Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2711110FD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642830; cv=none; b=aU3qiKd9TWxE3GyszcSXmwUfatPed4vDTc6lI7SyK/OQJ/+LBQN15KsH/sgZxBYmli6AKS4HEk5K0f716RzqJRCb7IQOc33J+G7YnnYOVmEwiCGvd23ZLSgAZoVz0RjiI4yjnOkhj1bs0S8E/+ayr/GJ90OKHk89yLBdZl1/wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642830; c=relaxed/simple;
	bh=opYqxACxHjxwDzJA1C6/1Tf3MpYUjrBAPf4mAACjNvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwYsqODx4a/5rKRsISFP+9ojXInMsAayPvlT1l0dvUrbvrncDE9KjIbFOzTvdTn3bQIpRdj4kiHkmbjcLRv7LkfnRcK6oF4fXd70Wg/FUclK1767gMhRrb4xwRuthCM40molYvAUlZYBFyoUbxUtmTVEworGJU3IVDxIM8AQ8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ahZ7QXVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cIq27oyu; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ahZ7QXVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cIq27oyu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D2031D00108;
	Mon,  5 Jan 2026 14:53:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 14:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767642827;
	 x=1767729227; bh=du8PFQIfy7bIsMnwmmQrapxJcv+LGKcmzcRSjxLhySA=; b=
	ahZ7QXVO9cST1e3itVO8vEr+ZEBlKsG/SvFKqqD8oRU1xgKnGpeG6DrsvI0m4B3t
	3uG6urWPgPF8cZ7Hd/Rmbu/dgaQ80FXHhqKtLCkY4NH0nb5uF0X8EVSfIc/RZxsd
	Mp+4rVanlPsDQh9QCQ5XzT0INq8TtUtnqaupwS4HgLx2RBV8rjft39e2ZThHIUe6
	ceeK4KIv63v799M+zOQGdJbgBpryHOcgt1mKc1DZF3IzOATN1XyecC/Xj15H5rUf
	hnRZHrgVoRguljFaXK8Efq2+Tip0jafwwB4ZJkV5LdNY3CxFn++dljQX6COQxtnD
	/z6mgnhlNgUjOVHxJUAz4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767642827; x=
	1767729227; bh=du8PFQIfy7bIsMnwmmQrapxJcv+LGKcmzcRSjxLhySA=; b=c
	Iq27oyuc4L8CGYLO1H1gBqooCNDjnobg/vHcRcBGCf0ZxgfoBEBYfsE0LSLnAQDd
	ZczjbIPK+hsJ3qfl00z108vL0jjSFf/cFQijs2K0M/3H4xMs2MnEzBLCjGW6mmNv
	8voqk+rVZY/AK92UqG5pjqiAo0evKwjP3OtZ2uLgDWctIlDKOF2nX8RsQWTCYroT
	RwGNrpAxA9IYKcWY5XLwBTGmdc8XpPPRGX4M3vZcas+OSDeH9iWqTINuyT7WosDn
	SHqoUHfOAtCs6ye4APTI5AzfkhkgOme8J0oT7veDdJK71Wwftea2cz81JUqAya5Y
	tc0PqhbccsWMfRhpDgZKw==
X-ME-Sender: <xms:yhZcaa3RZlYndqFXffIIL_ZTQRIjUKtS3v6WSGy_U8mV_aBvjqkghOI>
    <xme:yhZcad2DGuIiewDmZb2_BqaWF8wuTH67BmTnoLvmTFKerLC1Hwje3VwniR7dCQjKW
    mCqixMrb8hcu4wpFkoC47NCOwEnLrc1sqmtUL6-iA9KuOXPSvbsiQ>
