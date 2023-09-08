Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5144EEB565
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbjIHRpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245455AbjIHRpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:45:07 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5CC1FEA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:44:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5701dbeaf9fso3103925a12.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195098; x=1694799898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEnG0kNNpgL4K9o3XTg8w1Lw86qqjPuU7AWSct/ZOOU=;
        b=vhGDOBnMUU3JePi5MiJJu73g0d00oj/HF+NsCKYtGLpDe46/Rd/d6FsP52m6hMo2SB
         vsKVcwQXXAmee/WnW54CkJNfW/7j7XAFCjLnRJppxKGgnqjVxdLk1BO5T3KhOr2SfWV/
         6NKQCduvbD3R4RZqPMdh1lmlKGJpTEv6szftUFPOQLVgRDFFMZAN+AGbAByEGxH3yipE
         BmaENIiFs192lS4uN6zg7pfcpYAwBlZgU42WB4P9Oy5AYA4QttZliocMK1yjnLN8tJ2Z
         Ke2DKzKxDdWRWhy7fx6BrbLJXecoo3tLNckwPKMvqjdEuj1pddZlZcTpkMNmXSsHHbgS
         i6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195098; x=1694799898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEnG0kNNpgL4K9o3XTg8w1Lw86qqjPuU7AWSct/ZOOU=;
        b=DI2RHV2Mbf8poTWWBmylKfU6Ui0kipPQtiGyznoHUuRwrDf9dv8Ljc3xt7LQAvtn/x
         bZjvOxYfIqbSc5wHwN+KpHx3u0tCBAmCVRGz8ssVS4yq3RsYiwkiN2ZngXlD4YE6lWOW
         KOogk448USi//o6WJ3N9jR+n1gPbfruNze0qW0I2nbOGK4nMEe0MuPhC5zS9aDIClHr3
         TECm37zcfl2pdSMNEJZcDWUAj+a3uRH2tajZFQUEIshRStdqjTZCMmSj2Qr7aPbv9LHH
         RrJkLrVH1UCaYZV+3m0y6xiPZFoBMLygo5m6g7Gxr+AE11cpyx1mN12DH4GyDS5AZAng
         lzqQ==
X-Gm-Message-State: AOJu0YxhIr76sHU+2vbrsTsoG0L34QiJhAqAIj4o1DZ4AmG8e9e4o5rW
        nf5SOvjMD4a+9DKj/Sr5PrM74uHMK6TVD24zYx/J23xjleHN5l0tdnTQesbW/+fTdLiWCFYbDfL
        nJdHgkypf8B1e1HbUfa4gzIWvsDyWGKX3gLz/PKZ5ebbvCf5MxozXBWUHVBF3n912tQ==
X-Google-Smtp-Source: AGHT+IHYohkaaPNiRRoqv4xDizlpYoz0FRFW4sM8Ssq2DAfML0cTzfs9X4tVSrLHXBJxYuZrvDKAni2pw99kleo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:3542:0:b0:564:8375:d238 with SMTP id
 c63-20020a633542000000b005648375d238mr580283pga.4.1694195098104; Fri, 08 Sep
 2023 10:44:58 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:44:42 +0000
In-Reply-To: <20230908174134.1026823-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230908174134.1026823-1-calvinwan@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908174443.1027716-5-calvinwan@google.com>
Subject: [PATCH v3 5/6] git-std-lib: introduce git standard library
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git Standard Library intends to serve as the foundational library
and root dependency that other libraries in Git will be built off of.
That is to say, suppose we have libraries X and Y; a user that wants to
use X and Y would need to include X, Y, and this Git Standard Library.

Add Documentation/technical/git-std-lib.txt to further explain the
design and rationale.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
---
 Documentation/technical/git-std-lib.txt | 191 ++++++++++++++++++++++++
 Makefile                                |  39 ++++-
 git-compat-util.h                       |   7 +-
 stubs/pager.c                           |   6 +
 stubs/pager.h                           |   6 +
 stubs/trace2.c                          |  27 ++++
 symlinks.c                              |   2 +
 wrapper.c                               |   1 -
 8 files changed, 276 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt
 create mode 100644 stubs/pager.c
 create mode 100644 stubs/pager.h
 create mode 100644 stubs/trace2.c

