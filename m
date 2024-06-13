Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB7136E00
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259213; cv=none; b=fU6sKldihVG1KRQXQ9JT+XIkki0nOyZ3zoIY457/0+QeksVAF4eDfeMdb0VUfpLCy7Awqjk2FwUtvgc2nICdQHizvsID8mMmZ02FVMnN+p5+QuyiIdeQm11cZrDh4Wm+KkhcmAI7HK3R9ONy+MJqnpYxvto5iPW8ZbutiS7tNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259213; c=relaxed/simple;
	bh=ThNz3RxPshoJUvpksHlPFxGVliSs3SaQtZw2mfFcQv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz/DjFDSfHYg1N1dT7pp7o0mZVo1vRc8Qa9FPDAyTT0WL9ph4GJvyFe8BaUFvoPgJnUMyUPM3EK+8NwucZVjVIl2QJlU5lv4etCYooLLb1WLHo5PaMtjfIltwmT0eHPQGQIWRzyCosN1on14gglpyhtooF82efoVVCRxTm8tD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BjZJp1nb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1/P1Mk8; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BjZJp1nb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1/P1Mk8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 542251C000D0;
	Thu, 13 Jun 2024 02:13:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 02:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259209; x=1718345609; bh=yOkGjvvc8k
	XAx5L+PMOXqQ40t/HkRsGT4NshR0qX/8Y=; b=BjZJp1nb61RnUju3y1ggZTaHWY
	p2p09wDTwIBbim0OlJLnnuH9JsJk6AblL2twyiC5N2OZ0pKgVaYaeWbigGFEB0f7
	sglz2C7RK6TONl/Z9vxRAlxkRlCkg8jU1lSk+QWX/Kf0xV1Z/5Yzxmf9eFDMoEu+
	9Xl7oFVz9m/dJ2C6nKVINO8GmvoXrglhdcDCfKhyHNy/L8GQEbuxvGARQgU04EiW
	lxKL0ZOlaNBIFL2gvSkw+waFK+1zmdx6uZ5397JsHPXi/0jINfbvx2ydPoUpcySg
	0O0Ka3TbuVLnN7yj7VxRdyvApJm/jchf5x80HA73ST+Iqq3+LCfSbkbV4idQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259209; x=1718345609; bh=yOkGjvvc8kXAx5L+PMOXqQ40t/Hk
	RsGT4NshR0qX/8Y=; b=H1/P1Mk8bkn+xx56Y7EWuKrphowm7lIhbELVtUNHrVLD
	JuvVH8Q3rZni5erJbrC70NBZ9drUwMoHFGp6QxtSCtp4dBTgztSQnZA/Fcj3tAdz
	AItILmuDMhQAm+7azpLMzXc4bR/3lIEVaHD3h7kBIc3wlAt7EgPdZkUsgezF/Mep
	VdGdy/ua6nPVR2M74tLTdSpdBQtywO3jqa5Mqbe2GMS1fYkN6F2+KzL2o5cFAZSW
	dWak0MJImyGoldiS04YbD0IVOx8jZkYU6F/tyk+jTCs5omlGHdPMNboJpQyolrNH
	Hs3UsIe35HCdJ2Jsuv8zfboe9cIlL4sGQ6b5Qp4EDw==
X-ME-Sender: <xms:CY5qZhEjySvZVd8XocnCGGuDAVC9lFMid3aJDIc16G3G5HZebCGXjg>
    <xme:CY5qZmVQx7PSd-iAqT7OEqifJ8x8CobLYkqnrQsrxd0d9jG7Nc6UsFVXKPffVYues
    9kL_uHnDqfDY0C79w>
