Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02192168B01
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336976; cv=none; b=sq7B0h7OwmQJ9FHvnQCfh+f26MliJ0NGnkIDH+sXBn5UGv0aiSoq3EJiaMm3Ykc/fQpkxgp8fWlE269Xs2RB1suI1iVRJOdo8sPYfb5QNNrNSH8/tCbXRvK+PNcukVwc/fiiYXKrKSihLHtQIR/K7LjNTvWCRxjM9iRUWe1vNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336976; c=relaxed/simple;
	bh=1KmcghFF7+83vwY4DcYxDOdcg+gwlwUFWFy/dI0jsds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WenhDgm3ekxcR68v4RCSGUcndKlsHYwkoLUIYsvVdYWdWVEadVDejLLwoURleg/PZeK0HFaHNSP1kZaGB7SGA4/zjjWRbMt24ZOpV4CdvIn4jw3lq5/T/64XokTvlpGIIABIqXJCY9mXLB9INogGXvSTIMcJvEf0WUpdEjDN708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p93SvoMS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hqmWsqoy; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p93SvoMS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hqmWsqoy"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 124231C000E5;
	Fri, 10 May 2024 06:29:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 06:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336973; x=1715423373; bh=Tj/KG2yxNu
	E/1QAgHFbx55l6WQ//XkhmH3M5iWee9b0=; b=p93SvoMS0QE/jgfwdk8AYZ1GWX
	GEYXo4PQXFV9kGAyySZKnVJml7zRPPC3VHJTQ4pXEFqCNF540salbeTwF4SIi8o0
	7Gxs2cQUz18i1AadGE2+brX85xFfpOWvzYha613Ace9nxkMwTnI88AMJI7Cc5dIK
	TMelUPRFM5A8l+KB94TuGXL99kqESnWK95QvY1DQFSyJFQdaw32GJybAh8O4iVrz
	kHUSgBvQaLCgVkbgYkHnI27qnMy+vyyg0fGNhmENTM562J8V+SbCH16C8X4rj4dp
	tTNWHFS7oJNUhLmcPBLrnDXTSrEE4msxSPU+gQxxCQV6pul7SErGZnRYYAkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336973; x=1715423373; bh=Tj/KG2yxNuE/1QAgHFbx55l6WQ//
	XkhmH3M5iWee9b0=; b=hqmWsqoyhoovCCqvK1715pbRWVlrDTd/DWQokIRvCiSw
	lM5rUwOI2jLWtOEiX/Tr8jWtYPryn7dMAnePSYSyQZ8JAckc7q0LPVuHu1KhKles
	6W27tIoXdFXU+Q8UDcQamV5iW3zGvWzm+s/BmMMo4Lj9s7HB/Aiy1DotD4tRa6vp
	hEGX4g+kpuO9scWWqXlOHTx4WFfwftvPz6iwz9VoYw/Ex4DGoWyENhSpp7uCzRH1
	YrsciVKRtKu9Guak8/b1ZCyYuX32DdlY4CsM17I0AqX8m7nzOdGyaTAhM8kv+bXB
	thDf7/LPUp7S7IcsTLkNcYisc4wd9AIJxKgylvTNbQ==
X-ME-Sender: <xms:Dfc9Zjyo6lbXPLt5LD54RjA3RM4Zgtrf-qzzOswPmh4s_ZRRJGGcYg>
    <xme:Dfc9ZrSlVTyz4G3v9zsX-gd-eMLom14Mua0NpmuiPV34C27HpZi31FBulmpzetRXp
    cEnbA9pPYj8URrC0Q>
