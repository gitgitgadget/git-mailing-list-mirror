Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62558286D56
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879428; cv=none; b=hwEn/3UctAj33YEWOOELdMjFEguwaaorQ6foMesFbIgjYFTNoe76+Yf48AkhmEsfhX+xqtURvaaSIH/y8EPI9h4gVbtsl3kbWhIMjymUe+5bvAf8yH6Gb+6O4xI80i2zcqQCJcYA3vAsKLCcGfagKYOCgIcJGP1iAQM5pDzRjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879428; c=relaxed/simple;
	bh=Hyj7v7dDtoFaZlxhr3Y5yNilhX8z9ln+Zv2n6lHJStk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azqhlUX4vdbjCp0Xt595G/KcmYEthyPa/KfW3AIz08eoK+CB49MiQbnoerm4GC2LJ77YQMrBoZ1tokpfitJjfz1KaO0FPTR7You/pBdbqQeO3r99ND9JNAi0BLEyY6wUcU4k+ILWa82Ez5isZ7h8NK1ib4YVsT9YOOoZBIHVzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=clPbArUY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJLyPoRd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="clPbArUY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJLyPoRd"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 602B91D00128;
	Sun, 14 Sep 2025 15:50:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 14 Sep 2025 15:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879425;
	 x=1757965825; bh=/FWelSqEkE3+gT0h3O3rXJxo2tfy0qVOY0tIIk05dbM=; b=
	clPbArUYs6lHnunj6IJDpepp+LUtKiVpXEIy5XDGtMWkviEaEZUbUBjJglz08XWv
	jK7nTgZ5/0NJ763Y2F35ARxTtUhmnwTyFlb/sjy/viTM8Cost8R6ghjsWvPcvOMl
	JJw220nM8ZtFunRJd1AoPbHCJ4ASC74w+GU/yaRfPZG33w7C5x7PtRhMw/xnV9tu
	244tOehuLTel7FnjvMPNKD9ViGsUghx7d3maxsUNMCwSvJXly5QhvdnugJgu6FH9
	H/6Mhv/y9sLRq8lGN809WOxpY9eBLDr0HeeD04aNGppjH43B4SFbjJ1CBa18XTJH
	51aXejesPXLKi0CRZyzF4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879425; x=
	1757965825; bh=/FWelSqEkE3+gT0h3O3rXJxo2tfy0qVOY0tIIk05dbM=; b=n
	JLyPoRdNS6owtXy4AXchtxxInOnG95KYyMCQiTLYSA1OJWQg5S66iYRxcKlFNSIg
	hp1UOQliue232y2GAosT82ZyV98U2a9Eekf9X2WI7m6c9dJWp3LaY6lo+0aAH0rn
	ak+2PnTELsNDB7Qgq7xDC0tjuVAoYI5DK/2/yYIy3ut78/mSRLFQwtl7WetYpYQY
	f2JLiRxj4DKlru+0yMybmWT7oRYyKOfz4pCc7NLfPmHmXsccH3Bh9SssPXH/WEjk
	f5r/f55H9kYnF4NC+MiZK5a/NU/mGnl0IfaiRJnnwtvW5Mzo9LfN7SAo6XJrfBS3
	H6POgQY4pY+1qVRVJl3rg==
X-ME-Sender: <xms:gBzHaMmO_LwzZXcpUwMMHVUV_j16DQNULkf0aSM783-zBeU0IZuYbt8>
    <xme:gBzHaES84Jc0AztvLBxr2yzZY5T0G72rkNzPtqHg81hverpy7W2KkEfK2oE9FMsLp
    dpn6O4VW0z9stNMvA>
