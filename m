Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA471739
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846728; cv=none; b=IQvMQ5O5NkOoWNEBUd20fn/dbuavJKdR8VqisTm9MbtIUE/W/Ubw614MRPPDsPdl/TAhlbQLXFLrMasNolq0KEX75Ey0W24bbyesmHRTSPViekKXX7spwgFYW8QVp3OaIwZnE9eI56uNoNvL0Rs3H4qUq2VSMmZVfPFPzNQAqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846728; c=relaxed/simple;
	bh=gHrD8PHPX2sGKJGC6lFYmlwsKp97qFOOnZQjWn33akc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwRtgRS2rQEnXeWlI0FfeoxE2uED+KZVSiWZg7V5/hqWJ9389xbwMarJzlf7vUvWG7mGrU9toVbNIxWbJucLK9yVhnl++LVlfEzkiYd9ntbn/d0CR/EOy8i0gNCJR5PoJqvxITacO80SX+JsI326lo7UEpb7fsrA2p3zHD63lQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dB1QaVWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fD2mhAPG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dB1QaVWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fD2mhAPG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D0D2611400C8
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:05:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 May 2024 04:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846726; x=1715933126; bh=s6kcr1QYKI
	Pzm7Vnx+gA/IjC5xrEfZwZdAlB0yDOJjg=; b=dB1QaVWrMawY/PctUCTEruXVTq
	u02CNpYyzdKeoYYd7IUw1SUgoSTYu6y05Urlxh3LECpVAr2N4o4IQoisXaxAP4sZ
	ekRR2PNirv+IcX+NVO/eKEo9OupTgRTsDXm94D3uwlhgEBIUHyghDv5HwL5GarJj
	SRm9cM7rXTwFrchhfSJL3/NUc3/0UPtZa/4ilthTAXH6+cFQfmlvf8YYtdBmndUs
	sOgpn3Z3iV50WW4S9mguEZYlxGu0NdbBFGBxzCZ7IfuKQYCLZb7vAuDcsZHpZzzh
	7Mir2Op9EhABSM/nyQHgpkerMRG6fk0PhUbaWF86c1+MJIMd5GAKOrNG5Q3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846726; x=1715933126; bh=s6kcr1QYKIPzm7Vnx+gA/IjC5xrE
	fZwZdAlB0yDOJjg=; b=fD2mhAPGHJO5TtfDCn+7kJPk7qdtDvTw4S6nrrsjzy7C
	aWpDIyvqSIzGP68k87QxxLlm/pnw1D4zN2D3lcM7u63e1NtboVO38CXkx4Ik0ZqQ
	MIXvKcayEKUxwFh1lhX/bZ6/4Cif1FFUg6B/ZdhqU3iwt6Mr35ifdcVzJbGSIjwZ
	aiUQDGbV2LLtII1n0CRk6NXqa33jpJcQZVPJVC4QzBrq2qfQ/eLI5wk+9+v3ikAW
	VZruHtwJUlLjTcFMi5+3o8SPjCSKk40NWJ59t9guHWyNbmukOtUa3UemF8BvgiF9
	+l8gVWUr7thT8fCGHZHem0Kp5rXeg+xo/0naQ6w9uQ==
X-ME-Sender: <xms:Rr5FZk4V3qYFjW4MvoTyHh0M2B-YlHqcW94YHf8G436H69sCk5YMDg>
    <xme:Rr5FZl5CkSN3ZGtk6B4y_RC1NtqXPo74N6xpsk0yUd-lpm7bPTinjLDdfCsk0mK6w
    nHiasHMvQ3jsBu_Tg>
