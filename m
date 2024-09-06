Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D071B85D9
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661285; cv=none; b=r4TNF8E/kMfXmqCNrs/osyU7PsWSbKpED8n9aAZxNmIKMuRPoblYRqEaRCoNfyC1pNmsULFp2mpZrYg9T+XXVBTN1Jf3gnV/10qBT/BFrt52TNMyijn9F0vqVkiIncE4YIe4v3zdoMxQLCxKxNcxvajFLoOL2yc2zKg80X3e3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661285; c=relaxed/simple;
	bh=cNjTQ9do7Pb592/l3hClue6Rg3U4igqIppECLFsKOsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KgPIV1AO1L1Qkn/oXh+lCNAuCHvN1WmTcPRzX7+upjioNnaFZr0StsRyrK86efP2vTzC9JELENlLr8tDWUjThmRyD2sahmxjTumL7XumB3XM90jtizwfretyJWJPyIw70v8uf8a6Q+mEc7fH7Wrtj1DGxBTrXfZb2HTdqMm2IwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ll5x0lIu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ll5x0lIu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2052a68430fso35393315ad.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725661283; x=1726266083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YWAuPL8uhjw1wpxp06VnUE1NuAuxV0ix64I1KoaU5c=;
        b=ll5x0lIuUJXJtCQR62jQXvX6aZ286ezLefp7qq7lVainNxQVRkrSf2JIvjcbTyd3Jq
         wmt5B/voiJkmvPzm2ba4Hin1swwy7IUV4igalwzyAAORbQFsLH0X5TO3tzQC/pB8+97v
         FeoBDufCR4HoIBJqCjmycf7NFWA6Gjw4Mnx4XepPvH95zFtCSkVfmUynem4w/5ZOQUXq
         hDxjjD8aVARrjiEtVHGqvZxq5UyY55BYRae1+RgwW6sRB1c1UvqVvlFzt5/4PEdW/QSs
         W6dBdHcOpixFLRkasmXQQFLsRbnP6TLbjgxwF2WGds8iEW6/Ck7pAGZqhp1vy1JOMykO
         X7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661283; x=1726266083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YWAuPL8uhjw1wpxp06VnUE1NuAuxV0ix64I1KoaU5c=;
        b=hNYkkyhj0/rFgO3nqYMVELgKsob5/BjOPce09fowqICFKJqtmg4s5W5uThrf3PX7Kc
         auw16cWTNp+UFmk3jm2lJvxmSggyjnPRQoyECU4VFOnKkK5ya9tUr5KSSnbmyBnCmZ++
         bk375HcUzzMCn12pp4Im4WaxtM8cmnLb/QdUrSRp4evo6BoWKTQZrhHy7of7qQkOsA0c
         Eur41Ta+fdakKYOJ1NLcurAzQwGqyhk/iUgOcxO9BDcDsVvN062nXRcAlN0gc6nNBZlh
         AQEwmlwWqE/SNF5eYoRA5BHYHC47SF1m+asl1tfsTxPFfmVGnEItLRRoZdDNPBZr3eYc
         gXDw==
X-Gm-Message-State: AOJu0YwNXRy2wSICufOx9YLMWLTm72BGs6rBZYehFWuUbg6VJQDd9lWa
	IrdoWaBPism6JslsKoiGi9+IRnzDKZfUFUDbObgVzFXcuCDb1rGbc0DHK8B8Sq1YAJLvPqrwgfI
	HFoCOvQ37KxJsr7acrAzK6NrbZVvqqhEqE+GNAZ1ty8hEPVxnfJV4Lq3Fk/Af/NHGsfDN9rL1Dz
	gNZbLKerVSmsTPSYoVTPQarsTaM7+r2+wFJitwm6D6COXR
X-Google-Smtp-Source: AGHT+IGK6VYPB16X4w5Uk/oR/UcVpl4J+dMgdhPJzxiMJoA+/GUDXhoWbo6ED59riPDl8jxKArEWzvMF/EO1Xp0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:f68c:b0:205:4d47:e3ca with SMTP
 id d9443c01a7336-206f04b1669mr4359905ad.2.1725661282845; Fri, 06 Sep 2024
 15:21:22 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:21:11 +0000
In-Reply-To: <20240906221853.257984-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906222116.270196-1-calvinwan@google.com>
Subject: [PATCH v3 1/6] common-main: split init and exit code into new files
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Steadmon <steadmon@google.com>

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

Change-Id: I3d9b23ac28a50a4b79760987a3f37b0c6f4cbf9c
Signed-off-by: Calvin Wan <calvinwan@google.com>
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
2.46.0.469.g59c65b2a67-goog

