Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCA535AC
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209727; cv=none; b=UycRJeE9UZdzxOzhCH8s1xTy5I76RujkJdEAxOj86g+QrRYHJOsQpvwYRodR6YFw/+peX6XsSQjNPt8RAYcG9iZTOOPymL3ucsNO0Domv4phkc8ajfVYctFX6uIduG7ncJ/InkOpV5zfTV+FYlMmJKR19lhQK3yuPDC2iNPqCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209727; c=relaxed/simple;
	bh=TFebjWOrjwfMLSKxdRMYEOrZLuB3v6Xfhlqt81SIKp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8Fe2jIAA8IrA32wpLUBq684w+PGrpR5zI4dzI9S1uLQvwMGQMhoEtz44bsYIiiMH/++NJ+r43lui7hzgmutgG+uGWdfU/nEoco1rJ/7hVqtlwa+jeXi8umY2lRJ7y7D0fgjI8e/OPE6+5lrVyok07O2+TjYLUPt2FdgKGqkQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mZSPRXer; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XREn4TAC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mZSPRXer";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XREn4TAC"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4C13111400D9;
	Thu,  4 Apr 2024 01:48:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 01:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209725; x=1712296125; bh=Fj+aC1CQfh
	vJZqf2UmbsP9VMgSqcemv2VQhn537kHCk=; b=mZSPRXer87cVDfrTjqClwhkwKg
	P0wejA4D1JLnT4l7SWzLM3wx4Ylr/YRY1zERzifhec1Ltge5G16E/BXI1HRd/fSu
	LZs9iCb8l/ghVjhAIWn4t6w4TEeNaMcP3dqm/4rYmCiDM1z5kWs0B8/GYUs7hvw3
	kIqTuxMcOt85PWyEhjO2Jnc5PDBIDC0aI4GWJfEfSVpZhbzsJgk82dASKd5rdfGX
	DgMKF4ps/7ZR5p/c1CFiFcJKtducw7MLRyCbB1Yc5FpCnZbuKdWx9+G5XcL7Zqrd
	UWC0/iJ8fG7Capf4pCkL/MgH9XJbHCQLCbEbizz3i9YXEtApNZfP6o8KHKRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209725; x=1712296125; bh=Fj+aC1CQfhvJZqf2UmbsP9VMgSqc
	emv2VQhn537kHCk=; b=XREn4TACc+CUC46MdjAuNfkSyb+8Gl5Ud8p4izm6+Qn8
	yHKSp7ASzEFJIm4iANCimy4ylXoST8YVJI+WZqT2Ss8eoF3jz2R7kwb7JjpZaCek
	VXLtWjRVbkFwyG0JvG6MKxjktYefr+klxmhIMBYiMZ7Em4XxXY+wWtlQIQt2pLwX
	Dpjsi3j8o/zPg9pgC8A6r96LneqOKqqe8DpxAP85iyf/BNv6X2ODDZ2DIgMPmBdV
	yaNh1zbc5Jv8wtQilrcjPZYhSCzmagFD1ye58boTGjbATLyhnsty7jVKByG1tgqo
	LGGMRrJsTbGRjxqabneS9/GXyUo9PSOJfynCUHfotA==
X-ME-Sender: <xms:PT8OZmIOnMKRRjJ2kJTvB9y6uq1Q_Kcwd_2J8x668-j6HlpUoCAc2A>
    <xme:PT8OZuJHrJdB2113djdSnKN6SZVK0fkYsk_VMyOf4qOzllHaqJ7UQD8amEJY-TjmV
    P4zXLGPFUhbDrRDVw>
X-ME-Received: <xmr:PT8OZmv_p5RODx6F45aNRxl0qCbiLKcKOO6RQp7riMtLxzIh-hC2Q-fYm7nSfJRQph9hyi1AzUXL0AjM8-5g3Vfg915cdgXfrmVQas9DfCtFdCQO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PT8OZrZOicDKq_s0nPl1lF99aJFtHNWXs0N1Z5mV90Zxyb4I2VgP_g>
    <xmx:PT8OZtbLOfdiCbC7TR3gsNt4t1Db_klJiVbI3K1GVNThlSArxvwb9Q>
    <xmx:PT8OZnCq7C69rS-Oyl8twEUOxu_2IYTsVb39J9mq-pkYJTPD2WupLA>
    <xmx:PT8OZjbDwk2E2s01bmlMOmlR-T3ibgcKNTSyhW4Wh4RJRrrA6Oa3Aw>
    <xmx:PT8OZsVCGRPZeNVFQ1Oe9OWn0DAN1IqUa5xoWrOGEg1MQ0oOdqfgRm7c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dbb3180e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:41 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 09/11] reftable/writer: reset `last_key` instead of
 releasing it
