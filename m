Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F40BC04FDF
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjHJQiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjHJQhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC9B30CA
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586a5cd0ea9so14281777b3.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685441; x=1692290241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cUxUi4uBhpupqkYaatpzJKbvNJPyRHJkk6V+qr5Vb4=;
        b=G+LsoA+yudAStO6f55w5mi0OOi/6J7MFiC3LnGIYr4hPJvfsj43BEaDIsPkuYbXRcQ
         +QaHC0HzdPYhjhXYHTLhys8vEURtahqzXHecK+OzEAQqAO+N7r2OFcN5h/Wg5tjMIucy
         ar5va2SDAx8dN0H8pFmYK4enaAiMtCOUqy97buKyEPRlH5s9gnBWlkQ3qFod8qoJU5IB
         brkIRWKDTgXYe7o1Z1gAXcO8tFBgvzkKCziXL8S0uHUGRJrpturQ1WIu4ZGCZf5egwwN
         lh37Fqa1lPDYG4VP/nlBHIdiPyImGnREzub8+33ITTdaCLf0DceJegt6mQNkQ1eGbP49
         DX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685441; x=1692290241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cUxUi4uBhpupqkYaatpzJKbvNJPyRHJkk6V+qr5Vb4=;
        b=OoLwjpwPVfzkwu9jHcZd7CMp+z5jGQeQ3LBBsg/VMLaTEOHeCp9e8b+wCI4wD6HIjl
         6zLB6/YWXWPybmM8hSlQvYQYJLjmMojhYtTKGY08UXdhPz3og/8YG3O7/ye9mrA+tedb
         Ztd4GJXpHtk60vYN+H4/sHGQRt7G3BqSSkYiNYrTliBLBD/AFDWDExWTklwOgcs5sp77
         1jaaq8V9NLSv2NnmkLNXrTdL02TWi2Tog9jWGWx+UhlX1Ea4jhgYx/mIu3vu3M2Y8lKu
         waLSkJb+8Hev11JpHT5ZmqswgJdDELy6fmSeA/x4Pve8kebDs6hiN0c85fqqG4ZhW4k6
         AvYg==
X-Gm-Message-State: AOJu0YyX5D6nFL/B3jp7j67y0i5oWLd+UdlhU1+T4CneKAv8E3H4D3u2
        StISLv9wJKJnLreIVGN4EOSnzMxwbd1ApAWx6nTFFs1qqQgU7U/MR/7e4kMieeV6Xee1npNjqnS
        9HvnnHGueY1HLnPt58eWdkWoxmt81vNIbRQpcQMiu0c+JMGcJNdNCsBO/eEZ2NUxB+w==
X-Google-Smtp-Source: AGHT+IHiPfVp2BF6m8O/k45+/sm2R70tM0MzJtCvVtx/9XzyyhLCF5TKmvcUs+2OGr6DsmRcKqY1VRGG9OMiWtg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:340a:0:b0:d0c:e71d:fab with SMTP id
 b10-20020a25340a000000b00d0ce71d0fabmr51740yba.0.1691685440927; Thu, 10 Aug
 2023 09:37:20 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:36:53 +0000
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810163654.275023-6-calvinwan@google.com>
Subject: [RFC PATCH v2 6/7] git-std-lib: introduce git standard library
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, jonathantanmy@google.com, linusa@google.com,
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
---
 Documentation/technical/git-std-lib.txt | 186 ++++++++++++++++++++++++
 Makefile                                |  62 +++++++-
 git-compat-util.h                       |   7 +-
 stubs/repository.c                      |   4 +
 stubs/repository.h                      |   8 +
 stubs/trace2.c                          |  22 +++
 stubs/trace2.h                          |  69 +++++++++
 symlinks.c                              |   2 +
 8 files changed, 358 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt
 create mode 100644 stubs/repository.c
 create mode 100644 stubs/repository.h
 create mode 100644 stubs/trace2.c
 create mode 100644 stubs/trace2.h

