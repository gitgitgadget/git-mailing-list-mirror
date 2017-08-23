Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CDB20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbdHWMiw (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33908 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdHWMiv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id m6so1358670pfm.1
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28rKnlXYs6kYHBnlm++mrR55QXgMpBoLmUv45KoF/QM=;
        b=NjnlHwTAhdLNCJImAZrzMuE7RHuqM/WEkdZcNKvBVG1RPnZ+zSbNfe6+vUt4F5gTGq
         NCQimAhcKzD8gghcxvU81FHcVifip70UYqD1UAkidGgVoDExDAsMYEflJ400A1jFPlDU
         SIyy6PESRES2PCorSUJO/+isnGzQAZ3z7Zb9lW6t9JiB5YAw38Fej/p4RIidTchoOf07
         7LQtyRJAHr8VofxSZ1Kk30HIWwTLJEDIutfFWkDD6/jxa07vfDDmQWDXb1DCNhC6MlaY
         USsyxnAMtIErf1zGM/wRMKD+fOavyg0Lw8zJVLGobww/OSf+PehgdkmXYCWRM6qU3+JX
         6C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28rKnlXYs6kYHBnlm++mrR55QXgMpBoLmUv45KoF/QM=;
        b=QZUV1dkp3asjCQm2DDAClXSaMq3oncenCkCs0kgtxlY1KP9CA+1G5dUhhHLeJ95dg7
         5DD9xHy9iDZyx5QoTDF4UxEDXfAXI2HswL88zF9q3xPV/aSPAAR9iRr006vnkPHVKr/X
         /RdrlnfkLtQkWX9DPV5VIFJCtsbPk6rr1D/CyUcSPXqspBCBwEMio60dedXZZl9hw/CH
         /aSqRktlWJHfapv/COHknF30WcbouJDDlSoGxgbrHlOhGddws584CdU2nbDGFASBVH9h
         G5rK3uhZJJcQz4AN1T/PSXniDRGBhx5VuzbMx1wZhAYIwyvIjW/tBcz6Cv7z8ZzkVoR3
         Fzbw==
X-Gm-Message-State: AHYfb5iqJMaCVwivC8DTHuSHiE2XPkfIeL5EuUZnckLTrJL4kyUwT6L7
        dEH910UD0p/x3xmo
X-Received: by 10.99.106.193 with SMTP id f184mr2552237pgc.290.1503491931192;
        Wed, 23 Aug 2017 05:38:51 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id q133sm2944109pfq.31.2017.08.23.05.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 15/16] refs.c: remove fallback-to-main-store code get_submodule_ref_store()
Date:   Wed, 23 Aug 2017 19:37:03 +0700
Message-Id: <20170823123704.16518-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this state, there are three get_submodule_ref_store() callers:

 - for_each_remote_ref_submodule()
 - handle_revision_pseudo_opt()
 - resolve_gitlink_ref()

The first two deal explicitly with submodules (and we should never fall
back to the main ref store as a result). They are only called from
submodule.c:

 - find_first_merges()
 - submodule_needs_pushing()
 - push_submodule()

The last one, as its name implies, deals only with submodules too, and
the "submodule" (path) argument must be a non-NULL, non-empty string.

So, this "if NULL or empty string" code block should never ever
trigger. And it's wrong to fall back to the main ref store
anyway. Delete it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 8c989ffec7..a0c5078901 100644
--- a/refs.c
+++ b/refs.c
@@ -1587,6 +1587,9 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	char *to_free = NULL;
 	size_t len;
 
+	if (!submodule)
+		return NULL;
+
 	if (submodule) {
 		len = strlen(submodule);
 		while (len && is_dir_sep(submodule[len - 1]))
@@ -1595,14 +1598,6 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 			return NULL;
 	}
 
-	if (!submodule || !*submodule) {
-		/*
-		 * FIXME: This case is ideally not allowed. But that
-		 * can't happen until we clean up all the callers.
-		 */
-		return get_main_ref_store();
-	}
-
 	if (submodule[len])
 		/* We need to strip off one or more trailing slashes */
 		submodule = to_free = xmemdupz(submodule, len);
-- 
2.11.0.157.gd943d85

