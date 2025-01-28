Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6F19ADA2
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101706; cv=none; b=C5Wh40nmiDlDZOZD1ZSOomhEY7s891ZRHdpkArC4jEsYB0jfnT9UYtYO9lxQ4wv4JiKpqm1uMXAJrM673t83dp6oOFWSSjB4xix3ZuYNH4q0lAA64DA2og6fj2ZszhXH6kgeS/PboYMu7+7i+dEhk3PAEMe+lBil4ivFiRwV5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101706; c=relaxed/simple;
	bh=xpQ5r3b+wKyJStBtFVyIeSlIbJg+wtr2luHDlzGJRy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3ZS/4uqRB8+KAhzzS+iUDTR0UZnvXe/YB91BNPqv3pgvs46ywO+vcZSrHIq9H85J6ld2C7NEN/Q6Bob+08xCaNtRNWFgK02a5ywKpwT5z3MiCYg10ZzIR/VPLnoYD+Euur8DgAo5A2sDWltKtU/t5foth3PqAxwNjTXYjT1k9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUf0ID8g; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUf0ID8g"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so17865095a91.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 14:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738101704; x=1738706504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9I/fPoi91qaez+oEvBEfPK30HgUg9/3UbRce4Ryttw=;
        b=qUf0ID8gkIDH6XAo9Qj5vXB8g4tco4IneEDloT9UrkYoEMiwFkZmWCn0zPTAPrlGDz
         ehhBQVPjMQIujGG9WbtemE4+VUoEoWEQoSGZVztRc1JEQ8DT8e3CHkNpCi6DQJesuIaJ
         1iGL5f+RXf8v2e2C7JRw4jxFxLjVPFI26F2410k0zJmc3ZqTJmO/lvw05M8Nd7VkRntZ
         taGcbpX8pIuPezaiR/9uPBGHHBlxU43ZOtRTBlEgiBvJVfj8ixoCX2FJE3kKc6QDs0m7
         tNqK42cwLlUvKF6GR/ft+NspXiVz7utVxFwVj130wJqWB8LX+4SkR+O9kMFQkNlwXBQc
         REaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101704; x=1738706504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9I/fPoi91qaez+oEvBEfPK30HgUg9/3UbRce4Ryttw=;
        b=AVGUAzBOUitYJgAXREuyUa7d8+diycMifz5vkPv+XUqEWxnJEhYSUokP9n33NWuKd1
         JmFlWvHOBbnS/DV3x5Z1tISQnITGyp+T7RNu28zQCCl3Al6F51i6YD7k+1OOU+ATk7je
         wF7PDBFVpQ5VAiRn78x0wT2B2KUmARvDphvR9uE5gxsmLZ6RTB6F1deLc1A/+cFAjJ22
         BMCxgJvEfzaDcffryOmCOe6wDpi1dvI5JTkUMYaDd6cJPYYxwdr3HUQyAg5OD+YRmOnl
         4nNdxHhE6Krm4aDungCZSLFBLxPIVb9vdkl92xpWSvAEAEYVmxuny8pMF5rNpFAPphc7
         041A==
X-Gm-Message-State: AOJu0YyXjeyuU5Uyyq8/o4ZqjE+fEKtzPWt+ReKRwJRUQQp1NpE2VKFH
	45DWqwoRgsAGnPb2podjh5avLEMer25xCU1xF84fQcH5qIX3oOyJpy+CksWCOfIBV1byMOlQVnN
	PCuta8ywnf8lvcTjhjQkL2x6WRtjqpbq+1WUOG3pjFn/jzzzrt9XqB0nJL48HThMoLLZCfPP3l1
	ixE53tYI+HUJ/XTqYlK5qK3gWkVTzo9TAzBo1C+Eg=
X-Google-Smtp-Source: AGHT+IGDgyDL1a6P/Mqeor7DUbSC7QzePqZDwZUJWJQsNFATkpSKj56Kd+Igf7iAs4PLjqcrdHHQ4xo5Gw4sKw==
X-Received: from pjbdb3.prod.google.com ([2002:a17:90a:d643:b0:2ef:7aa2:dd51])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2dcd:b0:2ee:d96a:5831 with SMTP id 98e67ed59e1d1-2f83ac801e2mr953534a91.30.1738101704172;
 Tue, 28 Jan 2025 14:01:44 -0800 (PST)
Date: Tue, 28 Jan 2025 14:01:37 -0800
In-Reply-To: <cover.1738101256.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738101256.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <cd0cb9aa046b99d2cd3f95b0a8cc7aaf29c677d5.1738101256.git.steadmon@google.com>
Subject: [PATCH v8 1/4] common-main: split init and exit code into new files
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com
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
 meson.build   |  2 ++
 6 files changed, 101 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h

diff --git a/Makefile b/Makefile
index 97e8385b66..27e68ac039 100644
--- a/Makefile
+++ b/Makefile
@@ -981,6 +981,8 @@ LIB_OBJS += combine-diff.o
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
diff --git a/meson.build b/meson.build
index 0064eb64f5..e5ba28b47f 100644
--- a/meson.build
+++ b/meson.build
@@ -245,6 +245,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
-- 
2.48.1.262.g85cc9f2d1e-goog

