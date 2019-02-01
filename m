Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8312C1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 03:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBADJk (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 22:09:40 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38387 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBADJk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 22:09:40 -0500
Received: by mail-qt1-f202.google.com with SMTP id n45so6285256qta.5
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 19:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Lr0OpRd8HFWJHfsn+W7tweEnZNsFBr+7hXWdXRCxCMg=;
        b=UeALuU3CaPD96yaOg5QA4ZdUbIoD8muUTlA6I9e2N1C0NUo3TncuoIg+XQcjdMIqNu
         fkKy4hs/dKzwKQ34JXHINpN8QXYKJPuhSMcGQedpDq7/MUlQRg0LHaOWbo2lPAfWgrwU
         y2fcZZTun5trhIGVxqeD1vL+XXIGBcpNElEhtHDzzUGxOlBoIeT+1cJ8cQXDQSGZD4Gz
         Q4bFJhmAkj9aJrr8WJb/zMpMKFJeMg2iRKThhow2hbgcCdkigrYOGuvONouZaBiRC3ZF
         cd/VrxcTnx63+6yPVCDFsnBwU7BH3ZPAij67fkS8EQ3YPa20Vnq8/Ld1ejiaWCodKJbr
         B9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Lr0OpRd8HFWJHfsn+W7tweEnZNsFBr+7hXWdXRCxCMg=;
        b=YTpL5Ok/c7vSi0uHwATQE99mh1NF4UrIKPYqDdVIVIQFfvQOBw8h7lEKbQWoeLdASP
         QkMF8wTi+JqQiHNjFLIGaoZ9iWntTVaSKMrh5wb1qiMjvkjtHkpwSYy7HVRCVjBfICsK
         QEd+ZBGKys1oheroECBfuKTCyyuabgxOMepKegwBZHZB982vz6VMSo9l0ABhX+Oy4dLA
         tPRGf3xIOAyQS/T1MSkSY3jfUcLQYyiI5WYLtWoQJYuvjNQMU9l/zHV6BloCsfOOkBxl
         PePxFekm/cE1wyNacGCMj9icLTw0a6fvLhjnrAwRB4A7NDUh9ygxThGFqYIp2BtE1obt
         ce9w==
X-Gm-Message-State: AHQUAuYkQinoW/kiYxramvb+BWnCOWEa+W6/F/L/7ML64pDlO/+DiWiM
        YTJveK+79usNKFP0rqaCCmABfhAt+jTrBPBK6hTEVq8Dy0rcM7pNzhOWGUG8Xjq5Fnw/jVPjRex
        1suw8UlRGJLMpLeDWRO45+qg4QU1a56zEkCyhd1qrct7XawUyvW+P0aGy0w==
X-Google-Smtp-Source: AHgI3Iai+Y4OAjA8LROxSU3NnLYkfSeYrpShzNlsLmlVfrrzLeH6wwcgXR/Cigzg9Cu+lbtqkksrfYNHV68=
X-Received: by 2002:a0c:9199:: with SMTP id n25mr11354974qvn.49.1548990578935;
 Thu, 31 Jan 2019 19:09:38 -0800 (PST)
Date:   Thu, 31 Jan 2019 19:09:20 -0800
In-Reply-To: <20190201030925.177124-1-sxenos@google.com>
Message-Id: <20190201030925.177124-3-sxenos@google.com>
Mime-Version: 1.0
References: <20190201030925.177124-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH v4 3/8] ref-filter: add the metas namespace to ref-filter
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
2.20.1.611.gfbb209baf1-goog

