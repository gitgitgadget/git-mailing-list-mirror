Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39413C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 15:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiBAPt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiBAPt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 10:49:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E9C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 07:49:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h7so1099841wrc.5
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5d3e6n3PIIfd0cnwZWL2w+lorDihRslGDnOFhFknVJM=;
        b=p6UVBwTD5Z06UjYKxB3V/Fozq43RuOiVtvG9ZBuVNacNOwYFiz4NrB7w2TIbeGj9+m
         q2t3o0qc8D/Z/tliQBjrVrRrPh8cyxmU5I5ABpoz5uMFl4irPm1wIM7qySotGS+Oazj2
         ZQZOniogbb5StDAPkAbiixVRx8TUhm3YpwxirFpl1CWjOE3D/dMZgdxMCTlSjCQmC+Dp
         mWCV0D/iZOPrjM83yk6TiXsM9JAlOMpnLwwILWD4K4UqEkjrMOQd6e6NeHXBCUSO87Jy
         0ChCVTrJacMRkbqfBbAk8lIwnavSYKTOsPlTKgNax2yIC/gCyFODBGCBfGVBqoP+gTC/
         6ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5d3e6n3PIIfd0cnwZWL2w+lorDihRslGDnOFhFknVJM=;
        b=4bgq0wMMjK1xT1oW3gFZQDTg4kBlm4PpUi9j1CZVolHyK/e2NDYUMATU9fvWGoiqQq
         Dr0wSMUX1Qj0ZB0hWF+/+M2Dx0HGLPdD2q2HnoxiiJbag07sruGK17yTGMsOGJKjnuAb
         Xvqg9fYTpaJu1HLPc4aZg6epGxGaTuSFThvbKOWCyysrPL6DfjribzK95w2Xynnyno7G
         Fmf9w/S3zM9Zs/peQeyEhq54ahRyp6ic5t8DjLPv/qmdlc3H60yJWFwH93db4AcqjxFV
         RAl8xPvb8Z6y+TQOm1EJTIW8KywFVq2iovpS2MMCfeBcldqoy++cLpdfHEQ0PKQUpnrl
         u01w==
X-Gm-Message-State: AOAM532jyt9d9DGfb9Q0V24RVtR54+rD9qNInFo/Pyi9qIv+xVvv8G8a
        gkUBG+C5NNfSCgrGe0R3cPcj6BJBRKk=
X-Google-Smtp-Source: ABdhPJx4pHw68CUxVKreEWrfc1jJ6bb+ecldyUkpSU30d+pE2ZfCtGaIbfchZiQ5leRRt0UlZe1a9Q==
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr22179453wrh.301.1643730595870;
        Tue, 01 Feb 2022 07:49:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm2284741wma.48.2022.02.01.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:49:55 -0800 (PST)
Message-Id: <ca50ce77ae47268a3aab0c9366fad8a79ab8ecdb.1643730593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 15:49:48 +0000
Subject: [PATCH 1/6] fetch-negotiator: add specific noop initializor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a specific initializor for the noop fetch negotiator. This is
introduced to support allowing partial clones to skip commit negotiation
when refetching to apply a modified filter.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 fetch-negotiator.c | 5 +++++
 fetch-negotiator.h | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 273390229fe..fe316afbf03 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -23,3 +23,8 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 	}
 }
+
+void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator)
+{
+	noop_negotiator_init(negotiator);
+}
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index ea78868504b..e348905a1f0 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -53,7 +53,15 @@ struct fetch_negotiator {
 	void *data;
 };
 
+/*
+ * Initialize a negotiator based on the repository settings.
+ */
 void fetch_negotiator_init(struct repository *r,
 			   struct fetch_negotiator *negotiator);
 
+/*
+ * Initialize a noop negotiator.
+ */
+void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator);
+
 #endif
-- 
gitgitgadget

