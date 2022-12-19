Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD4C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiLSSi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiLSShx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:37:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876A1704C
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:35:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m21so3697074edc.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClU0jF00fl75+g37wZ79wAtJP9th/0Tl+z9FHN+6Xfg=;
        b=XoYdo45fcq4e7sFdFML0YS0TL1BSoolPox+HzyaxhupexeDPuLH1ywZ1tK14gxiHp1
         jSZ7fTbaIQSlO0Y6u72lwvUEzicx6XK26Pwc0LreT3UPj42ipMn+IHxeTYEvlVtoVE5U
         qv6oIoOtvDeFG0/loA4Y44XF8jdxCtSXOdfpzveEMpRkpY+NVgwwv+k6o/e0dC3AWSRY
         luKiosDwY5dPSjzq3xOeqr3uXJxFC6TC5ccTV3goVH7fpE+mlpI4PdCdGtiwQytymEbU
         rGfS6CGaRkyHCL3V8dAUVVcx4mG6TuRmf5HfpE2aGpSiFK37R3Lcb3+XoorsoEv78saq
         Qa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClU0jF00fl75+g37wZ79wAtJP9th/0Tl+z9FHN+6Xfg=;
        b=FBXLBg8WJIKgZpdtdOCqIJ0YE5tkn/iAqbp3u9tSpwtO3OHv7HExDqwGOtaf4YEx50
         0HcSmYUljcW6HCrl51J8wrGuoyjHSSo6u7bgetKyHwP9zaCAM7Wdf/Gxbz06HAICW/6t
         JgaWNK/psXlnwMsRpvMA/tSWsGrE1kXzQ12bmbRMi8bsVT4773jt72WxZtkF6l5SkQFp
         ZkzyO3JDz5yBut1WM1XY7eR9Qw6e4F+jRNVPngVJ33smsWvn7NK+OsiY6Z6x4vcYF8fw
         g3vz9hBI4M6GuVJ6U3zinpb/HpiuU3iL6LeRLk13CaY0rqbMDkGu2XJ/5fG9OpEoHPRf
         shyA==
X-Gm-Message-State: ANoB5pkfbmIn5Xvjnzstr9+Mly9iz6vVR9/1CPGbQ6ZSVicWIOnChdlc
        BgS9Y+jfD5GI4KJPyb4dV7Ag882IxzAXPA==
X-Google-Smtp-Source: AA0mqf7PCLdJ+yv5/mWt3OxJn9oFKGBPt2iIJA1ipjff5ObjHqXQ3ZBhorUYujULxmCIzgNgZVq3Yw==
X-Received: by 2002:aa7:d2d6:0:b0:46b:34a:3945 with SMTP id k22-20020aa7d2d6000000b0046b034a3945mr34526479edr.31.1671474899251;
        Mon, 19 Dec 2022 10:34:59 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id z7-20020aa7d407000000b0046b531fcf9fsm4708302edq.59.2022.12.19.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:34:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7KyY-006iCT-1Z;
        Mon, 19 Dec 2022 19:34:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Explicitly set errno to ENOENT if err is not
 ERROR_DIRECTORY
Date:   Mon, 19 Dec 2022 19:33:52 +0100
References: <pull.1402.git.git.1671465108414.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1402.git.git.1671465108414.gitgitgadget@gmail.com>
Message-ID: <221219.86mt7jxmwd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Rose via GitGitGadget wrote:

> From: Seija Kijin <doremylover123@gmail.com>
>
> At this point, the only two possible errors are
> ERROR_DIRECTORY or ERROR_BAD_PATHNAME.
>
> This code clarifies this and also saves a call to
> err_win_to_posix.
>
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>     Explicitly set errno to ENOENT if err is not ERROR_DIRECTORY
>     
>     At this point, the only two possible errors are ERROR_DIRECTORY or
>     ERROR_BAD_PATHNAME.
>     
>     This code clarifies this and also saves a call to err_win_to_posix.
>     
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1402%2FAtariDreams%2Fopendir-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1402/AtariDreams/opendir-v1
> Pull-Request: https://github.com/git/git/pull/1402
>
>  compat/win32/dirent.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
> index 52420ec7d4d..8f94a5ab6db 100644
> --- a/compat/win32/dirent.c
> +++ b/compat/win32/dirent.c
> @@ -34,13 +34,13 @@ DIR *opendir(const char *name)
>  	if (len && !is_dir_sep(pattern[len - 1]))
>  		pattern[len++] = '/';
>  	pattern[len++] = '*';
> -	pattern[len] = 0;
> +	pattern[len] = '\0';

Maybe the subject of this patch is a good change (I have no idea, and
don't use Windows), but this just seems like unrelated general cleanup.

I think it's probably good to change these sorts cases from 0 to '\0',
but let's do that as a seperate change...
