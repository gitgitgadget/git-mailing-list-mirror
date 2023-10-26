Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B02168C7
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="1NVQGw+/"
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EDE1AB
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:41 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-581f78a0206so795093eaf.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698360401; x=1698965201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4jOTBwwBH7nKoPw0WlSovtQkR5f47OUKV5RsyaQ71k=;
        b=1NVQGw+/ghDrl1mhDaVH9JS1tZV42iEwtvTTg8vFqxUKLIeEAglRagUOYHlurA1jjg
         m2BcZAZlC2ho+yLGAHNHRwIxpZR7ilROFzs/qwJArJwC6aXwY2db25QV0+SLCQat9i72
         ARCreir+W0hmJhOs2bg6schd05KUzD6ciD/AS+8tVC4Fj8VpRfroqchFuCuPMbw0jVB7
         PaGNrsTuB15difE92x7cBl9JaXdqE4DSO8o/WkND+PjiT4CPH+COL43aVSLvztJkn2iu
         UVbmpeaeKEE3x6pA5wjESonedWAaX1+u4zjK8rLcKqyIMdFdMVvTGH1TIrfuhBIzCJXC
         A+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360401; x=1698965201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4jOTBwwBH7nKoPw0WlSovtQkR5f47OUKV5RsyaQ71k=;
        b=Psp5EDPMZIaOwqKGVtACGr3vyqwM1uXb0Wxgasaj2uIk3HTQmDsVNlTXvcgNMsdTZ4
         T6S+OAgSra7MK8GYdtYxHGtG1kJLYwPbRGxD97kZAii7glQKYLR5PsN5m3TP45sSE6Jj
         KLvs8U03alO40aOeQaEoO0GzDGgHkr9Q6oqshxXG6Cb9T6li2KG2Ghb/5LaeP+nVPPgG
         u5bLFGRGM+Q/pRI4kMcsMVGF1+ofUb+mBnpDzTbhYCzDPc1IEDm11uUGPXvUeg7EtkMu
         GI/QOs3JF+rlNq/fSZ+qhAKLnHLZovq5eAJNyuv9R1Vw1IclRxFvDyFC6rBe1eUhHRNA
         SjSg==
X-Gm-Message-State: AOJu0YywECiQIbtp9KkTO/+9DuO691DJQ2uinHCUsF0OVd9hu9RJo1rM
	gSxFtKTbrqN+JyuNEjGyjB/fyBUTuF1B/9UbTQk=
X-Google-Smtp-Source: AGHT+IEpkOdz8EvQRO0X6Vd2VEIVf8L2udCRwEEJawb+FiF6o6M+uhQoi6ggfR1Fu0vqXcwAY3ZK3Q==
X-Received: by 2002:a05:6358:5241:b0:168:e5ee:8fbd with SMTP id c1-20020a056358524100b00168e5ee8fbdmr1515480rwa.27.1698360400670;
        Thu, 26 Oct 2023 15:46:40 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-45-225.mycingular.net. [166.170.45.225])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b0058ac101ad83sm112318pgc.33.2023.10.26.15.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:46:39 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH v2 1/6] status: add noob format from status.noob config
Date: Thu, 26 Oct 2023 15:46:10 -0700
Message-ID: <20231026224615.675172-2-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.404.g2bcc23f3db
In-Reply-To: <20231026224615.675172-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 Makefile         |   1 +
 builtin/commit.c |   7 +++
 table.c          | 117 +++++++++++++++++++++++++++++++++++++++++++++++
 table.h          |   6 +++
 wt-status.c      |  72 +++++++++++++++++++----------
 wt-status.h      |   1 +
 6 files changed, 179 insertions(+), 25 deletions(-)
 create mode 100644 table.c
 create mode 100644 table.h

diff --git a/Makefile b/Makefile
index 9c6a2f125f..a7399ca8f0 100644
--- a/Makefile
+++ b/Makefile
@@ -1155,6 +1155,7 @@ LIB_OBJS += submodule-config.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
+LIB_OBJS += table.o
 LIB_OBJS += tempfile.o
 LIB_OBJS += thread-utils.o
 LIB_OBJS += tmp-objdir.o
diff --git a/builtin/commit.c b/builtin/commit.c
index 7da5f92448..880c42f5b7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1430,6 +1430,13 @@ static int git_status_config(const char *k, const char *v,
 			status_deferred_config.status_format = STATUS_FORMAT_NONE;
 		return 0;
 	}
