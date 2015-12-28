From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: [PATCH/RFC v2 1/2] describe: add option to use perl-compatible regexes with --match
Date: Mon, 28 Dec 2015 11:30:23 +0100
Message-ID: <980902959f83a7f82e6f5eb38f4c3a8bf074c77a.1451298323.git.mostynb@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
Cc: Mostyn Bramley-Moore <mostynb@opera.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 11:31:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDV4x-0000fV-N4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 11:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbbL1Ka6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 05:30:58 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38065 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbbL1Kay (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 05:30:54 -0500
Received: by mail-wm0-f53.google.com with SMTP id l126so264173148wml.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 02:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aOfV9z2wc3N5iN1/hdkkayELtNXDrNmhZLzzMsMBAHs=;
        b=fdjwT9dpkBFTMUKvegntFbbNFPMR7dDog2o9AZc3S0BudkFdtSLqx5Ih732wp6jccS
         fQ8xWdggML6teIO5VAriOPMXvK3sDEeJxdcXfrus5AkrNA6KrnFmpJTmFO9kLC3xp9yq
         FKTiExW/MvetBDPFPTuJh7DiWEvACeVRrQ0kxsAx0gIYPCUFhudUvTZxAkhLttmXSsN9
         zd8nWH7Cr2PmcF2LRd0VKVnBR/AiKjGtV8PZ3tCzkqbrMF2KRxMau2HDnT/ebE6XSNfi
         fcMO+8par6GNZvQKqpTXXma9u4hm2giiHmCXPAI83XMsX5zDTCWzoZSVrQfQKYj3hbij
         YfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aOfV9z2wc3N5iN1/hdkkayELtNXDrNmhZLzzMsMBAHs=;
        b=QL8QP1neSeb7yn9Jes3PmbFTM6LqAWta3irFU3Wldluv2XxilcwZBQAOmTMCVkuQNe
         O8f+6ABefD2wAfi0elxSeHie7W10NvAj8QtCY6B3fKbPvcbtbRP89ChQmJTuZScE0M6z
         T4B8lBabwxL7ckwjuhLZzqgvMac+yNkBz2RSeA/TJLPAmxaB8xW3W13XmZVsnB0X6CeL
         5A6R+O39nd/T0nEizJDj8JHnp/tWr/1vP3VuY4MRcMItmFBOIG6iyYU0E521h39amapT
         T19VZ4kaA+gwxM4IUUSyhWJzKhyucq6+O+wwJJLgIbghH63mqC+BIujV4frhY4hYieRs
         WsRQ==
X-Gm-Message-State: ALoCoQkG2cMKwfuj5LEvve1zL+TtC+g4CuIQNvPPVgy6wslg+dGl+gtqyCvs/s1YTIewdmLzEXKg+MgDv9b3NMy9oEW8/wyqyg==
X-Received: by 10.28.156.198 with SMTP id f189mr24411665wme.25.1451298653489;
        Mon, 28 Dec 2015 02:30:53 -0800 (PST)
Received: from teardrop.oslo.osa (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id uw6sm56248541wjc.42.2015.12.28.02.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 02:30:52 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1451298323.git.mostynb@opera.com>
In-Reply-To: <cover.1451298323.git.mostynb@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283034>

This allows more flexible pattern matching than the default globs.

Signed-off-by: Mostyn Bramley-Moore <mostynb@opera.com>
---
 Documentation/git-describe.txt | 15 +++++--
 builtin/describe.c             | 90 +++++++++++++++++++++++++++++++++++++++++-
 t/README                       |  3 +-
 t/t6120-describe.sh            | 24 +++++++++--
 4 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c8f28c8..b8279ec 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -81,9 +81,18 @@ OPTIONS
 	that points at object deadbee....).
 
 --match <pattern>::
-	Only consider tags matching the given `glob(7)` pattern,
-	excluding the "refs/tags/" prefix.  This can be used to avoid
-	leaking private tags from the repository.
+	Only consider tags matching the given pattern, excluding the
+	"refs/tags/" prefix.  This can be used to avoid leaking private
+	tags from the repository. The pattern type can be chosen by
+	specifying --glob or --perl-regexp.
+
+--glob::
+	Use `glob(7)` patterns with --match, this is the default.
+
+-P::
+--perl-regexp::
+	Use Perl-compatible regexp for patterns with --match. Requires
+	libpcre to be compiled in.
 
 --always::
 	Show uniquely abbreviated commit object as fallback.
diff --git a/builtin/describe.c b/builtin/describe.c
index 8a25abe..d9ab5bd 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -10,6 +10,10 @@
 #include "hashmap.h"
 #include "argv-array.h"
 
+#ifdef USE_LIBPCRE
+#include <pcre.h>
+#endif
+
 #define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
@@ -19,6 +23,11 @@ static const char * const describe_usage[] = {
 	NULL
 };
 
+enum match_type {
+	MATCH_GLOB = 0,
+	MATCH_PCRE
+};
+
 static int debug;	/* Display lots of verbose info */
 static int all;	/* Any valid ref can be used */
 static int tags;	/* Allow lightweight tags */
@@ -31,6 +40,12 @@ static int have_util;
 static const char *pattern;
 static int always;
 static const char *dirty;
+static enum match_type pattern_type_arg = MATCH_GLOB;
+
+#ifdef USE_LIBPCRE
+static pcre *pcre_regex = NULL;
+static pcre_extra *extra = NULL;
+#endif
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -119,6 +134,61 @@ static void add_to_known_names(const char *path,
 	}
 }
 
