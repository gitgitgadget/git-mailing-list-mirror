Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6D84D35
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407051; cv=none; b=iiRjwimVSzN2s76BqCsQhwYkpUfKcPyG5NP7AtP0Qsqml+Jm+NsXg51mna+UKC8Jxy2AOWcWmxmUQmUH1v1XzQv77f6y2weOiIEahD+Cns3luJyu3Sg+gOM+MivtSK9y4eqsfG1/AE6Q7LPSoykEApXC6wwBtdmqJ0L6JOnhZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407051; c=relaxed/simple;
	bh=TTOav4ZvQWhXBh7qYtAdT8LrquGSSbJCIw2ozlpLnn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg37R+7fTVGu5GfLX9bty0Sf6bEGK0PO7Sx3YbxLRunzD5ZV+gyAzqkoF5EtlYQQjP07XcHm6Seqr8hcyGkSmlSis65+VrjCxeQUK5D3x+DkvaQwUky68QuUUZUcWKydFKB7I1u1rHSBLyGmdADKOB0IumWIiUd+c0nHjwjFXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gg8dRgRm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJmUKVfg; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gg8dRgRm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJmUKVfg"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 29A481800070;
	Mon,  3 Jun 2024 05:30:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407048; x=1717493448; bh=0d4Jo4If76
	VBA18mQXUYFuTgn3GmwIeh9Xi6VlRfCB8=; b=Gg8dRgRm20fV23Nd6CjoVt+73M
	1EuyVy0ZlViRRMBEL+LQVCumx8dCfm/ltSGs5zWJxc5bekWZeo+FhtN9BeFo/yBB
	DlrihjH2b2xM52asHerSDAPjEDaUTwQNnyMjHk9YFFTELq6TF67pHaFMs/T2+rhJ
	5hGDAL48jQtqpGrx2S8qa7a/j52HQcCZUaoakcfRZFk5lptH6YDCb7izRIOl7YKG
	E9+TISuczAVDjoe13okhgoKkZ6xWwgr97viqftwILf8glodXy7IjB65ILQZ4GQFZ
	/gY/UBh+eL4Rd8BwO3pn3ndectEyJOD+zbs+vyK/uaW2YxRKQJSDzzl36R8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407048; x=1717493448; bh=0d4Jo4If76VBA18mQXUYFuTgn3Gm
	wIeh9Xi6VlRfCB8=; b=IJmUKVfgc9Q7MPxwOdvZDa/Zz371Sn/GSLrV63/Dpg+G
	BohSTckIYc5fT4wbGeTQFMqr4QKiSIs2nu0HWlXVOFGMmoIeht0gCwgHK5bEO3xc
	Q8SXWx0PeG21FjEhrsmOYUIRHVmHfIJ1pQGADfKq6e5QF51X9gSLDYNSxirgJQEw
	I8dVfJkt2QVqNNSOSfFt4wOVd/d9kHLpk+o16KVlu28gLTYuCdHpqs2fu3mcGzue
	/RA4Yuo95iyKfOB62QvBjQHP7tTZM6vwoB9cGlip7OcdHd554eGG0JQg/TZO317V
	aCvYmOxrcK32f3v3qihHKgfBrwagbmNQIjnhPcCgNQ==
X-ME-Sender: <xms:SI1dZrra4YJ-oXI7-aRadAa-yTHvx7fJPI4WH66uLTmMiih5N7Ctrw>
    <xme:SI1dZlpZG9yA00ACvSmROuzR3WILhdnKRQHC9LaXSvI0kJM7Aye4QYeyZ_M8uiZNX
    rE7DoUJoC8nBVBD5Q>
X-ME-Received: <xmr:SI1dZoM_RKwN6q5nsLQkJbGu2VhXByBYgr5kGftGX0qtKNmd1F8F_KZJoFJ9xTdtj2jryLPztKMuognd-NgOSRZPZXCHNwrhXvyG4PMXupTZE0GJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SI1dZu4oxhXyyB7Uotc-qv-VdD5XP9ifHHIdNK1zbpbHdbpaRQfefg>
    <xmx:SI1dZq4F0alAU1VL_iG7zjL-pc3jpSjzSYCd5J_jSthxJKgBzIeebw>
    <xmx:SI1dZmhbaLpKKjABQf1hiXVhPVRyx4-LXzDh_YieVNGKKPYJctW57g>
    <xmx:SI1dZs7sCwd4pERNhDLTY9w86aR4y7S5ZwCZ2DCmOxa5n6JR4CVerw>
    <xmx:SI1dZsSm1ikEAofiO78A1MuQLQd0v8-JnGLPQcMlyo-Vd_jGcrMlPway>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ab86e314 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:22 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 08/12] reftable: inline `merged_table_release()`
