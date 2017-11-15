Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3D3201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758197AbdKOSoD (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 13:44:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:57029 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbdKOSoB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 13:44:01 -0500
Received: by mail-pg0-f65.google.com with SMTP id z184so13235441pgd.13
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qWVlvl9nzqPufsNOx5z3dIWddnHwyy4kJo7h8RuT1GA=;
        b=kMuvQihXY9zH6jwl1Qo/UMfu1HzfLecqwidcg5HonMaJUAENAC82b7qDsUpcgzvUpQ
         tj9dYi4uGhV2Ddm+yw0cyFpTiwSddfoPk/zBOGNU/L8wafZb4hkyKt1RnXIn9bhFb4h1
         M8cKZn6LSn7CBrMEe2W8Up+uMRTQzy3747rP15UPQeIGUr/8tWrL1I3rTc+FAUJcsX6J
         JzMNjh/mZy5l0vfwNwoHgZGzv9lUaR/QF2xCuCaDZUarMBqnFFiOEZiFfkPeweOZtr2q
         I7XmJdMg4tlovIWTRY9mQRUuJw+IsdsMPxR1c5L2p2so8ijjOmE/2zm72b+uZXA9Rp4B
         rJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qWVlvl9nzqPufsNOx5z3dIWddnHwyy4kJo7h8RuT1GA=;
        b=CRb32niXJpUuukJzhlVuvyt2d3n3LNELw7+/GKKg4W8RkUMcU7ErVctPJIFAG3Liyj
         StkW4/FXBNU2LoBNEO/MwqwvrHGWAc4a4xnaS7pVnbqcD3mUK0+B6TMZpjS9f3NQYRED
         6hUy/UZ0FawCGf0ZsdhxU29PDTF9NSZMs1D38G+25XIkelnSva7PHWaF8KNngU8o7/ST
         KmRB5MqFPbi6b67fEOjvZE5NGABaGr1Jqb8IPTf6x6XKlJouBThAim6bc6oUMB5AbD70
         rcHpqWRvk1LIK2kzMU+TKE0i5S8qEKqjjW7qrbxLJvnCnIlWsJxiXWnprGVqab/YRKDb
         /7pA==
X-Gm-Message-State: AJaThX5mjC3z07GVjuxFaYJT2XWCHmQ/C1qx9o5DYnjP9AWAMRVmi4dI
        r3Dk2gKnJqhIlBaLHEIUE0G7sFLSSKy29hld3kSajg==
X-Google-Smtp-Source: AGs4zMbkg3c6VIPPRssFJBH/rPlmTB/X9cLlPmTrfutIfdfE9rkP2bm2thBm3v8vyOrlShnG0CLmi/xqeCIJE9mXR5w=
X-Received: by 10.98.219.198 with SMTP id f189mr3819324pfg.44.1510771441192;
 Wed, 15 Nov 2017 10:44:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.167.42 with HTTP; Wed, 15 Nov 2017 10:44:00 -0800 (PST)
In-Reply-To: <20171115104125.1686-1-phillip.wood@talktalk.net>
References: <20171115104125.1686-1-phillip.wood@talktalk.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 15 Nov 2017 19:44:00 +0100
Message-ID: <CAN0heSrbszhhFauYHNs70-WWk+bju0sSVzjavRcwg09CzCXSjA@mail.gmail.com>
Subject: Re: [PATCH] sequencer: reschedule pick if index can't be locked
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 November 2017 at 11:41, Phillip Wood <phillip.wood@talktalk.net> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Return an error instead of dying if the index cannot be locked in
> do_recursive_merge() as if the commit cannot be picked it needs to be
> rescheduled when performing an interactive rebase. If the pick is not
> rescheduled and the user runs 'git rebase --continue' rather than 'git
> rebase --abort' then the commit gets silently dropped.

Makes sense. (Your analysis, not the current behavior. ;-) )

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 6d027b06c8d8dc69b14d05752637a65aa121ab24..8c10442b84068d3fb7ec809ef1faa0203cb83e60 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -438,7 +438,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>         char **xopt;
>         static struct lock_file index_lock;
>
> -       hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
> +       if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR))
> +               return -1;
>
>         read_cache();

From the commit message, I would have expected the flags to be zero. This patch
does not only turn off the die-ing, it also tells the lockfile-API to print an
error message before returning. I don't have an opinion on whether that extra
verboseness is good or bad, but if it's wanted, I think the commit message
should mention this change.

Also, don't you want to check "< 0" rather than "!= 0"? If all goes
well, the return value will be a file descriptor. I think that it will
always be non-zero, so I think you'll always return -1 here.

Martin
