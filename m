Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00A3A1E99
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106967; cv=none; b=ZV/IF7wTUPrk21V0vDIQOj6eHr5rHBsrYfjYGeyXug669z9/D96evSB4zis7A9D8TXDv937fsseRsQacZ/9ss/h5QpQ0dJ6pJSCA71J9y+rC8BqG+lmLjCCqgOAa72kDAf+7IcDrzc0GiUp7aIGW6aCGWaP/PFh2fFMhC9QFIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106967; c=relaxed/simple;
	bh=z9SrxsYTkV8vOGIj04fPlGKwfaXOJZ00YhBrnL6mOrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+wqTyiFe/UYozFfpa/1mhXJDgAAlcFPHwaids7kTtZjWEQAuYgKaKCLQNJIQT7nl80rmrGOYw3UUTTmT8+Eu0RLVJpQH1Wmbiyh8FLnF6fwhuNGDyKZjzMMYDzticJsNiynwqd0w0FOevry6nwKq7WlLAyiADnW/yv6Wno15xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SJn5HnSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGeHyVuJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SJn5HnSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGeHyVuJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D9C481D00035;
	Tue, 30 Dec 2025 10:02:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Dec 2025 10:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767106963;
	 x=1767193363; bh=ICdVVaX9WW5Ik/Jhc+HxGwP4KoH46te8mHP0upXfhFc=; b=
	SJn5HnSpEtFkm19dKm5bKR7WS+fYNPrvbOSsiMelrSclLBv7KMn5cwlGW9Onnh3y
	yavb1K/39JWK9RVH3DIdjCrKCCaESBdFpKSLRrR3EgeoojZIFGZfPTr6kyuBAsTX
	cbjEZFElW/fe5QNVFToBe1E38HTkeyiGWtQh64HRIJTQtaxARzaZoP8aYhxfMsTF
	MInsXUwxSLMp5/B5lG8KGXxb3uwnCNaRROGX7La/gRx31KICzfozQleGXtcaezSX
	Q44+Qb+ZbtBd1lwK/p+xUzg/guAeDuOV252J+Y1ks15THFiEEPa/C8Gt5+ZyI+G/
	dBXFC7fINmBWX/zrwIOP7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767106963; x=
	1767193363; bh=ICdVVaX9WW5Ik/Jhc+HxGwP4KoH46te8mHP0upXfhFc=; b=C
	GeHyVuJs14Zkf/Z8FbmLJvSbK/I1nKgRbub4ft7F/zJ8AezhR8pVNQ/guGGXeOaD
	t6Iw1GDsSuL1Kd7NBO+pQhzBZU/tRmP5dxcqyrSNweoEielwdxdsB8vj2KNUogNP
	HroCnhohW1dxP0c5sCJE5TIgJwYaNYpEqKBu1z1G09ZUDUf6cKER2TvXSUHOB+Gd
	llbkOEv3lJ0Msmq/F4gzFdSxH94QGUdVVQRp3I2vGA1zN4DA1yDGuiR0WwbTg9CO
	liDd/06eN8mLfTVWdBFeASNskjlnvr6TanNg5exlvHKwijzFCYe4FHNagZQZK9U3
	u5GoIcgNmhdUN15zUi3JA==
X-ME-Sender: <xms:k-lTaeXnmy7MmEjx-L5jED0YqA9peE7OAv8tYvoHmbdsjiXjcD563jE>
    <xme:k-lTaT7qwitz6GxtkwjriCXQZqaLEv9KUzktltAtgAJsuwA4t8uSXhwh18dR5vqfx
    ySj0yuqHfhzekKNndA7-Dqc3PYkQ3iBOj_-o9v1BI0Pvu5mb2z2j4g>
X-ME-Received: <xmr:k-lTaZo_D9xFDiAhmAIkZJdF3Hm1fwWaqypXZN67UH46sAjr8r1OJF8JTI6dy0ZBvwgiXrvjGsdOLEjqbVZ0BRqI6mB9259PoAWTZ3BpPXJUtbqfSGqhAOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:k-lTaWmPyiLqa5_Kl9TohkRvGWDNHHWWZ4xLcIdtRZ6bWFfQHOZyFQ>
    <xmx:k-lTaVPc6x1e9ZEGCjYidU7EoWzyTHfse0CIaAOmTqc-55KxpNew5g>
    <xmx:k-lTaaNlsbq26xZI0RZB2fCPteYr8QxQOh4a9ls65GCpTQ-1zwymMQ>
    <xmx:k-lTaWiUYNbobHQvX2UVeTI1sSSrTtIWvd2Bgbz9hEKWtmqrvm8rdA>
    <xmx:k-lTaTf5V5pfcssGgnnFzYnhSN-dZx7vMZtAfVKLUo7K63hnO7UBqYBd>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:02:41 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/5] replay: die descriptively when invalid commit-ish
