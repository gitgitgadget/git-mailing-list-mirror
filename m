Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E8161325
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330922; cv=none; b=quzm5NOBACiLaf/QW3X4a/i+NM5MNkgZfwzFYzVYy12+qdYDtPXl7Elus2LuV9dyj+0AIQ+COHTLbT5AMd2Tqq96QEEO3S19hClTOAlf9dEqeEeC96SE8Z3q9lTkTIVAYoL0XmXuitI2EZNInyU9FXU23smTh5yyzCmiKyrZfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330922; c=relaxed/simple;
	bh=nRREW9CXSvItZ/sCqa7eKyOUGDca84oQOC30NC3XgHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1hHm/56upffOU6mD+40SWeZJ9uQIquox2IwS67nG+EiA79gUZeLNs1tTrilPXkeKdZ2AjuiZC9XYhHTA0a6L0ReENwZ0FeU7hgy4RtwLwpHMcgnv302HCU7MZ5/KXLuoSEE8YT4XEZQQkroZ0f+Gw6CjydHUagCtGOZ2y52xYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AtGk+wdk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZ480gdE; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AtGk+wdk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZ480gdE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 23C221C000F3;
	Fri, 10 May 2024 04:48:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 04:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330919; x=1715417319; bh=fn34Ya9O4P
	ObdxH6vSmoW26D55ECB9lnUhi2Vq7VXw0=; b=AtGk+wdkuj6rRnWQd0GHH/tdwL
	ctCSZI0KMejj/n35HuxeSDFmTqgXLwRJFp2Qun5Q0+oWUtSLMyrZcOGh94ridgpF
	mPkLsqUiG2shkcqaQyYZPG5UWT+JqsJZnS58utg1UXJLoirmkPvD/621zl/iRtuc
	USoe65+SDKm0qHMQnrIydujXcKi6jch2KJI+/eLoTzqtZQgd+K7kPeQJc2aGUG5E
	HrDEPJ0mC5mnlX5lSa6QXQDkzizUzQeec9Z5x40Ajwza7i4akya5h/ZLyO5/OYIe
	EvcXkfliWu+L7SH0tu2mCmplydznGahq8vmF2FCLMJrBkhAk9DEEyXF2lgWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330919; x=1715417319; bh=fn34Ya9O4PObdxH6vSmoW26D55EC
	B9lnUhi2Vq7VXw0=; b=FZ480gdEDUlbS0AzBInX5Lj6iXdKYu7aoBG/6ICYbKln
	fNba7/7A7rh83DkzUOCrVNVyAOK+Hou+886VKIrcRKiU4zttD+1NYskV+HkHRj71
	fBsHmr6PHJOyezx6RgZJ9eNWXvn9uJtzMzLySt1OgZNj2Raj2tOKNeTvn6hO8tVh
	F7kWU4KiaQcTOq889fAMTSDNQJcseCsX/u/IABMyGH0Wi09Gexhw03Xo4DSx1ZNs
	VgQSTE30cal61eTVA+b/u6sNoEuiElkH8UtpVX/Gf+0Hwr4vPyeafQu2zAtriWec
	a+uzUIPvraVPHNJ75UZHtBFhY6ZMey/xSETy113gxg==
X-ME-Sender: <xms:Z989ZmMU0mK30Hxe58RzqJt3lt6rinTUb4OcL713YQFwey2ECxM5KA>
    <xme:Z989Zk-8_b5ymGHCIkivw7_mZjmppbcq0-twWF6RKf7DGIuFN0-LdMtpmJqct1P9m
    QnF16XEKq7zbbT7Yg>
X-ME-Received: <xmr:Z989ZtR_bFtONCRO7Keki32kHs7-ib_kydH3Cgtp3YcWo9VRou7fW6lb6v3V5K07gN63b4gzhTNpDXxayDu_H-3BQETYA41yTU0kSxuJXK5_AIEH-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Z989ZmtRXlw93MX7K_KjSSjKdkPS3_mlDWbXjL2UsyeNhbOpRT70rA>
    <xmx:Z989ZueQNiaQM5iM3yl-pqflD4539Vg1crRoUQfHLjQwto6OZ_FpyQ>
    <xmx:Z989Zq3YRbOPjhjSEidLXYMH8Ewcan8ntzXF8hBb_p7IxHGgz6bxeg>
    <xmx:Z989Zi9Bgk3g9B_WieWifB_5F-pfagGAALzC1Cqzlpg7D1H5GQILXA>
    <xmx:Z989ZlwFS7Oko3japWk-NTHsNpnHZLJw3li22SC1OqIjddPu4aFS1yXj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5e6de8b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:25 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 07/10] refs: classify HEAD as a root ref
Message-ID: <b32c56afcb22b6d7e30e5ee0d9f6af3386edab39.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IpBBkYZjk8WehsbD"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--IpBBkYZjk8WehsbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Root refs are those refs that live in the root of the ref hierarchy.
Our old and venerable "HEAD" reference falls into this category, but we
don't yet classify it as such in `is_root_ref()`.

