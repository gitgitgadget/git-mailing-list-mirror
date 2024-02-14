Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60A17571
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896784; cv=none; b=DzPNoyZGbbLYmIUaFZBws4fJylT33C1eiIE9WYOEq9EKLHkTXj7GM5VJIvyNYiQdbYZMosof+sI5uUjEixUPT7jk7WWcXJTepEgjjnrpn5qA/78WRd8115PgM6AJAfNQz/ruRxgixWvdYkcNaBgOebquJqpFJBKKvpdxMRCmv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896784; c=relaxed/simple;
	bh=G2NUbDP2gqkH3v3UKakEsuin5QfvJpKGTxxEH9+ueHs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe/Hd2qdbbQ5HJEoIrM1cVyYbFf+cxgOjZM8idbnPxSN/zgLVacnjcHJSmhhFT8fgfXyPyr7vt+dQb8rfJIxpoRQ+rRELnt9SS0ui6x37NZKY+2KAP2KF0VcjuPun2ZZjEGiMaeI0Sby9cc7KNy9hnbdwDFO41T/Nszof9W48O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XeoYQiJT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkb+gsyJ; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XeoYQiJT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkb+gsyJ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 188C41800096
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Feb 2024 02:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896781; x=1707983181; bh=dJgMVSOI73
	4rvMz+y6cllQKTHGvA+mRWKxx90rhlWqo=; b=XeoYQiJTdQfizH1OAztqG7qZRC
	vn+Klmb12LsmvZRToDhN1WSSuA4yhdAzoiQoNURRaMieMK2ZNSM/sS60roYB5RRe
	T5EpZFeV4NuhtvxupkfovCCubinBjtqgNV49JRWn4lyCfZpYasEi60UpHc5b6n3a
	CLfLN7/fvHM8lWO6Womw2eB/ZQvWk87RLt6HG7RbZw0wjE9MsvpwKicVr+GciCi3
	Ew18OkzwXB+vOLAAth2o5Dk024qH25WKR/olQiLE0komv+ICdhSZv+gFqnzeqQMm
	7bWPboqkwwgk6drTSZSwAt0Ic9SSG6WEj0297yEijh8Lpkelou5tBUOM983A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896781; x=1707983181; bh=dJgMVSOI734rvMz+y6cllQKTHGvA
	+mRWKxx90rhlWqo=; b=mkb+gsyJ9RJYFoBZiCPD7Y1AZueklCSIwUXw0ddaj1Dr
	Y2tUWo3Z6pBQPl3wyM4VKTj+QI3dLFuLDX8hXXyASpQV+jqfZxEHgY+BvMVQU8+/
	z1Q+BclXj8FLl27OyzGdmuejngQW36O6Tb9fw4cUFwRAjtzkfKKl+D0w22kPXy02
	GYgo/ZUz1g0TxiqGZEbXhRpLmDmQazFbrdgAwCt7wpwAU3wwyMr0FmgnL3gP/nkH
	j7THLFeE8o28qFsPSK/OZScfumSv7Ka2Lsk16cc8XA2hj9vLaIdbKEJJKNEztJeH
	/UjDddOnTGFatn5eY+N6Yy3id/5SQG2E6n9IPfY+kw==
X-ME-Sender: <xms:zW_MZUe15dFwgAvfanAZImp5GPkeHG7hLV584KBPzWP5Ij3ghcuZag>
    <xme:zW_MZWMVFrdaXi-2L8aK8bPVN37zKITudXZxQjOrsg-d86MROgobHg_-s6UhZ6Jcx
    Q-G6vI7cwqNXPcWVA>
X-ME-Received: <xmr:zW_MZVhlQlQDUNjE9P0zmhTUakqb6T3poAOf0WiKKKHDxb60v_VnAxUC5E8GFhkOgLjMTd0WFQwM-BkGGZssdJbapMdBkhvTqLZC-LYEH1g3xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:zW_MZZ-iVYlfyueCPjkA3OPZxy68RGZvBWRuFigS8BjIKvCkcttUwQ>
    <xmx:zW_MZQvcaHKkpFMoee8nT_LFeozmUl-RTijPUTuHdNkRaE4PtG2I5Q>
    <xmx:zW_MZQEvYtEXC-T3q4LRVtl13-0TWvuC_ydVW4FbPAvuu1fw8fKP6A>
    <xmx:zW_MZdXCXEE8il1D-q1dW8PBJl0dQqhAXDGbHaKD9gUcgJtGqfC7RZHg658>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80a83c27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:31 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:46:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/12] reftable/record: reuse refname when decoding
