Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AE15B990
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783108; cv=none; b=EwStRGkDy4c0Q7EDMNmROsLlLPUceaeQUjsTp8xSH+1QWkQjwGgcwNf08n4kqDTKRurA6atAsLVIF0zMhEeVJkRqLcMOEAn89/7x5bKIX+VL4TeJbnGTue17Fefsd5fRElYgInf3v9VslssKt2UULCCC3hpd+KygqHX9NdJ2OKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783108; c=relaxed/simple;
	bh=0mp2WUd2epIIoEhc6vE0SXtPS7rLXG2Ojz9rCgy2qrI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKaXt2bSa2vvA093NdeD1vgixHd6b8nspvsB1vpEHQsPY7FJq6s72A5G53LjXPLe0Z4fQi2isF0NuDehxpfmMDhuKI4f2Lzoa3TgQZTdkN75KeoJZV8GUrn5CEhzDI6QSSTAIhuY0SHEMtDojFWa1Minw7WiLfbVSYI8IpM/ZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k47CaNFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovAP9mJm; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k47CaNFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovAP9mJm"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 23BB63200B1C
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:25:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Feb 2024 05:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706783104; x=1706869504; bh=oohmreglTx
	TteCMuyKsk6GVYX+wxqA2vk70Tz8xOXxs=; b=k47CaNFv8Frf7UIDGEyM3dsED1
	vJpajsGfMVcrgaoCErvM3Xpw3ASip5CE9YOPMhM2xwkqQNqmMeGDaQpxHKgiwIPs
	DNUT5p12LWjG8RXFYx7lQmSPjvmu4n+LmrQds12saoUihqGA+hP9hAYGLcrrNEkh
	sPiQiXqsNHA7Zkx+9t87IVd721T6kcpHqIwZVoaJh0XRzNu8yeyOA2m5TbBPIpRE
	mTLG1bOfFBLdA6Od7SD9ipdD47YRjdEG0rFROj/IX+zxSb8T/VUD6YXXVS2FSyrc
	BDSBVaoddyZwSTY85wz4qJbqCT829H4vU2FjeYQD8nDhHbTbFH/TDWSqbQcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706783104; x=1706869504; bh=oohmreglTxTteCMuyKsk6GVYX+wx
	qA2vk70Tz8xOXxs=; b=ovAP9mJmqeYmXBOUjsFymGQITg+5SPFIx9qIhoDQECxF
	Eh1WxDY26B1+S+8hT8tV0alRM3On6y8LvpNFdzY+sa41LAm9QxO06RjVVQ7oEf4y
	UwmwDt4jNPVylDHcirD1Kz7Sh5KAOzu4LcDYvdj3a/dGCThx1Zr130KDG2nGV5x3
	nQL2TLefvdtxF9Wl7GA3WYvfZDYfuzFBAJ2dyS2iaKyfOX0/y1dC0cSCbOsmPCGs
	xvgAzax1dG9uPi4kN2e5swrWIFzPZF5xAPDD8Nj82lG5DgrCe48COKxxs6jZrnQo
	+wO9IvBy6BcjtCOwGNlym2y7yr9O52tIIi2gwPiHzg==
X-ME-Sender: <xms:gHG7ZaxrTU7W7wXndmOYAIHYkdrRQydIH9Ab4qJvEF6OUlQ027YGrw>
    <xme:gHG7ZWR8OZg21y6CXXW41omFhbEDX1l65kEWxb1isfBE5mOf28JCEog3LWWGnB6fH
    m8ohh_xCUUL3g8O4g>
X-ME-Received: <xmr:gHG7ZcUmzNHGUYmNQvlzlP_l1Yv0j0lE8S90OIMU05wi1RHO2dbk8Ls9_yqx7s33wqDNLnUpVaD6FJjXAL0Fy3SSUyJ6uXEg1Dz-Lij9xdpw8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gHG7ZQjsQJcgsFnD-IHD8HYF8Gm9xU62CY2uFxlFVi4pdedkKo6mVQ>
    <xmx:gHG7ZcBzV35JpFcEqdw4ReKViexNB0cC9ldLRaRuOfHWNEIWV5jSoA>
    <xmx:gHG7ZRJlIROG0g8srm0X8w6fRXwNrTWe8zYGr59m1DzLPvLh-Yi0ow>
    <xmx:gHG7ZXp3K_UI7Q-7vXEMlfFWOuyRqKeGM3eanFYrNbktT-zBGh1TLA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:25:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8240fba4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:21:41 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:25:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/7] reftable/merged: allocation-less dropping of shadowed
 records
Message-ID: <576a96f2e5cf462d2f5793a0c8244f4966789654.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5J2bwb7ljdts5QQw"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--5J2bwb7ljdts5QQw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The purpose of the merged reftable iterator is to iterate through all
entries of a set of tables in the correct order. This is implemented by
using a sub-iterator for each table, where the next entry of each of
these iterators gets put into a priority queue. For each iteration, we
do roughly the following steps:

  1. Retrieve the top record of the priority queue. This is the entry we
     want to return to the caller.

  2. Retrieve the next record of the sub-iterator that this record came
     from. If any, add it to the priority queue at the correct position.
     The position is determined by comparing the record keys, which e.g.
     corresponds to the refname for ref records.

  3. Keep removing the top record of the priority queue until we hit the
     first entry whose key is larger than the returned record's key.
     This is required to drop "shadowed" records.

