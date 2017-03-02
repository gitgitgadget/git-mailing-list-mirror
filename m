Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6DB2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbdCBA4z (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:56:55 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32777 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753799AbdCBA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:56:50 -0500
Received: by mail-pg0-f54.google.com with SMTP id 25so25863051pgy.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lITrand8zpEeDnZmIEIDLdKwy2lAuYQ5IvJ8E6kjfeY=;
        b=wN+trQvcMO5FlUQ34wWjsxHUZin8HSwhpUlL+PVawQjQYLcnWbf5nTMSr34K5rjIsM
         gXjz9DqTEGeQrdSMHWDkalznIPga/Zln331t12u0ThB6clJyJ3S5oQFGk04X36C40SG8
         C4nfSUGyIwbnXsiATxzPh38gjMUH2+4nfAHR8y+rb4hqu6YfGsUSSOeHQnf/2HrIWq8f
         Zr5+CFey3Knpfm+kYkrR6BPu79kuKmE7RnvHkCqzwuJ6+IslSVsXKbwE3hmLa4h90fS0
         bvr+etQxmYViakeSSsnReMVT3ELTn2YF3hVNQ4udYOMkxP3G9LduSZxz1M5J4/KrBCon
         bLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lITrand8zpEeDnZmIEIDLdKwy2lAuYQ5IvJ8E6kjfeY=;
        b=GnEyXEUWTTAc1e4qlE6EwGu1SrXA0hFiHsVC8eNh647Jw2f20qHeV0hroCv+rl8ePC
         i0A+/QqjBne5MfVqs/7o4jdTIfLoRRxpc2BwD8JUsK+2/NTI3Kl0RztZQh/liKvVOahg
         dEPMOLLpqqhKju5QMkBu13NWUEJD/RKpu2qBLxpB5kvu2IIG+AUsdHM8u/E+oy3TqKCW
         pEgFKJR3+b/wMxLYpAxTckQfX5zaTLQjJZl2nDIp1K1TrCAUZDqHBTQUMwaM7JgKmFhM
         FfLQeGu1A2NXBLcphETsjiGlgBa1hEKZtstXO0Vsq7VuPcszZ57nce0l6N3aeSWYyQNQ
         EUfg==
X-Gm-Message-State: AMke39kwJiQ/Y9or7W3q09Rykj5ICq1SMsHZQCukTSv1CiEHFIiboXgGwMMYFrxbQxO95Qi4
X-Received: by 10.84.232.9 with SMTP id h9mr14458446plk.102.1488415704317;
        Wed, 01 Mar 2017 16:48:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id 10sm12751797pfs.113.2017.03.01.16.48.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 16/18] entry.c: update submodules when interesting
Date:   Wed,  1 Mar 2017 16:47:57 -0800
Message-Id: <20170302004759.27852-17-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
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
2.12.0.rc1.52.ge239d7e709.dirty