diff --git a/Documentation/technical/git-std-lib.txt b/Documentation/technical/git-std-lib.txt
new file mode 100644
index 0000000000..397c1da8c8
--- /dev/null
+++ b/Documentation/technical/git-std-lib.txt
@@ -0,0 +1,191 @@
+Git Standard Library
+================
+
+The Git Standard Library intends to serve as the foundational library
+and root dependency that other libraries in Git will be built off of.
+That is to say, suppose we have libraries X and Y; a user that wants to
+use X and Y would need to include X, Y, and this Git Standard Library.
+This does not mean that the Git Standard Library will be the only
+possible root dependency in the future, but rather the most significant
+and widely used one.
+
+Dependency graph in libified Git
+================
+
+If you look in the Git Makefile, all of the objects defined in the Git
+library are compiled and archived into a singular file, libgit.a, which
+is linked against by common-main.o with other external dependencies and
+turned into the Git executable. In other words, the Git executable has
+dependencies on libgit.a and a couple of external libraries. The
+libfication of Git will not affect this current build flow, but instead
+will provide an alternate method for building Git.
+
+With our current method of building Git, we can imagine the dependency
+graph as such:
+
+        Git
+         /\
+        /  \
+       /    \
+  libgit.a   ext deps
+
+In libifying parts of Git, we want to shrink the dependency graph to
+only the minimal set of dependencies, so libraries should not use
+libgit.a. Instead, it would look like:
+
+                Git
+                /\
+               /  \
+              /    \
+          libgit.a  ext deps
+             /\
+            /  \
+           /    \
+object-store.a  (other lib)
+      |        /
+      |       /
+      |      /
+ config.a   / 
+      |    /
+      |   /
+      |  /
+git-std-lib.a
+
+Instead of containing all of the objects in Git, libgit.a would contain
+objects that are not built by libraries it links against. Consequently,
+if someone wanted their own custom build of Git with their own custom
+implementation of the object store, they would only have to swap out
+object-store.a rather than do a hard fork of Git.
+
+Rationale behind Git Standard Library
+================
+
+The rationale behind what's in and what's not in the Git Standard
+Library essentially is the result of two observations within the Git
+codebase: every file includes git-compat-util.h which defines functions
+in a couple of different files, and wrapper.c + usage.c have
+difficult-to-separate circular dependencies with each other and other
+files.
+
+Ubiquity of git-compat-util.h and circular dependencies
+========
+
+Every file in the Git codebase includes git-compat-util.h. It serves as
+"a compatibility aid that isolates the knowledge of platform specific
+inclusion order and what feature macros to define before including which
+system header" (Junio[1]). Since every file includes git-compat-util.h, and
+git-compat-util.h includes wrapper.h and usage.h, it would make sense
+for wrapper.c and usage.c to be a part of the root library. They have
+difficult to separate circular dependencies with each other so they
+can't be independent libraries. Wrapper.c has dependencies on parse.c,
+abspath.c, strbuf.c, which in turn also have dependencies on usage.c and
+wrapper.c -- more circular dependencies. 
+
+Tradeoff between swappability and refactoring
+========
+
+From the above dependency graph, we can see that git-std-lib.a could be
+many smaller libraries rather than a singular library. So why choose a
+singular library when multiple libraries can be individually easier to
+swap and are more modular? A singular library requires less work to
+separate out circular dependencies within itself so it becomes a
+tradeoff question between work and reward. While there may be a point in
+the future where a file like usage.c would want its own library so that
+someone can have custom die() or error(), the work required to refactor
+out the circular dependencies in some files would be enormous due to
+their ubiquity so therefore I believe it is not worth the tradeoff
+currently. Additionally, we can in the future choose to do this refactor
+and change the API for the library if there becomes enough of a reason
+to do so (remember we are avoiding promising stability of the interfaces
+of those libraries).
+
+Reuse of compatibility functions in git-compat-util.h
+========
+
+Most functions defined in git-compat-util.h are implemented in compat/
+and have dependencies limited to strbuf.h and wrapper.h so they can be
+easily included in git-std-lib.a, which as a root dependency means that
+higher level libraries do not have to worry about compatibility files in
+compat/. The rest of the functions defined in git-compat-util.h are
+implemented in top level files and are hidden behind
+an #ifdef if their implementation is not in git-std-lib.a.
+
+Rationale summary
+========
+
+The Git Standard Library allows us to get the libification ball rolling
+with other libraries in Git. By not spending many
+more months attempting to refactor difficult circular dependencies and
+instead spending that time getting to a state where we can test out
+swapping a library out such as config or object store, we can prove the
+viability of Git libification on a much faster time scale. Additionally
+the code cleanups that have happened so far have been minor and
+beneficial for the codebase. It is probable that making large movements
+would negatively affect code clarity.
+
+Git Standard Library boundary
+================
+
+While I have described above some useful heuristics for identifying
+potential candidates for git-std-lib.a, a standard library should not
+have a shaky definition for what belongs in it.
+
+ - Low-level files (aka operates only on other primitive types) that are
+   used everywhere within the codebase (wrapper.c, usage.c, strbuf.c)
+   - Dependencies that are low-level and widely used
+     (abspath.c, date.c, hex-ll.c, parse.c, utf8.c)
+ - low-level git/* files with functions defined in git-compat-util.h
+   (ctype.c)
+ - compat/*
+ - stubbed out dependencies in stubs/ (stubs/pager.c, stubs/trace2.c)
+
+There are other files that might fit this definition, but that does not
+mean it should belong in git-std-lib.a. Those files should start as
+their own separate library since any file added to git-std-lib.a loses
+its flexibility of being easily swappable.
+
+Wrapper.c and usage.c have dependencies on pager and trace2 that are
+possible to remove at the cost of sacrificing the ability for standard Git
+to be able to trace functions in those files and other files in git-std-lib.a.
+In order for git-std-lib.a to compile with those dependencies, stubbed out
+versions of those files are implemented and swapped in during compilation time.
+
+Files inside of Git Standard Library
+================
+
+The initial set of files in git-std-lib.a are:
+abspath.c
+ctype.c
+date.c
+hex-ll.c
+parse.c
+strbuf.c
+usage.c
+utf8.c
+wrapper.c
+relevant compat/ files
+
+When these files are compiled together with the following files (or
+user-provided files that provide the same functions), they form a
+complete library:
+stubs/pager.c
+stubs/trace2.c
+
+Pitfalls
+================
+
+There are a small amount of files under compat/* that have dependencies
+not inside of git-std-lib.a. While those functions are not called on
+Linux, other OSes might call those problematic functions. I don't see
+this as a major problem, just moreso an observation that libification in
+general may also require some minor compatibility work in the future.
+
+Testing
+================
+
+Unit tests should catch any breakages caused by changes to files in
+git-std-lib.a (i.e. introduction of a out of scope dependency) and new
+functions introduced to git-std-lib.a will require unit tests written
+for them.
+
+[1] https://lore.kernel.org/git/xmqqwn17sydw.fsf@gitster.g/
\ No newline at end of file
diff --git a/Makefile b/Makefile
index 9226c719a0..0a2d1ae3cc 100644
--- a/Makefile
+++ b/Makefile
@@ -669,6 +669,7 @@ FUZZ_PROGRAMS =
 GIT_OBJS =
 LIB_OBJS =
 SCALAR_OBJS =
+STUB_OBJS =
 OBJECTS =
 OTHER_PROGRAMS =
 PROGRAM_OBJS =
@@ -956,6 +957,7 @@ COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 
+ifndef GIT_STD_LIB
 LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
 LIB_OBJS += add-patch.o
@@ -1196,6 +1198,27 @@ LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+else ifdef GIT_STD_LIB
+LIB_OBJS += abspath.o
+LIB_OBJS += ctype.o
+LIB_OBJS += date.o
+LIB_OBJS += hex-ll.o
+LIB_OBJS += parse.o
+LIB_OBJS += strbuf.o
+LIB_OBJS += usage.o
+LIB_OBJS += utf8.o
+LIB_OBJS += wrapper.o
+
+ifdef STUB_TRACE2
+STUB_OBJS += stubs/trace2.o
+endif
+
+ifdef STUB_PAGER
+STUB_OBJS += stubs/pager.o
+endif
+
+LIB_OBJS += $(STUB_OBJS)
+endif
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
@@ -2162,6 +2185,11 @@ ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
+ifdef GIT_STD_LIB
+	BASIC_CFLAGS += -DGIT_STD_LIB
+	BASIC_CFLAGS += -DNO_GETTEXT
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -3668,7 +3696,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB) $(STD_LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3849,3 +3877,12 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+### Libified Git rules
+
+# git-std-lib
+# `make git-std-lib.a GIT_STD_LIB=YesPlease STUB_TRACE2=YesPlease STUB_PAGER=YesPlease`
+STD_LIB = git-std-lib.a
+
+$(STD_LIB): $(LIB_OBJS) $(COMPAT_OBJS) $(STUB_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
diff --git a/git-compat-util.h b/git-compat-util.h
index 3e7a59b5ff..14bf71c530 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -455,8 +455,8 @@ static inline int noop_core_config(const char *var UNUSED,
 #define platform_core_config noop_core_config
 #endif
 
+#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
 int lstat_cache_aware_rmdir(const char *path);
-#if !defined(__MINGW32__) && !defined(_MSC_VER)
 #define rmdir lstat_cache_aware_rmdir
 #endif
 
@@ -966,9 +966,11 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 #endif
 
 #ifdef NO_PTHREADS
+#ifdef GIT_STD_LIB
 #define atexit git_atexit
 int git_atexit(void (*handler)(void));
 #endif
+#endif
 
 static inline size_t st_add(size_t a, size_t b)
 {
@@ -1462,14 +1464,17 @@ static inline int is_missing_file_error(int errno_)
 	return (errno_ == ENOENT || errno_ == ENOTDIR);
 }
 
+#ifndef GIT_STD_LIB
 int cmd_main(int, const char **);
 
 /*
  * Intercept all calls to exit() and route them to trace2 to
  * optionally emit a message before calling the real exit().
  */