+#ifdef USE_LIBPCRE
+static void pcre_init()
+{
+	const char *error = NULL;
+	int erroffset = -1;
+	int opts = PCRE_MULTILINE;
+
+	pcre_regex = pcre_compile(pattern, opts, &error, &erroffset, NULL);
+	if (!pcre_regex)
+		die("invalid PCRE at position %d of \'%s\': %s",
+			erroffset, pattern, error);
+
+	extra = pcre_study(pcre_regex, 0, &error);
+	if (!extra && error)
+		die("%s", error);
+}
+
+static void pcre_cleanup()
+{
+	pcre_free(pcre_regex);
+	pcre_regex = NULL;
+	pcre_free(extra);
+	extra = NULL;
+}
+
+/* return 1 on match, 0 on no match. */
+static int pcre_match(const char *text)
+{
+	int ovector[3], flags = 0;
+	int ret = pcre_exec(pcre_regex, extra,
+	                    text, strlen(text), 0,
+	                    flags, ovector, ARRAY_SIZE(ovector));
+	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
+		die("pcre_exec failed with error code %d", ret);
+	else if (ret > 0)
+		return 0; /* no match */
+	else
+		return 1; /* match */
+}
+#endif
+
+/* Return 1 on match, 0 on no match. */
+static int match(const char *pattern, const char *text, enum match_type t)
+{
+	if (t == MATCH_GLOB) {
+		return wildmatch(pattern, text, 0, NULL);
+#ifdef USE_LIBPCRE
+	} else if (t == MATCH_PCRE) {
+		return pcre_match(text);
+#endif
+	}
+
+	assert(0); /* None of the alternatives above were used. */
+}
+
 static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	int is_tag = starts_with(path, "refs/tags/");
@@ -130,7 +200,7 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 		return 0;
 
 	/* Accept only tags that match the pattern, if given */
-	if (pattern && (!is_tag || wildmatch(pattern, path + 10, 0, NULL)))
+	if (pattern && (!is_tag || match(pattern, path + 10, pattern_type_arg)))
 		return 0;
 
 	/* Is it annotated? */
@@ -406,6 +476,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING(0, "match",       &pattern, N_("pattern"),
 			   N_("only consider tags matching <pattern>")),
+		OPT_SET_INT(0, "glob", &pattern_type_arg,
+			   N_("use glob patterns with --match (default)"),
+			   MATCH_GLOB),
+#ifdef USE_LIBPCRE
+		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
+			   N_("use Perl-compatible regular expressions with --match"),
+			   MATCH_PCRE),
+#endif
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
@@ -429,6 +507,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
 
+#ifdef USE_LIBPCRE
+	if (pattern && pattern_type_arg == MATCH_PCRE)
+		pcre_init();
+#endif
+
 	if (contains) {
 		struct argv_array args;
 
@@ -455,6 +538,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
 
+#ifdef USE_LIBPCRE
+	if (pattern && pattern_type_arg == MATCH_PCRE)
+		pcre_cleanup();
+#endif
+
 	if (argc == 0) {
 		if (dirty) {
 			static struct lock_file index_lock;
diff --git a/t/README b/t/README
index 1dc908e..207257e 100644
--- a/t/README
+++ b/t/README
@@ -798,7 +798,8 @@ use these, and "test_set_prereq" for how to define your own.
  - LIBPCRE
 
    Git was compiled with USE_LIBPCRE=YesPlease. Wrap any tests
-   that use git-grep --perl-regexp or git-grep -P in these.
+   that use the --perl-regexp or -P flags to git-grep or
+   git-describe in these.
 
  - CASE_INSENSITIVE_FS
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 85f2694..47427c4 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -12,13 +12,14 @@ test_description='test describe
 '
 . ./test-lib.sh
 
-check_describe () {
-	expect="$1"
-	shift
+_check_describe () {
+	pcre="$1"
+	expect="$2"
+	shift 2
 	R=$(git describe "$@" 2>err.actual)
 	S=$?
 	cat err.actual >&3
-	test_expect_success "describe $*" '
+	test_expect_success $pcre "describe $*" '
 	test $S = 0 &&
 	case "$R" in
 	$expect)	echo happy ;;
@@ -28,6 +29,14 @@ check_describe () {
 	'
 }
 
+check_describe() {
+	_check_describe "" $*
+}
+
+check_describe_pcre() {
+	_check_describe LIBPCRE $*
+}
+
 test_expect_success setup '
 
 	test_tick &&
@@ -175,12 +184,19 @@ test_expect_success 'set-up matching pattern tests' '
 '
 
 check_describe "test-annotated-*" --match="test-*"
+check_describe_pcre "test-annotated-*" --match="^test-" --perl-regexp
 
 check_describe "test1-lightweight-*" --tags --match="test1-*"
+check_describe_pcre "test1-lightweight-*" --tags --match="^test1-" \
+	--perl-regexp
 
 check_describe "test2-lightweight-*" --tags --match="test2-*"
+check_describe_pcre "test2-lightweight-*" --tags --match="^test2-" \
+	--perl-regexp
 
 check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
+check_describe_pcre "test2-lightweight-*" --long --tags --match="^test2-" \
+	--perl-regexp HEAD^
 
 test_expect_success 'name-rev with exact tags' '
 	echo A >expect &&
-- 
2.5.0
