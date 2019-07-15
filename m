Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E825F1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 12:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfGOMlO (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 08:41:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38839 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfGOMlN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 08:41:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so12494817oie.5
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IzrC3Sfh+R6eo+w49D/KvQXTvmTtInV0HgXeoh06Cks=;
        b=gIWM/1UOCBSqmSPhfXa2iE+cX4ApXokJ3Ed94u3Dpg6Yz7sFuC2RogBeRV556dbvDJ
         r2/eurIVXm1w8kiTZtNM48IcrPfWs1CB7Dkb2g/a491PM9AOykS4Iv9xbt6uCNNiO+YY
         48YkR81zmZmwkdsHtAVDLZ+qlJVOAegkEPcbAAyQ0tES+0DFtiCaIlDHy+fN7x5sfpfA
         x1KSjkeIkgJ7FJskeKcUbpdE1RY6NuaKbOynnoaOzR9wB0TVWoX4vLvHimXhNR57Cy+i
         SMomxE4/0j69Hf5eSdrBvKX0J4sRcFyb9gqvIPzOMBA0So21ycFQYLiCiLPdbjczuX2j
         ND3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IzrC3Sfh+R6eo+w49D/KvQXTvmTtInV0HgXeoh06Cks=;
        b=Uoso+e4l7ktI9FHEJB0LDHg8ERb5SXsRWFQ41Anrd3UUUz5mUFIwXpKs3A4eWYgJ9/
         Ef1pUzaWZtzs5FMwC8l/IlilP3XamqMpNpO9zg8rPIY6qIhMAm/AaV/kBzxHc0PguYdA
         J4vxtWsDayzwpjN3I84E9l4C4bn2/oNgX6aate5ao7OrNLNicb1cjbUA2/xsrpc8/49B
         XiAGfhzfyeNBbOq9mOxhAdxAbSsnjqo4ya06wWKjgM+9FwysVim0hQgX0VL6q1zopNYB
         kAMfVLezAoZMBt5McgpBhIYMCXWjb9XVDXejqb/cZGapnS/qmvw31H2WVod1dE6nBG2D
         uwgg==
X-Gm-Message-State: APjAAAV/CKEgIG3hJXgCFmrqn6jlSRN+jo4iHJ1frSMhN65hebDIIizy
        JhY31ZodfBNQHtXb05+5QNz4VHvU
X-Google-Smtp-Source: APXvYqxmfNX1FzsOkX3n0VwKTqlxVlhqB0cffb1Rmd90YLsGeN13WhCU1nS7ef/afR2+w02r64MwKg==
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr11882850oii.114.1563194472992;
        Mon, 15 Jul 2019 05:41:12 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5c00:b322:c4d8:3df5])
        by smtp.gmail.com with ESMTPSA id q17sm6085893otf.54.2019.07.15.05.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 05:41:12 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 1/3] log: add warning for unspecified log.mailmap setting
Date:   Mon, 15 Jul 2019 07:41:04 -0500
Message-Id: <20190715124106.12642-2-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124106.12642-1-ariadne@dereferenced.org>
References: <20190715124106.12642-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on discussions around changing the log.mailmap default to being
enabled, it was decided that a transitional period is required.

Accordingly, we announce this transitional period with a warning
message.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 builtin/log.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7c8767d3bc..1cf9e37736 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -47,7 +47,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap_config;
+static int use_mailmap_config = -1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -63,9 +63,14 @@ struct line_opt_callback_data {
 	struct string_list args;
 };
 
+static int session_is_interactive(void)
+{
+	return isatty(1) || pager_in_use();
+}
+
 static int auto_decoration_style(void)
 {
-	return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
+	return session_is_interactive() ? DECORATE_SHORT_REFS : 0;
 }
 
 static int parse_decoration_style(const char *value)
@@ -151,6 +156,16 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
+static char warn_unspecified_mailmap_msg[] =
+N_("log.mailmap is not set; its implicit value will change in an\n"
+   "upcoming release. To squelch this message and preserve current\n"
+   "behaviour, set the log.mailmap configuration value to false.\n"
+   "\n"
+   "To squelch this message and adopt the new behaviour now, set the\n"
+   "log.mailmap configuration value to true.\n"
+   "\n"
+   "See 'git help config' and search for 'log.mailmap' for further information.");
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -199,6 +214,13 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
+	if (mailmap < 0) {
+		if (session_is_interactive() && !rev->pretty_given)
+			warning("%s\n", _(warn_unspecified_mailmap_msg));
+
+		mailmap = 0;
+	}
+
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
-- 
2.17.1

