Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A7EC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C8B64E7A
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhBWVOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:14:09 -0500
Received: from [93.83.142.38] ([93.83.142.38]:58152 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S234636AbhBWVL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 16:11:56 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id B59E027B16;
        Tue, 23 Feb 2021 22:11:32 +0100 (CET)
Subject: [PATCH] replace "parameters" by "arguments" in error messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <40b2fedc-fdde-1fc0-ef98-86d8ea638193@kdbg.org>
 <xmqqk0qz4284.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <71cdd5a6-d71b-154a-30da-13a6a66779af@kdbg.org>
Date:   Tue, 23 Feb 2021 22:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqk0qz4284.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.02.21 um 09:28 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> When an error message informs the user about an incorrect command
>> invocation, it should refer to "arguments", not "parameters".
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  Recently, I was greated by an accidental `git tag` invocation:
>>
>>  $ git tag one two three
>>  fatal: too many params
>>
>>  This is bad in two regards: (1) There's a techie-speak abbreviation
>>  in a user-visible text, (2) and it is wrong terminology to refer to
>>  "parameters" when "arguments" would be correct.
>>
>>  Then I looked at every single occurrence of "parameter" in Documentation/
>>  and half-way through the rest and wanted to  correct all incorrect uses,
>>  but things are by far not as clear-cut as I hoped.
>>
>>  So, I stopped here and fixed the one pain point that triggered the voyage,
>>  which I hope is not too controversal.
>>
>>  bisect.c                    |  2 +-
>>  builtin/notes.c             | 20 ++++++++++----------
>>  builtin/stash.c             |  2 +-
>>  builtin/tag.c               |  2 +-
>>  t/t3301-notes.sh            |  6 +++---
>>  t/t6030-bisect-porcelain.sh |  4 ++--
>>  6 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/bisect.c b/bisect.c
>> index 75ea0eb57f..ae48d19acf 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -1064,7 +1064,7 @@ enum bisect_error bisect_next
>>    	if (!all) {
>>  		fprintf(stderr, _("No testable commit found.\n"
>> -			"Maybe you started with bad path parameters?\n"));
>> +			"Maybe you started with bad path arguments?\n"));
>>    		return BISECT_NO_TESTABLE_COMMIT;
>>  	}
>> diff --git a/builtin/notes.c b/builtin/notes.c
> 
> The above hunk is curious for a few reasons.
> 
>  - The hunk header claims that both the preimage and the postimage
>    are 7 lines long, but they only have 5 (2 precontext, 1 change
>    and 2 postcontext) lines.
> 
>  - There are spaces before tab on a few context lines that do not
>    exist in the patch target.
> 
> Ahh, format=flawed, that is.
> 
>     Content-Type: text/plain; charset=utf-8; format=flowed
> 

Sorry for that. Modern Thunderbird requires a new add-on to force
non-flowed messages, and that works as expected only when TB is
configured "correctly". I've missed this subtle point. Here's the
patch again unmodified, hopefully non-flowed.

---- 8< ----
Subject: [PATCH] replace "parameters" by "arguments" in error messages

When an error message informs the user about an incorrect command
invocation, it should refer to "arguments", not "parameters".

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 bisect.c                    |  2 +-
 builtin/notes.c             | 20 ++++++++++----------
 builtin/stash.c             |  2 +-
 builtin/tag.c               |  2 +-
 t/t3301-notes.sh            |  6 +++---
 t/t6030-bisect-porcelain.sh |  4 ++--
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index 75ea0eb57f..ae48d19acf 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1064,7 +1064,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 
 	if (!all) {
 		fprintf(stderr, _("No testable commit found.\n"
-			"Maybe you started with bad path parameters?\n"));
+			"Maybe you started with bad path arguments?\n"));
 
 		return BISECT_NO_TESTABLE_COMMIT;
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index 2987c08a2e..08b8914d29 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -373,7 +373,7 @@ static int list(int argc, const char **argv, const char *prefix)
 				     git_notes_list_usage, 0);
 
 	if (1 < argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(git_notes_list_usage, options);
 	}
 
