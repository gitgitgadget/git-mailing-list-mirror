Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644F81F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeFFHkH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:07 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36830 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932208AbeFFHkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:40:02 -0400
Received: by mail-lf0-f68.google.com with SMTP id u4-v6so7576588lff.3
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vo/2t6NMbbosw+fR2n87KMjYthQ0SfcN9Fghi7/1Li4=;
        b=ZL0ZFB4IlIRg6fhTguw2Lnj7CfUvrRwVIwZB9VDrC3CkTjK4dWnWHJldWy6WXogeSV
         NDgJA7X/3tohSsuR3USnKXR+bwUHlt1s4YL/xbpefkOlAxEdR9w2dTGwcg5wqUdDvXaB
         WIUJHN1zr5mU3thrgWmbOdkmkb0pFTa9/5bRvWh2B2Ti4Doaw8r3+4Tk1XHleRytp82j
         RlRjyR23h2ccCGM/mi1AlMb6Sh7s1pzBg80+O+HIvJlO+veBiaUdQfiAMfMLspNIG6QY
         1aHlGLnDl7MFSwT7SBJfK2OTVNzOZoXdW3CShoYaimMAYerBjsZtZq08M9P6MtjxDLMF
         AUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vo/2t6NMbbosw+fR2n87KMjYthQ0SfcN9Fghi7/1Li4=;
        b=ZxWf61S9AwYgEYUSyRm+FY6UjMk9vjOl7HMF51NF2k1NqDQVeZfpzGo+/7oRqppdSi
         LsulDbDyR/WwQWzOQdmWgKi0czzrZXRu+fGwrcc2812laY8kMWKU4gRiaj+KzxHMb2DO
         JiWTF+ueNKEHp1GFhEOKgIhHwZ+FYy+0Oq8SD5Ms4X7WPWG5S+GWDvcdmcPBjOGVhcjA
         kC9CYqI3ymWlVWXWN1LH7/8OJu55ZBojY7g9gV5TzP1h3uoX2KCtyczGONbiebDJNaTB
         acJ0UQvw7qzmwUd7kisVlzLK/lWBNN4u8aWKroQGm8Nq7WOSg7Vlbg0g1mUUT1I+8NMq
         cJ8A==
X-Gm-Message-State: APt69E3NqEh4DiolfsoJn3lw+OOk2MoDB+EqEMchlVAKRunXWBL/ofEU
        3QsJR2ll8Xe97doiLrInPK0=
X-Google-Smtp-Source: ADUXVKLYLVVpbMqn5EGjznpfo0Quzy1AtfJ+kNNbBGH+N4q7hiMMG6TvnCXP5LZaDZxkpGuVTMk7vw==
X-Received: by 2002:a19:e9d3:: with SMTP id j80-v6mr1157993lfk.129.1528270800729;
        Wed, 06 Jun 2018 00:40:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:40:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 14/20] entry.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 09:39:27 +0200
Message-Id: <20180606073933.14755-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
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

