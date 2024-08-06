Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BA1BD027
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934812; cv=none; b=SRnm4PWjm8eeCupCGoh+uSfLu7kwbSJJj/p4H3haQiVUsgT1xQUzH5iGVbGrft3MReq6Ym1R9btGa1c2Jg1lbqhJAjCm4+2YMSC6x3G9BFN3ZJIgAtEmfOfccvsJk6Z1KBtJqSDiXkN1zIVJ+vdaN5MSHZehHiljz6DMVyNwpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934812; c=relaxed/simple;
	bh=6mkLbZox9A+qRx6jFBZAKgMCt8KW9FTmgq9C/3LGyE4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDoiwLISwoG2vDwzrlNOwBmV6gzpuYH9H4Uzt7RJUDawZtQqzBMD/1uwR1oUGbzXDFM8yl64nqe7VtuiToVKCVUAxP8OepYeaNBktXfyNCfVYQZyFA7m7JTPJ4c0SmldwOAhz6LydF18nVZ39bIfwt0MpBabSUvYHpXM5LQXtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NphNCTCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DRi0M8Ww; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NphNCTCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DRi0M8Ww"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 48A91138FCAD
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 05:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934810; x=1723021210; bh=akMqEqfqyy
	H68qd/7gOFbzCgXhnrjiiTGmzEmrZXPhg=; b=NphNCTCrUXhg5ux7ogk5baZm2N
	kO7Lren4MKHT+6yLQ57pVEJbLaCgpC3zxJpPPEaA4kte5EZKN/e1dLl70Nclvcee
	y/wMlq6W79ltqtYz8oQdzhIbyoKaLT2c/XB6Tq+U1/E1SwatXuHLMdXFc/gAp36t
	bkTIRFsT6e1rvF1wZdYHEfwfWK7KA/heSIJ7+qTZ0DXOGZtE9p+QVevS55Lj4X0F
	jQnEZsEKh8zq6qUgg7RM04KeQ8odGjk1pEGYdMSHNwUaSXYBNCvfPelDrpNZLbHO
	+dalDRGs9rIu25gPpC77GrmxLvaw7NOCOYmrvgKYuffeCvqePO7NSwpwdbfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934810; x=1723021210; bh=akMqEqfqyyH68qd/7gOFbzCgXhnr
	jiiTGmzEmrZXPhg=; b=DRi0M8WwdKEvHIvZ1ywn7agMxla01xmO4JhlC7A8C08t
	9kXsSCSJAG04MB1sWxYHI6R08Ws/RBllInQ1+Scl8l4J9EG1EPkamWXfbUcC3PRB
	PJuHurUA2CE5xFVvJzpPL4WERmZCi32QNjW9nUVhMF8rRo0d6odJmtG3M1Ufx8Ef
	bua6r6fVwkbhQHJGDnX6AbdyZseoILmDruwT2xtsibLRa0o4kspfJRRiN3Gg0+3f
	BqTBvz16dBsAk4cF45gB1qAy+YEp9skCdCn1FSgepm+39KwYwAALDFzD6Y773LgW
	7mvJpHUxEdf0wvstK58EXAY5DPYUqIkCpB8wk3Mexg==
X-ME-Sender: <xms:GuaxZtEg5PZMipZg8_xd4zA1h23U3nsIm6SDnw2lmbHoJOnjDWoNqQ>
    <xme:GuaxZiXbP9tu1qjE33g3RzFH-N-eh5b0SecaRsBlZOn78OUkuMfKTO0n37q2DmdoH
    gMRMV86_Wr7PXFgDg>
X-ME-Received: <xmr:GuaxZvLkj8yjPDPNAZI0RpLQBUFfp8sNiUTNDwF0bFNFtY2i4rvGtcxukIklK_ix7qQD2At3XMsO6QNfokXuu0MrvtYnMarN4pC7BkoTAU7d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:GuaxZjFT8ZBewkseZI4DSbgbuhIvf6luxblJyNIk6xa9txNh6W3iCg>
    <xmx:GuaxZjU27vLxcaLwPLNVb9Fi55q_s0jsmhD51NDzx1Cw00H__h01kQ>
    <xmx:GuaxZuNO4-M9PmQphLiKtLGT0DBCZDhzAAv_Ctgj_5wwjuGwv0iz3g>
    <xmx:GuaxZi0aikYzUydCcVtBlnb27UYuuH-yXxt9Unj4CN_INDQzScDpKw>
    <xmx:GuaxZqczMyICsYU28ePQzLqJjE-dNACz92YHknbUBesLBvGhFZ2wa2Ik>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bed1b99a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:06 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/22] submodule-config: fix leaking name enrty when
 traversing submodules
