Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F2C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C593960FD7
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhHQQPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhHQQOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 12:14:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D52C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 09:14:22 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 61-20020a17090a09c3b029017897f47801so2986007pjo.8
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HEh2fUWZAz5kSAu5pPsgTlRcNP6AfyFlos2CCR4n4O8=;
        b=LfBLurfOG8uiVaJ9qwjWfAc/ZQ6x4yCaRml84P6UNHDSE/oADasDwI3zQxOIWI3Aoq
         IURetxfImhu9ue2Iop3geiRWb+YaGDL7qPfVgMX/7zacbcXRq6dY7gi2j4PS8TVGrier
         kqLbbcT8G4DC83FegzwmMcGbCpXN6h5IvhPNVahldElxV8VlYPUGKGZtd8tKSgLgHddv
         poInccDMfQ6gklrOqPhzHob66an4BLkVPK0Nt/qTPV71xt+b21o+pHJZPJBs5ILZ8O43
         wDGGNgWzfYgONyHTekYVv7n0eeU4FfQpWhkqISScicghMyve8RHFEd7+KFIiJtHjbpi/
         N9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HEh2fUWZAz5kSAu5pPsgTlRcNP6AfyFlos2CCR4n4O8=;
        b=M4/ZDbLNmTcbFj5efMbtPMdIZtyqTcFMuFBQLjM7Z7uGF5ZcUdbwS9tBMvzf5mGimr
         7ICycrL9yI54+pBHLn/YYr8/j7TIJaD11+qeeOXr4Hv0fG/INu6TOxkp+4UTiSPr2sz+
         8LPSU0I9QVUV0viGm2SPq2zqvwLU8CAR1ea+txBJRBtw6XhuZFCiSw8MP+aZJcLe+rBL
         to04ArOG3igoN51Rs2PjhoGH0X/yfelL/03F9IWcaRV3Z/jhAZieNec42QtZWlZtDg45
         YZtP38xFcomJbJdui+mkzd4KZhMvx2zFkuRl9RmkvGJ0eh+Yz6DVtzc7RtowbTB0NIum
         ZAvQ==
X-Gm-Message-State: AOAM532nJynF+Ym8gl1NAx58maPqxyyUYqalghK5GHvktrTBYCQ7Xr29
        WnBDIIBEK7/dWowr5N0aqX+Csk2yNHmBwtjuG5cU
X-Google-Smtp-Source: ABdhPJx/ca+1V5yvmxrlSKCbBL5ZhKaElXiVVuaBYC0GEKI3EFCA08POJ94UNaxuSCkWyyDJdBmxJ7W4d7I952kbfDfO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ab83:b0:12d:c574:98df with
 SMTP id f3-20020a170902ab8300b0012dc57498dfmr3492559plr.39.1629216861842;
 Tue, 17 Aug 2021 09:14:21 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:14:19 -0700
In-Reply-To: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
Message-Id: <20210817161419.3606302-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH] fixup! propagate errno from failing read
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, jonathantanmy@google.com,
        avarab@gmail.com, hanwenn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0d96eeba61b..f546cc3cc3d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -454,6 +454,7 @@ stat_ref:
>  	}
>  	strbuf_reset(&sb_contents);
>  	if (strbuf_read(&sb_contents, fd, 256) < 0) {
> +		myerr = errno;
>  		close(fd);
>  		goto out;
>  	}

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Thanks - a straightforward fixup. (I don't think we need the errno from
close() in this case.)
