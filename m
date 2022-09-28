Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022D6C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 15:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiI1PNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiI1PNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 11:13:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F89AB074
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:13:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hy2so27791046ejc.8
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=t0W7lpXtTGndYQMlbbR3wbqZwtAeN205j6oXGqf7Fvw=;
        b=det7T8ypuYI2xZeo2wWrnH5IHIYEcgt4ihaz5OavksYUhQZ1wZ+13oqIEiFShzMqhg
         6ZUN/qVYEx1fUTMhvbxPPdNwX+mwq7Q1Tu8YZGs/PQ7W0ayuDqVPnQn0DXUVSZ+iP3MU
         S3ks+0g2xhpcVVepXhbUF9RjbFLV7L3YFoDpGWKwrnp5oj+M3k3ROm5nhkXB2h3ycmiN
         LeaesPDmwfP7rv9eKa1nywS6P67/4XvmxJ4dlrSI7fDTkAA4cisjqksdftc2tD2J+kpI
         2GPgzxlmsuiPHSJHVVu0xgtRWtwWSo6+G+HH8SudCKc+Jru7upXIlRS7EUtwtWJ+KrIc
         SXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=t0W7lpXtTGndYQMlbbR3wbqZwtAeN205j6oXGqf7Fvw=;
        b=Sto1H5zdzXn2yhGK2QNEhx/dRN31p1q9Bevnn9Bx0Gsq+uut5XPxF5ie3VLNqkqcVd
         TaDdB+YuY1+d/cermBuNSRBUxIeMLnbMBfINQ5KBSDZ8BMycLu7KNyND69i1QuRfcS6+
         Z1wHipeSb7M/0AIjQXPqLaa3FSgwsRWsn2XLrASMurYMGRCVQAWiuLMRs5SAR3md8gZZ
         7Bd8wGpXfhIgVNoGZ9FsIkcIjYSVzC2CsqaYKp9iMNAt/BxE/l/6o6zilQ5DNGBBg5RE
         2EdPxMBmayy3FI8KIN/j+ggITp7l1enFW69ewcOEbIvBLW9Gr6boyKqxIqJl7rhnavt1
         BcfQ==
X-Gm-Message-State: ACrzQf1++soZWvSKFrQsoKNanA7vOVBEujWhqe2rwyKp2jXvyOsCZSyq
        WeiX4APRwBoMM6iMiD41G+mkelyQGggrhg==
X-Google-Smtp-Source: AMsMyM4pJaiCAGffnRA7T58e+ftaM4q+h+mKquh7+GX7gun+VmgZ5tsqcKKdJsrXDy1dwY8hjUJzzQ==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id wt6-20020a170906ee8600b0074189bc27a1mr28390604ejb.725.1664378016998;
        Wed, 28 Sep 2022 08:13:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j5-20020aa7ca45000000b004580296bb0bsm454460edt.83.2022.09.28.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:13:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odYkh-0010tW-1k;
        Wed, 28 Sep 2022 17:13:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, gitster@pobox.com
Subject: Re: [PATCH] bugreport: clarify that -o expects a directory and not
 a file
Date:   Wed, 28 Sep 2022 17:09:16 +0200
References: <20220928050432.701512-1-alexhenrie24@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220928050432.701512-1-alexhenrie24@gmail.com>
Message-ID: <220928.86tu4rwmzk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Alex Henrie wrote:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/git-bugreport.txt | 2 +-
>  builtin/bugreport.c             | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> index eca726e579..784d9b6304 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -8,7 +8,7 @@ git-bugreport - Collect information for user to file a bug report
>  SYNOPSIS
>  --------
>  [verse]
> -'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
> +'git bugreport' [(-o | --output-directory) <dir>] [(-s | --suffix) <format>]
>  		[--diagnose[=<mode>]]
>  
>  DESCRIPTION
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 530895be55..827688183e 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  }
>  
>  static const char * const bugreport_usage[] = {
> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
> +	N_("git bugreport [-o|--output-directory <dir>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
>  	NULL
>  };
>  
> @@ -110,7 +110,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
>  			       N_("create an additional zip archive of detailed diagnostics (default 'stats')"),
>  			       PARSE_OPT_OPTARG, option_parse_diagnose),
> -		OPT_STRING('o', "output-directory", &option_output, N_("path"),
> +		OPT_STRING('o', "output-directory", &option_output, N_("dir"),
>  			   N_("specify a destination for the bugreport file(s)")),
>  		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
>  			   N_("specify a strftime format suffix for the filename(s)")),

Hi, there's an outstanding patch of mine queued in "seen" that fixes the
same issue. I sent a re-roll of it after you submitted this (but the v1
had been in "seen". See:
https://lore.kernel.org/git/patch-v2-17.35-97873747a1e-20220928T082458Z-avarab@gmail.com/

Per that change I think the right thing here is to convert both to use
"<path>".

I don't really have a strong opinion per-se on if we use "<dir>" or
"<path>", but from grepping around the latter seems more common, even in
cases where we mean "a path that's only a dir".

In any case, if you did want to advocate that we should really use
"<dir>" you missed also updating these:
	
	Documentation/git-bugreport.txt:-o <path>::
	Documentation/git-bugreport.txt:--output-directory <path>::
	Documentation/git-bugreport.txt:        Place the resulting bug report file in `<path>` instead of the current

The recent "diagnose" built-in is also largely copy/pasted from
"bugreport", and uses the same interface, so in that case it would make
sense to update it too...