X-ME-Received: <xmr:Rr5FZjcOglBtT0U2k4qOE_owBx8gYmVsHB2F8PU1pl7HmJbaNZeSmTgqA33a_zM8w9wGduzReBqrO2Mla1tOgxI4Mz-wFXpy5Ubo70ICZ4mgvXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Rr5FZpLjvDFaBTnLeEimtlLX6K2-GnEl_ORRHr_4LlcwaYqmPBd4ig>
    <xmx:Rr5FZoLVvYTpJWYI4ldssuJyfdxcp27WWkxcj9CLfxiJM0QOjQbeYA>
    <xmx:Rr5FZqxQZSNNWLskxD8a3-iRm_qO7acD1Zgr619nPVa-4oSTrjXesA>
    <xmx:Rr5FZsJyyxFzrelmI6lRuY7noHZWdJjSzvTC-gMau8sU4NfxWVEDrg>
    <xmx:Rr5FZigPImiLJHKov0ojCUxEchcSo_1aTKn18A9UjTwXnT-bdDv5I4Dz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:05:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ea7d4bee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:05:01 +0000 (UTC)
Date: Thu, 16 May 2024 10:05:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/16] refs/files: remove references to `the_hash_algo`
Message-ID: <ab0c7937392c3067d56ff43079c91de70d4a19e0.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3xWQL7pVJy0QYQy"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--d3xWQL7pVJy0QYQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove references to `the_hash_algo` in favor of the hash algo specified
by the repository associated with the files ref store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5294282770..5684f1bfc6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1822,7 +1822,7 @@ static int write_ref_to_lockfile(struct files_ref_sto=
re *refs,
 		}
 	}
 	fd =3D get_lock_file_fd(&lock->lk);
-	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
+	if (write_in_full(fd, oid_to_hex(oid), refs->base.repo->hash_algo->hexsz)=
 < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
 	    fsync_component(FSYNC_COMPONENT_REFERENCE, get_lock_file_fd(&lock->lk=
)) < 0 ||
 	    close_ref_gently(lock) < 0) {
@@ -3223,7 +3223,7 @@ static int files_reflog_expire(struct ref_store *ref_=
store,
 			rollback_lock_file(&reflog_lock);
 		} else if (update &&
 			   (write_in_full(get_lock_file_fd(&lock->lk),
-				oid_to_hex(&cb.last_kept_oid), the_hash_algo->hexsz) < 0 ||
+				oid_to_hex(&cb.last_kept_oid), refs->base.repo->hash_algo->hexsz) < 0 =
||
 			    write_str_in_full(get_lock_file_fd(&lock->lk), "\n") < 0 ||
 			    close_ref_gently(lock) < 0)) {
 			status |=3D error("couldn't write %s",
--=20
2.45.1.190.g19fe900cfc.dirty


--d3xWQL7pVJy0QYQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvkMACgkQVbJhu7ck
PpTVRhAAnRSpqyfTYKQ7J9meRsdhYJejs8EfStHF74cxQLwpMvpZnnqJDJFYGzES
elP5oHozeDdQRjQEX3bqSV+TGkRvCFU0pX6QX6ZRRr/90g0BX10KKEPD/OocPx58
gMANze/6Wy9ILBIbnnO/xKi7Hxh7qK3dTfy6dnMJKDFrT/fCYDbnAepBLy5UtvO1
NH1Vlzo8QrHVAqxPNrkzFzK3WxwZJUurv4sBHvDlGBChi0RR1w783b7TDv7KVrmz
KFrE469sjBFyRWeqws01/Y2ipThzlSHrDswZ9baL0juKCl6f1bxykDTkS2a6ZFHj
1FwJBKFqvZdXPiYDZnvIlwnuj55HhR0fu1M6Uca64XxsVHsA3uDp8zfOnHqAaG3Y
53wMzCEfuQYsKzNoBIP+MeuWd4MpxxVnKpbtzUXjZ6y/X4GaYheNZx4rL2Kt7rL7
gqiai+bRiLblNEe1vGP7zJOY9NkkaVFwWldz7MWGAvdSY76CN1wV76e94mhSABRT
EjrWRG64YiU0YdP03rJvcLRWPl4PDIKsmKubF+1UOOF2YdqjUBzgrLVwRDS8Q6uv
kQYBypaticzEWoWNhHKuSM8jro6Y5l6ylOVwf36ghd9VZFQggcKAEJhioStXRj2d
ItTFauoZieM9Tdlx8dKosDiEKFpU8O0RfBcS09pHR7XcdS+WLwk=
=m28N
-----END PGP SIGNATURE-----

--d3xWQL7pVJy0QYQy--