The last step will lead to at least one comparison to the next entry,
but may lead to many comparisons in case the reftable stack consists of
many tables with shadowed records. It is thus part of the hot code path
when iterating through records.

The code to compare the entries with each other is quite inefficient
though. Instead of comparing record keys with each other directly, we
first format them into `struct strbuf`s and only then compare them with
each other. While we already optimized this code path to reuse buffers
in 829231dc20 (reftable/merged: reuse buffer to compute record keys,
2023-12-11), the cost to format the keys into the buffers still adds up
quite significantly.

Refactor the code to use `reftable_record_cmp()` instead, which has been
introduced in the preceding commit. This function compares records with
each other directly without requiring any memory allocations or copying
and is thus way more efficient.

The following benchmark uses git-show-ref(1) to print a single ref
matching a pattern out of 1 million refs. This is the most direct way to
exercise ref iteration speed as we remove all overhead of having to show
the refs, too.

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     180.7 ms =C2=B1   4.7 ms    [User: 177=
=2E1 ms, System: 3.4 ms]
      Range (min =E2=80=A6 max):   174.9 ms =E2=80=A6 211.7 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     162.1 ms =C2=B1   4.4 ms    [User: 158=
=2E5 ms, System: 3.4 ms]
      Range (min =E2=80=A6 max):   155.4 ms =E2=80=A6 189.3 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.11 =C2=B1 0.04 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 11 ++---------
 reftable/merged.h |  2 --
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index c258ce953e..fb9978d798 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -51,8 +51,6 @@ static void merged_iter_close(void *p)
 		reftable_iterator_destroy(&mi->stack[i]);
 	}
 	reftable_free(mi->stack);
-	strbuf_release(&mi->key);
-	strbuf_release(&mi->entry_key);
 }
=20
 static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
@@ -105,14 +103,11 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	  such a deployment, the loop below must be changed to collect all
 	  entries for the same key, and return new the newest one.
 	*/
-	reftable_record_key(&entry.rec, &mi->entry_key);
 	while (!merged_iter_pqueue_is_empty(mi->pq)) {
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
-		int cmp =3D 0;
+		int cmp;
=20
-		reftable_record_key(&top.rec, &mi->key);
-
-		cmp =3D strbuf_cmp(&mi->key, &mi->entry_key);
+		cmp =3D reftable_record_cmp(&top.rec, &entry.rec);
 		if (cmp > 0)
 			break;
=20
@@ -246,8 +241,6 @@ static int merged_table_seek_record(struct reftable_mer=
ged_table *mt,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
-		.key =3D STRBUF_INIT,
-		.entry_key =3D STRBUF_INIT,
 	};
 	int n =3D 0;
 	int err =3D 0;
diff --git a/reftable/merged.h b/reftable/merged.h
index d5b39dfe7f..7d9f95d27e 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -31,8 +31,6 @@ struct merged_iter {
 	uint8_t typ;
 	int suppress_deletions;
 	struct merged_iter_pqueue pq;
-	struct strbuf key;
-	struct strbuf entry_key;
 };
=20
 void merged_table_release(struct reftable_merged_table *mt);
--=20
2.43.GIT


--5J2bwb7ljdts5QQw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cX0ACgkQVbJhu7ck
PpTI2Q//dxwds9yZ5Ooxp49BJGhtENPfH5Oq1nUmxnkVh48VAm/kv/FpbmCSz/UI
qImm0y2+DZxvkoHkYe/6nwiku0EFrvhIO1Cw5tyArCLvlaXnYfi5b9YyLtLQ++gV
R19p37l97TF1TCGrocqXHxfgcZD2Ao5IqC6aJQSoMU56VrBSsLjbLvtskPr3AUMK
759GE9yDu4GFlEG198T/7nTqAXFdMKa0AmjV/HsH6kFu9J0Zh7KGop5goe6XAkPn
kWQM0cqxgdnOT81cjBoKcp+69QwTtgTqp5R75wRTUmmrV4f/SJUZ/IYH1d3RmcKu
C6cTec1P1LoBKh3u5RAhv5lI5KS52xweB62gkbO+gYyMNyJr1sa7ief8mDzY1gWR
9Y1JnW1JS9dPIazgOvOyQ9ysPyzbDkbKDQCsappgtx1wnYTJDALceJ60ivMRm76y
ty8I4KC4xGH2OH1ngxgmxf1zo7wqyOsnoPmsbSC4Qk7GorAOWOBVLHxZs5Q6qgXn
fo7Ws8EtbypfZEsYlFVSOfL5+vXdyS40Xm3uUfvePoGTBuN25HBdEcRGxhrvcRd4
gSjPcsbcCd+3IY8rL9V6RctQP5JrDne69361WMYrb/Oz9gBWZWLn0JpXwkd17luX
SQF6h7X/6VJiHGfjTzjkXiJPGO2/qx4I/LyO2uobSbQRvxxd+Jg=
=bvGe
-----END PGP SIGNATURE-----

--5J2bwb7ljdts5QQw--
