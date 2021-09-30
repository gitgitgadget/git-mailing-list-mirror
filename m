Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D67C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7C361425
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbhI3TTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhI3TTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 15:19:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2897C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:17:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 134so8923729iou.12
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9YeqIdrqaeqLXG5mQ6WR+BpGuELEex4pLA+Ebx7fCw=;
        b=RMvoL9NAGvabqjVHIT2eh7HF+00mMkWBZ/FpzRBIOzQ6m6+FVgYI6kvW8q/QroIAMD
         t8mVn2oj/mKDaJmeMJGQOhy9yX8WHmZcX6LSekTRs9Oqx006e5KN/9qwrh/h2O7oi326
         PTJi5DAn4nnokEa2rttJofkyEGwjwiQkfzQttW4/ZSmJISmBpeNClUg1CvU4Q5nFNGDk
         Sa5IONmJ+FDl3hPaRnk53MoaeDL4ebXvEsSHB+XDNZk2ljpYRcKKrPVTZDaDNk3EoyRP
         mRgLTCIJMOGBq7DSOEHqWVMsbsKc7JC4+pAoHzuXOP/WKAyiGupVlFVAmK8voc63vZtG
         /GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9YeqIdrqaeqLXG5mQ6WR+BpGuELEex4pLA+Ebx7fCw=;
        b=hC1sgVXaoLiIk4Cl+j3N9dAL3QYJhQ17WzVmQrpi2q+KB0XEI5gny5udsnQgWsCtQ2
         sKv3dY/SHlM6+bB+GSCMGXrxzNJLKEYpR/wSd6I0HgAbC7AoV84kOrsoYOrd3Yx9di85
         /catbBQdAMdE/8SkvTxX/76wPNXi4I3d71UNxGI2bt7zzogP76+Gu1N4/F+HI2n4NbL/
         1EfD5XBlgG+0Dpmn7HJpFwKUIn4d6soDp7vjFlgAJaDRWFnkhijrVHW0d5/8NssLFkxC
         LtLsS8YHcTuVYt9j4W/EVnfLOP2F/BiqSeTmkTDCMtM+rBXh6Z/6mZw9bw0F/DHDGslY
         7eJA==
X-Gm-Message-State: AOAM532erhnpPvYGEcP+vmL5OwTBw89IMP1WSRDlzvDTCzI0tIevAC1C
        t9BlkzndUj1EcsgKsF3dqwQWxw==
X-Google-Smtp-Source: ABdhPJywr82iDMYix8pb+ASLy5qiN1/p21Zv2h9uw9PnarfdJeWehDA7Mv+d/jhzzzyQtDfh9qvOQg==
X-Received: by 2002:a02:aa8e:: with SMTP id u14mr6398541jai.24.1633029469264;
        Thu, 30 Sep 2021 12:17:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a12sm2164946ilb.66.2021.09.30.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 12:17:49 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:17:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/7] sparse-index: update command for expand/collapse test
Message-ID: <YVYNW13aVADaR+g6@nand.local>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 02:50:56PM +0000, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
>
> In anticipation of multiple commands being fully integrated with sparse
> index, update the test for index expand and collapse for non-sparse index
> integrated commands to use `mv`.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index c5977152661..aed8683e629 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -642,7 +642,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
>  	init_repos &&
>
>  	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -		git -C sparse-index -c core.fsmonitor="" reset --hard &&
> +		git -C sparse-index -c core.fsmonitor="" mv a b &&

Double-checking my understanding as somebody who is not so familiar with
t1092: this test is to ensure that commands which don't yet understand
the sparse index can temporarily expand it in order to do their work?

If so, makes sense to me. And renaming 'a' to 'b' is arbitrary and fine
to do since we end up recreating the sparse-index repository each time
via init_repos.

Looks good to me.

Thanks,
Taylor
