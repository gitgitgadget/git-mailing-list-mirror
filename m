Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2C15B964
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783116; cv=none; b=Ynv6PgSwuDwxb253pJtHFqZlD2vK/7yOM/wAQIPJLMsDcLYujCeUTssV+l+RFEXNiNQqQ+qoc6/k7k2PS9UcjpdgQOzz86PsLEUypO5ynYnpJ0RkSvWb+ig2EkywsXxDzVRJkifSYhYl2jAhKwqgs2O4U71KvioFjaCh3+9g5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783116; c=relaxed/simple;
	bh=OsJ8/eNqG8jcNoZ95dVKdNW714/2RfGsvyCXIA6aLzw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK2nsRZQRGbZ2l2QU1Ty/CXm+xjeXL0EgkOxSeJbftDASilIqrYssgSnShbZIT9KT4DmAWb/UGxVT8i8mUJFRwD04LdUtDt1xMyPO9/wTctmnBOU31QQ1M0zd5SGmy+OahIa41Ic5CZTXoIGsqB94LvBixk4ikaGeMrOgU0Sofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gWO0F3EZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V4SZSBSb; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gWO0F3EZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4SZSBSb"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id D5C6A180007A
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:25:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 01 Feb 2024 05:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706783113; x=1706869513; bh=TL7nbh2/B/
	7RlZEt8sHbJki5BX2GEwIlzPMIot3hJc4=; b=gWO0F3EZLM5MDU2m0HCJpUGFcE
	sVxdFnu2a9YnghemVsbJEXkdMJ25sKIypaIZ97npmrrh9KD7ajxyDHcYHdA8wX+8
	Tt3HP0sbKOmxsvIDDZymxA3j3vaNysawlJiUFnJg13B92KguCynhrScw9SG7PCu0
	xfWj5d8qQGENBfQxTSvfHfT07tDOGwZwMh1bURwaRiWW+34vu2I2+VAaYXa+mE20
	RYDOFfpLmnKaWaPQrcGwBi6lgO5j+SB3IVzppizVD5gA2N+1phLDKzC7IilvbJvA
	HUQb6gWgh4dx9xWPvvAyHT8Wk/MN7AU8AW3whvg7iCZGQu4xKCtDJp0AM/sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706783113; x=1706869513; bh=TL7nbh2/B/7RlZEt8sHbJki5BX2G
	EwIlzPMIot3hJc4=; b=V4SZSBSb7cbTiNnGQ+1/UacczfQDQLnJQwZWQCJf4KM4
	GI5Re1AT2LNKTbahnwq/t+/JCYQ+rOkL6CbeP13VRQvB8VPR4DW18FtihhUEKTC2
	GMSDRUy1twfch8l3vt7UYQhHLj0gpjlQzKSi85Xu9kn5+xxi/S4FHUC4Bh9nS287
	Bw0xdcB+YCzmzkF4AY2uQgyd4ExhrWVIDUFf82sY1RL7M3lu+N9Dd62c4nyRbTGn
	JhkJLbHcFMBH0YtTUc4UlmACDaB0tfeKfi+6Ii3gTBf7NhbgZRHgnjYB1GJIZZeQ
	8C9nNStzriQntHxiwAajpp+4mMrc/iZJy8vnlFTbzQ==
X-ME-Sender: <xms:iXG7ZWjISmipbRrkEiGi-QjddAydLQaCaPcl-g2CvoKz5a1vV45Xxg>
    <xme:iXG7ZXDgus8eiXZA1yt5If9wwIuIxoMhZFizIxqR3TttfuFPmbBhro2fDU07wc61z
    GT7LqW7Ez8iwN0TCQ>
X-ME-Received: <xmr:iXG7ZeGH1lYj0_UDxYQwKIjE03qivOCOVbV1T3I-bgtnJkANnRdbGANNgSn4RyQbnStGc5a1aa9gzxVDUea_Yrhw-tFeZiEaKLdWHcq5Raa_gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:iXG7ZfRsu118akH4vB4f_cne5JaoQwZqptOspmud_ISo5GeSRSJN8g>
    <xmx:iXG7ZTxg5JF5WPs1JYDDG3adl-ZpyH3t8PB7voOsIPJ5ZnTQtnHW6Q>
    <xmx:iXG7Zd596Yx37iVAXslXdbJ677N0EMHqLpELv-CifbZ-yNqA6Bp0xg>
    <xmx:iXG7Zcqib-SOtE1m1P0EI3rpkKiODRRSbrgB6nCRkP8u68yIO_4C9yp23XU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:25:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c318743b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:21:49 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:25:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] reftable/pq: allocation-less comparison of entry keys
Message-ID: <1c9c19a3b3daf9690fda0423c52da33e337c8b54.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="21GP2NAu0M8dRhdg"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--21GP2NAu0M8dRhdg
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


--21GP2NAu0M8dRhdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cYUACgkQVbJhu7ck
PpSkbQ//TQMZTrwftIQEfRiUhmdzEUl2TdLpeb51YD3GC5IPQgppUQtlMajR9HBz
AfAbKFG+cem58Gy/eTkKrLxzUqoYmxhCCkGUgcZO2s0PCsWR4Aaq+1N41Dhk6eLH
i/9g5u7ERKisQVGSndYsGW9q0FFqnz6rUvGlpaOucb8KW/5ukbRRqAT6DJ1PcX5V
I/aj4ClQoyCzqFFYk3mehdvfEbVkpKTvqq/HuaDa1D4ky9sIJSrZIA6mMCXXIC5x
ZFZEW8U/fMdECWY0FRQ49DRwAm07NKJfftDg/V1dtXkrSbVjpP0y1t2ujabMQwQJ
nOMDT2QPhQftnWZLe1B10H+2mYU9ElEOTurENOFtW8Tvg0falxA+7R8XpAqcK5q/
/DZuHOj07mS3lOSzL4UcfOPcTKxCMxr4Am/fzH1FxXepqOcyZVznX6rTvVkJcOhd
oBzEQecdvFDSParse6DPkKIsccF/rZJH57SQwG2CWPtm4Ne3AXhqf2v9QigFssTT
8rHDSXwkcab4cGSietqghngBybdjETPVPw4E/ZnUv4OM2A5YdocPlDqqRz5nhP4C
1zR7dJRAv/Nf2NQpvWwy9ymCdc4NfysqMjSAl96oTtwg9INJA14nwxvuCSPoxnzq
eJBRsdaZ3EYlDGKofp/kTm97bFf4qNH/RSrpselbajJVY939idA=
=1UjA
-----END PGP SIGNATURE-----

--21GP2NAu0M8dRhdg--