X-ME-Received: <xmr:yhZcafDRrtwextGB7UPWySainyUeizq6BRgRQCmUjVqpUeMBaC-RxjgnBuimeJAD2WXqU1RDSfN37HoWdcrKNfWNznaHSWPfya5N7cynzp7TbuMKXwEwY6QBfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:yhZcac55Vb4kMpEV4KplwtEjizwHpsbSKU8mEfud9wOZBhcftIQEmQ>
    <xmx:yhZcaQL1icJp3n5QjbT2c3JHygikgT48l2Dmigbbo0ft_NYO6gCh2Q>
    <xmx:yhZcadv5-EuTjBFDlm5iIwVUQzEDnAVd-4a0anBfj8u5rzhllXwn1g>
    <xmx:yhZcaXKSENgCWLAPUdYJhd4EcXNmbdupt2eMfzKRUO96QB7eTLA6LQ>
    <xmx:yxZcaXyOvy2R71jjbeoDvTcdGc5Qs0ulQXuzzVZejK2cMZlwcVtYYiAO>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 14:53:44 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/6] replay: die descriptively when invalid commit-ish
Date: Mon,  5 Jan 2026 20:53:16 +0100
Message-ID: <V3_CV_replay_die_descr.1a4@msgid.xyz>
X-Mailer: git-send-email 2.52.0.383.gb1c58d6b301
In-Reply-To: <V2_CV_replay_die_descr.17b@msgid.xyz>
References: <V2_CV_replay_die_descr.17b@msgid.xyz>
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

§ Dropped section (see v1)

Somewhat unrelated to this change ...

§ Changes in v3

Apply review feedback from Elijah. See patches for details.

• Patch 1: More terse function name
• Patch 2: Improve commit message
• Patch 3: Improve commit message: fix outdated function name mention
• Patch 4: [new] Apply code comment/error message tweaks

§ Link to v2

https://lore.kernel.org/git/V2_CV_replay_die_descr.17b@msgid.xyz/

Kristoffer Haugsbakk (6):
  replay: remove dead code and rearrange
  replay: find *onto only after testing for ref name
  replay: die descriptively when invalid commit-ish is given
  replay: improve code comment and die message
  replay: die if we cannot parse object
  t3650: add more regression tests for failure conditions

 builtin/replay.c         | 87 ++++++++++++----------------------------
 t/t3650-replay-basics.sh | 54 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 62 deletions(-)

Interdiff against v2:
diff --git a/builtin/replay.c b/builtin/replay.c
index ca5a14de4c7..dc46c921667 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -156,16 +156,16 @@ static void get_ref_information(struct repository *repo,
 
 		free(fullname);
 	}
 }
 
-static void populate_for_onto_or_advance_mode(struct repository *repo,
-					      struct rev_cmdline_info *cmd_info,
-					      const char *onto_name,
-					      char **advance_name,
-					      struct commit **onto,
-					      struct strset **update_refs)
+static void set_up_replay_mode(struct repository *repo,
+			       struct rev_cmdline_info *cmd_info,
+			       const char *onto_name,
+			       char **advance_name,
+			       struct commit **onto,
+			       struct strset **update_refs)
 {
 	struct ref_info rinfo;
 
 	get_ref_information(repo, cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
@@ -347,13 +347,15 @@ int cmd_replay(int argc,
 			  "'%s' bit in 'struct rev_info' will be forced"),
 			"simplify_history");
 		revs.simplify_history = 0;
 	}
 
-	populate_for_onto_or_advance_mode(repo, &revs.cmdline,
-					  onto_name, &advance_name,
-					  &onto, &update_refs);
+	set_up_replay_mode(repo, &revs.cmdline,
+			   onto_name, &advance_name,
+			   &onto, &update_refs);
+
+	/* FIXME: Should allow replaying commits with the first as a root commit */
 
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
 	}