X-ME-Received: <xmr:gBzHaLGwcv59Ul-n_EHIYZ9SfJFQQ7RVi22TK_0JEcs-cRnyaJS5XCero1PUp5aPxgUtiiDDZocKqpVliNzWHBJn5RlHxokZJnGqO04Rr_7DHcEe4Ks4M0S7ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepieegvdffvedvvdetjedtieeigeejjeelgfeugfevlefhtedvieeiteehvedtiedt
    necuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gBzHaJEQNikAXQ0E_AECrkWgHyX-Jm-ijRZiPAiISsPG6QtmwISAQA>
    <xmx:gBzHaJRyw7HW4JvH8FY8P5SfeLvWtu7HZJvYT7k-oND_gaWvd2UvMw>
    <xmx:gBzHaKI3oU_10lsXxS6-vL4QCnKsHz_YmqeqACH5PSL2PFSQnrkyVQ>
    <xmx:gBzHaEZAxoObnY8ow3X2311N3-QpaGI6jv5jsIaRYcJtHIfoFfbRuQ>
    <xmx:gRzHaG8u9dflUj6cT3-_KCdDKwB1-CUsBjRwyHMz_gwjzXhYVOUX1RiE>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:50:23 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/8] you-still-use-that??: improve breaking changes troubleshooting
Date: Sun, 14 Sep 2025 21:49:34 +0200
Message-ID: <cover.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name>
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

    $ ./git whatchanged
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
    $ ./git pack-redundant
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

§ Changes in v5

Fix the leak that Peff found (with Peff’s suggestion).  Also fix (with
Peff’s help) a regression where you were able to get into an infinite
alias loop specifically when using deprecated builtin names.

Link: https://lore.kernel.org/git/20250910051347.GA556174@coredump.intra.peff.net/

Also bring back the `BUG` check.

Cheers

Kristoffer Haugsbakk (8):
  git: add `deprecated` category to --list-cmds
  git: move seen-alias bookkeeping into handle_alias(...)
  git: allow alias-shadowing deprecated builtins
  t0014: test shadowing of aliases for a sample of builtins
  you-still-use-that??: help the user help themselves
  whatchanged: hint about git-log(1) and aliasing
  whatchanged: remove not-even-shorter clause
  BreakingChanges: remove claim about whatchanged reports

 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/config/alias.adoc    |  3 +-
 Documentation/git-whatchanged.adoc |  8 ++-
 Documentation/git.adoc             |  3 +-
 builtin/log.c                      |  8 ++-
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 git.c                              | 90 ++++++++++++++++++++----------
 t/t0014-alias.sh                   | 58 +++++++++++++++++++
 usage.c                            | 33 ++++++++---
 10 files changed, 163 insertions(+), 46 deletions(-)

Interdiff against v4:
diff --git a/git.c b/git.c
index b3aafebfe4c..1310363e5c4 100644
--- a/git.c
+++ b/git.c
@@ -365,7 +365,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 	return (*argv) - orig_argv;
 }
 