@@ -428,7 +428,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0);
 
 	if (2 < argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(git_notes_add_usage, options);
 	}
 
@@ -506,7 +506,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 
 	if (from_stdin || rewrite_cmd) {
 		if (argc) {
-			error(_("too many parameters"));
+			error(_("too many arguments"));
 			usage_with_options(git_notes_copy_usage, options);
 		} else {
 			return notes_copy_from_stdin(force, rewrite_cmd);
@@ -514,11 +514,11 @@ static int copy(int argc, const char **argv, const char *prefix)
 	}
 
 	if (argc < 1) {
-		error(_("too few parameters"));
+		error(_("too few arguments"));
 		usage_with_options(git_notes_copy_usage, options);
 	}
 	if (2 < argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(git_notes_copy_usage, options);
 	}
 
@@ -595,7 +595,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0);
 
 	if (2 < argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(usage, options);
 	}
 
@@ -662,7 +662,7 @@ static int show(int argc, const char **argv, const char *prefix)
 			     0);
 
 	if (1 < argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(git_notes_show_usage, options);
 	}
 
@@ -812,7 +812,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		error(_("must specify a notes ref to merge"));
 		usage_with_options(git_notes_merge_usage, options);
 	} else if (!do_merge && argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(git_notes_merge_usage, options);
 	}
 
@@ -960,7 +960,7 @@ static int prune(int argc, const char **argv, const char *prefix)
 			     0);
 
 	if (argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(git_notes_prune_usage, options);
 	}
 
@@ -982,7 +982,7 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 			     git_notes_get_ref_usage, 0);
 
 	if (argc) {
-		error(_("too many parameters"));
+		error(_("too many arguments"));
 		usage_with_options(git_notes_get_ref_usage, options);
 	}
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 9bc85f91cd..60813d70d3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -222,7 +222,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc)
-		return error(_("git stash clear with parameters is "
+		return error(_("git stash clear with arguments is "
 			       "unimplemented"));
 
 	return do_clear_stash();
diff --git a/builtin/tag.c b/builtin/tag.c
index e8b85eefd8..482d1b7d28 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -564,7 +564,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	object_ref = argc == 2 ? argv[1] : "HEAD";
 	if (argc > 2)
-		die(_("too many params"));
+		die(_("too many arguments"));
 
 	if (get_oid(object_ref, &object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 4af881f0ba..d742be8840 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1293,11 +1293,11 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	grep "replacement note 3" actual
 '
 
-test_expect_success 'git notes copy diagnoses too many or too few parameters' '
+test_expect_success 'git notes copy diagnoses too many or too few arguments' '
 	test_must_fail git notes copy 2>error &&
-	test_i18ngrep "too few parameters" error &&
+	test_i18ngrep "too few arguments" error &&
 	test_must_fail git notes copy one two three 2>error &&
-	test_i18ngrep "too many parameters" error
+	test_i18ngrep "too many arguments" error
 '
 
 test_expect_success 'git notes get-ref expands refs/heads/main to refs/notes/refs/heads/main' '
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 7bcde054d7..43608abcb7 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -578,9 +578,9 @@ test_expect_success 'skipping away from skipped commit' '
 	test "$para3" = "$PARA_HASH3"
 '
 
-test_expect_success 'erroring out when using bad path parameters' '
+test_expect_success 'erroring out when using bad path arguments' '
 	test_must_fail git bisect start $PARA_HASH7 $HASH1 -- foobar 2> error.txt &&
-	test_i18ngrep "bad path parameters" error.txt
+	test_i18ngrep "bad path arguments" error.txt
 '
 
 test_expect_success 'test bisection on bare repo - --no-checkout specified' '
-- 
2.30.0.455.ge51aa30bde

