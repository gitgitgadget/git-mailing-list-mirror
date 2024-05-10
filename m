Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403415F40C
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330917; cv=none; b=okbERK2cUtb/wVaz1F6eUfpRg2NObRrbxzOCCYvGjS6j9LHAXJD+Mt3Zs59JteVoGTNZwrIEGUXuvy65ISIgxEah5CNyxfhfW/Tf4yUZ9rIrtzobcLwGPibFJhQUexpwKHge/39UlaPGVnk9rgH/wkoPgaGRrTM8Cm6MYJk6ATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330917; c=relaxed/simple;
	bh=Wh2r4dQudXOI/fAnDiay1pORjIEx6Dpz9jhCqUz6O3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhEy/y4istE5c3dsrmLmTmlGOWDLnJAFdaLXpyuOxLESrYTdlZAlzN9KHDCkTotnBGIao/wpH7OXnQoI5NbiCog8rKabf7zlOt9Zq2BQ+eb9WLAFACH8zzyAFGHMKtrU1ZI7ppG90KlthdkPF8HSLhMXW4wb8KQuFj4kZ1R5Dfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oV5ph2V4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UJGSrgYJ; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oV5ph2V4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJGSrgYJ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 26C361800137;
	Fri, 10 May 2024 04:48:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 04:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330914; x=1715417314; bh=raxYrptLK4
	zWy4rwZNQ35iNmKJTm7/DsUyIRLSf6PX0=; b=oV5ph2V4l65cTnA5vxTU0EJDI6
	Ov+yOkse5XM3CPikUj3nmLw8ub3QSipxvwswnMQVxGmUw+j9csWR1sMOe5x+4Hk7
	9ppCO5ZXThTsrp5UblQpGNxKROU4jhX1n3zxRDlqn41Eey+Aurf3+haGhys5Ynjr
	1QY6ewqQ9f9qaksrA9zI/WctT+wksr+R/vGudcyIvs83fPKY1/FhIC259HoEdrM/
	ZDAht5klh1nZXjW0wgin+thrIvlXJ5joaZKirdXiKCUr4vsG1o0utOL7tmSq6eoL
	VF+dR4SjjcptcCJxqbjYQ7LUPPXZWb8Lety8dBpQp6gOOGOIaD3B0GlTkwJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330914; x=1715417314; bh=raxYrptLK4zWy4rwZNQ35iNmKJTm
	7/DsUyIRLSf6PX0=; b=UJGSrgYJ6pG/5NdER7MIoGopnTrgfXTFu9X/3AK+czJO
	p7Ws3/NbnZIf3qwmma2l6CtRqBtNKVJoTwYsRcPKZgzbiRwQMk1wnEsXeuwn04r1
	ay9F6Wxp/DEX4XOpaecSQmWlCGPGWhxdf2QmlwKAl0T5aZ7Zce2QycIxVoF4tthb
	tmtERtRSkdpBEvLDWqwpxM7i+Chv+4sR/uE0swxY++zD7zf+5kqwo21Pn7BxdGyv
	OoAmNbblXIvXiellAQb4ibW3+4MDU+7p46253Xi+ndJeBKzK1Y01qP3IRWqZ97G9
	G/X1hUzhAm/SOfWYzc3UX1Ev9V0dQRHOEZuzOU5sxA==
X-ME-Sender: <xms:Yt89Zl8zlWmqiiQshq-pbcX892DpJ2Z_RZKxTShrDKtpNaw6LnaHTg>
    <xme:Yt89ZptVOAZB_MadKYUJKNpQa3D7w7ykr4o7y7dtqABEo9GTQgMfeP_nHKzy0vjN2
    kreilFmAsmDLRLXAg>
X-ME-Received: <xmr:Yt89ZjANKo-H7IUWMDXKrbJFPih1JQAg6a8-zM9NPgY348xuZdgGtZIObwlCFmWqSNoOvM6emoykORG5lo1aQW_nuunDHYSQhYlyRO7MoMxjG0raIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Yt89Zpcp5MlP_MdK_4KcvRX2dJROVOQO2LgCr9exGNAcoq0Wor43aQ>
    <xmx:Yt89ZqMj-3iZfqjbyjWYrRCpBGNRQT2WdqTBJdoyiPM_9n7wClxi9g>
    <xmx:Yt89Zrk6HdqZJ_vxRODvhn6n6APSt5dRxjN41R_6obJw7nUbPGiNSA>
    <xmx:Yt89ZkvIXSRirXUJapm3rYAFjBMUpI1SM5UjnkArJMXCdnDI98lPgA>
    <xmx:Yt89ZrihNt-3y8Bc3bjBGv07c38Vqv-6JzwBj9WwWF0bGy-UDiVpld_h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4c18ae5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:20 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 06/10] refs: root refs can be symbolic refs
Message-ID: <5e402811a668ae7659175c6f91da6bbb982bacf1.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZwK6Jt58LQtY6s9Y"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--ZwK6Jt58LQtY6s9Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before this patch series, root refs except for "HEAD" and our special
refs were classified as pseudorefs. Furthermore, our terminology
clarified that pseudorefs must not be symbolic refs. This restriction
is enforced in `is_root_ref()`, which explicitly checks that a supposed
root ref resolves to an object ID without recursing.

This has been extremely confusing right from the start because (in old
terminology) a ref name may sometimes be a pseudoref and sometimes not
depending on whether it is a symbolic or regular ref. This behaviour
does not seem reasonable at all and I very much doubt that it results in
anything sane.

