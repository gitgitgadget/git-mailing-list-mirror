Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD317C22E
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107123; cv=none; b=iFNEV8Z8J2qriVd+QSXQdTQCiAl7pNrC0isVKwsmRYwVZ7ocnQ2vtanDk15AmgKjOeG0Mskb7anf3ssIY0wocpZMt941b+XiawB1U7GNhp7bijwZGNwBXRWdvVMxMov17PVRdsHAO/fGSbQXV+9Kxjccu/69efrJRFfTDO2RmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107123; c=relaxed/simple;
	bh=V0vn5QPmafvWk+vuG3vLqR11gzLd/Vf63tNnAAx7RLU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oksyT3xt5tyqxdnEtjGJ6TGWsMxzIt1sYfI9YMrQ8orQiUyCIXghxSntq9+MX3kWETif8slArX5VIkAzkpX/PHqOQk807ahhSP85wOzf7fR6kciG9UaJnErBsz2AEZlG36oQ83SGr3+ToI1pwchZSRduesW+tqgWRgtQIA474ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kMmUhCFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CC851M3Z; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kMmUhCFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CC851M3Z"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 81D681C0007B
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 07:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107121; x=1718193521; bh=p6gGN6k9bH
	xFpCOXjhLGJJdaK96N6jgfRxBvvzc1WKc=; b=kMmUhCFqit0GgvsOPosJ0qsh9a
	ewabGMEFFIXlFRtDYEzXCKODTOCGRFxmqGidqRONPyVwBIGVxUXzwMAxVls7LKxf
	JFlCa8SjCQD8oq1wzBa1Vyq0jFakxBaF/Xrhh70V0iMaZDTx4LBR1QZW/8etKY3p
	4hV9M3pr4nOjqkhXjE8Sl9AybiVKL/w/EEOmojAlr/DXiOn58qrA5VDSs7D5FMrs
	RppasjphAg/0BQHHE83B9XRXwv0SydF8pOprmfldrphTn+O/uRCR0rSFp9ES8pYo
	QxXMi7IOV8ZWsdgtRpIUYF5UMeRW5gEnrRtgi4XVDfYJoRg4tpwvLKuOXF0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107121; x=1718193521; bh=p6gGN6k9bHxFpCOXjhLGJJdaK96N
	6jgfRxBvvzc1WKc=; b=CC851M3ZyCEPfjdsfcA4BKG9RlGIlSV8x5AId4tkkvwk
	Ms+jSQKHkyopCsnwo28X+rElrGvLNufO3tjAM8MNBQt7sxIEo3eTZLCJE0ygva56
	22Sh5dZOE3JTDmfn72hih6Jyjl+ctBm4mUio3Zlj9TYTPXQ5NbRqHfEtnyBPWNGr
	Ii5FRBKuwNMjtZZAKIHV7o8SIUxpNlBfIgkXwPszROLErVRSMN9koGlzPH1kLEKl
	mtPSAc4zQ/fDqQGHAHEPzgP5mQTOWNpY0FRQRNGUdzKjo2imOimWfVnw93uNFuMj
	KT9BfEiwkzaeTKOGgeCOP4m4/p4GdtkXi/JxzbUUVA==
X-ME-Sender: <xms:8DtoZvY1PUBOz-5FjDlUO9gNRr6-DsSe_H043gpdJNdIVqv6tNfAAg>
    <xme:8DtoZuYZSbMrepP421Hlf3LGoYGtOIbxlkzhm8wzqqLZgh5DP83MgPfTBtNxTK2vW
    gJIxO7gZLDU4lTU0Q>
X-ME-Received: <xmr:8DtoZh8DzU4K6C8l0oitrZnnovQeGobY8oYnNLjEVUIZeyH-JRiDrhtyFr9D6spDFMjRtIaP_G_INLP_r0Sjhr-PFlaY_YxYkvuuWs7wA9dST4EnWc87>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8TtoZlqaj8Vrs0RtzgiAFxJeNTv_XE88JXLkUBA24ORShakVRGdTqw>
    <xmx:8TtoZqpYDbZYu0R7h_13HLBfbhGZk6ROeElT3Pt8C0SQfj1gJLEMnw>
    <xmx:8TtoZrQY9ipRA2YhUWH20uBpbdzn5tbBMMad0XKBmfWL4DtdlwTQUg>
    <xmx:8TtoZirOh7XSHWEGzEvXuHGJH3OmCwn3kUpBXzDGK0EFHTVQ_-XTCQ>
    <xmx:8TtoZvDWufhw1-aYzB35QFBaiViWUukzM_6DQWq9YRUxoxfye0QZMNdk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bccffe93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:31 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/21] protocol-caps: use hash algorithm from passed-in
 repository
Message-ID: <c877d48f7dc3c4a7ab93fe9a9ab1c38fcb4dd747.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqzEsjH1No0LGSe4"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--bqzEsjH1No0LGSe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `send_info()`, we pass in a repository but then use `get_oid_hex()`
to parse passed-in object IDs, which implicitly uses `the_repository`.
Fix this by using the hash algorithm from the passed-in repository
instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 protocol-caps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index fe8d1d5c63..855f279c2f 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "object.h"
 #include "object-store-ll.h"
+#include "repository.h"
 #include "string-list.h"
 #include "strbuf.h"
=20
@@ -52,7 +53,7 @@ static void send_info(struct repository *r, struct packet=
_writer *writer,
 		struct object_id oid;
 		unsigned long object_size;
=20
-		if (get_oid_hex(oid_str, &oid) < 0) {
+		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
 			packet_writer_error(
 				writer,
 				"object-info: protocol error, expected to get oid, not '%s'",
--=20
2.45.2.436.gcd77e87115.dirty


--bqzEsjH1No0LGSe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO+wACgkQVbJhu7ck
PpTJHQ//QdRacxqVbSF127xFTv82TOY2irZ2wiQ6zAYHpqLNnW+5gITC8Wpb4ogC
2iqOPe3CZB0Msp34A+VR9kjiQEnrV1q+asHL+NDdM+p9n20sXXT8PPhIruv/Xb7E
E/nhrFL7KXsYXYkt+i6EbX8/qzGXpS4bpYX/a+aIIgxruFmq1y+uFPRRvIQ954zP
cFhU1FKlmSBGtPFwolaXyk+pZfLLuu3OS9Qh5T20a07RD2AUiS1c1uasD8/UBCj2
JHdNqIKwhwv5CfLAJenMRKGutc+B084Une4f7bbTgEQ/gdjOrEkwuiuzaT7wDJXT
+NRccCAxs37d1fE+nqC1ouyVgz2d+NfK73JLCYhrM3xo8IgnVJYWmSeBHyEjaOy1
C0RLdGlYGCPwsDIrFmU6iWgKZcls1o/hy5MMEow7+XXrOdJKx+oINXEPOeBk7GLi
W1TpXOUl1fhUSj4WfQZe1vTmUO8V7fv2vwJnD2ozt08qhlQGFzxWlqL107Iy9xSh
P7kIa5/V7WV2wwI0KQDJx8ihijfFUN9Q4nQ9gfvplQfeBFe8jlRKwFEK5V8tWEaF
aUi/lF3fdh9cV3rSh3gM5HBZJ+IwPnFPTCaK9Z0/BBg6nYdWWeWBkky8/Ok436ci
O4S3BRY4OAlopTQvoyvn0TYPEQoo6tCQbMaySJDBvg7Cs5GFXN4=
=CX74
-----END PGP SIGNATURE-----

--bqzEsjH1No0LGSe4--
