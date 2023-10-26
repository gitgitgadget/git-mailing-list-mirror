Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4259273D1
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="PylVT53k"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5C1B2
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1383930b3a.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698360407; x=1698965207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/myvL0wBmCeIacYTdD9mDqkuo8P/UBGmG+cU/3jDDE=;
        b=PylVT53kjQgfwZr2vYWx5xAEGsuJu/5w96LIM4wvjNsalWlct3W5MKblEPUkmIxzHC
         a6OgiN047hKWh35teUgfJrNWzuJFKzqGfFI3dpqbFBYjePgcQpfIimVVsYl+xbDmllIL
         Dvd4HXYfZ8MjFUUnBtXq5iEW72ngfXqxlJrtmhNluzvrp8iaaOAUis6vKbmpLZOhawDG
         LOvt8UPMPaQaxJG4g+Pd3tbwjUVBqDMqKIIPc4Gpqfq5y0bblA6J5Ld9KESgg4vYz4em
         s7eXWhlMNrlJkwgKjROxcf/gyBx1L1qv6P6ywyHUsI2wHuSIfL1mY+XVhx0Ju5P0L8IK
         PBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360407; x=1698965207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/myvL0wBmCeIacYTdD9mDqkuo8P/UBGmG+cU/3jDDE=;
        b=D8bqORve+F4Ns+Zoa/tjwKEcwadg15LgWYNEb+PJeCReoNMfXw3PuZLnPJTQPeXq5i
         T+gnLMgL4nZUhbKqcS7rqesyXiu7z/vWnDNP+hLCwRuPU4dDFc93uSexFoGsYjLwWwZL
         GZvzJkH3IX2kys/w2w8WZacj3xDYSLdWvTssIO18a0EtrgqTiBOaLoYTq+Y8L8CiEGMp
         EgVi5L+HEE3EldP3oZ6ySxFxFU2SJ3f984SaNjtjqX+j5Ue3BbbBY/TgwGV/hMpYRYPE
         mX6l9Z7HeYLWAR2Q66tnbpADfoBXHn18ws7xg83QpsUyzqMyKKfN93gLl6bUIoy4oROw
         KDnw==
X-Gm-Message-State: AOJu0YzOstc030cKhgI5GGTIUnKMLE1AApdWEvEt1sXHyOJAQd0srkME
	SXfhej78lihRN+9G3L6AocS40MzFuMte5erGtT8=
X-Google-Smtp-Source: AGHT+IE5233cIBC4QDjUtuKrewtP1MGenM4au6Ls2CVyPSx3ecS7wd5i2GofdPnBDFKxGk518e+Wgg==
X-Received: by 2002:a05:6a20:3d8b:b0:137:514a:984f with SMTP id s11-20020a056a203d8b00b00137514a984fmr1365100pzi.35.1698360407633;
        Thu, 26 Oct 2023 15:46:47 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-45-225.mycingular.net. [166.170.45.225])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b0058ac101ad83sm112318pgc.33.2023.10.26.15.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:46:46 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH v2 6/6] status: add advice status hints as table footer
Date: Thu, 26 Oct 2023 15:46:15 -0700
Message-ID: <20231026224615.675172-7-jacob@initialcommit.io>
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
 builtin/commit.c |  1 +
 table.c          | 42 +++++++++++++++++++++++++++---------------
 table.h          |  2 +-
 wt-status.c      |  3 ++-
 wt-status.h      |  2 ++
 5 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3f816c117d..b97943e642 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1434,6 +1434,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
 	s.verbose = verbose;
+	s.is_cmd_status = 1;
 	if (no_renames != -1)
 		s.detect_rename = !no_renames;
 	if ((intptr_t)rename_score_arg != -1) {
diff --git a/table.c b/table.c
index 3602def17a..36719e3d09 100644
--- a/table.c
+++ b/table.c
@@ -6,6 +6,7 @@
 #include "config.h"
 #include "string-list.h"
 #include "color.h"
+#include "advice.h"
 #include "sys/ioctl.h"
 
 static const char *color(int slot, struct wt_status *s)
@@ -132,7 +133,18 @@ static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, stru
 	printf(_("|\n"));
 }
 
