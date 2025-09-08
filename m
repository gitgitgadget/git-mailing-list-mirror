Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298C30ACEF
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345888; cv=none; b=XzzWdSN0wFvfT5XfbieFvApu8dwlFub4cQ2G9XiwQV6K4NXAsDjckOxBbL/N8Hu9JEMacMzf1jOFlfemfnlDxptVLfpuzKLuHYXx2NuJUEgFsN4rIMeLDB51FjSw9JtfueD+hlK7uEgm7Bh1iU46cECZn+ixD7sOGzVnzpK1J0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345888; c=relaxed/simple;
	bh=27hpRfaUmP2LB7r0O33JbU4VwZmxHHNHvkCgWlQbUYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHmumEgLWeDx+Bf94pdwjp7sEE/RZIx5qXENIvdqBnsS54Qnb2S9N1jmv1Rv4xz5ttpqLNRXssF1rAFeoW7jAyqa3rPnmV+JFvh6nEnUZ0bcl3+GcEqVcAz2wrvC5azm3PCbEadjIbdw75F1FDf88V6Ti255y881oB/VBDscb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WmL+iAc0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VUPzD57W; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WmL+iAc0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VUPzD57W"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 46802EC020B;
	Mon,  8 Sep 2025 11:38:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 11:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757345885;
	 x=1757432285; bh=DjhuU8dJ1wVvILNlNI4cMaUT5lMe8yJlTgRibmLOhak=; b=
	WmL+iAc02RopLk3s1DqwffyL3B3fKd5My3vjNx4BBMmoGI4t9pwnolew4T5QVbfQ
	GVcJbSFZFTWToedQCzEIAF1c4uhZsXBZmEoIBDImvScwKGOY0yAO9ITBcV40SuqN
	B1UG3ZK6m+rVptKVFh9b4OPdUOYZFJFh2WQzuZECGmrTuhDM2wY9vSyfWta59ftK
	xn/fyR77Yas5gyUGXAoCAk6JetQkXuRq+RwwjzczQwjYHJwQWC4hkYMv5Zi6imou
	XQ4VFVEAr+8Ftkn1tdeymDxs5FjqxInyV0qWhJsxBFMvo6+nOXA17+P2jEKFluRm
	Vq/ZZiUIgRn89MY1Pi8KDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757345885; x=
	1757432285; bh=DjhuU8dJ1wVvILNlNI4cMaUT5lMe8yJlTgRibmLOhak=; b=V
	UPzD57W1ZWfpuGg6N3spUZ1dbJKH7Sjo4kyANJ82UjqMhLFyV5QuesZVsR7Bm9EG
	LtjJivhO2qHcp35lZLIxNqT+kzCnEVie4x+jlOWlKak0EYmpNv3cE2J1BjW6PX9z
	yEAryfMOtsCxflxWAOisJgv+06qwOWBiMHyh91hbBiv6jwltdpw8M499CL1lex0M
	+MQMK6cQDfzCZT7sqU4KXAcowrMDSxG8+iMKfFfr+f+TJEg8TlLYIcp7I8aZeDbL
	CTC3OKMVsAhu+ddRQgdyRiqde/pS1qjVd0XeEyIN9QsbldAM5fzm2iTTd+ucAEoy
	NFUrpDDZ3B9q+rKN1YgOg==
X-ME-Sender: <xms:XPi-aNvNujiBBdqmyyFD5TbQrOYOSoeFYLwUP8HSiYcmnhF7TW5FYDU>
    <xme:XPi-aBB2ShpdpmeJ_PfZb1AABiczoCRoz4wd3L4llI43G6GZhb_uFfRqQ-DM72KKv
    Zn3BOHmnEceqARQNA>
