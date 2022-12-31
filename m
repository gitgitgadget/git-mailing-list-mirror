Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2EC3DA7D
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 02:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiLaCv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiLaCvz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 21:51:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F211450
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 18:51:54 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jn22so23573019plb.13
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 18:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vK5IBaC2nTe0sfHZBlrM3vx4UTvVjKuM5VigaUjW6dE=;
        b=MbPcXDF/lRhuAKKt0wScID9vGvUE2IxxlUoQV9cQfGHG7gub72FU+4mfm5meprLkay
         hSq0rVgD+CgjvT9NJ83jVEDN0eHWg92RJtiOH3Sot93+Rbuohy0tM0gI2bBq47a6PRWp
         s9L+LBha+aU0D6DP2aoY4Ds0puJafZFuv0PP12qQ2+tmNxBJnFUqJLepr70w95yee9Tg
         tQT9mSscYkgw4Z+lTWBMGe2zYMfkHMViU1hsRdEgc2UayJvU2QXxTyNgimAIBYBUT/sC
         RH2te4zwIUFdgBBBwYXh5AIeznJQ2rUdPMl8gfiR0fsQQtVpaORR+2fkIHDM7y/0ZdiG
         CqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK5IBaC2nTe0sfHZBlrM3vx4UTvVjKuM5VigaUjW6dE=;
        b=0ahBln25GTvcFKuQ9OkilJkqhJzbYlOBqcimAReEtcFJxvZN8h6s/OQbYU2HlpTE45
         jqksWV/So8s/BOue7y9zk23EONXJr7yeQ/ApP22dCVzXSLfv0dwLNyDQ2co7AuHbCYwk
         MzuAvyw5jPfgM9WEAKUH0yizPA5AklPmTiGMtIu/4ge+GRP1YUJDEoZaog14pOJkgEwV
         ZREhAUFm3DOyFstT946Kujw6PQ6xwssDAbwIZbDLdEoem1ZvwAZHPhekKgwyeG6maAmy
         LtsX7ewXTWrqmnFMz+wlKPSTRCq3+JYDs1sry3HfeYJTtW2LH7g1nlG6nsEGxnSflZbO
         evqA==
X-Gm-Message-State: AFqh2kr8Vofwjz9C/hItfJGdupSMMntcWr4/HU7cOwm+47rr16wPl+h9
        /rqANmqbopGJwHdJJ4gXLp0=
X-Google-Smtp-Source: AMrXdXvHDjgeLLGyocb5S3DX0WF81yh1wgL3VEjrt6xVcFImVE0Syg9N5iO+vHOTm4BXPTjO3g1Irg==
X-Received: by 2002:a17:902:e845:b0:188:fc0c:b736 with SMTP id t5-20020a170902e84500b00188fc0cb736mr75969550plg.67.1672455114008;
        Fri, 30 Dec 2022 18:51:54 -0800 (PST)
Received: from localhost ([2001:ee0:50c6:a3f0:4a98:acc:5d63:954a])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b0018c990ce7fesm15718626plh.239.2022.12.30.18.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 18:51:53 -0800 (PST)
Date:   Sat, 31 Dec 2022 09:51:50 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] win32: remove return_0 inline function
Message-ID: <Y6+jxkZjBMurBiw5@danh.dev>
References: <pull.1420.git.git.1672453222075.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1420.git.git.1672453222075.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-31 02:20:21+0000, Rose via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> The macro works on its own without the helper function

NACK

>  #define pthread_mutex_t CRITICAL_SECTION
>  
> -static inline int return_0(int i) {
> -	return 0;
> +static inline int return_i(int i) {
> +	return i;
>  }
> -#define pthread_mutex_init(a,b) return_0((InitializeCriticalSection((a)), 0))
> +#define pthread_mutex_init(a,b) return_i((InitializeCriticalSection((a)), 0))

This change does nothing and harmless in its own.

>  #define pthread_mutex_destroy(a) DeleteCriticalSection((a))
>  #define pthread_mutex_lock EnterCriticalSection
>  #define pthread_mutex_unlock LeaveCriticalSection
> @@ -36,7 +36,7 @@ typedef int pthread_mutexattr_t;
>  
>  #define pthread_cond_init(a,b) InitializeConditionVariable((a))
>  #define pthread_cond_destroy(a) do {} while (0)
> -#define pthread_cond_wait(a,b) return_0(SleepConditionVariableCS((a), (b), INFINITE))
> +#define pthread_cond_wait(a,b) SleepConditionVariableCS((a), (b), INFINITE)

But this is not,
pthread_cond_wait return 0 on success, otherwise error number.
SleepConditionVariableCS return non-zero on success, 0 on failure.

IOW, this change is broken on Windows.

-- 
Danh
