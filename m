Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A9A1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfBQKLO (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37337 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so7005407pgq.4
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aO6JsWlsIB4B7n1GsPODL8zSy1r5yYtHNSmotuyvrkU=;
        b=eqb/6ZwfvRIaAyN7DFVL9mGLozxQGJOTbi6HJnDFG7OyLs2srKOqFji7PwcNc9jRAo
         4iPz0F7pZR9NLDeQbWKF2PnE0TphYQJhkxY9HWN4lF6Bg0EAppiLoBCC6CmCOrZd1N2s
         ofY01HOjbEM91i3/iu4Xfs01ZUoIfc2jq/Y8xI4UNvirAXcO4KyhpRb94NcUNqFDlPht
         m9VYBzC3bl9gJnVSWeKz6yfnwmSYonWJ4rNYMNqnTvq0zbrLlnkHjEA8d9NLN1fEsSDh
         Xns8YqAXkuaeygA4SvSn4nh3Y361Hv5uX1z4+2wwtiI1523f2u20j6+RFs+qD2LY9HJp
         /kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aO6JsWlsIB4B7n1GsPODL8zSy1r5yYtHNSmotuyvrkU=;
        b=t2vVuAh6sokv1yafwJ/3dXwOhxz1RTDLTv4UjPK3B75U6mMhBVVaXsdsQgHddLyxhr
         WeYxYpVQ4gSrzBsZIbNch9NW/L67Hckn38yAuUC9qmEo+LLnDoUaYErlAj86goq3JaSF
         eEIgq3IgxU3aqsWval9YvahIFh3OD5RQb6B/5wogeFv3q2JS1jUCSfstZZLGKFPaWpLo
         6jmYke4+DGPUmuJTOeMkGMTq4Ozpr6FdXFyKCDGyk05KfDs33w2TbcVQMAxuzqZ8M7dO
         Z5dd+Eq0qo7Z8TRq1VGBtQiKTff71nRxn8+EEf/lkWTeOyayUvt6YLixF67eh5XBtyHl
         OH/Q==
X-Gm-Message-State: AHQUAubg2XVgjDc9LH+7tFu7KIyS4VW6GzRm7APQge8AIvWVFQ/nViBC
        XRXw6MHAIGKQk+MOQXBXlum0ovlv
X-Google-Smtp-Source: AHgI3IYi8LJEvmbvxz1SlqByEZuyAs4DG+XmfoZCscjOxPVTAnpOPCRCiF+S7OHo3nu3QDEu/zStIg==
X-Received: by 2002:a63:df09:: with SMTP id u9mr17358102pgg.299.1550398273082;
        Sun, 17 Feb 2019 02:11:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e24sm13827742pfi.153.2019.02.17.02.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/31] sha1-name.c: remove the_repo from get_oid_with_context_1()
Date:   Sun, 17 Feb 2019 17:09:08 +0700
Message-Id: <20190217100913.4127-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6b53ea2eeb..64a50d1291 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "submodule.h"
 #include "midx.h"
 #include "commit-reach.h"
 
@@ -1797,7 +1798,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			oc->path = xstrdup(cp);
 
 		if (!repo->index->cache)
-			repo_read_index(the_repository);
+			repo_read_index(repo);
 		pos = index_name_pos(repo->index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -1842,6 +1843,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
+			/*
+			 * NEEDSWORK: Eventually get_tree_entry*() should
+			 * learn to take struct repository directly and we
+			 * would not need to inject submodule odb to the
+			 * in-core odb.
+			 */
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
 				ret = get_tree_entry_follow_symlinks(&tree_oid,
 					filename, oid, &oc->symlink_path,
-- 
2.21.0.rc0.328.g0e39304f8d

