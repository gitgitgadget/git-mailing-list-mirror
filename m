Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BEBEEB564
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbjIHRpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245456AbjIHRpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:45:07 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DB1FED
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:45:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-570a1c83727so2901706a12.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195099; x=1694799899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlgE9zKsjtvmJ/dHu1hhc8Vvyo66qzpPDcl+tF3/7QA=;
        b=PdX8kfdFYWiouHs2lUruSl1bsHMKZyrdMO9fvAJpIofEhMaABCzxu6mahZI0QzspyB
         N/aG4ue3pQjiq+FJX6VlfIGi+9zvkCKmdjlXEshUfL2KYATk5FtL3dKW56rA1zziBy48
         UkWJFjfDvtSFo19B3QiMe/zu85kwsCHV+zDRgr7PTBwaocCM1AKiB81oC+H6+BuHr1uo
         fkTrjUjvIAoRZlVOrzXBNy+tDzl6v+OG3dKidHoXHpdNrEcv/Ki9FfuADKOIkFB7m5VK
         8jOp5alDiZu0C/klz42bqV+3XKU1LobmKgZwemWCJbA80HYcllI+JObNIAD5fNW+PHkP
         fIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195099; x=1694799899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlgE9zKsjtvmJ/dHu1hhc8Vvyo66qzpPDcl+tF3/7QA=;
        b=YPToSM8AOW5T3mmG6+UYNSrf1vrSocMsKMW0xz+fnYjyWa/kKg8kvivSbl4j7Q9HhA
         cYBMefwEBIS+oJjWCU62bIE/GTI9jksKtOdMdWcISgt4z9VsbXInBJ0s+LD3c5Tfv+MR
         z7kqgFZuynL2kZtvoCzPqmyiFjhYRFzHVywsOGnm4BdoNrzYf1wIq7/Dhc1EijyShDBt
         e7AKF2gNVELfRxCUcPCcJlwCIOy2N1uQuhEAWtVFJ4FCdciknoIoYOKcxFb0tK56+cPu
         EQOHZshHyzW+ff5SMmFpvr+30rd3fZgMGQ6jkBomBkU3U2EOLm1W6LcCaDa+iG9vhV2p
         MkFA==
X-Gm-Message-State: AOJu0YwWdSp6Kv4G1L402ZF3Ezyb3uwGxLITy3zDtzuu02retWxteXAX
        ab2AkFPpNdelbicOXp/8QT6L0V1Qhvqni/owKtAk6vIBdK9DcFYq8y+aDysKoFzGYJ3DbfDVn8y
        AePDP0KchND3O58boPlHln5LsvR+WVhaNOBY7HEGQ6V8aa0DbjGBDNbGU6CPsGYWfvQ==
X-Google-Smtp-Source: AGHT+IEIBdewHdnBSHofrfsqsogsNLu2J+iiC/UG5dEy91PIn5tcQZujjXpkxzBe7VLxyWGW9mxGSwvEn/w8jfs=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a65:6ab5:0:b0:56b:b9b1:34e0 with SMTP id
 x21-20020a656ab5000000b0056bb9b134e0mr621367pgu.11.1694195099473; Fri, 08 Sep
 2023 10:44:59 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:44:43 +0000
In-Reply-To: <20230908174134.1026823-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230908174134.1026823-1-calvinwan@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908174443.1027716-6-calvinwan@google.com>
Subject: [PATCH v3 6/6] git-std-lib: add test file to call git-std-lib.a functions
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test file that directly or indirectly calls all functions defined in
git-std-lib.a object files to showcase that they do not reference
missing objects and that git-std-lib.a can stand on its own.

Certain functions that cause the program to exit or are already called
by other functions are commented out.

TODO: replace with unit tests
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/Makefile      |   4 +
 t/stdlib-test.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+)
 create mode 100644 t/stdlib-test.c

