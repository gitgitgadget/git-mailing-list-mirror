Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F5218584
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429582; cv=none; b=t1JNNWxixpUAF2XGIvJUm6Y37O+2MRcUX+4gn/oa7lLuFVb2fvO1iJtMq5IA9s49kIc6RLtYnuhZiBC1C9fbwRJvR3X9TnhmH2br6uVZinksnBBByqVRIsoa6KSWMgVrLSIq/2SA6sCyReL1oAAmm6pCPlnQh40dKRWX02B5WXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429582; c=relaxed/simple;
	bh=JBS9SnWJ3U6atlNJMVIMcEWrsoqzH/ajDtHJ3Xzphcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qc7J1KM3QUemPJ7F+odwUq+BMfdZbGNsn+wYmU4fIGBtTXTG9l7yJ/sM/OaT4ueJDDgeU82adv2bVLAEfeeApy7yjSS6oweoOlg/6QmKRoE2SvoOhre3SiOHeLC5tw2t85+2w4kNIM9wqroQoKSnDJMd4cuF9QT2wGYhzw4ep3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7aysJjh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7aysJjh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3204db795so5261107b3.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728429580; x=1729034380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4B4dEWv8y9Qd3S1MimW5v7zVo47XrMO3kEwqW/kDQMo=;
        b=F7aysJjhvgZ8MyBjJCsTnpjU8nfvR782S31ajG3i4RtPnUkU7zchpozCacpr8dI9al
         u99lQwU+SD2WQ2Yi0BxSExsL/J/Hbi4TdO7l/2CKyYNUYAJXV2qhui8FLyiMMFNlINqC
         6X8Q2s22vf+Za5KaFVk7BGb4NX7YY4oWwYGkzD7Rsia3UBbgNzOON76F3bQ45fSq92Xa
         qftG83N7UKmA2m/9uMk0DIHhYGi0BTX+NdcPQ4sgyG2gurjFQiZRL9IkA00e9d64OUUk
         UJj+gAcXKmI5EApgigASmrgES/EdWbSMXrfylxDueS4UrRUCYy3tz7zWfAOiu09/doV4
         imCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429580; x=1729034380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B4dEWv8y9Qd3S1MimW5v7zVo47XrMO3kEwqW/kDQMo=;
        b=ELj8BSuWu0KfUHjlg/YqE/ctN5O6U2vqHHJ9xa/crgTG4bQE4ymU7IG5uyO5V5VBPA
         1kkaEqZjVyLMScOEG3bI42zrltyl/0sFxMq0HzX6iss/FIlJtQSoxJEnEm/GR/yBgmFs
         ZEf1CYFvhj0kM7BY8jWqAaapyJVE5hZ581Sxx1kBaSxTSSeuZsN9S/YIa3AhvZ3IuS2b
         cAs2JGKo18Zj3NRBcpBlLzQSxPyFtJfit7nWu+1zZ7fZknlyg5BOy5WmGhHDNnmvXTID
         /0whmYWYHmCuY1Ow0kZdKDoNDaInIC0TDyQsMdeMyLqqvr5y1DZZaFxKJRsqAFX/CiCS
         +D2A==
X-Gm-Message-State: AOJu0YzTnVLfE0yD1SBW03YgrvhhJBQFfu/prId4eXFqsULxYOm60pUD
	XIczp+nDZ5cdYyu5S0RhMUZuAYPhzppAuW8+rozfWHZDtlO3NcS0mKjkyiKIha/7P3AJaT/Vsoe
	H5lY40lr7WGpBSJWtiQrzEEFkDDKq3jrxhwAiYEjZz8hZqCCYdhna7YmYlL+GMnaE1xK5riAFyh
	qo3oKR/D6b8S2lGZiO0IHGRfhG57hJQu3+jq6ZmDM=
X-Google-Smtp-Source: AGHT+IGFD59NCCleS6BX2GYgT7iFovjLMdbeGPJiXYBhmViUXj/+6TpPdGFZ+Jb6WucYSDQAYwpvSPv1MShcSg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:7c00:8752:4498:cc1b])
 (user=steadmon job=sendgmr) by 2002:a05:690c:460d:b0:6db:89f0:b897 with SMTP
 id 00721157ae682-6e3221683d8mr12047b3.4.1728429578861; Tue, 08 Oct 2024
 16:19:38 -0700 (PDT)
