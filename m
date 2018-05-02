Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B615C21847
	for <e@80x24.org>; Wed,  2 May 2018 05:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeEBFuO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 01:50:14 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37852 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeEBFuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 01:50:13 -0400
Received: by mail-wm0-f43.google.com with SMTP id l1so22087510wmb.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7o+FNnF7DOebr6Sb2ZhuRj61dGoUd177Sfi5weZK0lk=;
        b=MKHHwm7+o9zTjspu6pf4LVzGkQExbAoE/5LiUeoBvuf2MssU9yOwNarcGZMka5pEGA
         /z1x1yx39mpBjbZpZvl6MDgPIVTPr8R8kioNJZzkOqAAHNMomnnIodQ/D/6cp90UwNhZ
         OYupSU9WjiF+6ZKvhD8GZiejdyjunBsGGNacwFKCGtFDeIRvLxs6JN5/BF1fR9GOf4WM
         Vl290B4ANI8jVFmkHU4fnL4/Ohd2ANa+1u5RpLrCLfPQdiOCuFvmq/z0ahTMsd0MI+Sk
         hcUM2ZN4GHtiu/+pyHkpdzxR9raqs4ZZ8bOb/W0j2oWe2h5Asi4W1tw/qpuqEfy7YEze
         JMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7o+FNnF7DOebr6Sb2ZhuRj61dGoUd177Sfi5weZK0lk=;
        b=LA9BqCiltQ0CdGY9wXTpMtRg/Vl08md/LGV/zgpBxbnWCr0Uvv7jwmjOW7aEHhhTzW
         /1jYuC8EQocH0sgoTre3qTapytLg2IzpiuoQ0Ky0CCOiRwlqHoJ9DMWPFmof3/WnSNbF
         yF9GFyyU0BrrqvPOhK2MgE7X7N91dswFo7H2Sny+ATEFJkkpuqkR4CCT9oo+ucGS0O9b
         xz11RQwJr2NaQhUoJVGeg2oQsXgpLFX9p38/d38JtGoxRx65PHYa22IIuW4G5CCBURO3
         1iQl6QF6rn4cj/uL9VBbn3Esvrlv9o+8I82M0mJY0cOmPEO+YBf3O0PdDfxPm9YSMJ57
         4PxA==
X-Gm-Message-State: ALQs6tC9nhHM4r9vlohmBWHiZGxoPV4LpDpcT+zsY0nR6AuAK397SjrU
        mNL5UtX9lxx+fc6Us39lqtU=
X-Google-Smtp-Source: AB8JxZoBvK5Gj2NsKVGBIrHYWLk7mnJYFd09gDl9+T3HbuCidP5XZ8FAXEymUj1TgMJuDfgmJp2Jaw==
X-Received: by 10.28.218.19 with SMTP id r19mr12205658wmg.2.1525240211646;
        Tue, 01 May 2018 22:50:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w40-v6sm18702000wrc.69.2018.05.01.22.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 22:50:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: fix --short and --porcelain options
References: <20180426092524.25264-1-sxlijin@gmail.com>
        <20180418030655.19378-1-sxlijin@gmail.com>
        <20180426092524.25264-2-sxlijin@gmail.com>
Date:   Wed, 02 May 2018 14:50:08 +0900
In-Reply-To: <20180426092524.25264-2-sxlijin@gmail.com> (Samuel Lijin's
        message of "Thu, 26 Apr 2018 05:25:23 -0400")
Message-ID: <xmqq36zawqr3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> Mark the commitable flag in the wt_status object in the call to
> `wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
> and simplify the logic in the latter function to take advantage of the
> logic shifted to the former. This means that callers do not need to use
> `wt_longstatus_print_updated()` to collect the `commitable` flag;
> calling `wt_status_collect()` is sufficient.
>
> As a result, invoking `git commit` with `--short` or `--porcelain`
> (which imply `--dry-run`, but previously returned an inconsistent error
> code inconsistent with dry run behavior) correctly returns status code
> zero when there is something to commit. This fixes two bugs documented
> in the test suite.


Hmm, I couldn't quite get what the above two paragraphs were trying
to say, but I think I figured out by looking at wt_status.c before
applying this patch, so let me see if I correctly understand what
this patch is about by thinking a bit aloud.

There are only two assignments to s->commitable in wt-status.c; one
happens in wt_longstatus_print_updated(), when the function notices
there is even one record to be shown (i.e. there is an "updated"
path) and the other in show_merge_in_progress() which is called by
wt_longstatus_prpint_state().  The latter codepath happens when we
are in a merge and there is no remaining conflicted paths (the code
allows the contents to be committed to be identical to HEAD).  Both
are called from wt_longstatus_print(), which in turn is called by
wt_status_print().

The implication of the above observation is that we do not set
commitable bit (by the way, shouldn't we spell it with two 'T's?)
if we are not doing the long format status.  The title hints at it
but "fix" is too vague.  It would be easier to understand if it
began like this (i.e. state problem clearly first, before outlining
the solution):

	[PATCH 1/2] commit: fix exit status under --short/--porcelain options

	In wt-status.c, s->commitable bit is set only in the
	codepaths reachable from wt_status_print() when output
	format is STATUS_FORMAT_LONG as a side effect of printing
	bits of status.  Consequently, when running with --short and
	--porcelain options, the bit is not set to reflect if there
	is anything to be committed, and "git commit --short" or
	"--porcelain" (both of which imply "--dry-run") failed to
	signal if there is anything to commit with its exit status.

	Instead, update s->commitable bit in wt_status_collect(),
	regardless of the output format. ...

Is that what is going on here?  Yours made it sound as if moving the
code to _collect() was done for the sake of moving code around and
simplifying the logic, and bugfix fell out of the move merely as a
side effect, which probably was the source of my confusion.

> +static void wt_status_mark_commitable(struct wt_status *s) {
> +	int i;
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d = (s->change.items[i]).util;
> +
> +		if (d->index_status && d->index_status != DIFF_STATUS_UNMERGED) {
> +			s->commitable = 1;
> +			return;
> +		}
> +	}
> +}

I am not sure if this is sufficient.  From a cursory look of the
existing code (and vague recollection in my ageing brain ;-), I
think we say it is committable if

 (1) when not merging, there is something to show in the "to be
     committed" section (i.e. there must be something changed since
     HEAD in the index).

 (2) when merging, no conflicting paths remain (i.e. change.nr being
     zero is fine).

So it is unclear to me how you are dealing with (2) under "--short"
option, which does not call show_merge_in_progress() to catch that
case.
