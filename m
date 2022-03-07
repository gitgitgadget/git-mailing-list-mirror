Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B0AC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiCGLeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiCGLdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:33:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0859FCF8
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:31:23 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so10101720pjd.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvlStCwMMino8SKQ+60lj3FQeAe36kxSo/WaGzEmCUc=;
        b=eloBcaRDWChYkvdxbVIPkB/7k9GXcIMRpL9GMap8wNAb9Sax7XIQWjI/acc7qkxgoD
         afqCx5lupX3yXZzvleV1WnjlaopusrFt01d/1BXk1Xd1+eRb9IJZKhhXtXMwoW6B/Hj5
         mEqZK6IGZt39sXOiIPXmKSd9ZWNIvK8bPBWSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvlStCwMMino8SKQ+60lj3FQeAe36kxSo/WaGzEmCUc=;
        b=JSwZ5CFCdHurqULWBn6IkAlWLEegEY9V3uF7GxWhIcDuxnm8qh9zLLjPW9FNm62mPz
         j3lp3zEu/j3ibMredkQcUExB8t5hYKonMuiGagAqQItM+MR3ZNw4f8BimxCsw9ODz+W5
         Dbwx4LidrlXyaWpO3hvHjr/v4/wyX2pS9SsTdVMcJWWqHvFl4w0iA60YolOFOSnckHaq
         61rE6xCcvogxWVneg1W5mJfq5lWdknoZDy0pG0Leh3Qk6bU8gDNflEJ1mNzwqRwQ8gvr
         zxYw1665O4P7spFk3ciTkNPhgbJabQAsxjsdkslG1O0nJAY52qvsOcv6Eni0GzCGzpL7
         5SEA==
X-Gm-Message-State: AOAM532hAIXkgF/+g7SaVmy1Pg+tvleS2l1z5VBku3J6hU1AYnWGZtW7
        RJcAq2VGoZcQVeGa/ZQj+lja9jj7ZdFXVacRH0GXjw==
X-Google-Smtp-Source: ABdhPJzleiAZlc/EAm+mxUMyc3j/Qzvxb2hxGVsruLAgbtrJ8WAdlx5CGE3GqYs4H3p8bb/zrj6v8WHy06KJfqLVCG8=
X-Received: by 2002:a17:90b:1104:b0:1b8:b90b:22c7 with SMTP id
 gi4-20020a17090b110400b001b8b90b22c7mr12820701pjb.45.1646652682464; Mon, 07
 Mar 2022 03:31:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
 <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com> <a503b98f33328133f9a89ad7eba986b73535c461.1646406275.git.gitgitgadget@gmail.com>
 <xmqqa6e51kms.fsf@gitster.g>
In-Reply-To: <xmqqa6e51kms.fsf@gitster.g>
From:   Robert Coup <robert@coup.net.nz>
Date:   Mon, 7 Mar 2022 11:31:11 +0000
Message-ID: <CACf-nVfEt8xWgg-d8JmtSD09Mvp=YvshN=cfMQ=304--h5Rjcg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] fetch: add --refetch option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Mar 2022 at 21:19, Junio C Hamano <gitster@pobox.com> wrote:
> I guess the existing --unshallow has the same problem, but it strikes
> me odd that these aren't doing a bog-standard OPT_BOOL(), with default
> value of "false", like, say "--update-head-ok" does.
>
> That will naturally support things like
>
>         git fetch --refetch --no-refetch
>
> where a later option overrides what an earlier option did.
>

Ah, I literally copied the unshallow one since it seemed boolean-ish
and that's what I wanted. I'll look into it.

Thanks,
Rob :)
