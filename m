Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E2111B1
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726769; cv=none; b=I9/MHFvD0hcTg7+BNNtKQP+LjN3VEPP18DW6MnfNsKkXmBPv2Wr/QKRIggDKGjG8pRHL6A9d32omtH3zU7Z+MaS+vtTjaHqC55Amf1L6zqBcnnYGz9CzpjMDBF7dMj8BFkhnPmyVmUDGjhYjWFnywCHRvWwWnT3TdMKIEJsxyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726769; c=relaxed/simple;
	bh=tASX5euincqdLAY5iI+k5eMNBO1zjQlDosjl8g0jCjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p93//XLhZqavtAxP2tt7Tm8FijfuDCWC1iK3YMf/9Buo2e61cBVFaCxFZuB70ddE86qWzP4TPA+AkkY/UeGvz0UCVtzsliW03pVARHsU7J7BqteWeboo23A67Lop//ML27Ge3/RMAJaCOOM4ZFNaxh8/rgzXcDmwF4JV2YmKb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hGO4WXqy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xU2Byf1t; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hGO4WXqy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xU2Byf1t"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5414C1140091;
	Mon, 12 Feb 2024 03:32:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 12 Feb 2024 03:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726766; x=1707813166; bh=PjMeQvFcvJ
	zfk8C+QLgS/LrXjOP+clCzIg2y/N2t4eg=; b=hGO4WXqy2YxMhDfqeHHmbvD+I9
	KSHtrS3OeFigjxu7873FgxP4f/LFxvTJ1icctTd0mZrL1xnIGozNl5Fl73gIbqD0
	kKAI73109QGPlJn1ZroH1/R8k10Vb0dD+D53pvRtiHSoN4gdlfDEh+YRECC95Zsu
	vFQ4rPkp1W4wW+Xu7/CELCnEStnZ1FcowjCYmvB3PPWk8/Enhw67BPgzFWSXCEK3
	NdAamAD2yrN7g6wT2GEeMBVzW+TymgpcRAUa2QiQ44Z1oTGdsALG+Kq/ARB47+I1
	O09ai4CkPNaKYDXjMWFh4IYDwEax5CaPsCzMLylAq+mAYiS23Cf5ktXnNNEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726766; x=1707813166; bh=PjMeQvFcvJzfk8C+QLgS/LrXjOP+
	clCzIg2y/N2t4eg=; b=xU2Byf1tVcnlvZtf/1CkmIbc+El7vLKr37ZbE8poK+Ly
	a66tDVlWLnRryWZZAcaaI1aXGkx66ECst/yqm8V2ku37zrtdRJbZzsLQb8gDhZ55
	MpW3gVbK4xu0AkB6dFQ9U2JltbkXkeGoPK/zts0w0/ArTVYlgibggQvwNkQOHpwR
	mBrBUxvmdcEOQfzrTt7UXWkHWeU3QyKOHnwWGKNO22BygKSQ7coDAUnzIEVy35nC
	ZRD6B8MXJG8QeCZjqVxN6XYtARBOXly5KwGWNIAT+IZm3i80lBFMMiWPiKl28L55
	UvHaVCzUbZ0YiXuPHy2WEgsaYdTbxSETo4Rizbon9w==
X-ME-Sender: <xms:rtfJZT8MDCqBFuajbpsfg6KK8MT5mbNy2-p6MqeURmZ3t14k_6N9xg>
    <xme:rtfJZfvsK-7bVuny89qDJofgrYWm2UOh5E4bZ5XINPFn7-NsOeRnJVhfPrqp8K_Ar
    ZRnSs8tTjha0SHWsg>
X-ME-Received: <xmr:rtfJZRDBYfgJzqk3z-fCkt6iqr2e7PEuV4Oa2TvLOWpymyBPaB0TZic9tI25T7lo-PPQtGWxlJH04AX7Wb5Uors--xBJnDz-tSQ5uA7V4kaOCmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rtfJZff_trQnuA7nt6KCjmljmhRzIOt0amGQHKEuMb1-ggfJDV5QhQ>
    <xmx:rtfJZYOq2sF2cjM5ID1DCtV8WXQpWXIy0pcAg2_j9H2nghK_XfepNA>
    <xmx:rtfJZRno9kqKCBzZRT6XqbJ9o_MOFZPYq7KOViYDXGGuf4ZyAJuiFw>
    <xmx:rtfJZdrXQPxh9DjxOPJ4EGUMQr-uUVafsfqoeU0y6ciRp3JYJUnExQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3c3293f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:28:59 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 4/7] reftable/pq: allocation-less comparison of entry keys