Date: Tue, 30 Dec 2025 16:01:46 +0100
Message-ID: <V2_CV_replay_die_descr.17b@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <CV_replay_die_descr.13f@msgid.xyz>
References: <CV_replay_die_descr.13f@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

You get this error when you for example mistype the argument to
`--onto`:

    fatal: Replaying down to root commit is not supported yet!

Consider that you might not know yourself that you have mistyped
something; then this looks even more puzzling. You might have given a
range like `main..topic` but the command says that it would need to
replay down to the root commit.

The only thing that’s happened though is that `NULL` has been
interpreted in the wrong way.

Let’s instead die immediately when the real error happens, in other
words when we can’t find the commit for the given commit-ish.

Also:

• Add more regression tests
• Remove dead code
• Slightly more robust object parsing (parse_object_or_die)

§ Dropped section (see previous)

Somewhat unrelated to this change ...

§ Changes in v2

In this version we remove some dead code (see previous section), improve
tests and add a couple more, and improve the main “die descriptively”
part, with two additional patches/commits to that end:

• replay: find *onto only after testing for ref name
• replay: die if we cannot parse object

See the notes on each patch/commit for change details.

§ Link to v1

https://lore.kernel.org/git/CV_replay_die_descr.13f@msgid.xyz/

❦ ❦ ❦ ❦ ❦

(this means you can stop reading here)

§ How I Present Patch Series

Version: 2

The cover letter:

• Problem statement and solution
• (optional) Summary of what each commit/patch does
• Changes compared to the previous version
  • Note that all versions are not included
• (optional) “CC”/“Cc” which explains all or parts of the CC list
  • But some things are not noteworthy, like the standard practice of
    including previous-round respondents
• Link to the previous version
  • This is new.  I thought it was redundant but some people (like me!)
    use webapp email clients which are not that great for navigating
    among tree-like email threads.  So I was inspired by this practice
    which many others already use.

Then each commit/patch might have Git notes with a `series` namespace.
These contain:

• Comments/questions to reviewers about my approach or statements made
  in the commit message.
• May quote the commit message or emails (with links)
• Lines starting with `v<version>:` which introduce a changelog for that
  version.  Might have `v<num>: [new]` if this version is 2+ and the
  patch/commit is new. Now, lately (Sep 2025) these have been written in
  the “imperative mood”, like what is done for a commit message in this
  (Git) project.  A bit strange, given that most others seem to use the
  more immediately natural past-tense.  But on the other hand: how many
  new contributors to this project use the wrong tense/mood in their
  commit messages?  The Git project rule is not “natural”.  But I think
  it’s better nonetheless and worth the effort.
• ... But this kind of changelog might also be conducive to a bullet
  list of changes.  So I might either skip the previous point, do only a
  bullet point, or do both: a presentation and then the bullet points
  summarizing the presentation.
• Note that all `v<version>:` are kept between versions, which is not
  consistent with how I only have the “Changes” part for the previous
  version in the cover letter.
• `v<version>:` are ordered newest-to-oldest.

Kristoffer Haugsbakk (5):
  replay: remove dead code and rearrange
  replay: find *onto only after testing for ref name
  replay: die descriptively when invalid commit-ish is given
  replay: die if we cannot parse object
  t3650: add more regression tests for failure conditions

 builtin/replay.c         | 87 +++++++++++-----------------------------
 t/t3650-replay-basics.sh | 54 +++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 63 deletions(-)

Interdiff against v1:
diff --git a/builtin/replay.c b/builtin/replay.c
index 175b64c5335..ca5a14de4c7 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -25,18 +25,20 @@ static const char *short_commit_name(struct repository *repo,
 {
 	return repo_find_unique_abbrev(repo, &commit->object.oid,
 				       DEFAULT_ABBREV);
 }
 
-static struct commit *peel_committish(struct repository *repo, const char *name)
+static struct commit *peel_committish(struct repository *repo,
+				      const char *name,
+				      const char *mode)
 {
 	struct object *obj;
 	struct object_id oid;
 
 	if (repo_get_oid(repo, name, &oid))
-		die(_("'%s' is not a valid commit-ish"), name);
-	obj = parse_object(repo, &oid);
+		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
+	obj = parse_object_or_die(repo, &oid, name);
 	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
 						  OBJ_COMMIT);
 }
 
 static char *get_author(const char *message)