Message-ID: <c7e8ab40b5191d9721cacadb7257aded3dd90db7.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WLK+NzQndhf7QmnI"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--WLK+NzQndhf7QmnI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `merged_table_release()` releases a merged table, whereas
`reftable_merged_table_free()` releases a merged table and then also
free's its pointer. But all callsites of `merged_table_release()` are in
fact followed by `reftable_merged_table_free()`, which is redundant.

Inline `merged_table_release()` into `reftable_merged_table_free()` to
get rid of this redundance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 ++----------
 reftable/merged.h |  2 --
 reftable/stack.c  |  8 ++------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index f85a24c678..804fdc0de0 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -207,19 +207,11 @@ int reftable_new_merged_table(struct reftable_merged_=
table **dest,
 	return 0;
 }
=20
-/* clears the list of subtable, without affecting the readers themselves. =
*/
-void merged_table_release(struct reftable_merged_table *mt)
-{
-	FREE_AND_NULL(mt->stack);
-	mt->stack_len =3D 0;
-}
-
 void reftable_merged_table_free(struct reftable_merged_table *mt)
 {
-	if (!mt) {
+	if (!mt)
 		return;
-	}
-	merged_table_release(mt);
+	FREE_AND_NULL(mt->stack);
 	reftable_free(mt);
 }
=20
diff --git a/reftable/merged.h b/reftable/merged.h
index a2571dbc99..9db45c3196 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -24,6 +24,4 @@ struct reftable_merged_table {
 	uint64_t max;
 };
=20
-void merged_table_release(struct reftable_merged_table *mt);
-
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index a59ebe038d..984fd866d0 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -261,10 +261,8 @@ static int reftable_stack_reload_once(struct reftable_=
stack *st, char **names,
=20
 	new_tables =3D NULL;
 	st->readers_len =3D new_readers_len;
-	if (st->merged) {
-		merged_table_release(st->merged);
+	if (st->merged)
 		reftable_merged_table_free(st->merged);
-	}
 	if (st->readers) {
 		reftable_free(st->readers);
 	}
@@ -968,10 +966,8 @@ static int stack_write_compact(struct reftable_stack *=
st,
=20
 done:
 	reftable_iterator_destroy(&it);
-	if (mt) {
-		merged_table_release(mt);
+	if (mt)
 		reftable_merged_table_free(mt);
-	}
 	reftable_ref_record_release(&ref);
 	reftable_log_record_release(&log);
 	st->stats.entries_written +=3D entries;
--=20
2.45.1.410.g58bac47f8e.dirty


--WLK+NzQndhf7QmnI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjUQACgkQVbJhu7ck
PpSNKg//WyEiecVu0rONw+7ppc2KwZeIefYPwwTRghArTncAH0HVD/Z64Y9dIFqu
xdBg9VsulwbY0wzMCOgMRi2loyBUbspPuubXh95Vzss8sUDq7Hb/DpIzw/euUHgw
oRN00Pz4MhnehRT5afK0l0PZVUwW+ubHKQ2egkBKm64IUMwfWZwaxKLJsvaUxQzI
uDEiVaBnkk1YmRWfzSssqBrsdBrsyA+WC2woe80M3YFUU1q+0cFdGitkMr79D5xL
BPLPEf3/pR4NHUenEq+F7djPHCCRA7880sOjs3i7uSjs97fwtyj7zUbS6VEdOKvW
WABRWhZCqlw+5iKXYLpBmTWZkhoOkvlHHgVIMA9srO+uo/ajvxuvOCUDm2pLJTrw
27bN9nw2CmKPo3vfMIWkSjjEYcNtAdEXjh59tdSt2xito326OjFoPQ+Yke+ka+8C
w6wYCwjrCptLi/mutm8iJSeLrowqhJbaKwpbPD1Fe2WMHMLU0szrsOrwSUKpItPs
EWvoORFmC11/GHERI/sTkejnyubOtAfrwbNaUv0j/w8NYqnCeB+iICrLkZxTTv2I
bG8r0Vf2yeeBSMIouT8TX9yKrqBIYjnpN601pUqRUfeZzSaIyigsyHHodBTxD87A
N1ezMO9HhYZWprLkQ059BlJIi6lOutYOiKHhbB/Wbkf0LCFz0JY=
=GrrG
-----END PGP SIGNATURE-----

--WLK+NzQndhf7QmnI--