-void print_noob_status(struct wt_status *s, int advice)
+static void print_table_hint_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
+{
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_HINT, s), "%s", buf1->buf);
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_HINT, s), "%s", buf2->buf);
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_HINT, s), "%s", buf3->buf);
+	printf(_("|\n"));
+}
+
+void print_noob_status(struct wt_status *s)
 {
 	struct winsize w;
 	int cols;
@@ -163,20 +175,6 @@ void print_noob_status(struct wt_status *s, int advice)
 	printf(_("%s\n"), table_border.buf);
 	printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
 
-	if (advice) {
-		build_table_entry(&table_col_entry_1, "(stage: git add <file>)", cols);
-		build_table_entry(&table_col_entry_2, "(stage: git add <file>)", cols);
-		build_table_entry(&table_col_entry_3, "(unstage: git restore --staged <file>)", cols);
-
-		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
-
-		build_table_entry(&table_col_entry_1, "", cols);
-		build_table_entry(&table_col_entry_2, "(discard: git restore --staged <file>)", cols);
-		build_table_entry(&table_col_entry_3, "", cols);
-
-		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
-	}
-
 	printf(_("%s\n"), table_border.buf);
 
 	/* Draw table body */
@@ -282,6 +280,20 @@ void print_noob_status(struct wt_status *s, int advice)
 	}
 
 	printf(_("%s\n"), table_border.buf);
+
+	if (s->is_cmd_status && advice_enabled(ADVICE_STATUS_HINTS)) {
+		build_table_entry(&table_col_entry_1, "stage: git add ...", cols);
+		build_table_entry(&table_col_entry_2, "stage: git add ...", cols);
+		build_table_entry(&table_col_entry_3, "unstage: git restore --staged ...", cols);
+		print_table_hint_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+
+		build_table_entry(&table_col_entry_1, "", cols);
+		build_table_entry(&table_col_entry_2, "discard: git restore --staged ...", cols);
+		build_table_entry(&table_col_entry_3, "", cols);
+		print_table_hint_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+		printf(_("%s\n"), table_border.buf);
+	}
+
 	strbuf_release(&table_border);
 	strbuf_release(&table_col_entry_1);
 	strbuf_release(&table_col_entry_2);
diff --git a/table.h b/table.h
index 5dff7162a4..c9e8c386de 100644
--- a/table.h
+++ b/table.h
@@ -1,6 +1,6 @@
 #ifndef TABLE_H
 #define TABLE_H
 
-void print_noob_status(struct wt_status *s, int i);
+void print_noob_status(struct wt_status *s);
 
 #endif /* TABLE_H */
diff --git a/wt-status.c b/wt-status.c
index 1332d07dba..288817dcf7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -50,6 +50,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
 	GIT_COLOR_CYAN,   /* WT_STATUS_ARROW */
+	GIT_COLOR_YELLOW, /* WT_STATUS_HINT */
 };
 
 static const char *color(int slot, struct wt_status *s)
@@ -2151,7 +2152,7 @@ static void wt_noobstatus_print(struct wt_status *s)
 		wt_longstatus_print_tracking(s);
 	}
 
-	print_noob_status(s, 0);
+	print_noob_status(s);
 }
 
 static void wt_porcelain_print(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index c6bce8f74a..0a14b4b064 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -20,6 +20,7 @@ enum color_wt_status {
 	WT_STATUS_REMOTE_BRANCH,
 	WT_STATUS_ONBRANCH,
 	WT_STATUS_ARROW,
+	WT_STATUS_HINT,
 	WT_STATUS_MAXSLOT
 };
 
@@ -146,6 +147,7 @@ struct wt_status {
 	struct string_list added;
 	struct string_list restored;
 	uint32_t untracked_in_ms;
+	int is_cmd_status;
 };
 
 size_t wt_status_locate_end(const char *s, size_t len);
-- 
2.42.0.404.g2bcc23f3db

