From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-picking commits with empty messages
Date: Wed, 01 Aug 2012 15:26:54 -0700
Message-ID: <7vehnqdz9t.fsf@alter.siamese.dyndns.org>
References: <20120801111658.GA21272@arachsys.com>
 <7vd33afqjh.fsf@alter.siamese.dyndns.org>
 <CAOBOgRZ9Ouan2htT9m3qBrUvae3nT1az3A61kiRMSJNyFv1MdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>
To: Angus Hammond <angusgh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:27:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwhNe-0002Hs-SL
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 00:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146Ab2HAW06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 18:26:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092Ab2HAW05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 18:26:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4340D9C23;
	Wed,  1 Aug 2012 18:26:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5YGk/+O/uxrUQg8AyBtVIzljOuk=; b=wdtn0O
	kqOhKQndhdcm5qmFDC0XoXin34ZDZlWv9wicYSeAJGTO+wf1cEgjCh5D+B1W6HEj
	Z+Y5iCEY5OrkZUv4yxqj4XjWSpyLp9gn9ITU3E0FjvdPaP2YopiqsHIPka/tB5Vy
	6UxqaPcpcgM9b0Iz1Bo0YRnL1O4Qm8+z687TE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Le2VDjv5yVL7kJfMKYoB2MwekDjNTygg
	VFexOVymCBKxn5cNQA5B5WDZI2tcGQf4yGj2NTUpv/YFokfsthfphfCsURSjICmB
	IsIdnfIj5RJwoWkzsEPQ7E3RQBxfJB9pMubglcnPL/ZJ7UW8Oq2vRnGeoEDWCq3/
	o+Z3fgLac/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EAC49C22;
	Wed,  1 Aug 2012 18:26:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83B249C21; Wed,  1 Aug 2012
 18:26:55 -0400 (EDT)
In-Reply-To: <CAOBOgRZ9Ouan2htT9m3qBrUvae3nT1az3A61kiRMSJNyFv1MdQ@mail.gmail.com> (Angus
 Hammond's message of "Wed, 1 Aug 2012 19:15:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 000CEFC6-DC28-11E1-8EC7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202735>

Angus Hammond <angusgh@gmail.com> writes:

>>    But from the bigger UI consistency point of view, it would be
>>    chaotic to change the default of some options for a single
>>    command depending on the nature of the operand, so I would
>>    recommend against going this route, and pick one view between
>>    "give the user a chance to fix" or "the user must have done so on
>>    purpose" and apply it consistently.
>>
>> My recommendation, backed by the above line of thought, is to add
>> support for the "--allow-empty-message" option to both "rebase [-i]"
>> and "cherry-pick", defaulting to false.
>
> Though I completely agree regarding having a consistent UI that
> doesn't change it's behaviour based on the operand, I'd argue that
> --allow-empty-message should default to true on cherry-pick for a
> couple or reasons.

I've read your entire response three times, and I am having a hard
time deciding if you are against my suggestion, or you misread my
suggestion.

> Firstly, in the case that git perpetuates an empty
> commit message that the user does not want, it is only damaging a
> repository in a way that it is already damaged, clearly this still
> isn't ideal, but it's certainly not as bad as damaging a repository
> that's pristine. Arguably it's the user's responsibility to ensure
> they don't TELL git to perpetuate their own bad commit.

I guess by "perpetuates" you meant there was already a commit with
an empty message, by "the user does not want" you consider such a
commit is a bad thing, and by "to ensure they don't TELL git", you
meant it is the user's responsibility not to give an extra option to
cause Git to replay a bad (= having an empty message) commit and
leave it in the resulting history.

It sounds to me that you are advocating for "git cherry-pick"
without any flags to stop and do not commit when given a commit with
an empty message.

And that is what I thought I was suggesting.  Give users a support
to say "git cherry-pick --allow-empty", but do not by default enable
it.  Perhaps I sounded as if I was suggesting the opposite?

> Secondly, I'd don't like the idea of a command that 99.9% of the time
> will run completely independently, but then every so often will become
> interactive.

As "cherry-pick" is expected to stop and give control back whenever
there is conflicts, this does not apply.  Any script that uses
cherry-pick to replay an existing commit has to be prepared to see
it stop and give control back to the script already, or the script
is unusable.  Note that the script would not be buggy even if the
only thing it does when it sees cherry-pick stop and give control to
it is to abort and give control back to the user.
