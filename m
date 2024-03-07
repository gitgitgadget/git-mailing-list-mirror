Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B001E865
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843764; cv=none; b=i727R0UeuAplIxEqBWvjlqMwBcSrVf5iLdvjsWXvQ7rQPos3pcH1sOMk3XH8On50gRey1lX/U+LInaEoXB53B/JvewF68SGzcOsZk4ILKMBQtcJBmTXlRw+hMSgZKbXtYJWl0XBUmwwQDFvQJpKvIFJQ7UJ3S5vHOigtsJsXBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843764; c=relaxed/simple;
	bh=bPa/6nHbixsR2kNk9Yo1W48ltZdPBBqfGAx6IYHhcqk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE2A9AmHIXQfUCLQrja1cXSis4g73Xpm9nozSk5v+4MQfTOcQkbMkGYtrriB7/CYLVs1iK0Riu2UHQFL720scRou5tgvF7B04OHMMpz8QXCQ8ZT+3MzViyXUtgcyyEzY/2FQa5zbfnWHRLjRJwoQ/EGX/5P44zzDR9SReSYWVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qTeLmAhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PzlC9jaL; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qTeLmAhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PzlC9jaL"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 79D6F320015C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:36:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2024 15:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709843761; x=1709930161; bh=Z4gcNjMrQK
	gQ4uKX4WY0fs0ceNA8txdTvbIK//BYe84=; b=qTeLmAhUU/GNN2WKHR362i8mfp
	lgkfZfunqp5nECYTs8BYmlqLWCMtQFG0AMdwuR/c7KgagyAono4U4NMadY2dpW+g
	aqGEW++VSmBPp88RxRTImF6JpnoImsVsj+umLnaorlXNkygixL6y6x6eJGz1FrKv
	8c5kGud984Xt2vTPe7som9vuVSGOp9PUUflkaUTNeHH1hCew6KodMEh+DdC3X1TF
	XyUTcksTWpTcEZwqURBYLuJdN1dSfe1++J6RqoAJZTS9jxnDsXQ5mvjiYeeibjwe
	BpYuNlALVMRI431cKcPKA4ljYbJZ9KwNr2YcDB3QHWez3U5d8xARG0SYZiPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709843761; x=1709930161; bh=Z4gcNjMrQKgQ4uKX4WY0fs0ceNA8
	txdTvbIK//BYe84=; b=PzlC9jaLaHEzRyIkVOySUdQ/HUUPqCZktmjXDne4GvKR
	VJ1Zo8WfDAkyslmVB7ZwEnV8h2cMGlrdOzvNkQc9jbVvuTOsHCb4iIVkq4roxnYT
	16Q6MxjbZ6iNvdbWnQAXDmMPfAqf6z8r1CoxHASaC0mOFAiw4oGp5lcOEsS9+2/i
	PB6CCcLJ8njtcBgZyDVFuh2Q1Begoi11dI7S2vVG01Ju+CpLqfZxoOKMsC0gQ2x1
	/t2vnTnjjw37n08+lqecy+xiM25LGTB0JELXjg3XD1WhlXR9hNqbvfNoONTtgINo
	jylSZe8Ms5poxJzbj3DALYrhmodtPUDEAGUVYAKL5g==
X-ME-Sender: <xms:MCXqZY7HSQjOXGKh6EOX78upNIt0_DkjZj36y6dC_n9LEVPZf_WA8A>
    <xme:MCXqZZ6nkTPIFd9ufYlsARPI_XvUQFctmtinTjQ1UmN8c4UnrIcXpFkHZlKbLMoY7
    s1McIVSkTZqwWOMIQ>
