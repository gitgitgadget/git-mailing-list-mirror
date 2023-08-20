Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06BEEE49A5
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 09:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjHTJAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 05:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHTJAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 05:00:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF1ED
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fee843b44cso5764105e9.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521695; x=1693126495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zcDsuRavCDviLGOuatKVm+MWPqvnjvYjWGbxy09WDg=;
        b=Tsn4XqMzr5aTXBXm/4GnbkhjfI+/K5Fl+IxItS0tgqROCRtsgdmODvKvFYyfHiFgk1
         ewmoP1ZxR4apWpygjd6FxZEeifEhb+EsLLAOLGM6LpGUQS7VxNfZOXlAs/JIj29TnMyi
         aGNg3LIpYfo/Oc7IV8/1lQWVIu6unCKUOi6hW/q97hHfAgO5WM+blckEoy8Ni+/2y0gl
         ppnzeH/6MT80DhFonsFC9tO42ugiOxdRbb4NSPvZGIcuBY2ES3jMJtc8I5G1teiKT+zv
         Pl12nm+BXNAcPlNtEdWBD43Cf93ggUTjxGonhcYGMT3TotAlkoA/AZE/mMDU+62fcpr9
         v3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521695; x=1693126495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zcDsuRavCDviLGOuatKVm+MWPqvnjvYjWGbxy09WDg=;
        b=kdzc/XdlQYElCZ3eDTLNC2GbkDfhCCXeG2uwWKU9rIweH+5wlwZNHmLhYy8BAkMKQt
         Lo1LN1chWkGVPt72o47nTvbSJ9LBp1uUMg7HiOrkFFh8DmIYj/IcU69dw4yHmTdfkxgR
         bp33G2bILLoWGiBbpzK1RyyqvibczbTJ5v4KsMEe4eufNv3hkETcFlovQc4QwgT63XEf
         k1Q4GUW2eLSWqV+x0gD7qn6/8UiwEK1XrIXiTa68SzrK6TqJg/mIkVAWKrLUwIGa6G4a
         CcPcd5F7Yk1CcR8uHIVLmXPMHSiWXwwatkUYUZ4eDni58S9E48hERyOUHp0puWfK2BX2
         8orQ==
X-Gm-Message-State: AOJu0Ywij9yu6AUtAJPQ5atAEGIgRwAHVXpDrrmnvIe5r2Bk/SF76rfk
        gXjh0zJ7KA5ho1cRmPVpOkyZr072Zt+BYTAj
X-Google-Smtp-Source: AGHT+IFA1WLbsiMWQD9JmByfqrszI7C5teHcxxKHmF3PF+ZAC2XWytae2cyv/XuQ8TBkUJoxGP66Wg==
X-Received: by 2002:a05:600c:2296:b0:3fe:4e4e:beeb with SMTP id 22-20020a05600c229600b003fe4e4ebeebmr2850967wmf.38.1692521695223;
        Sun, 20 Aug 2023 01:54:55 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:54 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 3/8] decorate: refactor format_decorations()
Date:   Sun, 20 Aug 2023 09:53:31 +0100
Message-ID: <20230820085336.8615-4-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the format_decorations_extended function to format_decorations
and drop the format_decorations wrapper macro. Pass the prefix, suffix
and separator strings as a single 'struct format_decorations' pointer
argument instead of separate arguments. Use default values defined in
the function when either the struct pointer or any of the struct fields
are NULL. This is to ease extension with additional options.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c | 23 +++++++++++++++++------
 log-tree.h | 15 ++++++++-------
 pretty.c   |  6 ++++--
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 208c69cbb7..cd12c26c29 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -303,14 +303,12 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
 
 /*
  * The caller makes sure there is no funny color before calling.
- * format_decorations_extended makes sure the same after return.
+ * format_decorations ensures the same after return.
  */
-void format_decorations_extended(struct strbuf *sb,
+void format_decorations(struct strbuf *sb,
 			const struct commit *commit,
 			int use_color,
-			const char *prefix,
-			const char *separator,
-			const char *suffix)
+			const struct decoration_options *opts)
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
@@ -319,10 +317,23 @@ void format_decorations_extended(struct strbuf *sb,
 	const char *color_reset =
 		decorate_get_color(use_color, DECORATION_NONE);
 
+	const char *prefix = " (";
+	const char *suffix = ")";
+	const char *separator = ", ";
+
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
 
+	if (opts) {
+		if (opts->prefix)
+			prefix = opts->prefix;
+		if (opts->suffix)
+			suffix = opts->suffix;
+		if (opts->separator)
+			separator = opts->separator;
+	}
+
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
 	while (decoration) {
 		/*
@@ -370,7 +381,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	}
 	if (!opt->show_decorations)
 		return;
-	format_decorations(&sb, commit, opt->diffopt.use_color);
+	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
 	fputs(sb.buf, opt->diffopt.file);
 	strbuf_release(&sb);
 }
diff --git a/log-tree.h b/log-tree.h
index bdb6432815..14898de8ac 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,17 +13,18 @@ struct decoration_filter {
 	struct string_list *exclude_ref_config_pattern;
 };
 
+struct decoration_options {
+	char *prefix;
+	char *suffix;
+	char *separator;
+};
+
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 void show_log(struct rev_info *opt);
-void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
-			     int use_color,
-			     const char *prefix,
-			     const char *separator,
-			     const char *suffix);
-#define format_decorations(strbuf, commit, color) \
-			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
+void format_decorations(struct strbuf *sb, const struct commit *commit,
+			int use_color, const struct decoration_options *opts);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
diff --git a/pretty.c b/pretty.c
index 718530bbab..24fb82a5a2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1537,10 +1537,12 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decorations(sb, commit, c->auto_color);
+		format_decorations(sb, commit, c->auto_color, NULL);
 		return 1;
 	case 'D':
-		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
+		format_decorations(sb, commit, c->auto_color,
+			&(struct decoration_options){.prefix = "",
+						     .suffix = ""});
 		return 1;
 	case 'S':		/* tag/branch like --source */
 		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
-- 
2.42.0-rc2

