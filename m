Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6E10FD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642885; cv=none; b=YvGsgAO2NSt89vSFKFk2YmaI1uylyr8107OEA5fMtJSdyfBN7YQIrZbOoniow82hT52DfSmiUnufiOPs01tqHz8lYRf24DwtW9e5kCVINJvsug0hSMEHmSuGaIspwlbZvDeDkKbMhWE/2qSIdwkYCNz2BF0acAJjArGGqvnNYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642885; c=relaxed/simple;
	bh=LeJB3JhcXw0PMcvir6g2tch2EKEg5ejMVA31JXtplRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKK650mUJt2Af/hHFB816ypuhxNwR4nU6sY5Bbt6Lwb0WMCgkIrWk+XazpZQy/r9ej5zYjgxorL4I3PNuCtIzgNXJNMQEoNCa+WY5TrHWYGhYyFihm9bCp8aF/2EEMBTT89a/LRE4LqWyEB817j7GlfC+OhKPBdJiBFKH3mddBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ky2O0w2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpdNIibG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ky2O0w2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpdNIibG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE5907A00F4;
	Mon,  5 Jan 2026 14:54:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 05 Jan 2026 14:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767642882;
	 x=1767729282; bh=jLv+pia+b1rvKgRJnwZENd7gjzs1vLNwYCIZnTN0ADY=; b=
	Ky2O0w2i3b7OJwT51XGPYLj+a8mTHaXxAFTM5MIFy5qrM2TQkaBq8UkX12MDfhMP
	U4rrqn16p88lPoTha+eHsiIzI60WI/sAwt38Hmg7Y9dWj4mffANAH26mSiDEOKQz
	ROA/ObmsOYUGEVgcFc0tVCDRQ3GKebvoMkgBbnVksGwWtEj/WaVWmkX6EwTS109+
	bdVDRH3jJBCdVUjjroKx4/M92dzy4dC3y/0B2Ku38FvF0DTaKYGkKt3A5/au5/PV
	NYGqfmNMwPEDzGZgsbx2TED+0GtwAIejZUgMAR7aCrhYg6ivUy8ADjyiDS4gwFC7
	Z8bF6tsuCIK/qmyYDhfRbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767642882; x=
	1767729282; bh=jLv+pia+b1rvKgRJnwZENd7gjzs1vLNwYCIZnTN0ADY=; b=H
	pdNIibG4J4N0vf0b+ayw+VE2Gedj5qITIorOvieyTAxY93NpCG9b9we0+6lbddZg
	xthD4Q2HXdcf3PSzA18BctHij3xMD4D6gogK/OIDrsFYhv/q+Uc0JEP63uUy3z5r
	3SnAP2n55AsCl+5yL/jMh7quOZ1JguUuWmQT/1ANYv7ghHLKTa62UWBzmydgMVos
	mScRHA+XU6F/wansV+SttVEgjaglC46IaFajlU3guWd66v8c5qqYzPHYoZbVhLGy
	de+8vejhLsf8sG6+Q00Y3ZJGEGp55IQTA2RU7sofxSy0YncWYOm6bu+PpCSzT3ka
	MIza/zc02xPACiYhxUeBw==
X-ME-Sender: <xms:Ahdcadtm21LHKwEyTIdLxYE5OWjSXRWwsWvG3p5bLTMlQXdzR6qIi1A>
    <xme:Ahdcafz8pAUXYz3xTSX-usl_d6dyE6YJVTATu9Np6aBZ3bKcwojJlvS5MFhGlKdMD
    wD9omnYHjmc4xHbk9D_SsdIoylTW9Ec3H-V-enIEcPsxTdWNzqfUQ>
X-ME-Received: <xmr:AhdcaYDuT8l5HkcYo33JQiVXPQbE1vUlWw9V3nvC4PQ4fKx3WQiqNR1U1_qIOVrSIEnUA1Qxg6oeYRQZjxzASswyHsqbtvRQumqSaxvo4dh8B4qfGrGmnzypoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:AhdcaVerf_SOHrntyqGgwADrL_qjTjaOUhsOvfJFf4ppXhcs6_vlNQ>
    <xmx:AhdcaamUiEKXQPPcHVcJ5vfPNUpm-Kxp2AGeOdIWtPylVE3_XDSZ2Q>
    <xmx:AhdcaUEmUaIvCUAL2Rn7mr4Wybj4EgtXWWKX0BptCiQfkfUNIxB9oA>
    <xmx:Ahdcaa6LG5LKwHi_qZagRaPvnsETtp5T9hIZBc3LJ2DpCw9Sx5XTWQ>
    <xmx:Ahdcae3ZRFIFKodaWrmW33Nh1JF-pzrEmRtibv4u62znsLlbL0OWoa6P>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 14:54:41 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/6] replay: die descriptively when invalid commit-ish is given
Date: Mon,  5 Jan 2026 20:53:19 +0100
Message-ID: <V3_replay_die_descr.1a7@msgid.xyz>
X-Mailer: git-send-email 2.52.0.383.gb1c58d6b301
In-Reply-To: <V3_CV_replay_die_descr.1a4@msgid.xyz>
References: <V2_CV_replay_die_descr.17b@msgid.xyz> <V3_CV_replay_die_descr.1a4@msgid.xyz>
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

1. `onto` is `NULL` from `set_up_replay_mode`;
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
    v3:
    
    Update commit message since it uses the outdated function name.[1]
    
    🔗 1: https://lore.kernel.org/git/CABPp-BH1b3rHi96qXLQwQRX6g7POmqYLKyAc=_1UsWmfiWsGFg@mail.gmail.com/#t
    
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

 builtin/replay.c         | 13 +++++++------
 t/t3650-replay-basics.sh |  7 +++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 8c33a15398d..dfb98eb3a9c 100644
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
 
@@ -170,11 +172,11 @@ static void set_up_replay_mode(struct repository *repo,
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
@@ -191,11 +193,11 @@ static void set_up_replay_mode(struct repository *repo,
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
@@ -349,12 +351,11 @@ int cmd_replay(int argc,
 
 	set_up_replay_mode(repo, &revs.cmdline,
 			   onto_name, &advance_name,
 			   &onto, &update_refs);
 
-	if (!onto) /* FIXME: Should handle replaying down to root commit */
-		die("Replaying down to root commit is not supported yet!");
+	/* FIXME: Should handle replaying down to root commit */
 
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
 	}
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
2.52.0.383.gb1c58d6b301

