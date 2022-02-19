Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9277AC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 06:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiBSGFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 01:05:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbiBSGFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 01:05:31 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A774D50B32
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:05:12 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so19741203eje.10
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8xVpJOiiiKD/l6VcnALUpFSorwSrewjLJOPODpK0NCE=;
        b=CrhuYvBfs+dRwwweBJndcZF3WgJGddSC7tC5U4nPe+OHpb9ZjBSB7YV/UBSGVyaG9u
         e0PxM91UwAX3B1eSkeafJHc79Nv2z7v5eZX+t4qanfzqD3ychb3wJkVRlt//ldtJnPAK
         oys6Tr3ny4RU3vBmoIMozR09GTAgNdvPqp22pfWh/hPAqH65enCM/6jR3W5BiU4PI4XN
         W8xUuXg+XyPr0GYt1gRL1+tt9x0JYKZQNiI/hkxXLgKAfNXkEoQe+6kYWVpY2r6ETKVa
         UuAhBbXLSDCUN1vFFPCU58wBjHjM0g3uzzT1MP5otkrkmx/KeUIfFvjzogn8mv4RrCpY
         K5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8xVpJOiiiKD/l6VcnALUpFSorwSrewjLJOPODpK0NCE=;
        b=lPOsApUm/uiCX9zrjKggh1SurihZ5dQ+UsnZRYrxvgtJHC6+KtTn8KD2rRj4997azP
         917jvmTgqvJoUBAyz1xrhqU6i5mmOcqY73v/gZ/MVnb2m7wq16Naxb3K2g3WKxIBNq0A
         ZMSn8wF26SNuvOG1YQ/YxriY9983IFPOdd3C5wSHU1PfDF91swiP3cVXaHqtEfJDhKI4
         W/MmUBL7rxX8JYJfpINgpEmqaTxbWNUo53DqgXIUmNR9/y0nbhc4g6Wi+fCDelO0LEAg
         aVWL6eNNQQ2hh3UaRHE2b1ELpIBzopG7FI82mu5SyYzgex0PGIs78BE7VyPq/8uggYb1
         zJiw==
X-Gm-Message-State: AOAM530dZDnRNAUMaofnWtijW4uCM5mnzMnqv7EoycXcHhPDRLxvVpbr
        Y230yPUcOdW3OOc1oPcgzPc=
X-Google-Smtp-Source: ABdhPJzOwZSG63tdzQDLFbTNWaFXQwcIwEFrzmZ27USfWs1zEjJEf+I8hSVGGhzhocc5gXczZrz+tA==
X-Received: by 2002:a17:906:dfd0:b0:6ce:4226:2672 with SMTP id jt16-20020a170906dfd000b006ce42262672mr9181225ejc.141.1645250711043;
        Fri, 18 Feb 2022 22:05:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a29sm9562edm.54.2022.02.18.22.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 22:05:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLIrm-004oQk-0Q;
        Sat, 19 Feb 2022 07:05:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v11 07/13] ls-tree: fix "--name-only" and "--long"
 combined use bug
Date:   Sat, 19 Feb 2022 07:04:39 +0100
References: <cover.1644319434.git.dyroneteng@gmail.com>
 <b22c2dc49ea3aa0ed7d0df367eddc84e931e9e21.1644319434.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b22c2dc49ea3aa0ed7d0df367eddc84e931e9e21.1644319434.git.dyroneteng@gmail.com>
Message-ID: <220219.86iltbe6i2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 08 2022, Teng Long wrote:

> If we execute "git ls-tree" with combined "--name-only" and "--long"
> , only the pathname will be printed, the size is omitted (the original
> discoverer was Peff in [1]).
>
> This commit fix this issue by using `OPT_CMDMODE()` instead to make both
> of them mutually exclusive.
>
> [1] https://public-inbox.org/git/YZK0MKCYAJmG+pSU@coredump.intra.peff.net/
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 9c57a36c8c..32147e75e6 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -120,12 +120,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  			LS_SHOW_TREES),
>  		OPT_SET_INT('z', NULL, &line_termination,
>  			    N_("terminate entries with NUL byte"), 0),
> -		OPT_BIT('l', "long", &ls_options, N_("include object size"),
> -			LS_SHOW_SIZE),
> -		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> -		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> +		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
> +			    LS_SHOW_SIZE),
> +		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
> +			    LS_NAME_ONLY),
> +		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
> +			    LS_NAME_ONLY),
>  		OPT_SET_INT(0, "full-name", &chomp_prefix,
>  			    N_("use full path names"), 0),
>  		OPT_BOOL(0, "full-tree", &full_tree,

This seems like a sensible fix, but let's add a test for it. See:

    git grep 'test_expect_code 129'

For examples.
