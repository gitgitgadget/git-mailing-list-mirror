Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6AFB1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 22:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbcHaWUi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 18:20:38 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38378 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbcHaWUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 18:20:38 -0400
Received: by mail-it0-f41.google.com with SMTP id c198so11892645ith.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oPVaMRiA+GdryR+STElvyJ9tw19uKwgxVunCZOYsHFo=;
        b=EqmZ0dfvIslsvNgzhjSzQC+82JsQh8R4f5uvEDVEbZGF/TkVLeo0NRcMOO6Bq6ya5Z
         hVl0hrb2GFSlIx6j1GBEPkAO3wN1yfcR9hLE2zxMecQsrKBPc1EdpPcBr7Ebc1XTy4bT
         42jjvubIAJXzUDAzUnkA4Vcwk6tV1sGAaKtWDKdnzimI7ZQcLIfiZ7pbOfSw4XFblTuX
         eDWTAySzBrRDomkek0B+wvUeku3WKMHwrD03VVjTO5P1HHvsQxoAMT12gA+jEYj7noDm
         S6gyzBBXFbP6pkDM+sOxWnYYDp8VJR/oanLKmxjVc8qx4snv0r0wTsCwdgrzBZlx3S9S
         vejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oPVaMRiA+GdryR+STElvyJ9tw19uKwgxVunCZOYsHFo=;
        b=hjmSVycL3HCNsCD535zLnlFS9aloqUTJEqHbrROEklzbwD19EGee6Lad2Gs8AOiebi
         eE+PRl9B+/0aVqclCr7CZ88WP4uUKIz0xp2kyI2DzLWLZ/mrUcPBP8aVg9Yr/Mi4K6SY
         a/LQz3JAMEy9D4y8a0aRLK4sKr9znZYfWHWPfHsjJZZY6k62sKDIV7a9oBy8bP1shepi
         YuletbpvYOIC3aOZYtiXwF65g71cm4Ob5xSzoEnoIyt9TbxNOOXFUVnntPrQyDdz0tc2
         IY9Kh/aLwA5YZK8SB56BNvTPC1CNwP1zzF5ibCRGSY2fbA4YWp8JpoPFzSZSlgMg+b2R
         /vpw==
X-Gm-Message-State: AE9vXwPK7VR4G5TXwpp67XQG7YBRltRWUBtjv/+BgJt+XL9SnvcwObkUggl0FZojVT1LGCzf2QaT552JDHLexH3y
X-Received: by 10.36.107.82 with SMTP id v79mr33891059itc.52.1472682036865;
 Wed, 31 Aug 2016 15:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 15:20:36 -0700 (PDT)
In-Reply-To: <20160827184547.4365-11-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <20160827184547.4365-11-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 15:20:36 -0700
Message-ID: <CAGZ79kbdoF-1=ZBZG8y3sEz6LVaNP4Ou+KVk+=M7y9PSzQ1J0Q@mail.gmail.com>
Subject: Re: [PATCH v13 10/14] apply: change error_routine when silent
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To avoid printing anything when applying with
> `state->apply_verbosity == verbosity_silent`, let's save the
> existing warn and error routines before applying, and let's
> replace them with a routine that does nothing.
>
> Then after applying, let's restore the saved routines.
>
> Helped-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c | 21 ++++++++++++++++++++-
>  apply.h |  8 ++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index ddbb0a2..bf81b70 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -112,6 +112,11 @@ void clear_apply_state(struct apply_state *state)
>         /* &state->fn_table is cleared at the end of apply_patch() */
>  }
>
> +static void mute_routine(const char *bla, va_list params)

Instead of 'bla' you could go with 'format' as the man page for
[f]printf puts it.
Or you could leave it empty, i.e.

    static void mute_routine(const char *, va_list)
    ...

I personally do not mind bla, as I know that the first parameter is
supposed to be the format, but let's not add unneeded information.
(Side question: Is there a culture that doesn't recognize 'bla' as a
fill word?)



> +{
> +       /* do nothing */
> +}
> +
>  int check_apply_state(struct apply_state *state, int force_apply)
>  {
>         int is_not_gitdir = !startup_info->have_repository;
> @@ -144,6 +149,13 @@ int check_apply_state(struct apply_state *state, int force_apply)
>         if (!state->lock_file)
>                 return error("BUG: state->lock_file should not be NULL");
>
> +       if (state->apply_verbosity <= verbosity_silent) {
> +               state->saved_error_routine = get_error_routine();
> +               state->saved_warn_routine = get_warn_routine();
> +               set_error_routine(mute_routine);
> +               set_warn_routine(mute_routine);
> +       }
> +
>         return 0;
>  }
>
> @@ -4864,7 +4876,7 @@ int apply_all_patches(struct apply_state *state,
>                 state->newfd = -1;
>         }
>
> -       return !!errs;
> +       res = !!errs;

I am trying to understand this and the next chunk (they work together?)

>
>  end:
>         if (state->newfd >= 0) {
> @@ -4872,5 +4884,12 @@ int apply_all_patches(struct apply_state *state,
>                 state->newfd = -1;
>         }
>
> +       if (state->apply_verbosity <= verbosity_silent) {
> +               set_error_routine(state->saved_error_routine);
> +               set_warn_routine(state->saved_warn_routine);
> +       }
> +
> +       if (res > -1)
> +               return res;
>         return (res == -1 ? 1 : 128);

So anything > -1 is returned as is, and == -1 returns 1 and <-1  returns 128 ?

So I guess a reminder/explanation on why we need to fiddle with return codes
in the commit message would help. (I do not understand how the
verbosity influences return codes.)
