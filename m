Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E0FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190EC604DB
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbhJOQ12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbhJOQ1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:27:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07988C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:25:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d9so1594895pfl.6
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OCKr9XBN6fIc9F6IWgiUYddE52S+jfpTCHYWH2P6mec=;
        b=mbLE7RLeUqAiv8PCp5x587QLA0b2PDlW9fq9h3o998pUu08EUzGd13e1mfZELIR7Sf
         fEThWh04S21jzuRYEt+qqqOwUzf8VDjEVWuQ2dN/ugkwJFixXPQiTVuQIQXkeYg8jUX1
         RfJ0Wc/vl4mQgRd1NlOcj/0g2a5BuBdfc73CIA8Uq1Zq1kEZV4KGd2XsviqkJZTQ3EjL
         8Wv5vTBWKdpbnUBswzYVUwdyN0KimJhwjsSlmWkv7na4wUQOMg663EN91T2syWp1HoSd
         k/pZ7wHNWzC5d2mDJ8LnVoYSLcpcVhqS6uaPmgPFSqimDpdGZ9U3n+nB8B4xYC3FDKNE
         6Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OCKr9XBN6fIc9F6IWgiUYddE52S+jfpTCHYWH2P6mec=;
        b=HE4PxL4aDJKcImZj1yGDk4WHz9Etuvuuw2qgxDx0gr2jLvY8V8yBA7Khed5ACTRm/P
         Jwu0lBKIUzfncYlF8GqiLSpNhfs69zGH+huWEUUjCzqyJ+NbyDkVz6emc/bG3CsBJjmP
         FQQIUqYxyp7l74WWo2BDs/DkGfVh6w1O6p0stx2reABi4GumSRGPeNLVntw5h9+slCOc
         9NrOPqtOUzfwbFu+gERj1lUHMUPmhRZatLUVD/izJMS6yAeceTjbitGvPA7s27G9O7X2
         tnRfnQD2TpbJyIHnjhWLO+z+D5uPraD9W0SibkpsSKczRWurfmbPFyLcDpdTwNQlrcPo
         X/Ag==
X-Gm-Message-State: AOAM532D5p0NlIyjDGl3gzkI1ZQs5eSqTmeH3UfoFJ2rrbi+xAgJfTae
        1a8tdVYkxKzJ5l+WM5bhX9TJZK2elT3svg==
X-Google-Smtp-Source: ABdhPJyE1MQ13ZNfdaocSwY43q1657kAaq+ds5eER1oyecLtHeiDxMaTAhYQhV/rlUFQkE5q06721Q==
X-Received: by 2002:a63:35c6:: with SMTP id c189mr2960445pga.22.1634315109339;
        Fri, 15 Oct 2021 09:25:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id q12sm5295298pgv.26.2021.10.15.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:25:08 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:25:04 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 03/13] rebase: convert pre-rebase to use hook.h
Message-ID: <YWmrYE65qWjStVzf@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-03.13-6227a1e644d-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-03.13-6227a1e644d-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:30:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Move the pre-rebase hook away from run-command.h to and over to the
> new hook.h library.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  builtin/rebase.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8c6393f6d78..9a44939d662 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -28,6 +28,7 @@
>  #include "sequencer.h"
>  #include "rebase-interactive.h"
>  #include "reset.h"
> +#include "hook.h"
>  
>  #define DEFAULT_REFLOG_ACTION "rebase"
>  
> @@ -1305,6 +1306,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	char *squash_onto_name = NULL;
>  	int reschedule_failed_exec = -1;
>  	int allow_preemptive_ff = 1;
> +	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
>  	struct option builtin_rebase_options[] = {
>  		OPT_STRING(0, "onto", &options.onto_name,
>  			   N_("revision"),
> @@ -2021,9 +2023,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	/* If a hook exists, give it a chance to interrupt*/
> +	strvec_push(&hook_opt.args, options.upstream_arg);
> +	if (argc)
> +		strvec_push(&hook_opt.args, argv[0]);
>  	if (!ok_to_skip_pre_rebase &&
> -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
> -			argc ? argv[0] : NULL, NULL))
> +	    run_hooks_oneshot("pre-rebase", &hook_opt))
>  		die(_("The pre-rebase hook refused to rebase."));
>  
>  	if (options.flags & REBASE_DIFFSTAT) {
> -- 
> 2.33.0.1567.g7b23ce7ed9e
> 
