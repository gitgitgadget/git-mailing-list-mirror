Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF94288A4
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933940; cv=none; b=bgYKFSDZ06bHlJmK3ajyc6m09X8/Fya65xYtdWhiC55Nma5AmlLgQN+107Q5LAiZP+wo8hBdLkOhBNaPro5DI2i71dHGqcNkf/EYE9YkQQgsyWTDbwlKxDGrFGmZYeRTibkZHNIIgxGL0m+Y0+2B8oIwNKoGjUiNFkpZsXSKoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933940; c=relaxed/simple;
	bh=vIgdI9GCHAfs87nVt4MpL0cfEOwm+VRU0KKsTyIQsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pprAL497W1NTVAq3m++3Dgo9h7O9urgFuKdoi1iMOs/vAYRFbUco5i6lKkj44BS5BKl5YhNcYdgYdTZhDta8+bG1E0gjKOOoMVHhs5NyeLbLFqmk2JFnZhTxcnCpGqvRArEHL85jE/uKwq7o68bADuXlRoAw7esWHLJNTvlGUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sWYiFa3K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKhuMlAk; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sWYiFa3K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKhuMlAk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1C9661800178;
	Fri, 17 May 2024 04:18:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 May 2024 04:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933937; x=1716020337; bh=V/2MKTzUMc
	WtuDJ9Es0BrDO2SiaUQCLsv2RMkAVk2Nw=; b=sWYiFa3KhpD5xZjX4sgEQ/kw4C
	3Pf7RNFd4Fd/axdX0QBEL5pClXPay5xMYQ3HwgRdJG/5pxkDin9Wnm+gPUCd6tR4
	2+yizTP0sY37GjaLClzMUJM0aXldFdPnYIxG9SxW2ploxYHW50ok8UbJTQ6Caasu
	D/gKuFgqJGh8RffCh3kDMFVVouFNkRUUEMM0D43fIlJYSy9MJultN3eHZf4oSC+V
	2ZML3UGJNMcp/D6V851XVwgu+kX5gMCm+06xU3xjyuVEmj89aB3KTZF7ooJbNT1w
	1mnq2ktBwuBf4jYGHCIpezCnqTK7o5fWNYy9yJswOo1x5MGaaNY0FU+otqhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933937; x=1716020337; bh=V/2MKTzUMcWtuDJ9Es0BrDO2SiaU
	QCLsv2RMkAVk2Nw=; b=MKhuMlAkheYnLueOhneTIs1dzvlKi1ydgJ7LdfwTIgWB
	sQvXfqm6fRC3WZ/zEQgFKTx1B8LJHxm2anEVp2RiJb3JX9fxsbLCDNs4TRVO3OMK
	1UqH4wezWzqtM+3WfP4LhHKNm4ZutI5VgM5YWky8pkZM9OkoTa1YVtvfikxktMcv
	nfHwfQd6J9W7/w7rUEJrlzUewPb/dRIUAOeVSPOibE3UOqm2xfKxYu4Oo/4h7G5b
	oJc+5fumH04iAUAnZiegjsmeFzjkl/Jw4nGjBEhlXVvRIGDMmlzFY46rRE2IrKu0
	7kBjLVRFwU9/7TGZDT8ht5nTboxRHx82iXMIDlR3JQ==
X-ME-Sender: <xms:8RJHZsW1KWOTQGQ2pBhbWG0ZFhRJ57_NdAJ2JBdDdx-ba--rSo6E5Q>
    <xme:8RJHZgl_o2HYJSQmwE-d6K0yPRnAB7L55N4mc7qG_iR4P8_yKSuiiRxi8ofQq_-st
    q0cayoBLVDMHB51zA>
X-ME-Received: <xmr:8RJHZgaFa1i0yEAzbg4-66nGu8hpFGbtOqTtVEv3cq2eByydGLZ7R8Hd8taisSgHS8WDSaTumKtnMngSmU0c8YOrKqUVgy_XPiNbD4DhC8eqpQxP_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8RJHZrVztlnuzC-f53rYLwXJykmiBqGgf1AOnrt0fG6SjCOoYV42mw>
    <xmx:8RJHZmmmw_uU-rg3oWWslzu4WUSLAhNii0DOtvU79lSIaIrhd_fZ0Q>
    <xmx:8RJHZgfNgvFUl26MRBznjOlKSsqDM4ZRtzsJNireBGExmGGn1nOnjw>
    <xmx:8RJHZoEn9992fIVcxH3d50jzt6iUjtAiRK9CGWq_3gUay_eeuxz15g>
    <xmx:8RJHZogs3z98iEPxfjT6ddi28oJZur8JJIOLNgyHnyt8dZ5PFkk_czWj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 677fb25c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:29 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/16] refs: pass ref store when detecting dangling symrefs
Message-ID: <423d7b3fb65067fe381b6654e74f28da83e470bc.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mf47I8iSzKsgWaFi"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--Mf47I8iSzKsgWaFi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both `warn_dangling_symref()` and `warn_dangling_symrefs()` derive the
ref store via `the_repository`. Adapt them to instead take in the ref
store as a parameter. While at it, rename the functions to have a `ref_`
prefix to align them with other functions that take a ref store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c  |  3 ++-
 builtin/remote.c |  3 ++-
 refs.c           | 40 ++++++++++++++++++++--------------------
 refs.h           |  7 ++++---
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3829d66b40..3df1c0c052 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1412,7 +1412,8 @@ static int prune_refs(struct display_state *display_s=
tate,
 					   _("(none)"), ref->name,
 					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
-			warn_dangling_symref(stderr, dangling_msg, ref->name);
+			refs_warn_dangling_symref(get_main_ref_store(the_repository),
+						  stderr, dangling_msg, ref->name);
 		}
 	}
