Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548B171C1
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896778; cv=none; b=fp6AQh7J3rkc6bA2YFbvfijcRu6USOLrV2Ro0GiNDu74TGp7vqYIlY2heKRNeH5MI+TT0CAt2scEvIt0FOUBUlEE8UJz1ZU0HZD+SitpqQm7PcPp10ePPiodspG8IOpPTf7u6EokVHqSSzXb3jTNioqo0E7BvDypYFex2aGS0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896778; c=relaxed/simple;
	bh=BkriRgWFHhuRf6k9Qr6wYGWAzSySTdkHtu1uYYhMeY4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDtDz5KJHQLoKEg7bPCNKuBEZYyBcdy5HbojJ7+vZ3NkkA+NwrBt4oyAN2obDuJ+yKv1+XHxkXKNF0k6O6yMgGoPfwf3C1SN2uXVjAx7S2HrAZcQispuPwgJZT79qRf0qh5QuVqjDOdirbwKagwdivge4sMnbxw8F4R+3/Okd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OFGWXQzo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HO86E0aZ; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OFGWXQzo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HO86E0aZ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 84EEF1C0007A
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 14 Feb 2024 02:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896776; x=1707983176; bh=HFjvEVaHsu
	ydKXrQ0rx4LbNOMFNLcqCmGAFSIvvVGH4=; b=OFGWXQzorY1evhMLGl0dfbKewt
	kmpo3cofJuZEE1zhaXEJKyOit3/z/bj/OZgS5X9WYy700Gk0FWAwlX0omFjIrQpl
	kqInNUgT3dIwAITjAILrEpcaNdyBmxX+5OmikFboNCQ0hS72IQW+0udCY9dwWeMC
	Xml9ayi1hab52Be0JxVEaMbKfxMuAtlZkYoG0VyjAT63NV0R3WyRER0T3zYM8wmN
	n3y5nAxSaoDweJAOZlugITO8Bg8wjjwVdXrIgifjKJqejMWHz1SW1yZHji8NFUHP
	M91l5ahvn1w2M73WRMQqXpI6cK27XlB7uW5D9XNaLRmBCDM24nwBZRFc+EMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896776; x=1707983176; bh=HFjvEVaHsuydKXrQ0rx4LbNOMFNL
	cqCmGAFSIvvVGH4=; b=HO86E0aZ/5HqXcRgU9uwy7TRgOR0q5VvOFwAiUzoG0WH
	gK+sTzz3cbIAMBWAe1sDdwdAtO0EqeHZx8hbvpqVIp19QfYTJqzrJFdll+lKNSW4
	kUDPV971GV+RCdfEDx3e3Gu1Gzn1tVSw32YOh0Zxto/jD+Cl8EfmMGSPPC6de8oE
	nq8l3rzKUJ4c6pqWsmcqY4zo3djDiRcJ4BHEDLfodNUVDgVP4RJVniJxZfPYEfva
	qp8mCyFcLdbZ1l8ExIcH+0lVEt55SC7hGOiwg6M1K8D1Q7zb7dHM5MMMMzMwQCxa
	tLA7BTINHENMWuvD4+tEX2mMTJgvbclxUZ6o29GaCQ==
X-ME-Sender: <xms:x2_MZdmsNMup7AJGrykv2Oodq2fPHj92NZTaazXP6ivlQI5d_LQqOQ>
    <xme:x2_MZY2quqYl2nf2acz3wYD_nacqk5ujpI8pXy0SpO6TBLkQSCv7TTu1gltMhsfi-
    MfPMmB2I9sK2j4ljw>
X-ME-Received: <xmr:x2_MZTqkESozPqX7m5WZxPKDT603M4pH-yj6gWixSSlzCVhXErsvYTOA_eWBdOlKlHoudf2lph7wIH6hHL6a6PecSKvFYeqItPMuljVSoWiMJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:x2_MZdl0armyoqhUqjduOCSzx-dgqp223umarCDAEOnNhYNxJR7RFQ>
    <xmx:x2_MZb16nrmhtQ05tJMH7vTpkP_777aCLP06ok5HEFKN1YF6MmqDpQ>
    <xmx:x2_MZcus4vdto8pLxInMKBFIKYlI4f6Xo64x4gG5Ovsoy4AHHTSkiA>
    <xmx:yG_MZU_i_8p0uzGdlROiYdtJf9su22u57KxuqYGceWve-LuBBc_XDMptlZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09c62488 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:25 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:46:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/12] reftable/merged: avoid duplicate pqueue emptiness check