Adapt the function to also treat "HEAD" as a root ref. This change is
safe to do for all current callers:

- `ref_kind_from_refname()` already handles "HEAD" explicitly before
  calling `is_root_ref()`.

- The "files" and "reftable" backends explicitly called both
  `is_root_ref()` and `is_headref()`.

This also aligns behaviour or `is_root_ref()` and `is_headref()` such
that we also return a trueish value when the ref is a dangling symbolic
ref. As there are no callers of `is_headref()` left afer the refactoring
we absorb it completely into `is_root_ref()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  | 9 +--------
 refs.h                  | 5 ++---
 refs/files-backend.c    | 3 +--
 refs/reftable-backend.c | 3 +--
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index d63d60a0dc..077ae5756a 100644
--- a/refs.c
+++ b/refs.c
@@ -863,6 +863,7 @@ static int is_root_ref_syntax(const char *refname)
 int is_root_ref(struct ref_store *refs, const char *refname)
 {
 	static const char *const irregular_root_refs[] =3D {
+		"HEAD",
 		"AUTO_MERGE",
 		"BISECT_EXPECTED_REV",
 		"NOTES_MERGE_PARTIAL",
@@ -902,14 +903,6 @@ int is_root_ref(struct ref_store *refs, const char *re=
fname)
 	return ret;
 }
=20
-int is_headref(struct ref_store *refs, const char *refname)
-{
-	if (!strcmp(refname, "HEAD"))
-		return refs_ref_exists(refs, refname);
-
-	return 0;
-}
-
 static int is_current_worktree_ref(const char *ref) {
 	return is_root_ref_syntax(ref) || is_per_worktree_ref(ref);
 }
diff --git a/refs.h b/refs.h
index b15ac3835e..f6f4d61e1b 100644
--- a/refs.h
+++ b/refs.h
@@ -1060,7 +1060,8 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  *
  *   - Their name must be all-uppercase or underscores ("_").
  *
- *   - Their name must end with "_HEAD".
+ *   - Their name must end with "_HEAD". As a special rule, "HEAD" is a ro=
ot
+ *     ref, as well.
  *
  *   - Their name may not contain a slash.
  *
@@ -1079,6 +1080,4 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  */
 int is_root_ref(struct ref_store *refs, const char *refname);
=20
-int is_headref(struct ref_store *refs, const char *refname);
-
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0fcb601444..ea927c516d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -351,8 +351,7 @@ static void add_pseudoref_and_head_entries(struct ref_s=
tore *ref_store,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && (is_root_ref(ref_store, de->d_name) ||
-								is_headref(ref_store, de->d_name)))
+		if (dtype =3D=3D DT_REG && is_root_ref(ref_store, de->d_name))
 			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
=20
 		strbuf_setlen(&refname, dirnamelen);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 36ab3357a7..7ad4337229 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -354,8 +354,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		 */
 		if (!starts_with(iter->ref.refname, "refs/") &&
 		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
-		     (is_root_ref(&iter->refs->base, iter->ref.refname) ||
-		      is_headref(&iter->refs->base, iter->ref.refname)))) {
+		      is_root_ref(&iter->refs->base, iter->ref.refname))) {
 			continue;
 		}
=20
--=20
2.45.0


--IpBBkYZjk8WehsbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY932MACgkQVbJhu7ck
PpQ2FBAApaXMINQfzU/ZSYmUNQdxYHrWhY9jtcf5RLZlTQUkoA/b9Iaf1ZLB4LUp
4pqt6rQQP4+KeKSVUS5MthC01MX9aFofYtAw3YJeFGz15Ql1+MY+7H/Yw3/Tv2J8
Becr1aFX9dRDEA9Ol7N/YSN6ALYhOPE+jv5sVxhkHrPnZnCUPohD97vFY/1i9DNg
5LXhjxWj406paKkgBP4bLBQEoqRQASFhHEmC/XJh3glFP85uh056iTRlcEpyXRXP
geVJg9YrH1i49mFWhaf+c5xISOl9c+W68M+BXHBb5rZzLhda+XjMzQFniw5UVW/V
OgRl4ugLt6WOoIaIN1j6I6ROKlDCbcqbkNbHiaqxURmzbLv2t/lvBhp2YCOsAVyW
oKCNFeX7YFkquoUvhoFqD+CChnlbhbWKM1LW/6nH0iJiu3t3sWJ3BKpgy+/F9qel
5w+NaXVbU/N1Dhf9tzK7/28111QmGyA0KORiVofT/6Bnwx9lfQfidN/4rBnibcMe
UYNF14FOgfbbN/3SLrXq9LbqoGZGDa15vactOeUd55JkqtzaBRorche1AQOhpFph
MocMBZVw06V4hsZnfTc4NNZHbXtRdzojpdDTR20Hpnew43KvyVQiYy54JvzrIIJ3
XUdjt0z28rFHp0JgKwdYMGufliWe6wtXDPQCELv2Q5UUzIESneU=
=uNLU
-----END PGP SIGNATURE-----

--IpBBkYZjk8WehsbD--