@@ -366,12 +368,12 @@ int cmd_replay(int argc,
 	while ((commit = get_revision(&revs))) {
 		const struct name_decoration *decoration;
 		khint_t pos;
 		int hr;
 
-		if (!commit->parents) /* FIXME: Should handle replaying down to root commit */
-			die(_("replaying down to root commit is not supported yet!"));
+		if (!commit->parents)
+			die(_("replaying down from root commit is not supported yet!"));
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(repo, commit, replayed_commits,
 						  onto, &merge_opt, &result);
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index c0c59ae6938..d10c01506f1 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -78,11 +78,11 @@ test_expect_success 'option --onto or --advance is mandatory' '
 	test_must_fail git replay topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'no base or negative ref gives no-replaying down to root error' '
-	echo "fatal: replaying down to root commit is not supported yet!" >expect &&
+	echo "fatal: replaying down from root commit is not supported yet!" >expect &&
 	test_must_fail git replay --onto=topic1 topic2 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'options --advance and --contained cannot be used together' '
Range-diff against v2:
1:  314ba49dd2f ! 1:  6d785c6b45f replay: remove dead code and rearrange
    @@ Commit message
     
             *advance_name = xstrdup_or_null(last_key);
     
    -    Let’s also rename the function since we do not determine
    -    the replay mode here. We simply populate data structures.
    +    Let’s also rename the function since we do not determine the
    +    replay mode here. We just set up `*onto` and refs to update.
     
         Note that there might be more dead code caused by this *guess mode*.
         We only concern ourselves with this function for now.
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v3:
    +
    +    Use more terse function rename.[1] Also tweak commit message based on
    +    this change.
    +
    +    🔗 1: https://lore.kernel.org/git/CABPp-BEJV1XG62_hn_OiZ9q9S3jsyTP0VdOEzS4pME2rrkKFrg@mail.gmail.com/
    +
         v2: [new]
     
         See the link in the commit message.
    @@ builtin/replay.c: static void get_ref_information(struct repository *repo,
     -				  char **advance_name,
     -				  struct commit **onto,
     -				  struct strset **update_refs)
    -+static void populate_for_onto_or_advance_mode(struct repository *repo,
    -+					      struct rev_cmdline_info *cmd_info,
    -+					      const char *onto_name,
    -+					      char **advance_name,
    -+					      struct commit **onto,
    -+					      struct strset **update_refs)
    ++static void set_up_replay_mode(struct repository *repo,
    ++			       struct rev_cmdline_info *cmd_info,
    ++			       const char *onto_name,
    ++			       char **advance_name,
    ++			       struct commit **onto,
    ++			       struct strset **update_refs)
      {
      	struct ref_info rinfo;
      
    @@ builtin/replay.c: int cmd_replay(int argc,
      
     -	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
     -			      &onto, &update_refs);
    -+	populate_for_onto_or_advance_mode(repo, &revs.cmdline,
    -+					  onto_name, &advance_name,
    -+					  &onto, &update_refs);
    ++	set_up_replay_mode(repo, &revs.cmdline,
    ++			   onto_name, &advance_name,
    ++			   &onto, &update_refs);
      
      	if (!onto) /* FIXME: Should handle replaying down to root commit */
      		die("Replaying down to root commit is not supported yet!");
2:  976d336adef ! 2:  7f9aac28792 replay: find *onto only after testing for ref name
    @@ Commit message
         Let’s try to find the ref and only after that try to peel to
         as a commit-ish.
     
    -    Also add a regression test to protect this error-order from future
    +    Also add a regression test to protect this error order from future
         modifications.
     
         Suggested-by: Junio C Hamano <gitster@pobox.com>
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v3:
    +
    +    Don’t use a hyphen in “error-order” since that can be confusing.[1]
    +
    +    🔗 1: https://lore.kernel.org/git/CABPp-BE13K1QB42YLv3mLzB9+jUgkMtHNmbs_XWoTsbv2zSYog@mail.gmail.com/
    +
         v2: [new]
     
         Fallout of v1. Needs to be moved so that the new error message does not
    @@ Notes (series)
         See: https://lore.kernel.org/git/xmqqpl85pb7k.fsf@gitster.g/
     
      ## builtin/replay.c ##
    -@@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repository *repo,
    +@@ builtin/replay.c: static void set_up_replay_mode(struct repository *repo,
      		if (!*advance_name)
      			BUG("expected either onto_name or *advance_name in this function");
      
    @@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repositor
      		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
      			     &oid, &fullname, 0) == 1) {
      			free(*advance_name);
    -@@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repository *repo,
    +@@ builtin/replay.c: static void set_up_replay_mode(struct repository *repo,
      		} else {
      			die(_("argument to --advance must be a reference"));
      		}
3:  a7a7e1e720e ! 3:  88544dcad3e replay: die descriptively when invalid commit-ish is given
    @@ Commit message
     
         Going backwards from this point:
     
    -    1. `onto` is `NULL` from `determine_replay_mode`;
    +    1. `onto` is `NULL` from `set_up_replay_mode`;
         2. that function in turn calls `peel_committish`; and
         3. here we return `NULL` if `repo_get_oid` fails.
     
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v3:
    +
    +    Update commit message since it uses the outdated function name.[1]
    +
    +    🔗 1: https://lore.kernel.org/git/CABPp-BH1b3rHi96qXLQwQRX6g7POmqYLKyAc=_1UsWmfiWsGFg@mail.gmail.com/#t
    +
         v2:
     
         Let’s use a slightly longer subject line in the commit message so that it
    @@ builtin/replay.c: static const char *short_commit_name(struct repository *repo,
      	obj = parse_object(repo, &oid);
      	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
      						  OBJ_COMMIT);
    -@@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repository *repo,
    +@@ builtin/replay.c: static void set_up_replay_mode(struct repository *repo,
      	die_for_incompatible_opt2(!!onto_name, "--onto",
      				  !!*advance_name, "--advance");
      	if (onto_name) {
    @@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repositor
      		if (rinfo.positive_refexprs <
      		    strset_get_size(&rinfo.positive_refs))
      			die(_("all positive revisions given must be references"));
    -@@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repository *repo,
    +@@ builtin/replay.c: static void set_up_replay_mode(struct repository *repo,
      		} else {
      			die(_("argument to --advance must be a reference"));
      		}
    @@ builtin/replay.c: static void populate_for_onto_or_advance_mode(struct repositor
      			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
      	}
     @@ builtin/replay.c: int cmd_replay(int argc,
    - 					  onto_name, &advance_name,
    - 					  &onto, &update_refs);
    + 			   onto_name, &advance_name,
    + 			   &onto, &update_refs);
      
     -	if (!onto) /* FIXME: Should handle replaying down to root commit */
     -		die("Replaying down to root commit is not supported yet!");
    --
    ++	/* FIXME: Should handle replaying down to root commit */
    + 
      	if (prepare_revision_walk(&revs) < 0) {
      		ret = error(_("error preparing revisions"));
    - 		goto cleanup;
    -@@ builtin/replay.c: int cmd_replay(int argc,
    - 		khint_t pos;
    - 		int hr;
    - 
    --		if (!commit->parents)
    -+		if (!commit->parents) /* FIXME: Should handle replaying down to root commit */
    - 			die(_("replaying down to root commit is not supported yet!"));
    - 		if (commit->parents->next)
    - 			die(_("replaying merge commits is not supported yet!"));
     
      ## t/t3650-replay-basics.sh ##
     @@ t/t3650-replay-basics.sh: test_expect_success 'argument to --advance must be a reference' '
-:  ----------- > 4:  2e149c41634 replay: improve code comment and die message
4:  9700630d95e = 5:  35cce78b469 replay: die if we cannot parse object
5:  5e1b9205df5 ! 6:  cd87a11f96b t3650: add more regression tests for failure conditions
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with invalid commit-ish' '
     +'
     +
     +test_expect_success 'no base or negative ref gives no-replaying down to root error' '
    -+	echo "fatal: replaying down to root commit is not supported yet!" >expect &&
    ++	echo "fatal: replaying down from root commit is not supported yet!" >expect &&
     +	test_must_fail git replay --onto=topic1 topic2 2>actual &&
     +	test_cmp expect actual
     +'

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.383.gb1c58d6b301

