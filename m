Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6693CC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4518C24670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKoT5Yn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgANSoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40343 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgANSn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:43:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so13257804wrn.7
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iNgdJu33yWmrC3CO0xyJZ8AewEp6xJw0yMtoc0eSul0=;
        b=YKoT5Yn4sO8r8YuMcJ1nwFs9atpfkdJwSAGO1Gva7zOT0o9jOTdnDj5G7pum3Q7BwF
         RBZKSvbcV58qZlewwA68ql+h16SSck464we0+VZAsiN/MEX/Wgtx47AqtP43AEjuuaWA
         D1gttZAYZEs1WkD2lut6L3Nzr4DFInS2z21xI/bOaOJvDPj0dO/PVoFklSM9nBKdfIc7
         XTBjNPh8T0/wtNgA4Gajgno1J1gA1PgdgveiTcK8uOGi5PCInCDBf9nQJizweGaN3Cb6
         osCBoatSKpcAGiRCdwB0fN4ZPCwxtr58jem2A5qy+y68x278JFo2e0awSEjkVlTEAgC8
         zlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iNgdJu33yWmrC3CO0xyJZ8AewEp6xJw0yMtoc0eSul0=;
        b=bQO3COOFCh/Fg1DHqK7yYNTMbHdKgO0BpwSaHEB80Q6b7YjDQbDXXpM15y3ftadTkC
         KmhuRds1oK0lOwaIzopsItEnfLGC6nD0juBYsrCJR3sRSLhotgSyEXIYkC4TjcYC1jq0
         C6q6gsg89f4qTgox2k3mZf8YFHJqMR8xWEqKSYmMuldufBaIrP+AOXDnfide4IPcYcnp
         59OVNq4wvpsv31NAT5OnnqASdrNQKkvP6QnXOC14gnmBDRLAdb88IcleEvzWE6Bx9giF
         ImVkU6BgOrLjVjb+9N23mGyw+WiWPKHvX4wXAy/wtGw4HGx1A9K4IMTk3ZjDS49xAKET
         SH0w==
X-Gm-Message-State: APjAAAWgmGst/yxfxRzqCIgv5e3cl0ntvkTD5RFR0Da2zz6QXgsCsqsT
        Hh0oG0pYIAvzdJOAQ70BVAqDg5SO
X-Google-Smtp-Source: APXvYqz/BXoO3SUK3pNuT4dB/BaZXVnRsd7tF37Y3p3dMF1ZMIc3IFu7sJT6G2xv7afzbM2H4foUQQ==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr27385784wrh.371.1579027436890;
        Tue, 14 Jan 2020 10:43:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm18813708wrt.29.2020.01.14.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:43:56 -0800 (PST)
Message-Id: <413a87bd798296844ebec0c1aad579044da56194.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:45 +0000
Subject: [PATCH v4 02/10] built-in add -p: support interactive.diffFilter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version supports post-processing the colored diff (that is
generated in addition to the uncolored diff, intended to offer a
prettier user experience) by a command configured via that config
setting, and now the built-in version does that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 12 ++++++++++++
 add-interactive.h |  3 +++
 add-patch.c       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index a5bb14f2f4..1786ea29c4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -52,6 +52,17 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 		diff_get_color(s->use_color, DIFF_FILE_OLD));
 	init_color(r, s, "new", s->file_new_color,
 		diff_get_color(s->use_color, DIFF_FILE_NEW));
+
+	FREE_AND_NULL(s->interactive_diff_filter);
+	git_config_get_string("interactive.difffilter",
+			      &s->interactive_diff_filter);
+}
+
+void clear_add_i_state(struct add_i_state *s)
+{
+	FREE_AND_NULL(s->interactive_diff_filter);
+	memset(s, 0, sizeof(*s));
+	s->use_color = -1;
 }
 
 /*
@@ -1149,6 +1160,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
 	prefix_item_list_clear(&commands);
+	clear_add_i_state(&s);
 
 	return res;
 }
diff --git a/add-interactive.h b/add-interactive.h
index b2f23479c5..46c73867ad 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -15,9 +15,12 @@ struct add_i_state {
 	char context_color[COLOR_MAXLEN];
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
+
+	char *interactive_diff_filter;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
+void clear_add_i_state(struct add_i_state *s);
 
 struct repository;
 struct pathspec;
diff --git a/add-patch.c b/add-patch.c
index 46c6c183d5..78bde41df0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -398,6 +398,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 	if (want_color_fd(1, -1)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
+		const char *diff_filter = s->s.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
@@ -407,6 +408,24 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		argv_array_clear(&args);
 		if (res)
 			return error(_("could not parse colored diff"));
+
+		if (diff_filter) {
+			struct child_process filter_cp = CHILD_PROCESS_INIT;
+
+			setup_child_process(s, &filter_cp,
+					    diff_filter, NULL);
+			filter_cp.git_cmd = 0;
+			filter_cp.use_shell = 1;
+			strbuf_reset(&s->buf);
+			if (pipe_command(&filter_cp,
+					 colored->buf, colored->len,
+					 &s->buf, colored->len,
+					 NULL, 0) < 0)
+				return error(_("failed to run '%s'"),
+					     diff_filter);
+			strbuf_swap(colored, &s->buf);
+		}
+
 		strbuf_complete_line(colored);
 		colored_p = colored->buf;
 		colored_pend = colored_p + colored->len;
@@ -531,6 +550,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 						   colored_pend - colored_p);
 			if (colored_eol)
 				colored_p = colored_eol + 1;
+			else if (p != pend)
+				/* colored shorter than non-colored? */
+				goto mismatched_output;
 			else
 				colored_p = colored_pend;
 
@@ -555,6 +577,15 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		 */
 		hunk->splittable_into++;
 
+	/* non-colored shorter than colored? */
+	if (colored_p != colored_pend) {
+mismatched_output:
+		error(_("mismatched output from interactive.diffFilter"));
+		advise(_("Your filter must maintain a one-to-one correspondence\n"
+			 "between its input and output lines."));
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -1612,6 +1643,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	    parse_diff(&s, ps) < 0) {
 		strbuf_release(&s.plain);
 		strbuf_release(&s.colored);
+		clear_add_i_state(&s.s);
 		return -1;
 	}
 
@@ -1630,5 +1662,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	strbuf_release(&s.buf);
 	strbuf_release(&s.plain);
 	strbuf_release(&s.colored);
+	clear_add_i_state(&s.s);
 	return 0;
 }
-- 
gitgitgadget