Date: Tue,  8 Oct 2024 16:19:31 -0700
In-Reply-To: <cover.1728429158.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1728429158.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <1ae14207f69af3d1c6fe19dfd779062a69f16122.1728429158.git.steadmon@google.com>
Subject: [PATCH v4 1/5] common-main: split init and exit code into new files
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, ps@pks.im, sunshine@sunshineco.com, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
Content-Type: text/plain; charset="UTF-8"

Currently, object files in libgit.a reference common_exit(), which is
contained in common-main.o. However, common-main.o also includes main(),
which references cmd_main() in git.o, which in turn depends on all the
builtin/*.o objects.

We would like to allow external users to link libgit.a without needing
to include so many extra objects. Enable this by splitting common_exit()
and check_bug_if_BUG() into a new file common-exit.c, and add
common-exit.o to LIB_OBJS so that these are included in libgit.a.

This split has previously been proposed ([1], [2]) to support fuzz tests
and unit tests by avoiding conflicting definitions for main(). However,
both of those issues were resolved by other methods of avoiding symbol
conflicts. Now we are trying to make libgit.a more self-contained, so
hopefully we can revisit this approach.

Additionally, move the initialization code out of main() into a new
init_git() function in its own file. Include this in libgit.a as well,
so that external users can share our setup code without calling our
main().

[1] https://lore.kernel.org/git/Yp+wjCPhqieTku3X@google.com/
[2] https://lore.kernel.org/git/20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile      |  2 ++
 common-exit.c | 26 ++++++++++++++++
 common-init.c | 63 ++++++++++++++++++++++++++++++++++++++
 common-init.h |  6 ++++
 common-main.c | 83 ++-------------------------------------------------
 5 files changed, 99 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h

diff --git a/Makefile b/Makefile
index 3eab701b10..7caeb3c872 100644
--- a/Makefile
+++ b/Makefile
@@ -979,6 +979,8 @@ LIB_OBJS += combine-diff.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += commit.o
+LIB_OBJS += common-exit.o
+LIB_OBJS += common-init.o
 LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
diff --git a/common-exit.c b/common-exit.c
new file mode 100644
index 0000000000..1aaa538be3
--- /dev/null
+++ b/common-exit.c
@@ -0,0 +1,26 @@
+#include "git-compat-util.h"
+#include "trace2.h"
+
+static void check_bug_if_BUG(void)
+{
+	if (!bug_called_must_BUG)
+		return;
+	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
+}
+
+/* We wrap exit() to call common_exit() in git-compat-util.h */
+int common_exit(const char *file, int line, int code)
+{
+	/*
+	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
+	 * to e.g. turn -1 into 255. On a POSIX system this is
+	 * redundant, see exit(3) and wait(2), but as it doesn't harm
+	 * anything there we don't need to guard this with an "ifdef".
+	 */
+	code &= 0xff;
+
+	check_bug_if_BUG();
+	trace2_cmd_exit_fl(file, line, code);
+
+	return code;
+}
diff --git a/common-init.c b/common-init.c
new file mode 100644
index 0000000000..5cc73f058c
--- /dev/null
+++ b/common-init.c
@@ -0,0 +1,63 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "git-compat-util.h"
+#include "common-init.h"
+#include "exec-cmd.h"
+#include "gettext.h"
+#include "attr.h"
+#include "repository.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "trace2.h"
+
+/*
+ * Many parts of Git have subprograms communicate via pipe, expect the
+ * upstream of a pipe to die with SIGPIPE when the downstream of a
+ * pipe does not need to read all that is written.  Some third-party
+ * programs that ignore or block SIGPIPE for their own reason forget
+ * to restore SIGPIPE handling to the default before spawning Git and
+ * break this carefully orchestrated machinery.
+ *
+ * Restore the way SIGPIPE is handled to default, which is what we
+ * expect.
+ */
+static void restore_sigpipe_to_default(void)
+{
+	sigset_t unblock;
+
+	sigemptyset(&unblock);
+	sigaddset(&unblock, SIGPIPE);
+	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
+	signal(SIGPIPE, SIG_DFL);
+}
+
+void init_git(const char **argv)
+{
+	struct strbuf tmp = STRBUF_INIT;
+
+	trace2_initialize_clock();
+
+	/*
+	 * Always open file descriptors 0/1/2 to avoid clobbering files
+	 * in die().  It also avoids messing up when the pipes are dup'ed
+	 * onto stdin/stdout/stderr in the child processes we spawn.
+	 */
+	sanitize_stdfds();
+	restore_sigpipe_to_default();
+
+	git_resolve_executable_dir(argv[0]);
+
+	setlocale(LC_CTYPE, "");
+	git_setup_gettext();
+
+	initialize_repository(the_repository);
+
+	attr_start();
+
+	trace2_initialize();
+	trace2_cmd_start(argv);
+	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
+
+	if (!strbuf_getcwd(&tmp))
+		tmp_original_cwd = strbuf_detach(&tmp, NULL);
+}
diff --git a/common-init.h b/common-init.h
new file mode 100644
index 0000000000..3e6db20cae
--- /dev/null
+++ b/common-init.h
@@ -0,0 +1,6 @@
+#ifndef COMMON_INIT_H
+#define COMMON_INIT_H
+
+void init_git(const char **argv);
+
+#endif /* COMMON_INIT_H */
diff --git a/common-main.c b/common-main.c
index 8e68ac9e42..6b7ab077b0 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,92 +1,13 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
-#include "exec-cmd.h"
-#include "gettext.h"
-#include "attr.h"
-#include "repository.h"
-#include "setup.h"
-#include "strbuf.h"
-#include "trace2.h"
-
-/*
- * Many parts of Git have subprograms communicate via pipe, expect the
- * upstream of a pipe to die with SIGPIPE when the downstream of a
- * pipe does not need to read all that is written.  Some third-party
- * programs that ignore or block SIGPIPE for their own reason forget
- * to restore SIGPIPE handling to the default before spawning Git and
- * break this carefully orchestrated machinery.
- *
- * Restore the way SIGPIPE is handled to default, which is what we
- * expect.
- */
-static void restore_sigpipe_to_default(void)
-{
-	sigset_t unblock;
-
-	sigemptyset(&unblock);
-	sigaddset(&unblock, SIGPIPE);
-	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
-	signal(SIGPIPE, SIG_DFL);
-}
+#include "common-init.h"
 
 int main(int argc, const char **argv)
 {
 	int result;
-	struct strbuf tmp = STRBUF_INIT;
-
-	trace2_initialize_clock();
-
-	/*
-	 * Always open file descriptors 0/1/2 to avoid clobbering files
-	 * in die().  It also avoids messing up when the pipes are dup'ed
-	 * onto stdin/stdout/stderr in the child processes we spawn.
-	 */
-	sanitize_stdfds();
-	restore_sigpipe_to_default();
-
-	git_resolve_executable_dir(argv[0]);
-
-	setlocale(LC_CTYPE, "");
-	git_setup_gettext();
-
-	initialize_repository(the_repository);
-
-	attr_start();
-
-	trace2_initialize();
-	trace2_cmd_start(argv);
-	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
-
-	if (!strbuf_getcwd(&tmp))
-		tmp_original_cwd = strbuf_detach(&tmp, NULL);
 
+	init_git(argv);
 	result = cmd_main(argc, argv);
 
 	/* Not exit(3), but a wrapper calling our common_exit() */
 	exit(result);
 }
-
-static void check_bug_if_BUG(void)
-{
-	if (!bug_called_must_BUG)
-		return;
-	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
-}
-
-/* We wrap exit() to call common_exit() in git-compat-util.h */
-int common_exit(const char *file, int line, int code)
-{
-	/*
-	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
-	 * to e.g. turn -1 into 255. On a POSIX system this is
-	 * redundant, see exit(3) and wait(2), but as it doesn't harm
-	 * anything there we don't need to guard this with an "ifdef".
-	 */
-	code &= 0xff;
-
-	check_bug_if_BUG();
-	trace2_cmd_exit_fl(file, line, code);
-
-	return code;
-}
-- 
2.47.0.rc0.187.ge670bccf7e-goog

