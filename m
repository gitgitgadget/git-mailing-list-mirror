Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1084C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6BB64E2E
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhBBJAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBBJAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:00:15 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D317C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 00:59:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s18so23048164ljg.7
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 00:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dL467WuyIjh6+/MpBBs7H42JKdN+tFcTo7xeVs0gcnA=;
        b=OoeDyX+W7vrGs+K3S/EmcFFSMoAcF5ugED5PNDFSndG4dtxfY89Dmj8a2qoQzJkHLq
         ydDfOv/p9m+urH5Cwx9jwanwfln7JiYs01u04pKSUCOfp0GG4/88ZFVmV5lMgFDAGxkq
         7cfY+JwHp93/+M9fUXouyZdo06LcgSuILnvCB0/ycVAu/81gU3LFOhBfW5OwQtZoPIVW
         6QY4UYV8XBowckC06yU+CJy5cRcc0mY81DEa8+P+eXTdSPQgzjfLi10ihGgfY53eZ7hU
         azkC46A4N2gskfnSwvNz0Ugkk1USO1a2+7KeSfCHDZLUFYdAN9ntFbX7HGLlp/I74s5M
         P3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL467WuyIjh6+/MpBBs7H42JKdN+tFcTo7xeVs0gcnA=;
        b=XWs6CIVM9zy2eMX9EnV9xoKhsdFoLPp5fYk7OZ4hY7OlQ7GujL9Jmusgw0f3Dg96yx
         hnP83Il4xpaEeeSDcrQEBfCviGWGioP+VwMRcJ2Yh2KrMEQsexnRfNBcKiF6r4nXbtFW
         fMjADzCzmdiMQohnR/88mM13p2ZFdYbrn2aDN9xqL0KkJ/fVXCvp0wXMCzf3gl7JXRUj
         Srbq9SdYpuKr1t6s8UdqEnGNEupm054Xh/CMPairsBF1qY1QC4LEQ87mqE7V8XVAOSMM
         Q5YCJtn+0kyqcf5VABOgV8nqDsl6wgaKHKSeGw0RjGK6Qm/SAT3QCeTS9E4pS7p2r5oq
         ZyYA==
X-Gm-Message-State: AOAM533BpSe6rXD3QV4AIYdOZVkesgJ5HbenQCoV5e3NanviZe49jHWD
        KaBpOB+AlI9fIX1peLb0kZeBKtd3lYfqwlNfumc=
X-Google-Smtp-Source: ABdhPJzw2B0jiEsfXWGOlb/YUrLYHiab4//4/KtLIP64qnuMvmFh58ZWTZZNuDheemugvEO519c+DGseBc00JnqJ9RQ=
X-Received: by 2002:a2e:98ce:: with SMTP id s14mr12114433ljj.447.1612256373420;
 Tue, 02 Feb 2021 00:59:33 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
In-Reply-To: <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 2 Feb 2021 16:59:21 +0800
Message-ID: <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> You can,  on _your_ end, filter incoming messages that are sent via
> vger.kernel.org and do not have your address on To or Cc.

Thank you very much for your comment. It seems that the following
Gmail filter will do the trick:

From: *@vger.kernel.org
To or Cc: -hongyi.zhao@gmail.com

But I can't find the Cc field on the filter panel.

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
