Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068B39FD6
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877555; cv=none; b=nE92OYxzmbXzqoe+jyR8Rx5oJx8IwaoHDRgRjOf6W9bKza6yTJM0qfjnRM/ldj9jzAgZjM3bqAqE4Qn6v27l9ZK1LFA+aBL7CqlnNJHs+e2SuMB1I3Di9jUcdoGn/t6yqYNE8+bw9qi6A6ri11rcZJPX2rzGqAR0mlIZFe0fJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877555; c=relaxed/simple;
	bh=i4AqGQilEbm0AGzRWH0JAteuttgyqNjmWSModw8rzQQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=I4WVjjeK1HCsZSOOjSLVNGD9fzrssaUoN/k+smiEXEHjcJ7pXWu+ZAsiSNX3sHDiK1Y1t0v0JosvIj2LWu5NdhBlg9xgLvkqICA8XX6UpUE1RB7VuraH33frRyQDCT9sSwu6HKGKKP/acp4BrwBt5lUL9JCYuvbUxQIfhynflBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBjPccRV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBjPccRV"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d212f818so7128097e87.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710877551; x=1711482351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s33kMLKSeE7sYm0NtjwxVRWxSnglOOju6FFlPi52FZA=;
        b=CBjPccRVm+DigjjIpGLudeSdiGtJUWISkI5kpNNjKEruX13AIe0K3T3YhzObreTdFY
         9LTy7OJNrDfXTS1uCQo2dPLMifZgfkPN88DpQcZaCN5ObVWagq2DxVaMCQ2ShJtuw+Of
         uywpteIDaoctQtW19PK/OOqXB5CHZSGZ34UFd2889AKac6tZ9Tewo85UKWCOIWGgV+hF
         577VK6uidzgMqe3I2L0Sg9ONmzEZXNYssWN5LSAITbL/d0B6fi4ehnnU4GzgrWX6pePD
         WocQlVxZtOZYdeFYmpiC6CDeeOc/DCU4SXxRD62irlHB2TBV/GuYieQKsp1zNXVSQK4J
         vyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710877551; x=1711482351;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s33kMLKSeE7sYm0NtjwxVRWxSnglOOju6FFlPi52FZA=;
        b=ELtLGy9dpJ83SKIwOpQO8AlnRHSZwuL6XHcMwN7GX/pi0sFUQjc7ZY+bitJ+Ds2SMu
         bJoh8DVDieBqs6p91Xdnt9wZ9j4317nJy3DLMYnX7At/1wk5FFsMyxau3Py9hNDDQHEe
         gQSUWL3skfxzWE1ergd+QWbseN4/Q5CyyYUVGPVHi5/yyN104tBoF+PvvGCJN6F92sJk
         uIlb/v6lgPZi2pvi7wfa+kVAu3JaZX2GyUpCiFgffgwwKDP41s3DM5ih81FLWcFTSUmc
         XJMSc1FkvlSNl8UZuPac2Lh/D2N/3EzeTJPERayGXD0jBxC0Eo1amtdjygZmMaGpSucN
         6jzQ==
X-Gm-Message-State: AOJu0YxxT1bqOHKIvqDB6L+FYCCRPLGmDs9Ze2RUplYvAavc6tgopITS
	DQWkLDCrmBGSViYO2T5epF0Vxa+3ylhPR2o2wLA8uKjwjuHl25mHhC5kkMMiqN8=
X-Google-Smtp-Source: AGHT+IFSKL0tMRHjQdywMSAlyRcQG8a8mXAFH/mZ+M5PF4iR6FSwhZOyy5G3MBoK6z4/wulFC7VOMg==
X-Received: by 2002:a05:651c:d3:b0:2d2:3c88:cd57 with SMTP id 19-20020a05651c00d300b002d23c88cd57mr48564ljr.32.1710877551364;
        Tue, 19 Mar 2024 12:45:51 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id fa6-20020a05600c518600b004146a49d0d3sm162777wmb.30.2024.03.19.12.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 12:45:50 -0700 (PDT)
Message-ID: <e47f9df1-be1f-45aa-9308-dfbc2124f29c@gmail.com>
Date: Tue, 19 Mar 2024 20:45:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: add "Hightlight commit name" menu entry
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Denton Liu <liu.denton@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, Beat Bolli <dev+git@drbeat.li>
References: <20240130085308.5440-1-rgallaispou@gmail.com>
In-Reply-To: <20240130085308.5440-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping since I haven't received any reviews or comment on this 
patch. :)

Do you guys actually take patches for the gitk tool ? I feel like there 
is not much features added on this.

Regards,
Raphaël

Le 30/01/2024 à 09:53, Raphael Gallais-Pou a écrit :
> When working with diverged branches, some patches can appear several times
> on different branches without having the need to merge those branches.
> On the other hand you may have to port a specific patch on another
> branch you are working on. The search with a SHA1 cannot be applied here
> since they would differ.
> 
> This patch adds an entry in the main context menu to highlight every
> instance of a commit.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>   gitk-git/gitk | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 7a087f123d..4b15230a16 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2672,6 +2672,7 @@ proc makewindow {} {
>           {mc "Make patch" command mkpatch}
>           {mc "Create tag" command mktag}
>           {mc "Copy commit reference" command copyreference}
> +	{mc "Highlight commit name" command highlightcommitname}
>           {mc "Write commit to file" command writecommit}
>           {mc "Create new branch" command mkbranch}
>           {mc "Cherry-pick this commit" command cherrypick}
> @@ -9002,13 +9003,13 @@ proc rowmenu {x y id} {
>       if {$id ne $nullid && $id ne $nullid2} {
>           set menu $rowctxmenu
>           if {$mainhead ne {}} {
> -            $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
> +            $menu entryconfigure 9 -label [mc "Reset %s branch to here" $mainhead] -state normal
>           } else {
> -            $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
> +            $menu entryconfigure 9 -label [mc "Detached head: can't reset" $mainhead] -state disabled
>           }
> -        $menu entryconfigure 10 -state $mstate
>           $menu entryconfigure 11 -state $mstate
>           $menu entryconfigure 12 -state $mstate
> +        $menu entryconfigure 13 -state $mstate
>       } else {
>           set menu $fakerowmenu
>       }
> @@ -9481,6 +9482,22 @@ proc copyreference {} {
>       clipboard append $reference
>   }
>   
> +proc highlightcommitname {} {
> +    global rowmenuid autosellen findstring gdttype
> +
> +    set format "%s"
> +    set cmd [list git show -s --pretty=format:$format --date=short]
> +    if {$autosellen < 40} {
> +        lappend cmd --abbrev=$autosellen
> +    }
> +    set reference [eval exec $cmd $rowmenuid]
> +    set findstring $reference
> +    set gdttype [mc "containing:"]
> +
> +    clipboard clear
> +    clipboard append $reference
> +}
> +
>   proc writecommit {} {
>       global rowmenuid wrcomtop commitinfo wrcomcmd NS
>   
