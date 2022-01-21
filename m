Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD88C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382171AbiAUSrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 13:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiAUSq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 13:46:59 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F2C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 10:46:59 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id h30so8378269ila.12
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 10:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXmd4BE5sQA2EU/FkG29wLajjAMDxEwkK/NK0K3pB2w=;
        b=jFWNB8PY8FMXj8QHKo1LJ14v9JwPe9V0hyTKlk9bxoMQLdqQHi5tZqyUR4lyXJqexC
         NioG8I6TWFx6SLAN0NfaO4W144BSqclXGKaVevFoEYj+uPc1vFtSNSiLBKmHO1JWVkSz
         peBIj7tC3p9o2nbhf2SBsmxx/RBZN21upA7npL4joAYs69JN624BjLZ4ZR1uPMc9tTet
         Ar/DRQeJrowZ280xNQVWZUoNlj3baoAtt24MoKTl9tUZNIBzJlXSMWIzMXMOJsRnB7ZI
         2hWSzZo4/24j3YD6sPwjytwfUpxSBP/nyS5IYBQ2/ce/9VQuvrzVuyK29bDOuGZ+3pnr
         k68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXmd4BE5sQA2EU/FkG29wLajjAMDxEwkK/NK0K3pB2w=;
        b=gTLS0hS+wM+ZLNSCiDVFFsmaX7ZsyNm/SzMv2xN/U/M8lliAjpz5Q+357ySZ3+GRYR
         QgZ5JhIymFc96l3tYYb235D+9mmnNV9RDgJ76z+n/bSxuXO0nxnRxCsyXPI3nuRfUyG0
         puD27ZXyKld3CPfZMe+GPa5u9lSL7PAn5SY/PE1Z41Rl+3U/NviezQrIfk+27305L+mG
         i3Yv5o+pVs+hofAi3mIK4aCndJ9A8oF0cKGNrqsNL4Lbh0WEehugjyBKqcB7KHOJU9yF
         Nuir7YW3whWaqul4EINXrcPFu/V9msR2Xta7VDkJPTpx3ng4I82TMdAw0QugOQe7nRXb
         HFjA==
X-Gm-Message-State: AOAM531h22ELt6Tmr7zcsOu1qfpzx6jEGMqYXmbpEympnB2UUsfGc5Xk
        zRHybIuZHppMz62Ds7CYcW5glG0O2nAWNQ==
X-Google-Smtp-Source: ABdhPJzAQQ/EZUnaPrWARtcrMoLBwjlwCWZErW6nYz0sTZnZvWDF2qAVe/nXcVetylg4Scg1LuPtjQ==
X-Received: by 2002:a05:6e02:1e01:: with SMTP id g1mr2903945ila.129.1642790818540;
        Fri, 21 Jan 2022 10:46:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h13sm3445506ili.31.2022.01.21.10.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 10:46:58 -0800 (PST)
Date:   Fri, 21 Jan 2022 13:46:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
Message-ID: <Yer/oEZK6TBFSsde@nand.local>
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
 <20220121102109.433457-2-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121102109.433457-2-shaoxuan.yuan02@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shaoxuan,

On Fri, Jan 21, 2022 at 06:21:09PM +0800, Shaoxuan Yuan wrote:
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 3235ab4d53..c72a28d3a5 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -6,7 +6,7 @@ TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>
>  check_config () {
> -	if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
> +	if test_path_is_dir "$1" && test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
>  	then
>  		: happy
>  	else

Looks very reasonable to me. Indeed, this line comes from 6adcca3fe8
(Fix initialization of a bare repository, 2007-08-27) which predates
2caf20c52b (test-lib: user-friendly alternatives to test [-d|-f|-e],
2010-08-10) when these helpers were originally introduced.

I thought that we could probably just shorten this to calling
"test_path_is_file" twice: once for "$1/config" and a second time for
"$1/refs", but that assumes "$1" is non-empty. And to ensure that you'd
need another check, which amounts to the same amount of code overall.

So the fix here looks good to me, and thanks for your contribution!

Thanks,
Taylor
