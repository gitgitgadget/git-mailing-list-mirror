Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C0B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIDWex (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:34:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34765 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDWew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:34:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so4009591eds.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zM2LVoypbVioC68T96bkoBYhhrOrY4+WERwcEau2H8A=;
        b=gzHMXUDgMwGoBbMZhH6BoB5UJhm2VyXO8JB33knq0es+olLqjHP5DcBkhNEUcKNKfu
         Q/x3WoFSoKnraCKZcIBrA1WMOJRZ2E36ddKusDG4OOt4Kda2Jxnn7NIO/BttHqsIynY5
         0nYcz62JA52TRjmDoY/l+eJQzOLYNNkPmjJudcSzHBnTQ11DaIe39Cn2pR+4s+6DpVQt
         3/kAJdUAi6K3dbzGtZ5FFv/ygK3g7fJ1iAGRhQsD7tFxxSw1ewSLvmk23TKUGnuongP1
         4rDdGqMpWbXqXKwkRQF1sO+ZFxzA+NT8OxKmXI4MeY0+M372UitJm2UGjTRTH86U3lGt
         x38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zM2LVoypbVioC68T96bkoBYhhrOrY4+WERwcEau2H8A=;
        b=OzVda5sJSO10aiKbMX9g7BUwEm8sRsDkuzBw7eWHbx+6vNYYQaIrP3HUMgK1UQIwYx
         bDt4ZQTH8ksxMyPROVPKGIDyEeIK5aRhe97pUHoKMo8C4BN/I/YpOFtjKBEuaSl85X6U
         PgV4TSzjurJkuBYd21SCqk9gsFzKPXo9FXg82y3Est0U2WosdZz1/WpiYZ1jw/mESwe3
         Jyxx7mOMkJcsPgt+PVuo+5414cZOkcBtK8gWdB257hrkwuruNHXHAGJmFOZiq98rjP4F
         P49y+LJL4fjislff9U7Gh5M6mAQepw3d4SlKuTsu6Z82nTa/ZSwENmsVyh/YLclOjdc8
         Bmig==
X-Gm-Message-State: APzg51BLRdg+/H2D+p7ZUnAeAzw8OU6mgjTa/Sh77RrZ8C/8LoeaGcoV
        9Fx+BfQqcxoZ2rdk4p6RefO30K7/Rry1+ZJd21ZJGw==
X-Google-Smtp-Source: ANB0Vdb9x/7guz1xrXDzVWRUrqigVSQrGkzR5r89MmiPcPC84Av+dKrGF4CefRCTjXbgeoZ5g7u7oKKSzwHU4nPU3iA=
X-Received: by 2002:a50:f5ae:: with SMTP id u43-v6mr38006427edm.75.1536084517031;
 Tue, 04 Sep 2018 11:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180904135258.31300-1-phillip.wood@talktalk.net>
In-Reply-To: <20180904135258.31300-1-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 11:08:25 -0700
Message-ID: <CAGZ79kaBBzG6-QKruCeybN_do735h9tAXHZ7Rjx_YXeh85ax6A@mail.gmail.com>
Subject: Re: [PATCH] diff: fix --color-moved-ws=allow-indentation-change
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 6:53 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If there is more than one potential moved block and the longest block
> is not the first element of the array of potential blocks then the
> block is cut short. With --color-moved=blocks this can leave moved
> lines unpainted if the shortened block does not meet the block length
> requirement. With --color-moved=zebra then in addition to the
> unpainted lines the moved color can change in the middle of a single
> block.
>
> Fix this by freeing the whitespace delta of the match we're discarding
> rather than the one we're keeping.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> While I was working on this I spotted a couple of other issues I don't
> have time to fix myself at the moment, so I thought I mention them in
> case someone else wants to pick them up
>
> 1) I think there is a potential memory leak at the end of
>    mark_color_as_moved(). If pmb_nr > 0 then the whitespace deltas
>    need freeing before freeing pmb itself.
>
> 2) The documentation could be improved to explain that
>    allow-indentation-change does not work with indentation that
>    contains a mix of tabs and spaces and the motivation for that
>    (python?) [I've got some code to add an option that supports that
>    which I'll post when I've written some tests after 2.19 is
>    released]
>
>  diff.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 145cfbae5..4e8f725bb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -968,8 +968,13 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
>                         /* Carry the white space delta forward */
>                         pmb[i]->next_line->wsd = pmb[i]->wsd;
>                         pmb[i] = pmb[i]->next_line;
> -               } else
> +               } else {
> +                       if (pmb[i]->wsd) {
> +                               free(pmb[i]->wsd->string);
> +                               FREE_AND_NULL(pmb[i]->wsd);
> +                       }
>                         pmb[i] = NULL;
> +               }

I agree on this hunk, as it will fix the mem leak in the case of
allow-indentation-change, wondering if we need the same in
pmb_advance_or_null as well (and anywhere where there is a
'pmb[i] = NULL' assignment outside the swapping below.).


>         }
>  }
>
> @@ -990,10 +995,6 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
>
>                 if (lp < pmb_nr && rp > -1 && lp < rp) {
>                         pmb[lp] = pmb[rp];
> -                       if (pmb[rp]->wsd) {
> -                               free(pmb[rp]->wsd->string);
> -                               FREE_AND_NULL(pmb[rp]->wsd);
> -                       }

Eh, this makes sense, though I had to think about it for a
while as I was confused. By the first line in the condition we
also keep around the ->wsd pointer as is.

Thanks!
Stefan
