Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B9CE79D0
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjITN1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjITN1r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:27:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7DD9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:27:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578a91ac815so1840899a12.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695216458; x=1695821258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR5VKuZEr7n6xLz3aad9GUltN2ms9C4oUwdEBALOgLk=;
        b=AZTN0pqSLNE3teO0AkLRsrUJDts575IRC8ZnVLCQb0YO4w6HWMu0hPfI2JIPf9wKsF
         z4thbnVuIG7TQMjihAQ/EnK+mXHGg1tbPJ718dk1MIoEgXMRiSmex9P4OfUCWBL98EoA
         1QA2nB5RXr0785xxjxF8e2PmVOpZNVx67DngDGUDOeTLThP7n+IX++DbfbJI+5QwdaLB
         nMYq2Bhy+CBo2Fgq6H/qExuW3w+KN8xYOig+N8Dt0oFBMP216od/nL4AGkaWdwuzPlR1
         3lhF++ZfOkutSt62n/GsO6V4G/qEEREzf0Hueg/DqLy6oDPkt+o0V0lXWxLDhDE2CdWy
         8Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216458; x=1695821258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR5VKuZEr7n6xLz3aad9GUltN2ms9C4oUwdEBALOgLk=;
        b=tVk4yDpuDrMZZEWvBNcmi6URv4DLeTufd+Cpz2m1QOVsB321o+D2aFb7/WTiKFHktF
         aqQkVK0dzR8iQ3Vk/yzKVbBKYul21C+JgemqjeNSbdvyCkYBKqYo872ZWyJd0R1JdgSJ
         yYcwP+FUEN6fxR9xokUKFJqI21J21IDRvFA116UhFYdAr0Fnqp1inzsj2k1S85HECGH4
         xBEDL4nmAhgvbdUDl1MNt5DsIiCtyt+Ba5Oib1JfGCzRyhJsqfZJ50GMgHPXWsZTvU3I
         5UYvx4Ecb48vm7q6lGoeus+FUs+BZE7wFg/87vDpQKUQNEKWIcB0bC0octLI0BfrquHl
         IXOQ==
X-Gm-Message-State: AOJu0YxSixMAJOaHRWY5DrjncXxlIi5DVp52G7miZOIXtkgeLrBBxI3q
        ZrzoOyOJVMebCY/yaTvsTNt06J7dsmB4x+WDsW8=
X-Google-Smtp-Source: AGHT+IHk2A76fd+TmN+kn5OfYThAKz6oaeeik2priv6MVaXR2GFUEsKLBItnQ0f8ruI44jlZG6RpyQ==
X-Received: by 2002:a17:90b:1b4c:b0:268:5558:de4c with SMTP id nv12-20020a17090b1b4c00b002685558de4cmr2637108pjb.38.1695216458270;
        Wed, 20 Sep 2023 06:27:38 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a01da00b00268b9862343sm1433048pjd.24.2023.09.20.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:27:37 -0700 (PDT)
From:   Han Young <hanyang.tony@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2] show doc: redirect user to git log manual instead of git diff-tree
Date:   Wed, 20 Sep 2023 21:27:31 +0800
Message-ID: <20230920132731.1259-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905121219.69762-1-hanyang.tony@bytedance.com>
References: <20230905121219.69762-1-hanyang.tony@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While git show accepts options that apply to the git diff-tree command,
some options do not make sense in the context of git show.
The options of git show are handled using the machinery of git log.
The git log manual page is a better place to look into than git diff-tree
for options that are not in the git show manual page.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
Changes since v1:
* change wording to clarify not all options of `git log` are meant for `git show`

 Documentation/git-show.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b1bc7288d..fc46b3687b 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -26,7 +26,7 @@ with --name-only).
 
 For plain blobs, it shows the plain contents.
 
-The command takes options applicable to the 'git diff-tree' command to
+Some options that 'git log' command understands can be used to
 control how the changes the commit introduces are shown.
 
 This manual page describes only the most frequently used options.
-- 
2.42.0