@@ -154,89 +156,50 @@ static void get_ref_information(struct repository *repo,
 
 		free(fullname);
 	}
 }
 
-static void determine_replay_mode(struct repository *repo,
-				  struct rev_cmdline_info *cmd_info,
-				  const char *onto_name,
-				  char **advance_name,
-				  struct commit **onto,
-				  struct strset **update_refs)
+static void populate_for_onto_or_advance_mode(struct repository *repo,
+					      struct rev_cmdline_info *cmd_info,
+					      const char *onto_name,
+					      char **advance_name,
+					      struct commit **onto,
+					      struct strset **update_refs)
 {
 	struct ref_info rinfo;
 
 	get_ref_information(repo, cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 
 	die_for_incompatible_opt2(!!onto_name, "--onto",
 				  !!*advance_name, "--advance");
 	if (onto_name) {
-		*onto = peel_committish(repo, onto_name);
+		*onto = peel_committish(repo, onto_name, "--onto");
 		if (rinfo.positive_refexprs <
 		    strset_get_size(&rinfo.positive_refs))
 			die(_("all positive revisions given must be references"));
-	} else if (*advance_name) {
+		*update_refs = xcalloc(1, sizeof(**update_refs));
+		**update_refs = rinfo.positive_refs;
+		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
+	} else {
 		struct object_id oid;
 		char *fullname = NULL;
 
-		*onto = peel_committish(repo, *advance_name);
+		if (!*advance_name)
+			BUG("expected either onto_name or *advance_name in this function");
+
 		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
 			     &oid, &fullname, 0) == 1) {
 			free(*advance_name);
 			*advance_name = fullname;
 		} else {
 			die(_("argument to --advance must be a reference"));
 		}
+		*onto = peel_committish(repo, *advance_name, "--advance");
 		if (rinfo.positive_refexprs > 1)
 			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
-	} else {
-		int positive_refs_complete = (
-			rinfo.positive_refexprs ==
-			strset_get_size(&rinfo.positive_refs));
-		int negative_refs_complete = (
-			rinfo.negative_refexprs ==
-			strset_get_size(&rinfo.negative_refs));
-		/*
-		 * We need either positive_refs_complete or
-		 * negative_refs_complete, but not both.
-		 */
-		if (rinfo.negative_refexprs > 0 &&
-		    positive_refs_complete == negative_refs_complete)
-			die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
-		if (negative_refs_complete) {
-			struct hashmap_iter iter;
-			struct strmap_entry *entry;
-			const char *last_key = NULL;
-
-			if (rinfo.negative_refexprs == 0)
-				die(_("all positive revisions given must be references"));
-			else if (rinfo.negative_refexprs > 1)
-				die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
-			else if (rinfo.positive_refexprs > 1)
-				die(_("cannot advance target with multiple source branches because ordering would be ill-defined"));
-
-			/* Only one entry, but we have to loop to get it */
-			strset_for_each_entry(&rinfo.negative_refs,
-					      &iter, entry) {
-				last_key = entry->key;
-			}
-
-			free(*advance_name);
-			*advance_name = xstrdup_or_null(last_key);
-		} else { /* positive_refs_complete */
-			if (rinfo.negative_refexprs > 1)
-				die(_("cannot implicitly determine correct base for --onto"));
-			if (rinfo.negative_refexprs == 1)
-				*onto = rinfo.onto;
-		}
-	}
-	if (!*advance_name) {
-		*update_refs = xcalloc(1, sizeof(**update_refs));
-		**update_refs = rinfo.positive_refs;
-		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
 	}
 	strset_clear(&rinfo.negative_refs);
 	strset_clear(&rinfo.positive_refs);
 }
 
@@ -384,15 +347,13 @@ int cmd_replay(int argc,
 			  "'%s' bit in 'struct rev_info' will be forced"),
 			"simplify_history");
 		revs.simplify_history = 0;
 	}
 
-	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
-			      &onto, &update_refs);
-
-	if (!onto) /* FIXME: Should handle replaying down to root commit */
-		die("Replaying down to root commit is not supported yet!");
+	populate_for_onto_or_advance_mode(repo, &revs.cmdline,
+					  onto_name, &advance_name,
+					  &onto, &update_refs);
 
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
 	}
