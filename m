Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834B81F453
	for <e@80x24.org>; Fri, 25 Jan 2019 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfAYVgU (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 16:36:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56007 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVgU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 16:36:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so8045283wmc.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 13:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fZOzCvbi6PPz+/GongQtlFStMLr9kcHfW19v/PBDFIY=;
        b=H0OMRRaAArA3WcVHUnxkgx/FKAkfQWhGSunWzbBbaCF+XmXZrDx6LiZzyFingfDrCN
         Z9z2bW7Ll6HkAft4W5LEnssdazfUnKArzV/1zkl/Bfzpk8bTf99d5sY2hLCpdOJYAx13
         RYkmdFRp1ftzrxmgZhcDGgUaDSv6M9Y2qQrutmGwhdTwL0uTSI3N4Je4THzzdpA6K+Eq
         Jw7pjJZdKaPInnjppjZlQvlcZNSLw1Nadic95jeOWMGTq5E4phWT2iqGqTdLeOgaBRjp
         UgCSN3J2A7qtEHMinRardHj6t6HNPG/R9V8HPLKiyhLhwfD55vh69lZMjhFDjswdV4px
         i+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fZOzCvbi6PPz+/GongQtlFStMLr9kcHfW19v/PBDFIY=;
        b=adtp6HJkx+CkjlB+G/g3/0BPMRm035SkwefKC76uzL/9JnIV1sKzucSHaYKCdTpx4h
         K7qZVjVXL//LtXjewADkFaUnllyS79lSN1ec/JIm6B2FKtLvdzy/KLBF4c9zPrkI57cb
         /d5h+hzRFdiSW3JxKe7FdDb5b8odWM6kAY5SLJIMOQjvTK8R9S7ClTfAEMGBQ07gTOet
         LyiM5WOdAYg0wRk9h6OUZkdqX11NneDwKMvTw8LyxdMdb2SiM7mEA+RNkizsrxerBmGt
         eV/dyAtF3so0Os/dSrS8incgME0n9b9/a7Fz55fyFGcd29AqZLQWd0JkExtISBd9dEju
         ceQA==
X-Gm-Message-State: AJcUukctMdzx8vKiuTF9xjy/LIelYcI/O0jwbLB28LFzDGXWYe6mulek
        QTQiyQ4KbkKNf0OyKHc+wDA=
X-Google-Smtp-Source: ALg8bN6XzAMk6kknl6mu6R2sjOCD03m72sX1SH77jffb2Qwn+FiCLtEEa0x4XK36x8XsNsqOeW3+Qw==
X-Received: by 2002:a1c:4855:: with SMTP id v82mr8355360wma.15.1548452178224;
        Fri, 25 Jan 2019 13:36:18 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o5sm119578002wmg.25.2019.01.25.13.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 13:36:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: prefer suffix substitution in compact fetch.output
References: <20190125095122.28719-1-pclouds@gmail.com>
Date:   Fri, 25 Jan 2019 13:36:17 -0800
In-Reply-To: <20190125095122.28719-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 25 Jan 2019 16:51:22 +0700")
Message-ID: <xmqqef90fmi6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> I have a remote named "jch" and it has a branch with the same name. And
> fetch.output is set to "compact". Fetching this remote looks like this
>
>  From https://github.com/gitster/git
>   + eb7fd39f6b...835363af2f jch                -> */jch  (forced update)
>     6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
>   * [new branch]            nd/diff-parseopt   -> jch/*
>   * [new branch]            nd/the-index-final -> jch/*
>
> Notice that the local side of branch jch starts with "*" instead of
> ending with it like the rest. It's not exactly wrong. It just looks
> weird.
>
> This patch changes the find-and-replace code a bit to try finding prefix
> first before falling back to strstr() which finds a substring from left
> to right. Now we have something less OCD
>
>  From https://github.com/gitster/git
>   + eb7fd39f6b...835363af2f jch                -> jch/*  (forced update)
>     6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
>   * [new branch]            nd/diff-parseopt   -> jch/*
>   * [new branch]            nd/the-index-final -> jch/*

Sounds good.  I do not think strstr() would ever be correct in this
application in the first place.  In what situation would it produce
a reasonable result, I wonder?

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/fetch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e0140327aa..e0173f8a33 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -629,9 +629,14 @@ static int find_and_replace(struct strbuf *haystack,
>  			    const char *needle,
>  			    const char *placeholder)
>  {
> -	const char *p = strstr(haystack->buf, needle);
> +	const char *p = NULL;
>  	int plen, nlen;
>  
> +	nlen = strlen(needle);
> +	if (ends_with(haystack->buf, needle))
> +		p = haystack->buf + haystack->len - nlen;
> +	else
> +		p = strstr(haystack->buf, needle);
>  	if (!p)
>  		return 0;
>  
> @@ -639,7 +644,6 @@ static int find_and_replace(struct strbuf *haystack,
>  		return 0;
>  
>  	plen = strlen(p);
> -	nlen = strlen(needle);
>  	if (plen > nlen && p[nlen] != '/')
>  		return 0;