=20
diff --git a/builtin/remote.c b/builtin/remote.c
index ff70d6835a..c0b513cc95 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1477,7 +1477,8 @@ static int prune_remote(const char *remote, int dry_r=
un)
 			       abbrev_ref(refname, "refs/remotes/"));
 	}
=20
-	warn_dangling_symrefs(stdout, dangling_msg, &refs_to_prune);
+	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
+				   stdout, dangling_msg, &refs_to_prune);
=20
 	string_list_clear(&refs_to_prune, 0);
 	free_remote_ref_states(&states);
diff --git a/refs.c b/refs.c
index d705add3b8..48323dd28d 100644
--- a/refs.c
+++ b/refs.c
@@ -447,6 +447,7 @@ enum peel_status peel_object(const struct object_id *na=
me, struct object_id *oid
 }
=20
 struct warn_if_dangling_data {
+	struct ref_store *refs;
 	FILE *fp;
 	const char *refname;
 	const struct string_list *refnames;
@@ -463,8 +464,7 @@ static int warn_if_dangling_symref(const char *refname,
 	if (!(flags & REF_ISSYMREF))
 		return 0;
=20
-	resolves_to =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository=
),
-					      refname, 0, NULL, NULL);
+	resolves_to =3D refs_resolve_ref_unsafe(d->refs, refname, 0, NULL, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -477,28 +477,28 @@ static int warn_if_dangling_symref(const char *refnam=
e,
 	return 0;
 }
=20
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refna=
me)
+void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
+			       const char *msg_fmt, const char *refname)
 {
-	struct warn_if_dangling_data data;
-
-	data.fp =3D fp;
-	data.refname =3D refname;
-	data.refnames =3D NULL;
-	data.msg_fmt =3D msg_fmt;
-	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     warn_if_dangling_symref, &data);
+	struct warn_if_dangling_data data =3D {
+		.refs =3D refs,
+		.fp =3D fp,
+		.refname =3D refname,
+		.msg_fmt =3D msg_fmt,
+	};
+	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
=20
-void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct str=
ing_list *refnames)
+void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
+				const char *msg_fmt, const struct string_list *refnames)
 {
-	struct warn_if_dangling_data data;
-
-	data.fp =3D fp;
-	data.refname =3D NULL;
-	data.refnames =3D refnames;
-	data.msg_fmt =3D msg_fmt;
-	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     warn_if_dangling_symref, &data);
+	struct warn_if_dangling_data data =3D {
+		.refs =3D refs,
+		.fp =3D fp,
+		.refnames =3D refnames,
+		.msg_fmt =3D msg_fmt,
+	};
+	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
=20
 int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb=
_data)
diff --git a/refs.h b/refs.h
index fa1f19464e..56d9714293 100644
--- a/refs.h
+++ b/refs.h
@@ -388,9 +388,10 @@ static inline const char *has_glob_specials(const char=
 *pattern)
 	return strpbrk(pattern, "?*[");
 }
=20
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refna=
me);
-void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
-			   const struct string_list *refnames);
+void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
+			       const char *msg_fmt, const char *refname);
+void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
+				const char *msg_fmt, const struct string_list *refnames);
=20
 /*
  * Flags for controlling behaviour of pack_refs()
--=20
2.45.1.190.g19fe900cfc.dirty


--Mf47I8iSzKsgWaFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEuwACgkQVbJhu7ck
PpSRZBAAhy1agOFBXCvx9NXlbq9egI7wBhfrBVPx4Yub+X1HQ0/zGEc6NTpoYatF
rmsvC9lrTfg2KLQhm814nCyWdFqAUzgb/OB75Gda06+mLvWNmbU6nEZiPSSlPRbB
1oG3mxRgV2KgtHT4VYR2jcD4oDOhI1qz84sFn9o/5421TkqjoSaFttQ00i9nk1sJ
Cnpxekx564p9hvzvdrEWEe9gxLN1/qCSWmwOkAD22e8YKduZaCvH0u3TvBbQvvA8
tBs+boMmOlpA1fzpvM6LhMcmLbnfRbXhflATKQRrZUH0ziVDfboksGOXOt8bdr5f
qmVQWEkCNa95wsbXXwSDce8wdg4+BFbr/fyEFbOpiANAsmZMEQz3P64HjZCyHmM1
LvvHJq4pEjCKB8cH8sdc9uo3FUM6W7jidv/LIyAmgLI63gv4GgiXk6AL7vC5J1oY
62kUQ04k/iiCiQIMdf7oZZtGXh845gnzY25mGLbo6RxwTqXw4+6GlqxZR+rSVp2H
ePH/Ecn2yMR6iChipaHooXX/rf6cHx8r79ZQ2SYw19Mn+iDon3iWNFYnGiQCpW4j
IGVED1ZNXtux4car9inH8pZTzXIa0X8w2nfAL30O8gJYZHrLXgb+52D2jwW2slC7
K3Hpmk0WPKAK6FkPf57e5+AT5TmPorT0oLYfxpG5ihgNRG4wWck=
=/PX7
-----END PGP SIGNATURE-----

--Mf47I8iSzKsgWaFi--
