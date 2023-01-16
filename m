Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8EEC677F1
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 16:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjAPQJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 11:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjAPQIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 11:08:20 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF67193E8
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 08:05:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c6so30773779pls.4
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTodSUqIWtApkBU7Jb+mnOjT3rtdgJa5in7doqt7nQU=;
        b=jC92JHdKv1/GkNtW9J7+87WRHZIMKT5JcSVPewp58iH8aXsVZq4BbhIOQqH/DRzxx3
         JYZDRmrJUFq4rJFy0UEzZNrt141FczVcHysT3TkUDRJrIXX/mhzU2WY+tihfzIsKtCcB
         jMTai2uz3UKtTtpYimf//2/gQ2c4wcXPS/irjDt90xfe4bnThjdMlNcQ9nQ3Hs+WreBN
         /ik0syXnq7Be6rveEtYFISXPLel1JgGT3IwsDFAv8EfIEQCDI9fYN6GPm6PSIr2AhS07
         MliTS0yVUC7RJ7zsBWPPvQWPqBJapUSE4V5pC5/f/4Iq6VRVw+t5gicH3O3iPwlsDFR8
         Yjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTodSUqIWtApkBU7Jb+mnOjT3rtdgJa5in7doqt7nQU=;
        b=whyJ1VNyuGcqwJmkoCb1kEyPGVvIUrgafimC99htL9VWF0U+8NoeALr1OMCLdHngqN
         eOxh1H8/XfJ54+npoZyQHArXa7LKWSnTOCEEmgPMpixvdzy/9X3VG+1LIPEfuasT9SJy
         bIVPomBha9AJ6cdjOJKdEiTEt4zrCuXlz0WhACXeQOEnNXVqmDxF4+bsazapxCd1yyF0
         OzB5yT5Ywb1mpH9YopllAn9S4YIV4/Ex6pquI4Vcm+ErehmiZUQP8pXsQVnzC5B6pctY
         XPu+bhtPw/tUagO94qVxnitWc2zD7sUgOOZAXA3IC3/4K/ONsAw74rkZfrrj9MhuD1fL
         FBNA==
X-Gm-Message-State: AFqh2kpSiAFIkovHuQ5KBZQybfRRRr/TPb06M5dmjAfIib12K/3wvgEa
        gCIfbGLAv5qIT18LxQgzgtM=
X-Google-Smtp-Source: AMrXdXt6w08wh0X3vet1ruStam73CaeC25bKl0zFu5a62QpDG1mo5nMRIYvIg9j/LtACdGFMkLJtGw==
X-Received: by 2002:a17:902:eb8b:b0:194:6103:1e18 with SMTP id q11-20020a170902eb8b00b0019461031e18mr178255plg.65.1673885157465;
        Mon, 16 Jan 2023 08:05:57 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00182a9c27acfsm19494233plm.227.2023.01.16.08.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:05:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 3/3] http: support CURLOPT_PROTOCOLS_STR
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
        <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
        <230116.86edruzk5m.gmgdl@evledraar.gmail.com>
Date:   Mon, 16 Jan 2023 08:05:56 -0800
In-Reply-To: <230116.86edruzk5m.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 16 Jan 2023 14:06:50 +0100")
Message-ID: <xmqqzgaicvmj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> +#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR (LIBCURL_VERSION_NUM >= 0x075500)
> +#if GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
> +#define GIT_CURLOPT_REDIR_PROTOCOLS_STR CURLOPT_REDIR_PROTOCOLS_STR 
> +#define GIT_CURLOPT_PROTOCOLS_STR CURLOPT_PROTOCOLS_STR
> +#else
> +#define GIT_CURLOPT_REDIR_PROTOCOLS_STR 0
> +#define GIT_CURLOPT_PROTOCOLS_STR 0
>  #endif

I find it a bit ugly that CURLOPT_* being used are all non-zero, but
it may be true in practice.

> diff --git a/http.c b/http.c
> index e529ebc993d..3224e897f02 100644
> --- a/http.c
> +++ b/http.c
> @@ -933,24 +933,22 @@ static CURL *get_curl_handle(void)
>  	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
>  	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
>  
> -#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
> -	{
> +	if (GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR) {
>  		struct strbuf buf = STRBUF_INIT;
> ...
> +	} else {
> +		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> +				 get_curl_allowed_protocols(0, NULL));
> +		curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> +				 get_curl_allowed_protocols(-1, NULL));
>  	}
> -#else
> -	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> -			 get_curl_allowed_protocols(0, NULL));
> -	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> -			 get_curl_allowed_protocols(-1, NULL));
> -#endif

I somehow find the above over-engineered solution looking for a
problem.  Conditional compilation might be ugly, but what is uglier
is a conditional compilation hidden behind what pretends to be a
runtime conditional but gets optimized away at compile time.  Also,
when the non _STR variant changes status from deprecated to removed,
the code will cease to build, so I am not sure if the above is the
whole story.  You'd also need dummy definitions for them when the
version of cURL is advanced enough.

It is true that with the above we will always pass both sides to the
compiler, which may be an upside, but at the same time doesn't it
make it harder to notice and remove the support of the older side
once the time comes?

Thanks.
