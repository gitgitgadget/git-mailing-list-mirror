Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E1157E97
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624261; cv=none; b=ltDmybb/AN03GVVV2z0pHoIPz7AE+ZdCE9y22wYCbM4rMojVqfgSsyFu06pTntmfJ/QlPtvbVgvHmY9rrkPeI9DFaDEOFLo/6DnJThTJOobzExZl01KaPKAi8p4q6xYL0G35nOVze/8269zzExM9/JdLLp6yk7wwzkSHAG5nv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624261; c=relaxed/simple;
	bh=r4PUGIvGvAdZx7rEJcIi664vrC47I8Zk0FztsjCqUn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ra0bKYryWfa3wZPv5Oj5ibw+TojgYZN2s1yhzMBfT5C3OEX+YRDYzcuchukv96wXUPC5BVyVB5pSsV19DG9yY6O61ySD8ZQ9hrc157VPfiUG6zrse1Gk7yPBvUS87S64x6IM+tK++XMqywDOgmj0BJx/X6Q9EjJsSESB2qFeAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Qz1yMN0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Qz1yMN0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60770007e52so97580057b3.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708624258; x=1709229058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdVmkS0j3Q6STfJeqvpWE/rPVNdBU7ihxxUrtqOBDHo=;
        b=0Qz1yMN0B6SjZWoG+JI7lUTfLVgTFEK0To5bmxoE/Doid108tjDzxNknzJsDxIO2pn
         BfuvCTIOt9nJtaMbiH7iONpzS9geQcAp1bG3muMf1mH9EbOH1Bu9/lhqK8gl4AkpAlIx
         /wxmcML7D+H+HC4FqUNEgmwqRZiEmywcOcdVxI1U8IbrraC/sAY2GRt+60Y51rHnLTDS
         OsvvqlSQD70nIrzfoWU/gwELbbmSKT0J+Q0vA3peSGjuPtwa/sVpx5gyRCDxb1/uJNq7
         xkLHUnZuvOirf88xpC7aKGFaRGbQZHDAuuJtgDlj934Vlc7RhVzNXYo230W6uBExKCls
         wEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624258; x=1709229058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdVmkS0j3Q6STfJeqvpWE/rPVNdBU7ihxxUrtqOBDHo=;
        b=Fd3E72sqD2nAqJYs/MI0zjI9aVcS+cVgp6UPysgDvrUpSngzSmwCfLDksQa8PiCufM
         Bn/2pkjlbJBlLty85vy5I27c/B2+06gjU2M71/zjRmtsdphKsKMfl4+6jy8tcEg5DXI9
         lHbm7hSmz3ScHfoRWZdjzyhppOkKrN/FVDWBLT1ZFLlAcfnQ9ZYGU3+iYcT6xtktVw6x
         DBrVkE6mdRa54OYuLop4If/zkZqsI08Sz5SIGZxzMemCVGfii7izJ9rdawGiiH+GtJ9l
         /9Gfc5KyjjNQthDTfSO9pQR95+1OeRCRuGbNkL+VE80lmrEF91SzT2aylhZO0QN2Grrr
         39bA==
X-Gm-Message-State: AOJu0YzJNC/w+rj5kLWqMOV+IJyuA2jVgk6BTyN2MgGPbIRDhRX68Yk9
	xMh7REDGGSqtcMzXVNJJqhCO6hvRTHq2tiFWOhE4TR6dbBrOlAAinbj89IrPEBY0c2ufhY4ThAD
	l7j69VTAf1mjh9uYib+iDctfxzv5XCMiJkoHuXelN1h5DSDL/T3j9qbhX4wbnajYZaglqyBaYqx
	mbuDbigz1WrmUcFtUz1AlgZQoyR92LHthstYbnWeZX+4Og
X-Google-Smtp-Source: AGHT+IEbcX47ieabCRECUUsk5OguG7orwiUnWA8PxgmE62L1/hjfxoBcvIptKkL1XmpbDo+oTv9LkGek9MWX8i0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ee0a:0:b0:608:66be:2f71 with SMTP id
 l10-20020a81ee0a000000b0060866be2f71mr1424468ywm.9.1708624258084; Thu, 22 Feb
 2024 09:50:58 -0800 (PST)
Date: Thu, 22 Feb 2024 17:50:32 +0000
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222175033.1489723-3-calvinwan@google.com>
Subject: [PATCH v5 2/3] git-std-lib: introduce Git Standard Library
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, 
	phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

This commit contains:
- Makefile rules for git-std-lib.a
- code and Makefile rules for git-stub-lib.a
- description and rationale of the above in Documentation/

Quoting from documentation introduced in this commit:

  The Git Standard Library intends to serve as the foundational library
  and root dependency that other libraries in Git will be built off
  of. That is to say, suppose we have libraries X and Y; a user that
  wants to use X and Y would need to include X, Y, and this Git Standard
  Library.