Last but not least, the current behaviour can actually lead to a
segfault when calling `is_root_ref()` with a reference that either does
not exist or that is a symbolic ref because we never initialized `oid`.

Let's loosen the restrictions in accordance to the new definition of
root refs, which are simply plain refs that may as well be a symbolic
ref. Consequently, we can just check for the ref to exist instead of
requiring it to be a regular ref.

Add a test that verifies that this does not change user-visible
behaviour. Namely, we still don't want to show broken refs to the user
by default in git-for-each-ref(1). What this does allow though is for
internal callers to surface dangling root refs when they pass in the
`DO_FOR_EACH_INCLUDE_BROKEN` flag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                         | 31 ++++++++++++++++++++-----------
 refs.h                         |  3 ++-
 t/t6302-for-each-ref-filter.sh | 17 +++++++++++++++++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 6266f77474..d63d60a0dc 100644
--- a/refs.c
+++ b/refs.c
@@ -869,28 +869,37 @@ int is_root_ref(struct ref_store *refs, const char *r=
efname)
 		"NOTES_MERGE_REF",
 		"MERGE_AUTOSTASH",
 	};
-	struct object_id oid;
+	struct strbuf referent =3D STRBUF_INIT;
+	struct object_id oid =3D { 0 };
+	int failure_errno, ret =3D 0;
+	unsigned int flags;
 	size_t i;
=20
 	if (!is_root_ref_syntax(refname))
 		return 0;
=20
+	/*
+	 * Note that we cannot use `refs_ref_exists()` here because that also
+	 * checks whether its target ref exists in case refname is a symbolic
+	 * ref.
+	 */
 	if (ends_with(refname, "_HEAD")) {
-		refs_resolve_ref_unsafe(refs, refname,
-					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					&oid, NULL);
-		return !is_null_oid(&oid);
+		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+					 &flags, &failure_errno);
+		goto done;
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++)
+	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++) {
 		if (!strcmp(refname, irregular_root_refs[i])) {
-			refs_resolve_ref_unsafe(refs, refname,
-						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-						&oid, NULL);
-			return !is_null_oid(&oid);
+			ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+						 &flags, &failure_errno);
+			goto done;
 		}
+	}
=20
-	return 0;
+done:
+	strbuf_release(&referent);
+	return ret;
 }
=20
 int is_headref(struct ref_store *refs, const char *refname)
diff --git a/refs.h b/refs.h
index d0374c3275..b15ac3835e 100644
--- a/refs.h
+++ b/refs.h
@@ -1052,7 +1052,8 @@ extern struct ref_namespace_info ref_namespace[NAMESP=
ACE__COUNT];
 void update_ref_namespace(enum ref_namespace namespace, char *ref);
=20
 /*
- * Check whether the reference is an existing root reference.
+ * Check whether the reference is an existing root reference. A root refer=
ence
+ * that is a dangling symbolic ref is considered to exist.
  *
  * A root ref is a reference that lives in the root of the reference hiera=
rchy.
  * These references must conform to special syntax:
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 948f1bb5f4..92ed8957c8 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -62,6 +62,23 @@ test_expect_success '--include-root-refs with other patt=
erns' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--include-root-refs omits dangling symrefs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git symbolic-ref DANGLING_HEAD refs/heads/missing &&
+		cat >expect <<-EOF &&
+		HEAD
+		$(git symbolic-ref HEAD)
+		refs/tags/initial
+		EOF
+		git for-each-ref --format=3D"%(refname)" --include-root-refs >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
--=20
2.45.0


--ZwK6Jt58LQtY6s9Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9314ACgkQVbJhu7ck
PpR4Nw/+OyVLtEEqEod0ZDET6ci8lRWvTpKqpzjuKGkdgcQXbnpxPYaIMCWwJKw3
Hzba7nyOLYU5XKhiob8S16HpgxeS1YtW26vYuSAwISAeG1SBypk+yDKPzDzK1gcT
l+yRi7TOTwsPaQoSHb8HCQPz1TkikekeFK3QiNQ9POn82VTgDFHk1nYX7rdIxNZn
j7mod+58iqYEmlNyYmJdJCsjb82M9tHiT3pl8Q2Se5Q0XCwGmawebWzCd5ynXVQW
l2ApkycI+ceILuTnbt5DgiVrJI7dk02Z6FrZ5AcW94jNKbYz6ZVQVeByVvlRqhTs
9RF5qtK+ZVoHPZ3LwO0LSRMppw8G//xT0mPAdBPPwiFhDu9Pb6N6G/Uong670a0k
cxCR9lt3bdwR9YYZFWtQwzHLqYrF5KqB5HzRA8zRvnvnBPknY+Jp8ZuyzK2VcPfv
LgBHryFC2RDkd93du4btmIpquOJJJ9ZMsQrU7v/lIvuib4/z1eHLLWa8R2g5tPJ3
8m0FZs71Z6AyKL82KZrIR4gvGqrzFuJxM9SqmA2r1hazBCP8A6ZB0rE9f/QDCjWf
EIp9yt5xtyRS/qedL9XcMzomgWZTDJ9UMVq11GHaYkrXpLj0+d4Deluvbd/EGdRP
KqvQf0sd8nSj3dgaCxSpEQTYbsJSkce8b14jwvkwHVVNIiyOCVg=
=0nIu
-----END PGP SIGNATURE-----

--ZwK6Jt58LQtY6s9Y--