diff --git a/Documentation/technical/git-std-lib.txt b/Documentation/technical/git-std-lib.txt
new file mode 100644
index 0000000000..3d901a89b0
--- /dev/null
+++ b/Documentation/technical/git-std-lib.txt
@@ -0,0 +1,186 @@
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
+The rationale behind Git Standard Library essentially is the result of
+two observations within the Git codebase: every file includes
+git-compat-util.h which defines functions in a couple of different
+files, and wrapper.c + usage.c have difficult-to-separate circular
+dependencies with each other and other files.
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
+ - stubbed out dependencies in stubs/ (stubs/repository.c, stubs/trace2.c)
+
+There are other files that might fit this definition, but that does not
+mean it should belong in git-std-lib.a. Those files should start as
+their own separate library since any file added to git-std-lib.a loses
+its flexibility of being easily swappable.
+
+Wrapper.c and usage.c have dependencies on repository and trace2 that are
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
+stubs/repository.c
+stubs/trace2.c
+relevant compat/ files
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
index e9ad9f9ef1..82510cf50e 100644
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
+ifdef STUB_REPOSITORY
+STUB_OBJS += stubs/repository.o
+endif
+
+ifdef STUB_TRACE2
+STUB_OBJS += stubs/trace2.o
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
@@ -3654,7 +3682,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB) $(STD_LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3834,3 +3862,35 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+### Libified Git rules
+
+# git-std-lib
+# `make git-std-lib GIT_STD_LIB=YesPlease STUB_REPOSITORY=YesPlease STUB_TRACE2=YesPlease`
+STD_LIB = git-std-lib.a
+
+$(STD_LIB): $(LIB_OBJS) $(COMPAT_OBJS) $(STUB_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
+TEMP_HEADERS = temp_headers/
+
+git-std-lib:
+# Move headers to temporary folder and replace them with stubbed headers.
+# After building, move headers and stubbed headers back.
+ifneq ($(STUB_OBJS),)
+	mkdir -p $(TEMP_HEADERS); \
+	for d in $(STUB_OBJS); do \
+		BASE=$${d%.*}; \
+		mv $${BASE##*/}.h $(TEMP_HEADERS)$${BASE##*/}.h; \
+		mv $${BASE}.h $${BASE##*/}.h; \
+	done; \
+	$(MAKE) $(STD_LIB); \
+	for d in $(STUB_OBJS); do \
+		BASE=$${d%.*}; \
+		mv $${BASE##*/}.h $${BASE}.h; \
+		mv $(TEMP_HEADERS)$${BASE##*/}.h $${BASE##*/}.h; \
+	done; \
+	rm -rf temp_headers
+else
+	$(MAKE) $(STD_LIB)
+endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 481dac22b0..75aa9b263e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -396,8 +396,8 @@ static inline int noop_core_config(const char *var UNUSED,
 #define platform_core_config noop_core_config
 #endif
 
+#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
 int lstat_cache_aware_rmdir(const char *path);
-#if !defined(__MINGW32__) && !defined(_MSC_VER)
 #define rmdir lstat_cache_aware_rmdir
 #endif
 
@@ -787,9 +787,11 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 #endif
 
 #ifdef NO_PTHREADS
+#ifdef GIT_STD_LIB
 #define atexit git_atexit
 int git_atexit(void (*handler)(void));
 #endif
+#endif
 
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
@@ -951,14 +953,17 @@ int git_access(const char *path, int mode);
 # endif
 #endif
 
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
diff --git a/stubs/repository.c b/stubs/repository.c
new file mode 100644
index 0000000000..f81520d083
--- /dev/null
+++ b/stubs/repository.c
@@ -0,0 +1,4 @@
+#include "git-compat-util.h"
+#include "repository.h"
+
+struct repository *the_repository;
diff --git a/stubs/repository.h b/stubs/repository.h
new file mode 100644
index 0000000000..18262d748e
--- /dev/null
+++ b/stubs/repository.h
@@ -0,0 +1,8 @@
+#ifndef REPOSITORY_H
+#define REPOSITORY_H
+
+struct repository { int stub; };
+
+extern struct repository *the_repository;
+
+#endif /* REPOSITORY_H */
diff --git a/stubs/trace2.c b/stubs/trace2.c
new file mode 100644
index 0000000000..efc3f9c1f3
--- /dev/null
+++ b/stubs/trace2.c
@@ -0,0 +1,22 @@
+#include "git-compat-util.h"
+#include "trace2.h"
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
+void trace2_collect_process_info(enum trace2_process_info_reason reason) { }
diff --git a/stubs/trace2.h b/stubs/trace2.h
new file mode 100644
index 0000000000..88ad7387ff
--- /dev/null
+++ b/stubs/trace2.h
@@ -0,0 +1,69 @@
+#ifndef TRACE2_H
+#define TRACE2_H
+
+struct child_process { int stub; };
+struct repository;
+struct json_writer { int stub; };
+
+void trace2_region_enter_fl(const char *file, int line, const char *category,
+			    const char *label, const struct repository *repo, ...);
+
+#define trace2_region_enter(category, label, repo) \
+	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
+
+void trace2_region_leave_fl(const char *file, int line, const char *category,
+			    const char *label, const struct repository *repo, ...);
+
+#define trace2_region_leave(category, label, repo) \
+	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
+
+void trace2_data_string_fl(const char *file, int line, const char *category,
+			   const struct repository *repo, const char *key,
+			   const char *value);
+
+#define trace2_data_string(category, repo, key, value)                       \
+	trace2_data_string_fl(__FILE__, __LINE__, (category), (repo), (key), \
+			      (value))
+
+void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names);
+
+#define trace2_cmd_ancestry(v) trace2_cmd_ancestry_fl(__FILE__, __LINE__, (v))
+
+void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
+			    va_list ap);
+
+#define trace2_cmd_error_va(fmt, ap) \
+	trace2_cmd_error_va_fl(__FILE__, __LINE__, (fmt), (ap))
+
+
+void trace2_cmd_name_fl(const char *file, int line, const char *name);
+
+#define trace2_cmd_name(v) trace2_cmd_name_fl(__FILE__, __LINE__, (v))
+
+void trace2_thread_start_fl(const char *file, int line,
+			    const char *thread_base_name);
+
+#define trace2_thread_start(thread_base_name) \
+	trace2_thread_start_fl(__FILE__, __LINE__, (thread_base_name))
+
+void trace2_thread_exit_fl(const char *file, int line);
+
+#define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
+
+void trace2_data_intmax_fl(const char *file, int line, const char *category,
+			   const struct repository *repo, const char *key,
+			   intmax_t value);
+
+#define trace2_data_intmax(category, repo, key, value)                       \
+	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
+			      (value))
+
+enum trace2_process_info_reason {
+	TRACE2_PROCESS_INFO_STARTUP,
+	TRACE2_PROCESS_INFO_EXIT,
+};
+int trace2_is_enabled(void);
+void trace2_collect_process_info(enum trace2_process_info_reason reason);
+
+#endif /* TRACE2_H */
+
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
-- 
2.41.0.640.ga95def55d0-goog

