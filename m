Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657182047F
	for <e@80x24.org>; Sat, 30 Sep 2017 13:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbdI3M76 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 08:59:58 -0400
Received: from avasout07.plus.net ([84.93.230.235]:53052 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdI3M74 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 08:59:56 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id Fozt1w0020M91Ur01ozuWB; Sat, 30 Sep 2017 13:59:54 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=dIu3SnmMAAAA:8 a=5rxgeBVgAAAA:8
 a=ecQrQ98wvdTfWjWBv40A:9 a=QEXdDO2ut3YA:10 a=Ua9G7VpiFza3u12uuhVB:22
 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
 <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
Date:   Sat, 30 Sep 2017 13:59:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/09/17 07:49, Pranit Bauva wrote:
> `--next-all` is meant to be used as a subcommand to support multiple
> "operation mode" though the current implementation does not contain any
> other subcommand along side with `--next-all` but further commits will
> include some more subcommands.
> 
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> 
> ---
> Hey,
> 
> It has been a long time since this series appeared on the mailing list.
> The previous version v15[1] is now split into many parts and I am
> sending the first part right now, will focus on getting this merged and
> then send out the next part.
> 
> The changes in this part:
>  * Stephan pointed out that "terms" was missing in patch 2 ie.
>    "bisect--helper: rewrite `check_term_format` shell function in C"
> 
> [1]:
> https://public-inbox.org/git/CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com/

Hi Pranit,

Just before Junio dropped your 'pb/bisect' branch from his
repository (and What's cooking), I fetched it locally with
the intention of finishing it off. (It would have been silly
to waste all your good work).

Although I have rebased your branch a few times, and added
a few commits while 'reading' the code, I haven't actually
added much to your branch (only 12 commits and I had meant
to squash some of those together)!

However, there were some bug fixes in there, so you may want
to take a look at:

    git://repo.or.cz/git/raj.git branch 'bisect'

[the 'pb-bisect' branch was the original branch from Junio,
including the 'SQUASH' commit that I squashed!]

These patches seem to relate to patches 1-5 & 8 of the original
series. The diff between these patches and the first 6 patches
of my bisect branch is given below. Note that most of the diff
seems to be caused by swapping patch #6 for #8, but not all of
the hunks are caused by this.

Note that I moved some code between patches (e.g. some of the
GIT_PATH_FUNC()s moved out of patch #4, because they were not
used in that patch. Ah, is that why you moved patch #8 up?).
[Also I added the 'bisect clean' message to delet_refs() to
patch #4 as well.]

Look for []-ed comments in the commit messages for a note of
the changes I made to your original patches, in patches #2,
#4, #7-9, #11-12 and #14.

The commits I added, which are just WIP, are as follows:

  $ git log --oneline bisect~12..bisect
  7d7117040 (raj/bisect, bisect) bisect--helper: convert to struct object_id
  188ea5855 bisect--helper: add the get_bad_commit() function
  b75f46fb4 bisect--helper: add a log_commit() helper function
  4afc34403 bisect--helper: reduce the scope of a variable
  62495f6ae bisect--helper: remove useless sub-expression in condition
  964f4e2b0 bisect--helper: set correct term from --term-new= option
  62efc099f bisect--helper: remove redundant assignment to has_double_dash
  d35950b92 bisect--helper: remove redundant goto's
  b33f313ac bisect--helper: remove space just before \n in string
  3eb407156 bisect--helper: remove some unnecessary braces
  c2b89c9b8 bisect--helper: add some vertical whitespace
  8c883701c bisect--helper: fix up some coding style issues
  $ 

Again IIRC, there are a couple of bug fixes in these commits ...

I have to go now, so I will leave it with you. ;-)

Hope that helps.

ATB,
Ramsay Jones


-- >8 --
diff --git a/bisect.c b/bisect.c
index 2838d672d..b19311ca7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1066,7 +1066,7 @@ int bisect_clean_state(void)
 	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
 	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
-	result = delete_refs("bisect: remove", &refs_for_removal, REF_NODEREF);
+	result = delete_refs("bisect: clean", &refs_for_removal, REF_NODEREF);
 	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_expected_rev());
diff --git a/builtin/am.c b/builtin/am.c
index c973bd96d..aa66f9915 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -32,22 +32,6 @@
 #include "apply.h"
 #include "string-list.h"
 
-/**
- * Returns 1 if the file is empty or does not exist, 0 otherwise.
- */
-static int is_empty_file(const char *filename)
-{
-	struct stat st;
-
-	if (stat(filename, &st) < 0) {
-		if (errno == ENOENT)
-			return 1;
-		die_errno(_("could not stat %s"), filename);
-	}
-
-	return !st.st_size;
-}
-
 /**
  * Returns the length of the first line of msg.
  */
@@ -1300,7 +1284,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_file(am_path(state, "patch"))) {
+	if (is_empty_or_missing_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty."));
 		die_user_resolve(state);
 	}
@@ -1883,7 +1867,7 @@ static void am_run(struct am_state *state, int resume)
 		resume = 0;
 	}
 
-	if (!is_empty_file(am_path(state, "rewritten"))) {
+	if (!is_empty_or_missing_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
 		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 35d2105f9..2af024f60 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -5,8 +5,6 @@
 #include "refs.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
-static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
-static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
@@ -45,8 +43,8 @@ static int check_term_format(const char *term, const char *orig_term)
 	if (res)
 		return error(_("'%s' is not a valid term"), term);
 
-	if (one_of(term, "help", "start", "skip", "next", "reset",
-			"visualize", "replay", "log", "run", "terms", NULL))
+	if (one_of(term, "help", "start", "terms", "skip", "next", "reset",
+			"visualize", "replay", "log", "run", NULL))
 		return error(_("can't use the builtin command '%s' as a term"), term);
 
 	/*
@@ -82,37 +80,12 @@ static int write_terms(const char *bad, const char *good)
 	return (res < 0) ? -1 : 0;
 }
 
-static int is_expected_rev(const char *expected_hex)
-{
-	struct strbuf actual_hex = STRBUF_INIT;
-	int res = 0;
-	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
-		strbuf_trim(&actual_hex);
-		res = !strcmp(actual_hex.buf, expected_hex);
-	}
-	strbuf_release(&actual_hex);
-	return res;
-}
-
-static void check_expected_revs(const char **revs, int rev_nr)
-{
-	int i;
-
-	for (i = 0; i < rev_nr; i++) {
-		if (!is_expected_rev(revs[i])) {
-			unlink_or_warn(git_path_bisect_ancestors_ok());
-			unlink_or_warn(git_path_bisect_expected_rev());
-		}
-	}
-}
-
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
-		CHECK_EXPECTED_REVS
+		BISECT_CLEAN_STATE
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -122,8 +95,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -140,17 +111,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		return bisect_next_all(prefix, no_checkout);
 	case WRITE_TERMS:
 		if (argc != 2)
-			return error(_("--write-terms requires two arguments"));
+			die(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
 	case BISECT_CLEAN_STATE:
 		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
+			die(_("--bisect-clean-state requires no arguments"));
 		return bisect_clean_state();
-	case CHECK_EXPECTED_REVS:
-		check_expected_revs(argv, argc);
-		return 0;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 71fe09264..7a1901893 100644
--- a/cache.h
+++ b/cache.h
@@ -2029,4 +2029,7 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+extern int is_empty_or_missing_file(const char *filename);
+
 #endif /* CACHE_H */
diff --git a/git-bisect.sh b/git-bisect.sh
index 0138a8860..f1202dfb4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -209,7 +209,7 @@ bisect_start() {
 	eval "$eval true" &&
 	if test $must_write_terms -eq 1
 	then
-		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
+		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -237,6 +237,22 @@ bisect_write() {
 	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
+is_expected_rev() {
+	test -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")
+}
+
+check_expected_revs() {
+	for _rev in "$@"; do
+		if ! is_expected_rev "$_rev"
+		then
+			rm -f "$GIT_DIR/BISECT_ANCESTORS_OK"
+			rm -f "$GIT_DIR/BISECT_EXPECTED_REV"
+			return
+		fi
+	done
+}
+
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -264,7 +280,7 @@ bisect_state() {
 		rev=$(git rev-parse --verify "$bisected_head") ||
 			die "$(eval_gettext "Bad rev input: \$bisected_head")"
 		bisect_write "$state" "$rev"
-		git bisect--helper --check-expected-revs "$rev" ;;
+		check_expected_revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
 		hash_list=''
@@ -278,7 +294,7 @@ bisect_state() {
 		do
 			bisect_write "$state" "$rev"
 		done
-		git bisect--helper --check-expected-revs $hash_list ;;
+		check_expected_revs $hash_list ;;
 	*,"$TERM_BAD")
 		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argument.")" ;;
 	*)
diff --git a/wrapper.c b/wrapper.c
index 36630e5d1..975ca2f1b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -690,3 +690,16 @@ int xgethostname(char *buf, size_t len)
 		buf[len - 1] = 0;
 	return ret;
 }
+
+int is_empty_or_missing_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return !st.st_size;
+}
