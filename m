Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B163FC7EE23
	for <git@archiver.kernel.org>; Tue, 23 May 2023 19:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbjEWTt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjEWTty (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 15:49:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A05126
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:49:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d269d0086so87061b3a.2
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684871393; x=1687463393;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=buO2SZm/hTDHtyauS0vAYgxWuzagK3r6mYtthoqJvlg=;
        b=rH3WKFAwfb6TtpYDnb2WIrRTgWzaYk1GM/mJO57xh0uOvY7PUg2FOUj+/NfBG4iqIJ
         tEjn7WP2rTT0a0cWRpXdPFog/0wRjJiNHrpLITE3ineKq50mKVIfNa53ZnicIsRrrUST
         /4iyEMuZ3qFH1hHGBle0Qx245XG0SYjL9FXng/4wzLveGPB8c6xDvb3K5G4G3iLx4nGw
         vPtM4MWr9LiVmCEdZjxtXjEFedkRvpb7AwF/8hGRoGD/60tfrVa+qWhOOv7eQ4HfQqmR
         KoykB85C3MEnbeLM2GZDyR593acN9O8fcuh3E+yGGZGT/H+3Al/Ol76477KFvAA8pZKW
         1dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684871393; x=1687463393;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buO2SZm/hTDHtyauS0vAYgxWuzagK3r6mYtthoqJvlg=;
        b=DshXa5tx9U0hlQz7FSOSEW+60oTu+bc1b6mL4/tFOJcKz9hDx4iStyTSbKUrhuqtk+
         ny0TAtKW/EqfQdwdtgK1H5tt3/OPHkYSWiJbTWsLUG5xSSKGs/TwkZ70065OKx6XirIs
         x54Hcp/Bv2HYqGxABcv1hx8d06L2BhtzQzAmzgLtQbhsdT/C8/MnvcJU3IMDe52lsIW0
         uX9mEz7iCPwvJgFh/kPLr1cxzduK89iy/R2CAubOLoPVF6+E0coKezTOREZ8F7X9JKxS
         35UFDQhMU39ufbbG4hxCPVEGixsWP13RTzm9qQPRmlNIOfusuCEKxOx7f5KNaDxsu3fd
         TonQ==
X-Gm-Message-State: AC+VfDwtfpvFKmwRtEpaWMzD1JIv57uYYPwWhe9ig4vHE1V+y9XTllBx
        nyHyUibXTAaOQEm+Tir5hDW1AjgMDsd+s08=
X-Google-Smtp-Source: ACHHUZ7w1wYa09IECLeDgEYvSbApn+UgxZ4fQacxYWkap00h6WD+iXTZMyNRo6M7elhUjFKsxaxbP6uWEOWZK44=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:3905:b0:63b:608a:eeac with SMTP
 id fh5-20020a056a00390500b0063b608aeeacmr80735pfb.3.1684871393219; Tue, 23
 May 2023 12:49:53 -0700 (PDT)
Date:   Tue, 23 May 2023 19:49:49 +0000
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523194949.1285748-1-calvinwan@google.com>
Subject: Re: [PATCH v3 00/28] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
From:   Calvin Wan <calvinwan@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * a textual & semantic conflict with cw/strbuf-cleanup (affecting strbuf.c;
>    to address, delete the conflict region and also delete the include of
>    repository.h)

In patch 19, you also include path.h into strbuf.c because before my
series, strbuf.c had a dependency on repository.h. Since that dependency
is removed, there is no need to include path.h anymore.