Message-ID: <e5c7dbe4179c38aab5fc218e4d5fa855fc8f92fa.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eXpUyFzsJPEL38j0"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--eXpUyFzsJPEL38j0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable writer tracks the last key that it has written so that it
can properly compute the compressed prefix for the next record it is
about to write. This last key must be reset whenever we move on to write
the next block, which is done in `writer_reinit_block_writer()`. We do
this by calling `strbuf_release()` though, which needlessly deallocates
the underlying buffer.

Convert the code to use `strbuf_reset()` instead, which saves one
allocation per block we're about to write. This requires us to also
amend `reftable_writer_free()` to release the buffer's memory now as we
previously seemingly relied on `writer_reinit_block_writer()` to release
the memory for us. Releasing memory here is the right thing to do
anyway.

While at it, convert a callsite where we truncate the buffer by setting
its length to zero to instead use `strbuf_reset()`, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 7b70c9b666..32438e49b4 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -109,7 +109,7 @@ static void writer_reinit_block_writer(struct reftable_=
writer *w, uint8_t typ)
 		block_start =3D header_size(writer_version(w));
 	}
=20
-	strbuf_release(&w->last_key);
+	strbuf_reset(&w->last_key);
 	block_writer_init(&w->block_writer_data, typ, w->block,
 			  w->opts.block_size, block_start,
 			  hash_size(w->opts.hash_id));
@@ -478,7 +478,7 @@ static int writer_finish_section(struct reftable_writer=
 *w)
 	bstats->max_index_level =3D max_level;
=20
 	/* Reinit lastKey, as the next section can start with any key. */
-	w->last_key.len =3D 0;
+	strbuf_reset(&w->last_key);
=20
 	return 0;
 }
--=20
2.44.GIT


--eXpUyFzsJPEL38j0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPzkACgkQVbJhu7ck
PpQ5Cg//ZXKqsqUQYD+xPUCCDVOttmJxjSWbdWrdlG3vMnsqDdTc95m8fSTj2SP9
xIL5zhTDg8koy1kQRvRxjKNDsyUToEEBuQGApv72Cm+usPzhXsVqZR8/L0N8rIJA
4iBcpS4iexgcKt8n6VV8F34q7zDqQt5SssuDl+ZiYueouEXvhBXdTMlsJq9S6gRi
yyBiH/ShDYAGrCwDz+gRBwLczzsNW9K45cbFhUOE3U30alSrJFkh0PIJoN9iYKlI
Nz96cEO8lmOvHa8AtVXDfPn+/hcds6FkAau02MXcdxRSo+mq2aBk3Tri8KmJJyHA
bpsV7BDdvQX6h04u4/CEPIU7RA0sbhRwAJoKNs8CfRBZPhzSzYnZvDatSrmTd451
41zKkU3xq6bE1d3rF1ge8qSw6aPmZK5IgL/n5XZMn5/PKZ9h5VOcq69nH62nYhqf
91Y3al6hL2/v5A8SWHztqXBPtFh8D24lES526HM3PF7WPZNAPjkxnLpLip5QXxqt
nB8ygE0dD0YwyfRdw9Affx2ahiDxhvOH8owur7ckZzS0W11Zk14VHpK9dliTQ0+e
ThSpbzcyo2SU1DaYGrB9tB5K11CpKWe0zh+R+WxNb2BV3Ob4/wEd6OYMugGBHdRC
hqrNztBw0xKz/ZbCMI9EtPgJEZq3A23AVLmyNZuTbQIlQCjWKbY=
=02Vs
-----END PGP SIGNATURE-----

--eXpUyFzsJPEL38j0--
