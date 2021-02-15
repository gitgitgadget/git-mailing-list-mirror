Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849BAC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0864DF4
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBOVzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOVzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:55:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F2C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:54:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id y26so13533895eju.13
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Or/HzNpPBXTo+QDv09NfSfTqDLatYFGglKzJLappj8Y=;
        b=n7T2OQzLIi/UL+vGnBJpGF5fOew7Mpm8QFbKTxBawvoUd57h1SEVotVioWIFBS9sgd
         WZN6qTloB6xlGjh66yGD+ebBpsPdUGwxZ1Gd2GY1q0ijqt5CMp+18hr+pCTqCdybzQXg
         uQ+KPXpo904RlEEkjIsme3T3Rtt+QenTTxtO+8nRZG0pZWyYlPhzrSIAOLhxzxcad7TQ
         T0OMBNJzzhAdqaVolBjblcp56pS/U9o2H/nouoQ4z7QbYH3UY/5IGS2033zI/zwHUXKj
         5481dbfuwJws9mDxl42EWo3ryx7HnWoqRwmXBy216Cn6PPUuRKn65pmWesaZljVX+04q
         X80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Or/HzNpPBXTo+QDv09NfSfTqDLatYFGglKzJLappj8Y=;
        b=I0XoCMSgO+UDEx940igW9/AyGqh16ZOBvG2ReUG1hVSgGS/fH0tjufv8qNcZTbupml
         GNMNumFibSXM3hrSiSp3PILHQTiodZKl5RujzMX45QH21IL6gaDXVMQ45wmmeUhJdg+h
         FOmeJ5Yi2ufrDVqTnV5Tiqdy8Vfw2mKCIe5nI8E77GNWTlETDGNuqNuC5WXSJs3fSvwg
         sangqOS8SX40e+tW2ymd09g0KIhV0FsSEPbcnUkIb2XJqNcAOw2lkY4mZVMNirGkK2fT
         Q9WyDfnq3FBd96o+/zsmr81tbizsTClx+HMM99Llw/ztAlyhOsUkBum2ClYT32rZbaH0
         tXgw==
X-Gm-Message-State: AOAM533YYsmS34Wa324ChB0E+Q3mOA59HBTJ48yZujeq8crOkpRfhBk1
        A3vf9gFuFaBfO/XXi7wkIWw=
X-Google-Smtp-Source: ABdhPJxAPgjIJke435Bu/2TbNxcJpdXGDZ1WeOKBhlbm6/9SBbCcXEdIaRcNFa4mIS38ITGUQjGGlw==
X-Received: by 2002:a17:906:b0d8:: with SMTP id bk24mr3338268ejb.252.1613426072285;
        Mon, 15 Feb 2021 13:54:32 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id b11sm11658247eja.115.2021.02.15.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:54:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] builtin/multi-pack-index.c: split sub-commands
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <16f33e41388ed431f70e09ef68717bd30fbee67f.1613422804.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <16f33e41388ed431f70e09ef68717bd30fbee67f.1613422804.git.me@ttaylorr.com>
Date:   Mon, 15 Feb 2021 22:54:31 +0100
Message-ID: <877dn9atew.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Taylor Blau wrote:

>  	trace2_cmd_mode(argv[0]);

Not a new issue, but curious that in the commit-graph.c code we'll first
validate, but here write garbage into the trace2_cmd_mode() before
potentially dying.

>  
>  	if (!strcmp(argv[0], "repack"))
> -		return midx_repack(the_repository, opts.object_dir,
> -			(size_t)opts.batch_size, opts.flags);
> -	if (opts.batch_size)
> -		die(_("--batch-size option is only for 'repack' subcommand"));
> -
> -	if (!strcmp(argv[0], "write"))
> -		return write_midx_file(opts.object_dir, opts.flags);
> -	if (!strcmp(argv[0], "verify"))
> -		return verify_midx_file(the_repository, opts.object_dir, opts.flags);
> -	if (!strcmp(argv[0], "expire"))
> -		return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
> -
> -	die(_("unrecognized subcommand: %s"), argv[0]);
> +		return cmd_multi_pack_index_repack(argc, argv);
> +	else if (!strcmp(argv[0], "write"))
> +		return cmd_multi_pack_index_write(argc, argv);
> +	else if (!strcmp(argv[0], "verify"))
> +		return cmd_multi_pack_index_verify(argc, argv);
> +	else if (!strcmp(argv[0], "expire"))
> +		return cmd_multi_pack_index_expire(argc, argv);
> +	else
> +		die(_("unrecognized subcommand: %s"), argv[0]);

I realize this is the existing behavior, but let's just make this die()
be the usage_with_options() we emit above in this case?

So maybe this on top?

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index caf0248a98..6f9223d538 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -65,6 +65,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_write_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -79,6 +81,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_verify_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -93,6 +97,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_expire_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -112,6 +118,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	trace2_cmd_mode(argv[0]);
+
 	options = parse_options_dup(builtin_multi_pack_index_repack_options);
 	options = add_common_options(options);
 
@@ -144,20 +152,15 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
 
-	if (argc == 0)
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
-
-	trace2_cmd_mode(argv[0]);
-
-	if (!strcmp(argv[0], "repack"))
+	if (argc && !strcmp(argv[0], "repack"))
 		return cmd_multi_pack_index_repack(argc, argv);
-	else if (!strcmp(argv[0], "write"))
+	else if (argc && !strcmp(argv[0], "write"))
 		return cmd_multi_pack_index_write(argc, argv);
-	else if (!strcmp(argv[0], "verify"))
+	else if (argc && !strcmp(argv[0], "verify"))
 		return cmd_multi_pack_index_verify(argc, argv);
-	else if (!strcmp(argv[0], "expire"))
+	else if (argc && !strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
 	else
-		die(_("unrecognized subcommand: %s"), argv[0]);
+		usage_with_options(builtin_multi_pack_index_usage,
+				   builtin_multi_pack_index_options);
 }

