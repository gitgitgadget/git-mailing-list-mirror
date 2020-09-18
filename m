Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921CCC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CD520DD4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwW9gfpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRWA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgIRWAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 18:00:25 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD2C0613CF
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:00:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y11so6420580qtn.9
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Da29aZww5fnBlbQKaGT8PulIMUy9KoUU8p3h+2QxMm0=;
        b=nwW9gfpu8nYFXVnyEW/jzLjPLJ/4nRIJzdWELPWO0kIr/bgQ00xIwiOVlTSxyMi5uw
         L2CL/6cjMrdhmnKK3TlIJDlulpkyXrMikmUD1DtGHW4BeZxfc5jA8dRPk0Ca+TWrL3tG
         81JvVJXulYzwtSVZMfQgvsHK3HTnNeKS6yhqpZoJSF9UOsF5LkVE4/7kuXNXDTHHSu1Z
         I1tQW6M751Pel7mG7leXriuExIDckflQHCs9JmxDLYcabwohfrD52dDarbd+QneAYOW1
         6gStX3qzh22tcpO/EviJl+PZztYC0Xjx83F1n4KhFgCIwdQsrKZz9LXYm4X4lZS+BFrU
         1olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Da29aZww5fnBlbQKaGT8PulIMUy9KoUU8p3h+2QxMm0=;
        b=SWZAjJNsOpTx5rw9LCcMYGPCmOtU40oLtS5SyFwZvLIzCbAbIYU1BCH5yEfMIxjuLl
         m5nVli8JignehauAH8COBjpogB+zzlnrwF+XEWRJqtU2xjRlS6Rhi1FkriibIEuwhU94
         t6cJKIYr9nOZdjrHItqATYD4u/CK7oQvbfc/zTw2MjL/muLo59bfcEbAfDG6PLozQRCn
         +OtvNu3cMI84ic172F7j1524rEHoXnsAWb7DIjjQA+vJlQl3H+Wmgo4LH08ITbycWJ+L
         GevXszN3rGuBGdRk8KWLV4zb7hL8CCUCVWXLF7KQB75nfm32VmzazSLtpTIknXYoaD/M
         FlnQ==
X-Gm-Message-State: AOAM532rWnV7WtkQHg56ob+kKqIcQMFgOLb5weEdTXuL69o+ix9F1zC6
        r9mKCnDkZboXfigFZjKOW6+prKES/xH8p1wV
X-Google-Smtp-Source: ABdhPJybBQYLotSrhIL0wzIcLnueqIa04Xj7TJvV6OWwUkMemc9HKfegMsV4EMjsMbvB00dW3Eh3Dg==
X-Received: by 2002:ac8:354c:: with SMTP id z12mr877793qtb.24.1600466424369;
        Fri, 18 Sep 2020 15:00:24 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id n144sm2994477qkn.69.2020.09.18.15.00.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 15:00:24 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v2 2/2] Doc: prefer more specific file name
Date:   Fri, 18 Sep 2020 17:58:42 -0400
Message-Id: <20200918215842.62232-3-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200918215842.62232-1-alipman88@gmail.com>
References: <20200918004909.32474-1-alipman88@gmail.com>
 <20200918215842.62232-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change filters.txt to ref-reachability-filters.txt in order to avoid
squatting on a file name that might be useful for another purpose.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 Documentation/git-branch.txt                                | 2 +-
 Documentation/git-for-each-ref.txt                          | 2 +-
 Documentation/git-tag.txt                                   | 2 +-
 Documentation/{filters.txt => ref-reachability-filters.txt} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/{filters.txt => ref-reachability-filters.txt} (100%)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 290b90639c..ace4ad3da8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -368,7 +368,7 @@ serve four related but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.
 
-include::filters.txt[]
+include::ref-reachability-filters.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7b9cf0ef1f..2962f85a50 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -409,7 +409,7 @@ will be reported.
 NOTES
 -----
 
-include::filters.txt[]
+include::ref-reachability-filters.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index cc667d7d01..56656d1be6 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -380,7 +380,7 @@ include::date-formats.txt[]
 NOTES
 -----
 
-include::filters.txt[]
+include::ref-reachability-filters.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/filters.txt b/Documentation/ref-reachability-filters.txt
similarity index 100%
rename from Documentation/filters.txt
rename to Documentation/ref-reachability-filters.txt
-- 
2.24.3 (Apple Git-128)

