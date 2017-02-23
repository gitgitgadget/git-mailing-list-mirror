Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CB520254
	for <e@80x24.org>; Thu, 23 Feb 2017 23:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdBWXFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:05:22 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36268 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdBWXFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:05:22 -0500
Received: by mail-pg0-f53.google.com with SMTP id s67so2266724pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m68MjCSCfqoJ6jzekbnTiNdy9dx/e4lBg8B4YoEuUOI=;
        b=SJC3VcrCMOC6RP+BAPmal6EY0Q723OQZjoCpU77TmlujwhYO1grT+lX0PcYpQ9tAaU
         h+rGu8iGSYxR2V4HtrM+Nn8CWXl8kIbk59o/+u2lcfbgjN3grnAP2ZDGTb6KqN8MFdAd
         s8R6w6aRTTB+ZM88qmFFmHJNFcUBCoLIw5fZZye5Z1X3x3kQShwv8hWTXNGbKgXyOrfI
         HHZ6Wt3Ol2U7p2SUbp621/u0YIQztGZQGBuEDHDGsJJXBmj5z2I2phCqvg6GQzB4/9Vr
         pI5kZOVxrRC3CQSEyGO32hIbLtSXbZWoci5ser/+Wv+7xol57plpdrkUGyI6h813Mu7T
         ot7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m68MjCSCfqoJ6jzekbnTiNdy9dx/e4lBg8B4YoEuUOI=;
        b=c4g2f9R7ws9g4rWI+T7DkVsgIkvwXIwue+BhFq1rTjQwIpH5RsErjAjf6M0uJ/Nkzf
         bMz8QX4rljlLCnWdnbV5MV2HpSER2D+LaoGNdmnu5ulsT7WMrRUngyrSN4I0nav8PvlU
         hIea98lpQ/QzNUC6VyEEnAgC6vlhxUnUIsyOu0XTu6noSOI3d76vUetOrx5T86VZ4vJ0
         vD31wsVIQdGtT4gExtb96wSdRm3Ifs4AvHiWgJyu9BsuZCLg8GnWgKUtGKkpiMpgSZn+
         pIllskm5G6U/gJcRDDQ0vikgHjpZwldop519F35wmliPvlbobmKQ2NUa7qx1//3OgyD9
         mkDA==
X-Gm-Message-State: AMke39lYvkonrTHcvGtzQof+UUgtwkqROjgNHts8SmPNr9Ygqf2vQN0rRQXdZ8JuyEKdmK6K
X-Received: by 10.98.66.82 with SMTP id p79mr48859054pfa.10.1487890690648;
        Thu, 23 Feb 2017 14:58:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id e129sm11623699pfe.8.2017.02.23.14.58.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:58:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 14/15] entry.c: update submodules when interesting
Date:   Thu, 23 Feb 2017 14:57:34 -0800
Message-Id: <20170223225735.10994-15-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/entry.c b/entry.c
index c6eea240b6..d2b512da90 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -146,6 +147,7 @@ static int write_entry(struct cache_entry *ce,
 	unsigned long size;
 	size_t wrote, newsize = 0;
 	struct stat st;
+	const struct submodule *sub;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
@@ -203,6 +205,10 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		sub = submodule_from_ce(ce);
+		if (sub)
+			return submodule_move_head(ce->name,
+				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -259,7 +265,31 @@ int checkout_entry(struct cache_entry *ce,
 	strbuf_add(&path, ce->name, ce_namelen(ce));
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
+		const struct submodule *sub;
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		/*
+		 * Needs to be checked before !changed returns early,
+		 * as the possibly empty directory was not changed
+		 */
+		sub = submodule_from_ce(ce);
+		if (sub) {
+			int err;
+			if (!is_submodule_populated_gently(ce->name, &err)) {
+				struct stat sb;
+				if (lstat(ce->name, &sb))
+					die(_("could not stat file '%s'"), ce->name);
+				if (!(st.st_mode & S_IFDIR))
+					unlink_or_warn(ce->name);
+
+				return submodule_move_head(ce->name,
+					NULL, oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
+			} else
+				return submodule_move_head(ce->name,
+					"HEAD", oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
+		}
+
 		if (!changed)
 			return 0;
 		if (!state->force) {
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

