Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA311586C8
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624263; cv=none; b=Yz2eVkLYxA4qJK2aKup4NY25If/TgZSo7rnjTvnkwEdYQXnDXe5ncLE+XZ84wCLxwD/j0b5srqb4hzkiVecKXmtbTBkxNUj3jAudwHKs8J5Sw6paj3zJdAd9kSEXJD1HXbs0F9bdSovlhy+0yPm373oH9snnUlSVnYncFkghh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624263; c=relaxed/simple;
	bh=04dq8/Aa0gzT2rFNq5nPdY64/2aFPl0R4rbXRuJVpkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tC5Ng04xqjc1aCRnbkSkz0gBTFf0H6ZJ0ne10MgvfwLQLhhnkLsfhNhR+ViK8d7ZYjYO2Z9bMor17lXDD1hgSukhD5rr70So8w/moic77OQOLOt04bSXo09KT3Gr+z0iyay+d+FBzl2Ubfts/g7DfDxchYCvlUFAhx+25y6bkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LQf4Qcc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LQf4Qcc"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608852fc324so36231677b3.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708624260; x=1709229060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqbeBBLJfu+yQOebvWXcKsAS4nA6/imikXTYExMSSf4=;
        b=1LQf4QcccKZoIY14kUHc/vVBYpZcjMy4JbVStuQlsW4FWPt2DTJy9riClmVMlr+KCc
         R4cggmY3OisHixFxaVDowZJTE2x93bx8mQQoaRTl2PQ50Ltz/u/m2UgFecdZCsVPeIMU
         6Et938rulahKPtVjXbmZo74EiadxX4Snx1r7D9QPqfmCb2oy+jT+YxBEFwmYMdJXuC+K
         kNiKDZsbAryT9wXLIYlMt9jYKEy44gJMvSTAPQDH6v88m0v6HRxIRt9A9b1j2xrQW710
         sNx6etKmujyvxQs5m5NJ84POrsRCMd9jPsfIl6Qa8adj8rmWa7GFHllinRuX/nWNOvsr
         PwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624260; x=1709229060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqbeBBLJfu+yQOebvWXcKsAS4nA6/imikXTYExMSSf4=;
        b=w39a+ipqmLr/WF3QyHPQq8pa+r/z0+deGeqyfwyycEXOSHpGI+Tdd9JqML1y7e71W3
         +Sy5fyZ5v9iyu8zDF7HRmBe/MehlHwCAsLYLz2mImdG0FZwYp8hFrZDhEzJ4gPbBUCWC
         GqKtarI3n4G1W/XWi9ORwJREbU1f01Th7ikGEngH1f0vHWRerJy+SkbK8szttPzSNogo
         sSJy1sfMLurzPRCPv+dyxyNTihauN6WFUcO6Z43ADbP6sq21M0E0kNtK2nJJv0jMYLbg
         7jYC1V/+jhxVmwDzMcCuJIOFKGO/0Itl3fnzFo8KAJSceY64PqtjaNviZeH6ne3aKl1R
         Zinw==
X-Gm-Message-State: AOJu0Yyyx8TEAH7lQCtSAfM5Odu4ulnTiVp//Mz2F0o7MAtl16J27ukm
	TEcftOmSuk0Ed1e+eL7Qqvtm3rHVooBw3ZmXOF7ws1K4KZnS0jEJ2nLtg2BmMuK2gmr7/H65igB
	UmD91U7NlXiJhTQ7LGtwWoBuCtpxr/p4jz/xbp1FByQkwVttmaNysadqOvIahyPT6g9SBMK1iA+
	mRvWbdr81tyw3N0709E8duyEkGxQ5haZe51nOk8FUJCcwG
X-Google-Smtp-Source: AGHT+IEbiujIzpyc8GbKzgLvZVXCpu9/zxrTKUrgF3Skt3Z3gDpfwQad/65JvWpJppw9vmX4UNhpY6mqkJdcFmM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:1204:b0:dc6:d678:371d with SMTP
 id s4-20020a056902120400b00dc6d678371dmr796007ybu.3.1708624260402; Thu, 22
 Feb 2024 09:51:00 -0800 (PST)
