Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A2C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB8360240
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhHKBtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhHKBtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 21:49:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF462C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:48:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a20so642417plm.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EDfSTpR85k2sJQxWd707yjJrTWsO93jjB+CZvt3NvM=;
        b=kKUJLeoYXhhJ82HwzLwBNMy7r9xvw4FiFyFioMAtnjf3CpPdV82T1SPjpsCy+v4TyP
         x6YIT6dNpPcJJiZB1PwOjGEFBuXjZ2m05GozS5Bp5JdH14FGXq5kEwR0OK/N+BDTVXNT
         rmOz0BHR2P9vacCsqlRT5vq5tMy0Wn54yh5yJi7S83VnBGI4ZBPRhf+FdgsUyckyAyxm
         UewCk82a9T5dxjfToOu2Z6q3S5y7mxMqt6SyEyUo0miWgSHdVasVIz01Ni1+vJ1aRyVn
         ZvB9P/JsVySFIuO4M/qkOIn0d9bYdsygwRb7NMArfT+QhvBE+J7rLdHmb8Z13UMx7Ewl
         HY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EDfSTpR85k2sJQxWd707yjJrTWsO93jjB+CZvt3NvM=;
        b=GOJH884c7C+fY5hVLMijmj2wn0LmtdANRNVq3wle4tNSf8yAW8+BzuO0Y/RVyg+PdQ
         mLDztYYfHnW3CuJN7CGMAweMlraLSqDQ3Y59HdaKu5eSNADBpFutkNqeoMiWVeXmyOZG
         FgskxumPVgFGNnbhP1RVqidd+Ta6t+UqJe5xOHqJXcRDfksUfXSAEmDzD7fA/iBrLhqj
         8v61q4+gHsejd14KCvvVRVlZs/WCfoeS/vuz7836sl7NYdx/RWLrDyy76vI4ZqdbwVIM
         xJUCcgVxt6mTXV8UejXPRcw2Nar3Tqu9fLsR7cFahXrJOXnYy9B4CduiWFx/S3KbfJQT
         xqiA==
X-Gm-Message-State: AOAM5317K56wmcQRMG/lb99GVIXvauodSLVHPtXs3dsCaaSVOqx0euHm
        pDJ9F00JfBrtURlnoZClTJs=
X-Google-Smtp-Source: ABdhPJxuIPX44fXVbVvGSF16obnjgpD7fycL3qaG+a6KtrfVGpiFq4MQs7Z5gy5bLKk5upunTDlZ/w==
X-Received: by 2002:a62:8042:0:b029:3cd:8339:7551 with SMTP id j63-20020a6280420000b02903cd83397551mr9149132pfd.79.1628646519463;
        Tue, 10 Aug 2021 18:48:39 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id v5sm4517962pjs.45.2021.08.10.18.48.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:48:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v3 0/3] packfile-uris: commit objects exclusio
Date:   Wed, 11 Aug 2021 09:48:33 +0800
Message-Id: <20210811014833.15753-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <87czr5s162.fsf@evledraar.gmail.com>
References: <87czr5s162.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>It looks like you provided the wrong base for the --range-diff (likely
>>master?), so it's not a diff against v2, just whatever you used as a
>>base.

Agree.
Sorry about that, the first use made a mistake. Maybe corrected next time :)

Thank you.
