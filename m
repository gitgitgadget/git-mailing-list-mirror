Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D851C00144
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 02:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiHBC0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 22:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHBC0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 22:26:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A44229CB5
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 19:26:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f22so4924652edc.7
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=bvUQhvWYx30fpbTzKjAtcpnWPAIuX1MuYKMfXosoPyw=;
        b=dPYqLdYxutpsYRowOnlnxxb129KFyK1pP0S7WcHFvx6ZeyXyuVV4FtGk1irtDd28ZI
         icB8G6mBwz9RfqQU96WnktmD5y6r2MS4uMyT8rNVmGZyp/nx3r2b0VGBn7Wz7i+81IWZ
         2JKA+tTSksufEaEztZZ84240ENukkkUvZeltQYXuuwpIJMWqBjQK2zfTM0y37Dgr0Cu0
         5EqVZ/22XH7EjJGaR//Xk6uoZcl+MFM8KB2i4fPRqm57GIMNzsTmujH1KkWCH4GDjSbg
         GD0cwxGyCl2f7sLYvdjjkxnSYv57+E9gC5N5y62pbO8g0jXGW0hWecVA8ypRDSFfuceW
         xrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bvUQhvWYx30fpbTzKjAtcpnWPAIuX1MuYKMfXosoPyw=;
        b=C0OCIeFaLjkn14g2K/KeSwUgUA3LP9467slbvkGpLEtDjKiaOUDM8SmnGDB5VgxGGe
         EyY0U0PKQdaXK8eLID6E76N3ausFvUR7PO5/NIiUYG/eJ6aLDUxMZo406d37wi2Ptr1n
         JTuuUMopPbINQlE65sBI/c/YjIW64N4zls56jombQrH7L8AYXl/0u40Xv3EovfHO4v92
         hUSpYMr75NgGFmHatPKGYBKEruIyqM+VrwXhmrzgEBtodk3sHl63BWNeGX7t7nLcIfty
         3z8BI6dQjaOnP54hSDF0Dgq5Ouhvv4R6+prdBqzgDDV3hs9g9mQFuyEwZRmO8lyA5GED
         dsNg==
X-Gm-Message-State: AJIora+xQnmm/Esb0FOKKPu1i7I0xF3cwG/aJ9HJCwQKvkARkUsgy8Kp
        eQROXRQ5uiWxhCCpL3Tg2zY=
X-Google-Smtp-Source: AGRyM1vXmvEU+LoHPkiFvkIUPw3piqSY7UNSPZ5EbO2fKkngU6rddsJoLk/noARDz0c2q9D/XT+9qw==
X-Received: by 2002:a05:6402:e93:b0:43b:6a49:7e88 with SMTP id h19-20020a0564020e9300b0043b6a497e88mr18862691eda.132.1659407205897;
        Mon, 01 Aug 2022 19:26:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i26-20020a50fc1a000000b0043cf1c6bb10sm7519006edr.25.2022.08.01.19.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 19:26:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oIhcK-009AlT-2F;
        Tue, 02 Aug 2022 04:26:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/7] builtin/bugreport.c: create '--diagnose' option
Date:   Tue, 02 Aug 2022 04:17:52 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <932dc8cddacf1841996cd3e0d512b95828213015.1659388498.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <932dc8cddacf1841996cd3e0d512b95828213015.1659388498.git.gitgitgadget@gmail.com>
Message-ID: <220802.86edxzgz2z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 01 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
> [...]
>  Documentation/git-bugreport.txt |  11 +-
>  builtin/bugreport.c             | 282 +++++++++++++++++++++++++++++++-
>  t/t0091-bugreport.sh            |  20 +++
>  3 files changed, 309 insertions(+), 4 deletions(-)
> [...]

Maybe it's not easy in this case, but I wonder if this series can't be
re-arranged in a way that more directly benefits from the diff move
detection.

E.g. if we moved the unchanged functions to a new repo-disk-usage.c or
something we could have an intermediate step of having both use that,
and then going forward would work towards a better lib/built-in
split-up...

> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -8,7 +8,7 @@ git-bugreport - Collect information for user to file a bug report
>  SYNOPSIS
>  --------
>  [verse]
> -'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
> +'git bugreport' [<options>]
> [...]
>  static const char * const bugreport_usage[] = {
> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
> +	N_("git bugreport [<options>]"),
>  	NULL
>  };

We have some built-ins that punt on re-listing the synopsis in the -h
output, but we always list the full usage in the SYNOPSIS.

I think both of these hunks should be dropped, instead we should
(presumably) add a "git bugreport --diagnose" to this, and if it
combines (or not) with other options, let's update both accordingly.

> [...]
> +	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
>

Is the "scalar-diagnose" here a mistake?
