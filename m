From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: give better advice when cherry-pick is in progress
Date: Mon, 17 Jun 2013 13:15:58 -0700
Message-ID: <7vli68biip.fsf@alter.siamese.dyndns.org>
References: <1371443306-3073-1-git-send-email-ralf.thielow@gmail.com>
	<7vppvkczqu.fsf@alter.siamese.dyndns.org>
	<CAN0XMOJhUA7Uut-jpnpSRW_E2xHARCyP_8FUmebNjBkm59v0JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Lucien.Kong@ensimag.imag.fr
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UofqR-0003Qr-4A
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab3FQUQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:16:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587Ab3FQUQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:16:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A242843A;
	Mon, 17 Jun 2013 20:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xHZcKnhTl3RkCmLBFo7uBx1WhGE=; b=JiW+kj
	GnrLFEA9y5lr+7+3YIBSKo98AAplp+QGdzMevNBRhzjsHhvkmn5n38GrZZDPipS/
	7eDiSmv1qH/Ey2Zu6JaoHTwiSCu9DTkDdFr0YFfTNz9AnyxD9WgOPEPzDjwFUJJ+
	cldb4sMGOE8D0VaLj8cMzikyXv3PKD89bJrRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cp18Po43Ndn83kpNRRUXzk9o547SSKll
	On0xm32aZNH4wThdLWAHHgyvi1+vL3jnvnBSMRD+qp32eQBEC53Ai84pax7DCymE
	zMEJO3E26kVJoiUqX+aJG4cSy+PqXStZZp6YWzha7fpQUnuwLRTvtrN+12hE5BU8
	dFisbDhzdkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9955E28439;
	Mon, 17 Jun 2013 20:16:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD8AF28435;
	Mon, 17 Jun 2013 20:15:59 +0000 (UTC)
In-Reply-To: <CAN0XMOJhUA7Uut-jpnpSRW_E2xHARCyP_8FUmebNjBkm59v0JA@mail.gmail.com>
	(Ralf Thielow's message of "Mon, 17 Jun 2013 21:29:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9D6D738-D78A-11E2-9A11-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228111>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> 2013/6/17 Junio C Hamano <gitster@pobox.com>:
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>
>>> When cherry-pick is in progress, 'git status' gives the advice to
>>> run "git commit" to finish the cherry-pick. However, this won't continue
>>> the sequencer.
>>> "git status" should give the advice of running "git cherry-pick --continue"
>>> or "git cherry-pick --abort".
>>
>> Is the above _always_ the case, or does the updated advice message
>> only apply when you are cherry-picking a range of commits with "git
>> cherry-pick A..B"?  In other words, when "git cherry-pick $it" (a
>> single commit) stops, waiting for your help to resolve it, would
>> "git cherry-pick --continue" conclude it?
>>
>
> Yes, both "--continue" and "--abort" works with a single commit.

Perhaps that is a good thing to explain, in addition to "won't
continue the sequencer", as single-pick case does not have much to
do with it ;-)

Thanks, will queue.

>> If that works then this definitely is a good change (the user only
>> needs to know "cherry-pick --continue").
>>
>>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>>> ---
>>>  t/t7512-status-help.sh | 6 ++++--
>>>  wt-status.c            | 6 ++++--
>>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
>>> index bf08d4e..4f09bec 100755
>>> --- a/t/t7512-status-help.sh
>>> +++ b/t/t7512-status-help.sh
>>> @@ -632,7 +632,8 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
>>>       cat >expected <<-\EOF &&
>>>       # On branch cherry_branch
>>>       # You are currently cherry-picking.
>>> -     #   (fix conflicts and run "git commit")
>>> +     #   (fix conflicts and run "git cherry-pick --continue")
>>> +     #   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
>>>       #
>>>       # Unmerged paths:
>>>       #   (use "git add <file>..." to mark resolution)
>>> @@ -655,7 +656,8 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
>>>       cat >expected <<-\EOF &&
>>>       # On branch cherry_branch
>>>       # You are currently cherry-picking.
>>> -     #   (all conflicts fixed: run "git commit")
>>> +     #   (all conflicts fixed: run "git cherry-pick --continue")
>>> +     #   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
>>>       #
>>>       # Changes to be committed:
>>>       #
>>> diff --git a/wt-status.c b/wt-status.c
>>> index bf84a86..438a40d 100644
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -955,10 +955,12 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>>>       if (advice_status_hints) {
>>>               if (has_unmerged(s))
>>>                       status_printf_ln(s, color,
>>> -                             _("  (fix conflicts and run \"git commit\")"));
>>> +                             _("  (fix conflicts and run \"git cherry-pick --continue\")"));
>>>               else
>>>                       status_printf_ln(s, color,
>>> -                             _("  (all conflicts fixed: run \"git commit\")"));
>>> +                             _("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
>>> +             status_printf_ln(s, color,
>>> +                     _("  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"));
>>>       }
>>>       wt_status_print_trailer(s);
>>>  }
