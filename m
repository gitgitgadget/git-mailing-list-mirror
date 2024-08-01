Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04137170A37
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508842; cv=none; b=SrB/469dHUDkjM9Y712f1quBXFNGmkdUcJ7NjaSMuJf+g1w6+yGn2S5A/2YfouMjhtN457cq7SilRGAd7pSgUwQIQGd6NI7l5QN5oZfSTKRqttGUgktz8wBkbe8vwwDYo7pQ3iz2gQcrbm1M4LeFMcLE5BYGqNGK9JOB0fQ9XMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508842; c=relaxed/simple;
	bh=OAUbzsIIPTgEINdOEqY0T+t5n5yfOxlR7yGAvlCYSrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDIYQMnmGc8pKoZGsy+kv2b6xODb7P5kH4SF4htxW0wGUDZt1pVMMPX/5qpS3pZtOWvGyQh3vo4mMgdFUDEKZdgpLkgDbBTCHsQ102uB2yEWfiB9oSs/KBz3OrgLJzUjzTgh6f/iYUKMKbLtjCC16ZHJMSGhek/UfeCznkeLB4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ivr15qCo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psmHp61E; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ivr15qCo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psmHp61E"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 52B07114ABD4;
	Thu,  1 Aug 2024 06:40:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 06:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508840; x=1722595240; bh=osvFIp2dSs
	R/ea8x13yG9yC6tP/BivzLoCuEqWV7udg=; b=ivr15qColbhJFfhTXGols8yB8k
	I2YnVZA1YJAKkQVFn37NMdOO4vueS1h530ouAZi7AJbP/O6se8P7nlaDwYkv4fHv
	bkiTRCi9YO+NGm4PfGlkXqhlccfLzgpYb0V33obXI8vBLT31/NKY1XWgWz3BAJGY
	MTjps1KHpXurm5yFmHnYRItqnUFVSGBA+wgUPZs3D8AeAEcrhwjZPU6QU4gbw5UU
	t8/oosjwIcf0IqBHIwoMbJolXaFhHz9nrmmYQYNr5yybbP3Wui1JMhwl7IedOIde
	E2TUITV73dWBNYrEok7dM04dgJQRbrM/X0czaOxAeceNLgGbyR4vNL4WCqUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508840; x=1722595240; bh=osvFIp2dSsR/ea8x13yG9yC6tP/B
	ivzLoCuEqWV7udg=; b=psmHp61EmMBx0tCgBmjwFj9x4qAwcFxIeQ7wMyba32FF
	52pGr0WfQH9w80VITddY1KAzeIidk9/QC7OfJNl5MxFT+t9PdfMMQ4BxECCEQtCU
	SWivKK9PlLmY4D50am8Bgd9vlgP2aIcTJL8kzELrO5WUuKnhALNHLiMpjNZ+C5Su
	QkMSsQ4tW9K0Lu2Txz3wHinaQgZyYzNHlNBKG++VbU0rc72AvdknbgQCSCd7LgPc
	tD9Tt11PtsWq6W8vS1qWZOPI5MzFBio/VBzpDcbFvkfSYxYjyHWSNdZctTlKL2ZP
	46pbvEK/AqWhUBSy+ew2ckRuXtQOQuuOUnT1b/a6Nw==
X-ME-Sender: <xms:KGarZuPcmyuA_gM_CRXiQLlXCQK3kBe6PSmSJyvtQo7YuzETcA_yXA>
    <xme:KGarZs8aC12rj2EtDKRCr1tlTAqy1SE0ljaBJom1aB6zLLai9xzSYkcFcJYU9RrUA
    10QwZl0MG2tByaEMw>
X-ME-Received: <xmr:KGarZlS8BMh2sIGtCfeeUCvcixmNGp58lHtbXqWO5nal6ugIyqLjUQ1Jh5mpYBSg4oV57z_8tYp8fNPr6gYJQ8dLW9jIy8QzsufsfTdPmePt1Zc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:KGarZusTiyWP7wyonpAWBkG_x1ernVHp0sganKu-Z3ia9t1O8xSFqw>
    <xmx:KGarZmdhBFM83LMiMDN-vOpzqDQBgAkW19c9I0K8JkyezgZd-UOYuQ>
    <xmx:KGarZi2fOua4evHR3htXknibq055-fd64w_IyDWMbidVqZUFQOH2Dw>
    <xmx:KGarZq_FEeiS1uTN9PknTtw8tbiMjf621o4BXJnBkLaBMMle8iAyvg>
    <xmx:KGarZjExzewyYYRgumrKlUQq-1CiXepBeRrKl48I27B6KTTALpo1NCH5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be1d8fda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:07 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 16/24] builtin/rerere: fix various trivial memory leaks
