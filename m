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
	by dcvr.yhbt.net (Postfix) with ESMTP id D19881F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbfJYCvt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:51:49 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54377 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:49 -0400
Received: by mail-pl1-f202.google.com with SMTP id j9so546422plk.21
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xW+gXInzmEOsyML6gAJy6Y8/K2eeTRCnCrci0ntYOpc=;
        b=rS2x5Uw8dssps7hbCkeUiWZo4Z1X8qVcZXzg3m+Q78laujhoroUDYGGo0vDyJjNnu8
         a6gSZog/WDIXQQ95B3mdyHrkAATzxCcWsYbGUB5zAvxbMtrL+6Z1oqBctbOaHugY9Pm0
         gFwhM6tro1YHMxpq1X6jDLGsbMptQ0apuLl+Y5xWqeT8w9bjxZcEsonss02KxT3jHFzv
         A4i9K5fwtBK7MGFTA8JxTBCzIpYFleCKBbn++yGbp0JdUXczfuj2eJvKAuQXMj5fVY/3
         0JpNKM6LmNszVYTGUIzmKo+LiLoOuXHvPJxw5YIN8LWjE+X2GgcyO0wS8bYEAU+cha51
         uK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xW+gXInzmEOsyML6gAJy6Y8/K2eeTRCnCrci0ntYOpc=;
        b=dRHL0+QfceCrw33yjRfe7XjaUObrgZQDPGbBIk47oQlZP9VrDxwyVbybncl/1HqYSh
         aE8curO0XmfR4OfIEET7Z2AWIvGRYpqzT85wkv1O+k1HXqtaQw0bAzXnbyCUybJTJi92
         Lb1CWHfUhATQgYpQCv9aCPDdke4uV6ipWKcQZ94fHIGgIFUluI4GFedpSbsbMra/srIW
         y36hjjIXKpCRHUaeyEopcvMFpVmC/cx8FifNLnt3F5ZMvyjMfBoDxQsjrQ2eu8FKQM9U
         1HAeHA7JzVs5KoyQ00UK4L7hElibZRksBDdgUm5vW5OWZd9N/RJN9KFihL7iNr+eEvx7
         o2jg==
X-Gm-Message-State: APjAAAVE4HHkbx6ytxdUcl/2oJVVEXdkH6X/515rTLA1RIsbRLsNQSpe
        o2EJCOKqxxEOmvnJytisH8n1fL5Iv5ubd18vBMXFJP2UGFOfwNGPpGAmTRatzptAn0o3dzQdsfH
        UWFCRKwWhvF9XDe4NJcfhYKn2WQagVh3hIOvXv7tU5e7ToTlI14QEomzu2QFpd+z9irAQEEn4og
        ==
X-Google-Smtp-Source: APXvYqzwlXdOZqOzt87tzyjRhJuIq+ANKK9k/S+4g1rS/cpHyQNq2JqG+SBdXT7eSFzp662kOWYODNRXLhD/suBlCqA=
X-Received: by 2002:a63:f050:: with SMTP id s16mr1427104pgj.261.1571971908571;
 Thu, 24 Oct 2019 19:51:48 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:23 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 3/9] bugreport: add version and system information
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach bugreport how to collect the Git, curl, and ldd versions, as well
as the uname string.

Learning the uname and versions in the user's environment will enable us
to reproduce behavior reported by the user; the versions will also give
us a good starting place while bisecting a newly introduced bug.

Put this functionality in a library, so that other commands can easily
include this debug info if necessary.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Makefile            |  1 +
 bugreport.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++
 bugreport.h         |  7 ++++++
 builtin/bugreport.c | 13 +++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 bugreport.c
 create mode 100644 bugreport.h

diff --git a/Makefile b/Makefile
index 78767ecdde..045b22cb67 100644
--- a/Makefile
+++ b/Makefile
@@ -844,6 +844,7 @@ LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
+LIB_OBJS += bugreport.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
diff --git a/bugreport.c b/bugreport.c
new file mode 100644
index 0000000000..ada54fe583
--- /dev/null
+++ b/bugreport.c
@@ -0,0 +1,55 @@
+#include "cache.h"
+
+#include "bugreport.h"
+#include "help.h"
+#include "run-command.h"
+#include "version.h"
+
+void get_system_info(struct strbuf *sys_info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf std_out = STRBUF_INIT;
+
+	strbuf_reset(sys_info);
+
+	// get git version from native cmd
+	strbuf_addstr(sys_info, "git version: ");
+	strbuf_addstr(sys_info, git_version_string);
+	strbuf_complete_line(sys_info);
+
+	// system call for other version info
+	argv_array_push(&cp.args, "uname");
+	argv_array_push(&cp.args, "-a");
+	capture_command(&cp, &std_out, 0);
+
+	strbuf_addstr(sys_info, "uname -a: ");
+	strbuf_addbuf(sys_info, &std_out);
+	strbuf_complete_line(sys_info);
+
+	argv_array_clear(&cp.args);
+	strbuf_reset(&std_out);
+
+
+	argv_array_push(&cp.args, "curl-config");
+	argv_array_push(&cp.args, "--version");
+	capture_command(&cp, &std_out, 0);
+
+	strbuf_addstr(sys_info, "curl-config --version: ");
+	strbuf_addbuf(sys_info, &std_out);
+	strbuf_complete_line(sys_info);
+
+	argv_array_clear(&cp.args);
+	strbuf_reset(&std_out);
+
+
+	argv_array_push(&cp.args, "ldd");
+	argv_array_push(&cp.args, "--version");
+	capture_command(&cp, &std_out, 0);
+
+	strbuf_addstr(sys_info, "ldd --version: ");
+	strbuf_addbuf(sys_info, &std_out);
+	strbuf_complete_line(sys_info);
+
+	argv_array_clear(&cp.args);
+	strbuf_reset(&std_out);
+}
diff --git a/bugreport.h b/bugreport.h
new file mode 100644
index 0000000000..ba216acf3f
--- /dev/null
+++ b/bugreport.h
@@ -0,0 +1,7 @@
+#include "strbuf.h"
+
+/**
+ * Adds the Git version, `uname -a`, and `curl-config --version` to sys_info.
+ * The previous contents of sys_info will be discarded.
+ */
+void get_system_info(struct strbuf *sys_info);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 2ef16440a0..7232d31be7 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "bugreport.h"
 #include "stdio.h"
 #include "strbuf.h"
 #include "time.h"
@@ -27,6 +28,13 @@ int get_bug_template(struct strbuf *template)
 	return 0;
 }
 
+void add_header(FILE *report, const char *title)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	strbuf_addf(&buffer, "\n\n[%s]\n", title);
+	strbuf_write(&buffer, report);
+}
+
 int cmd_bugreport(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -43,6 +51,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_bug_template(&buffer);
 	strbuf_write(&buffer, report);
 
+	// add other contents
+	add_header(report, "System Info");
+	get_system_info(&buffer);
+	strbuf_write(&buffer, report);
+
 	fclose(report);
 
 	launch_editor(report_path.buf, NULL, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