-static int handle_alias(struct strvec *args)
+static int handle_alias(struct strvec *args, struct string_list *expanded_aliases)
 {
 	int envchanged = 0, ret = 0, saved_errno = errno;
 	int count, option_count;
@@ -376,6 +376,8 @@ static int handle_alias(struct strvec *args)
 	alias_command = args->v[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
+		struct string_list_item *seen;
+
 		if (args->nr == 2 && !strcmp(args->v[1], "-h"))
 			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
 				   alias_command, alias_string);
@@ -423,6 +425,24 @@ static int handle_alias(struct strvec *args)
 		if (!strcmp(alias_command, new_argv[0]))
 			die(_("recursive alias: %s"), alias_command);
 
+		seen = unsorted_string_list_lookup(expanded_aliases, args->v[0]);
+		if (seen) {
+			struct strbuf sb = STRBUF_INIT;
+			for (size_t i = 0; i < expanded_aliases->nr; i++) {
+				struct string_list_item *item = &expanded_aliases->items[i];
+
+				strbuf_addf(&sb, "\n  %s", item->string);
+				if (item == seen)
+					strbuf_addstr(&sb, " <==");
+				else if (i == expanded_aliases->nr - 1)
+					strbuf_addstr(&sb, " ==>");
+			}
+			die(_("alias loop detected: expansion of '%s' does"
+			      " not terminate:%s"), expanded_aliases->items[0].string, sb.buf);
+		}
+
+		string_list_append(expanded_aliases, args->v[0]);
+
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
@@ -677,6 +697,8 @@ static void list_builtins(struct string_list *out,
 			  unsigned int include_option,
 			  unsigned int exclude_option)
 {
+	if (include_option && exclude_option)
+		BUG("'include_option' and 'exclude_option' are mutually exclusive");
 	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (include_option && !(commands[i].option & include_option))
 			continue;
@@ -810,8 +832,7 @@ static int is_deprecated_command(const char *cmd)
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
-	struct string_list cmd_list = STRING_LIST_INIT_DUP;
-	struct string_list_item *seen;
+	struct string_list expanded_aliases = STRING_LIST_INIT_DUP;
 
 	while (1) {
 		/*
@@ -821,9 +842,7 @@ static int run_argv(struct strvec *args)
 		 * deprecation complaint in the meantime.
 		 */
 		if (is_deprecated_command(args->v[0]) &&
-		    alias_lookup(args->v[0])) {
-			if (!handle_alias(args))
-				break;
+		    handle_alias(args, &expanded_aliases)) {
 			done_alias = 1;
 			continue;
 		}
@@ -876,35 +895,17 @@ static int run_argv(struct strvec *args)
 		/* .. then try the external ones */
 		execv_dashed_external(args->v);
 
-		seen = unsorted_string_list_lookup(&cmd_list, args->v[0]);
-		if (seen) {
-			struct strbuf sb = STRBUF_INIT;
-			for (size_t i = 0; i < cmd_list.nr; i++) {
-				struct string_list_item *item = &cmd_list.items[i];
-
-				strbuf_addf(&sb, "\n  %s", item->string);
-				if (item == seen)
-					strbuf_addstr(&sb, " <==");
-				else if (i == cmd_list.nr - 1)
-					strbuf_addstr(&sb, " ==>");
-			}
-			die(_("alias loop detected: expansion of '%s' does"
-			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
-		}
-
-		string_list_append(&cmd_list, args->v[0]);
-
 		/*
 		 * It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (!handle_alias(args))
+		if (!handle_alias(args, &expanded_aliases))
 			break;
 		done_alias = 1;
 	}
 
-	string_list_clear(&cmd_list, 0);
+	string_list_clear(&expanded_aliases, 0);
 
 	return done_alias;
 }
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index bf7e6512bb1..1ac739a2737 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -27,6 +27,21 @@ test_expect_success 'looping aliases - internal execution' '
 	test_grep "^fatal: alias loop detected: expansion of" output
 '
 
+test_expect_success 'looping aliases - deprecated builtins' '
+	test_config alias.whatchanged pack-redundant &&
+	test_config alias.pack-redundant whatchanged &&
+	cat >expect <<-EOF &&
+	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
+	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
+	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
+	fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
+	  whatchanged <==
+	  pack-redundant ==>
+	EOF
+	test_must_fail git whatchanged -h 2>actual &&
+	test_cmp expect actual
+'
+
 # This test is disabled until external loops are fixed, because would block
 # the test suite for a full minute.
 #
@@ -72,6 +87,15 @@ test_expect_success 'can alias-shadow deprecated builtins' '
 	done
 '
 
+test_expect_success 'can alias-shadow via two deprecated builtins' '
+	# some git(1) commands will fail... (see above)
+	test_might_fail git status -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias.whatchanged=pack-redundant \
+		-c alias.pack-redundant=status whatchanged -h >actual &&
+	test_cmp expect actual
+'
+
 cannot_alias_regular_builtin () {
 	cmd="$1" &&
 	# some git(1) commands will fail... (see above)
Range-diff against v4:
1:  66e6a9554b1 ! 1:  13682553018 git: add `deprecated` category to --list-cmds
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v5:
    +
    +    Add back the `BUG` check from v3 because I think it makes sense to only
    +    populate one of the two options.
    +
    +    Link: https://lore.kernel.org/git/cover.1757345711.git.code@khaugsbakk.name/T/#m922b852384911511c45afd458051f52b50dce62f
    +
         v4:
     
         Incorporate Patrick’s suggestions about the for-loop refactor and
    @@ git.c: int is_builtin(const char *s)
     +			  unsigned int include_option,
     +			  unsigned int exclude_option)
      {
    ++	if (include_option && exclude_option)
    ++		BUG("'include_option' and 'exclude_option' are mutually exclusive");
      	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
     -		if (exclude_option &&
     -		    (commands[i].option & exclude_option))
-:  ----------- > 2:  7f82ef6e96f git: move seen-alias bookkeeping into handle_alias(...)
2:  672253e0e71 ! 3:  4bfe36cccd0 git: allow alias-shadowing deprecated builtins
    @@ Commit message
         the command is removed for good.
     
         Let’s lift this limitation by allowing *deprecated* builtins to be
    -    shadowed by aliases.
    +    shadowed by aliases.[4]
     
         The only observed demand for aliasing has been for git-whatchanged(1),
         not for git-pack-redundant(1).  But let’s be consistent and treat all
    @@ Commit message
              have empty commits (no changes)[2]
         [2]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
         [3]: https://lore.kernel.org/git/BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM/
    +    [4]: The test “looping aliases - deprecated builtins” covers the
    +        case of the extra output mentioned in footnote number 3 of the
    +        previous commit
     
         Based-on-patch-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v5:
    +
    +    Fix a leak caused by calling `alias_lookup(...)` without freeing the
    +    return value by not calling that function.
    +
    +    Add tests for deprecated builtins for infinite alias looping as well as
    +    simple chaining.  This is to exercise all code paths that we could think
    +    of.
    +
    +    Expand on the infinite alias looping test on the whole error
    +    output (compared to the one above).  Link this change to the
    +    previous patch/commit by mentioning it in a footnote.
    +
    +    See the last footnote and the note on the previous commit/patch.  I have
    +    opted not to get rid of this redundant line.  But this documents the
    +    change and future changes that affect it will trigger this
    +    assertion (say if they remove the redundant line).
    +
         v4:
     
         Better `is_deprecated_command` implementation.
    @@ git.c: static void execv_dashed_external(const char **argv)
      static int run_argv(struct strvec *args)
      {
      	int done_alias = 0;
    -@@ git.c: static int run_argv(struct strvec *args)
    - 	struct string_list_item *seen;
    + 	struct string_list expanded_aliases = STRING_LIST_INIT_DUP;
      
      	while (1) {
     +		/*
    @@ git.c: static int run_argv(struct strvec *args)
     +		 * deprecation complaint in the meantime.
     +		 */
     +		if (is_deprecated_command(args->v[0]) &&
    -+		    alias_lookup(args->v[0])) {
    -+			if (!handle_alias(args))
    -+				break;
    ++		    handle_alias(args, &expanded_aliases)) {
     +			done_alias = 1;
     +			continue;
     +		}
    @@ git.c: static int run_argv(struct strvec *args)
      		 * it no longer is safe to invoke builtins directly in
     
      ## t/t0014-alias.sh ##
    +@@ t/t0014-alias.sh: test_expect_success 'looping aliases - internal execution' '
    + 	test_grep "^fatal: alias loop detected: expansion of" output
    + '
    + 
    ++test_expect_success 'looping aliases - deprecated builtins' '
    ++	test_config alias.whatchanged pack-redundant &&
    ++	test_config alias.pack-redundant whatchanged &&
    ++	cat >expect <<-EOF &&
    ++	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
    ++	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
    ++	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
    ++	fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
    ++	  whatchanged <==
    ++	  pack-redundant ==>
    ++	EOF
    ++	test_must_fail git whatchanged -h 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + # This test is disabled until external loops are fixed, because would block
    + # the test suite for a full minute.
    + #
     @@ t/t0014-alias.sh: test_expect_success 'tracing a shell alias with arguments shows trace of prepare
      	test_cmp expect actual
      '
    @@ t/t0014-alias.sh: test_expect_success 'tracing a shell alias with arguments show
     +		can_alias_deprecated_builtin "$cmd" || return 1
     +	done
     +'
    ++
    ++test_expect_success 'can alias-shadow via two deprecated builtins' '
    ++	# some git(1) commands will fail... (see above)
    ++	test_might_fail git status -h >expect &&
    ++	test_file_not_empty expect &&
    ++	test_might_fail git -c alias.whatchanged=pack-redundant \
    ++		-c alias.pack-redundant=status whatchanged -h >actual &&
    ++	test_cmp expect actual
    ++'
     +
      test_done
3:  00108f28f82 ! 4:  a04c6ae968e t0014: test shadowing of aliases for a sample of builtins
    @@ Metadata
      ## Commit message ##
         t0014: test shadowing of aliases for a sample of builtins
     
    -    The previous commit added a test for shadowing deprecated builtins.
    +    The previous commit added tests for shadowing deprecated builtins.
         Let’s make the test suite more complete by exercising a sample of
         the builtins and in turn test the documentation for git-config(1):
     
    @@ Notes (series)
         if I test all of them.
     
      ## t/t0014-alias.sh ##
    -@@ t/t0014-alias.sh: test_expect_success 'can alias-shadow deprecated builtins' '
    - 	done
    +@@ t/t0014-alias.sh: test_expect_success 'can alias-shadow via two deprecated builtins' '
    + 	test_cmp expect actual
      '
      
     +cannot_alias_regular_builtin () {
4:  6bdcaf7f80f = 5:  2f78ab2e28c you-still-use-that??: help the user help themselves
5:  58de9767b22 ! 6:  34443066645 whatchanged: tell users the git-log(1) equivalent
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    whatchanged: tell users the git-log(1) equivalent
    +    whatchanged: hint about git-log(1) and aliasing
     
         There have been quite a few `--i-still-use-this` user reports since Git
         2.51.0 was released.[1][2]  And it doesn’t seem like they are reading
         the man page about the git-log(1) equivalent.
     
    -    Tell them what options to plug into git-log(1).  That template produces
    -    almost the same output[3] and is arguably a plug-in replacement.
    -    Concretely, add an optional `hint` argument so that we can use it right
    -    after the initial error line.
    +    Tell them what options to plug into git-log(1), either as a replacement
    +    command or as an alias.[3]  That template produces almost the same
    +    output[4] and is arguably a plug-in replacement.  Concretely, add
    +    an optional `hint` argument so that we can use it right after the
    +    initial error line.
     
         Also mention the same concrete options in the documentation while we’re
         at it.
    @@ Commit message
             • https://lore.kernel.org/git/9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org/#t
             • https://lore.kernel.org/git/83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com/
         [2]: The error message on 2.51.0 does tell them to report it, unconditionally
    -    [3]: You only get different outputs if you happen to have empty
    +    [3]: We allow aliasing deprecated builtins now for people who are very
    +        used to the command name or just like it a lot
    +    [4]: You only get different outputs if you happen to have empty
              commits (no changes)[4]
    -    [4]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
    +    [5]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v5:
    +
    +    Mention the aliasing hint in the commit message.
    +
         v3:
     
         Add an alias hint now that that is possible.  Also prefix each hint-line
6:  407b430d02c = 7:  b0aabd793f0 whatchanged: remove not-even-shorter clause
7:  fee752d2fb0 = 8:  5021647c245 BreakingChanges: remove claim about whatchanged reports

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.16.gcd94ab5bf81

