Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97753A1E99
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106984; cv=none; b=oVO/hZX0Hvq5sWuEkk998/RXrflEyXlH2CMCMl3k0VR646YPjpMq+8OZaqxqTi+BfwijVmBca0RwDtcLkOiFCiA8k9eQx03pyi/tZou+jOcIMI1jHjeAILHCghFF5YcONSz7t60w5T35rwi0B5kWvfiS1HHOSMEkYJDRiG0Vt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106984; c=relaxed/simple;
	bh=JR02AtEubs7A1jbpDxOx2TUmdq3n6PxishJ+9y8/JiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+kxmJVJyAGcuzDlwfLUVnm8yJAGE79JVt4fgIj+qzDfPVeUHSGeYRZ3Q+3jPbT4YIOkbQZAhFqfUsDAZpR8Gu7+NRcxNh3lxCaVOnXXPgO2cVsj+cNRPVFPUSerNOCHJirFTxrUMrlzWLtZ30Spk9MUpJSAd8REQcqM3iZU+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eFTZGrwg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYlEJ2TP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eFTZGrwg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYlEJ2TP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CBED7A001B;
	Tue, 30 Dec 2025 10:03:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 30 Dec 2025 10:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767106981;
	 x=1767193381; bh=sa/ifiZm9EDlZC02wPgzppLmtUxLLL2EhTDg2W4j+JA=; b=
	eFTZGrwgEDf5zcpiUmcHAhO2Wwia/lC/kIVHPePqCJ60zQNHzyYsaN9LiZfeJblE
	w0lJ1RlZwCw+OOhcqkhbLe6Df6ZYypkWCI1j8VrYQAxlIYAMd60u8/sW9zJgysT4
	HNr90ev1WhxvAuRCt1WO4KeVV5MSC4bItiUghUNSuzyAMofXEJdW4bFzIFrzloOg
	vxoVQ6NnfezB3+abJWSgiFTDR7QUOxQva/jetEb2wIOm1HbbTJ4iBjUjfjai9r2N
	Q5g1x6QPozzaQeS8j+pIHJQfLSGGdKa5ZIZA+l02+gSY3HKmPEF8nU+SnDqfUNp0
	ffQqR5rBFsSrCPlEyQG8WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767106981; x=
	1767193381; bh=sa/ifiZm9EDlZC02wPgzppLmtUxLLL2EhTDg2W4j+JA=; b=i
	YlEJ2TPFIZ+iCr2b4QcmWPwS90OO+u9FsHZda4w8k1zR9aX1f+NpHBh1HXdIDUiF
	iX+u7WnmcZ+yMljht7U7MOCqjO/NIxAGW53ciDKeOq2MdThrkt/bv05IAwbXFcwS
	dRCOgr1f63JuJ0abH7nhnGMeLDPFJpIjuLRWFuiCssUy1POFJPxGtOQBOeIMJVyz
	LR4lq1dFvemiwhBDeo7RMHc/2CQxwmtL4qvegnMUbovUTGvwWcCPqtbnbSlAH/tC
	+8RDcP6CZRxwes8vA0FVLwmwh1TTpo/6K6dW2fQ1nsa8YtR3Mu2EhEgUWr7hgeWY
	9/WObin2mLauJRDXDC7Pg==
X-ME-Sender: <xms:pelTacSBT6ZMSOLLmXxfhzeCJrxNYa-vZaJ1MYvN32PUhzg7xwwp4yI>
    <xme:pelTaTHIDbvBVG7WtGX7jSts_QUj3reVhVJKWl6_FCQBzUHTCXrC2QGY9qSiW54Qt
    QqQti5JHI857Ad-dwHJ36yQO1A-61O7CDtu8c_G_sMTnylZBy9dYA>
X-ME-Received: <xmr:pelTaRESXHhPIGo-8MA7RgUPXDPF5Z_vLaI0wEEsebIwm-EVoOikXO94b1ptB9ocYDfAfOdTDA32Vtp6BpzoXPwD14sLJ6lrUkEJ0uQ7rSEzpx_FfIdqQDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdefvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pelTaRQWS-w0YZEbu5q0wzzIZB6l-J_CdQ-75CjVvCDuH0qKrtc8ng>
    <xmx:pelTaSLVRtJvFDzHB7WmC4Ow6oj3pcvFCuX5JNQqn6l2P-2R2UqEcA>
    <xmx:pelTacZPyyEiR-FtGzdueeJGfjnkNKVlFAsPN8VnMDwtJWyx6Ligyg>
    <xmx:pelTaU-3CDdrscdgROI5WD2gtKM0OxgB4zjKiRp1aZZ6cqLaPvI_-A>
    <xmx:pelTaXZyHl6IHhaeAhfIeTiD55DnOibfHHVlfTD4jaIXUHX6STbda0VB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:03:00 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/5] replay: remove dead code and rearrange
Date: Tue, 30 Dec 2025 16:01:47 +0100
Message-ID: <V2_dead_replay_code.17c@msgid.xyz>
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

22d99f01 (replay: add --advance or 'cherry-pick' mode, 2023-11-24) both
added `--advance` and made one of `--onto` or `--advance` mandatory.
But `determine_replay_mode` claims that there is a third alternative;
neither of `--onto` or `--advance` were given:

    if (onto_name) {
    ...
    } else if (*advance_name) {
    ...
    } else {
    ...
    }

But this is false—the fallthrough else-block is dead code.

Commit 22d99f01 was iterated upon by several people.[1] The initial
author wrote code for a sort of *guess mode*, allowing for shorter
commands when that was possible. But the next person instead made one
of the aforementioned options mandatory. In turn this code was dead on
arrival in git.git.

[1]: https://lore.kernel.org/git/CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com/

Let’s remove this code. We can also join the if-block with the
condition `!*advance_name` into the `*onto` block since we do not set
`*advance_name` in this function. It only looked like we might set it
since the dead code has this line:

    *advance_name = xstrdup_or_null(last_key);

Let’s also rename the function since we do not determine
the replay mode here. We simply populate data structures.

Note that there might be more dead code caused by this *guess mode*.
We only concern ourselves with this function for now.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]
    
    See the link in the commit message.
    
    Not strictly needed for this series but I think it makes sense to fix it
    here.

 builtin/replay.c | 70 +++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc9..54849f65c87 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -154,16 +154,16 @@ static void get_ref_information(struct repository *repo,
 
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
@@ -174,69 +174,30 @@ static void determine_replay_mode(struct repository *repo,
 	if (onto_name) {
 		*onto = peel_committish(repo, onto_name);
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
 
+		if (!*advance_name)
+			BUG("expected either onto_name or *advance_name in this function");
+
 		*onto = peel_committish(repo, *advance_name);
 		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
 			     &oid, &fullname, 0) == 1) {
 			free(*advance_name);
 			*advance_name = fullname;
 		} else {
 			die(_("argument to --advance must be a reference"));
 		}
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
 
@@ -384,12 +345,13 @@ int cmd_replay(int argc,
 			  "'%s' bit in 'struct rev_info' will be forced"),
 			"simplify_history");
 		revs.simplify_history = 0;
 	}
 
-	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
-			      &onto, &update_refs);
+	populate_for_onto_or_advance_mode(repo, &revs.cmdline,
+					  onto_name, &advance_name,
+					  &onto, &update_refs);
 
 	if (!onto) /* FIXME: Should handle replaying down to root commit */
 		die("Replaying down to root commit is not supported yet!");
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.52.0.10.g08704017180

