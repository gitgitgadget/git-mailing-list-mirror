Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0313E04C
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618362; cv=none; b=beD00rITorN6LjsR18INbaQSgiUIKjFISs19cBj6mFj8pui//GH8YreqqrnX8fLhLBO1Ncc4Cu1QJmJ3Sbf4HhXpmr4Dh9DXnK+gPkdWDQUc1DU78sGU2DifRhPYsCVGtafp7SeZmw3CyJOzyLYcXtTW8/4o0VwT2m0EQ8asNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618362; c=relaxed/simple;
	bh=waks8hoUfznjH12i0vKxdz5LLbjHaWq8lhvqfR9VQag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu4y+vDCN84OZ5agjcRka2FH+MlQ/MKytq5wjsHdbxqNUUVaOB8db8jKUuBDPTjIypR0ubI17t+exiy/fuzymrCDGTlDIe4LVxcaX7nk13lLg2fzW/leDp0wfkm519ZnKz4XLosuNdv2+hqGEhNATTmji6rIk2LgupKYIqz/2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nTUgib/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMwXkk3y; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nTUgib/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMwXkk3y"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 762AE114EADE;
	Wed, 14 Aug 2024 02:52:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 02:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618359; x=1723704759; bh=VsEJeKMeqw
	r010bAYWR8h0QBoC4ZOScl7Aq4HzEOYMU=; b=nTUgib/zoKuvG1XEBN1quFLkQQ
	smgb6YHNdQbEDQyhxWPzjMggpGQMa2AWHH46pJrWoipOFIQwI0FHWUkebecF5rxz
	gY7Zw+S6M5RjheqVS7Gw4zUZAY946tunb6UPvUg4CJG51GPaOb2XLEMObSCVjd7J
	pxU/Lxn+ixhklTSTRp6kV2VNuMe0hiQpIaUh3eHmXZVLrpI5/xLGy5JjgxbVIGTA
	cfn3o0RvSv0vJCzQAim+OZwEAV3VfaCzCdWhMURQr+F9QYkb33ZO5r3NQ3VsA3h8
	O1os2DHg2ppWKwnbYZSKf6RnxhhgiWPUOm4RMCy/VdYbLaAn8kPC2gCcdvoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618359; x=1723704759; bh=VsEJeKMeqwr010bAYWR8h0QBoC4Z
	OScl7Aq4HzEOYMU=; b=uMwXkk3yssLhgGjdrY6bYMlI3HjMryzv0D9E1+RlKSon
	09nGvktYQuXcrdM96cLA1hYU4KanYfq0ZtQFNJ0MxIhl3z2NnJ0zaAzS8yNqS2Ys
	sAL1YnEfh8f43F811ZZeXIR5gmG/S2Xh7T2EpIsRk1zr1u0bD21Hac5gXwlE4kdD
	OWnXkF0Po/WjID8FOQP95GKsb6Nuo/ZC6JxwW/zzPkuRjU3pGxAeSu6fzUqIvy/l
	njJsJHIsgxBI7g0JHshmY21yxZM9pOvAXLiHdZA6zJuMOFRKuXXGavNC8yLITyMS
	7KZCqr9/Ub9oI3ENVWNEaWcbV4QDjGI8nbNZknnF1A==
X-ME-Sender: <xms:N1S8Zv9ah1Ud0SKNsF7wXpH7olfKHPirh4ZR0WkAognSq6y4mWJGrw>
    <xme:N1S8Zrv0bFP1q7OIZExymKu9lfZ8uG3fBhT5Lbo5c0Pjms5gICGCv9gwZXDw2mcDI
    YngKTV3EGM1nHJfXQ>
