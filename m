Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901917BD5
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651781; cv=none; b=dytvW+DUXfyUoZ1TyR7QN7gcI+Z1Ejoxr+e0+wvMJTJb9nxkNU9garA0Z0ubwpYZujKL52q8FdtPgcAwTnf4yvksV692VGb2XzBPFJ5fd0ssmd02+YGhH81rfLPcbFSM5hAGmYY5XhQSCQuZQx0TpGwEuVd0fKKm9o4DmMf0FOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651781; c=relaxed/simple;
	bh=ltfm9xLu6ItC0rks+3zNvnGzNe+bg5msMbWMaiRVW5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFEF5c5r4JmXBdqCA/NG6kLdwmPatytvfc0aw5u/GN9cf6C2bUs7d8v/uCdxpfBcj2dm6P1Vdy4VMtN6KBGpW9uapxbA1Yrv1OruocCL218rlS+hwoSJMC0FsoRECeRBG9NF8XEMLDPVNnGJkMN5/DiacAJUy4ebsIqNjODL35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z7HugnK+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rvfze/Sb; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z7HugnK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rvfze/Sb"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id CE57E1800199;
	Thu,  6 Jun 2024 01:29:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 01:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651778; x=1717738178; bh=7nH7QkcpSx
	Mrj8Q7vaunoijEXOhjlP3vVM+tZfZS6mk=; b=Z7HugnK+d6hQly6pYhcxhvSt/8
	F9sW9Cu4gkeERvh4xGpHJlezzwapmyIQ2i7Um0l2ac+QjSOsMdMe/GgGKgOtnQVq
	RhE5UFHdo/RcM/M/aOd/O0xvHbwXma2ozyeM7SWxsF0NS625HcztJoJCjB7aw52f
	MGliigs35KnaAOcV9gGXifqRou5OpBq/EhbudKYIzFCtu0pjWY1n1RC9N//nU/8H
	XlrkRQOcqIAMaw3B6EhxO7X+jfTAS+1gOV93rxXW7/MRzOqtoKT9Z51MSsnW3t40
	iz9oiVHZcd8XXI5SXRlyvcSEyVOvQPMjZp2eS+RbrW48QUhtKtsdW7cCo6+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651778; x=1717738178; bh=7nH7QkcpSxMrj8Q7vaunoijEXOhj
	lP3vVM+tZfZS6mk=; b=Rvfze/SbHRiMHI9OvWliyBLCw1VjfvZBWdIl/In7HXcA
	bXZlAd2hoP3evJRgSwpfYsuI6NJyjMDy1E5dcxebjpyVzsujqc5Fk0U/Njl8lBkC
	Ch2LXMrUaa2xcx/rsShU7xfE46zlTsHWr+lTks+R+3xK6qlkLnlaiapdI6GNOnjj
	4p96pnfz005PrrBwWgv2yBhtvCdlXSMHV5j5Vks+ElZzp+1BT3TkmzEcpdgEuVyR
	iNuLpE28O3toWTEkYxNnMVctnQkR7EbRVzFh8JCXHPTMDAQWR88OM4ZQljIP3pvF
	QDunacvwTNsmmIiKJidRgvu+maIFfXBmylFU3Hmvhw==
X-ME-Sender: <xms:QklhZpPLMVQ5cdUp81tpVBDwGJqbU7O7vrVj2p-03J6PfHisSeSdNg>
    <xme:QklhZr_bkwNrAFACL8V9YdL7BsAARjR1tRBpYbM3Q6VnQ7Ye-PROCEwPLFG4fyAZu
    uBOHazq1AAwrJBtSA>
X-ME-Received: <xmr:QklhZoSC1oqYUeSkvoTqsvSFGt96_7KtJ88bofoDABtHGfuUiPDa8Dl2CVQTvrVYB942wpKAwm7U3pOzNw41nxyTSf2VXb7PU2xK_60zIrqAH-8h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QklhZluWK-WpS-hx0GMRXPCkg72VBVN-BeSE3VlcdabWI2fmgwJm6Q>
    <xmx:QklhZheLzH5xwAi46dmYd9ym539HC6DuePs67ACEsBulh2pfYXxbNw>
    <xmx:QklhZh1_KG5buzHTeyKzgZAwir34uEQVE0XAU7rwkgdxsZoAZLzF3w>
    <xmx:QklhZt--yxB6F_GfNiy8RFJl6YfsUhMM8S_iYHPDgtuumEVXYyKf7w>
    <xmx:QklhZrvTNzXhO-2h_iiijYvAijFZb7nn1vqi626aIBXRomG0SeTNEvPa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b00dff25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:29:07 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 09/12] worktree: don't store main worktree twice
