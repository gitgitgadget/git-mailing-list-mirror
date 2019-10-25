Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333021F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391279AbfJYCwK (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:52:10 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44676 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:52:10 -0400
Received: by mail-qt1-f201.google.com with SMTP id t16so659534qtp.11
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=chedpYzZpSl1sb5bBmFQq5AiopcUWdk/3H89WTN8dl0=;
        b=PMKrbzKhoUwSMCOjHkpigCTpVshrClxlLEd6iI9c6osQ3IQse8Q4zTYrD/WtBYowtv
         2c4xatBz21vKcUMT0mvxyhlclDnZHTBr7omHnA6Yw3Vx0CDusp/hN4Q2erzivMeSay0z
         koK46NfTHtkX0wJHlqtx7xQo2DJfaI+PlzsXnAquex8xYBCfI6ROXy1PORSR6rkyk9rG
         0XXZ7DpgKZKEM5H00ODmQkF8uW9+wsts7+PsciU/htP0fLt83yDzQu0TR8hOa0U1mn5j
         +3SheHw2CTnlHeZiju/lO67qKhodl1EgZuSy766fbKHRGbxHjCV1Hq1Ma7kOpnpkT+jY
         CcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=chedpYzZpSl1sb5bBmFQq5AiopcUWdk/3H89WTN8dl0=;
        b=UIhBJfxuL6sKYe6O37FImKQJAkjMs0OIbRaluE5jqfC6IJdk8C3zygpAHbE/+3NY27
         HjJ/3fQgDaNfrLqrB/40eswzyayA8zzjNbhEZt/ejbgQkpt/zb3zhr3m8/s7JXsyxnVQ
         2cwBQbqDxtvfspnc6HZ/IniZ2ial5u0vhp7lmW8fFhvxq30esz5fkoEXm0LJ8ZFc1KhJ
         Wz2gpWju2CiWqXCNc4eBKJGrc23nbPA4iKZcxZ/ZYaY5r1mOnYZgHv6hCWeSmfUrqpkK
         E3DEOKWGd1TMr4etOYPLb4TcWCmNcu3bsY00x/60Sk9d4u3P/ZIfop31Ke99JiTQWrym
         PSxQ==
X-Gm-Message-State: APjAAAVwktmAO60TSSazbtDPsW2YyQEUwV0/eL0LCMf8Nawr5YYvkQdb
        xiztRiYlDDpd6apb1bs5NhmUzDOtMyYE7kjVEcbbZ4x1VyoeKdEZUWny4QCI+qc24TXORqt9DSj
        16xXZz3cM87T7fiy7WSzCwjVEg/hKSsH3CnDM+ARapWkIbzajgfqDquiD6l1vbk2qttAQog6jEw
        ==
X-Google-Smtp-Source: APXvYqwu/FtdYmtTsUdzbCnCfckC8lL9LLZmRQENkYZhQktqBHTyYTkDxLkA6LBa6/72G3H5RJb9rFoNpsnHD1APbpE=
X-Received: by 2002:a0c:eb90:: with SMTP id x16mr1151282qvo.140.1571971927388;
 Thu, 24 Oct 2019 19:52:07 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:28 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 8/9] bugreport: list contents of $OBJDIR/info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miscellaneous information used about the object store can end up in
.git/objects/info; this can help us understand what may be going on with
the object store when the user is reporting a bug. Otherwise, it could
be difficult to track down what is going wrong with an object which
isn't kept locally to .git/objects/ or .git/objects/pack. Having some
understanding of where the user's objects may be kept can save us some
hops during the bug reporting process.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c         | 58 +++++++++++++++++++++++++++++++++++++++++++++
 bugreport.h         |  6 +++++
 builtin/bugreport.c |  7 ++++++
 3 files changed, 71 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 79ddb8baaa..ce15904fec 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -6,6 +6,7 @@
 #include "help.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "version.h"
 
 #include "dirent.h"
@@ -171,6 +172,41 @@ void list_contents_of_dir(struct string_list *contents, struct strbuf *dirpath,
 	}
 }
 
+/**
+ * Fills 'contents' with a list of all directories within the provided
+ * directory, recursing into each directory.
+ */
+void list_contents_of_dir_recursively(struct string_list *contents,
+				      struct strbuf *dirpath)
+{
+	struct string_list current_contents = STRING_LIST_INIT_DUP;
+	struct string_list current_subdirs = STRING_LIST_INIT_DUP;
+	struct string_list_item *it;
+	struct strbuf buf = STRBUF_INIT;
+
+	list_contents_of_dir(&current_contents, dirpath, 0, 0);
+	for_each_string_list_item(it, &current_contents) {
+		strbuf_reset(&buf);
+		strbuf_addbuf(&buf, dirpath);
+		strbuf_complete(&buf, '/');
+		strbuf_addstr(&buf, it->string);
+
+		string_list_append(contents, buf.buf);
+	}
+
+	list_contents_of_dir(&current_subdirs, dirpath, 1, DT_DIR);
+	for_each_string_list_item(it, &current_subdirs) {
+		if (strcmp(it->string, ".") == 0
+		    || strcmp(it->string, "..") == 0)
+			continue;
+		strbuf_reset(&buf);
+		strbuf_addbuf(&buf, dirpath);
+		strbuf_complete(&buf, '/');
+		strbuf_addstr(&buf, it->string);
+
+		list_contents_of_dir_recursively(contents, &buf);
+	}
+}
 
 void get_object_counts(struct strbuf *obj_info)
 {
@@ -240,3 +276,25 @@ void get_packed_object_summary(struct strbuf *obj_info)
 		strbuf_complete_line(obj_info);
 	}
 }
+
+void get_object_info_summary(struct strbuf *obj_info)
+{
+	// strbuf += GITDIR/info/:
+	// recursively list contents of $GIT_OBJECT_DIRECTORY/info
+	struct strbuf dirpath = STRBUF_INIT;
+	struct string_list contents = STRING_LIST_INIT_DUP;
+	struct string_list_item *entry;
+
+	strbuf_reset(obj_info);
+
+	strbuf_addstr(&dirpath, get_object_directory());
+	strbuf_complete(&dirpath, '/');
+	strbuf_addstr(&dirpath, "info/");
+
+	list_contents_of_dir_recursively(&contents, &dirpath);
+
+	for_each_string_list_item(entry, &contents) {
+		strbuf_addstr(obj_info, entry->string);
+		strbuf_complete_line(obj_info);
+	}
+}
diff --git a/bugreport.h b/bugreport.h
index 11ff7df41b..4f5e2d1b9a 100644
--- a/bugreport.h
+++ b/bugreport.h
@@ -30,3 +30,9 @@ void get_loose_object_summary(struct strbuf *obj_info);
  * hook_info will be discarded.
  */
 void get_packed_object_summary(struct strbuf *obj_info);
+
+/**
+ * Adds a list of all contents (recursively) of '.git/objects/info'. The
+ * previous contents of hook_info will be discarded.
+ */
+void get_object_info_summary(struct strbuf *obj_info);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index da91a3944e..8aad33a9b0 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -72,6 +72,13 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_packed_object_summary(&buffer);
 	strbuf_write(&buffer, report);
 
+	add_header(report, "Object Info Data");
+	get_object_info_summary(&buffer);
+	strbuf_write(&buffer, report);
+
+	// Close file
+	// open file in editor
+	launch_editor(report_path, NULL, NULL);
 	fclose(report);
 
 	launch_editor(report_path.buf, NULL, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

