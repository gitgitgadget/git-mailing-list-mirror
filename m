Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95160C433FE
	for <git@archiver.kernel.org>; Fri, 27 May 2022 17:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352770AbiE0REC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiE0REB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 13:04:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5A13B8C1
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:04:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d20so992974pjr.0
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PofBwnR7eszWh/Ii8BIcACuZUptikSsoRyrpluJXjyM=;
        b=mf1F++9m6pFoGZD+tlTBc5aq5crNSzSGbEqDkprROxRDI/prScHMxvA3gTGTYuJe0E
         cL1BsCKUv2vto427xM+DnzbuLvxr2aXrFDZOAE8jheJJSvZNGL+e84Pfa7kPgsqjf5hd
         0rdDGKuZsWhUvWI7YGr1gT5rq4d0ZoRjsNWzUhuSEPjB+xh6N02ph0GsE6m/Y50ZsNhk
         o6/UOLzuJfjQlcP5PKgWfntGXu1TvZQCifdSdEkZAFfTXLQIgIgyYNgiV4XNy238Q+iY
         5ITI+X4GN5dXipFLFMImOtF+zFj8TWcPO611G995RB6l48644hZTj7Fqw1ASo9VL9etl
         7O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=PofBwnR7eszWh/Ii8BIcACuZUptikSsoRyrpluJXjyM=;
        b=niGtxUUGAw1kDS6/OG4CvXoA/Il+4Kj8C+I9+gT5uyHgUoMFFnTsktpQ1U/P14kBfR
         zBymI88ZmMXo9nOIRnctxcf7ySYG9akkYGpidKPE982uwcUk0Y0UqVD8gBEWr8nk63Dt
         YfmohXnX+NOgPLXH1VibKQozRwyEoeDZ1ThFuxCvR0No2ZnacCYitjiUDRERvMVWHqha
         u7+INzoVNRJhn2PPAHeO1JEz7M/GKLYBUBaVFAp8jQB0r7AOE6GnClN5Bf3JnowRRLuA
         rfBazwFYP8+O/DhwTxpfWBAyrpC8gIpDtsr8VJEPDdwOazRPgggEhITuRBoVbQikVTXq
         85Dw==
X-Gm-Message-State: AOAM532R8DLJC343nXuWnTIkK8zOkF6uyw9byzyrktCmeYX9NOu2u+DX
        BHK/TYnzlF5Dp/XMHRvcmfmgaA==
X-Google-Smtp-Source: ABdhPJxBiTIFufcoWKm+C/mueTTrta3wGxiZ89nmo+xsUkvzLGrVYSp3pud+oeXFW8ItGV7KrLKbGQ==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr43720158plo.166.1653671039257;
        Fri, 27 May 2022 10:03:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:fbc7:30a9:c3f6:e550])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001621cdf7172sm4057143plb.58.2022.05.27.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:03:58 -0700 (PDT)
