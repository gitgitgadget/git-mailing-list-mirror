Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A1EC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 10:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiK1KNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 05:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiK1KNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 05:13:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32BD13E35
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 02:13:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q7so15058411wrr.8
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 02:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5Gy4wgKdkathVVCGimA5ZOmeTTqAKc3MZoEjg23BeI=;
        b=Vc5OH0WjijLOwmLZiaZMAQY1L3aC2YmyECRF02D2GP8XgdrIvpKUJsplR3Rda/eQyL
         4SCslJ75/CFJaWYscq3/a8BwIVbqCjm+Zf7Qv0SKWRZrh6eFZUjR/d+unD+/HFd5Su/N
         8E40b++lg1u80dPo4x9Wncf9r6HZkDS4iQPJDVurb2SOIX8ABPlKTmn4usOl99kTf6eH
         7jtmG64DWtBHkOX2v9+2edZ4njLZ3hviRRFzmOwZeoU78u43Wc8afuGV2TZi0ZIdeMbW
         Om4M963DhHDklTIFNnX/2y+Ixh3tEoz8kVI6Kna2PSAAyCGVN+OuOYRLvzvnRf0xTCt3
         XTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5Gy4wgKdkathVVCGimA5ZOmeTTqAKc3MZoEjg23BeI=;
        b=Ch/P3Zjq4GmhSnYw14L+7xrgBbcrEvtkfnkRQH3GDnMy/xyiRd7vd0yE9aLPKf6MV9
         J0lX2OCR7X+iQ7x/CFiWGptTaoVJct2fuAPE4HRqkalEHwH6BxiNP2Ei6Le5yPAz0SYV
         35ocQnRiRQU8F72B/UovBnPKpiH/1l7Svu88MeKPwz61SZ/yahaR6McH0hz8Sm0jHThf
         Lp3sRfoObu5+3oE2QWw7bxfSx17hqAwV/2o9eenvhE5Cjarurx/dWLwQt9YeplwH1sIP
         AFJJTbgPHYzWazT5Vxtk+JpxuHBrbp/XJJlY+kDR7mWvJC1O/Fa9b66vyisdh82z7scW
         +IBg==
X-Gm-Message-State: ANoB5pns0KlKXUwEGTWrA66YIpuXdofzARMWIVM6FEJASWdtc0nVViPk
        B2Z3+BNOfplcRl89RXlgUgx6MxUCen0=
X-Google-Smtp-Source: AA0mqf7m85Wk+7EW65+bHHcSDRwuyZU+Hi8tuQ/e7rG2I7iiFJzzm1Sn+hRYguPEaxMz2WovAy97mw==
X-Received: by 2002:adf:f7c8:0:b0:236:720a:e391 with SMTP id a8-20020adff7c8000000b00236720ae391mr23593828wrq.368.1669630427217;
        Mon, 28 Nov 2022 02:13:47 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d474f000000b002421a8f4fa6sm1458210wrs.92.2022.11.28.02.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 02:13:46 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b79a4852-1e20-2c9a-a91c-f1ea629af402@dunelm.org.uk>
Date:   Mon, 28 Nov 2022 10:13:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 0/3] git-jump: support Emacs
Content-Language: en-US
To:     Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
References: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
 <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yoichi

On 27/11/2022 01:18, Yoichi NAKAYAMA via GitGitGadget wrote:
> Add an optional argument 'stdout' to print the quickfix lines to standard
> output. It can be used with M-x grep on Emacs.
> 
> Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
> EDITOR="emacsclient" and EDITOR="emacsclient -t".

I've tested this version and it addresses all of my previous concerns, 
thanks for working on it.

Best Wishes

Phillip

> Jeff King (1):
>    git-jump: move valid-mode check earlier
> 
> Yoichi Nakayama (2):
>    git-jump: add an optional argument '--stdout'
>    git-jump: invoke emacs/emacsclient
> 
>   contrib/git-jump/README   | 10 ++++++++-
>   contrib/git-jump/git-jump | 45 ++++++++++++++++++++++++++++++++++++---
>   2 files changed, 51 insertions(+), 4 deletions(-)
> 
> 
> base-commit: eea7033409a0ed713c78437fc76486983d211e25
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v8
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v8
> Pull-Request: https://github.com/gitgitgadget/git/pull/1423
> 
> Range-diff vs v7:
> 
>   1:  446777d300d ! 1:  afface9b010 git-jump: add an optional argument '--stdout'
>       @@ contrib/git-jump/git-jump: mode_ws() {
>        +	case "$1" in
>        +	--stdout)
>        +		use_stdout=t
>       -+		shift
>        +		;;
>        +	--*)
>        +		usage >&2
>       @@ contrib/git-jump/git-jump: mode_ws() {
>        +		break
>        +		;;
>        +	esac
>       ++	shift
>        +done
>         if test $# -lt 1; then
>         	usage >&2
>   2:  972d51888ba = 2:  e9aa6fdf836 git-jump: move valid-mode check earlier
>   3:  d8233f96175 ! 3:  048f508ca99 git-jump: invoke emacs/emacsclient
>       @@ contrib/git-jump/git-jump: EOF
>        +		#
>        +		# Wait for completion of the asynchronously executed process
>        +		# to avoid race conditions in case of "emacsclient".
>       -+		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat \$1\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
>       ++		eval "$editor --eval \"(let ((buf (grep \\\"cat \$1\\\"))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
>        +		;;
>        +	*)
>        +		# assume anything else is vi-compatible
> 
