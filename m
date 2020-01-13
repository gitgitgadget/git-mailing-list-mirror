Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03921C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAA221569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNiug/jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgAMI3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55934 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAMI3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so8590200wmj.5
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xhk2glhnZpSdWYPFBK/mexCFtCvi1f9dZ47jLBhURjU=;
        b=KNiug/jhT6VGJaenqC1v1wyPbmdEog66wI110KMFQlr8jKIlPLhrqwoPDomUCb+f4q
         0gZ95S4S+5wojHK6mABrx4jcIWCfYG7l9iKOcxmE3obeTKYE2b8/mZlop82PaIsTMaxa
         pb/Oj8hW3Jy9ziK+3X/O6ZSxE+7264oKG0/sf3u4Gn1xt70ZcXhysZ5EoAt5m1JPep9r
         /pRVLdlarqFS2guSmNOmqnuNo/ZaqxWLlY9ZmdvSPW5Zut4y7EOgqhCU4ymsISFJ2gej
         me15qOB7zuHiK2nFxx1f/4JvsyAdtgdBFoIFX705xuJvp50MYmflJ5yfUrYCHpJTtUVN
         hGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xhk2glhnZpSdWYPFBK/mexCFtCvi1f9dZ47jLBhURjU=;
        b=n6edKhktRrEXSLrywlueepSH+PeQRgO/WWijQArD7Gb+aEKm4dS7Y832QibSp88u/9
         b9TZMSrWtYLtcDWvydkaxxFi6zT5ZApskzqMaIJmcMZnlZA+1asEFIK/psgcaQKWP4No
         HkZIlwiidfKNW3zak6zkpuLZ1mxN8pNrMNhWr0PAd5VsoycCGwR8qtXbxpCeHLcLj5DX
         5Ww34zFJTuTPJnqc+24ybpPFM+ioHPqQAUvBpSZFoMWEEm/qJRmW2vvgx6D837bRuK2b
         VImR38L4yYXBIJXIpFBPi/KbljjqfTHjJBPtcTbHs2PgtQQZ7O6Jf9bmESuNJWi7RCTT
         oHPw==
X-Gm-Message-State: APjAAAVCzJekFVYSmCwq+1lA9yrqY6wK+it6OvVCivgeIkzcn6nOlOG3
        zeEsEovSnfPoa0PefAWsI69AHlet
X-Google-Smtp-Source: APXvYqzsBDhDR0xSDli5AKSsntJopswWUz6cGfQX5V6Oei0tV5PvbkIJcpu47lr5wrmo/FLFwLzTyA==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr18212048wmj.165.1578904174022;
        Mon, 13 Jan 2020 00:29:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c195sm14135606wmd.45.2020.01.13.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:33 -0800 (PST)
Message-Id: <2a5951ecfef7a5d93fd6f5a36c4b5df75ec910e1.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:23 +0000
Subject: [PATCH v3 02/10] built-in add -p: support interactive.diffFilter
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
index 3ff8400ea4..b36e5d97d8 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -53,6 +53,17 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
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
@@ -1151,6 +1162,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
 	prefix_item_list_clear(&commands);
+	clear_add_i_state(&s);
 	sigchain_pop(SIGPIPE);
 
 	return res;
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
index 9a3beed72e..7d6015229c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -399,6 +399,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 	if (want_color_fd(1, -1)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
+		const char *diff_filter = s->s.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
@@ -408,6 +409,24 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
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
@@ -532,6 +551,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 						   colored_pend - colored_p);
 			if (colored_eol)
 				colored_p = colored_eol + 1;
+			else if (p != pend)
+				/* colored shorter than non-colored? */
+				goto mismatched_output;
 			else
 				colored_p = colored_pend;
 
@@ -556,6 +578,15 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
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
 
@@ -1614,6 +1645,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	    parse_diff(&s, ps) < 0) {
 		strbuf_release(&s.plain);
 		strbuf_release(&s.colored);
+		clear_add_i_state(&s.s);
 		sigchain_pop(SIGPIPE);
 		return -1;
 	}
@@ -1633,6 +1665,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	strbuf_release(&s.buf);
 	strbuf_release(&s.plain);
 	strbuf_release(&s.colored);
+	clear_add_i_state(&s.s);
 	sigchain_pop(SIGPIPE);
 	return 0;
 }
-- 
gitgitgadget