Message-ID: <3ba697036c1db3837f46775823a7bd55602b4bac.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cklNB8Xnmd7VYS34"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--cklNB8Xnmd7VYS34
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When decoding a reftable record we will first release the user-provided
record and then decode the new record into it. This is quite inefficient
as we basically need to reallocate at least the refname every time.

Refactor the function to start tracking the refname capacity. Like this,
we can stow away the refname, release, restore and then grow the refname
to the required number of bytes via `REFTABLE_ALLOC_GROW()`.

This refactoring is safe to do because all functions that assigning to
the refname will first call `release_reftable_record()`, which will zero
out the complete record after releasing memory.

This change results in a nice speedup when iterating over 1 million
refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)

    Time (mean =C2=B1 =CF=83):     124.0 ms =C2=B1   3.9 ms    [User: 121.1=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   120.4 ms =E2=80=A6 152.7 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     114.4 ms =C2=B1   3.7 ms    [User: 111.5=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   111.0 ms =E2=80=A6 152.1 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.08 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Furthermore, with this change we now perform a mostly constant number of
allocations when iterating. Before this change:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 1,006,620 allocs, 1,006,495 frees, 25,398,363 bytes a=
llocated

After this change:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 6,623 allocs, 6,498 frees, 509,592 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c          | 16 ++++++++++++----
 reftable/reftable-record.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index d6bb42e887..e800cfef00 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -368,16 +368,24 @@ static int reftable_ref_record_decode(void *rec, stru=
ct strbuf key,
 	struct reftable_ref_record *r =3D rec;
 	struct string_view start =3D in;
 	uint64_t update_index =3D 0;
-	int n =3D get_var_int(&update_index, &in);
+	const char *refname =3D NULL;
+	size_t refname_cap =3D 0;
+	int n;
+
+	assert(hash_size > 0);
+
+	n =3D get_var_int(&update_index, &in);
 	if (n < 0)
 		return n;
 	string_view_consume(&in, n);
=20
+	SWAP(refname, r->refname);
+	SWAP(refname_cap, r->refname_cap);
 	reftable_ref_record_release(r);
+	SWAP(refname, r->refname);
+	SWAP(refname_cap, r->refname_cap);
=20
-	assert(hash_size > 0);
-
-	r->refname =3D reftable_malloc(key.len + 1);
+	REFTABLE_ALLOC_GROW(r->refname, key.len + 1, r->refname_cap);
 	memcpy(r->refname, key.buf, key.len);
 	r->refname[key.len] =3D 0;
=20
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index bb6e99acd3..e657001d42 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -22,6 +22,7 @@ license that can be found in the LICENSE file or at
 /* reftable_ref_record holds a ref database entry target_value */
 struct reftable_ref_record {
 	char *refname; /* Name of the ref, malloced. */
+	size_t refname_cap;
 	uint64_t update_index; /* Logical timestamp at which this value is
 				* written */
=20
--=20
2.43.GIT


--cklNB8Xnmd7VYS34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb8oACgkQVbJhu7ck
PpQc6Q/+IHYYfLcDafyFYBmVkRIWYN/hAkOZFs+WExLbanufFrRg9K3XRBYKauec
JICA4DPeKOjh5ZT0trZsoAoB57ZJvRmDRIJgRoLU+3dhpky3MBZPuZ3MzWoh77VC
vdyGDPIOjO6W+rrg3ilzE9mn60IHj2HM5F9ha6hDh1A9m7Vraje4S35Qr+sd1GL6
yc8NTbLqNZWNkHPtbWyovMUOh/mqnV5MWqEI/sc7knqtC4uI3AwbF8wY0ff5PIJ9
1Cz7aZ79iRHdjgkO8/ONrSsGcD01BHNDzyAV+c9LmqtY90a6Dn9aBQnyIreKteoi
Rl5Le0xtT9dd8B05YPRPSuBbszyptvD3Wnjfu/dPRnT6Q1GFROe7xImtLbZ59n+H
fFsLYLXJk6OCkId0Oowa59Z8Suq3irBvhHGBST2GuxDGpdLsfnsDUdXHuBALxvPX
V5WoWRf+xBrA6ktHuWd01ocUVD2SMa5mdgYVyan/pQnOuAEI+weO1KqCK03EZiRB
7rcD1KyQApy1iJV2MDi+Jq57D7CCIDaud478BN4PA5fZlOpbK07bBdpQnygIqK1U
DmBs6QiU5BFQHUzB5kh9bymgHcEZhPFzvu+kfJPWN36PJ9V4XE6J0Lw/SaGVCydN
w/acfR5jBTx+MXbXfGxQMW1xH5dpmjsxE2AMoGthdZcCj2vcldw=
=svN0
-----END PGP SIGNATURE-----

--cklNB8Xnmd7VYS34--