Message-ID: <89699a641d0487140152159b50835e9c4fb28efe.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ci2jLeFUnf30TiI0"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--Ci2jLeFUnf30TiI0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_worktree_ref_store()` we either return the repository's main ref
store, or we look up the ref store via the map of worktree ref stores.
Which of these worktrees gets picked depends on the `is_current` bit of
the worktree, which indicates whether the worktree is the one that
corresponds to `the_repository`.

The bit is getting set in `get_worktrees()`, but only after we have
computed the list of all worktrees. This is too late though, because at
that time we have already called `get_worktree_ref_store()` on each of
the worktrees via `add_head_info()`. The consequence is that the current
worktree will not have been marked accordingly, which means that we did
not use the main ref store, but instead created a new ref store. We thus
have two separate ref stores now that map to the same ref database.

Fix this by setting `is_current` before we call `add_head_info()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/worktree.c b/worktree.c
index 12eadacc61..70844d023a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -53,6 +53,15 @@ static void add_head_info(struct worktree *wt)
 		wt->is_detached =3D 1;
 }
=20
+static int is_current_worktree(struct worktree *wt)
+{
+	char *git_dir =3D absolute_pathdup(get_git_dir());
+	const char *wt_git_dir =3D get_worktree_git_dir(wt);
+	int is_current =3D !fspathcmp(git_dir, absolute_path(wt_git_dir));
+	free(git_dir);
+	return is_current;
+}
+
 /**
  * get the main worktree
  */
@@ -76,6 +85,7 @@ static struct worktree *get_main_worktree(int skip_readin=
g_head)
 	 */
 	worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
 		is_bare_repository();
+	worktree->is_current =3D is_current_worktree(worktree);
 	if (!skip_reading_head)
 		add_head_info(worktree);
 	return worktree;
@@ -102,6 +112,7 @@ struct worktree *get_linked_worktree(const char *id,
 	worktree->repo =3D the_repository;
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
 	worktree->id =3D xstrdup(id);
+	worktree->is_current =3D is_current_worktree(worktree);
 	if (!skip_reading_head)
 		add_head_info(worktree);
=20
@@ -111,23 +122,6 @@ struct worktree *get_linked_worktree(const char *id,
 	return worktree;
 }
=20
-static void mark_current_worktree(struct worktree **worktrees)
-{
-	char *git_dir =3D absolute_pathdup(get_git_dir());
-	int i;
-
-	for (i =3D 0; worktrees[i]; i++) {
-		struct worktree *wt =3D worktrees[i];
-		const char *wt_git_dir =3D get_worktree_git_dir(wt);
-
-		if (!fspathcmp(git_dir, absolute_path(wt_git_dir))) {
-			wt->is_current =3D 1;
-			break;
-		}
-	}
-	free(git_dir);
-}
-
 /*
  * NEEDSWORK: This function exists so that we can look up metadata of a
  * worktree without trying to access any of its internals like the refdb. =
It
@@ -164,7 +158,6 @@ static struct worktree **get_worktrees_internal(int ski=
p_reading_head)
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] =3D NULL;
=20
-	mark_current_worktree(list);
 	return list;
 }
=20
--=20
2.45.2.409.g7b0defb391.dirty


--Ci2jLeFUnf30TiI0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhST4ACgkQVbJhu7ck
PpTcPA/9FDsZt8i252tC6OH/ZIX4YZX2mfhjLXA0ijWACACT2Han/sYHkAzVq+ug
r6vUhgaaOnHf2GY2UrSY4/bbezvIaurwY2mWv16PNpuPSLKnsnyrahbKr3hnLImU
H6WDzZa9YwhtAIKWauMSHY8Td45KJaNPqdYIIVkcrh2QilOSGC9jmFzGC1xxBp/n
V05R8xmh57t7HMxWYkG4En5/I/fc0LW17P8BDqwZtuspCvSoYmU8MK15JGmywYaF
Pdcz60fvVOkMGIte7+BwmBLr/4ImJKTBMz5Rir67M+6zgevLz8iAQ3T+dUhB7ilF
Lv0oa8XeYmg4RomEpaeUKjukKkRgZRvZE81YnAc2oyl0mIds7bmcuJvvcKEJr9mM
Vek7EhfBu48GDE1cOajsLH4HGrqmUG3wQEVgJ+Qs/g9SR7pTiWcjGlC+CnVUlzsI
SWBOkw8nyuAIjjSfmwV6Mz9qprkYyE1hBbBdqf+lwwk1nusycQLDGaT4lk4KSoHb
QMGnLn7ROge4ScTB5neyi2Ye2ORKUtYgOBtQulycGhWOaW5RXgmVx2W3wKeqyaoS
iDgSFBww7eFoS0WF2+/O/RfJznrK7dZdMUf56/nTQOeRc4h0azhRduqKKj2Hd5QT
V6EPkfRxZzyLaUU6rWRNeFZkxKmwfuPxqGM3qYtvLup1j7Z9MnE=
=fUY5
-----END PGP SIGNATURE-----

--Ci2jLeFUnf30TiI0--