X-ME-Received: <xmr:N1S8ZtCNCCcE90qH-mGlz9nNDygqGeAZXf4j0xEZOj6tuVKNIAAyUCA72BY5m2EGnS4WtgB77teDcrqo9Suqlvi7SmkeE1dLh6akPAobPCgPLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:N1S8ZretsK5RXOwW9QrzFtOM0uZWLUZunlYIJ8MKwUp5wCftcZxM5g>
    <xmx:N1S8ZkMlRDAhRwHptXoMQNqIBJWOGyCeP2dxxg9eIqbsWEc6cEKDJQ>
    <xmx:N1S8ZtmrKLtwjfe4gOYMkDUr4Z2Kk972_nlLDgb7WScjVrz-5cqwsA>
    <xmx:N1S8ZuuyX0fjF29fWbCHE37AzPIgFTdY5hu7CPz0ovVvTTzF2Ru2SQ>
    <xmx:N1S8ZgB-DU0J_rsnH6W3K5TEO7SKY7bKgPjQV4j3c6SxVfosVekYfKpH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f193847e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:19 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 15/22] sequencer: release todo list on error paths
Message-ID: <f6c1055805d944337752acb70cc613d8d4684d3f.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

We're not releasing the `todo_list` in `sequencer_pick_revisions()` when
hitting an error path. Restructure the function to have a common exit
path such that we can easily clean up the list and thus plug this memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c                     | 66 +++++++++++++++++++++++----------
 t/t3510-cherry-pick-sequence.sh |  1 +
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cade9b0ca8..ea559c31f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5490,8 +5490,10 @@ int sequencer_pick_revisions(struct repository *r,
 	int i, res;
 
 	assert(opts->revs);
-	if (read_and_refresh_cache(r, opts))
-		return -1;
+	if (read_and_refresh_cache(r, opts)) {
+		res = -1;
+		goto out;
+	}
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
 		struct object_id oid;
@@ -5506,11 +5508,14 @@ int sequencer_pick_revisions(struct repository *r,
 				enum object_type type = oid_object_info(r,
 									&oid,
 									NULL);
-				return error(_("%s: can't cherry-pick a %s"),
-					name, type_name(type));
+				res = error(_("%s: can't cherry-pick a %s"),
+					    name, type_name(type));
+				goto out;
 			}
-		} else
-			return error(_("%s: bad revision"), name);
+		} else {
+			res = error(_("%s: bad revision"), name);
+			goto out;
+		}
 	}
 
 	/*
@@ -5525,14 +5530,23 @@ int sequencer_pick_revisions(struct repository *r,
 	    opts->revs->no_walk &&
 	    !opts->revs->cmdline.rev->flags) {
 		struct commit *cmit;
-		if (prepare_revision_walk(opts->revs))
-			return error(_("revision walk setup failed"));
+
+		if (prepare_revision_walk(opts->revs)) {
+			res = error(_("revision walk setup failed"));
+			goto out;
+		}
+
 		cmit = get_revision(opts->revs);
-		if (!cmit)
-			return error(_("empty commit set passed"));
+		if (!cmit) {
+			res = error(_("empty commit set passed"));
+			goto out;
+		}
+
 		if (get_revision(opts->revs))
 			BUG("unexpected extra commit from walk");
-		return single_pick(r, cmit, opts);
+
+		res = single_pick(r, cmit, opts);
+		goto out;
 	}
 
 	/*
@@ -5542,16 +5556,30 @@ int sequencer_pick_revisions(struct repository *r,
 	 */
 
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir(r) < 0)
-		return -1;
-	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
-		return error(_("can't revert as initial commit"));
-	if (save_head(oid_to_hex(&oid)))
-		return -1;
-	if (save_opts(opts))
-		return -1;
+			create_seq_dir(r) < 0) {
+		res = -1;
+		goto out;
+	}
+
+	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
+		res = error(_("can't revert as initial commit"));
+		goto out;
+	}
+
+	if (save_head(oid_to_hex(&oid))) {
+		res = -1;
+		goto out;
+	}
+
+	if (save_opts(opts)) {
+		res = -1;
+		goto out;
+	}
+
 	update_abort_safety_file();
 	res = pick_commits(r, &todo_list, opts);
+
+out:
 	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7eb52b12ed..93c725bac3 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,6 +12,7 @@ test_description='Test cherry-pick continuation features
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Repeat first match 10 times
-- 
2.46.0.46.g406f326d27.dirty

