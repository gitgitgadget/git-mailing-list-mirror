From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] worktree.c: add is_worktree_locked()
Date: Sun, 22 May 2016 22:04:29 -0400
Message-ID: <CAPig+cTVbOy5S57W2x0C6ngmECJz8mjDVtA+NPde5-Ci2rOt6g@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
	<20160510141729.23063-3-pclouds@gmail.com>
	<CAPig+cQR40u4nMEP1wz74ubA=wW5m+KiCZnpZwuWAyYvXsPHrw@mail.gmail.com>
	<CACsJy8ChM99n6skQCv-GmFiod19mnwwH4j-6R+cfZSiVFAxjgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 04:04:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4fER-0005fc-QH
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 04:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbcEWCEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 22:04:31 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33147 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbcEWCEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 22:04:30 -0400
Received: by mail-io0-f174.google.com with SMTP id t40so92620832ioi.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=qhuKcUx4Vr6cV/VDbP9XCHemkeZKgpQMhYo8W+58SaY=;
        b=nfcR706wCn+pKTd8XurvUf7m6zSALEIEczcEK0MFynJPMk0bnZRevFBFUxqDr+MUDZ
         zKoyl7o0tdarVtMtE83hICTics7iRhAx5FvCWZSTpCK5gcnmSofIlAEDho70SNzE4SV1
         9DhfgTl3dJ4GKqaDjM2aP9trz5Q6ySvP6LMRNHbiQFBETJqXhFqyj0y0Z4AO8hiV9WvB
         t+GQYOOtMts7KtDooGVswkQVJX2GqQrgCvs8dz2R/afuP1F5FqaB4928TQtATFcCo3im
         bGrcCa6fhOqgbjJ7MYBqa1KEFM3b/FntNKQahP0aGyEoBKnxKt9+kyzVusERFtWBeZK3
         Z5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qhuKcUx4Vr6cV/VDbP9XCHemkeZKgpQMhYo8W+58SaY=;
        b=eVSVzYTJEAuMcXne9KuKbYo4btGrSTlBEB2wkqHZPS4yywuW/86VAf2xjqp7ouvPmt
         0utQrM80nQFcOiGZ3j7+65NtpHzcnhEYYPjrdVPkKhsGRmnzbFLrCqpJi6/pi0MB/gYx
         0uKzyxAb2RU4DVqJluJTQbf6gaMrUBNorZgHezR15VQYpst968AjKj+o+lZu4PTHo5uW
         EwP8uqKCvR+vhgYeVk0lqaexi6jDiJpUYWYSwlZU0D0ubFWqwm71T3f7MT0Cl1X6V6JV
         MK92LGHzgiMm0V00lMvpBKS/qnz0Er+sQ4Ta/EVH9uJrUBB/RiAjmNnWL1YzgsO/+Xe7
         SrsQ==
X-Gm-Message-State: AOPr4FVIufuG7xPLfm8m2LtGFGV+oeiBMQoBhqmHk+1i0N9zbVk4yxRy00xdKZzh4FihVyoCdWVR5IcuN4L0iA==
X-Received: by 10.36.55.13 with SMTP id r13mr11023933itr.73.1463969069824;
 Sun, 22 May 2016 19:04:29 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 19:04:29 -0700 (PDT)
In-Reply-To: <CACsJy8ChM99n6skQCv-GmFiod19mnwwH4j-6R+cfZSiVFAxjgA@mail.gmail.com>
X-Google-Sender-Auth: gQXPiD_eibOqJ12KRYksJB5uVmc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295302>

On Sun, May 22, 2016 at 5:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, May 13, 2016 at 11:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Actually, I recall that when I suggested the idea of 'struct worktree'
>> and get_worktrees() to Mike that it would be natural for the structure
>> to have a 'locked' (or 'locked_reason') field, in which case the
>> reason could be stored there instead of in this static strbuf. In
>> fact, my idea at the time was that get_worktrees() would populate that
>> field automatically, rather than having to do so via a separate
>> on-demand function call as in this patch.
>
> I'm keeping this as a separate function for now. I don't like
> get_worktrees() doing extra work unless it has to. We soon will see
> the complete picture of "git worktree" then we can merge it back to
> get_worktrees() if it turns out checking "locked" is the common
> operation. is_worktree_locked() then may become a thin wrapper to
> access this "locked" field.

is_worktree_locked() could also just go away since the 'struct
worktree::locked' field would be non-NULL for locked, else NULL.

>>> +extern const char *is_worktree_locked(const struct worktree *wt);
>>
>> I was wondering if builtin/worktree.c:prune_worktree() should be
>> updated to invoke this new function instead of consulting
>> "worktrees/<id>/locked" manually, but I see that the entire "prune
>> worktrees" functionality in builting/worktree.c first needs to be
>> updated to the get_worktrees() API for that to happen.
>
> I thought about updating prune too. But it is in a bit special
> situation where it may need to consider invalid (or partly invalid)
> worktrees as well. So far worktree api is about valid worktrees only
> if I'm not mistaken and we probably should keep it that way, otherwise
> all callers may need to check "is this worktree valid" all over the
> place.

Yes and no. In addition to suggesting to Mike that 'struct worktree'
should have a 'locked' field, I also suggested a 'prunable' field
which would indicate whether a worktree was a candidate for pruning.
In fact, the field would be a 'const char *' where non-NULL would mean
prunable and give a reason (one of the reasons already determined by
builtin/worktree.c:prune_worktree()). Alternately it could be an enum.
Like the 'locked' (or 'lock_reason') field, 'prunable' (or
'prune_reason') is likely the sort of information which should be
presented by "git worktree list". And, as with 'locked', I think it
makes sense for the 'prunable' field to be populated automatically by
get_worktrees().

As for your concern about clients having to take care with valid vs.
invalid worktrees, get_worktrees() could be updated to return all
worktrees or only valid worktrees (for some definition of "valid").
"git worktree list" is an example of a client which would want to see
all worktrees assuming its updated to show 'locked' and 'prunable'
status.
