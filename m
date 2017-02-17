Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D762520136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934115AbdBQOF1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:05:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35892 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934107AbdBQOFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:05:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id a123so2263829pgc.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evfGn8o94DEvpV0zQGPapG7RSgKBGjkAXfX14m8kLAI=;
        b=QC/jeTAjMyKnwMaKMIYK/W9Ld9I+gA0knNaydkswiG4bkju8nFCh1SDlQH4hRd0fqk
         sXIqzb90EyXzbwbNTTiXA3va0L2I1K0wN7Skfm3l4VXXrQ3O19aShr8ZPHen8DarVJ4j
         tcacwnt1KD4du++Au8/JR8Mub1VgtNHtuT9CwEFWphJJ5XC8PybTOKYp18st2EPHQopv
         wQH8srLeMPv7bhgUD/SgpQOejk3snpLnaW74kxOBalk3MBNzaE4u6uVFe/34gfL7ng0/
         MQQEUiJrlP9rtA+ZWFQwEoTsp3u5HcaxHJZvmH1mZ853/Klj9vVlWR6uGAUpB0pPyRtA
         CH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evfGn8o94DEvpV0zQGPapG7RSgKBGjkAXfX14m8kLAI=;
        b=e58GxgfPznMytq0J+yYCZra8A3QUkTEbXcdFOEM/V1Or5rCnE7qjZVJbYQItwmROgg
         0/zylgnxdZAcE4WzNUsNttMGdbWJ2Il2MGGKa5+1hEEmZYZ/JL+h9R/dljFTfjfDgRPd
         PbEZOROQN8nwR3lQgMN/Y3WWIoHY/k2Qo5+KUB5g4tMZccFph7OkIYj2kfiqGj908cS8
         7i+ynL6XTS8YVkS54d/WfpSxtfVfPUPNlaezXq5EgeOGtjOR7UbeKc2OkFM/u6eRJ+6U
         vaxQ3iVEzQKSO6VDFBzTOVU6/VuhV4a5femVuQjwYsbZWcFnf3nEw6aKsF7IH+ma78c9
         eGVw==
X-Gm-Message-State: AMke39lDf73ImypIpxoFGhXg27tgB5kpvLdVIoPmy1/ofQtxey3/3IA1x3T99M9RdiyNig==
X-Received: by 10.98.159.80 with SMTP id g77mr9561632pfe.34.1487340324358;
        Fri, 17 Feb 2017 06:05:24 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id e127sm19969559pfh.89.2017.02.17.06.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:05:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:05:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 05/16] refs.c: share is_per_worktree_ref() to files-backend.c
Date:   Fri, 17 Feb 2017 21:04:25 +0700
Message-Id: <20170217140436.17336-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 6 ------
 refs/refs-internal.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 4f845798b..7a474198e 100644
--- a/refs.c
+++ b/refs.c
@@ -489,12 +489,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-static int is_per_worktree_ref(const char *refname)
-{
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
-}
-
 static int is_pseudoref_syntax(const char *refname)
 {
 	const char *c;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 59e65958a..f4aed49f5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -651,4 +651,10 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 				    int resolve_flags,
 				    unsigned char *sha1, int *flags);
 
+static inline int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/bisect/");
+}
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.11.0.157.gd943d85

