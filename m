Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC29C433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiAIIOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 03:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiAIIOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jan 2022 03:14:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48CC06173F
        for <git@vger.kernel.org>; Sun,  9 Jan 2022 00:14:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so18816970pjf.3
        for <git@vger.kernel.org>; Sun, 09 Jan 2022 00:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MBQXwuC2b0LnweVIBbVBAEiIe5a5GoEYkznuOyk0xnU=;
        b=mJB/yHRazmKM+nt7tTr+MgGVM5jPK1d9JXE+IaJuOSrFRuS/nc/+TZC0RtEIuwjwe5
         4uZHFEsrL8OZYl8rJgYZFszSSWO5VRUjqEx4cmI3v/wbpJB1abHbxkBhH4QbUnxlOT0v
         IwUA2p9EJTRslrlpdkzf8KyTgVhSyvpY8UNc4fYCygoa9IPRr4jobpi7FqCuh2L1EkOX
         HgyD2VOAK+cEhRjRYxYxCLHdrxsVtcDHsiRT2g8CSOxXVsace7rH2d5zrjdZ7kapXku4
         W2vVKfoA0Bhw+H5nKIO9aASfx3O4OMyMPhKXb1mmSBb/PY7ZP7Iqzh846Yu2oim8XDlU
         U9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MBQXwuC2b0LnweVIBbVBAEiIe5a5GoEYkznuOyk0xnU=;
        b=HU4Z0Kxp0SgSRz6XDOIhQ03K2H5n10tq2DXsCCs+UyqakwSCd07sw26XJ3AMISqZ6p
         YhmcaQ1tiRKLndNpJRYAtZyXLojQZp2lQqZSstCtRVzq56lYhW3WozD+qhgF2mIDJq84
         Jihe5Ji0W7C1SkVvzErGgjwrgRQfEXIBpKx64mHg6BasGxWbEGinGZ/D4C4i2ds9Nbfh
         1wxTZ/ArHK53csrb6LQvRF5vWTvJZbmq1rNFJmAEbBDUyGRNCm5+9wYCIE38dsoS66nM
         nQkDjS7kYHBFp+LvrQywKnJWF/Y/U3D6UjVdIHL/JEpgec+7d9PU0NNcJ8f5lXhgoylC
         yoCw==
X-Gm-Message-State: AOAM5315QsbJYLDlaqqbf4VEX2wxiiIjJ/1M9VLCy2xwDSG1gHov76XR
        iSEybdbVdNBzxTkbKp9rZuiTCt5V8lY=
X-Google-Smtp-Source: ABdhPJyGqJAJLoXGrBGjE6iHeJhslIWmC+v7SeeyI0TkR9xQdWtJQQYMSbL2rdcVa1IDuXWni4GpLg==
X-Received: by 2002:a17:90a:fa88:: with SMTP id cu8mr4992293pjb.110.1641716055623;
        Sun, 09 Jan 2022 00:14:15 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id z2sm3266986pfe.93.2022.01.09.00.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 00:14:15 -0800 (PST)
Message-ID: <9c7aeb5b-87b2-a51e-c08d-8dfc75ecf588@gmail.com>
Date:   Sun, 9 Jan 2022 15:14:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] hook: test -a|o is not POSIX
Content-Language: en-US
To:     Issam Maghni via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Issam Maghni <issam.e.maghni@mailbox.org>
References: <pull.1172.git.git.1641528221530.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1172.git.git.1641528221530.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/01/22 11.03, Issam Maghni via GitGitGadget wrote:
> From: "Issam E. Maghni" <issam.e.maghni@mailbox.org>
> 
> I faced `test: too many arguments` when building using sbase [1]
> 
> This is due to a non-POSIX syntax `test ... -a ...` and `test … -o …`.
> 
>> The XSI extensions specifying the -a and -o binary primaries and the
>> '(' and ')' operators have been marked obsolescent.
> [2]
> 
> [1] https://core.suckless.org/sbase/
> [2] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html
> 
> Signed-off-by: Issam E. Maghni <issam.e.maghni@mailbox.org>
> ---
>      shell: test -a|o is not POSIX
>      
>      I faced test: too many arguments when building using sbase
>      [https://core.suckless.org/sbase/]. This is due to a non-POSIX syntax
>      test ... -a ... and test … -o ….
>      
>      > The XSI extensions specifying the -a and -o binary primaries and the
>      > '(' and ')' operators have been marked obsolescent.
>      
>      https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1172%2Fconcatime%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1172/concatime/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/1172
> 
>   templates/hooks--update.sample | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
> index c4d426bc6ee..6cc46ebcf3a 100755
> --- a/templates/hooks--update.sample
> +++ b/templates/hooks--update.sample
> @@ -37,7 +37,7 @@ if [ -z "$GIT_DIR" ]; then
>   	exit 1
>   fi
>   
> -if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
> +if [ -z "$refname" ] || [ -z "$oldrev" ] || [ -z "$newrev" ]; then
>   	echo "usage: $0 <ref> <oldrev> <newrev>" >&2
>   	exit 1
>   fi
> @@ -95,7 +95,7 @@ case "$refname","$newrev_type" in
>   		;;
>   	refs/heads/*,commit)
>   		# branch
> -		if [ "$oldrev" = "$zero" -a "$denycreatebranch" = "true" ]; then
> +		if [ "$oldrev" = "$zero" ] && [ "$denycreatebranch" = "true" ]; then
>   			echo "*** Creating a branch is not allowed in this repository" >&2
>   			exit 1
>   		fi
> 
> base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907

 From the patch above, the title should be "replace non-POSIX test -a & test -o with logical operator".

-- 
An old man doll... just what I always wanted! - Clara