X-ME-Received: <xmr:XPi-aNWypqcjpNJNNNrV0YUDeSYY3UjdAni0dkWho4mFEETv5EvuG6QHu_vJcymFJCwFw9zq_1y5t7R4yCinF73ii0rJnhqB9YZ63TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepieegvdffvedvvdetjedtieeigeejjeelgfeugfevlefhtedvieeiteehvedtiedt
    necuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:Xfi-aHC4QmbkcJXbxT4xojy7Dv9wnrK4W6-QooqKnj4b6WWbwMYDOQ>
    <xmx:Xfi-aI918_FdAhGugo2xYqW8rSmVvgRf2AbTNI5-FadO5NklRE4HQg>
    <xmx:Xfi-aGGbBqp4b1OFReLfUBean3xIUIZVO3ZHRKOIX1iH28KBYjPmDQ>
    <xmx:Xfi-aOM0AssUyL9MoWLtwvxzLz-3oZDnr914vxKtHIBuUVh7zUKgoQ>
    <xmx:Xfi-aC83IkM9slDU_J-kAuxEUWSdbEsIgSX8-pZ8OInWCMOlRQk01POu>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:38:03 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 0/8] you-still-use-that??: improve breaking changes troubleshooting
Date: Mon,  8 Sep 2025 17:36:11 +0200
Message-ID: <cover.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1756480827.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Based on the recent i-still-use-that reports about whatchanged, improve
the error reporting with this command in mind:

1. Give more possible actions instead of just (only) asking them to send
   an email
2. Hint how to replace their git-whatchanged(1) use with git-log(1) or
   an alias `whatchanged` (you can alias deprecated commands now)
3. Minor documentation changes
4. Add `deprecated` to `git --list-cmds`

§ What the errors now look like

    $ /git whatchanged
    'git whatchanged' is nominated for removal.

    hint: You can replace 'git whatchanged <opts>' with:
    hint:   git log <opts> --raw --no-merges
    hint: Or make an alias:
    hint:   git config set --global alias.whatchanged 'log --raw --no-merges'

    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20whatchanged
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this
    $ git pack-redundant
    'git pack-redundant' is nominated for removal.
    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20pack-redundant
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this

§ Changes in v3

Patches 1–4 are new:

• Make aliases which shadow deprecated builtins possible (based on
  Peff’s patch)
  • This was based on Eric’s prompt[1]
• Add `deprecated` category to `git --list-cmds`

Then the patch “whatchanged: tell users the git-log(1) equivalent” is
changed to add the now-possible aliasing.

🔗 1: https://lore.kernel.org/git/CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com/

Kristoffer Haugsbakk (8):
  git: add `deprecated` category to --list-cmds
  git: make the two loops look more symmetric
  git: allow alias-shadowing deprecated builtins
  t0014: test shadowing of aliases for a sample of builtins
  you-still-use-that??: help the user help themselves
  whatchanged: tell users the git-log(1) equivalent
  whatchanged: remove not-even-shorter clause
  BreakingChanges: remove claim about whatchanged reports

 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/config/alias.adoc    |  3 +-
 Documentation/git-whatchanged.adoc |  8 +++--
 Documentation/git.adoc             |  3 +-
 builtin/log.c                      |  8 ++++-
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 git.c                              | 55 ++++++++++++++++++++++++------
 t/t0014-alias.sh                   | 34 ++++++++++++++++++
 usage.c                            | 33 ++++++++++++++----
 10 files changed, 124 insertions(+), 26 deletions(-)

Interdiff against v2:
diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 2c5db0ad842..3c8fab3a95c 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -3,7 +3,8 @@ alias.*::
 	after defining `alias.last = cat-file commit HEAD`, the invocation
 	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored. Arguments are split by
