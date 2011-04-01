From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #06; Thu, 31)
Date: Fri, 01 Apr 2011 10:01:42 -0700
Message-ID: <7vbp0phpmx.fsf@alter.siamese.dyndns.org>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
 <20110401152623.GA4553@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5hjT-0003ZS-4V
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 19:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758395Ab1DARBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 13:01:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757606Ab1DARBx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 13:01:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A4054E91;
	Fri,  1 Apr 2011 13:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QnK3VWI7q4TT6TWiQ1Wib9dEoy4=; b=IeFAei
	3qg1hYVeq/wu+kz0c/I8WHvwU9a+oVZuy70XFDVwnq/Qxocp+msAUJxYnQ3hCykm
	ZVsC8QIGplDwB+oXmvmyVAD783bTxbNRsHQxzEHDMwMPMLPfhC403t1qsbIc4heg
	LVt26Rqzfizmw5PRkrZqcon1PddqrislTYItE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HvKzmXqoPkms34xJk03ye2pCDhauixkz
	kNqJtAMtYei2fvadLpm5dNKoAGdLLT+weKeo1EZ3BF2u1YNXhi/l/nDEMZJmQdIa
	Q26P4eQzqWgmITsqQ3IMFdxJiiqDHN3jMMUlxkIvZJEEYgV9/1r5qK7EQFUXXJZg
	jinODUC/IAM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 235E54E90;
	Fri,  1 Apr 2011 13:03:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC9434E8F; Fri,  1 Apr 2011
 13:03:33 -0400 (EDT)
In-Reply-To: <20110401152623.GA4553@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Apr 2011 11:26:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBFE0446-5C81-11E0-9733-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170595>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 31, 2011 at 03:26:31PM -0700, Junio C Hamano wrote:
>
> (... parts that I do not disagree with are omitted ...)
>
>> * jc/add-u-migration (2011-03-22) 3 commits
>>  - add: make "add -u/-A" update full tree without pathspec (step 3)
>>  - add: make "add -u/-A" update full tree without pathspec (step 2)
>>   (merged to 'next' on 2011-03-31 at 962e058)
>>  + add: make "add -u/-A" update full tree without pathspec
>> 
>> The bottom one is a necessary first step toward the UI clean-up planned
>> for 1.8.0 which we discussed in length in the earlier part of the cycle;
>> the change is low impact, isolated, and has no risk of breaking the system
>> as a whole, but I would wait until the ":/" magic pathspec materializes,
>> as the advice message would have to become different, and the way to get
>> more stable semantics will become more direct.
>
> I have been meaning to look closer at this. Were you wanting to get the
> first stage of the transition into 1.7.5?

I was tempted to but I think it would be far more pleasant if the first
step were to add the warning against "add -u" without pathspec that is ran
from a subdirectory to advise "if you meant 'from here', say '.', if you
meant 'everywhere', say ':/'---for now we pretend you said '.' to match
the traditional behaviour."

It is adding even more confusion to add the "in this repository, 'add -u'
is tree-wide" configuration variable without giving people who need to
override that in unfamiliar repositories (read: scripts).

Right now, we don't have a good advice to force the tree-wide behaviour
other than "cd $(git rev-parse --show-cdup)/. && git add -u", which is
quite a mouthful.

We know how the magic "this pathspec is from the root" should work, and I
think we even saw "should look like this" patches, but haven't applied to
any branch so far yet.

>> * jk/progress-with-pager (2011-03-24) 4 commits
>>  - diff: turn on rename detection progress reporting
>>  - show: turn on rename detection progress reporting
>>  - progress: use pager's original_stderr if available
>>  - pager: save the original stderr when redirecting to pager
>> 
>> Will cook until 1.7.5 final.
>
> I'm not sure if this whole thing should be scrapped. There are potential
> problems with starting a pager that wants to grab the whole screen
> (i.e., not less). Maybe it would be enough to have a pager.noprogress
> option for people who use such a pager.

Perhaps.  With "Will cook until" I only meant "will not graduate until"; I
was not even making any prediction after 1.7.5 in the message.

Thanks.
