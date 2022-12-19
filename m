Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB35C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 20:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiLSUhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiLSUhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 15:37:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0056343
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 12:37:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i7so9854137wrv.8
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 12:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/PkA/EVkuraXmCY9SUjUuSFO3K669oeI4Iy42P4wzl0=;
        b=ZTqcgcSX2bM3DHfnu5eK5rCIYdVwonFbHVsznerYIO6PgBkf3HNw5/xLNi5LHL01lt
         lilRP5o0pyjo8Nj9lumbdaN3GsVcNPxdngCBHCGama8uojxGQyem14TwfXuq12o1rtFL
         qqwSctgU+gm13C3jLY7tWK/u8kz3zQNEVmLVt1Z7CTSEqsk0YQQ44dyREUc4mWCGKY49
         WfmXnXz0tXOWmovBb20TgL91SdV6yAEbYcCJvJHTlVXONd4FtYatQ5K+2X2tLEgUgvkq
         c6J+iFHKKB2n0OSHcAsa1egfAJjCqXWl2J9M2iUrrw+UA1WujRJIp1MAbNShKqBpL9F6
         gaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PkA/EVkuraXmCY9SUjUuSFO3K669oeI4Iy42P4wzl0=;
        b=Xu8sBShCfZ+Zh7di8icktyA9Qa2PM1IyYb+lk4QFDhIywNdtuVPMqN6pzRNvsDxfEE
         rNozlKCwpzdcV4ENL4PyZTv77SjkOj5QpBDBN3Iw1XZFKTinmHCLADGxErEj5WllWBVB
         pm848B75kO7mXZPacXFoEPrBYEGaDwiEzoE18g1f4ZHz8TfbY6UCklRnzEMU1OBEHWwC
         rfHkvrHhBQqQVDrOiA0oooPaTZo7NS5JGxbbCaOoadvWuSQ8IzCbmhjNomdkcaUfv2gC
         u7uJ5AyXGFdQMOEKq/acloZYoT0YCmmJz0VT0FrrGWZrM6qdXilwGiI+oqBFJ9FYtXjE
         SslA==
X-Gm-Message-State: ANoB5pmnSPvzWFRKKeOaOuHdCz5Kd45oqK/sTCeZiAhn8f/6d7D34HuU
        9YTH6oCzGs4ZdFaWN4zVYXo=
X-Google-Smtp-Source: AA0mqf5RoHj9th1hAzUUduR3joDMM2q9PEaaS5/WI+LDa1ddaNUkERs+2R7MKBghAv7NcYzq7gcdCA==
X-Received: by 2002:a05:6000:83:b0:242:fd7:285f with SMTP id m3-20020a056000008300b002420fd7285fmr26740063wrx.45.1671482230358;
        Mon, 19 Dec 2022 12:37:10 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id w4-20020adfec44000000b00241dd5de644sm10858821wrn.97.2022.12.19.12.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 12:37:10 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <dd47cbd0-35a6-1009-26e8-6a281224436d@dunelm.org.uk>
Date:   Mon, 19 Dec 2022 20:37:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] win32: ensure len does not cause any overreads
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1404.git.git.1671470222521.gitgitgadget@gmail.com>
In-Reply-To: <pull.1404.git.git.1671470222521.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/12/2022 17:17, Rose via GitGitGadget wrote:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> Check to make sure len is always less than MAX_PATH,
> otherwise an overread will occur, which is
> undefined behavior.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>      win32: ensure len does not cause any overreads
>      
>      Check to make sure len is always less than MAX_PATH, otherwise an
>      overread will occur, which is undefined behavior.
>      
>      Signed-off-by: Seija Kijin doremylover123@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1404%2FAtariDreams%2Foverread-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1404/AtariDreams/overread-v1
> Pull-Request: https://github.com/git/git/pull/1404
> 
>   compat/win32/dirent.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
> index 52420ec7d4d..0c1bdccdd58 100644
> --- a/compat/win32/dirent.c
> +++ b/compat/win32/dirent.c
> @@ -27,7 +27,7 @@ DIR *opendir(const char *name)
>   	DIR *dir;
>   
>   	/* convert name to UTF-16 and check length < MAX_PATH */
> -	if ((len = xutftowcs_path(pattern, name)) < 0)
> +	if ((len = xutftowcs_path(pattern, name)) < 0 || len > MAX_PATH)

The documentation for xutftowcs_path() says

/**
  * Simplified file system specific variant of xutftowcsn, assumes output
  * buffer size is MAX_PATH wide chars and input string is \0-terminated,
  * fails with ENAMETOOLONG if input string is too long.
  */

Looking at the implementation it seems it does check the length so I 
don't think we need this change. I haven't looked into why 0217569bb2d 
(Win32: Unicode file name support (dirent), 2012-01-14) changed the 
length check from "len + 2 >= MAX_PATH" though.

Best Wishes

Phillip

>   		return NULL;
>   
>   	/* append optional '/' and wildcard '*' */
> 
> base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
