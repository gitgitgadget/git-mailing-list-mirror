From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 0/6] Expose submodule parallelism to the user
Date: Thu, 11 Feb 2016 12:23:32 -0800
Message-ID: <xmqqlh6rvvwb.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<xmqq4mdh36o8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYt9bw9MreiBhA_ZQNjS+1Xi71aNGwkjcfC1hwxkOoyYA@mail.gmail.com>
	<xmqqziv91qzi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTxm8-0008BG-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 21:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbcBKUXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 15:23:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750884AbcBKUXf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 15:23:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EBB441CBF;
	Thu, 11 Feb 2016 15:23:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QO6JUJknkBhGJienQorMPMwFpUo=; b=aW9g7d
	vm3xyGdDCV2hp9i1NnFobkW1L1HDQWnVoULWnrWwAJ3qmHxl6j5jOxrBk7JwZ0y7
	9tpYgu3QlEw0Alp6b187iNg+12syjE+3DyhDBLCWQuovpVOshI0t89Jd/HaMyCh/
	kHbdXI1OkEGGhSk6Zn1oTeno58ChCndxp5TgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=or+3Yag046CQ7+JWYUjLRwl5vXrprxW6
	Stg/iVEEN51ML+tMdVDVTgBZcIsrD66Qnsun79/XuD94ckoBQhAy0zrDA4EUEmVm
	RoJGrC90EQIG8tcX3zO4eNGfcgJsEPBPXMfTkZI6l5Bqx++/GSmMun6bRQM7hST8
	sovCFVRAOII=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 779D241CBE;
	Thu, 11 Feb 2016 15:23:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C20D941CBD;
	Thu, 11 Feb 2016 15:23:33 -0500 (EST)
In-Reply-To: <xmqqziv91qzi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Feb 2016 14:03:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 52BD57E2-D0FD-11E5-90A9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285995>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>>> * This seems to clash with 00/20] refs backend.
>>>>> Applied this on top of a merge between the current 'master' and
>>>>> 'sb/submodule-parallel-update' topic to untangle the dependency;
>>>>> otherwise there is no way for this topic to make progress X-<.
>>>>
>>>> Anything I can do to help with easing the clash?
>>>
>>> Perhaps try to rebase the series on top of such a merge (with this
>>> updated series) yourself and propose it as a basis for the next
>>> reroll for David?  In short, working together with topic(s) that
>>> touch the same area?
>>
>> Ok, I'll see if I can find a better commit to base this series on.
>
> That is not what I meant.  I meant rebasing the refs-backend series
> on top of a merge between this one and 'master', just like the way I
> queued the refs-backend series on top of a merge between the
> previous round of this series and 'master'.
>
> These two topics want to update the same piece of code, so another
> possibility is to rebase this series on top of a merge between
> refs-backend and 'master', but the current iteration of refs-backend
> already depends on the previous round of this topic.  Rebasing this
> on top of refs-backend would involve first adjusting parts of
> refs-backend that touched the same code as the previous round of
> submodule-parallel-update touched so that refs-backend would work
> directly on top of 'master', and then including the necessary change
> to the refs-backend code while rebuilding submodule-parallel-update
> on top of the result.  So I do not think you would go in that
> direction.

Having said that, at least for this round, I do not think there is
nothing to do at this point on your end; I just created a merge
between master and your updated sb/submodule-parallel-update and
then rebased the LMDB series on top of it.  It at least applies
cleanly and I expect it would test OK as well (the test is still
running).

On your plate is to adjust the submodule-init topic so that it knows
that the .update field no longer is a string (but is now an enum).

I did try doing that myself to see the extent of necessary changes
but did not finish it myself, because I suspect that
sb/submodule-parallel-update may need further updates.

Thanks.