Message-ID: <76d81c8ae1e99d3160a2535c2fd93fde0734e86b.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7G+ArVwQdRp+pxR8"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--7G+ArVwQdRp+pxR8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple trivial memory leaks in git-rerere(1). Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c          | 8 +++++++-
 rerere.c                  | 9 +++++++--
 t/t2030-unresolve-info.sh | 1 +
 t/t4200-rerere.sh         | 1 +
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index b2efc6f640..81b65ffa39 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -73,11 +73,17 @@ int cmd_rerere(int argc, const char **argv, const char =
*prefix)
=20
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
+		int ret;
+
 		if (argc < 2)
 			warning(_("'git rerere forget' without paths is deprecated"));
 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
 			       prefix, argv + 1);
-		return rerere_forget(the_repository, &pathspec);
+
+		ret =3D rerere_forget(the_repository, &pathspec);
+
+		clear_pathspec(&pathspec);
+		return ret;
 	}
=20
 	if (!strcmp(argv[0], "clear")) {
diff --git a/rerere.c b/rerere.c
index 3a3888cce2..525ed6cc1e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1107,7 +1107,7 @@ static int rerere_forget_one_path(struct index_state =
*istate,
=20
 int rerere_forget(struct repository *r, struct pathspec *pathspec)
 {
-	int i, fd;
+	int i, fd, ret;
 	struct string_list conflict =3D STRING_LIST_INIT_DUP;
 	struct string_list merge_rr =3D STRING_LIST_INIT_DUP;
=20
@@ -1132,7 +1132,12 @@ int rerere_forget(struct repository *r, struct paths=
pec *pathspec)
 			continue;
 		rerere_forget_one_path(r->index, it->string, &merge_rr);
 	}
-	return write_rr(&merge_rr, fd);
+
+	ret =3D write_rr(&merge_rr, fd);
+
+	string_list_clear(&conflict, 0);
+	string_list_clear(&merge_rr, 1);
+	return ret;
 }
=20
 /*
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index be3fcdde07..b3f6bc97b5 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -5,6 +5,7 @@ test_description=3D'undoing resolution'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_resolve_undo () {
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b0a3e84984..213b36fb96 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,6 +25,7 @@ test_description=3D'git rerere
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.dirty


--7G+ArVwQdRp+pxR8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZiMACgkQVbJhu7ck
PpTV6w/9E9wfXXGcUD73QS/Z5b4aEX17rGUI7tnyYxCmojfG1QWn8MmfV4hAvwVA
O/10gManSdkgxWGK+Gs7HAYtlIYZWwxj+bdvs427Z99B5mZ2X5H9w4nmToL5wnmD
+mP8H1S3tMC0edkwKSET7zYkF7X4ypGjFiXJpbzbdnxKEF55sGwkcmu1OE1f7Ytt
Fu0VQb8S27MAscVGA5bc3PEudUyTCgknJ0NbaAT1sNRorHNYit6Sr1TE5D2L4r3z
dwGQCdLmIznDn4Ah7qDBfzFU4C7UMLkARxyIFvJdp4C+TfLvxa8MnJjrCay6rJf+
SN5pSBo28pBlgiJngc8cU4XfqSScH3kPP7h7EYq6aNN7aprzKS33Ks2Vckqfmzbb
yWx242kEYEWNmmf5bPRgVxzamIqSax9Sg1eOQWWY7dQPEHbR2QXXChwQa4j4Ym5C
ArE+4nS2XtUEZBPOjDx70l/+EAJVwOVtyt8z36M5qZ0TJW+GB2jQMB//qdneKQFV
LXSX21U1++ucbPVrf/q2YryBajRJDm7EzsK7bAbG7FMNNjr98tixZofD711si2wd
b13rbqW1aW3Ix9JMy2Pu99AWGQL6oBkKasWnLORVet2sp4bZsySYhC1iSR7bfZIG
f0C8lp935Wg+xfr52egycf9bsLfrbyS1BuEhybNJdfSrNqutj5Q=
=CUx9
-----END PGP SIGNATURE-----

--7G+ArVwQdRp+pxR8--
