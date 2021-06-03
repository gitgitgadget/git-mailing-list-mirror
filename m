Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8B1C4708F
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D1F613EE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFCC40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:56:26 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:33632 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCC40 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:56:26 -0400
Received: by mail-yb1-f202.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so5944471ybp.0
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=82M82ff1if8iqNj5C+O24nv61ShxU94JyThwu9PWU6Y=;
        b=ZJEw+LWdS7imnC8JenkjQNaNWb/YLUy+6WRgbHWnnBO1Fg+tX9+FIoKaUr6upPHgQg
         gUkej6+IwcxRhzp5Zx7rkV+j4LkK+D1S3RC7vpKMGayMXC8pnpB0uEynjstA/RAG5E1A
         qw0xiNOSjsjFV/z89R4+3UGhx1Am6tbdwRNSFtEg29J+WFh9R/iKCO19E16aioOs+UbR
         gBWKuSVrzdr+RH+gioUDqcF7ELYe8YeBMA+L64PwvcgXAC0MlmxpIfFSExfGRttrTk+0
         kbRKhHRdf9ihdzvtNsa20YVI6/nUgth8ES5TMn+EEoZe9Zl93d4GixSba65Rxdk33qcD
         Bmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=82M82ff1if8iqNj5C+O24nv61ShxU94JyThwu9PWU6Y=;
        b=aNEdWXfbjJjjfWZmp1Bob5SS0H7J1ncKTCeVrsk7hTAYO5EAAdC/1VeUTsWRJY6eHz
         SV4brPmfvzCU5bXGrGD4OZJqGOlOH7H3mm6kvDapYoqXNIW5+lpX8E2ycMpBmU7Wp7oM
         obVa8LBVUZDmoPKI0eJZMXDvOa7LPSSkXUa3YaY4kFQg7vN6Q0XOCZzvGThwzEprjg2g
         jitc5dF92Bjuv7bSIhZh5zMAzWfuDFcQgYgsL9mm2NmB+mpTITXoBjQrSer40Pq4+GFV
         nforGUfel723oLBqpuf0/27odos9/1iBCECkiY7Cl4DJzQh9CoBlobOBBJTLZkpEgYDC
         zPIg==
X-Gm-Message-State: AOAM531P2D563dw9kVuI9Ji0YzeitVbPuoiVKR023ffiBf/QWGtRs18z
        ypZKo3AygDtyMNNxAUK0wd5IMJEWGs3dfTeBHxxU
X-Google-Smtp-Source: ABdhPJwASuseyAMPEaZhbsgFlR1uUxu04bfX2AyTClbO6skmqHn5wLXXWdweY8FsSIX1E+yHOOJR6/DeBTdtlyHtUf4H
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:489:: with SMTP id
 n9mr50982092ybp.45.1622688822414; Wed, 02 Jun 2021 19:53:42 -0700 (PDT)
Date:   Wed,  2 Jun 2021 19:53:40 -0700
In-Reply-To: <1bb350ea5d21eacf95426192c89173b502b7e06a.1619710329.git.gitgitgadget@gmail.com>
Message-Id: <20210603025340.349224-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <1bb350ea5d21eacf95426192c89173b502b7e06a.1619710329.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH 6/8] refs: clear errno return in refs_resolve_ref_unsafe()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1685,10 +1685,11 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  }
>  
>  /* This function needs to return a meaningful errno on failure */
> -const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> -				    const char *refname,
> -				    int resolve_flags,
> -				    struct object_id *oid, int *flags)
> +static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
> +						 const char *refname,
> +						 int resolve_flags,
> +						 struct object_id *oid,
> +						 int *flags)

So a third function (refs_resolve_ref_unsafe_errno() - not to be
confused with refs_resolve_ref_unsafe_with_errno(), which has an extra
"with")? Couldn't we just swap the other 2 functions directly instead of
going through this intermediary?

> +const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
> +				    int resolve_flags, struct object_id *oid,
> +				    int *flags)
> +{
> +	const char *result = refs_resolve_ref_unsafe_errno(
> +		refs, refname, resolve_flags, oid, flags);
> +	errno = 0;
> +	return result;
> +}

This is the errno = 0 part that I was talking about in my review of patch 4.