Date: Thu, 22 Feb 2024 17:50:33 +0000
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222175033.1489723-4-calvinwan@google.com>
Subject: [PATCH v5 3/3] test-stdlib: show that git-std-lib is independent
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, 
	phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Add a test file that calls some functions defined in git-std-lib.a
object files to showcase that they do not reference missing objects and
that, together with git-stub-lib.a, git-std-lib.a can stand on its own.

As described in test-stdlib.c, this can probably be removed once we have
unit tests.

The variable TEST_PROGRAMS is moved lower in the Makefile after
NO_POSIX_GOODIES is defined in config.make.uname. TEST_PROGRAMS isn't
used earlier than that so this change should be safe.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile               |  23 +++-
 strbuf.h               |   2 +
 stubs/misc.c           |   1 +
 t/helper/.gitignore    |   1 +
 t/helper/test-stdlib.c | 266 +++++++++++++++++++++++++++++++++++++++++
 t/t0082-std-lib.sh     |  11 ++
 6 files changed, 299 insertions(+), 5 deletions(-)
 create mode 100644 t/helper/test-stdlib.c
 create mode 100755 t/t0082-std-lib.sh

diff --git a/Makefile b/Makefile
index d37ea9d34b..1d762ce13a 100644
--- a/Makefile
+++ b/Makefile
@@ -870,9 +870,7 @@ TEST_BUILTINS_OBJS += test-xml-encode.o
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
 TEST_PROGRAMS_NEED_X += test-fake-ssh