+	if (!strcmp(k, "status.noob")) {
+		if (git_config_bool(k, v))
+			status_deferred_config.status_format = STATUS_FORMAT_NOOB;
+		else
+			status_deferred_config.status_format = STATUS_FORMAT_NONE;
+		return 0;
+	}
 	if (!strcmp(k, "status.branch")) {
 		status_deferred_config.show_branch = git_config_bool(k, v);
 		return 0;
diff --git a/table.c b/table.c
new file mode 100644
index 0000000000..15600e117f
--- /dev/null
+++ b/table.c
@@ -0,0 +1,117 @@
+#define USE_THE_INDEX_VARIABLE
+#include "builtin.h"
+#include "gettext.h"
+#include "strbuf.h"
+#include "wt-status.h"
+#include "config.h"
+#include "string-list.h"
+#include "sys/ioctl.h"
+
+static const char *color(int slot, struct wt_status *s)
+{
+	const char *c = "";
+	if (want_color(s->use_color))
+		c = s->color_palette[slot];
+	if (slot == WT_STATUS_ONBRANCH && color_is_nil(c))
+		c = s->color_palette[WT_STATUS_HEADER];
+	return c;
+}
+
+static void build_table_border(struct strbuf *buf, int cols)
+{
+	strbuf_reset(buf);
+	strbuf_addchars(buf, '-', cols);
+}
+
+static void build_table_entry(struct strbuf *buf, char *entry, int cols)
+{
+	strbuf_reset(buf);
+	strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
+	strbuf_addstr(buf, entry);
+
+	/* Bump right padding if entry length is odd */
+	if (!(strlen(entry) % 2))
+		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2 + 1);
+	else
+		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
+}
+
+static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
+{
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", buf1->buf);
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%s", buf2->buf);
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%s", buf3->buf);
+	printf(_("|\n"));
+}
+
+void print_noob_status(struct wt_status *s)
+{
+	struct winsize w;
+	int cols;
+	struct strbuf table_border = STRBUF_INIT;
+	struct strbuf table_col_entry_1 = STRBUF_INIT;
+	struct strbuf table_col_entry_2 = STRBUF_INIT;
+	struct strbuf table_col_entry_3 = STRBUF_INIT;
+	struct string_list_item *item;
+
+	/* Get terminal width */
+	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
+	cols = w.ws_col;
+
+	/* Ensure table is divisible into 3 even columns */
+	while (((cols - 1) % 3) > 0 || !(cols % 2)) {
+		cols -= 1;
+	}
+
+	build_table_border(&table_border, cols);
+	build_table_entry(&table_col_entry_1, "Untracked files", cols);
+	build_table_entry(&table_col_entry_2, "Unstaged changes", cols);
+	build_table_entry(&table_col_entry_3, "Staging area", cols);
+
+	/* Draw table header */
+	printf(_("%s\n"), table_border.buf);
+	printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+	printf(_("%s\n"), table_border.buf);
+
+	/* Draw table body */
+	for_each_string_list_item(item, &s->untracked) {
+		build_table_entry(&table_col_entry_1, item->string, cols);
+		build_table_entry(&table_col_entry_2, "", cols);
+		build_table_entry(&table_col_entry_3, "", cols);
+		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+	}
+
+	for_each_string_list_item(item, &s->change) {
+		struct wt_status_change_data *d = item->util;
+		if (d->worktree_status && d->index_status) {
+			build_table_entry(&table_col_entry_1, "", cols);
+			build_table_entry(&table_col_entry_2, item->string, cols);
+			build_table_entry(&table_col_entry_3, item->string, cols);
+		} else if (d->worktree_status) {
+			build_table_entry(&table_col_entry_1, "", cols);
+			build_table_entry(&table_col_entry_2, item->string, cols);
+			build_table_entry(&table_col_entry_3, "", cols);
+		} else if (d->index_status) {
+			build_table_entry(&table_col_entry_1, "", cols);
+			build_table_entry(&table_col_entry_2, "", cols);
+			build_table_entry(&table_col_entry_3, item->string, cols);
+		}
+		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+	}
+	
+	if (!s->untracked.nr && !s->change.nr) {
+		build_table_entry(&table_col_entry_1, "-", cols);
+		build_table_entry(&table_col_entry_2, "-", cols);
+		build_table_entry(&table_col_entry_3, "-", cols);
+		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+	}
+
+	printf(_("%s\n"), table_border.buf);
+	strbuf_release(&table_border);
+	strbuf_release(&table_col_entry_1);
+	strbuf_release(&table_col_entry_2);
+	strbuf_release(&table_col_entry_3);
+}
diff --git a/table.h b/table.h
new file mode 100644
index 0000000000..c9e8c386de
--- /dev/null
+++ b/table.h
@@ -0,0 +1,6 @@
+#ifndef TABLE_H
+#define TABLE_H
+
+void print_noob_status(struct wt_status *s);
+
+#endif /* TABLE_H */
diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..712807aa8f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -31,6 +31,7 @@
 #include "lockfile.h"
 #include "sequencer.h"
 #include "fsmonitor-settings.h"
