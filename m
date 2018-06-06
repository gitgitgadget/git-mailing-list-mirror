Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1621F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeFFRDN (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33411 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933029AbeFFRDI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:08 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so10255789lfy.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vo/2t6NMbbosw+fR2n87KMjYthQ0SfcN9Fghi7/1Li4=;
        b=PQ6jZzyYc/4rNg1UPw2u7cToIJsn7mfQYd0aB6MFYm6+Itq1886LIbW9BXGvMrh1kg
         oAHTO9ac+0WeW13tVpnFvNZBDXO0eFznVnkQsqTfKPiYCbl24fhXeBhKAZwOzXKRd5JM
         y/6T51cEHRkY9YGWax6x9ulmbjtRk78ZxD1d6vuCQUmXMQFoMpsPC/Y5hnNhPFc8sx5J
         aNJ9mM9fuit7Rfd4zXo7aSjcL5yLYNHCiCRBHjnR+c9iwAxrDOaIy3Qy4r1Ay3wYty4v
         VL+Q+P7pdcTKWBvDF0Mgvl55zZOniy0IxdJe9fHZxZHHCjVdS3vukuiCz1Xc3Wh6X0W+
         ReOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vo/2t6NMbbosw+fR2n87KMjYthQ0SfcN9Fghi7/1Li4=;
        b=N05NWmxhPzGtnnBOXKFjb8mPkUbFaT/v9VxlRO1zYbruXgwgkVsxjtMl7y/Haj6RBT
         WK/8u+NvSI2RPbublCI2il1UraBS1oahGuNgc4ymmj84ixbsbOYxXQZiLoqtfI43FDeP
         LqA4qtsHj5Ppim9oBHN7RYq53TTh7Z8Gd3nzdlFfCKBGpCdWEK5xa7tZd9UwRx+W2d8S
         6pueQ/QMhNXo9pN4b053sDn7B86Wk/FQ5OEKVd3lrCrwFzuJCxYSzvQepNJ1Qa5vvMfx
         0nXr1gz4ZFb+KBRmigMFF+LhuYXtgcec6KvUupkjTud1sqG5T72Qrvmv1GaPxFE6ZdCo
         MbLg==
X-Gm-Message-State: APt69E1CSlygBdonGqh1BuKkk7i3jQrg0cZ6Im43BYtTlgL7lIOuZ/JS
        hYRmTFjsTvQXEXbKczd1Fec=
X-Google-Smtp-Source: ADUXVKIdlxKmV/skxVcaxSgIGFHaqc7vU00jF0R6jfpnDxS2Uwud/K0SDPBF4b3DsaJd3PfMxpCuEA==
X-Received: by 2002:a19:484b:: with SMTP id v72-v6mr2503117lfa.120.1528304587458;
        Wed, 06 Jun 2018 10:03:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 14/23] entry.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:34 +0200
Message-Id: <20180606170243.4169-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

checkout-index.c needs update because if checkout->istate is NULL,
ie_match_stat() will crash. Previously this is ie_match_stat(&the_index, ..)
so it will not crash, but it is not technically correct either.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout-index.c |  1 +
 entry.c                  | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a730f6a1aa..d92db62fbd 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -190,6 +190,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
+	state.istate = &the_index;
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
diff --git a/entry.c b/entry.c
index 12d9191051..02752f7b53 100644
--- a/entry.c
+++ b/entry.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "blob.h"
 #include "dir.h"
@@ -265,7 +266,7 @@ static int write_entry(struct cache_entry *ce,
 	const struct submodule *sub;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(&the_index, ce->name,
+		struct stream_filter *filter = get_stream_filter(state->istate, ce->name,
 								 &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
@@ -313,14 +314,14 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
-			ret = async_convert_to_working_tree(&the_index, ce->name, new_blob,
+			ret = async_convert_to_working_tree(state->istate, ce->name, new_blob,
 							    size, &buf, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new_blob);
 				goto delayed;
 			}
 		} else
-			ret = convert_to_working_tree(&the_index, ce->name, new_blob, size, &buf);
+			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf);
 
 		if (ret) {
 			free(new_blob);
@@ -421,7 +422,8 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		const struct submodule *sub;
-		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		unsigned changed = ie_match_stat(state->istate, ce, &st,
+						 CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 		/*
 		 * Needs to be checked before !changed returns early,
 		 * as the possibly empty directory was not changed
-- 
2.18.0.rc0.333.g22e6ee6cdf