-TEST_PROGRAMS_NEED_X += test-tool
-
-TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS_NEED_X += $(info tpnxnpg=$(NO_POSIX_GOODIES))test-tool
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
@@ -2678,6 +2676,16 @@ REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
+ifndef NO_POSIX_GOODIES
+TEST_PROGRAMS_NEED_X += test-stdlib
+MY_VAR = not_else
+$(info insideifndefnpg=$(NO_POSIX_GOODIES))
+else
+MY_VAR = else
+endif
+
+TEST_PROGRAMS = $(info tptpnx=$(TEST_PROGRAMS_NEED_X) myvar=$(MY_VAR))$(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
+
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 .PHONY: test-objs
@@ -3204,7 +3212,11 @@ GIT-PYTHON-VARS: FORCE
             fi
 endif
 
-test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+test_bindir_programs := $(info tbptpnx=$(TEST_PROGRAMS_NEED_X))$(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+
+t/helper/test-stdlib$X: t/helper/test-stdlib.o GIT-LDFLAGS $(STD_LIB_FILE) $(STUB_LIB_FILE) $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$< $(STD_LIB_FILE) $(STUB_LIB_FILE) $(EXTLIBS)
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
 
@@ -3635,7 +3647,8 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
 OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll t/unit-tests/bin/*.dll)
 endif
 
-artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
+# Added an info for debugging
+artifacts-tar:: $(info npg=$(NO_POSIX_GOODIES) cc=$(COMPAT_CFLAGS) tp=$(TEST_PROGRAMS))$(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
 		$(UNIT_TEST_PROGS) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
diff --git a/strbuf.h b/strbuf.h
index e959caca87..f775416307 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+#include "git-compat-util.h"
+
 /*
  * NOTE FOR STRBUF DEVELOPERS
  *
diff --git a/stubs/misc.c b/stubs/misc.c
index 92da76fd46..8d80581e39 100644
--- a/stubs/misc.c
+++ b/stubs/misc.c
@@ -9,6 +9,7 @@
  * yet. To do that we need to start using dgettext() rather than
  * gettext() in our code.
  */
+#include "gettext.h"
 int git_gettext_enabled = 0;
 #endif
 
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 8c2ddcce95..5cec3b357f 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,2 +1,3 @@
 /test-tool
 /test-fake-ssh
+/test-stdlib
diff --git a/t/helper/test-stdlib.c b/t/helper/test-stdlib.c
new file mode 100644
index 0000000000..460b472fb4
--- /dev/null
+++ b/t/helper/test-stdlib.c
@@ -0,0 +1,266 @@
+#include "git-compat-util.h"
+#include "abspath.h"
+#include "hex-ll.h"
+#include "parse.h"
+#include "strbuf.h"
+#include "string-list.h"
+
+/*
+ * Calls all functions from git-std-lib
+ * Some inline/trivial functions are skipped
+ *
+ * NEEDSWORK: The purpose of this file is to show that an executable can be
+ * built with git-std-lib.a and git-stub-lib.a, and then executed. If there
+ * is another executable that demonstrates this (for example, a unit test that
+ * takes the form of an executable compiled with git-std-lib.a and git-stub-
+ * lib.a), this file can be removed.
+ */
+
+static void abspath_funcs(void) {
+	struct strbuf sb = STRBUF_INIT;
+
+	fprintf(stderr, "calling abspath functions\n");
+	is_directory("foo");
+	strbuf_realpath(&sb, "foo", 0);
+	strbuf_realpath_forgiving(&sb, "foo", 0);
+	real_pathdup("foo", 0);
+	absolute_path("foo");
+	absolute_pathdup("foo");
+	prefix_filename("foo/", "bar");
+	prefix_filename_except_for_dash("foo/", "bar");
+	is_absolute_path("foo");
+	strbuf_add_absolute_path(&sb, "foo");
+	strbuf_add_real_path(&sb, "foo");
+}
+
+static void hex_ll_funcs(void) {
+	unsigned char c;
+
+	fprintf(stderr, "calling hex-ll functions\n");
+
+	hexval('c');
+	hex2chr("A1");
+	hex_to_bytes(&c, "A1", 1);
+}
+
+static void parse_funcs(void) {
+	intmax_t foo;
+	ssize_t foo1 = -1;
+	unsigned long foo2;
+	int foo3;
+	int64_t foo4;
+
+	fprintf(stderr, "calling parse functions\n");
+
+	git_parse_signed("42", &foo, maximum_signed_value_of_type(int));
+	git_parse_ssize_t("42", &foo1);
+	git_parse_ulong("42", &foo2);
+	git_parse_int("42", &foo3);
+	git_parse_int64("42", &foo4);
+	git_parse_maybe_bool("foo");
+	git_parse_maybe_bool_text("foo");
+	git_env_bool("foo", 1);
+	git_env_ulong("foo", 1);
+}
+
+static int allow_unencoded_fn(char ch) {
+	return 0;
+}
+
+static void strbuf_funcs(void) {
+	struct strbuf *sb = xmalloc(sizeof(*sb));
+	struct strbuf *sb2 = xmalloc(sizeof(*sb2));
+	struct strbuf sb3 = STRBUF_INIT;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int fd = open("/dev/null", O_RDONLY);
+
+	fprintf(stderr, "calling strbuf functions\n");
+
+	fprintf(stderr, "at line %d\n", __LINE__);
+	starts_with("foo", "bar");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	istarts_with("foo", "bar");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_init(sb, 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_init(sb2, 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_release(sb);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_attach(sb, strbuf_detach(sb, NULL), 0, 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_swap(sb, sb2);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_setlen(sb, 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_trim(sb);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_trim_trailing_dir_sep(sb);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_trim_trailing_newline(sb);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_reencode(sb, "foo", "bar");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_tolower(sb);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_add_separated_string_list(sb, " ", &list);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_list_free(strbuf_split_buf("foo bar", 8, ' ', -1));
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_cmp(sb, sb2);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_addch(sb, 1);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_splice(sb, 0, 1, "foo", 3);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_insert(sb, 0, "foo", 3);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_insertf(sb, 0, "%s", "foo");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_remove(sb, 0, 1);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_add(sb, "foo", 3);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_addbuf(sb, sb2);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_join_argv(sb, 0, NULL, ' ');
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_addchars(sb, 1, 1);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_addstr(sb, "foo");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_add_commented_lines(sb, "foo", 3, '#');
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_commented_addf(sb, '#', "%s", "foo");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_addbuf_percentquote(sb, &sb3);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_add_percentencode(sb, "foo", STRBUF_ENCODE_SLASH);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_fread(sb, 0, stdin);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_read(sb, fd, 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_read_once(sb, fd, 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_write(sb, stderr);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_readlink(sb, "/dev/null", 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_getcwd(sb);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_getwholeline(sb, stderr, '\n');
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_appendwholeline(sb, stderr, '\n');
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_getline(sb, stderr);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_getline_lf(sb, stderr);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_getline_nul(sb, stderr);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_getwholeline_fd(sb, fd, '\n');
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_read_file(sb, "/dev/null", 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_add_lines(sb, "foo", "bar", 0);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_addstr_xml_quoted(sb, "foo");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_addstr_urlencode(sb, "foo", allow_unencoded_fn);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_humanise_bytes(sb, 42);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	strbuf_humanise_rate(sb, 42);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	printf_ln("%s", sb->buf);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	fprintf_ln(stderr, "%s", sb->buf);
+	fprintf(stderr, "at line %d\n", __LINE__);
+	xstrdup_tolower("foo");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	xstrdup_toupper("foo");
+	fprintf(stderr, "at line %d\n", __LINE__);
+	xstrfmt("%s", "foo");
+	fprintf(stderr, "at line %d\n", __LINE__);
+}
+
+static void error_builtin(const char *err, va_list params) {}
+static void warn_builtin(const char *err, va_list params) {}
+
+static void usage_funcs(void) {
+	fprintf(stderr, "calling usage functions\n");
+	error("foo");
+	error_errno("foo");
+	die_message("foo");
+	die_message_errno("foo");
+	warning("foo");
+	warning_errno("foo");
+
+	get_die_message_routine();
+	set_error_routine(error_builtin);
+	get_error_routine();
+	set_warn_routine(warn_builtin);
+	get_warn_routine();
+}
+
+static void wrapper_funcs(void) {
+	int tmp;
+	void *ptr = xmalloc(1);
+	int fd = open("/dev/null", O_RDONLY);
+	struct strbuf sb = STRBUF_INIT;
+	int mode = 0444;
+	char host[PATH_MAX], path[PATH_MAX], path1[PATH_MAX];
+	xsnprintf(path, sizeof(path), "out-XXXXXX");
+	xsnprintf(path1, sizeof(path1), "out-XXXXXX");
+
+	fprintf(stderr, "calling wrapper functions\n");
+
+	xstrdup("foo");
+	xmalloc(1);
+	xmallocz(1);
+	xmallocz_gently(1);
+	xmemdupz("foo", 3);
+	xstrndup("foo", 3);
+	xrealloc(ptr, 2);
+	xcalloc(1, 1);
+	xsetenv("foo", "bar", 0);
+	xopen("/dev/null", O_RDONLY);
+	xread(fd, &sb, 1);
+	xwrite(fd, &sb, 1);
+	xpread(fd, &sb, 1, 0);
+	xdup(fd);
+	xfopen("/dev/null", "r");
+	xfdopen(fd, "r");
+	tmp = xmkstemp(path);
+	close(tmp);
+	unlink(path);
+	tmp = xmkstemp_mode(path1, mode);
+	close(tmp);
+	unlink(path1);
+	xgetcwd();
+	fopen_for_writing(path);
+	fopen_or_warn(path, "r");
+	xstrncmpz("foo", "bar", 3);
+	xgethostname(host, 3);
+	tmp = git_mkstemps_mode(path, 1, mode);
+	close(tmp);
+	unlink(path);
+	tmp = git_mkstemp_mode(path, mode);
+	close(tmp);
+	unlink(path);
+	read_in_full(fd, &sb, 1);
+	write_in_full(fd, &sb, 1);
+	pread_in_full(fd, &sb, 1, 0);
+}
+
+int main(int argc, const char **argv) {
+	abspath_funcs();
+	hex_ll_funcs();
+	parse_funcs();
+	strbuf_funcs();
+	usage_funcs();
+	wrapper_funcs();
+	fprintf(stderr, "all git-std-lib functions finished calling\n");
+	return 0;
+}
diff --git a/t/t0082-std-lib.sh b/t/t0082-std-lib.sh
new file mode 100755
index 0000000000..0d5a024deb
--- /dev/null
+++ b/t/t0082-std-lib.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+test_description='Test git-std-lib compilation'
+
+. ./test-lib.sh
+
+test_expect_success !WINDOWS 'stdlib-test compiles and runs' '
+	test-stdlib
+'
+
+test_done
-- 
2.44.0.rc0.258.g7320e95886-goog

