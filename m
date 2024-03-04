Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F539FFC
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549369; cv=none; b=aCwexmUpxPlbLTwQXxNk+gCanTrW4YMXylhuD5SpWbjXicqiOLydqTxnOyMTMRqh84Av6HNxWpeg+WCiWxrMzeIBOwat+TZYp5Pk0tXNwRt7CrOXfK+3KLiDAuogFl5ufsjRzHMuFrQSabYu4K52ooaPSDnbzmXqf0xyK3yEZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549369; c=relaxed/simple;
	bh=BXUZlWEx7RIMQvHRhKgiCJ4rmbtf0prWhygBCcdRaAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUNbgTww427rEJL7Pm0tB2SYYISAZB2mmKG4Oz1HCP2hgAOe5mVBRZdOZS5oHXFosyfbjTk5MmHUADJiTqMQVrY+IpPSNul4jaRAjO/eh1QvEIjtvwdgChWIBiDrI/+13m/3MESpuJogdWBuoLYsQ/OvJOaBlPY8+dR3KHepQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fksVyf2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dW2+1Prq; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fksVyf2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dW2+1Prq"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 6F5FC3200302;
	Mon,  4 Mar 2024 05:49:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 05:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549364; x=1709635764; bh=ApvQkLIdk0
	jSIk8Nh7Ibks2VvW24sORbcbC9cg6At78=; b=fksVyf2Hk71xGgRhum6ANsX0nR
	QN4oLAZVib1APyH0pG+M+unQsE7hZbD67jFiQHr7LEss2B59aO6vLZcRW5cdt6/X
	aSuEbaSEyTPFoZy6fgRbvChi5MpRjDLMRscddPdBSIL38lh5NrGjPllbEWxt63zA
	guLTpTSc8yNG+hEIuIz3xVZ7iuN1uxXqsyCK2SAIBm4B+9b90OhSgRNgL0uwpvjI
	hlK55pjN+Qs+yVllEYA50VohIt88di0ThcRLefBtNr9gIPmKo4HK9Se/XXQr4vAd
	YLUvApcyxdAxlOf7YbAzY0fuAVdTwJyZjgEuYQdC4PxmAq4Tm4a7T9DoNv2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549364; x=1709635764; bh=ApvQkLIdk0jSIk8Nh7Ibks2VvW24
	sORbcbC9cg6At78=; b=dW2+1PrqBUeA+mYw7KE0rd4go9OYSm89jl3J3AU5G7SE
	Wh7GriAIn+oWJkOYzwNL6ahUdw808PeiixRJVGYvKmhlyphuj5YDzl4DA9InQ/iY
	A1YMa4PjYV606udVEYRDOoIUtOZnALxOx4VbIbZklnfVNBgC81ASLlF4stm5B3Fg
	zdieAdMh3Brjx26LPnrkfMNbI04IoiG+x/DkIMXL1whkM2GH7wHRJjcSwoEZXlBr
	yrDZybeD3uTUXz0EatNT8qxI2HzD6erZUBOsWDLUUUKGm1jIZ9nCREpz5BwB02I7
	so45+OoRHN9u2vmqXm04vT6rt3hRGJdT62mANMlwRg==
X-ME-Sender: <xms:NKflZYIyu6isYvYpZz2_nXXGx2M3MMPfdabTgYVca28Q22rhZFmoLg>
    <xme:NKflZYJp45ouM8tADGrVdMW0Lz6H2J-SWflCvLVl6kN-bhzHkKuX6xOGSVMAXeAna
    EE2kr6992Pn6YdaFQ>
X-ME-Received: <xmr:NKflZYsQ1zpUvibGelRO8tdJjOLQGaz1YRDPZMRT8GCLM6wERxUsixAIc9aYQQmbuctgxssiwXFR-5imeEiu4E7L8jFM8G_AUewADQypkNmW7Vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:NKflZVZZdlW-vagRRtF6U01EywBnR_TAHhjTNgs9JHzRsq-NY3H2QA>
    <xmx:NKflZfYRM-N_jlwZ5EMBJIv_RDRnDB3tLOD8b2h3L-oLSx8aw7cr9A>
    <xmx:NKflZRBGkALBgGyMSSso849tkx_f7rsmLXYpvWbZ7HgTIM_7UXzHug>
    <xmx:NKflZeknFiHbOW2sXzocUsab8Wq6_Tq4Nofxj6ULxfcS40T4HdGD-w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 348b2e96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:59 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 09/13] reftable/record: reuse refname when decoding
Message-ID: <92f83dd4046d117bdae77fc88dbdefb8742139fe.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WqSGSeqKhpUdtWBA"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--WqSGSeqKhpUdtWBA
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
the refname will first call `reftable_ref_record_release()`, which will
zero out the complete record after releasing memory.

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
index d6bb42e887..2b52e47c30 100644
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
+	SWAP(r->refname, refname);
+	SWAP(r->refname_cap, refname_cap);
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
2.44.0


--WqSGSeqKhpUdtWBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpzEACgkQVbJhu7ck
PpRjyw/7BgjqmFnyhnKXPXVkr67N/AWuKtRs6ZhmLvFMN+E91mevN9kAF5Mz6fl1
ZC9snKXZZStOj6L47pRTBAB19IrJiYLsn4tqDrvIs3pD5GJiyyyE5sb34cGZatxu
smuAt23cn7SqlEdh0efAHWPk3e+yw2LYPJqQLdeTwnBmuA+S30xVQCfqK0KFMQAV
+OnrPuCyGcn79sckDtvBK4SStt1g8hVj018gARU6NUTE3Y59xY6W776sJWO4Ai5I
CWekZPr2Wo0yLZ/0XUu6OXvcd0RH7DLsBzXtFgkZD5XfdLkOKwV8XduOdyfFhbAh
9tlf22xS1B+7T7/dMSfj9uFbod4/wK9/JcZ5mOVbGKXtXbbfUv5+zP6mglcoMwpR
C78DLKk1q6eQmvdB+vM7k3gfKLtHAPcJdJP9K2DolMumOqT8DWFpedExFQnjYgVI
iWnr5AtUR4hJNImLxls340Zd18LC2lvSHu7l2CzMAJLA25yrE0hNu35al3dAkTtk
xVrC3dTArB/Chv/Xt9oA3IP45dxvD/4I1wSRuCd5rch133BngBaMcVv68ctEgX+L
N8VXUViddPSXQtbPlaAIceP//w//3vMrr9Aee+K3tsvFTcWfhYPAWxt7IAMnmEXA
Y+v4A95nSPWwP++akLKmimfcFRzblcJckj04qpFVDiyLnpSQP0U=
=dBCk
-----END PGP SIGNATURE-----

--WqSGSeqKhpUdtWBA--
