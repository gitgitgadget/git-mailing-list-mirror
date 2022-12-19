Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A7C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLSSZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLSSZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:25:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309E614D
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:25:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id x22so23577885ejs.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7jzgiFu7ZirOWEtnDfUiboBuhyfnbGkcSij4E7A5O/0=;
        b=iELe75RajfhCwfGdmjJHPVfl/XTAvOUD5Tn1HcQRqoisk2pYLGDF3me6WnVnuFXy2Y
         x8sv25wfD+kinXsI+sQaWqyk4OSCoumJH6HE9+IIKrZogB8L4YT5/LuVBc/sj0zC9pMR
         sf3rT5tRAEtVrGYBXdtI2q5FK6OrVlx4roUpw7Y0f855MJqKI/Q/o8JtEVdlt9GRhRZ5
         Wn9K2AseauZuBsUbE57h8b0Sg12iPGmRthCQHLO/E2lR/CpmmuANL42+CVBODsC7Ozbr
         oLJ3LWnQfvgJcrHvqaFC+HQr9mSE4fjmH4Fm2x127SGUIlYE8sR5ugxeF0mcQ2FfRCeo
         zTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jzgiFu7ZirOWEtnDfUiboBuhyfnbGkcSij4E7A5O/0=;
        b=orDEvt08nZkhN85lRYJ8dv5Hpg9Vzrc6Eqlzlc/LnnuUIkuiJBr5kribXTFekE2GGb
         bdZlK3gNmhpOVoGTcbWO7s4AOFq9Cl+tOWVbNdARLL8IigCo2Z46BkUrVv5pdrqx5yY+
         DX+aPN/yM4qXaQgA5Hbqcjhw6Ul+h31a56yr7ue6dclZLH2A2tH87d8eRqifjhAh3Ov4
         pYTfUkz/g9izLKsjXM75xsHbiOekah6JjlOGzJgM9MQaSNv9vVyI0rFlhJ7XAXeA0Y0V
         2ifWMVpFFwqnBFx4c3RX4fXljBhEeLPkpxj8zsSEKbbFQvQFYN8mZnWHDyAG/Vxo1nUu
         qmFw==
X-Gm-Message-State: ANoB5pmLOBKCZ28eLeKWb87GkTkMcqpDE29hGP60ckAPNE8kuoHVrpM3
        H9+DZWcdVBbpf3DV9YQnzovqPOj7i/9ESQ==
X-Google-Smtp-Source: AA0mqf4VsNnusR57IKe/hDugMu2tgF59zvCkWR4SdlNoXF6A1PEU2Jv1i7spISoH/uCxZKciSbTMMw==
X-Received: by 2002:a17:907:760e:b0:7c1:49e:6e3b with SMTP id jx14-20020a170907760e00b007c1049e6e3bmr34922155ejc.68.1671474324134;
        Mon, 19 Dec 2022 10:25:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709061ba200b0081bfd407ad0sm2039731ejg.135.2022.12.19.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:25:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7KpH-006hjq-0y;
        Mon, 19 Dec 2022 19:25:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] win32: ensure len does not cause any overreads
Date:   Mon, 19 Dec 2022 19:19:42 +0100
References: <pull.1404.git.git.1671470222521.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1404.git.git.1671470222521.gitgitgadget@gmail.com>
Message-ID: <221219.86v8m7xncc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Rose via GitGitGadget wrote:

> From: Seija Kijin <doremylover123@gmail.com>
>
> Check to make sure len is always less than MAX_PATH,
> otherwise an overread will occur, which is
> undefined behavior.
>
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>     win32: ensure len does not cause any overreads
>     
>     Check to make sure len is always less than MAX_PATH, otherwise an
>     overread will occur, which is undefined behavior.
>     
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1404%2FAtariDreams%2Foverread-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1404/AtariDreams/overread-v1
> Pull-Request: https://github.com/git/git/pull/1404
>
>  compat/win32/dirent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
> index 52420ec7d4d..0c1bdccdd58 100644
> --- a/compat/win32/dirent.c
> +++ b/compat/win32/dirent.c
> @@ -27,7 +27,7 @@ DIR *opendir(const char *name)
>  	DIR *dir;
>  
>  	/* convert name to UTF-16 and check length < MAX_PATH */
> -	if ((len = xutftowcs_path(pattern, name)) < 0)
> +	if ((len = xutftowcs_path(pattern, name)) < 0 || len > MAX_PATH)

We tend to avoid assignments in "if", I think before this change it
could have passed, but now that we have a more complex expression it's
worth splitting it out. So, we can just move it up to when "int" is declared:
	
	diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
	index 52420ec7d4d..bf371cc9714 100644
	--- a/compat/win32/dirent.c
	+++ b/compat/win32/dirent.c
	@@ -23,11 +23,11 @@ DIR *opendir(const char *name)
	 	wchar_t pattern[MAX_PATH + 2]; /* + 2 for '/' '*' */
	 	WIN32_FIND_DATAW fdata;
	 	HANDLE h;
	-	int len;
	+	int len = xutftowcs_path(pattern, name);
	 	DIR *dir;
	 
	 	/* convert name to UTF-16 and check length < MAX_PATH */
	-	if ((len = xutftowcs_path(pattern, name)) < 0)
	+	if (len < 0 || len > MAX_PATH)
	 		return NULL;
	 
	 	/* append optional '/' and wildcard '*' */

But that leaves the question of whether this was just omitted from
0217569bb2d (Win32: Unicode file name support (dirent), 2012-01-14) by
mistake?

The comment above the code you're tweaking says we're checking that
"length < MAX_PATH", but as we can see 0217569bb2d dropped that
condition.

So, was that a bug? And if so why is your check for MAX_PATH different
than its check?

Shouldn't yours be (as it did):

	if (len + 2 >= MAX_PATH) {
		errno = ENAMETOOLONG;
		return NULL;
	}

?

Perhaps not, but the commit message should discuss it, i.e. why is the
MAX_PATH check now subtly different than the pre-0217569bb2d one.q
