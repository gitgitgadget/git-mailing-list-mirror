Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947851D61BB
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971551; cv=none; b=il8LhfQytb7ximsfMy13aChCz0dUsytHAlURmdAcK2ZguAWEitIpVit4oIYhrCaJuKJmLQmC4IeiP9OuW4ybf5DBRo303kRN+5yQPrJ1Rj2Aeu4p8dWXPZQ4kRJJOzgzGkEhqIrYRjLJNjpC0z+9g2qgtAgZoGhZupBKR4H2MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971551; c=relaxed/simple;
	bh=VJnKyKv1fpjrdio38HIZaxetMr/dZzyrE2vO98agGns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TvbzKa0gnyE0wtbozDVhKgPIKWI4+vm25UF5ufVb30E+8VO87oFukXbFhOay/yV7rrykA5J3BTsAS6BdAjhMZccYkABBL7jFacVdF0g/KDMMSbrEv4MWhXJRjiiaFm6MEJ/T3SuE+KQIyC1vwtWYhHdwG6lbKaO7cYrUth53/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yCh+UjS0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yCh+UjS0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21638389f63so1073635ad.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736971549; x=1737576349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQrEMC+sl7wsF0MXsCGtyp2CMun9dzs/KYxOHQiGEdI=;
        b=yCh+UjS0g2RFKfzBMthgF7ImWnlm73uk0Ve0K0ivDWMWuAs57ZMSIA5Y0QWgoZoChI
         oHgfW+TM0Sjinf6weRdnumSvBRZApZ6mOOZDJAB/ltLDgD02TLC0/W2yvzaXL9Zn63fz
         rYn3iX1AgWF+qEyXWoL24/BqriK1wVHJetpk3IVkRVf4JBXexFL+MMopILMPW73OuWjb
         6uMcLgdZ/1vRd7LfmDaAevxVaHvIRDr/968RYEMNnomDkKQf2VuCM9/57EcBVTP+az3q
         mUXOMpCh2CJC2DfuBctxfAI43LROPLUF1mBRFSYAmrG8sTprK1tjNQsqYDqc3cavl3sQ
         33HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971549; x=1737576349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQrEMC+sl7wsF0MXsCGtyp2CMun9dzs/KYxOHQiGEdI=;
        b=hZaciGZzHiuxVz4Eq2p6iBy+MA/r/spEU2qdlyRZZSzapl+B3sgClWhLR0bb15zm6E
         tiaCRpGmFuQ3ZlDXShoZYMhzGu6dBQjvSEK5tTbGvEnurxuYwlibg7NN0iMQVwibRJXa
         deH875mjZGknhwWsFxYPBT0ph9gLtWm7N5YbtwgACsYrXRMGEA4fEltbpbqr7/1QIIMY
         u6r71hnGs+DtOQwD1Erek1kUXQQ3R4jrYyzVai+HDzNZfC8Ys/NqePEezjmGTmuDfmPT
         TZrKdJkIoe0APDD3BsuLHnlzm5fAhCCf77S5j3/2YEAt8S59Ca7vau8vmv2HAOl/hjbu
         qnCw==
X-Gm-Message-State: AOJu0YwlcbjDo40BsF/eeYtK/XhhTX0SgQEQr3g3oloYR6AYZqa77FOl
	lY/u9xnQCNpE9hlsd9Z5Zkml1TKiGq9UDe6R9Ge5bgxeYJFeBT+oMWbHJTbO4FSub+FZgkeZlC9
	XdHMQWNCVzsIPI3op2aETMThISbOqQJKc0LVodwJkBwR+wAcntMkzfpDlZw6zAYYu0fESHX8/nh
	bHu57j+7jQRoOTJcrHnqK95/xSDBZ1MXehLZvhb8I=
X-Google-Smtp-Source: AGHT+IFO4TIbGpmI8m8x/Jpg3/nin3BGV/iRpsrnnpZu4P6z/2jI+lW1xkau7+YVDp/m5+0fb2VSunMBT+oFbg==
X-Received: from pfcj1.prod.google.com ([2002:a05:6a00:1741:b0:724:eefc:69ef])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:841a:b0:1ea:eca7:10ee with SMTP id adf61e73a8af0-1eaeca71173mr19624855637.6.1736971548603;
 Wed, 15 Jan 2025 12:05:48 -0800 (PST)
Date: Wed, 15 Jan 2025 12:05:40 -0800
In-Reply-To: <cover.1736971328.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1736971328.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <ff6cd62397ec2755d15e9d76f9af8a84b54a36c1.1736971328.git.steadmon@google.com>
Subject: [PATCH v6 1/5] common-main: split init and exit code into new files
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
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
-- 
2.48.0.rc2.279.g1de40edade-goog

