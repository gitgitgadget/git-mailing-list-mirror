Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5CDC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AE460F90
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhGZRd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhGZRd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:33:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FFAC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:13:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nd39so17861427ejc.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unul+hGnesofkil6kxrjSGlIujnL3tIHcQqushDFuP8=;
        b=SvMsOfHM8luZ1cdxS1xz3OLalkYq2QFOVkUqK4t9RBKo8O/IwZMx/CzoVzUwwCA2Uo
         ND3UKYpsSfPsnOdCDzCFtVvHlh+uyEZXjJ7jKbotD5m54OGI/yHMafo4ZIs2uAK28bm0
         bg/Q9iFn/BrtIqPr5KgUD/wqMn+tsqaHa+JiPnJjfrYsV1ULsnDZFqio6r2x2oirINu9
         gG3Ldq4zldIJW55dVgfWNYmYJPlaIHGj8g7Q70ORKhR06mAi3SdZWW2g4p6KHnEZVpkw
         Whq5UAPMChnANMVwOVwlfWZap7NOKT0I7gs8N9G5GVxBAfYyN6RFBu2MNjEftvgyRgZT
         IeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unul+hGnesofkil6kxrjSGlIujnL3tIHcQqushDFuP8=;
        b=gWtEl9znCCTESgPQwZz1Fl1gLKMi7yI08Yu1HuOg3ZSH0rfsJ8FAkXWQPrSgOIKYcN
         jA/Zrh1vvrRIsXWuiiqfRiRn9RcXLgsUYPMXPAfPP0FCo2bGxy1/zl90JglaBTppiLOc
         Ik8LVt2lyOmArOsYoeGkXWehg2EXk3pPDFiUi3IAN3QVi0UhZvwiapJinqP6lJXknog4
         UREVQLQjx9lJzUID1AF8bZxZq4SwKHn96wPnZeNKw8XeeZT/aqdmjj94S/aGEShc+0Ey
         Wsd/hrjQ0D7HQEdoVCIoI+XGqLhTSPcXmjpLWBWT+RgDWxHs59fenLUdDprAq8efjiZd
         4YNg==
X-Gm-Message-State: AOAM533Ix2Alka8h2ozMB5dR5yJN++T3I1DSGtr2j3dvvbzfv7QbZVLR
        bldHv3gx9x9rzoyrFIJAGDXQ0SXvqaad2ONFEQY=
X-Google-Smtp-Source: ABdhPJyVDaJs1IukAUU8l1JThh8z99NnLeRBrA7nAyFihVmY0BU9HbsLqo6vUpkMfMWbllWQZBJylDb21/uHKtZlPNY=
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr18079388ejb.283.1627323236374;
 Mon, 26 Jul 2021 11:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
In-Reply-To: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Jul 2021 20:13:45 +0200
Message-ID: <CAP8UFD37EyNcjPBeSmpAaryv9M0zqrZ98aQ36O6NXNZ9t_7CBw@mail.gmail.com>
Subject: Re: [PATCH] Fix git-bisect when show-branch is configured to run with pager
To:     Oded S via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Oded Shimon <oded@istraresearch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry, I forgot to keep the mailing list in Cc, in my first reply, so
I am resending it...)

On Mon, Jul 26, 2021 at 5:03 PM Oded S via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Oded Shimon <oded@istraresearch.com>

Could you explain a bit more here what is the unwanted behavior this
patch fixes?

> Signed-off-by: Oded Shimon <oded@istraresearch.com>
> ---
>     Fix git-bisect when show-branch is configured to run with pager

Usually subjects are something like:

bisect: make sure show-branch doesn't use a pager

Otherwise your patch looks good to me!

Thanks!