Date:   Fri, 27 May 2022 10:03:52 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 2/5] parse-options.c: use new bug() API for optbug()
Message-ID: <YpEEeOEF+exFBVp2@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <patch-2.5-a599cd015a3-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.5-a599cd015a3-20220521T170939Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.21 19:14, Ævar Arnfjörð Bjarmason wrote:
> When we run into bugs in parse-options.c usage it's good to be able to
> note all the issues we ran into before dying. This use-case is why we
> have the optbug() function introduced in 1e5ce570ca3 (parse-options:
> clearer reporting of API misuse, 2010-12-02)
> 
> Let's change this code to use the new bug() API introduced in the
> preceding commit, which cuts down on the verbosity of
> parse_options_check().
> 
> There are existing uses of BUG() in adjacent code that should have
> been using optbug() that aren't being changed here. That'll be done in
> a subsequent commit. This only changes the optbug() callers.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  parse-options.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 6e57744fd22..7fff588a45f 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -14,15 +14,15 @@ enum opt_parsed {
>  	OPT_UNSET = 1<<1,
>  };
>  
> -static int optbug(const struct option *opt, const char *reason)
> +static void optbug(const struct option *opt, const char *reason)
>  {
> -	if (opt->long_name) {
> -		if (opt->short_name)
> -			return error("BUG: switch '%c' (--%s) %s",
> -				     opt->short_name, opt->long_name, reason);
> -		return error("BUG: option '%s' %s", opt->long_name, reason);
> -	}
> -	return error("BUG: switch '%c' %s", opt->short_name, reason);
> +	if (opt->long_name && opt->short_name)
> +		bug("switch '%c' (--%s) %s", opt->short_name,
> +		    opt->long_name, reason);
> +	else if (opt->long_name)
> +		bug("option '%s' %s", opt->long_name, reason);
> +	else
> +		bug("switch '%c' %s", opt->short_name, reason);
>  }
>  
>  static const char *optname(const struct option *opt, enum opt_parsed flags)
> @@ -441,28 +441,27 @@ static void check_typos(const char *arg, const struct option *options)
>  
>  static void parse_options_check(const struct option *opts)
>  {
> -	int err = 0;
>  	char short_opts[128];
>  
>  	memset(short_opts, '\0', sizeof(short_opts));
>  	for (; opts->type != OPTION_END; opts++) {
>  		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
>  		    (opts->flags & PARSE_OPT_OPTARG))
> -			err |= optbug(opts, "uses incompatible flags "
> -					"LASTARG_DEFAULT and OPTARG");
> +			optbug(opts, "uses incompatible flags "
> +			       "LASTARG_DEFAULT and OPTARG");
>  		if (opts->short_name) {
>  			if (0x7F <= opts->short_name)
> -				err |= optbug(opts, "invalid short name");
> +				optbug(opts, "invalid short name");
>  			else if (short_opts[opts->short_name]++)
> -				err |= optbug(opts, "short name already used");
> +				optbug(opts, "short name already used");
>  		}
>  		if (opts->flags & PARSE_OPT_NODASH &&
>  		    ((opts->flags & PARSE_OPT_OPTARG) ||
>  		     !(opts->flags & PARSE_OPT_NOARG) ||
>  		     !(opts->flags & PARSE_OPT_NONEG) ||
>  		     opts->long_name))
> -			err |= optbug(opts, "uses feature "
> -					"not supported for dashless options");
> +			optbug(opts, "uses feature "
> +			       "not supported for dashless options");
>  		switch (opts->type) {
>  		case OPTION_COUNTUP:
>  		case OPTION_BIT:
> @@ -471,7 +470,7 @@ static void parse_options_check(const struct option *opts)
>  		case OPTION_NUMBER:
>  			if ((opts->flags & PARSE_OPT_OPTARG) ||
>  			    !(opts->flags & PARSE_OPT_NOARG))
> -				err |= optbug(opts, "should not accept an argument");
> +				optbug(opts, "should not accept an argument");
>  			break;
>  		case OPTION_CALLBACK:
>  			if (!opts->callback && !opts->ll_callback)
> @@ -494,10 +493,9 @@ static void parse_options_check(const struct option *opts)
>  		}
>  		if (opts->argh &&
>  		    strcspn(opts->argh, " _") != strlen(opts->argh))
> -			err |= optbug(opts, "multi-word argh should use dash to separate words");
> +			optbug(opts, "multi-word argh should use dash to separate words");
>  	}
> -	if (err)
> -		exit(128);
> +	BUG_if_bug();

It might be worth noting in the commit message that this changes the
exit value in this case. On the other hand, it seems unlikely that
people are depending on this to detect programmer error that shouldn't
show up in the first place. I guess I don't feel too strongly about
this, it's probably fine to not mention it.


>  }
>  
>  static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
> -- 
> 2.36.1.960.g7a4e2fc85c9
> 