X-ME-Received: <xmr:MCXqZXeqpFK3KWXHyIM4pnHT65Z4KMwCltxbP48dNpo7vdxLhaJ4vlucsNBvv0MN9vhc2YU0KUMd_pO6npUEIdaBZ8mL-tyVUkZl4EnLxkFmBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MCXqZdLq2r086WhCWuM-IKYfoZXVZXqppHMK8Lfz8QacMSYln5KGXA>
    <xmx:MCXqZcJrClcIAHHhDQVDvhHfe8_qhx2EnNImdJir60R62upUaiZgDQ>
    <xmx:MCXqZezJ_n_dpML0C_uJ10x1Dw1ddbnqGW7ZlLGNV5brJV0vNRNYwQ>
    <xmx:MSXqZWz_maGASAOo0hg1rpqYbPZddRO_vWC1eoc6HlbFLFRq28hhKA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 7 Mar 2024 15:36:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21f4e42d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 7 Mar 2024 20:31:28 +0000 (UTC)
Date: Thu, 7 Mar 2024 21:35:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 1/2] reftable/record: fix memory leak when decoding object
 records
Message-ID: <a963054f9a063ca0c4fdcf613fd0ab2e9c681ac9.1709843663.git.ps@pks.im>
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
 <cover.1709843663.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oKbxCPHKFterIESW"
Content-Disposition: inline
In-Reply-To: <cover.1709843663.git.ps@pks.im>


--oKbxCPHKFterIESW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When decoding records it is customary to reuse a `struct
reftable_ref_record` across calls. Thus, it may happen that the record
already holds some allocated memory. When decoding ref and log records
we handle this by releasing or reallocating held memory. But we fail to
do this for object records, which causes us to leak memory.

Fix this memory leak by releasing object records before we decode into
them. We may eventually want to reuse memory instead to avoid needless
reallocations. But for now, let's just plug the leak and be done.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/reftable/record.c b/reftable/record.c
index d6bb42e887..9c31feb35c 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -569,6 +569,8 @@ static int reftable_obj_record_decode(void *rec, struct=
 strbuf key,
 	uint64_t last;
 	int j;
=20
+	reftable_obj_record_release(r);
+
 	REFTABLE_ALLOC_ARRAY(r->hash_prefix, key.len);
 	memcpy(r->hash_prefix, key.buf, key.len);
 	r->hash_prefix_len =3D key.len;
--=20
2.43.1


--oKbxCPHKFterIESW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXqJS0ACgkQVbJhu7ck
PpS1hA/9FplRlYf8/tz/E9bAGdI3dmhucj3C1wVsrv0o+BPoN0XJZQ+TMhZVURAW
gdJaJ0lRT9LHk4cKcy8aQunvp2qiFCWcceiGhNiDepXtJRFuXTMZ+RuilGbGmg7W
NgQPx+AEjQQ5RNmd6sfvNX3nbSGhp7Vw2s4k63Ef6JyYenCFrLOSkgBXfVwysFg4
54AWCvbWJ+ZY6ov0Rhii9TsfzEl7wxTc1ROi3O1XgmCuOdyWFgAdO6iLk8bA8gr8
kDn9KRnC1GGtPyheJEGg1XXnaO3A0NFl1Dw+E8EEelSnuzrTzQ1WK/daBut1aCU/
q9UdlxK0ShcLEiB878vis2iSw/fzI7nHhD+l7p6oh5RPHcJ8EB5uUo37G13MGNRN
1JoJAHz4jfkbmfz6CBJ35bWpyuOH/Q0KipS80aCCsENuhfM1JzoDnDHLB7oDBUTB
95pBsEgM0pLXTgZRXBpK9jq0JlujH8MtXDgshWGzJ9rUsMyukU1MVe2RLHVJS0PR
NtpWOdlx+1KoczRvgg6kPEYPIDG591Q3KGRwd2OixAz2xA0y7aTIOeip+l7pgvAu
Ks1xGa90KcDkSngAuoyTx0nT9dp9lSkf6GZxRgqeZ4kAd9ejBcsSPk/1zg80XpZP
kNfFJ0ooVYeLGnzoe562vMzs/l9eZBnTpUedCQJctIZCNxXmqj8=
=191r
-----END PGP SIGNATURE-----

--oKbxCPHKFterIESW--
