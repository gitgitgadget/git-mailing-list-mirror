Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCAB18A6B3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122307; cv=none; b=HwJjoParzlUTvAltCoBO+uCYnI1MzDGLkUod6ilXKuDxNSfGPzw/fs6IjugCZnU7ZdgM9zAQakv+n6dN0Xg/s/fdIKulkTRwX5QWaoprMKfRAxn18VOpbZkO8j8q25se9q27CocTEHNx2eewXb5HTG41ZotMwP+dJ7e87tPLBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122307; c=relaxed/simple;
	bh=nC6TpkPJwmq473N1Bj2Wjb1MBxRxxFpWUJ4F+ywF50s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUPT2WOoLGpEfXzFsGV19ayPfHq7skk7dGaX1GRD8ChgQ+XAnQ5TCSewx+LiUiCOZmkQa8+lbUpz3x7pRshx9R+JSizIHRyrs/h+YDnb4RsdKjHxH/gGylBWHt6WNE2X3VJy7uhJZCUbzMrO6XJI87UY9HBRWefSLNZvLCBfFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gmKaQrWk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nd7YVTvC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gmKaQrWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nd7YVTvC"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id AF4B7138FC78;
	Thu,  8 Aug 2024 09:05:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122305; x=1723208705; bh=DGQBoweVC5
	9gm0Ezuyk6sI+AGLXmhsdKVfrzF8iu7V0=; b=gmKaQrWk8njXWRyOYaJh4k6KS0
	gehhaJ1RBa5Ds/xokgJeMYJFiw8s4GUe13mmBinDTvlL706b5TkRWn7BtehSpUf5
	ygwCnAqZEjdY0dvMHd51vicw1Npyzv4ms4DH94u5uuFqpErigDIGbmbfEceqxnw7
	1+rfnvXQMDYNWsLxmlwz2Yakgtvxp/TcUViGas2jCdorkyKZ+UpHjTMJkOcK+HMa
	IaEmCneMNh0DOkuE4ecfyrZW56OBhEgQB9mafzzWHpudb53ht1CM46zM2F+sxBdf
	Vdgjr0GhStAP9fC6vRGpwwewa+tuYSGL2mw2s51N7M7aXdAlgTmFKfmY7kWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122305; x=1723208705; bh=DGQBoweVC59gm0Ezuyk6sI+AGLXm
	hsdKVfrzF8iu7V0=; b=Nd7YVTvCcSOj/dKho58hmMjoHPWtOHAZA5GICEarnPWY
	jFodakRkitMN9kXORa+aIEQfrTliI3DgfkQTR+GtP8W0KJb6LVasYb6DfigVW6kS
	1IEmlJ8wD+7qJij1K1CkuTJYqFlwEMeZqMthFmu2VxGMlIDzo037xU7LQdOxpBHV
	jK/Kxv0wn6X2sylCrNiQw6gi45MRFS7/u7Py6oZlTZMF2V+9kFaJYdUFL/9iYBEx
	YlOTdrPf00o3VVVBJlmPyfEFrKggU1/PkM0bCUSDGoBc4NWByVQ1MaWvJRcspqiI
	zeeFLWjo1Rs2X7jMuM+IPIDjNIYTfQY6Eir2lhGd4Q==
X-ME-Sender: <xms:gcK0ZialtZyJ37nQd2HR0utJhqwMr2ZN8NuFLaco8o4Sq8T7NsFYfA>
    <xme:gcK0ZlaRtWYO73ZtUy9dSFTVFkQPSkLRR1YuHl-p7h_BQqUYMLHh-6joPe3UnNqTt
    UK6P5jwB4DrFKqsmA>
X-ME-Received: <xmr:gcK0Zs99imJDFM-1Sa-4oqVvbYXqn3BgBJ6StBIvPd7pfNLScUSiX3RpOz4vmcOzbZX6VJrA7bYvENrcIc-qGsBh9a7mQT42hfs1r1mLDy-7TOv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gcK0Zkr3tiMYBZzzYVuGkXssySXygU9krtE2ckrmNJCv8foeWDujNA>
    <xmx:gcK0ZtqKj_eLNKLpOs_Hx7l20Cgfu6C2FnX-kv6tphw0qlG4xYLXlQ>
    <xmx:gcK0ZiSXvOznhCeqYIzrg1NKcj1cW8eYW3oCkObShTGJyzb9z-drTw>
    <xmx:gcK0ZtpD5Du_GEv1X9QDi7qQOEn0gLfIVXGiC0ufeTGyKPKhbf0nFg>
    <xmx:gcK0ZkU9C8C_aUa4prahq-ePo58dVzZlo5NPWahwzkdRWFDWo8M9VSQR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a36e229b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:57 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 07/22] submodule-config: fix leaking name enrty when
 traversing submodules
Message-ID: <762fb5aa730fd2c0af21f8f4a4632cd9ca6ae35b.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Na4pRZHvjkF7oohT"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--Na4pRZHvjkF7oohT
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
2.46.0.46.g406f326d27.dirty


--Na4pRZHvjkF7oohT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wn0ACgkQVbJhu7ck
PpQ9MxAAqwKVNIGbTSwKb4bLg8bYfhZthIYBR58Lvjkk/GZBPxf87SLnJfNxUumm
v5jFeUtaUdvfQ04KiRSg8xfTeoTHuFxn62HjXgW1PUel2q3o3C6PEUid6Y5B82aq
OPdJd3P2ig7J204UcQn22syCpHBqQVar0vL+khUDy8eRBdLU2GdYeHC0Jbrr1iWP
MDppXjK9w53I2BzxO9Q1zgYeHiF3F0f8YPeHNPem1y/DNl1Gw+a3oluOh/qCGhMI
ERxy2WsRRnnXS8Zx2gWg5eJGxIy8LLPtlaQYUwkt0JmFMMcyBlJWoHNuxeehjEaV
H++fBr+tj7sbgEaF+IwhisTKOQo5wxxBb9dTac451+QEs+WOJsV4J+nHpUYBm2to
QaLHNzBaY7PMb9T91yLfJmV8ID5P+fP8yYIuig53WMNOHFPr5UGK+X14Z5WMBywR
v/V636xHzaZMjIHQW9EXGN/mKObs/It3Ug9bMv5yFvnaidadFWUutMU26OBelaww
PoSqn1voqhOXkbRk3Ub9b7/HxGnrpBp2xCScC4Y/GWOy1DPFb35I8E2OpmiJastO
ZvJJYMwF4M/lbbwu0lIgPdGtXOba/spPbsORRh53t6Ak1ZIO8t2kyHFmgmfJfYL5
UQybTj9jUWvuPbQwhUj3oITg4PZOym7BjvtTNC0iXkIZ0aGI6jQ=
=+EO3
-----END PGP SIGNATURE-----

--Na4pRZHvjkF7oohT--
