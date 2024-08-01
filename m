Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F5170A28
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508863; cv=none; b=SYMFgXivSG52IHobTLK6Zu4uN4d7bwFxIaUHWjVloJPCx9IufFZpg6lwzmaW2XkdtklvwFcZjqBxx2mZTL181wEon559xIa4jiqLGEzE9qSu3NyJbzhbms/WS1GAlnQ5pEJSohMwTTt3Uj6gMHc0VYRvn9AFdavDLb2AaZWUynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508863; c=relaxed/simple;
	bh=the81HxUmoAVHf5JbMB32UcDmpzJ/f6f6ORfQW/KCqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tax9RlJHhqXocGriOMlj+noedkiucqvul1CLZx09m7cZJxgrIOJW296C48utvd5ERK67j5FBWtWCA2LNQgH1tUXNRR12R4dwOmxqceNllsyTjpD50HzaJ1pZzr9bFeIbiCoP0Aki3dxBca8TyOyl4drdxDOzOnrT1Ou2gMj20To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jj9zlveQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sYMmMkUh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jj9zlveQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sYMmMkUh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9E761388060;
	Thu,  1 Aug 2024 06:41:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 06:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508860; x=1722595260; bh=pfbo+hNIjJ
	Oa1RRetvGydDVX1nV0SUgcmw3J9gYkWuU=; b=jj9zlveQfwerEyxHZgkiOoay4K
	7fE0/uJ9+osXG9uJbg3WfGHqQ1itEMofOf/8z5AAcVFvSCt6Pal4pktsSVN3oiZ9
	2sAYxFatqZAnkrPVKTNSZMG2DhQGUeKjKR7M1//Syu7zTYz3m2JwtNOcyv5oe6W8
	R8Loup0E1oQcHENXyd3pNCqT23BpihG3+QjCaEZJ/ZVVfeJMvU7uL4O4uEZsKvl9
	xuIsk4N7S2ZsnHl7+rbtqyzaq+/pLwZ8MTaR46N2kj6OTHySRAb0I8iUHpXQMfg6
	dpHnsjB+6HAWSd/XTJSvij9I3jdy1CZdamMXKLgDAQJYyMq7UReTeHppZICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508860; x=1722595260; bh=pfbo+hNIjJOa1RRetvGydDVX1nV0
	SUgcmw3J9gYkWuU=; b=sYMmMkUh4BV6iZD4bSfJz9KQx3kgRY/Jz6cg+kWDVZWg
	djAhFUWt04OYIviIULDsUdqWVi1ParercUqX2ZWohuTTwub8ByoNtqbrwVDKGJ/U
	46YpcHaveBJopemKpVKFYTqry0QD4bx95nC8ZSpeKnwfzSCOiR/HvoQa4BvyBEVk
	Zxp2j3FmlRGaOQK41+1O7bL23mubBz8y3dnBgP7yT5MnIAhT2VogSR4F7g+6ccNK
	C9wytEJzQeH4eVVpmXPpqi9cZ74GLb0HyjqAri+QHj+0B+EdbRvMkomKWabyvplV
	WL3PgO5HSMzBMbghUXB0Q7EUfCIw8YgKrXSCJWfcVQ==
X-ME-Sender: <xms:PGarZv1t9v8_sTBqPWv2CaoQBupG2qM_xrGT1wNwYKtueWg1iwsTUg>
    <xme:PGarZuE-8HVloPDdDVhCLCI6f-44scjNat5M_xQjGl1bH4dfO3ns9kiwbh71UxIXV
    H7UyVfjuXYboHL6Gw>
