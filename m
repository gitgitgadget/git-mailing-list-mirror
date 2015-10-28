From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1 2/2] git-p4: work with a detached head
Date: Wed, 28 Oct 2015 10:44:12 -0700
Message-ID: <xmqqfv0ulwgj.fsf@gitster.mtv.corp.google.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
	<1441461738-25066-3-git-send-email-luke@diamand.org>
	<xmqqfv2n5khe.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-_zhxf_daVxNB-hxFfbakMbJp9rk0vP+k46ErrJ6Qxiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:44:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUlo-0007AM-9s
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbbJ1RoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:44:16 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752375AbbJ1RoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:44:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B9B924FC6;
	Wed, 28 Oct 2015 13:44:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q4r4P9xH4o/gSg/07B4QnwYnPVA=; b=pmu52W
	L0wMCwGb9BS+pMDp1riSRX6loUgumf6EPHEhBUagkTypq4vWVyUNjAw9/Bj33xSe
	YYclCq/NSDHPyrI3StDjAeLDkTiruD3Pdip4RNGxSegXO0gn/Lyyaf6Z4QKY8gAk
	O0dFiAYAmWT/DXU8hixDHtnqlDT+Lh7b6b7Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eIB3yGy757PJm/7tSMeAaz3tZOyQARmz
	zg3NbtEyuXXcKlwT5FwXJLTt1+EspQc/I/xeotZ+6ChxVqC+Mi4FbM6CrZ3Wysxk
	qNY1fsE23+FcgmJ9jbik085yrlvHNqoJhmO0K/G43egqwouuMJeWGgbgCYrUnRry
	ww2aeogmiDw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1975424FC5;
	Wed, 28 Oct 2015 13:44:14 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96B2124FC4;
	Wed, 28 Oct 2015 13:44:13 -0400 (EDT)
In-Reply-To: <CAE5ih7-_zhxf_daVxNB-hxFfbakMbJp9rk0vP+k46ErrJ6Qxiw@mail.gmail.com>
	(Luke Diamand's message of "Thu, 10 Sep 2015 08:29:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80A3F766-7D9B-11E5-ABAE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280380>

Luke Diamand <luke@diamand.org> writes:

> On 9 September 2015 at 22:52, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>> ...
>>     def currentGitBranch():
>>         return read_pipe("git name-rev HEAD").split(" ")[1].strip()
>>
>> Yuck.  I know it is not entirely the fault of this patch, but
>> shouldn't it be reading from
>>
>>     $ git symbolic-ref HEAD
>>
>> and catch the error "fatal: ref HEAD is not a symbolic ref" and use
>> it as a signal to tell that the HEAD is detached?
>
> That sounds much nicer. I'll redo the patch accordingly.

No need to rush, but should I expect a reroll of this sometime, or
have things around this topic changed to make this topic no longer
necessary?  I am only asking so that I can decide to either keep or
drop ld/p4-detached-head topic that is listed in the [Stalled]
section for quite some time [*1*].

Thanks.


[Footnote]

*1* Not that my dropping a topic from 'pu' means very much; a
    dropped topic can still be submitted and requeued after all.
