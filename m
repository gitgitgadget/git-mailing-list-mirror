Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5301A0AE7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361472; cv=none; b=K/ykpG0SywqFFU9sHipMYKdU3jMP34a60oWbwvJMIHlFbt8p+7kNYAGTp/OCfReiT76VSsnH2ZKG2WiGZqThZXTCi+3mXRsVedNlQMh399SJmbReInejKAbeblDsTv1E9HRusypJAyDibbIyDcdwqYcIlShQZ2tC9Rb8FBChBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361472; c=relaxed/simple;
	bh=X/kpo+NkZZNezkRb593WL4GYS0z/JMmC1kAxB1tq6Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6KkSTuevF1rHz/hHCPBqOcZfTkX0QvqlG+bsIhug8WdQ/R6D7ZAHGoBJ9btqgf/9CdF1J5dMqVb4Wt8RI28GL+Qzb4jby2PRFvkblrUTILNZKgnbCGx1pcHotP00gC5lTw/VMZZx002G0EqDCG91IeZZvVmEoZ4A7Wag6f34OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BbiOj2Su; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZEC+QMXz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BbiOj2Su";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEC+QMXz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1EDC511400D9;
	Mon, 25 Mar 2024 06:11:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 06:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361469; x=1711447869; bh=JA9tYaXcoY
	T0wv6/4EVJJhuHE6tG40Go1jt48Whau24=; b=BbiOj2SuEXEtqL5gFjMY3pDgEd
	KZAWqVO3M1vJ2x8B9VF/+GJ6qheLQ9tN6CJGon0pIkj6/c2n8hoGnPh099i1VLwz
	wNyTEIlW4/Iq6FwtluVdroC/P6ItAQ7ZM82MiwjdJlr+sy9qZ2aafz/+mmHIi0b2
	Bg+a5AMnS1DVqaJph3Bc5ZGsbFOfhwySoR/VjSml6n5eBWonAoCo3o5otHAOpV/5
	6rG8ZJ8KPHHELzuF2AHjCOvCBwo3TFwK4upFQ5frs/MupOlxZ09aJHp+RRlfEyLD
	AIApjt6y2p5CluLU8sNx5VQaMWB/u1DcGbDQKPB+60obVwPATJ/Xyxrf08cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361469; x=1711447869; bh=JA9tYaXcoYT0wv6/4EVJJhuHE6tG
	40Go1jt48Whau24=; b=ZEC+QMXzBa+z0UzvMwyFH07preITdv/IYu0VpUurvoey
	yr5KzF+u+HwYMSk+vutzyyg2K3Y667DDS21RM8O+AgWaoAgnmqwyk3wE2zByyNXr
	5GGk0rbpE153o+dQEbzcBZzSrZ4ucCunwOVSQb9XzofBnYz2MEejAuzT4eXUTloF
	9ET0FSJnbn5xi9+6h/j7ZL3CxzZ3AR7QWxcm+zsX4LnN4RHtUv7R6gUZ+tvK+0Rl
	ejOTfnywDQnIeYe+B1JQ+nw1WquYBo1DPf+KX/Fx/SuuxSGsbYrDCIFPOvC+IQub
	0nHDBW6J4z0P7tQGe5SachjddUYIZU9XuKYASv/Riw==
X-ME-Sender: <xms:vE0BZh0kIkYLHpdlH_gdOro2Mow9gGkp4TK2vmLFzaZo16dqe45Y5Q>
    <xme:vE0BZoGKrUEMOCugaAZOOIshpsRcyJr6FIyWQ0TgDQbBpt4-kzUp0cKG0FUgRqSBt
    s66cBAKCePIc37g4A>
X-ME-Received: <xmr:vE0BZh43oGVvTKsGbJoFVnqAl7LCKvOdvlafqPYeXj20gTiDaTxxXFz3ZZ-8ZKUU0CxU2oA1Ep5bApIFDAR0yJNCTvTnXJlXsiWU9RJEhIr3Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vE0BZu3XR08sJXgp4O9qTEAUwKdwQOpmxtXRcC50IFSXFFTdlEIhAg>
    <xmx:vE0BZkGiVR5qUSYz7EgjzQ5lsHBXUignPPbIdcOuZm1IcNAvsnU8QQ>
    <xmx:vE0BZv8XD00_zGW1g-BVRMacHpchR0eT60b6MdG2I7f7UovF1R1QjQ>
    <xmx:vE0BZhnjrRL2wXMMSygzcrHl7iGV9ld1f2PvGZzbKbQT90Z_os3n0A>
    <xmx:vU0BZoDeXA3u88zsWQD_Fuxjd_v-03s603ATtXEl3_-2NXthsTksvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:11:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 811a2c87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:58 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:11:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 7/7] reftable/block: avoid decoding keys when searching
 restart points
