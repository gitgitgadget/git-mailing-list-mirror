Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31A1B598
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265109; cv=none; b=LDn50PVpUxjvXCvtVmxTY+x2WKHLtgTnCtjJK47FguNaFKTTzfLwu83pSsbr38qOt21vXMGrKspMXpFlAR+50erTYa9NKK1Gj9ZgVJzbJGb/XOKKU3/zc1snJSJds98q05z4eWik/kC04bWu0JnjrkTmMxUvbLhtKA2ypkv3kzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265109; c=relaxed/simple;
	bh=OE6gNBxWsueAZ04PutfdW6Tz5UwRgWpNC+Zi5vjCL9A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ3V5zT98Ha18b+wyEVPqFK/bOMvZHjSWDfb95vVs0K2gelZKhK+ba0LEmr3SrYm6ld6+nDhqQRtrxDPDKWV+Em3+jj/6DZuinkLQgbr4PzuAYxLqTToCFOfwuGxszwk9QIWXFAtgUw6giBHUe21xN62LGUS+cKv83s74r/jD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MJVZiHNs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nD0Z8f0t; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MJVZiHNs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nD0Z8f0t"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 4323C5C0121
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Jan 2024 05:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706265107; x=1706351507; bh=dI1RiSYF/6
	3y7pDlTvatrs6i/PlQ4cfE/1tQq3ZzT5c=; b=MJVZiHNsaAcAspAL50s+2wCr06
	irvDEl7uzdSUVhC2sYssLYQUFKzla1cO7bH2sl7W5vrhIIrcwfg8w39LUmY6FZRh
	dPIU5YESElOQ60jzlGkvj4B1dWLZXiEUdPoBd8RcXp2I5GCBQC7FwbYrvWRfpXF+
	80UmPWXMEgy2bUgwzy8I1CpsH2nO70h3AUCRgceLSeXuSKCI7MarVkvTyriJzx3j
	dtdh+FoEqSjkeY+VpqpiVVqTpbM3WHH4S9oeAkYL4Jp1VtLOSQH4uuapCDz2UHQC
	UbZEISuaDmCZ+dSWTI89DGQTC0Ahml6Jt+C6g1oCk1K8Sxh2oXcyIflwd7ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706265107; x=1706351507; bh=dI1RiSYF/63y7pDlTvatrs6i/PlQ
	4cfE/1tQq3ZzT5c=; b=nD0Z8f0tAYoEEE8l6F1bH6rrGrUsHB/MmssSq6Ti3FAx
	1PWKh74nQvJjAYBevWElta9MbfJHrEnvyApwn/5JaJC0QA8x6O8s3NxR0+rp3uAH
	XagM8vZEUGrX7QUQdZwbZ04dfTRjCmIZtA4y4T/S0WGLaPp+R7aXiHLTALIYPVyK
	u8a2iJbqybNkxmrIj8wTePCpTnRAMbA3zqoCPRczSGSj6lZyzm9WpCdqYFJ+DeyT
	+0P+0aYCKu9eMBtd640LgX/zAM1Y2kpOZiVrunjIL3EZr/feOoeMhtRgHktP36BB
	4AYkTDJJYiBY8LZxpimcrW4XHhquDtcfVEceQH7VQg==
X-ME-Sender: <xms:E4qzZQA0t0hjEqW1KkCQqgOrspYGu1Y8k32eDEHc2aL05UFeF-cN0g>
    <xme:E4qzZShAr8b5ZRn3I5G2qluvpY5RK0oLHC-uZeA7pG8buqXq1yAbncGGxs7arJvwk
    j4QhgzsnXNxcKXlJw>
X-ME-Received: <xmr:E4qzZTmZgtiPMi4O50h9Qyl8YGFm_mj92-8F1MY-01x6_PLO4iPn8bBGn0mYfvDwtTUoKWDPaELyKsFTj5A1Uq4yU8l6aHBaAVOjY_Il6TlUoel99g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:E4qzZWzfs3jrSDBuNpMNHUay8VlFhC98v2luquMf90c7gKvsHdY0uw>
    <xmx:E4qzZVTtJNtyFR5m1LOgxUFT0jDfruuQ-Ef4Hbkdkx7ctAMS9gFF1w>
    <xmx:E4qzZRYhSZ6dlSQNKdp27Wjn2x5i_88lL0QFBa5tvZnxCDSmYkEMeQ>
    <xmx:E4qzZQNQ_ALWzAxwY0G_XyabEbVLgEWd7SmKL1BYZUShRBuTFWdzvg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85852169 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jan 2024 10:28:34 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:31:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/5] reftable/writer: simplify writing index records
