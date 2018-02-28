Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB4F1F576
	for <e@80x24.org>; Wed, 28 Feb 2018 11:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeB1LCF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 06:02:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37792 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeB1LCE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 06:02:04 -0500
Received: by mail-pg0-f66.google.com with SMTP id y26so804815pgv.4
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E51UWp0dec6GCWMdHNIBYJqHUl5mUYBc3neu59l88Os=;
        b=Iwub9NdbzSuRnUFyNTA1k3kVMVpHYBA8TICiVX6zg0JQUsRs+WxAU8l1AqLrDrH12N
         /y1on+K5N0IfivLsfB85mbR85nlwZamgRR95GUu3L5DKB7pN5VPRN1HvsxhjXRvVs0Cq
         sVOzeZ8jAsfHhUzcNd2n1Vu2qHHyEmDZ3FuuAxZUA3sy5GEfmim/UK0zJvvUkKzhMIjx
         q1FhK+vIUNmPKqjRvuwgafYSl1OFiUDuBZ3/sUjYOfKHe4cUKfSuRWugx0CUjHTBME+5
         9+0EEzyKYTYSxS2hystHSvPfI2hCKdQnGs1xPybf2goc4QFOctO8HDFlNDXrFMNSQ/DT
         JbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E51UWp0dec6GCWMdHNIBYJqHUl5mUYBc3neu59l88Os=;
        b=mrBT4PWWT3Eo2Yv886kg8IvJSYBLO6eoDpZytYkGM9XdZiYdXjaqSyaJkDGbmgRijy
         Vs7OLNDrUoQw+UNrkzK4Q9s/b+ePqlk1lDLcDPntYiyV41f11EmSbMZzkPPUJkHUB8Sa
         IOM1iR7Vlt0ZXKZ0XlaFi+VQmLcBsmCVV4PIA4HP4TwVesp3I5GlPs90a2CkmINg6U4B
         OeiTQ+k46cWr86vrGziyoxsl13HudT5N/OO3UH6h4+mF8i60KDytX1W8CChBxzJh4tXO
         mL0Kym0fRX6Jy6IOJbq56WyqEFWQiy9yAHeqfQuviYVmOdSgkrkiO6grSAcosqPWXGk7
         wFDQ==
X-Gm-Message-State: APf1xPAPvuOe3jyroFDSm0J7kIfLFmpLQcKtTIQCmjGJsMiU8ynYE2Bw
        63QjyfMPvug+0NN1puPQ2VElCd6Aq/BEi7t9qwQbfN4c
X-Google-Smtp-Source: AH8x227YoBQMZtz0aNVdxyIbAfjQxQPotoSDDBQCy01ykMuzdIsuiKmF6iVLZR7Fl7h92z9FTOgByB7pl+QB9cQuQE8=
X-Received: by 10.98.182.26 with SMTP id j26mr15924936pff.223.1519815723190;
 Wed, 28 Feb 2018 03:02:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Wed, 28 Feb 2018 03:02:02 -0800 (PST)
In-Reply-To: <b19db05a8d8a98977788c04908134915eebc86a3.1519763396.git.martin.agren@gmail.com>
References: <cover.1519763396.git.martin.agren@gmail.com> <b19db05a8d8a98977788c04908134915eebc86a3.1519763396.git.martin.agren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Feb 2018 12:02:02 +0100
Message-ID: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com>
Subject: Re: [PATCH 3/5] merge-recursive: always roll back lock in `merge_recursive_generic()`
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 February 2018 at 22:30, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
> If we return early, we forget to roll back the lockfile. Do so.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  merge-recursive.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index cc5fa0a949..7345125691 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2198,8 +2198,10 @@ int merge_recursive_generic(struct merge_options *=
o,
>         hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>         clean =3D merge_recursive(o, head_commit, next_commit, ca,
>                         result);
> -       if (clean < 0)
> +       if (clean < 0) {
> +               rollback_lock_file(&lock);
>                 return clean;
> +       }
>
>         if (active_cache_changed &&
>             write_locked_index(&the_index, &lock, COMMIT_LOCK))

This is incomplete. If "!active_cache_changed", this function fails to
roll back the lock. I'll reroll this series.

This also highlights the point Peff made in [1] about how that
"active_cache_changed &&" can be confusing. I'll look into the added or
extended API he proposed, although perhaps not as part of the reroll.

Martin

[1] https://public-inbox.org/git/20180227214430.GC6899@sigill.intra.peff.ne=
t/