X-ME-Received: <xmr:PGarZv5DlRxu7AD7QlN_eta2NkHt5LD19C1sYVeEaZj3Dm9k_3PMPlHUD_-eTZ8JBMFSBcOK4KolIF98j71LgmLD_pYTf0Ehb8_Q8r2O-rDNM30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:PGarZk2Tr30RnSPQOIco_NgrEDA3ou6SRmSYuKIysQqnRpROHfng1w>
    <xmx:PGarZiGqWA8BHSmpiMMMU0nExSZ4hYdRuxhjaq8rUHdP2ZlykNtXDw>
    <xmx:PGarZl-y7CYnsUsXBRduXf_XirFepQog8D4i91QlIU3xrAje-odk6Q>
    <xmx:PGarZvndOn_x3oeT9oDw7NOShFgC84VA54UPSZFyqlOMd-PvnzGxvw>
    <xmx:PGarZvMyucC8Fg3T8S-ZikK4AEJWVGVV22x8r859COmlifdZtxKOZnBh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1ec928ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:27 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 20/24] t/test-repository: fix leaking repository
Message-ID: <eb58826b146c88654ef20ab5c28948ee027b4d25.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mDHI7J0aO3L7G4+O"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--mDHI7J0aO3L7G4+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The test-repository test helper zeroes out `the_repository` such that it
can be sure that our codebase only ends up using the supplied repository
that we initialize in the respective helper functions. This does cause
memory leaks though as the data that `the_repository` has been holding
onto is not referenced anymore.

Fix this by calling `repo_clear()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-repository.c | 4 ++--
 t/t5318-commit-graph.sh    | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index c6a074df3d..63c37de33d 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -19,7 +19,7 @@ static void test_parse_commit_in_graph(const char *gitdir=
, const char *worktree,
=20
 	setup_git_env(gitdir);
=20
-	memset(the_repository, 0, sizeof(*the_repository));
+	repo_clear(the_repository);
=20
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
@@ -49,7 +49,7 @@ static void test_get_commit_tree_in_graph(const char *git=
dir,
=20
 	setup_git_env(gitdir);
=20
-	memset(the_repository, 0, sizeof(*the_repository));
+	repo_clear(the_repository);
=20
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a2b4442660..2916c07e3c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'commit graph'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
=20
--=20
2.46.0.dirty


--mDHI7J0aO3L7G4+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZjcACgkQVbJhu7ck
PpSc/g/9FM9HcpCDOd76phm4RTNPaqFpCSTmh0taAOp14y5rPtZ8ezwHmzA/TLqc
uQTnGKKXvrAyECsTOptBMtq75c+O/IbqB1ESrFU8HeLOdjnAZ2256INtGielIrQf
iTdBKJ7aXKdGXB1+BcecMedOJlyeMUjWm06G4baiyGkmSBlL5YetgTByamsPWemu
VAGFv6CkCI/iqxaPwVGTGMm+Xq2RVUpHIhdvevQNBiAFCo3Ydf/abYnUXmw+7RS6
VzVVf7rY1FT4JY83gKMbApaAoM9tyioB7FaoJ1FgC5jWcNfVb1SL13bDRcT2Jm/+
sKj1+4ikayHfas+DCaDtjqDoUjEKaFSfeBXNzaFMJDEuOd/wCyes/bxle/4m/pG6
R1geyVVxgps+vMK8X45lrMkHovjlteOvUn/GDeS5bo9hfIpJnFX4KFgXP76H6zW5
xyFiMUdSv2HSGsjlEzZEKKSiFiSRNwHYt2sISpmKk8/Z28sdBkhVf5hJ8+QCiVeY
3BHB14HX0pykGG9cfNbDSo1IaWOLFbcQAtdY9aZKuDHJfV6hihMb/cFnlc8bFdaL
sYWYR0bbq3dNaZXHaxazJQEe5GHx6bbf80j4okKBhmrJWWbv+qJDxiNDw6Idok4x
ymCRVnadZnjlQbFNgQ+bu/yNEHjQyp5Io2MF7OyfNCUhiuJRIEQ=
=yykR
-----END PGP SIGNATURE-----

--mDHI7J0aO3L7G4+O--