+#include "table.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
 #define UF_DELAY_WARNING_IN_MS (2 * 1000)
@@ -1833,39 +1834,46 @@ static void wt_longstatus_print_state(struct wt_status *s)
 		show_sparse_checkout_in_use(s, state_color);
 }
 
-static void wt_longstatus_print(struct wt_status *s)
+static void wt_longstatus_print_onwhat(struct wt_status *s, const char *branch_name)
 {
+	const char *on_what = _("On branch ");
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+
+	if (!strcmp(branch_name, "HEAD")) {
+		branch_status_color = color(WT_STATUS_NOBRANCH, s);
+		if (s->state.rebase_in_progress ||
+		    s->state.rebase_interactive_in_progress) {
+			if (s->state.rebase_interactive_in_progress)
+				on_what = _("interactive rebase in progress; onto ");
+			else
+				on_what = _("rebase in progress; onto ");
+			branch_name = s->state.onto;
+		} else if (s->state.detached_from) {
+			branch_name = s->state.detached_from;
+			if (s->state.detached_at)
+				on_what = _("HEAD detached at ");
+			else
+				on_what = _("HEAD detached from ");
+		} else {
+			branch_name = "";
+			on_what = _("Not currently on any branch.");
+		}
+	} else
+		skip_prefix(branch_name, "refs/heads/", &branch_name);
+
+	status_printf_more(s, branch_status_color, "%s", on_what);
+	status_printf_more(s, branch_color, "%s\n", branch_name);
+}
+
+static void wt_longstatus_print(struct wt_status *s)
+{
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
-		const char *on_what = _("On branch ");
 		const char *branch_name = s->branch;
-		if (!strcmp(branch_name, "HEAD")) {
-			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (s->state.rebase_in_progress ||
-			    s->state.rebase_interactive_in_progress) {
-				if (s->state.rebase_interactive_in_progress)
-					on_what = _("interactive rebase in progress; onto ");
-				else
-					on_what = _("rebase in progress; onto ");
-				branch_name = s->state.onto;
-			} else if (s->state.detached_from) {
-				branch_name = s->state.detached_from;
-				if (s->state.detached_at)
-					on_what = _("HEAD detached at ");
-				else
-					on_what = _("HEAD detached from ");
-			} else {
-				branch_name = "";
-				on_what = _("Not currently on any branch.");
-			}
-		} else
-			skip_prefix(branch_name, "refs/heads/", &branch_name);
 		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_more(s, branch_status_color, "%s", on_what);
-		status_printf_more(s, branch_color, "%s\n", branch_name);
+		wt_longstatus_print_onwhat(s, branch_name);
 		if (!s->is_initial)
 			wt_longstatus_print_tracking(s);
 	}
@@ -2133,6 +2141,17 @@ static void wt_shortstatus_print(struct wt_status *s)
 		wt_shortstatus_other(it, s, "!!");
 }
 
+static void wt_noobstatus_print(struct wt_status *s)
+{
+	if (s->show_branch) {
+		const char *branch_name = s->branch;
+		wt_longstatus_print_onwhat(s, branch_name);
+		wt_longstatus_print_tracking(s);
+	}
+
+	print_noob_status(s);
+}
+
 static void wt_porcelain_print(struct wt_status *s)
 {
 	s->use_color = 0;
@@ -2560,6 +2579,9 @@ void wt_status_print(struct wt_status *s)
 	case STATUS_FORMAT_LONG:
 		wt_longstatus_print(s);
 		break;
+	case STATUS_FORMAT_NOOB:
+		wt_noobstatus_print(s);
+		break;
 	}
 
 	trace2_region_leave("status", "print", s->repo);
diff --git a/wt-status.h b/wt-status.h
index ab9cc9d8f0..3f08f0d72b 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -73,6 +73,7 @@ enum wt_status_format {
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
 	STATUS_FORMAT_PORCELAIN_V2,
+	STATUS_FORMAT_NOOB,
 
 	STATUS_FORMAT_UNSPECIFIED
 };
-- 
2.42.0.404.g2bcc23f3db

