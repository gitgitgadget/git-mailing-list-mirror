Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15891F453
	for <e@80x24.org>; Fri, 15 Feb 2019 04:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfBOEbY (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 23:31:24 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45402 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfBOEbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 23:31:23 -0500
Received: by mail-pf1-f201.google.com with SMTP id 74so6565482pfk.12
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 20:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6BCP5N9rpIJFppG4ZsdNfLckSwLH1p6veq7OYlKz9Jk=;
        b=dSraxzmueU9FROSmBuNRqYgiOLJE5VVFHKT6R4QKN3FmgPSwr95p+9xlQYSZXwCn41
         82qbZjuNDw2Qq0EV/8WSaCRXLZuoQVui71RZGg+PdA8aZnig+WvzF/Ak9z/Lsv/66LkA
         +mOy7DH0+yMvMFz63Ayd+EH5lic43OkWFIMgwun7ByyCVu1uJh2U+egtYL1pa2uiy2hR
         EsanX/1ujk+4hnhQbIbSiNaRMRgBuo4v4Sw20ROQHOUtXrZ5Tp88o7eXTwf4GRAoGjGn
         TbUPqhoW2Ai448L4aQfz30s+hb9VU06DNqe/9+H9HU3O4pWD0P0qVccDLapOg5IX7SMl
         cGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6BCP5N9rpIJFppG4ZsdNfLckSwLH1p6veq7OYlKz9Jk=;
        b=MlIUs30l9zic0eV11ra1pXPrgrzP4Lngkunmex2J6lkiC7HuX7MKEeSscvX9GNhyVt
         dUvTjR4B7CWFIayJufP9ViC67KjWjdKBZfo8Vw68v+uBwbPtcwdXsBtAPXIXf4LNrvjK
         4B3mbmrYkzgsRZTymkbx5bHs2KLN4fLwrI89YrP5L53nv9DHXY+OEpgg4zyfociHAuZ+
         j5l4Yl2vs3rorbwOAQCjel7wUraao14YikhyK2GPTgRUgjbPmeuMUKbG98DkoVeFWVgJ
         Q+XHz7By2MPHfiIQXt/GPaXskvQLpGiGVdBETN6Ub8AEbZlWM0c7Goauj0HWtZQDtioF
         Uy/A==
X-Gm-Message-State: AHQUAuYG4acBE/pUf0qUxKizSXcDm6p0AYEDq4k0rHKzTNCnBiUkxy5g
        42IbvCcV8ED0qm6Je0C0mdTAhV2pOntLCACz+7tvhj91IHOB4mQeBNxnXlSr/n4Wv8njSM4w3+6
        J5iHgQJ+5GvIpUNySln7CJyPT7d2oB5CTpCHfoBuyVxOQls6c8Cw+cgB5dA==
X-Google-Smtp-Source: AHgI3IaBvDlV89FpCZrK9hp8eIO5t9ilzg/JPbO2SQ5wRc8FEUbxN97OS03VcVmIHhW+TAeRXp1S4MbPzJ8=
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr2291808plt.37.1550205083104;
 Thu, 14 Feb 2019 20:31:23 -0800 (PST)
Date:   Thu, 14 Feb 2019 20:31:00 -0800
In-Reply-To: <20190215043105.163688-1-sxenos@google.com>
Message-Id: <20190215043105.163688-3-sxenos@google.com>
Mime-Version: 1.0
References: <20190215043105.163688-1-sxenos@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v5 3/8] ref-filter: add the metas namespace to ref-filter
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
2.21.0.rc0.258.g878e2cd30e-goog