diff --git a/t/Makefile b/t/Makefile
index 3e00cdd801..b6d0bc9daa 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -150,3 +150,7 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint
+
+test-git-std-lib:
+	cc -It -o stdlib-test stdlib-test.c -L. -l:../git-std-lib.a
+	./stdlib-test
diff --git a/t/stdlib-test.c b/t/stdlib-test.c
new file mode 100644
index 0000000000..76fed9ecbf
--- /dev/null
+++ b/t/stdlib-test.c
@@ -0,0 +1,231 @@
+#include "../git-compat-util.h"
+#include "../abspath.h"
+#include "../hex-ll.h"
+#include "../parse.h"
+#include "../strbuf.h"
+#include "../string-list.h"
+
+/*
+ * Calls all functions from git-std-lib
+ * Some inline/trivial functions are skipped
+ */
+
+void abspath_funcs(void) {
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
+void hex_ll_funcs(void) {
+	unsigned char c;
+
+	fprintf(stderr, "calling hex-ll functions\n");
+
+	hexval('c');
+	hex2chr("A1");
+	hex_to_bytes(&c, "A1", 2);
+}
+
+void parse_funcs(void) {
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
+void strbuf_funcs(void) {
+	struct strbuf *sb = xmalloc(sizeof(void*));
+	struct strbuf *sb2 = xmalloc(sizeof(void*));
+	struct strbuf sb3 = STRBUF_INIT;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	char *buf = "foo";
+	int fd = open("/dev/null", O_RDONLY);
+
+	fprintf(stderr, "calling strbuf functions\n");
+
+	starts_with("foo", "bar");
+	istarts_with("foo", "bar");
+	// skip_to_optional_arg_default(const char *str, const char *prefix,
+	// 			 const char **arg, const char *def)
+	strbuf_init(sb, 0);
+	strbuf_init(sb2, 0);
+	strbuf_release(sb);
+	strbuf_attach(sb, strbuf_detach(sb, NULL), 0, 0); // calls strbuf_grow
+	strbuf_swap(sb, sb2);
+	strbuf_setlen(sb, 0);
+	strbuf_trim(sb); // calls strbuf_rtrim, strbuf_ltrim
+	// strbuf_rtrim() called by strbuf_trim()
+	// strbuf_ltrim() called by strbuf_trim()
+	strbuf_trim_trailing_dir_sep(sb);
+	strbuf_trim_trailing_newline(sb);
+	strbuf_reencode(sb, "foo", "bar");
+	strbuf_tolower(sb);
+	strbuf_add_separated_string_list(sb, " ", &list);
+	strbuf_list_free(strbuf_split_buf("foo bar", 8, ' ', -1));
+	strbuf_cmp(sb, sb2);
+	strbuf_addch(sb, 1);
+	strbuf_splice(sb, 0, 1, "foo", 3);
+	strbuf_insert(sb, 0, "foo", 3);
+	// strbuf_vinsertf() called by strbuf_insertf
+	strbuf_insertf(sb, 0, "%s", "foo");
+	strbuf_remove(sb, 0, 1);
+	strbuf_add(sb, "foo", 3);
+	strbuf_addbuf(sb, sb2);
+	strbuf_join_argv(sb, 0, NULL, ' ');
+	strbuf_addchars(sb, 1, 1);
+	strbuf_addf(sb, "%s", "foo");
+	strbuf_add_commented_lines(sb, "foo", 3, '#');
+	strbuf_commented_addf(sb, '#', "%s", "foo");
+	// strbuf_vaddf() called by strbuf_addf()
+	strbuf_addbuf_percentquote(sb, &sb3);
+	strbuf_add_percentencode(sb, "foo", STRBUF_ENCODE_SLASH);
+	strbuf_fread(sb, 0, stdin);
+	strbuf_read(sb, fd, 0);
+	strbuf_read_once(sb, fd, 0);
+	strbuf_write(sb, stderr);
+	strbuf_readlink(sb, "/dev/null", 0);
+	strbuf_getcwd(sb);
+	strbuf_getwholeline(sb, stderr, '\n');
+	strbuf_appendwholeline(sb, stderr, '\n');
+	strbuf_getline(sb, stderr);
+	strbuf_getline_lf(sb, stderr);
+	strbuf_getline_nul(sb, stderr);
+	strbuf_getwholeline_fd(sb, fd, '\n');
+	strbuf_read_file(sb, "/dev/null", 0);
+	strbuf_add_lines(sb, "foo", "bar", 0);
+	strbuf_addstr_xml_quoted(sb, "foo");
+	strbuf_addstr_urlencode(sb, "foo", allow_unencoded_fn);
+	strbuf_humanise_bytes(sb, 42);
+	strbuf_humanise_rate(sb, 42);
+	printf_ln("%s", sb);
+	fprintf_ln(stderr, "%s", sb);
+	xstrdup_tolower("foo");
+	xstrdup_toupper("foo");
+	// xstrvfmt() called by xstrfmt()
+	xstrfmt("%s", "foo");
+	// strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
+	// 	     int tz_offset, int suppress_tz_name)
+	// strbuf_stripspace(struct strbuf *sb, char comment_line_char)
+	// strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
+	// strbuf_strip_file_from_path(struct strbuf *sb)
+}
+
+static void error_builtin(const char *err, va_list params) {}
+static void warn_builtin(const char *err, va_list params) {}
+
+static report_fn error_routine = error_builtin;
+static report_fn warn_routine = warn_builtin;
+
+void usage_funcs(void) {
+	fprintf(stderr, "calling usage functions\n");
+	// Functions that call exit() are commented out
+
+	// usage()
+	// usagef()
+	// die()
+	// die_errno();
+	error("foo");
+	error_errno("foo");
+	die_message("foo");
+	die_message_errno("foo");
+	warning("foo");
+	warning_errno("foo");
+
+	// set_die_routine();
+	get_die_message_routine();
+	set_error_routine(error_builtin);
+	get_error_routine();
+	set_warn_routine(warn_builtin);
+	get_warn_routine();
+	// set_die_is_recursing_routine();
+}
+
+void wrapper_funcs(void) {
+	void *ptr = xmalloc(1);
+	int fd = open("/dev/null", O_RDONLY);
+	struct strbuf sb = STRBUF_INIT;
+	int mode = 0444;
+	char host[PATH_MAX], path[PATH_MAX], path1[PATH_MAX];
+	xsnprintf(path, sizeof(path), "out-XXXXXX");
+	xsnprintf(path1, sizeof(path1), "out-XXXXXX");
+	int tmp;
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
+	// xsnprintf() called above
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
+int main() {
+	abspath_funcs();
+	hex_ll_funcs();
+	parse_funcs();
+	strbuf_funcs();
+	usage_funcs();
+	wrapper_funcs();
+	fprintf(stderr, "all git-std-lib functions finished calling\n");
+	return 0;
+}
-- 
2.42.0.283.g2d96d420d3-goog

