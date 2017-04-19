Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E621FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762542AbdDSLCc (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36703 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762535AbdDSLCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so2085982pfd.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeYaCnnXTdd9dpk3dELboTJ/OJrss+vnfRZRl1BGS5U=;
        b=mCwqKSWMpIONFHkrmm5ej74xub/6j81r79L4Xo11XnRN7VPmFwA+oz7lMIBLBRpzgq
         DKHAQEu/6+1pH93uXd5RQ77iJ1LGB12hSML0KiiAvuwKLZvxyZAe5S+rHLQGEKysYJgh
         0q3g+madHF++wRoyL7oggQEypAeZxN7JSXmgc6QZOITDDc1lMfKtmYyLt2Msmtdhg9VB
         p9M4dgAqqecktGOc5VVH7V2YqcMslMooNXFYn4gM4zdmDhy8JA7ZGCJf7i4Jqamokab6
         tWr71gg2ulwVjdgkKBXsLrjEAs605r33SgTscNdt2OQGCgzlGegxsxHh1Eht0SosT9/n
         ymcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeYaCnnXTdd9dpk3dELboTJ/OJrss+vnfRZRl1BGS5U=;
        b=aVws3CMCC5RqHJ+lGwZe+NZpp4ma48JuaZw6MF4N0F3iAC2a4aAQ0+TvPj3Xdf3003
         FtKY0iEKrta0w5tfBM/P9+kJKzQ2rfMyFvh2MUPDPXWS4wBFWNGEhQPs2PLvEkQcBLxa
         61MDk6eiRk7b8cdKRAEbF0RwL45iiFkRD8fmk2db55qfM43CcowbYhcJzOh0v4Zj8iUc
         +jfMV2FZYl/QxSPFURrWoKkoJZGCOMzqYOq+boszwmobv2wDvqXkiqIhiNBljcR9ZWhd
         auS+5SdXYDXcKAo9gJ+T7UHXbIrfSavnAfk76W99rEgyV6lVsIvPB7OcJLBKQVlSKgmu
         6vbA==
X-Gm-Message-State: AN3rC/46/sM1eSVMsFRP7pShL6ImkG00J7j6H/bdY6LtMUFc+kSJDrKs
        28st1jPCvI/3kA==
X-Received: by 10.99.131.66 with SMTP id h63mr2489026pge.39.1492599750000;
        Wed, 19 Apr 2017 04:02:30 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id q136sm3983266pfq.80.2017.04.19.04.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 05/12] refs: move submodule slash stripping code to get_submodule_ref_store
Date:   Wed, 19 Apr 2017 18:01:38 +0700
Message-Id: <20170419110145.5086-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a better place that will benefit all submodule callers instead
of just resolve_gitlink_ref()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 5902a3d9e5..26474cb62a 100644
--- a/refs.c
+++ b/refs.c
@@ -1422,25 +1422,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 int resolve_gitlink_ref(const char *submodule, const char *refname,
 			unsigned char *sha1)
 {
-	size_t len = strlen(submodule);
 	struct ref_store *refs;
 	int flags;
 
-	while (len && submodule[len - 1] == '/')
-		len--;
-
-	if (!len)
-		return -1;
-
-	if (submodule[len]) {
-		/* We need to strip off one or more trailing slashes */
-		char *stripped = xmemdupz(submodule, len);
-
-		refs = get_submodule_ref_store(stripped);
-		free(stripped);
-	} else {
-		refs = get_submodule_ref_store(submodule);
-	}
+	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
@@ -1558,7 +1543,17 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
+	char *to_free = NULL;
 	int ret;
+	size_t len;
+
+	if (submodule) {
+		len = strlen(submodule);
+		while (len && submodule[len - 1] == '/')
+			len--;
+		if (!len)
+			submodule = NULL;
+	}
 
 	if (!submodule || !*submodule) {
 		/*
@@ -1568,6 +1563,10 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		return get_main_ref_store();
 	}
 
+	if (submodule[len])
+		/* We need to strip off one or more trailing slashes */
+		submodule = to_free = xmemdupz(submodule, len);
+
 	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
 	if (refs)
 		goto done;
@@ -1589,6 +1588,8 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 done:
 	strbuf_release(&submodule_sb);
+	free(to_free);
+
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