Message-ID: <68bd6871132bac3ff8d67e908dd31647feab6bc3.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qn9pEIdQukjaOADg"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--qn9pEIdQukjaOADg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `merged_iter_next_void()` we first check whether the iter
has been exhausted already. We already perform this check two levels
down the stack in `merged_iter_next_entry()` though, which makes this
check redundant.

Now if this check was there to accellerate the common case it might have
made sense to keep it. But the iterator being exhausted is rather the
uncommon case because you can expect most reftable stacks to contain
more than two refs.

Simplify the code by removing the check. As `merged_iter_next_void()` is
basically empty except for calling `merged_iter_next()` now, merge these
two functions. This also results in a tiny speedup when iterating over
many refs:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     125.6 ms =C2=B1   3.8 ms    [User: 122=
=2E7 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   122.4 ms =E2=80=A6 153.4 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     124.0 ms =C2=B1   3.9 ms    [User: 121=
=2E1 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   120.1 ms =E2=80=A6 156.4 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.01 =C2=B1 0.04 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 29161a32cf..f85a24c678 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -148,27 +148,19 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	return 0;
 }
=20
-static int merged_iter_next(struct merged_iter *mi, struct reftable_record=
 *rec)
+static int merged_iter_next_void(void *p, struct reftable_record *rec)
 {
+	struct merged_iter *mi =3D p;
 	while (1) {
 		int err =3D merged_iter_next_entry(mi, rec);
-		if (err =3D=3D 0 && mi->suppress_deletions &&
-		    reftable_record_is_deletion(rec)) {
+		if (err)
+			return err;
+		if (mi->suppress_deletions && reftable_record_is_deletion(rec))
 			continue;
-		}
-
-		return err;
+		return 0;
 	}
 }
=20
-static int merged_iter_next_void(void *p, struct reftable_record *rec)
-{
-	struct merged_iter *mi =3D p;
-	if (merged_iter_pqueue_is_empty(mi->pq) && mi->advance_index < 0)
-		return 1;
-	return merged_iter_next(mi, rec);
-}
-
 static struct reftable_iterator_vtable merged_iter_vtable =3D {
 	.next =3D &merged_iter_next_void,
 	.close =3D &merged_iter_close,
--=20
2.43.GIT


--qn9pEIdQukjaOADg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb8QACgkQVbJhu7ck
PpR7OBAAgjjxpj3gjG0Tdqu3SQTUycf0zxn5qoS5RNdJRnvxhvvP5RmgbYIQWUaZ
ekuP9bY0fqCu4KkniyMlmpTEKh37EV7ko88ga/xVJGX1lJ90uaqUOfAzwEHnJu9+
RVlf8c0wSOGKf6LokM9zqxS9VyB9csWiL7Ll6YrJQQf3O59sZhosl1BmAj2FIOoT
8+1ERkGnm8ocESlcY8PnQja8MNU697ld5+pZPswe2FeofZauqVSrR8ngOCLK7mKs
c8cZz95FmGaPkxbdsqeLrjZyHFifcut6xLr2g52eMVULjMK5pvxb/zqsgxyZSAuy
VEbeSdGXOhhLh9Akala2beiQJpPTcBysZw8wmelFwC83jrEsyK+/GYd6Cle7sR4O
PqKJcEIdYH8DBKXaiW1YjHMYAsqOYpfRC3mKXm9/7BDbmLcaoYh1jQhVCQt8Uobi
+QI59HGc8mGC5DyIVSaLpHaLI/qmHT9MIcRftazZdxkDNS2Qge4glGOTpLyeihCA
QJfgsFnsx/2RGkkZ73ses8pe3AcfeJPfP8SU2PH1aSkp0t4gV7NLZn2RtwNB83Y2
qOKtlK7GGaTjzmax9fA3Tg2m36uaLhDg25Cv2sbcZ6sFeQL3jO7urY6LoMf0TsxF
CDmRThpeoTTj3jtdPPnHuIulu0AK1eH7AHCRPZa+jzka0HY8TvU=
=ynYX
-----END PGP SIGNATURE-----

--qn9pEIdQukjaOADg--
