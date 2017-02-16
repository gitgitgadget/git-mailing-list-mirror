Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A942013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756274AbdBPAjE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:39:04 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35327 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756255AbdBPAio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:44 -0500
Received: by mail-pf0-f176.google.com with SMTP id 202so796860pfx.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNEJVTBtITNIf1c6zZss12MRu6TOCKzvOelyuObDXys=;
        b=qa9uzMo1BHXwAJr6p9+v+1UsM4QH1bwUG005ZX+qRraFA9UYJqUEOrpiRXS7z9CIlo
         W33XARkM2BTEqIXcbhoBmRw4wZORxWAVaXQ0KKLytpn/+8tzNgInnPuK+EIFJrpB3pqk
         z+6DCyF1OgFma6xPTAbWph9xx9JmIP9qo8EoVANEk1/Fyxxk4pkF53cAmrVxRbjxRL0m
         LuxeNXnTA5ngzz5S9vwa76sXL5nIOaTDLALjsbVb1242HLU3oMd1cG1ix0JomrwTtV3e
         /O2IePB06D9A73OnCfpdfx9AKI4eQRMmKXwiebTjprHwZ+8ZyHq1SR0kYEDLRrXoh9zN
         /ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bNEJVTBtITNIf1c6zZss12MRu6TOCKzvOelyuObDXys=;
        b=bu+9+q84mUvSjtY4/OPVpC9O0tfimg0ZmdqRCsvDUpeH9YcJRftTkClH/D84l/li8W
         a8x8nKB4Y6vyihid7ON6sRHICUxglrNKZ2WJX3/VUyNBxBNKulWBxpt3/ktKVCWa5mvb
         wyQUoSp0bnGcJRdEC4Yf5yQIpx+MjvEll4vx1hD1JpEPaUOE2tK1t1QQS02vXs76nLqp
         xbqxAo84TlrZLgwZwhTje/y0u83RR77V+PRDZriNe6qbdpqPJ28CYEoqpj+MJJcDB1ZD
         r7TxnGOMuhBpxyNBG8uHubOA6HsTNv2K7MYezuP03dmTLeyim9X4R7U+AG8A6ONyFQ05
         623Q==
X-Gm-Message-State: AMke39m6bj7LdM3/xeZaej0f2e/7oF/Fhl7MkbjoAbePWEFHfgEBFzRI58+0wQf9zjoB5VwG
X-Received: by 10.99.121.195 with SMTP id u186mr42207653pgc.96.1487205518631;
        Wed, 15 Feb 2017 16:38:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id s65sm9525107pgb.64.2017.02.15.16.38.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:37 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/15] entry.c: update submodules when interesting
Date:   Wed, 15 Feb 2017 16:38:10 -0800
Message-Id: <20170216003811.18273-15-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/entry.c b/entry.c
index c6eea240b6..ae40611c97 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -203,6 +204,13 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
+				/*
+				 * force=1 is ok for any case as we did a dry
+				 * run before with appropriate force setting
+				 */
+				return submodule_go_from_to(ce->name,
+					NULL, oid_to_hex(&ce->oid), 0, 1);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -260,6 +268,26 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		/*
+		 * Needs to be checked before !changed returns early,
+		 * as the possibly empty directory was not changed
+		 */
+		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED)) {
+			int err;
+			if (!is_submodule_populated_gently(ce->name, &err)) {
+				struct stat sb;
+				if (lstat(ce->name, &sb))
+					die(_("could not stat file '%s'"), ce->name);
+				if (!(st.st_mode & S_IFDIR))
+					unlink_or_warn(ce->name);
+
+				return submodule_go_from_to(ce->name,
+					NULL, oid_to_hex(&ce->oid), 0, 1);
+			} else
+				return submodule_go_from_to(ce->name,
+					"HEAD", oid_to_hex(&ce->oid), 0, 1);
+		}
+
 		if (!changed)
 			return 0;
 		if (!state->force) {
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

