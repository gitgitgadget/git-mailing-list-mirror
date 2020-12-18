Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199BC2BBCF
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EAE22D01
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgLRFm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgLRFmz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:42:55 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F4C0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:42:14 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id b24so965997otj.0
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1mnKnYL/6ZQTxGqvbKx+gZswbb1ocL6SzjcD88G+1U=;
        b=K55p+xlcNeFFhawiZ+s7lwo9OOiIMdlyjg1wU9yjfiEx+WHiU8sho89+QEv1DX19u5
         TCJV8vWV+zqPI+wdbay0lpF7YS+Zquz0/TklwQeB714wxUgi7csx31dR1vbXfhSFLykI
         RwbWHUxzDR5tUm4sw6lJT45YDdpTxBU52P/4RB1BlqzfSowRWixyznz3zBiv8K14sbUp
         qxv7IFlcrG5Dw9PsTFlmH62R6CYThcId4Q2HKeshKPX6zO3llJAgLpHBpJpIhwoRc/EX
         6wJ8cWm4TsOEr0ulGq5N4//nVwVxPSzx+3AnPcbhn1FZWcntZXNfoMj5bjgfYECyaviy
         6OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1mnKnYL/6ZQTxGqvbKx+gZswbb1ocL6SzjcD88G+1U=;
        b=cGgQymS/i/Oq5PAcyDC3W03ueTND3XXhYvadVIB0PGvqspi4+ATf+uG7n4rE5V23OE
         cKGkW3t8kxmyR22lruxzmV3hYt/B9hQGrRB6s2jwvglm++sJplAtHov8tva9Y0gechEc
         gZoJjj+lc5rj+2khMCVN6Tvk2bP0B7Azs0alklxAHyaX/nnZayIVme4IzQT/XcEAYD8H
         z3K6AF2tBxsJqN2/EJcB7L6fKi97dFbG+9Trwy8jMmD+N6mfhzaBw+kUoRP5suL7jbzF
         T2eh7D8EgRkjQPFmyjqGWtUcMToCyaqwKI3GzCx4tlxsvySaTSaYx96IBY++4Tt85dL8
         Fb9w==
X-Gm-Message-State: AOAM533qqvm+ArlmJwIt9gsd82MGm2IhFihSsCmGP+EtCbNAWIXhaVyk
        fRl7Gvwd1alQ7R8Jj/HTiYxXexPUjUqEU9V35efLlAbnJ2o=
X-Google-Smtp-Source: ABdhPJxFo6sYN3MzaDFsUsuRIazMLaBfNKqIydDWeJGu8WPSZYoNjCzBfAhYz8coodM/8boysnaQ/wmEPwnPc6ZGZJA=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr1762610oth.316.1608270134146;
 Thu, 17 Dec 2020 21:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-24-sorganov@gmail.com>
In-Reply-To: <20201216184929.3924-24-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Dec 2020 21:42:03 -0800
Message-ID: <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Put open curly brace on its own line
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index cba391604ac7..0165fa22fcd1 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -2,7 +2,8 @@
>
>  #include "revision.h"
>
> -static void suppress(struct rev_info *revs) {
> +static void suppress(struct rev_info *revs)
> +{
>         revs->separate_merges = 0;
>         revs->first_parent_merges = 0;
>         revs->combine_merges = 0;
> @@ -10,17 +11,20 @@ static void suppress(struct rev_info *revs) {
>         revs->combined_all_paths = 0;
>  }
>
> -static void set_separate(struct rev_info *revs) {
> +static void set_separate(struct rev_info *revs)
> +{
>         suppress(revs);
>         revs->separate_merges = 1;
>  }
>
> -static void set_first_parent(struct rev_info *revs) {
> +static void set_first_parent(struct rev_info *revs)
> +{
>         set_separate(revs);
>         revs->first_parent_merges = 1;
>  }
>
> -static void set_m(struct rev_info *revs) {
> +static void set_m(struct rev_info *revs)
> +{
>         /*
>          * To "diff-index", "-m" means "match missing", and to the "log"
>          * family of commands, it means "show full diff for merges". Set
> @@ -30,19 +34,22 @@ static void set_m(struct rev_info *revs) {
>         revs->match_missing = 1;
>  }
>
> -static void set_combined(struct rev_info *revs) {
> +static void set_combined(struct rev_info *revs)
> +{
>         suppress(revs);
>         revs->combine_merges = 1;
>         revs->dense_combined_merges = 0;
>  }
>
> -static void set_dense_combined(struct rev_info *revs) {
> +static void set_dense_combined(struct rev_info *revs)
> +{
>         suppress(revs);
>         revs->combine_merges = 1;
>         revs->dense_combined_merges = 1;
>  }
>
> -static void set_diff_merges(struct rev_info *revs, const char *optarg) {
> +static void set_diff_merges(struct rev_info *revs, const char *optarg)
> +{
>         if (0) ;
>         else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
>                 suppress(revs);
> @@ -62,7 +69,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg) {
>   * Public functions. They are in the order they are called.
>   */
>
> -int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
> +int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
> +{
>         int argcount = 1;
>         const char *optarg;
>         const char *arg = argv[0];
> @@ -86,23 +94,27 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>         return argcount;
>  }
>
> -void diff_merges_suppress(struct rev_info *revs) {
> +void diff_merges_suppress(struct rev_info *revs)
> +{
>         suppress(revs);
>  }
>
> -void diff_merges_default_to_first_parent(struct rev_info *revs) {
> +void diff_merges_default_to_first_parent(struct rev_info *revs)
> +{
>         if (!revs->explicit_diff_merges)
>                 revs->separate_merges = 1;
>         if (revs->separate_merges)
>                 revs->first_parent_merges = 1;
>  }
>
> -void diff_merges_default_to_dense_combined(struct rev_info *revs) {
> +void diff_merges_default_to_dense_combined(struct rev_info *revs)
> +{
>         if (!revs->explicit_diff_merges)
>                 set_dense_combined(revs);
>  }
>
> -void diff_merges_set_dense_combined_if_unset(struct rev_info *revs) {
> +void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
> +{
>         if (!revs->combine_merges)
>                 set_dense_combined(revs);
>  }
> --
> 2.25.1
>

But...didn't you add all these functions yourself earlier in the
series?  Why didn't you split this patch up and squash it into the
relevant previous patches?