Message-ID: <fd09ba70fe16216114781dba9dd4d197bd0c4258.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QHlciGMLwROek3H1"
Content-Disposition: inline
In-Reply-To: <cover.1707726654.git.ps@pks.im>


--QHlciGMLwROek3H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The priority queue is used by the merged iterator to iterate over
reftable records from multiple tables in the correct order. The queue
ends up having one record for each table that is being iterated over,
with the record that is supposed to be shown next at the top. For
example, the key of a ref record is equal to its name so that we end up
sorting the priority queue lexicographically by ref name.

To figure out the order we need to compare the reftable record keys with
each other. This comparison is done by formatting them into a `struct
strbuf` and then doing `strbuf_strcmp()` on the result. We then discard
the buffers immediately after the comparison.

This ends up being very expensive. Because the priority queue usually
contains as many records as we have tables, we call the comparison
function `O(log($tablecount))` many times for every record we insert.
Furthermore, when iterating over many refs, we will insert at least one
record for every ref we are iterating over. So ultimately, this ends up
being called `O($refcount * log($tablecount))` many times.

Refactor the code to use the new `refatble_record_cmp()` function that
has been implemented in a preceding commit. This function does not need
to allocate memory and is thus significantly more efficient.

The following benchmark prints a single ref matching a specific pattern
out of 1 million refs via git-show-ref(1), where the reftable stack
consists of three tables:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     224.4 ms =C2=B1   6.5 ms    [User: 220.6=
 ms, System: 3.6 ms]
    Range (min =E2=80=A6 max):   216.5 ms =E2=80=A6 261.1 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     172.9 ms =C2=B1   4.4 ms    [User: 169.2=
 ms, System: 3.6 ms]
    Range (min =E2=80=A6 max):   166.5 ms =E2=80=A6 204.6 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.30 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/pq.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index dcefeb793a..7220efc39a 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -14,20 +14,9 @@ license that can be found in the LICENSE file or at
=20
 int pq_less(struct pq_entry *a, struct pq_entry *b)
 {
-	struct strbuf ak =3D STRBUF_INIT;
-	struct strbuf bk =3D STRBUF_INIT;
-	int cmp =3D 0;
-	reftable_record_key(&a->rec, &ak);
-	reftable_record_key(&b->rec, &bk);
-
-	cmp =3D strbuf_cmp(&ak, &bk);
-
-	strbuf_release(&ak);
-	strbuf_release(&bk);
-
+	int cmp =3D reftable_record_cmp(&a->rec, &b->rec);
 	if (cmp =3D=3D 0)
 		return a->index > b->index;
-
 	return cmp < 0;
 }
=20
--=20
2.43.GIT


--QHlciGMLwROek3H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ16oACgkQVbJhu7ck
PpSp+Q//borPEsTIYaTK3MH0H/Vncxx4btSw6RwdDqQ69ZBiCuJm99TwTIne2xrM
8Z5YqAWzfiw5k8m56NpN7wavhTUd3h+VAshtt/EEedMIFcRs10JW49i4ZbcWaA7j
Tv+k+1HOyNj/4VMHSMbubrVFqK63+gy+1y4d7q0CAUjRJ6pJP5XUamc2/R5Vq566
F+tQP9CQYrgXEX/JrAeioAjqYYVNfiW4eE73Lej1f0VZ4SiseP7C7SrYzAzlgXPx
tSnPrgOd4U0RoGNkzPM+D9ymZvDPqDy3O8Y5b73Z72HEbd/dOlzAuM3Py5vftCK2
FX5h3bJ0KEttZuHZRKutjEsb1fLlKtbp221QN/jimMVCpcD0rONPovbg2neM2B9y
Nb1BrlxIEIoaSZ1S1m05A24lwfJRGWylTnV47s/YN9uhaTbHDAbix+x2nQJrXOfw
uTVMxWr63EfH8znKseujyEg+3iGcVfBiJfHDsZhYGcRmh1oZikle73llMz4JrWOh
3I4pVFhptFveAO2+rbLflJBspHok0ZVLJ7fOUso2wUGMkM+ejdwke2IlqiyPorrr
0N91b8VDRElz8CqcF+TGiOXmG84Zv/8laRgaS28DJ47KQGK3o5uQe91eSe3JsxXN
xow8SRhCP64shgtMFkGsNw70TnNQtXfQjjPAOgrD1Fsy3wzUBlI=
=b5uu
-----END PGP SIGNATURE-----

--QHlciGMLwROek3H1--