+	hide existing Git commands are ignored except for deprecated
+	commands.  Arguments are split by
 	spaces, the usual shell quoting and escaping are supported.
 	A quote pair or a backslash can be used to quote them.
 +
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 743b7b00e4d..a2f0838b168 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -219,7 +219,8 @@ If you just want to run git as if it was started in `<path>` then use
 	List commands by group. This is an internal/experimental
 	option and may change or be removed in the future. Supported
 	groups are: builtins, parseopt (builtin commands that use
-	parse-options), main (all commands in libexec directory),
+	parse-options), deprecated (deprecated builtins),
+	main (all commands in libexec directory),
 	others (all other commands in `$PATH` that have git- prefix),
 	list-<category> (see categories in command-list.txt),
 	nohelpers (exclude helper commands), alias and config
diff --git a/builtin/log.c b/builtin/log.c
index 5dbb90c014d..1d1e6e9130a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -546,7 +546,9 @@ int cmd_whatchanged(int argc,
 		you_still_use_that("git whatchanged",
 				   _("\n"
 				     "hint: You can replace 'git whatchanged <opts>' with:\n"
-				     "    git log <opts> --raw --no-merges\n"
+				     "hint:\tgit log <opts> --raw --no-merges\n"
+				     "hint: Or make an alias:\n"
+				     "hint:\tgit config set --global alias.whatchanged 'log --raw --no-merges'\n"
 				     "\n"));
 
 	if (!rev.diffopt.output_format)
diff --git a/git.c b/git.c
index 83eac0aeab7..a452ce3f9e9 100644
--- a/git.c
+++ b/git.c
@@ -28,6 +28,7 @@
 #define NEED_WORK_TREE		(1<<3)
 #define DELAY_PAGER_CONFIG	(1<<4)
 #define NO_PARSEOPT		(1<<5) /* parse-options is not used */
+#define DEPRECATED		(1<<6)
 
 struct cmd_struct {
 	const char *cmd;
@@ -51,7 +52,13 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(struct string_list *list, unsigned int exclude_option);
+/*
+ * 'include_option' and 'exclude_option' are mutually exclusive.
+ *
+ * The default ('!include_option') is to include everything
+ * except those filtered out by 'exclude_option'.
+ */
+static void list_builtins(struct string_list *list, unsigned int include_option, unsigned int exclude_option);
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
@@ -88,7 +95,7 @@ static int list_cmds(const char *spec)
 		int len = sep - spec;
 
 		if (match_token(spec, len, "builtins"))
-			list_builtins(&list, 0);
+			list_builtins(&list, 0, 0);
 		else if (match_token(spec, len, "main"))
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
@@ -99,6 +106,8 @@ static int list_cmds(const char *spec)
 			list_aliases(&list);
 		else if (match_token(spec, len, "config"))
 			list_cmds_by_config(&list);
+		else if (match_token(spec, len, "deprecated"))
+			list_builtins(&list, DEPRECATED, 0);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
@@ -322,7 +331,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (!strcmp(cmd, "parseopt")) {
 				struct string_list list = STRING_LIST_INIT_DUP;
 
-				list_builtins(&list, NO_PARSEOPT);
+				list_builtins(&list, 0, NO_PARSEOPT);
 				for (size_t i = 0; i < list.nr; i++)
 					printf("%s ", list.items[i].string);
 				string_list_clear(&list, 0);
@@ -590,7 +599,7 @@ static struct cmd_struct commands[] = {
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 #ifndef WITH_BREAKING_CHANGES
-	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
+	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT | DEPRECATED },
 #endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
@@ -647,7 +656,7 @@ static struct cmd_struct commands[] = {
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
 #ifndef WITH_BREAKING_CHANGES
-	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+	{ "whatchanged", cmd_whatchanged, RUN_SETUP | DEPRECATED },
 #endif
 	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
@@ -668,13 +677,18 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(struct string_list *out, unsigned int exclude_option)
+static void list_builtins(struct string_list *out, unsigned int include_option, unsigned int exclude_option)
 {
-	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
-		if (exclude_option &&
-		    (commands[i].option & exclude_option))
-			continue;
-		string_list_append(out, commands[i].cmd);
+	if (include_option && exclude_option)
+		BUG("'include_option' and 'exclude_option' are mutually exclusive");
+	if (include_option) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
+			if (commands[i].option & include_option)
+				string_list_append(out, commands[i].cmd);
+	} else {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
+			if (!(commands[i].option & exclude_option))
+				string_list_append(out, commands[i].cmd);
 	}
 }
 
@@ -793,6 +807,12 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
+static int is_deprecated_command(const char *cmd)
+{
+	return !strcmp(cmd, "whatchanged") ||
+	       !strcmp(cmd, "pack-redundant");
+}
+
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
@@ -800,6 +820,19 @@ static int run_argv(struct strvec *args)
 	struct string_list_item *seen;
 
 	while (1) {
+		/*
+		 * Allow deprecated commands to be overridden by aliases. This
+		 * creates a seamless path forward for people who want to keep
+		 * using the name after it is gone, but want to skip the
+		 * deprecation complaint in the meantime.
+		 */
+		if (is_deprecated_command(args->v[0]) &&
+		    alias_lookup(args->v[0])) {
+			if (!handle_alias(args))
+				break;
+			done_alias = 1;
+			continue;
+		}
 		/*
 		 * If we tried alias and futzed with our environment,
 		 * it no longer is safe to invoke builtins directly in
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 854d59ec58c..bf7e6512bb1 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -55,4 +55,38 @@ test_expect_success 'tracing a shell alias with arguments shows trace of prepare
 	test_cmp expect actual
 '
 
+can_alias_deprecated_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail for `-h` (the case for
+	# git-status as of 2025-09-07)
+	test_might_fail git status -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'can alias-shadow deprecated builtins' '
+	for cmd in $(git --list-cmds=deprecated)
+	do
+		can_alias_deprecated_builtin "$cmd" || return 1
+	done
+'
+
+cannot_alias_regular_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail... (see above)
+	test_might_fail git "$cmd" -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'cannot alias-shadow a sample of regular builtins' '
+	for cmd in grep check-ref-format interpret-trailers \
+		checkout-index fast-import diagnose rev-list prune
+	do
+		cannot_alias_regular_builtin "$cmd" || return 1
+	done
+'
+
 test_done
Range-diff against v2:
-:  ----------- > 1:  bdc683a92b3 git: add `deprecated` category to --list-cmds
-:  ----------- > 2:  183dd68d09d git: make the two loops look more symmetric
-:  ----------- > 3:  eec01cbac16 git: allow alias-shadowing deprecated builtins
-:  ----------- > 4:  80fb02caeeb t0014: test shadowing of aliases for a sample of builtins
1:  6803e2cc6c3 = 5:  d25ee26f989 you-still-use-that??: help the user help themselves
2:  2f3ac952980 ! 6:  50621a0748f whatchanged: tell users the git-log(1) equivalent
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v3:
    +
    +    Add an alias hint now that that is possible.  Also prefix each hint-line
    +    with `hint: `.
    +
         v2:
     
         Review found a whitespace error in the prev. patch version.  I found a
    @@ builtin/log.c: int cmd_whatchanged(int argc,
     +		you_still_use_that("git whatchanged",
     +				   _("\n"
     +				     "hint: You can replace 'git whatchanged <opts>' with:\n"
    -+				     "    git log <opts> --raw --no-merges\n"
    ++				     "hint:\tgit log <opts> --raw --no-merges\n"
    ++				     "hint: Or make an alias:\n"
    ++				     "hint:\tgit config set --global alias.whatchanged 'log --raw --no-merges'\n"
     +				     "\n"));
      
      	if (!rev.diffopt.output_format)
3:  a074e7be422 = 7:  812c9870f1b whatchanged: remove not-even-shorter clause
4:  9196c3c7e33 = 8:  0d23a4badf0 BreakingChanges: remove claim about whatchanged reports

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.16.gcd94ab5bf81

