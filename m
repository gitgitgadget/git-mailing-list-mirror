Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24AAC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358537AbiBDMKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiBDMKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:10:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA0C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:10:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id p12so12722087edq.9
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ej1n/2WabMWO0Eqp6dHdOnenxByibXdmcjk7pFoD11A=;
        b=ADdzkboJ/Y6FvLdw+snj2YwSrTgHQMYDoOREUeARadooR2tFMFxAHZPM4FI7rNngX9
         Ue+z7EBKlrkkLuDesNJGT588825rt80CxA6j6cbSQgSzDskoe3BR321Rf9KiPuLfAzXb
         EfwfYBLt8f8KE8fQ4d0SUEjD+pPhkemL36kV3uD0cnHeEXm7vvAgTXoSr1BXX+AKp00a
         S83Cv1GekJuhKjK8DdqyR2O9DDYe8jWzs/k0IU1TJcW3ON4MymMC2KYeLM12qSv/Leg6
         Ddh+vC8Po9wlUvXq/owKcxWRUtU4YtPkg2tuG+wSvGMfrgRxfe+7mBTrf9Qj346wqY1K
         A2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ej1n/2WabMWO0Eqp6dHdOnenxByibXdmcjk7pFoD11A=;
        b=vguANE4ScExNY3utclMvDb+qJYMZgEDIbKdaZX3I/RgU+65bVDY4irA+PJ5YsRxhBi
         ImmeP34GwA+j4QvhMrAXXz2ESGeZmArpcoxgHJBnt5QGaMFDowGOBpMsQXxXcWKvtyI1
         +BrI85ecJjb7CrZVM34t9l3ooQ8JceOiNhLMcTI258jezbsdFAE1PoDzVNtn0uYrUXQG
         svtWkBoXkuaakAvaC6zusQ1D6/7nNcWMUv3fKeY3htQsBg7CowSYxcyfMZZQ/3AEosxd
         LMcIMaDTJkTfERPbQhq/9qIGMuKMlZwMiELqIZwIIwflQWJIee0A2rwkC8PPLb5RKUFB
         JxJA==
X-Gm-Message-State: AOAM531rSUlK2k4QUnjRezXN5xk02pGQoQb1HIcgsN+mS9/RMohzc0ZM
        JUAJ9wjsvj7DtT5Q7i3qHlzgbj/QxA9MOw==
X-Google-Smtp-Source: ABdhPJzJEXv+WNDmJTmk1zBGpAV8dPyNAeJqp6ykpSkx7BPGodaWhWO0Cj4/jFNIhtJEEQ9a9EKOuA==
X-Received: by 2002:a05:6402:2376:: with SMTP id a22mr2788912eda.3.1643976650387;
        Fri, 04 Feb 2022 04:10:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s20sm593357ejr.167.2022.02.04.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:10:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxQP-0063YH-0V;
        Fri, 04 Feb 2022 13:10:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] cat-file.c: rename cmdmode to mode
Date:   Fri, 04 Feb 2022 13:10:16 +0100
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <86df0c9e4df34566c10870e06865af536504a6af.1643915286.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <86df0c9e4df34566c10870e06865af536504a6af.1643915286.git.gitgitgadget@gmail.com>
Message-ID: <220204.86zgn63k8n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> To prepare for a new flag --batch-command, we will add a flag that
> indicates whether or not an interactive command mode will be used
> that reads commands and arguments off of stdin.
>
> An intuitive name for this flag would be "command", which can get
> confusing with the already existing cmdmode.
>
> Rename cmdmode->mode to prepare for this change.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/cat-file.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index d94050e6c18..858bca208ff 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -24,7 +24,7 @@ struct batch_options {
>  	int buffer_output;
>  	int all_objects;
>  	int unordered;
> -	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> +	int mode; /* may be 'w' or 'c' for --filters or --textconv */
>  	const char *format;
>  };
>  
> @@ -306,19 +306,19 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  	if (data->type == OBJ_BLOB) {
>  		if (opt->buffer_output)
>  			fflush(stdout);
> -		if (opt->cmdmode) {
> +		if (opt->mode) {
>  			char *contents;
>  			unsigned long size;
>  
>  			if (!data->rest)
>  				die("missing path for '%s'", oid_to_hex(oid));
>  
> -			if (opt->cmdmode == 'w') {
> +			if (opt->mode == 'w') {
>  				if (filter_object(data->rest, 0100644, oid,
>  						  &contents, &size))
>  					die("could not convert '%s' %s",
>  					    oid_to_hex(oid), data->rest);
> -			} else if (opt->cmdmode == 'c') {
> +			} else if (opt->mode == 'c') {
>  				enum object_type type;
>  				if (!textconv_object(the_repository,
>  						     data->rest, 0100644, oid,
> @@ -330,7 +330,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  					die("could not convert '%s' %s",
>  					    oid_to_hex(oid), data->rest);
>  			} else
> -				BUG("invalid cmdmode: %c", opt->cmdmode);
> +				BUG("invalid mode: %c", opt->mode);
>  			batch_write(opt, contents, size);
>  			free(contents);
>  		} else {
> @@ -533,7 +533,7 @@ static int batch_objects(struct batch_options *opt)
>  	strbuf_expand(&output, opt->format, expand_format, &data);
>  	data.mark_query = 0;
>  	strbuf_release(&output);
> -	if (opt->cmdmode)
> +	if (opt->mode)
>  		data.split_on_whitespace = 1;
>  
>  	/*
> @@ -695,10 +695,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  
>  	batch.buffer_output = -1;
>  	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
> -
>  	if (opt) {
>  		if (batch.enabled && (opt == 'c' || opt == 'w'))
> -			batch.cmdmode = opt;
> +			batch.mode = opt;
>  		else if (argc == 1)
>  			obj_name = argv[0];
>  		else
> @@ -712,9 +711,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  			usage_with_options(cat_file_usage, options);
>  	}
>  	if (batch.enabled) {
> -		if (batch.cmdmode != opt || argc)
> +		if (batch.mode != opt || argc)
>  			usage_with_options(cat_file_usage, options);
> -		if (batch.cmdmode && batch.all_objects)
> +		if (batch.mode && batch.all_objects)
>  			die("--batch-all-objects cannot be combined with "
>  			    "--textconv nor with --filters");
>  	}

There's a rather major rewrite in-flight to this codepath in
ab/cat-file. I think it would be better to base this on top of that. Per
Junio's latest "What's Cooking" that may be getting merged down today or
tomorrow.
