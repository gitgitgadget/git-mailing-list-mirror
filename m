Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBF3C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 12:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiBIMH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiBIMGt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6808C050CFE
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 03:07:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s18so3359130wrv.7
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GBoUJBibwojZNJKlh3dimn396zLql+nc3e4m2JQpCN8=;
        b=lmSHDSbGfdWPo8Sbe+Nm2K2Cg8CBxx35xUuySuB+fridjMZ4X0Rej74ta1ueRRw/1u
         V6WJNCOE3qyknVpcRjPV4KkL+kntrZbf9kZiuLyB0wp+dk9wdZhF6/hIaq/Vfe15Z2p+
         jHMDS3Q8uALXn7r3wOGsVJQPV/WzWb5yFrTYM62YhohtfWzeWvRlhc4inROJNhjlkbcT
         R1ndXWpu6nB06BbAYOTOJ4+4bq2y1iIL7zu0cNtTV65s4fVdQBlPITsBeUX0rloTPbwb
         Ui5LJT07SiFkovWeV3dR588NJvRihjgxutzkCTl5A1z1ERaehkDY6W75/gi3hXEHS8Ls
         fKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GBoUJBibwojZNJKlh3dimn396zLql+nc3e4m2JQpCN8=;
        b=xKzNlMYvI74XCXcjXGZqrt75NnMriG+kzl0cwg65tnNAA+1Qm3I5Rxh5BvQkQrseUT
         XOg1AFMyLI/3JuOfHCTJCXWUXpp9QuVUPIA3db1o3mNLuN3jnD/0o6FRFJmyAOBWHuiE
         khbPkKmZcTOzf/K5DqfGWaREHDN0ZV3AlW3OeOmeaKVq1hZ1EFJdCm9q6x84rJI9m1FY
         SQGPihJegoQyxW0RbZjfBf40O1gwiLzAQem7ahXa54+W9/8zfYE4TS8TELbk18hvYTRj
         O8mk6eagcynfiZEP07ydFFX1hI05wCA/4qOtyUGy+JcRxdmP12p+UsnxS53grs1HEvgZ
         5UFQ==
X-Gm-Message-State: AOAM530f6BG08XUxJWFb4B0zoHZwH6LaLtqUNkw9DrFtnCFV01uEyEUe
        tmyUirsWtcWgmhToxRhdbhAN7RiT720=
X-Google-Smtp-Source: ABdhPJzN0GnNobqkFzmlCknP3W/EayvSjmF/JUhirgB9kOD4TOMONm0cyOuSTJ6KdbV3mRftpmXU0Q==
X-Received: by 2002:adf:fdca:: with SMTP id i10mr1717029wrs.251.1644404832227;
        Wed, 09 Feb 2022 03:07:12 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id d12sm7749843wrx.47.2022.02.09.03.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 03:07:11 -0800 (PST)
Message-ID: <94c2b081-2767-8d4a-f77e-db74d9aeda56@gmail.com>
Date:   Wed, 9 Feb 2022 11:07:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
Content-Language: en-US
To:     Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
References: <20220209012951.GA7@abe733c6e288>
 <20220209013354.GB7@abe733c6e288>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220209013354.GB7@abe733c6e288>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Edward

On 09/02/2022 01:33, Edward Thomson wrote:
> Provide an indirection layer into the git-specific functionality and
> utilities in `git-xdiff.h`, prefixing those types and functions with
> `xdl_` (and `XDL_` for macros).  This allows other projects that use
> git's xdiff implementation to keep up-to-date; they can now take all the
> files _except_ `git-xdiff.h`, which they have customized for their own
> environment.

This seems like a sensible way to make it easier to share a common 
xdiff. The patch looks good to me apart from

> diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
> index a4285ac0eb..bf66dc0a87 100644
> --- a/xdiff/xinclude.h
> +++ b/xdiff/xinclude.h
> @@ -24,6 +24,7 @@
>   #define XINCLUDE_H
>   
>   #include "git-compat-util.h"

I think you want to remove this

Best Wishes

Phillip