@@ -405,11 +366,11 @@ int cmd_replay(int argc,
 	while ((commit = get_revision(&revs))) {
 		const struct name_decoration *decoration;
 		khint_t pos;
 		int hr;
 
-		if (!commit->parents)
+		if (!commit->parents) /* FIXME: Should handle replaying down to root commit */
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(repo, commit, replayed_commits,
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index c543d55857b..c0c59ae6938 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -41,61 +41,72 @@ test_expect_success 'setup' '
 
 	git switch main &&
 	test_commit L &&
 	test_commit M &&
 
+	git switch --detach topic4 &&
+	test_commit N &&
+	test_commit O &&
+	git switch -c topic-with-merge topic4 &&
+	test_merge P O --no-ff &&
+	git switch main &&
+
 	git switch -c conflict B &&
 	test_commit C.conflict C.t conflict
 '
 
 test_expect_success 'setup bare' '
 	git clone --bare . bare
 '
 
-test_expect_success '--onto with invalid commit-ish' '
-	cat >expect <<-EOF &&
-	fatal: ${SQ}refs/not-valid${SQ} is not a valid commit-ish
-	EOF
-	test_must_fail git replay --onto=refs/not-valid topic1..topic2 2>actual &&
+test_expect_success 'argument to --advance must be a reference' '
+	echo "fatal: argument to --advance must be a reference" >expect &&
+	oid=$(git rev-parse main) &&
+	test_must_fail git replay --advance=$oid topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
-test_expect_success '--advance with invalid commit-ish' '
-	cat >expect <<-EOF &&
-	fatal: ${SQ}refs/not-valid${SQ} is not a valid commit-ish
-	EOF
-	test_must_fail git replay --advance=refs/not-valid topic1..topic2 2>actual &&
+test_expect_success '--onto with invalid commit-ish' '
+	printf "fatal: ${SQ}refs/not-valid${SQ} is not " >expect &&
+	printf "a valid commit-ish for --onto\n" >>expect &&
+	test_must_fail git replay --onto=refs/not-valid topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'option --onto or --advance is mandatory' '
-	cat >expect <<-\EOF &&
-	error: option --onto or --advance is mandatory
-	EOF
-	# First line is the error; rest is Usage
-	test_must_fail git replay topic1..topic2 >&1 2>&1 |
-		head -1 >actual &&
+	echo "error: option --onto or --advance is mandatory" >expect &&
+	test_might_fail git replay -h >>expect &&
+	test_must_fail git replay topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'no base or negative ref gives no-replaying down to root error' '
-	cat >expect <<-\EOF &&
-	fatal: replaying down to root commit is not supported yet!
-	EOF
+	echo "fatal: replaying down to root commit is not supported yet!" >expect &&
 	test_must_fail git replay --onto=topic1 topic2 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'options --advance and --contained cannot be used together' '
-	cat >expect <<-EOF &&
-	fatal: options ${SQ}--advance${SQ} and ${SQ}--contained${SQ} cannot be used together
-	EOF
+	printf "fatal: options ${SQ}--advance${SQ} " >expect &&
+	printf "and ${SQ}--contained${SQ} cannot be used together\n" >>expect &&
 	test_must_fail git replay --advance=main --contained \
 		topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'cannot advance target ... ordering would be ill-defined' '
+	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
+	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replaying merge commits is not supported yet' '
+	echo "fatal: replaying merge commits is not supported yet!" >expect &&
+	test_must_fail git replay --advance=main main..topic-with-merge 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
Range-diff against v1:
-:  ----------- > 1:  314ba49dd2f replay: remove dead code and rearrange
-:  ----------- > 2:  976d336adef replay: find *onto only after testing for ref name
1:  d49923de7c5 ! 3:  a7a7e1e720e replay: die descriptively when invalid commit-ish
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    replay: die descriptively when invalid commit-ish
    +    replay: die descriptively when invalid commit-ish is given
     
    -    Giving an invalid commit-ish to `--onto` or `--advance` makes
    -    git-replay(1) fail with:
    +    Giving an invalid commit-ish to `--onto` makes git-replay(1) fail with:
     
             fatal: Replaying down to root commit is not supported yet!
     
    @@ Commit message
             $ git replay --onto ^main topic1
             fatal: '^main' is not a valid commit-ish
     
    +    Note that the `--advance` case won’t be triggered in practice because
    +    of the “argument to --advance must be a reference” check (see the
    +    previous test, and commit).
    +
         † 1: The argument to `--onto` is mandatory and the option parser accepts
              both `--onto=<name>` (stuck form) and `--onto name`. The latter
              form makes it easy to unintentionally pass something to the option
    @@ Commit message
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +
    +    Let’s use a slightly longer subject line in the commit message so that it
    +    looks more like a full sentence (no dropped/implied words).[1]
    +
    +    Also remove the test for `--advance` which is now wrong because of the
    +    previous commit/patch. And reword the commit message now that only `--onto`
    +    is relevant in practice.
    +
    +    There was also feedback about *where* to give this error:[2]
    +
    +    > How many callers use this function?  I am wondering if it is better
    +    > to give a better message at the caller(s), rather than here, where
    +    > we lack context to tell something like "You gave string 'ource' as
    +    > the argument to the '--onto' option, but 'ource' does not name any
    +    > commit" (in other words, "for what our caller is trying to peel
    +    > <name> to a commit").
    +
    +    But I opted to keep the check here by using the new `mode` parameter to
    +    provide the context; it is either `--onto` or `--advance`.
    +
    +    Also remove the “not supported yet” now that `*onto` cannot be `NULL` at
    +    this point. I wasn’t confident enough to pull the trigger on that in the
    +    first round. But after Elijah’s comment[3] I feel like I understand the code
    +    well enough.
    +
    +    Also change the test to use printf since it’s only one line. That will be
    +    in line with the later commits/patches here.
    +
    +    🔗 1: https://lore.kernel.org/git/xmqqecolrip7.fsf@gitster.g/
    +    🔗 2: https://lore.kernel.org/git/xmqqikdxriw3.fsf@gitster.g/
    +    🔗 3: https://lore.kernel.org/git/CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com/
    +
      ## builtin/replay.c ##
    -@@ builtin/replay.c: static struct commit *peel_committish(struct repository *repo, const char *name)
    +@@ builtin/replay.c: static const char *short_commit_name(struct repository *repo,
    + 				       DEFAULT_ABBREV);
    + }
    + 
    +-static struct commit *peel_committish(struct repository *repo, const char *name)
    ++static struct commit *peel_committish(struct repository *repo,
    ++				      const char *name,
    ++				      const char *mode)
    + {
    + 	struct object *obj;
      	struct object_id oid;
      
      	if (repo_get_oid(repo, name, &oid))
     -		return NULL;
    -+		die(_("'%s' is not a valid commit-ish"), name);
    ++		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
      	obj = parse_object(repo, &oid);
      	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
      						  OBJ_COMMIT);
    +@@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repository *repo,
    + 	die_for_incompatible_opt2(!!onto_name, "--onto",
    + 				  !!*advance_name, "--advance");
    + 	if (onto_name) {
    +-		*onto = peel_committish(repo, onto_name);
    ++		*onto = peel_committish(repo, onto_name, "--onto");
    + 		if (rinfo.positive_refexprs <
    + 		    strset_get_size(&rinfo.positive_refs))
    + 			die(_("all positive revisions given must be references"));
    +@@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repository *repo,
    + 		} else {
    + 			die(_("argument to --advance must be a reference"));
    + 		}
    +-		*onto = peel_committish(repo, *advance_name);
    ++		*onto = peel_committish(repo, *advance_name, "--advance");
    + 		if (rinfo.positive_refexprs > 1)
    + 			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
    + 	}
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 					  onto_name, &advance_name,
    + 					  &onto, &update_refs);
    + 
    +-	if (!onto) /* FIXME: Should handle replaying down to root commit */
    +-		die("Replaying down to root commit is not supported yet!");
    +-
    + 	if (prepare_revision_walk(&revs) < 0) {
    + 		ret = error(_("error preparing revisions"));
    + 		goto cleanup;
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 		khint_t pos;
    + 		int hr;
    + 
    +-		if (!commit->parents)
    ++		if (!commit->parents) /* FIXME: Should handle replaying down to root commit */
    + 			die(_("replaying down to root commit is not supported yet!"));
    + 		if (commit->parents->next)
    + 			die(_("replaying merge commits is not supported yet!"));
     
      ## t/t3650-replay-basics.sh ##
    -@@ t/t3650-replay-basics.sh: test_expect_success 'setup bare' '
    - 	git clone --bare . bare
    +@@ t/t3650-replay-basics.sh: test_expect_success 'argument to --advance must be a reference' '
    + 	test_cmp expect actual
      '
      
     +test_expect_success '--onto with invalid commit-ish' '
    -+	cat >expect <<-EOF &&
    -+	fatal: ${SQ}refs/not-valid${SQ} is not a valid commit-ish
    -+	EOF
    ++	printf "fatal: ${SQ}refs/not-valid${SQ} is not " >expect &&
    ++	printf "a valid commit-ish for --onto\n" >>expect &&
     +	test_must_fail git replay --onto=refs/not-valid topic1..topic2 2>actual &&
     +	test_cmp expect actual
     +'
    -+
    -+test_expect_success '--advance with invalid commit-ish' '
    -+	cat >expect <<-EOF &&
    -+	fatal: ${SQ}refs/not-valid${SQ} is not a valid commit-ish
    -+	EOF
    -+	test_must_fail git replay --advance=refs/not-valid topic1..topic2 2>actual &&
    -+	test_cmp expect actual
    -+'
     +
      test_expect_success 'using replay to rebase two branches, one on top of other' '
      	git replay --onto main topic1..topic2 >result &&
-:  ----------- > 4:  9700630d95e replay: die if we cannot parse object
2:  5aa5b96950e ! 5:  5e1b9205df5 t3650: add more regression tests for failure conditions
    @@ Commit message
         a few more since these are simple to write and remove if they become
         obsolete.
     
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +
    +    Improve test `option --onto or --advance is mandatory`. Phillip pointed out
    +    that using a pipe loses the return value. Instead let’s test the whole
    +    output by just appending `git replay -h` to `expect`.
    +
    +    Also “normalize” to just using echo/printf for the `expect` since these are
    +    just oneliner errors.
    +
    +    Also add two more tests (at the end).
    +
      ## t/t3650-replay-basics.sh ##
    -@@ t/t3650-replay-basics.sh: test_expect_success '--advance with invalid commit-ish' '
    +@@ t/t3650-replay-basics.sh: test_expect_success 'setup' '
    + 	test_commit L &&
    + 	test_commit M &&
    + 
    ++	git switch --detach topic4 &&
    ++	test_commit N &&
    ++	test_commit O &&
    ++	git switch -c topic-with-merge topic4 &&
    ++	test_merge P O --no-ff &&
    ++	git switch main &&
    ++
    + 	git switch -c conflict B &&
    + 	test_commit C.conflict C.t conflict
    + '
    +@@ t/t3650-replay-basics.sh: test_expect_success '--onto with invalid commit-ish' '
      	test_cmp expect actual
      '
      
     +test_expect_success 'option --onto or --advance is mandatory' '
    -+	cat >expect <<-\EOF &&
    -+	error: option --onto or --advance is mandatory
    -+	EOF
    -+	# First line is the error; rest is Usage
    -+	test_must_fail git replay topic1..topic2 >&1 2>&1 |
    -+		head -1 >actual &&
    ++	echo "error: option --onto or --advance is mandatory" >expect &&
    ++	test_might_fail git replay -h >>expect &&
    ++	test_must_fail git replay topic1..topic2 2>actual &&
     +	test_cmp expect actual
     +'
     +
     +test_expect_success 'no base or negative ref gives no-replaying down to root error' '
    -+	cat >expect <<-\EOF &&
    -+	fatal: replaying down to root commit is not supported yet!
    -+	EOF
    ++	echo "fatal: replaying down to root commit is not supported yet!" >expect &&
     +	test_must_fail git replay --onto=topic1 topic2 2>actual &&
     +	test_cmp expect actual
     +'
     +
     +test_expect_success 'options --advance and --contained cannot be used together' '
    -+	cat >expect <<-EOF &&
    -+	fatal: options ${SQ}--advance${SQ} and ${SQ}--contained${SQ} cannot be used together
    -+	EOF
    ++	printf "fatal: options ${SQ}--advance${SQ} " >expect &&
    ++	printf "and ${SQ}--contained${SQ} cannot be used together\n" >>expect &&
     +	test_must_fail git replay --advance=main --contained \
     +		topic1..topic2 2>actual &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'cannot advance target ... ordering would be ill-defined' '
    ++	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
    ++	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'replaying merge commits is not supported yet' '
    ++	echo "fatal: replaying merge commits is not supported yet!" >expect &&
    ++	test_must_fail git replay --advance=main main..topic-with-merge 2>actual &&
    ++	test_cmp expect actual
    ++'
     +
      test_expect_success 'using replay to rebase two branches, one on top of other' '
      	git replay --onto main topic1..topic2 >result &&

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.10.g08704017180

