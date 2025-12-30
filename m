Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392722E5418
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107025; cv=none; b=lxkCSDBX64F18kFWsoGY38FutjYlqR9OzmEirrncPN436ex1dskqR9LTyuvD8mG84uN7Io6kVe8HHhCutoCBqnzwwSoxrZe1e/t04zPhGSMTBjwjklpk8jn+8hW6+wHAGh1mSW6de0qFtFngdsgAtZOeVNNHthDzY2WrNAPYVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107025; c=relaxed/simple;
	bh=kQCDr+hyF4UIxeTocPDucf9WbtjvHwcfv4DK1WmF5V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReUkf0+0PoPqswTfqYy45skLq5z7VoAGwGlsmYO/sa4Cy3y2ezhMcK/+4I+e1KpkDeAm7LMzZQa2snkGaVJQp/VMCXCmVju5IsSTZ7gdW/HAhHHWpSmwcbFmZ5Qva+2XkxcmpMEMR1ifySFJS1CW4LpttWTRfxvjKKYRNnrx6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FHMaVzN6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnZwwUei; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FHMaVzN6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnZwwUei"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A2121D00033;
	Tue, 30 Dec 2025 10:03:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 30 Dec 2025 10:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767107022;
	 x=1767193422; bh=ffIwbrwJxvX3Km0AKt9EvoUYNWJ0T4wer1fMZ5Hy5eM=; b=
	FHMaVzN66IdnqiIhWVUjB80DsgRy8BSz6RMJi+WeHWbEvRqF4UABcy8q4wFmHL5u
	rigGj45oFnixNjWb3rIgz19tHkItikK0JlyRsOYewoGia5TjGEO2I0/PD2VWnSka
	q5HXIyNjbbj6h07hJBbFIr3KeYmSK4zo/oOrDIHLz/5rwDjoj/5mPpcgofC0rm9U
	eUF03ERwaj3pZ4By3ILurJSfEvY8gohxAbUGvFisYFCL+ZcTkaBAoFP6tqIT9LWE
	VCbtsYe2NJKAwukONbz/gm24Fgjo5NbF/kj+xngxmpRlSGZTlC21WanW6xJ3iJxn
	G/d+ua6mDCBP3Y4d193oHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767107022; x=
	1767193422; bh=ffIwbrwJxvX3Km0AKt9EvoUYNWJ0T4wer1fMZ5Hy5eM=; b=J
	nZwwUeix/eNACzalBVqKsRnVbxaYMZ0JeuJLWU+QjnZAbdAqNf/cNbyEhwOYltlN
	QSR0EkZHWSeSPbS/Kbjc7qC2ESgiWo8W4UY6kRkINoCWhPJ03Q7HfLD+ngyaobZz
	8XXV3YBpuABXqp4tBbN8XLtVwmz/oHLI6VA6dn+Frfce7wVCuUSZuVlXoyFdP7Ed
	zTXczqPv11eHGGznPhoie4lsnMRlr/L0EuIhEah3rEXVcem4+l8mjPqIy4w83gYE
	HtV+qTk7rpoUfpDVUjN6sf+DvIaJNdAi9gdTqYn1kd70gqhilv3ThHCzuMxk8Xoy
	H3oq/QHyA54jiwfVYWQ9Q==
X-ME-Sender: <xms:zulTaXKxKZ2oNtc40wSjdrmYaEc1VXNOPgQCjFIOmVeVj8yRcso7x30>
    <xme:zulTaUdpMrUg5eDJz-tbw8sdjuL5FYHXXc5My_-IdOvIIJ6UQBLUgm5FO_GyQ07xF
    jMWwEO52lFM2ChBXi2I1Zz8paO_WxiNoG_MRHgB_TkIm6i5Jcib_w>
X-ME-Received: <xmr:zulTaW9s9naYltAVrJ8g1Ig9gcCZOQdbqjmJWcsls8wnLKOnSOsxb-CVMTKECHdrTcGwiofY7amybGjaYSqBfqi4cYt5KQqgAQ7ZO6cyTixdpjqNWS882iU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:zulTaRoE3NNHlmToXtvlmAxuqT8-nrFF2xOXoQLOdnzkc1F53ozqIg>
    <xmx:zulTabCRXUJTCw8zSqq-98S3du8iNI-Eo9V1L6zHAnICATz4pdv_zA>
    <xmx:zulTaTwsyT9VxTDe37y2a1MOZ8Ht8iUxD8PxlxJeHrqzNSkgPRdwmw>
    <xmx:zulTaY2Z-aC3Vm9Lo04PMsm0wyUvYGiKU8C3LnDvm9aLQ6SZ3yzwog>
    <xmx:zulTaeQWD1PQp-VYxnYBfw3HvxDoibMace68PWUIgh_SAssI03HRc7-Y>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:03:40 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/5] replay: die descriptively when invalid commit-ish is given
