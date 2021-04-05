Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CEC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2BA613C7
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhDEULJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbhDEULG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 16:11:06 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D1BC061788
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 13:10:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so12821577qkb.0
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BXfo02k0hcacbMEP34ORuXMEzz6FAHjCfFDS6X5GlT0=;
        b=EoUODkgRo1g8YWQbg9zmSGNS6YoJ+KFsbPTzPdJVdoKTNqVYO0xPnRC89FQxs1sv83
         bU2usTB+05VNdHG1FpCGjAG1Usiss0P2bzwy4aEa6nPvRDIu2/s5p59yzFbBXLzdptBC
         Hd5Z0s6wmRk45yRMcaUCInOyqe/aHVWMw1d/6BOd638AJd384CIMuHqgn9gQ5xm6fa/4
         BPSOAPV/UN0CLnExtQ/xNzRLkt+bR079ECX6DKCoHitB5aUxz2Q/3wttoP4JqCgHEoAo
         aKtmHFiIv/7+b1YdWAVS7TyO3ebP4IyHKH6LiL8s2gHcM4ElRATX0CeJXik0tH9yPdvY
         ZLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BXfo02k0hcacbMEP34ORuXMEzz6FAHjCfFDS6X5GlT0=;
        b=qwdDsLltZ7guQYsoKNqV9hL3ZLRqPnc2KYHS8bZ1kEaRpfX8AxQ+RLqmjcsqf+davc
         IvyCJeWCEsHULvB7apxmhIcfiscQxr0SQmkbhIauNTO8TbxyZjxNF5hNXnnGyWwI8Q5G
         /1p7I1KjRdDh29Nq996hy7whCAGIJRzljd9ruxyL7Y9+WcWGcCY6Ch3Jon+AaBFOgFUP
         BTNkViRn5yokLMUynspErLseUhE9flzjECFU7Bbvoxo7w9Z0BG85T2dnZeGXEFyRB7V3
         3jyn5NkLAWXLMU3RSdYk8JrQS79Z+6g3RsKMnVF+O7VY3LX/jFzzWoVNNdG5F+c/eSyu
         nFfQ==
X-Gm-Message-State: AOAM531eEitiAoYeaQS5v8ixQJkoIJw67aiuLJUS3T8ZGPiUKCH7botB
        nqB1xaIxXZkPJNjW7ovVpe1aOJpQ7FRq9w==
X-Google-Smtp-Source: ABdhPJzur93ybveMkLhwi3BzOIINnu1v1sa2sYHdJgGFE2vvEJgBoQxyOmwgT4oLwHUfAgvD1p3Gtw==
X-Received: by 2002:a05:620a:12f6:: with SMTP id f22mr13193309qkl.3.1617653457603;
        Mon, 05 Apr 2021 13:10:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f9:c820:22ba:fec7? ([2600:1700:e72:80a0:91f9:c820:22ba:fec7])
        by smtp.gmail.com with ESMTPSA id v6sm13581069qkf.132.2021.04.05.13.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 13:10:57 -0700 (PDT)
Subject: Re: TR: [GitHub] Deprecation Notice
To:     Jean-Philippe LEGOUPIL Free <legoupil.jp@free.fr>,
        git@vger.kernel.org
References: <606968f85bfd6_3ff71824384fc@lowworker-78946b45bb-cr8gn.mail>
 <027b01d72a07$3593b810$a0bb2830$@free.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fff8fb90-7995-d364-d54a-037cc1094dd1@gmail.com>
Date:   Mon, 5 Apr 2021 16:10:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <027b01d72a07$3593b810$a0bb2830$@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 6:34 AM, Jean-Philippe LEGOUPIL Free wrote:
> Hello,
> 
> I have installed your version of git on my computer, and setup AndroidStudio with it.
> 
> But I regularly receive now message below from GitHub but I don't know what to do to solve it (the associated link didn't help me...) because AndroidStudio seems to have token (???)
> 
> Can you help me please ?

Hi, JP. This is the Git mailing list, which focuses on
the Git client. Your question regards the GitHub service,
which generally doesn't do support here. However, there
are several GitHub employees who read this list (including
me).

> -----Message d'origine-----
> De : GitHub [mailto:noreply@github.com] 
> Envoyé : dimanche 4 avril 2021 09:21
> À : Philoul
> Objet : [GitHub] Deprecation Notice
> 
> Hi @Philoul,
> 
> You recently used a password to access the repository at Philoul/AndroidAPS with git using git/2.30.0.windows.2.
> 
> Basic authentication using a password to Git is deprecated and will soon no longer work. Visit https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information around suggested workarounds and removal dates.

I'm a bit disappointed that the official post doesn't actually
solve your problem completely. One aspect is that you should work
on enabling two-factor auth through the user settings [1]. The
other side of the equation is that you should authenticate in a
way that doesn't use passwords. The recommended way (from my
perspective) is to install Git-Credential-Manager Core (GCM Core)
available at [2]. This will allow you to automatically authenticate
with GitHub (and Azure Repos and BitBucket) using whatever 2FA you
have set up without needing to generate PATs.

[1] https://github.com/settings/security

[2] https://github.com/microsoft/git-credential-manager-core/releases

Good luck!
-Stolee
