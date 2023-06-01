Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9771CC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 23:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjFAXiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFAXiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 19:38:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC7184
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 16:38:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5693862c618so11757147b3.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685662730; x=1688254730;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXd/aZCINNTBN4N1CziJdSCBIBrhuVYCf4kmp/YJdoo=;
        b=LcHA2GgHq7gYmd3kaeMcPD1fAuI0lQkNqDYidxJlzjN0p/sgYGohAOWxAX5pH9agTC
         X0QRR+c8bO2VtbyRRJvSCyBhAhynnBj0+b76OXmJbKSqezxFgoEbQHlfr2ytmRnTIMec
         Q+/8Oc+C6V3Y/hyCqbAQpEyhXm107nWUkr31vuzbc0Ok1bTi6Wp256Zo7HbHri7NBReI
         vJ6MeMf2eB289D1Ui8soSQ3VAQMEJEZblmgoXLCkbxqJLGXTpUKZAbeFht4idA+0WuZl
         X9QunKIZXUt/PFawyLiQQ1UMOedHfRhO9SVVrlHtHdIJDJqwZsEHbHAZ8ORJX5utitJX
         Cx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662730; x=1688254730;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXd/aZCINNTBN4N1CziJdSCBIBrhuVYCf4kmp/YJdoo=;
        b=Ugj5YF/n7NCNuaEyg22BufmvPOc5oBXSxZ8jQ6cEi5M6aR4cG/L5jSkBdRgkLcwh01
         wvG7GXCey50v5wUQgnaF+JlpuUDV05ZcHEuR6U15RmbPez+xs4MeiGvFejJPWlsRGLRc
         URZIonBTyPn/LyTrZOSC1tc1vmL2lT4QPAmFyQv9ApXGByaU0J2n0SBsOQyueDQ52qzc
         CvUbuJJvpEYBhafYV2KHDISIyiMx8AeBlk/SZS9QJiEeAwjAENZBr7Wg/QRk7Ahyek/1
         1RixjO+igZdHFr/2PEXux5Dw1s6KcJlVgV0nWsWQqAomSKu4QRafN77i5sAGYaW8oYSQ
         yTYA==
X-Gm-Message-State: AC+VfDznm+fGKWcDr13Yp1ZonFO6+fq7PmqqOz8uYG42leUKZhDzQZPc
        Jmea+cK5INcdwXyayoT42/Q3/yxYbvzGYuqn9Re7
X-Google-Smtp-Source: ACHHUZ48WvdMqx7JCzQ1Z7/moRllBvhNQB4As/YQX8W40WFu0ybiOV5LrGdlmY9bpnaxkSn6dqt0Y4/EKYzXYFauUZb3
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bc50:0:b0:ba8:918a:ceec with
 SMTP id d16-20020a25bc50000000b00ba8918aceecmr666837ybk.4.1685662729932; Thu,
 01 Jun 2023 16:38:49 -0700 (PDT)
Date:   Thu,  1 Jun 2023 16:38:47 -0700
In-Reply-To: <7dc0c46b864665dad87a5e0e32c6a8c36afa4673.1685472134.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601233847.430492-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 10/14] trace2: plumb config kvi
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>

Thanks - a mechanical code change that allows for quite some code to be
removed. Looks good.
 