Date: Tue, 30 Dec 2025 16:01:49 +0100
Message-ID: <V2_replay_die_descr.17e@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <V2_CV_replay_die_descr.17b@msgid.xyz>
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Giving an invalid commit-ish to `--onto` makes git-replay(1) fail with:

    fatal: Replaying down to root commit is not supported yet!

Going backwards from this point:

1. `onto` is `NULL` from `determine_replay_mode`;
2. that function in turn calls `peel_committish`; and
3. here we return `NULL` if `repo_get_oid` fails.

Let’s die immediately with a descriptive error message instead.

Doing this also provides us with a descriptive error if we “forget” to
provide an argument to `--onto` (but we really do unintentionally):[1]

    $ git replay --onto ^main topic1
    fatal: '^main' is not a valid commit-ish

Note that the `--advance` case won’t be triggered in practice because
of the “argument to --advance must be a reference” check (see the
previous test, and commit).

† 1: The argument to `--onto` is mandatory and the option parser accepts
     both `--onto=<name>` (stuck form) and `--onto name`. The latter
     form makes it easy to unintentionally pass something to the option
     when you really meant to pass a positional argument.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    Let’s use a slightly longer subject line in the commit message so that it
    looks more like a full sentence (no dropped/implied words).[1]
    
    Also remove the test for `--advance` which is now wrong because of the
    previous commit/patch. And reword the commit message now that only `--onto`
    is relevant in practice.
    
    There was also feedback about *where* to give this error:[2]
    
    > How many callers use this function?  I am wondering if it is better
    > to give a better message at the caller(s), rather than here, where
    > we lack context to tell something like "You gave string 'ource' as
    > the argument to the '--onto' option, but 'ource' does not name any
    > commit" (in other words, "for what our caller is trying to peel
    > <name> to a commit").
    
    But I opted to keep the check here by using the new `mode` parameter to
    provide the context; it is either `--onto` or `--advance`.
    
    Also remove the “not supported yet” now that `*onto` cannot be `NULL` at
    this point. I wasn’t confident enough to pull the trigger on that in the
    first round. But after Elijah’s comment[3] I feel like I understand the code
    well enough.
    
    Also change the test to use printf since it’s only one line. That will be
    in line with the later commits/patches here.
    
    🔗 1: https://lore.kernel.org/git/xmqqecolrip7.fsf@gitster.g/
    🔗 2: https://lore.kernel.org/git/xmqqikdxriw3.fsf@gitster.g/
    🔗 3: https://lore.kernel.org/git/CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com/

 builtin/replay.c         | 15 +++++++--------
 t/t3650-replay-basics.sh |  7 +++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 35813140e99..07a6767ade1 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -25,17 +25,19 @@ static const char *short_commit_name(struct repository *repo,
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
-		return NULL;
+		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
 	obj = parse_object(repo, &oid);
 	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
 						  OBJ_COMMIT);
 }
 
@@ -170,11 +172,11 @@ static void populate_for_onto_or_advance_mode(struct repository *repo,
 		die(_("need some commits to replay"));
 
 	die_for_incompatible_opt2(!!onto_name, "--onto",
 				  !!*advance_name, "--advance");
 	if (onto_name) {
-		*onto = peel_committish(repo, onto_name);
+		*onto = peel_committish(repo, onto_name, "--onto");
 		if (rinfo.positive_refexprs <
 		    strset_get_size(&rinfo.positive_refs))
 			die(_("all positive revisions given must be references"));
 		*update_refs = xcalloc(1, sizeof(**update_refs));
 		**update_refs = rinfo.positive_refs;
@@ -191,11 +193,11 @@ static void populate_for_onto_or_advance_mode(struct repository *repo,
 			free(*advance_name);
 			*advance_name = fullname;
 		} else {
 			die(_("argument to --advance must be a reference"));
 		}
-		*onto = peel_committish(repo, *advance_name);
+		*onto = peel_committish(repo, *advance_name, "--advance");
 		if (rinfo.positive_refexprs > 1)
 			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
 	}
 	strset_clear(&rinfo.negative_refs);
 	strset_clear(&rinfo.positive_refs);
@@ -349,13 +351,10 @@ int cmd_replay(int argc,
 
 	populate_for_onto_or_advance_mode(repo, &revs.cmdline,
 					  onto_name, &advance_name,
 					  &onto, &update_refs);
 
-	if (!onto) /* FIXME: Should handle replaying down to root commit */
-		die("Replaying down to root commit is not supported yet!");
-
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
 	}
 
@@ -367,11 +366,11 @@ int cmd_replay(int argc,
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
index 7dea62f064f..d4399aa1662 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -56,10 +56,17 @@ test_expect_success 'argument to --advance must be a reference' '
 	oid=$(git rev-parse main) &&
 	test_must_fail git replay --advance=$oid topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
+test_expect_success '--onto with invalid commit-ish' '
+	printf "fatal: ${SQ}refs/not-valid${SQ} is not " >expect &&
+	printf "a valid commit-ish for --onto\n" >>expect &&
+	test_must_fail git replay --onto=refs/not-valid topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
-- 
2.52.0.10.g08704017180