X-ME-Received: <xmr:CY5qZjJRlEgPDLcYlDuUG6gPk5wUj1OmF4h0tSuq7sJftLFt09penq2VDXweFAIhQAjKbTpEgkxhYzsdN_sIL286QMlL13olz18cIXojguP3TfebWoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CY5qZnHqFKOYUWkZY09ojdOGN86kDtVmqLDJxZQkXuOyiMqDLe3t1A>
    <xmx:CY5qZnUc-ZQNfDgyIIq4rxlhicyMQURUpzNVLnoy3LEzQXwP76C0fQ>
    <xmx:CY5qZiPYZHAMDWaD8uJVFVGHRMzRqBgjuNpNzI5zeiM0mYKsHX2CAg>
    <xmx:CY5qZm0KAYJsm0KpaCJzKXdWxJ-B9GXxWYlc0H47m-AfA3OexQQPAg>
    <xmx:CY5qZiT_9P58WWL3X92QgeAlMo-rNf_63aQWC_ko7p-LnmZ4Ij7WIWLr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c162c0fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:16 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 01/20] hash: drop (mostly) unused
 `is_empty_{blob,tree}_sha1()` functions
Message-ID: <d2154e8c4517cbe7c981184f911bdfd06a593cee.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8nCzMpCdPjuLiIXK"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--8nCzMpCdPjuLiIXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The functions `is_empty_{blob,tree}_sha1()` are mostly unused, except
for a single callsite in "read-cache.c". Most callsites have long since
been converted to use the equivalents that accept a `struct object_id`
instead of a string.

Adapt the remaining callsite and drop those functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.h       | 10 ----------
 read-cache.c |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/hash.h b/hash.h
index e064807c17..a1161e1b22 100644
--- a/hash.h
+++ b/hash.h
@@ -84,21 +84,11 @@ static inline void oidread(struct object_id *oid, const=
 unsigned char *hash)
 	oidread_algop(oid, hash, the_hash_algo);
 }
=20
-static inline int is_empty_blob_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_blob->hash);
-}
-
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_blob);
 }
=20
-static inline int is_empty_tree_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_tree->hash);
-}
-
 static inline int is_empty_tree_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_tree);
diff --git a/read-cache.c b/read-cache.c
index 447109aa76..10e002ce6d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -337,7 +337,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
=20
 	/* Racily smudged entry? */
 	if (!ce->ce_stat_data.sd_size) {
-		if (!is_empty_blob_sha1(ce->oid.hash))
+		if (!is_empty_blob_oid(&ce->oid))
 			changed |=3D DATA_CHANGED;
 	}
=20
--=20
2.45.2.457.g8d94cfb545.dirty


--8nCzMpCdPjuLiIXK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjgUACgkQVbJhu7ck
PpTMFBAAlYyJ7RYGq1WWK7MaY5BHXGt4tN8TERBaPZtZj1i/N+QjMsjUuP4qXx+q
DanMd9PUIwvic3rfh/z4Gt+2BJHj2DKzP61DbX19ELP0rEK9YkdoUbSvqHDUiowR
owF6eu5k7ec/MRifw5DxvsJbyEE8f7tNd7oNqsGYan+Ni2teTyBoxg0eSESjoI68
M6Nwdj272g7lep3HYu+n1/AQ4J3MajmAMg9tkYxucEiOItu/RZUTZViwtm8CyIV2
QzeKloHqfmc7p+sM9yc+zQ2g5tNgccxkgzjKXDMg6hKosaSHZa1/Lj7HZMjTEss8
hV9x8giWqioVmqZn62/yFEUMVsWd2wnpAgl2yjssB7SraAErjj/9IaRvisldJJ9B
6A0LNB5cpxsp2YOi3/4z8dwZoL5v+dU5Jphxb0Vt9fya0sQZtJ44MJZHHRSDpV1Y
IzpP9fMbxvRwygg439SudBytoRJjc2+iRTBZ58jDjg0XOw3kZdA98qG6+d2jmKGQ
zIY3HCPje1VPXjupTvbWBJRcBKzikM58a51CYnPOMV6kzf4t4S/yixR2ZB+vVsan
+At/zXpn9V8+6vrb6wnB16b1BUsv5aLiAZ8+4I2TYZTcPzrDBB46IWOMnmgC5dcn
RVZ8GN5YKH/51aVufV0nfpL1BsJdZLaCr4GpsfE/Scqm8tMF4YA=
=HgFz
-----END PGP SIGNATURE-----

--8nCzMpCdPjuLiIXK--
