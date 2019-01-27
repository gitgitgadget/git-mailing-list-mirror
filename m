Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142561F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfA0ToZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:44:25 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:37254 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfA0ToY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:44:24 -0500
Received: by mail-yw1-f74.google.com with SMTP id t192so8563410ywe.4
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W7uFzqyjRWxwkCF3xj4LWTSLlruZYya9JwjsYbq/8mE=;
        b=V5vXOxS9XpfCpIWVeFxgCRdZoKLAYbS/D//tHEfYD/oom8ZOuTN7opYSBxK+wlQ5wC
         BCV36zheyGq7x+f1H0zaEn95hVKcMPEw+Odolesb7NDx2K8GnwNZuqb4I3oqfgRWqUVc
         w7vLLpbtXL7gIHhFIjd7DN4Qp0bX2YcF4+f4UThFzIum4L1v4ufbyhlttdDmNvi1FX19
         6WxdN7zR7rE915KSqPquF8VsVSDGpFKIdkQywLKYUH7VShqEmoAST7waB9lu+nGS5Zo4
         Wr5jOd/0UOTWxwLEtqE5/OCDcw5JIferxh8MnoyWCpRAvouRMz3FECtdqhPi0iCFPJOK
         O+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W7uFzqyjRWxwkCF3xj4LWTSLlruZYya9JwjsYbq/8mE=;
        b=QXQxnLEgHffI5o09kzUhmZBzZaAFEpV+CYk4/5LfcCV39L5C1WzRCtt6P4BxAtscGb
         6AVV8EUaD2rULcAzQSJtfYbuPYXftUZ935/HZyZT26RPKY2nb2Y9RKD0ne+2I3tROGf1
         GlA4EqNyjP8MHHasbwq4cRmoMNh9i3Rx0UTTM/cFNwi7ZJ9Vb5keSBlbAusSU/mmkoU2
         AS//vTlKoIkQFAuqT4b3G+eaw9Vx9Znsag11hQF8Gg30CJTNdQEaYf4nGtKBVH83O+v5
         PjYWXlG4CHtRqXSGOA4Q1jg54SQG6kIMtV6KpXP5B0TrhXpMJsdlKEKvC2wr6/qf1PlJ
         ePSQ==
X-Gm-Message-State: AJcUukf9CEpm6XDlNW45eXiK2P9rqVA7WmK5LJvHYc3Yn4XuHWS0dCBm
        lgXhQEA53unG6Og5cHwJiEfw0HtVAAt75P6FQJW3mV4OpGtYWrgRAMVQkrLOpLae7LqTbirFk9C
        jRBMYUevgrtI+uS3ef1+9Oy/23Avrh97Nfh89DobQnYlNwaKIKQVVpm4aqg==
X-Google-Smtp-Source: ALg8bN7b7I4LBhnwPFgI4Oq4HewL14kTA1d1U7ggVzja9pIuiy5dxgGEvOg38Y9EPIuGQRhH5rvOe6CwSA8=
X-Received: by 2002:a25:818b:: with SMTP id p11mr8991536ybk.51.1548618263408;
 Sun, 27 Jan 2019 11:44:23 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:44:10 -0800
In-Reply-To: <20190127194415.171035-1-sxenos@google.com>
Message-Id: <20190127194415.171035-3-sxenos@google.com>
Mime-Version: 1.0
References: <20190127194415.171035-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH v3 3/8] ref-filter: Add the metas namespace to ref-filter
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

The metas namespace will contain refs for changes in progress. Add
support for searching this namespace.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 ref-filter.c | 8 ++++++--
 ref-filter.h | 5 +++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 422a9c9ae3..4d7bd06880 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1925,7 +1925,8 @@ static int ref_kind_from_refname(const char *refname)
 	} ref_kind[] = {
 		{ "refs/heads/" , FILTER_REFS_BRANCHES },
 		{ "refs/remotes/" , FILTER_REFS_REMOTES },
-		{ "refs/tags/", FILTER_REFS_TAGS}
+		{ "refs/tags/", FILTER_REFS_TAGS },
+		{ "refs/metas/", FILTER_REFS_CHANGES }
 	};
 
 	if (!strcmp(refname, "HEAD"))
@@ -1943,7 +1944,8 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 {
 	if (filter->kind == FILTER_REFS_BRANCHES ||
 	    filter->kind == FILTER_REFS_REMOTES ||
-	    filter->kind == FILTER_REFS_TAGS)
+	    filter->kind == FILTER_REFS_TAGS ||
+	    filter->kind == FILTER_REFS_CHANGES )
 		return filter->kind;
 	return ref_kind_from_refname(refname);
 }
@@ -2128,6 +2130,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind == FILTER_REFS_CHANGES)
+			ret = for_each_fullref_in("refs/metas/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind & FILTER_REFS_ALL)
 			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata, broken);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
diff --git a/ref-filter.h b/ref-filter.h
index 85c8ebc3b9..19a3e57845 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -18,9 +18,10 @@
 #define FILTER_REFS_BRANCHES       0x0004
 #define FILTER_REFS_REMOTES        0x0008
 #define FILTER_REFS_OTHERS         0x0010
-#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
-				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
+#define FILTER_REFS_CHANGES        0X0040
+#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
+				    FILTER_REFS_REMOTES | FILTER_REFS_CHANGES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
-- 
2.20.1.495.gaa96b0ce6b-goog

