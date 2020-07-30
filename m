Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26705C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33EE20829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 23:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S00IZy4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgG3XhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgG3XhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 19:37:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC3BC061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 16:37:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so26391181wrl.4
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaWkA+WzhStlbnl5L7eRJc03UGYFjG+isAPpi33IJdk=;
        b=S00IZy4X3jpMsSWPbPCllc5UnSUyDQijpqmS6fVhC/Zf8QXIFrnRXLU5btR/SgsWYn
         fTqBZP6nxs6O9tdskXyFLYNNPh96rZlO5zxBFyIpZpwZyxndJjLKSCQIz0Xp6jylyEdG
         Y8sQPBmez0X5fG6qNUjP+w/5W0eNXCq7e/9GFqIQ7ZlqCkrzzhl9Kg1AY/otYCdg77IK
         IX3BDsVFGNdlI0ob9OAJYw3qJIdb5e2SxcSKiy/nJxhnmVk2E75UYOnzEX/Vyk+T1LVP
         5tR9wttafRwu2o4nZzvs0W/X9U95SrouDq4QAJ4UgOoy34leUenHO2B9jiaA8TQqWQ/u
         L1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaWkA+WzhStlbnl5L7eRJc03UGYFjG+isAPpi33IJdk=;
        b=HlhRAt16pp3G5W5ypEbSaC55ehSPtwnJIKGpJixID1pJbSkzBFyCPPORacDiCyxmVB
         n60ui/XMzIcXuG/ehaVIENZp5V+DpCuGqU4SPgy4QOmmonUjA+kWGiE+/msZjNtppBp7
         B3eq6HsxPuj7n3uaR2aAqUmeinDd+ylFe1o4xNVrsAPiyX4yL60Rwd9S082RkOcM3b6w
         gpRgAMYGaM0KVAOS0o/SU6HFFBMfHoZe0RRO1yfGoaCUwYw1/HQGZsZoszTvGp85S5Ax
         wBB42rlQUu68GxQ1n/S0D8geJVXjxi4bNml+4Ho+BElqsKbcYMFh7qQ/xbZ+Ef1naXTe
         BZDA==
X-Gm-Message-State: AOAM533HURnCrR9+ZlzbefaxTe4k5NFil++9nirnBpSjrLHy0nFdw/oc
        m9X/x1/Jh6/3Fh/tHRlkwekZAyKyiJwprDdkaeM=
X-Google-Smtp-Source: ABdhPJy3Po0RoxJ74FjyZQ6BW1tv872sXn6KFaC4QMR5I0d5dcyndCkSKO8SinfJSqeyM7GniqkcyJrkIUU8GP7+TEs=
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr813780wrq.327.1596152220088;
 Thu, 30 Jul 2020 16:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <pull.671.v3.git.1596147867.gitgitgadget@gmail.com> <ef2a2319565939bfbdbd2e898a980c61ecc39c6a.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <ef2a2319565939bfbdbd2e898a980c61ecc39c6a.1596147867.git.gitgitgadget@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 30 Jul 2020 16:36:49 -0700
Message-ID: <CAPx1GvcpOC2jeeB=CNR5cGh=q59j6J09J2+vRz4+8aH1_cQocQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/20] maintenance: auto-size incremental-repack batch
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>, jrnieder@gmail.com,
        Jeff King <peff@peff.net>, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, Emily Shaffer <emilyshaffer@google.com>,
        sluongng@gmail.com, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 3:26 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 99ab1f5e9d..d94eb3e6ad 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -988,6 +988,46 @@ static int multi_pack_index_expire(void)
>         return 0;
>  }
>
> +#define TWO_GIGABYTES (0x7FFF)

You meant (0x7FFFFFFF) here, right?

Chris