Message-ID: <b0982baacf74a4501ce5c543b294bc15d6937875.1706263918.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ooy73kMXgL7P5x0/"
Content-Disposition: inline
In-Reply-To: <cover.1706263918.git.ps@pks.im>


--ooy73kMXgL7P5x0/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When finishing the current section we may end up writing index records
for the section to the table. The logic to do so essentially copies what
we already have in `writer_add_record()`, making this more complicated
than it really has to be.

Simplify the code by using `writer_add_record()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 5a0b87b406..2525f236b9 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -405,6 +405,7 @@ static int writer_finish_section(struct reftable_writer=
 *w)
 		w->index =3D NULL;
 		w->index_len =3D 0;
 		w->index_cap =3D 0;
+
 		for (i =3D 0; i < idx_len; i++) {
 			struct reftable_record rec =3D {
 				.type =3D BLOCK_TYPE_INDEX,
@@ -412,26 +413,14 @@ static int writer_finish_section(struct reftable_writ=
er *w)
 					.idx =3D idx[i],
 				},
 			};
-			if (block_writer_add(w->block_writer, &rec) =3D=3D 0) {
-				continue;
-			}
=20
-			err =3D writer_flush_block(w);
+			err =3D writer_add_record(w, &rec);
 			if (err < 0)
 				return err;
-
-			writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
-
-			err =3D block_writer_add(w->block_writer, &rec);
-			if (err !=3D 0) {
-				/* write into fresh block should always succeed
-				 */
-				abort();
-			}
 		}
-		for (i =3D 0; i < idx_len; i++) {
+
+		for (i =3D 0; i < idx_len; i++)
 			strbuf_release(&idx[i].last_key);
-		}
 		reftable_free(idx);
 	}
=20
--=20
2.43.GIT


--ooy73kMXgL7P5x0/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzig4ACgkQVbJhu7ck
PpRUUxAAiyKbmaLfeb+WU93P6kBlzHBCnQkhuZ03x8I4dhHdW90mdFP4wcd7NG2J
rAssxpqowQZMNV9pOCg90dJ1wztH0itu/+XUt1U5zgaWlQqbp2g/bz0xT3ZJ6WgE
Cg1pR8g+H02fhx6HLnykf7dRFYjexcq412Hcpsr3Jmw5yC6fw53IH/Uh4YeGRkKF
TRAjvr0LWxVghnRU21f+zsfmZF9xlmEjk+OXR7orsZOpGfq0bPwDqe1u6to+q/kw
lc/XZiUqH0i/cR7KAmajcYcr5ZFfL9lRiTosFcMTuDb9Xn5qaF1S90tGK1YIF8z2
3ilFv5AxO6TcKYkzj5rsv1pOGwpLN/ra+RTxFHEZGRXS/U0BVfk1n9lse7w97Pst
CbXcchD/2+5myMiUq5N9TAtsGwOGENLmT9y8WeFx8SjO33bm2coQ5U+BA0U+sWn0
XlrBmaJ6J0UKo0GaAISpFe80PFWdMh3KTLOjIBqoyoedVA9Qekekph5l609pRx88
Po5MyoMiN7MwE1yFHlpx7bipEooRbgeb7+52j07h2YtjylAK5vx1ttg6HkpUkMu/
JBjKe9QwsAwtjckLOCRJ21LrpPU/ca9sMAExmQd7jry8BjLdsop7wjGbe601ITFV
AH63Do52JClf5citC3dOtEIAQiUWXXuBZj/WNd1gZSiQaGR77tA=
=hx7i
-----END PGP SIGNATURE-----

--ooy73kMXgL7P5x0/--
