Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234884DED
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407056; cv=none; b=bro27Mb7fdVRYHgFt8UF/iIUxrTrBGdVDvisYBnBCimW4V59ATXnHYZJrg1CDBdrYF+NPtMpZUwKrCvTJjszb81OpMjTMDXHC9Jmnkja52dN1IhpWlLwQHg8zXNgYgNygjAvAT1W6chKK5l+ZbThnixjOarSrcHMPAY7UxFT/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407056; c=relaxed/simple;
	bh=HkSxfCdoU0+D8rl7AdPRT6mgbvvL3+PefBnLqhhF2xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1WqFTNy0GusG1+hZN8cdo4POhspwUjO69E/RxgdHs7NN8tYPTajxMr97ENNLzHfOheD5NxSLhiuNZKCoeNkVQkXkIry0RW1iQH8+JxQhkYkK8llut8PhnD45oF4N+nE5wmx9MC7vOerPW5kpIWyGYfa/uStNm++0zoIPU7mDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fKMtfjXR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FiIHv/P3; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fKMtfjXR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FiIHv/P3"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id A46161C000F9;
	Mon,  3 Jun 2024 05:30:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 05:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407053; x=1717493453; bh=3m6b3UGykD
	5g60tNqaZouN6O85Rhwr2sK5OvzEpMBbE=; b=fKMtfjXRJ8NYFIT8vY8qEkjN+M
	Ayr0d88JSqV4bbpzP49lrSoIz9rjfoUPFoZxNl4flpqsH3emvqFeBurx9QEas+dZ
	j4gdTMxtOSZXPTAlIRDobUtOczrTFQC/z1jIUILjdLKFUiU8QIZz70OLmA8owkWJ
	w7ZPm75e1uQz57X+eeXPU6C7lAmvJ7lmsJG6EsENU0A3bED0TUzwlxFpkpp62dz5
	rv0lQPRWZBQWC4FTej3aZ1b8vSzEcJJjGLhR+C6qp5pjiw5pzHiBEibjGb16+3NC
	nFuwYcoDLqlsNy5CyPt8C5tlUkPpjdoA6upoH95EUzUHWtYaJror4GSANC4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407053; x=1717493453; bh=3m6b3UGykD5g60tNqaZouN6O85Rh
	wr2sK5OvzEpMBbE=; b=FiIHv/P34/9JwoU+rGrf9eKX22u+I9WL1z9CUhk3GU29
	wO/rHKCgvL5wMI30zqeN76vZFTj37nIUKeaPHBS8+9NC6WtWjDwjbLjorc/JtR6y
	s4yFIpuTUmgr9edmeVoEi+eZkbYw5rY6Voi6cnwAoQ7ukDi1zd7PH1MsiZ6pSFs1
	0j1390ToyMSLbTY/CZB75WZJToJepkOidDoaTLCB5f3n0pmQnLqCh6i/SYZXIndf
	nnMto8h4A8UwTM6fGrg1Zxz/2MpIGjeszWOuHkyMwROewq3Mk9sGgxfnxaRqAYqH
	DiHz7IFD1S4h+BXI06eq1lATrsiAv4ot4D/HYxIBwA==
X-ME-Sender: <xms:TI1dZrQfogQJ_V5QQGNu4--z6AezHWCRry8eA6BUyxajVilaZMSX_w>
    <xme:TI1dZsxTaTvg-Fahxrrc28ZRGiOWrb1H6n0T7sdxzcZyO2tNog20wvwSb7aEXIVBr
    lYw8WmYBvTrg6Yj9A>
X-ME-Received: <xmr:TI1dZg1OkgxsmUxkmLZTX2kMljkVjLYMxJYvTeV_ry5yq8EfUdqfD3ixO7HR4m3yQXhQ9oZ30oBI2QY3phuxO5Dzv5yCIPytpzDKJsCYvixQPQVH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TI1dZrBVSksn02l659ktrx7dmnP3h-At0iuYvEEzn_Epuu7ZJ9Ek3w>
    <xmx:TI1dZkhgJrKON-jldAgvgYuv69JLbZaYNAkmM_qNsCmKO8DsJHQqxQ>
    <xmx:TI1dZvpKHghe2qOV5Xy_SXKwd_VkAYFu4LtcOjIhzqC-7ClZthCnaQ>
    <xmx:TI1dZvgZWAl7BmCIOUJw8J8KdYRM0tK-ZhYxFJpEzDDs0kPeri8eCQ>
    <xmx:TY1dZubX8AZxQXJCHtJyokpSxP08dmyU5VWDbBeER7wPbRy8lVXVZavF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 92298797 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:27 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 09/12] worktree: don't store main worktree twice
Message-ID: <7a89aae51526faefc0ccce0a73cbd54aec8e8879.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B5orHugSMKdGz35G"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--B5orHugSMKdGz35G
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
2.45.1.410.g58bac47f8e.dirty


--B5orHugSMKdGz35G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjUkACgkQVbJhu7ck
PpTRSA/9E1NEOI/fpR4ExalDZ15rCcIkAVZV7qBTFCzOUEYMtw3FRyZFAu6ZJuZc
uC74IUhH0/EEnGIwL8KEQ78LMmBAJvA3d242wRJya6MlPYkoe86BkuU/KtgHHAAE
qETAL1SCPg8SqWQz8EDMY4VCJ5Of8mPhzphm2nJJJevXuNwmqW6BUJkaz8cpapoW
18carzzP0u2fuALJkAkXyNWgvEZOQet3/Pk39HlVWaGbMVJkBanN2Te5EobByu9I
cKu394+RiY8MD1bgh9NgMENiF6JZrXH6cgE6kE+9w8AyTVF+GkGrh0U5xw/lOP1Z
V3oYDom4Wl75NONND7QPtrlSUH3vps69tJXT+XiZ231wz6MLC+5j8LFDBaWnkQ1r
Fdt+mKcDqwN/sSdQ9y/lj3q5acoHMhVuZdhA0I/3j+LBhe/0GDOadEPdAfaUxycY
2x4ofcz0ULkfXsA39DnwtVvdWXTWD04Mpzre95h3VO8LnUXe7uJ8n/J36gS7F+Z8
EaH/P+Hm0QpJV+Fq5wzCl3+8hs42tjETR40A6x68A2pDBw+XWjvkEiJnCxcqP/X7
l487G4j5FTins+zrQPXeLy5XUArgiA2xBxYkLJp4MBqaoP5Gm72m+lzDZxq1kA+p
omdiC03bFflwe1+jiyj+V4EBzPknrbNC/OJP8RhyJWbd4lo8Txk=
=wp57
-----END PGP SIGNATURE-----

--B5orHugSMKdGz35G--