Code demonstrating the use of git-std-lib.a and git-stub-lib.a will be
in a subsequent commit.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/Makefile                  |   1 +
 Documentation/technical/git-std-lib.txt | 170 ++++++++++++++++++++++++
 Makefile                                |  48 +++++--
 stubs/misc.c                            |  33 +++++
 stubs/pager.c                           |   6 +
 stubs/trace2.c                          |  27 ++++
 6 files changed, 274 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt
 create mode 100644 stubs/misc.c
 create mode 100644 stubs/pager.c
 create mode 100644 stubs/trace2.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c..f1dc673838 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -110,6 +110,7 @@ TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/bundle-uri
+TECH_DOCS += technical/git-std-lib
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
diff --git a/Documentation/technical/git-std-lib.txt b/Documentation/technical/git-std-lib.txt
new file mode 100644
index 0000000000..3d9aa121ac
--- /dev/null
+++ b/Documentation/technical/git-std-lib.txt
@@ -0,0 +1,170 @@
+= Git Standard Library
+
+The Git Standard Library intends to serve as the foundational library
+and root dependency that other libraries in Git will be built off of.
+That is to say, suppose we have libraries X and Y; a user that wants to
+use X and Y would need to include X, Y, and this Git Standard Library.
+This does not mean that the Git Standard Library will be the only
+possible root dependency in the future, but rather the most significant
+and widely used one. Git itself is also built off of the Git Standard
+Library.
+
+== Dependency graph in libified Git
+
+Before the introduction of the Git Standard Library, all objects defined
+in the Git library are compiled and archived into a singular file,
+libgit.a, which is then linked against by common-main.o with other
+external dependencies and turned into the Git executable. In other
+words, the Git executable has dependencies on libgit.a and a couple of
+external libraries. The libfication of Git slightly alters this build
+flow by separating out libgit.a into libgit.a and git-std-lib.a. 
+
+With our current method of building Git, we can imagine the dependency
+graph as such:
+
+	Git
+	 /\
+	/  \
+       /    \
+  libgit.a   ext deps
+
+We want to separate out potential libraries from libgit.a and have
+libgit.a depend on them, which would possibly look like:
+
+		Git
+		/\
+	       /  \
+	      /    \
+	  libgit.a  ext deps
+	     /\
+	    /  \
+	   /    \
+object-store.a  (other lib)
+      |        /
+      |       /
+      |      /
+      |     /
+      |    /
+      |   /
+      |  /
+git-std-lib.a
+
+Instead of containing all objects in Git, libgit.a would contain objects
+that are not built by libraries it links against. Consequently, if
+someone wanted a custom build of Git with a custom implementation of the
+object store, they would only have to swap out object-store.a rather
+than do a hard fork of Git.
+
+== Rationale behind Git Standard Library
+
+The rationale behind the selected object files in the Git Standard
+Library is the result of two observations within the Git
+codebase:
+  1. every file includes git-compat-util.h which defines functions
+     in a couple of different files
+  2. wrapper.c + usage.c have difficult-to-separate circular
+     dependencies with each other and other files.
+
+=== Ubiquity of git-compat-util.h and circular dependencies
+
+Every file in the Git codebase includes git-compat-util.h. It serves as
+"a compatibility aid that isolates the knowledge of platform specific
+inclusion order and what feature macros to define before including which
+system header" (Junio[1]). Since every file includes git-compat-util.h,
+and git-compat-util.h includes wrapper.h and usage.h, it would make
+sense for wrapper.c and usage.c to be a part of the root library. They
+have difficult to separate circular dependencies with each other so it
+would impractical for them to be independent libraries. Wrapper.c has
+dependencies on parse.c, abspath.c, strbuf.c, which in turn also have
+dependencies on usage.c and wrapper.c - more circular dependencies.
+
+=== Tradeoff between swappability and refactoring
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
+=== Reuse of compatibility functions in git-compat-util.h
+
+Most functions defined in git-compat-util.h are implemented in compat/
+and have dependencies limited to strbuf.h and wrapper.h so they can be
+easily included in git-std-lib.a, which as a root dependency means that
+higher level libraries do not have to worry about compatibility files in
+compat/. The rest of the functions defined in git-compat-util.h are
+implemented in top level files and are hidden behind
+an #ifdef if their implementation is not in git-std-lib.a.
+
+=== Rationale summary
+
+The Git Standard Library allows us to get the libification ball rolling
+with other libraries in Git. By not spending many more months attempting
+to refactor difficult circular dependencies and instead spending that
+time getting to a state where we can test out swapping a library out
+such as config or object store, we can prove the viability of Git
+libification on a much faster time scale. Additionally the code cleanups
+that have happened so far have been minor and beneficial for the
+codebase. It is probable that making large movements would negatively
+affect code clarity.
+
+== Git Standard Library boundary
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
+versions of those files are implemented and swapped in during compilation time
+(see STUB_LIB_OBJS in the Makefile).
+
+== Files inside of Git Standard Library
+
+The set of files in git-std-lib.a can be found in STD_LIB_OBJS and COMPAT_OBJS
+in the Makefile.
+
+When these files are compiled together with the files in STUB_LIB_OBJS (or
+user-provided files that provide the same functions), they form a complete
+library.
+
+== Pitfalls
+
+There are a small amount of files under compat/* that have dependencies
+not inside of git-std-lib.a. While those functions are not called on
+Linux, other OSes might call those problematic functions. I don't see
+this as a major problem, just moreso an observation that libification in
+general may also require some minor compatibility work in the future.
+
+== Testing
+
+Unit tests should catch any breakages caused by changes to files in
+git-std-lib.a (i.e. introduction of a out of scope dependency) and new
+functions introduced to git-std-lib.a will require unit tests written
+for them.
+
+[1] https://lore.kernel.org/git/xmqqwn17sydw.fsf@gitster.g/
diff --git a/Makefile b/Makefile
index 4e255c81f2..d37ea9d34b 100644
--- a/Makefile
+++ b/Makefile
@@ -669,6 +669,8 @@ FUZZ_PROGRAMS =
 GIT_OBJS =
 LIB_OBJS =
 SCALAR_OBJS =
+STD_LIB_OBJS =
+STUB_LIB_OBJS =
 OBJECTS =
 OTHER_PROGRAMS =
 PROGRAM_OBJS =
@@ -923,6 +925,8 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
+STD_LIB_FILE = git-std-lib.a
+STUB_LIB_FILE = git-stub-lib.a
 REFTABLE_LIB = reftable/libreftable.a
 REFTABLE_TEST_LIB = reftable/libreftable_test.a
 
@@ -962,7 +966,6 @@ COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 
-LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
 LIB_OBJS += add-patch.o
 LIB_OBJS += advice.o
@@ -1004,8 +1007,6 @@ LIB_OBJS += convert.o
 LIB_OBJS += copy.o
 LIB_OBJS += credential.o
 LIB_OBJS += csum-file.o
-LIB_OBJS += ctype.o
-LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += delta-islands.o
 LIB_OBJS += diagnose.o
@@ -1046,7 +1047,6 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
-LIB_OBJS += hex-ll.o
 LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
@@ -1097,7 +1097,6 @@ LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
 LIB_OBJS += parallel-checkout.o
-LIB_OBJS += parse.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
@@ -1152,7 +1151,6 @@ LIB_OBJS += sparse-index.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += statinfo.o
-LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += strmap.o
@@ -1189,21 +1187,32 @@ LIB_OBJS += unpack-trees.o
 LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
 LIB_OBJS += urlmatch.o
-LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
-LIB_OBJS += utf8.o
 LIB_OBJS += varint.o
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
 LIB_OBJS += worktree.o
-LIB_OBJS += wrapper.o
 LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 
+STD_LIB_OBJS += abspath.o
+STD_LIB_OBJS += ctype.o
+STD_LIB_OBJS += date.o
+STD_LIB_OBJS += hex-ll.o
+STD_LIB_OBJS += parse.o
+STD_LIB_OBJS += strbuf.o
+STD_LIB_OBJS += usage.o
+STD_LIB_OBJS += utf8.o
+STD_LIB_OBJS += wrapper.o
+
+STUB_LIB_OBJS += stubs/trace2.o
+STUB_LIB_OBJS += stubs/pager.o
+STUB_LIB_OBJS += stubs/misc.o
+
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
@@ -1352,7 +1361,7 @@ UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = common-main.o $(STD_LIB_FILE) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2693,6 +2702,8 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += $(STD_LIB_OBJS)
+OBJECTS += $(STUB_LIB_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3686,7 +3697,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB) $(STD_LIB_FILE) $(STUB_LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3878,3 +3889,18 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/
 build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS)
 	$(MAKE) -C t/ unit-tests
+
+### Libified Git rules
+
+# git-std-lib.a
+# Programs other than git should compile this with
+#     make NO_GETTEXT=YesPlease git-std-lib.a
+# and link against git-stub-lib.a (if the default no-op functionality is fine)
+# or a custom .a file with the same interface as git-stub-lib.a (if custom
+# functionality is needed) as well.
+$(STD_LIB_FILE): $(STD_LIB_OBJS) $(COMPAT_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
+# git-stub-lib.a
+$(STUB_LIB_FILE): $(STUB_LIB_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
diff --git a/stubs/misc.c b/stubs/misc.c
new file mode 100644
index 0000000000..92da76fd46
--- /dev/null
+++ b/stubs/misc.c
@@ -0,0 +1,33 @@
+#include <assert.h>
+#include <stdlib.h>
+
+#ifndef NO_GETTEXT
+/*
+ * NEEDSWORK: This is enough to link our unit tests against
+ * git-std-lib.a built with gettext support. We don't really support
+ * programs other than git using git-std-lib.a with gettext support
+ * yet. To do that we need to start using dgettext() rather than
+ * gettext() in our code.
+ */
+int git_gettext_enabled = 0;
+#endif
+
+int common_exit(const char *file, int line, int code);
+
+int common_exit(const char *file, int line, int code)
+{
+	exit(code);
+}
+
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
+int lstat_cache_aware_rmdir(const char *path);
+
+int lstat_cache_aware_rmdir(const char *path)
+{
+	/*
+	 * This function should not be called by programs linked
+	 * against git-stub-lib.a
+	 */
+	assert(0);
+}
+#endif
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
-- 
2.44.0.rc0.258.g7320e95886-goog

