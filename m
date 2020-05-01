Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA487C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA90208D6
	for <git@archiver.kernel.org>; Fri,  1 May 2020 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp9YV/+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgEAMxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728443AbgEAMxM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 08:53:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DE5C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 05:53:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so2313736pju.2
        for <git@vger.kernel.org>; Fri, 01 May 2020 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zTftP4ZxwRDAj3HtbvYRFVidt6n5/IUny2WyG8zZSz8=;
        b=Gp9YV/+Dk2+OQweUVHfXJT4vo9bV8rJ1dKmFPRbItybeY3luiD8Wstz3idC0dBjU5E
         lkF/1MYN9QnM+IP+KvYJrZkZlDwQthv9PfD3d4BgUkeXGFjMazWVN5gGnYa1BtyFsxmb
         Z+i6F/Zhhq17TAUBnVU9l7Sq3pJjA2LgiTa5Mw9syTi+BuqLLYEKjzxuNRQIxYJY0TaK
         UIXZllQ0t0YK5E9kJtc4EoLNHam1zEerBfhE5HQQhBTnP8tEYnItcMzy1235niI0vRjI
         wGkWJ+dOmZRAQH1RYg6w7X+OnLVMT5nsYisduJ0RjKD9hCLfUVSolfFZNy7NyavOaDlx
         pujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTftP4ZxwRDAj3HtbvYRFVidt6n5/IUny2WyG8zZSz8=;
        b=VwOEb02bPwuCQV/Z22ld8cuHlEOYBEdHC2G6kh0u+03cAT3YCwrSEYY61nr9umSF3R
         MZLmjDFl8PeLWIxNjC3RPeFTzDa96evSt3rCN81HBClX2wPDoz4Lu2KaorLI02zBsVuw
         YYT2GyKjFpEcS73kTHKWToPIrLGfqfkEEbU9K52lFiSOBcSuB1ux7XIH+iDOsu9sOB+K
         6GaeZDX8vEjW18uEphX1rfJZ8YgSpWsgXlb9Or7HDo3FwxGj7BxGW9k1ynUdcr3WzKL4
         GuiHEgo2SZBwU2NwZw7fn22YwViosGqfR4BjmtZNQ+wsHUXACtR++IbL27F1gwXqCtjJ
         4Cyw==
X-Gm-Message-State: AGi0PuZVkdbSgCOSznxp8pGsUMS6gr5nueZQu8n51XOAfXLx2o6lACF1
        Cfm1PcBGtWPMcMebYvZe5O8=
X-Google-Smtp-Source: APiQypIoWObZC2AhhABWz+c8RNxNn4iKyp6lT8++IMBy21aBwgXUTs5/NC3d2cQ3q+9WZYc2xjVyKw==
X-Received: by 2002:a17:90a:68cb:: with SMTP id q11mr4666658pjj.15.1588337591163;
        Fri, 01 May 2020 05:53:11 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x195sm2350729pfc.0.2020.05.01.05.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 05:53:10 -0700 (PDT)
Date:   Fri, 1 May 2020 05:53:08 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     git@vger.kernel.org, Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
Message-ID: <20200501125308.GE33264@Carlos-MBP>
References: <20200501105131.297457-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501105131.297457-1-leobras.c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 07:51:31AM -0300, Leonardo Bras wrote:
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 0a69810147..8e9da5ed64 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -203,8 +203,9 @@ independently of `--smtp-user`
>  Furthermore, passwords need not be specified in configuration files
>  or on the command line. If a username has been specified (with
>  `--smtp-user` or a `sendemail.smtpUser`), but no password has been
> -specified (with `--smtp-pass` or `sendemail.smtpPass`), then
> -a password is obtained using 'git-credential'.
> +specified (with `--smtp-pass` or `sendemail.smtpPass`, or as an output
> +of `sendemail.smtpPassCmd`), then a password is obtained using
> +'git-credential'.

this last part on git credential is just undocumented, since it is already
doing so since 4d31a44a08 (git-send-email: use git credential to obtain
password, 2013-02-12)
 
and of course, assuming you use a credential helper that keeps the password
encrypted you could use that instead of this new feature.

having said that, this looks like a good alternative, but might need to
make sure if die makes sense below or would be better to see if you can
still get a password through git credential even if that fails.

maybe the rule of what to do might even need some configuration itself.

Carlo
