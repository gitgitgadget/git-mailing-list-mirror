Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB531586FE
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773930; cv=none; b=urL96k/MjqqYvMk4OXBVLiTZdaqX2Rx5J8DKyRlr/mJaX63gpzxcQX9Cy2+l9B6N1HTPZyQB6+NObEwRBCC3bGD3NF1Pqly2ec5rYX53YahtK19mR9M96ZYWwVMIu1hY7gU1f7pN0ESUDOQLtTA2himFcztZxDr9X0xVrPrNi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773930; c=relaxed/simple;
	bh=cbX34zuD64EuECwd3TsXdFD3/b8P9/v/p2nmTe1YxEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goRELJsfc9H+UrIJrr+6Lz3tiTrfsrC7QfEu9izREZ9Nq/BOYC+PcyGnprlD9Ep/N4/dasxF+8YqDfZ7SA2zaQ7isa0/p/hRzSD30SLD9EJTOKWaktLfMNopgKQb731baRkGpb3Aad2AtmAKBCop6un75EEY54c5Xsk2o8dUCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QKag0iiP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WO1Lv6Sp; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QKag0iiP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WO1Lv6Sp"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2D94F180007C;
	Thu,  1 Feb 2024 02:52:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 02:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706773927; x=1706860327; bh=IFt0NGLBHF
	AUz1Wj8tfSBcQpb4lj0WEM+nLD5hv7Knc=; b=QKag0iiP9/BpIthAG6l1Lg3HFP
	g4rbAqT3142as0GYTBrizHo/41bcXVPrD0f5p+IobXk170+SK+BZ6CnO0Y7MjoIA
	/qNMw34yf/B4abImGCJgTyJ5hxZCoCSribcC/3s4pter8X1JWaB1UgscpK/N8zOh
	PhUcMJqdSUzwsMA/zRgvLElV7PdFi5nGtlKBLsYio0O/I5KuwRcjv5AIVyUd23q7
	flGqaUoG/vzsxDBHem5xwUVCHChDELurgdIyzvxDjbeXAKiiTqxCC2qjMDajUelj
	yev+NM6ncTh67JETQJTjlZZq/fbnGgUo3XF8H/a4eiyLddrY565VSYvn0bgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706773927; x=1706860327; bh=IFt0NGLBHFAUz1Wj8tfSBcQpb4lj
	0WEM+nLD5hv7Knc=; b=WO1Lv6SpbfCJs67xIGqhIdEXwmwNvdCyJeH2QsXQCgT7
	I0m2fR8uRLJrPvEcZSulR+2VDhRuVXCmB5s+X5LG0O2tG/Y4L0J76kUoYDhvS9BJ
	VvAtyXodfp8Oz8aXAIR+qX8ig+ZQa/XtxbizqjM6C3z9C7IjZcQ9fQgCpraUKaMn
	QT+gqfcHFJlrmg8LLzleNq2Esr7zO8OAfh0W6QHGf1ddJMPSHn34oPRElyiwdE0J
	KQmU8hLR7WGNoQimFVR587NbC/6Fp3U9NqrWi7FjRYY/kPbtc0/TzsLNAo6SdRw3
	GMAo/UNwVC/uxSDQnmH74gnSfshc4ijv6oGEUzClRg==
X-ME-Sender: <xms:p027ZT-XEoMMi6kw-GpmdL0Gt0Xs8w96wK3zJfkcAeGxThq-Ofd_8w>
    <xme:p027Zfsb19omVGoB7R_xNYfY-KPsrG1hureYa6mzXgq86-LBTBetS6yDksT4eu_qL
    LOmaKviRbXb3L5L5Q>
X-ME-Received: <xmr:p027ZRDEft0vWGDIZO0vTJzEx82OFrWKAaYXuuVZwRZYFuQYWxlRIbCVrU7XKEY7tfydal--IoX8bpwu9d1bw9FSE5e0P_KdacTQ7c_MFg9FYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:p027ZfdGwxYuZV3a4qwVAR1U5EPxsddoIm3LMNtFhp83lJyDrB288w>
    <xmx:p027ZYPl3vyDFFjapLaGpA9URo5_R0aQ2h1zgnwFPuBcuxbcyV2Rjg>
    <xmx:p027ZRkHxpzk5n1XSzcpKIsxewIyf-nzef9X5_PUmW955SYmqJudew>
    <xmx:p027ZVr2EqCHSc5Jsppi680Fc0KkcLqrrzAaZqYqaskAjJWVDnLtpx5IH14>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:52:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d790735 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:48:44 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:52:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 3/5] reftable/writer: simplify writing index records
Message-ID: <b3de0b7f3b3dfbe9cfa6a20220e20cb884b3539c.1706773842.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aM+GqRsYIpeGC5GW"
Content-Disposition: inline
In-Reply-To: <cover.1706773842.git.ps@pks.im>


--aM+GqRsYIpeGC5GW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When finishing the current section some index records might be written
for the section to the table. The logic that adds these records to the
writer duplicates what we already have in `writer_add_record()`, making
this more complicated than it really has to be.

Simplify the code by using `writer_add_record()` instead. While at it,
drop the unneeded braces around a loop to make the code conform to our
code style better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 5a0b87b406..b5bcce0292 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -412,26 +412,14 @@ static int writer_finish_section(struct reftable_writ=
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


--aM+GqRsYIpeGC5GW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7TaQACgkQVbJhu7ck
PpSgyg//T7PsZgpOlNTCT+jTrpRjjm1Z8gI7PUZ9w48tIGSYb3s6U6u0RWBk957B
/8XGI427phJL+vCyJZbPGpEz0FEDhCmLUTVwMzmJgUgzP6KkLWpDxjGpPGZLPJXa
h4Ys/ppRQ9t6tK9HrHAheyDTqaq3HwCIetNwdw3A5OYL12pI7daJ1Pz1MXWzJuIR
BqVIHJmG8LodDqGWDZ0DZJfzcFIRp8dTy7EB+0kIhCfiw3Z/6woebzMX5ljEJnV1
uVQHAi4Hy5MwFHf4Fo0Vn9af0MbibdJDxSVULtrnFIsgVtCAIdAcR0XI1Y9Xz0wZ
6mQnQGtbzhZJWnDMwX6nZwTJsMIVpYMvA7/xG3QLOA+mmAeQ658hpTTVunbDol2N
m5KZkWoJUH45PinSbEVLG5oKypVznRIcp3OgkgolgbxlxNYMfgocVInKHK2kUhap
bafOAuGgjws+kyIN673A0rL8BZWuR/jc/KfM5GsA+BR6Z+coosF58H1I5u0u8YjI
cpZGjlsgfzsjy6qYRpfhI5Enc7EEdDWoLqo3WyDutdFg9meYGGzM268a17OSNNNZ
/kSujZfCIxTRsk5wnxXnYv+ru7C25Ho6j88ZK5e5Y0Q2zm1zs42X0hXjjCkxBFX1
K25kIEdTuHJ/UkPlUxwFBLsNg//RzLzME6v+NOZYbSORuTeqgck=
=QRVk
-----END PGP SIGNATURE-----

--aM+GqRsYIpeGC5GW--
