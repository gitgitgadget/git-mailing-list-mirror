Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B065DC00144
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 06:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiHDGuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 02:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiHDGuA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 02:50:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29D45F5F
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 23:49:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id uj29so22040483ejc.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=ZAt+k4qeukc5BhI1U4tmndrKu7MlvR+fkJ525kSplaw=;
        b=qlDj3jHCvoqXBPrt4iNTVfowJ610fdzqv7G2h7on9AukneOngZ/WWYITO54Ay8D9yf
         GjN7AklLr/znVNBpgFYCQlM6t75ncl333ExGAyZsYIyGlKAUlT6rVzsVQOKdqTRB6BI9
         GNBAqK566nrZV5wMiiIN7VkGqbnohsIRqngMmCJm4A+xZ5D/A1CAOETC62B+PxZI6nbe
         LtF4TW6VP+MroafA98ogaeGqF/2sHys94FeDrk0mFNzRDFVNLdrnCkHl9GIh8HlqcmR+
         UVV02Q9WXqF/bFJGeeud69gzxA5CZBc4rPazpuEsywdsFYFGNFo7O7LGUnEuOOMELtFm
         oNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZAt+k4qeukc5BhI1U4tmndrKu7MlvR+fkJ525kSplaw=;
        b=tnQio1vJHqRXbENSaiCy3kVpqfCBLED0y7D7ThHdfy4f+uB1mDPWXTdl7wAK+HEYkw
         zJCmpt4Z5kqf0GOmpI/liqYcgWxs7t7LRl4GAtOv8qavUef8JvA2gSnceyqu79Gvjpt6
         0FNOoZ4xETlGxWUN7m9dSoB9e+n7ZpMEH1PPLWGFYmdyk2D4KCwoOZmhFn02ue46zdAY
         ogTzvDnia8YqjndtvdRrNxU1pB6s7DxIeat/RBOhcq9k4XAhqULGASE2ZlfaU7s20E8c
         YHpkXA8PAqZIukQL0j2D9tcG0oUMMzwfzy9+f//xk5rirC7iGAudwfywQpPJr4wq3luk
         6QHw==
X-Gm-Message-State: ACgBeo30QimqtGLFS01V50IaxhsFOjZmUci5u1vXEe79s54TpTvyq+YR
        K/+xOV2ohCblFGfwbLzCZ7A=
X-Google-Smtp-Source: AA6agR5ZbIxo4hCoiwC0CqqEeGaGAlCjZV9NqXi1Ov7WoTYqolzHRw0fse/YIwKZj3rO7e1a+Amczw==
X-Received: by 2002:a17:907:9612:b0:72e:56bd:2b9a with SMTP id gb18-20020a170907961200b0072e56bd2b9amr353900ejc.526.1659595797287;
        Wed, 03 Aug 2022 23:49:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709062f0700b00730165d7f41sm25534eji.13.2022.08.03.23.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:49:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJUg7-009eGj-2x;
        Thu, 04 Aug 2022 08:49:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 07/10] builtin/diagnose.c: gate certain data behind
 '--all'
Date:   Thu, 04 Aug 2022 08:39:47 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <a3e62a4a0418abbff5015302f0102ffacccf0ca4.1659577543.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <a3e62a4a0418abbff5015302f0102ffacccf0ca4.1659577543.git.gitgitgadget@gmail.com>
Message-ID: <220804.86v8r8ec4s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
> [...]
>  --------
>  [verse]
>  'git diagnose' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
> +	       [-a | --all]

I have some local patches that...

>  static const char * const diagnose_usage[] = {
> -	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>]"),
> +	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>] [-a|--all]"),
>  	NULL
>  };

...spot when we have SYNOPSIS & -h discrepancies. In this case we break
with a \n after <format> in the SYNOPSIS, but you don't add a "\n" and
indentation here in the -h output. The two should be the same.

> @@ -13,6 +13,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
>  	struct strbuf zip_path = STRBUF_INIT;
>  	time_t now = time(NULL);
>  	struct tm tm;
> +	int include_everything = 0;
>  	char *option_output = NULL;
>  	char *option_suffix = "%Y-%m-%d-%H%M";
>  	char *prefixed_filename;
> @@ -22,6 +23,9 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
>  			   N_("specify a destination for the diagnostics archive")),
>  		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
>  			   N_("specify a strftime format suffix for the filename")),
> +		OPT_BOOL_F('a', "all", &include_everything,
> +			   N_("collect complete diagnostic information"),
> +			   PARSE_OPT_NONEG),

Nice to have a "stats only" by default and some way to add the whole
shebang optionally...

> +int create_diagnostics_archive(struct strbuf *zip_path, int include_everything)

...but maybe...
>  {
>  	struct strvec archiver_args = STRVEC_INIT;
>  	char **argv_copy = NULL;
> @@ -176,11 +176,13 @@ int create_diagnostics_archive(struct strbuf *zip_path)
>  	loose_objs_stats(&buf, ".git/objects");
>  	strvec_push(&archiver_args, buf.buf);
>  
> -	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
> +	/* Only include this if explicitly requested */
> +	if (include_everything &&
> +	    ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0))))
>  		goto diagnose_cleanup;

...this should be --include-gitdir-extract or something, instead of
"--all" and "--include-everything".

I'd think that "all" would be a thing that would actually tar up my
entire .git directory as-is (in a way that would pass git fsck on the
other end (unless that's the bug being reported...)).

Aside: Since we are getting the churn of adding this, then re-indenting
 it maybe a prep step of adding a add_directories_to_archiver() would be
 useful, which would just have a data-driven:

	{
		{ ".git" },
		[...],
		{ ".git/logs, 1 },
		NULL
	},

Then loop over that, making it easy to add/declare new subdirs to add.
