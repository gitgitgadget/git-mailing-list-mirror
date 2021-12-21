Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E986BC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 02:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhLUC5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 21:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhLUC5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 21:57:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B9C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 18:57:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j6so25415994edw.12
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 18:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=s4mBWwsDqXUSE4CMGUkVpEDqY1/qiB5YwPPVDDB1RvQ=;
        b=fnZ3QHmLxaesE0gC8i71gAc6Te+dMMrK5RxykI4y2bIZXx8Pn/6RRrvU7pd8/Lwy+z
         6+WsyU0GJJfPLkz8dFFVBfJVUMcfh+RIYG+/60dYOk/ZkiC3Eq+g3X6i/Z2Dr4fyKayv
         GHaqalNZcBuuJgUSjIAoMvuOl1eDdX9ASTICmUFkdoKEiVEl8nzlF6/n2GdpdhTLgBWS
         WYjK6bcoyiPhPTuv0dvtRZbQxUj2os4FR+uio7k0fQ2i8P2pKPiRg7UmEVl242iRbknN
         L5PxaE5Cl/j6oIg65I75Z++FUCmRa92t1HEQqYBbEvmkkugnhKpnaaOXO4ujEaLx3SOT
         +KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=s4mBWwsDqXUSE4CMGUkVpEDqY1/qiB5YwPPVDDB1RvQ=;
        b=d0w4Myx8I8G7AWIVHq2h7oMsf41dIMp97kAiO/SihTVli59itk3UJ4voulnk0SzvTV
         D+bpo6+NlnflGd8rGYy7voMQiZkCMCL4598nZotagl64RXGeyPRWi4yppdHPBj5ZQgqi
         vo3IYSSkUEo4L1JoYvcMb83PYOK6Ulq3Xo65z3yMk3o6TJj5TPSSvz5aS3ksm5MsINE+
         KXFKAzW7i9EY8PQtOxMD275HLw2SauLvwMeeEnlrpBaOdmxqM0j4qa//h4SjfgcOQemh
         gamVVmGUS81mqcArs5T0twrBiPY2Uls4WuTnlcrPYrsembyuaWNtTvCERAFRraBuzTC5
         XzIA==
X-Gm-Message-State: AOAM530HSd/hEZGml6YN7++bkQayraMjH3Dfttz8GDXmt888tl/v84iR
        AQUyL8tXbXqq/lzlPyG7hcA=
X-Google-Smtp-Source: ABdhPJxlc5DxoemJdi5HXZTk+/1tL9/OsjBGXjANAfz4SiFH+yTx9o/g+N0fdxtb4vFFc8sCy3lRkw==
X-Received: by 2002:a17:907:7da5:: with SMTP id oz37mr884518ejc.682.1640055438746;
        Mon, 20 Dec 2021 18:57:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hp35sm4612662ejc.88.2021.12.20.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 18:57:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzVL3-000cvJ-Ke;
        Tue, 21 Dec 2021 03:57:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
Date:   Tue, 21 Dec 2021 03:51:58 +0100
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2112202324110.347@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2112202324110.347@tvgsbejvaqbjf.bet>
Message-ID: <211221.86k0fysm0i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Johannes Schindelin wrote:

> Hi Sean,
>
> On Sat, 18 Dec 2021, Sean Allred wrote:
>
>> I've got a custom subcommand I'm distributing in my company to integrate
>> with our bug-tracker. It's a pretty robust utility and has its own help
>> function, but running `git foo --help` doesn't pass --help to my git-foo
>> utility. I asked a question[1] about this scenario on the Windows fork
>> and they directed me upstream.
>>
>> It sounds like `git foo --help` is internally consumed as `git help
>> foo`, which forwards requests to info/man/web handlers per config.
>> Being on Windows and knowing my peers as I do, the vast majority of my
>> users won't be familiar with info or man. The HTML documentation used
>> by the web handler is in a Git4Win-controlled installation directory
>> that I'd really rather not touch/maintain. I really just want `git foo
>> --help` to call `git-foo --help`.
>>
>> What's the best way to go about this?
>>
>> In the event the best next step is to start a patch, does it sound
>> reasonable to simply not perform this `git foo --help` -> `git help
>> foo` transformation for non-builtins? Or, while I don't relish the
>> idea, would some kind of config option be needed?
>
> I think you might need to be a bit more careful than just looking whether
> the command in question is a built-in or not. It could be delivered as a
> script or executable inside `libexec/git-core`. So maybe check that,
> something like this:
>
> -- snip --
> diff --git a/git.c b/git.c
> index c802dfe98004..d609f90cc117 100644
> --- a/git.c
> +++ b/git.c
> @@ -688,6 +688,33 @@ static void strip_extension(const char **argv)
>  #define strip_extension(cmd)
>  #endif
>
> +static int is_in_git_exec_path(const char *command_name)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	int ret = 0;
> +
> +	if (!command_name)
> +		return 0;
> +
> +	strbuf_addf(&path, "%s/git-%s", git_exec_path(), command_name);
> +	ret = !access(path.buf, X_OK);
> +
> +#ifdef STRIP_EXTENSION
> +	if (!ret) {
> +		/*
> +		 * If `command_name` ended in `.exe`, strip it, otherwise
> +		 * append it.
> +		 */
> +		if (!strbuf_strip_suffix(&path, STRIP_EXTENSION))
> +			strbuf_addstr(&path, STRIP_EXTENSION);
> +		ret = !access(path.buf, X_OK);
> +	}
> +#endif
> +
> +	strbuf_release(&path);
> +	return ret;
> +}
> +
>  static void handle_builtin(int argc, const char **argv)
>  {
>  	struct strvec args = STRVEC_INIT;
> @@ -697,8 +724,11 @@ static void handle_builtin(int argc, const char **argv)
>  	strip_extension(argv);
>  	cmd = argv[0];
>
> +	builtin = get_builtin(cmd);
> +
>  	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
> -	if (argc > 1 && !strcmp(argv[1], "--help")) {
> +	if (argc > 1 && !strcmp(argv[1], "--help") &&
> +	    (builtin || is_in_git_exec_path(argv[0]))) {
>  		int i;
>
>  		argv[1] = argv[0];
> @@ -714,7 +744,6 @@ static void handle_builtin(int argc, const char **argv)
>  		argv = args.v;
>  	}
>
> -	builtin = get_builtin(cmd);
>  	if (builtin)
>  		exit(run_builtin(builtin, argc, argv));
>  	strvec_clear(&args);
> -- snap --
>
> Of course, this might break existing users' setups where they ship a Git
> command together with a manual page.
>
> A potential remedy against that would be, as you say, a config option.
> Maybe defaulting to the manual page if `help.format` is `man`, otherwise
> defaulting to passing `--help` to the command.

What are the cases that require us to inexpect our --exec-path at
runtime, as opposed to having a list of commands we know we put there at
"install" time?

The only ones I can think of are e.g. Debian's packaging which might
compile the git with "git-send-email", but it won't be there unless you
install "git-email" in addition to "git".

But for those cases any such logic would presumably want the hardcoded
full list over the dynamic access() check, since e.g. "git-doc" on that
platform orthagonally installs "git-send-email.html" and the like, and
"git help send-email" would presumably like to error saying that we know
about git-send-email, we just can't find its documentation, even if we
can't find it in --exec-path.