Message-ID: <e751b3c536ace78f975b7d2553c22dbf6845a8d4.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sJGzzaheq+Rpddjr"
Content-Disposition: inline
In-Reply-To: <cover.1711361340.git.ps@pks.im>


--sJGzzaheq+Rpddjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When searching over restart points in a block we decode the key of each
of the records, which results in a memory allocation. This is quite
pointless though given that records it restart points will never use
prefix compression and thus store their keys verbatim in the block.

Refactor the code so that we can avoid decoding the keys, which saves us
some allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index ca80a05e21..8bb4e43cec 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -287,23 +287,32 @@ static int restart_needle_less(size_t idx, void *_arg=
s)
 		.buf =3D args->reader->block.data + off,
 		.len =3D args->reader->block_len - off,
 	};
-	struct strbuf kth_restart_key =3D STRBUF_INIT;
-	uint8_t unused_extra;
-	int result, n;
+	uint64_t prefix_len, suffix_len;
+	uint8_t extra;
+	int n;
=20
 	/*
-	 * TODO: The restart key is verbatim in the block, so we can in theory
-	 * avoid decoding the key and thus save some allocations.
+	 * Records at restart points are stored without prefix compression, so
+	 * there is no need to fully decode the record key here. This removes
+	 * the need for allocating memory.
 	 */
-	n =3D reftable_decode_key(&kth_restart_key, &unused_extra, in);
-	if (n < 0) {
+	n =3D reftable_decode_keylen(in, &prefix_len, &suffix_len, &extra);
+	if (n < 0 || prefix_len) {
 		args->error =3D 1;
 		return -1;
 	}
=20
-	result =3D strbuf_cmp(&args->needle, &kth_restart_key);
-	strbuf_release(&kth_restart_key);
-	return result < 0;
+	string_view_consume(&in, n);
+	if (suffix_len > in.len) {
+		args->error =3D 1;
+		return -1;
+	}
+
+	n =3D memcmp(args->needle.buf, in.buf,
+		   args->needle.len < suffix_len ? args->needle.len : suffix_len);
+	if (n)
+		return n < 0;
+	return args->needle.len < suffix_len;
 }
=20
 void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
--=20
2.44.GIT


--sJGzzaheq+Rpddjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTbkACgkQVbJhu7ck
PpQFqQ//T3HEc33oH+rSPSop3QMGONY+xniW/RTvHa4SXZhIeom52j6ytPXdC9Ix
zfit96TB/M6t1QVCdP1Q+L/3rYanTlN3fE7Oj/jGK8kbnxb0xvZK6ZT/mzZsM+sx
vH0Kvq+XvGZCvvvFofQ9XB+xAmk++5uAFNVuGYakA/+GuZmZ5Hn9INbQ40aqZ4YV
Voqtv5DlrFaK7CG7J4sFQSImDSXqMwJp2fAVXvKR2A7vMyfPq89IXX9dqknUKkMB
mi8MlSn2NB4YB5JhbK3BhvTN+XM1CLxTPmZgSYlVWUWY9E37jn4Th2kncLNeiKHr
Wf7ypGAih0sjpBhMzkujpPTT2zYeFCrYNTgyYG41SD8VXj2dMzNZ5diIs6Cb+SR4
07bVeP2rDPUDH5aX4yyXea4oT68HfEVg4O29PdhvUBztqQrDkdsjPKUA6mIe0m4f
xhWbIu1Hxo8upSfofOPPaP/B1fNGD5U9dydS9/NK3xOuMNX0sxcCY6uSRPM14gLR
iQpp/e0xO89rl1fL7FsINeGwgu/verFLttc0n1077VA4HETH8wfr6A6ujo5o/ebn
EFRKxLqsbWCVU+oTJ2LSay3vk3gUZBsoKjTflfCWPaCjwHj/dOLCNNDIlyv3B0qt
FuTh8lSU3niBu9b4vZ+x00cieVBDVxRZYd8hFEYTj79fdLL6cy8=
=WXOj
-----END PGP SIGNATURE-----

--sJGzzaheq+Rpddjr--
