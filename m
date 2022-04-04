Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0756FC47080
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380296AbiDDVVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379965AbiDDS2I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 14:28:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D613F48
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 11:26:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z7so12393700iom.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ajHe4v+SzL7+Hwhox06XrHwZd2sSitJ7f9hYutLgt98=;
        b=b9zjJC4q95jJV38zrpdT52fWJTFwMTZNVYhfMOgvD+5bjj1D/oXnFLli5NJKopVtTf
         iFfRtT4Z2xNrFPk8Q4gk5v2Xv+BNJTMLpwTPSiCBwgyH+290QH9ctKDhzLFQlm22Kg0H
         mxjYep150AxAf3So5WcwyD5j4BC7pJFZBch/8Rqv5LalRt3Plqx+Z1rycJOGPEoeqlxK
         h8kMqHw8/N/E50n1Zkw4cmmgoQ/UktO+va0hEoMyCiiqSaDXt5QE6ffSRYvi2EeI8PnZ
         5R7qA+vmMWKkrhK9nYwa1g/gCfTDWmCyVnb46r1xJfLJhIMu/vydQzDNdco6b3b8knn3
         BYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ajHe4v+SzL7+Hwhox06XrHwZd2sSitJ7f9hYutLgt98=;
        b=AhvbR2nkcKEVw/qL1pFEfl78pfh2YZQmIqHxJM/Lj74R6elVCbyamUWWsE55feYoZC
         kvggt4K2MRbg3zXf0dJk9NUoErhV+3WdAyCvFLyv7L1gDfoo46KpsD2+Ucc1758nxbXZ
         hfSkR/li4nV6F/RcEaHuMAx7ga7//N5cp0jSCbTnyJgwRkV/Bpo/bBdO2If61X7gJibh
         scwlo3OQ+Fcf105x0YNMtSQMVHUVUngZ/8A9uw0XXLLOihPKkBBWBuPyxma/oE/TkbmE
         ib6C8QUq672+6y6koqtH3Fu5AxcA2jIJbdshiA2RfIzezsGhZvf5Dniieek2LRb8OLD1
         A1gQ==
X-Gm-Message-State: AOAM533zmGXLvKS0zPJKspwJ463rAsQtlWU8wpfTIwNTBnkp8PqNfE+O
        WXHLo8mtc+iglJvmNqS2zqzxIBfwbVJqfTkKJ9E=
X-Google-Smtp-Source: ABdhPJzRNbAtr/ASR0ZPBIgG3IHSzez+vS/Z+eHLuVKTOC+3zggfY01Ew3wmRS/IwGxm7NK/JcwlYhfKeVasSsdgJt8=
X-Received: by 2002:a05:6602:2a45:b0:648:b21c:6f49 with SMTP id
 k5-20020a0566022a4500b00648b21c6f49mr729165iov.206.1649096770175; Mon, 04 Apr
 2022 11:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220404182129.33992-1-eantoranz@gmail.com>
In-Reply-To: <20220404182129.33992-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 4 Apr 2022 20:25:59 +0200
Message-ID: <CAOc6etaY8enMF0nmhaqA2+Oi6JmYFY-bPqsUFTXE=K8aFoXDnQ@mail.gmail.com>
Subject: Re: [PATCH v2] blame: report correct number of lines in progress when
 using ranges
To:     Junio C Hamano <gitster@pobox.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 8:21 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> When using ranges, use their sizes as the limit for progress
> instead of the size of the full file.
>
>  '
>
> +test_expect_success 'blame progress on a full file' '
> +       cat >progress.txt <<-\EOF &&
> +       a simple test file
> +
> +       no relevant content is expected here
> +
> +       If the file is too short, we cannot test ranges
> +
> +       EOF
> +       git add progress.txt &&
> +       git commit -m "add a file for testing progress" &&

I wonder if the preceding section should be kept in a
separate 'setup test'?

> +       GIT_PROGRESS_DELAY=0 \
> +       git blame --progress progress.txt > /dev/null 2> full_progress.txt &&
> +       grep "Blaming lines: 100% (6/6), done." full_progress.txt
> +'