+
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
+#endif
 
 /*
  * You can mark a stack variable with UNLEAK(var) to avoid it being
diff --git a/stubs/pager.c b/stubs/pager.c
new file mode 100644
index 0000000000..4f575cada7
--- /dev/null
+++ b/stubs/pager.c
@@ -0,0 +1,6 @@
+#include "pager.h"
+
+int pager_in_use(void)
+{
+	return 0;
+}
diff --git a/stubs/pager.h b/stubs/pager.h
new file mode 100644
index 0000000000..b797910881
--- /dev/null
+++ b/stubs/pager.h
@@ -0,0 +1,6 @@
+#ifndef PAGER_H
+#define PAGER_H
+
+int pager_in_use(void);
+
+#endif /* PAGER_H */
diff --git a/stubs/trace2.c b/stubs/trace2.c
new file mode 100644
index 0000000000..7d89482228
--- /dev/null
+++ b/stubs/trace2.c
@@ -0,0 +1,27 @@
+#include "git-compat-util.h"
+#include "trace2.h"
+
+struct child_process { int stub; };
+struct repository { int stub; };
+struct json_writer { int stub; };
+
+void trace2_region_enter_fl(const char *file, int line, const char *category,
+			    const char *label, const struct repository *repo, ...) { }
+void trace2_region_leave_fl(const char *file, int line, const char *category,
+			    const char *label, const struct repository *repo, ...) { }
+void trace2_data_string_fl(const char *file, int line, const char *category,
+			   const struct repository *repo, const char *key,
+			   const char *value) { }
+void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names) { }
+void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
+			    va_list ap) { }
+void trace2_cmd_name_fl(const char *file, int line, const char *name) { }
+void trace2_thread_start_fl(const char *file, int line,
+			    const char *thread_base_name) { }
+void trace2_thread_exit_fl(const char *file, int line) { }
+void trace2_data_intmax_fl(const char *file, int line, const char *category,
+			   const struct repository *repo, const char *key,
+			   intmax_t value) { }
+int trace2_is_enabled(void) { return 0; }
+void trace2_counter_add(enum trace2_counter_id cid, uint64_t value) { }
+void trace2_collect_process_info(enum trace2_process_info_reason reason) { }
diff --git a/symlinks.c b/symlinks.c
index b29e340c2d..bced721a0c 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -337,6 +337,7 @@ void invalidate_lstat_cache(void)
 	reset_lstat_cache(&default_cache);
 }
 
+#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
 #undef rmdir
 int lstat_cache_aware_rmdir(const char *path)
 {
@@ -348,3 +349,4 @@ int lstat_cache_aware_rmdir(const char *path)
 
 	return ret;
 }
+#endif
diff --git a/wrapper.c b/wrapper.c
index 7da15a56da..eeac3741cf 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,7 +5,6 @@
 #include "abspath.h"
 #include "parse.h"
 #include "gettext.h"
-#include "repository.h"
 #include "strbuf.h"
 #include "trace2.h"
 
-- 
2.42.0.283.g2d96d420d3-goog

