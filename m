From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Wed, 02 Apr 2014 12:41:46 -0700
Message-ID: <xmqqlhvntt6t.fsf@gitster.dls.corp.google.com>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
	<xmqqppl0yaf9.fsf@gitster.dls.corp.google.com>
	<87ha6cian0.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeVH-000348-6X
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbaDBTlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 15:41:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932626AbaDBTlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 15:41:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6DDC78003;
	Wed,  2 Apr 2014 15:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IOuRMZmnji2OX6PODp6ioW3uyz4=; b=azS3Ys
	R49NZNO1q48MgfOl6OocQr8TRkE31qrTd26dRJ4SFCNAEHkuR4xS52wDd3DtbElr
	MroTmigLMFT4NvZHJtPw/jBrmSPtW1A6b8RMeQFR7K7jDa5JsHrKbnwXNUHYRF37
	JECy5CUeJu+j2xqTvj2SyZNub6D6EHmX4AHw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iu6luj/+HFZue9K7FlmC3tJYu5lvwMFx
	hChU5n/jgWO2Mu5LcuTAdmUtBxCwyw1mlCHV4SeRRIXCUqBv6wiKfdQPgmQvmsBg
	xsr8mOxaNsYVjeo1jFOKilkAoSIpC0IGzeOwlaZ8R4uNk/sf+9rMRH0r3ecGpx7e
	vhujszPVBbs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EF6C77FFE;
	Wed,  2 Apr 2014 15:41:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A098A77FFB;
	Wed,  2 Apr 2014 15:41:47 -0400 (EDT)
In-Reply-To: <87ha6cian0.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 02 Apr 2014 07:05:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D410807A-BA9E-11E3-89A1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245698>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I haven't reverted the merge of that "submodule update" topic yet; I
>>> should do that soonish.
>>> ...
>>
>> Sigh...  This is giving me a lot of headache.
>>
>> As 23d25e48 (submodule: explicit local branch creation in
>> module_clone, 2014-01-26) has been in 'master' since fairly early
>> during this cycle, a lot of topics that are not planned to be on the
>> 'maint' branch has forked from the tip of 'master' and are now
>> contaminated by that commit.
>>
>> I think I have a preparatory patch to correctly revert 00d4ff1a
>> (Merge branch 'wt/doc-submodule-name-path-confusion-2', 2014-03-31)
>> and 06c27689 (Merge branch 'wk/submodule-on-branch', 2014-02-27),
>> and also a part of 384364b (Start preparing for Git 2.0,
>> 2014-03-07), but I am not sure what to do with them ;-<))
>
> Why not just revert on master?  When merging with the topic branches,
> the revert should then override the contamination.

That was actually not the cumbersome part.  I wanted to be very sure
that the revert was correctly done, and one way I know to get an
independent verification is to rebuild the master branch starting
all the way back from the point before the problematic topic was
merged to it.  Some of the topics merged to 'master' after that
point, however, were forked after that original problematic merge
was made, so they needed to be rebuilt before I could do so.

It is worth noting that this verification can also be done in a
different way.  You can start at 06c27689^1, and "cherry-pick -m1"
(or "cherry-pick" for non-merge commits that update the release
notes) the commits in "git rev-list --reverse --first-parent
06c27689..master" on top of it.  That should result in the same tree
object as a correct revert on top of 'master' would have.

Because "cherry-pick -m1" loses the other parents, the resulting
history does not reflect the reality, but I am not doing this in
order to replace the history of the 'master' with the result but
only to make sure that the final tree matches what would have
happened if the topic were not merged to 'master', so it is
sufficient for the purpose of this exercise.

Hope it clarifies.