X-ME-Received: <xmr:Dfc9ZtWdp3TP5FpX5WHecDCObju5s7wq47K8uDgtifFwNFS762y6ulgUXEvmJ_YHNuoXoqiKSdDOvlp8JdZCYys4jquDh-QnNRVzH_lvr6OVZArMwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Dfc9Ztj9ar4baox4OCFn7Sm19h5_EuVUPX4vcSVSfepaNByf5s3nBQ>
    <xmx:Dfc9ZlDpAcMltoR2llkphJjQk_JPrvEIhygiqPaGbvMopoRW86TNTQ>
    <xmx:Dfc9ZmLTFLYXVhWyf5WvQe22ZbLJk64AS0iOMRSA0YdaMLL1Zdz3fQ>
    <xmx:Dfc9ZkCevYmmkZJ83PM70SN9NkfWfueuWoKW1Rq4teMsUU0xLubC6A>
    <xmx:Dfc9ZkODy7h9S2T3HhDjOcHRMTS-dH-fSJlcHGlZ7hrUjqQiL6nyCHCt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 07043d59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:19 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/11] reftable/writer: drop static variable used to
 initialize strbuf
Message-ID: <aa2903e3e5ac76f82252e12919a8a09178e267ee.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFBGryjD1orb/9DO"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--nFBGryjD1orb/9DO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a static variable in the reftable writer code that is merely
used to initialize the `last_key` of the writer. Convert the code to
instead use `strbuf_init()` and drop the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index ad2f2e6c65..7df6e53699 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -117,15 +117,12 @@ static void writer_reinit_block_writer(struct reftabl=
e_writer *w, uint8_t typ)
 	w->block_writer->restart_interval =3D w->opts.restart_interval;
 }
=20
-static struct strbuf reftable_empty_strbuf =3D STRBUF_INIT;
-
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    int (*flush_func)(void *),
 		    void *writer_arg, struct reftable_write_options opts)
 {
 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
-	strbuf_init(&wp->block_writer_data.last_key, 0);
=20
 	options_set_defaults(&opts);
 	if (opts.block_size >=3D (1 << 24)) {
@@ -133,7 +130,8 @@ reftable_new_writer(ssize_t (*writer_func)(void *, cons=
t void *, size_t),
 		abort();
 	}
=20
-	wp->last_key =3D reftable_empty_strbuf;
+	strbuf_init(&wp->block_writer_data.last_key, 0);
+	strbuf_init(&wp->last_key, 0);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	wp->write =3D writer_func;
 	wp->write_arg =3D writer_arg;
--=20
2.45.0


--nFBGryjD1orb/9DO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99wkACgkQVbJhu7ck
PpRLWA//bHvayPxvvOw+7cNp0DHhNIOwGp3PQRF8lX0ys3T9tWuHh+/UUpLxUQRY
OXRqW9hIO+sjhZkRei+wxnaQYifnCkQMKf4RXkbb6aRI6tjWnbvwJl7SaLB+TlHr
gSHF/6JZpf3PlvZBaUuvIKF2EVKWth6Qi/dro4C4OdoBB89k+5Bs0K72V/jggl8u
GXeamKZWAFObldOUtv/gzNI5vt51cwN0nzpU5OikYfbWGuj827XHUdxMXVtZmN1w
gNa0o41XQJNU1FSEVnQV6u+hFLlYPA2FMOwWqMZOo+5tkRO0ApR5fy7XqbNqVgH0
2hkLxWzuFt7OnI64LbcXMQoOMwlT2skbpzueIsCGhKht6datMI4RvypLJUMcLEFp
6EFltD4WTQVyo5zaGlUKRKV3tPw9c3L9yz5ZskLDzOnVE7AwZFCdPXF18rq3kHn4
tYTFgKyTp/vXTNaXZb9SvLPo3SgteQLWwfCzV2prFQuHX+KSbzdqsD5Hkko5LxJu
OD1GIIKiIq7+i/PMuWV2t5a+lA4FuXyu4Mh4eQjsmdK9993OEoDDv/EO1liZpyeS
A3/3pQt22Se9RRcrDcC0fpM4rXOQ2GbZINCZ6fZtjwvFMI9XnMGLSwj7gm5yBO6o
eK+YCKmb+xIGKmtkuG0z351ArYJE4HLxde9Mirw3rUz8d0QiVbQ=
=j+Ye
-----END PGP SIGNATURE-----

--nFBGryjD1orb/9DO--