Message-ID: <03f699cf39ebbbb2bc3ba9acaa72415efda4bbe3.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e8cK3DvtGuVO1sfO"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--e8cK3DvtGuVO1sfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We traverse through submodules in the tree via `tree_entry()`, passing
to it a `struct name_entry` that it is supposed to populate with the
tree entry's contents. We unnecessarily allocate this variable instead
of passing a variable that is allocated on the stack, and the ultimately
don't even free that variable. This is unnecessary and leaks memory.

Convert the variable to instead be allocated on the stack to plug the
memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 9b0bb0b9f4..c8f2bb2bdd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -899,27 +899,25 @@ static void traverse_tree_submodules(struct repositor=
y *r,
 {
 	struct tree_desc tree;
 	struct submodule_tree_entry *st_entry;
-	struct name_entry *name_entry;
+	struct name_entry name_entry;
 	char *tree_path =3D NULL;
=20
-	name_entry =3D xmalloc(sizeof(*name_entry));
-
 	fill_tree_descriptor(r, &tree, treeish_name);
-	while (tree_entry(&tree, name_entry)) {
+	while (tree_entry(&tree, &name_entry)) {
 		if (prefix)
 			tree_path =3D
-				mkpathdup("%s/%s", prefix, name_entry->path);
+				mkpathdup("%s/%s", prefix, name_entry.path);
 		else
-			tree_path =3D xstrdup(name_entry->path);
+			tree_path =3D xstrdup(name_entry.path);
=20
-		if (S_ISGITLINK(name_entry->mode) &&
+		if (S_ISGITLINK(name_entry.mode) &&
 		    is_tree_submodule_active(r, root_tree, tree_path)) {
 			ALLOC_GROW(out->entries, out->entry_nr + 1,
 				   out->entry_alloc);
 			st_entry =3D &out->entries[out->entry_nr++];
=20
 			st_entry->name_entry =3D xmalloc(sizeof(*st_entry->name_entry));
-			*st_entry->name_entry =3D *name_entry;
+			*st_entry->name_entry =3D name_entry;
 			st_entry->submodule =3D
 				submodule_from_path(r, root_tree, tree_path);
 			st_entry->repo =3D xmalloc(sizeof(*st_entry->repo));
@@ -927,9 +925,9 @@ static void traverse_tree_submodules(struct repository =
*r,
 						root_tree))
 				FREE_AND_NULL(st_entry->repo);
=20
-		} else if (S_ISDIR(name_entry->mode))
+		} else if (S_ISDIR(name_entry.mode))
 			traverse_tree_submodules(r, root_tree, tree_path,
-						 &name_entry->oid, out);
+						 &name_entry.oid, out);
 		free(tree_path);
 	}
 }
--=20
2.46.0.dirty


--e8cK3DvtGuVO1sfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5hYACgkQVbJhu7ck
PpSQjQ/+IzuULgv1FnngUoCft8bErjFE8ULz7cJ9Cqq5cfP06DpaTgyhGfKGaKEt
NKWWrmhddDDG9RyvJ0DJj2QbSGMcOVjIakmWrgH6g94ab3xKl3qGWEXl7VnNrvIT
128PvIaBXfY1ZF3Qd4Fv6i6geTJEWV/j3JTO7WdsE2KqzJ2UBvu+B68DQP6w1qxp
Mmiz/YNuGB1OawWXfq3giGyCBucTBfHJt6q3UY+XFnbhdzUUlzxpFrU+Tt608clc
iDPBkS7eoGLqWtM9EWBCBgvwYYM7F69zvs0hYcpi6l0POWrJqYGTcYLwEstTRKJz
IdqGf8mayZhzmz7mQ/uMdZmoaA1mJZwK1NX6ucrr0YA9cwd6sXUHbq+0UjYwDKAX
Kv3q3TqlC/L3NFYG+/3PlsLwT4kw2UflAhfpskWpLAa/PZ1mBGZH6UTP+1aacty0
rmcooB+svB2qav0a5pLZuNDG3MWZls4dnUr97nFO32u++UOK305dpcRNSqSTjI7/
r6w0AjCTJ7YmibcAP5+ovFxmJbF1X0XTnHDd4TKrPgdj1T43+KZW742GFhgehBSY
P+V0bUQtPai/EwQdV/e//Ir3+gHFXhRpWrHIPH9QPvIX5mrTNsuwgYG1+EycfR6m
wbPQZ0/s9TZwQniVOlhQIADjP2LsDCXGpnRItbD54mzTPD1AlXc=
=xR8r
-----END PGP SIGNATURE-----

--e8cK3DvtGuVO1sfO--
