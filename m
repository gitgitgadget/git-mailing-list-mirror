Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7370152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810368; cv=none; b=kxRN+lDNq6enA0mD9ZMsVcZaohUbEmTyrksASxnq3unVgGea8Ob8WW/LhlPqwXrUBRFs7ZOKzsvOInGplTeKjqAOBOUtjXyad6XBiruQGEKxCcBqFrOm9x/Jjb2jcDMndu6WO9mKhgIVGB5xLB8s5uGQBP7aJzuznXE8Zspu1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810368; c=relaxed/simple;
	bh=ca1hJXB2ytmAL1QAfXwBxrCQphzR6V01eZAOycE2B1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejqcaBPIPTOIa+3Cs3xRCl+XnTmLFEgR30Z3UxjwgEa+HVRs/zhT47BrvchFBY5hHw5mWYUI+GDpDQSJ3Bv3t7l3uhdkmjvEm+KJdZLhBGBwKHL2lLFLBWdD6oCHR82DPCSzbiD/f5WsLtBHKl8DQ5uDrzBUuK9pK6DsxAANnq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AvptjSvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hilLIKQQ; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AvptjSvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hilLIKQQ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id CBC2A1C000F6;
	Mon, 27 May 2024 07:46:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 27 May 2024 07:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810365; x=1716896765; bh=wZeeX/YAiP
	3l9QhDTeD8RtsE5qYhF1DpuSrS0IyEoRM=; b=AvptjSvyvBOZwpCJToLkgtU/3B
	/vmrn6oj4ljBG8MZzJ4grPuY+xijSGMHWZYMXK0F8ye+/EItL4AS0KTKgdpsMFj4
	ScxsxmspREHHtixtdkAimSKTSg1LTKT6eFjrSCFukZBatxHFcFG8ueOzSiDACU4o
	v//qeAtg3nwX02KTo0IPQWWWUaGmskU8w+Rx1kIZ+13Njk770OQboFFtMqZdrgUi
	Jc3SI6NekcN/wR/pjqZOHtmlbN8RPpnudVuSl4j42k2z23V4nlK4qr7RPmsNVcWw
	QEthRVDT7z/yspujQGd95Dr0grwVPl4WLtVHXZSuFboeGHM8heJ/nqbutJKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810365; x=1716896765; bh=wZeeX/YAiP3l9QhDTeD8RtsE5qYh
	F1DpuSrS0IyEoRM=; b=hilLIKQQo18XlWAZP0HSFilaaRzQGzAMQViM9JPP6kmF
	Ame1VzrDFrJzdMBzzkTw75BK27CUEMczTQ6LnF1l5QOnpLyqmNE0OL23Mz7658Cj
	sVj0y1IuDrlnwDBwD8KcdC0beOVPQbP0gdgnXuhhEELCcA24rQRs2/0QAfLtZ80w
	zxrS2uVcOrwBlbrXzkU3dn6QLFUemtzJ0W83vNMX6nuR2tQmEnRMGjhRp3RY8PVa
	Mfead9AaoCi8K8WqioJUKCO7Lb9UHEsnh/qeQRJkMBQMzxEU7TMjc82AAvn6bcxb
	DUcCag844GhQRHfP2feQqUU2+yp6VwueBDHg5Me3Dw==
X-ME-Sender: <xms:fXJUZhpOT5g2-kUDpemiOnhLCEc8mpypET-bQVdvHwFPHFCTmYURxw>
    <xme:fXJUZjq53e2qkML7O8bbt4RNufNGVWHtS6_4l9GEYgWPSQx51yzF3XtVeeDSYzUc7
    -CAIAj45REQ0I7b-w>
X-ME-Received: <xmr:fXJUZuNRqoBrKx3d5WfgGWkVEeguQRlhXMfNZsTxYX4lFW0kIGLh-_nu3Qi-JHiWxCPjKjdEKf7XMqkP0zSwWuJdH_nbFVSzdMEGMlbICSFZx9xoXzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fXJUZs47Pmoha26tJ9RlE4JV0QMvDeKdtJSlnNF6rOI5rdV5fUrKKg>
    <xmx:fXJUZg5PZijBJriT5lEzpHht2n1pVqQ0OnTxU2wWcqR5_xqd3OcN3A>
    <xmx:fXJUZkjZZKSAKk_hDo8mjyGyWOG-iFYlXsPYPKxt2llma-d1M6EVEQ>
    <xmx:fXJUZi7FJMs7QEZXTn8oP42iYJiFJ8oJKZgD42Y7jleHo-vAtwOtTQ>
    <xmx:fXJUZqRDKAVDCs8YuIQcF4rvUZSu6NJTLNvtQfQ2o7DrPdL1mvv50nxN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 41344458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:45:53 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 04/21] strbuf: fix leak when `appendwholeline()` fails
 with EOF
Message-ID: <aa5cbd9d1404065e40474c2b55c0a8da9df308c8.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wHj7YryhCG6w/+5P"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--wHj7YryhCG6w/+5P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `strbuf_appendwholeline()` we call `strbuf_getwholeline()` with a
temporary buffer. In case the call returns an error we indicate this by
returning EOF, but never release the temporary buffer. This can cause a
leak though because `strbuf_getwholeline()` calls getline(3). Quoting
its documentation:

    If *lineptr was set to NULL before the call, then the buffer
    should be freed by the user program even on failure.

Consequently, the temporary buffer may hold allocated memory even when
the call to `strbuf_getwholeline()` fails.

Fix this by releasing the temporary buffer on error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 strbuf.c              | 4 +++-
 t/t1400-update-ref.sh | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 0d929e4e19..e1076c9891 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -691,8 +691,10 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, i=
nt term)
 int strbuf_appendwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	struct strbuf line =3D STRBUF_INIT;
-	if (strbuf_getwholeline(&line, fp, term))
+	if (strbuf_getwholeline(&line, fp, term)) {
+		strbuf_release(&line);
 		return EOF;
+	}
 	strbuf_addbuf(sb, &line);
 	strbuf_release(&line);
 	return 0;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ec3443cc87..bbee2783ab 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -4,6 +4,8 @@
 #
=20
 test_description=3D'Test git update-ref and basic ref logging'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 Z=3D$ZERO_OID
--=20
2.45.1.246.gb9cfe4845c.dirty


--wHj7YryhCG6w/+5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcngACgkQVbJhu7ck
PpT7yxAAh8unGyZJy4oJGhmeVxvNz/ZLzR/9TafqZG/3YP0dQ9Muu9epYoEIGTQa
PJ9BQiNPZEjrRuoS1AAupqjYsBoK0nrt0rOkJuhAl7MiwT8B4oj4blpOE6qyxd8Q
AcIYcxQ9W2s+zRUnSowl49Ka3EVsMnbR65XNIjAb/lNtvOsIu9LCTjvXXmXUEYpB
lBYLxHAQtUCnCgnx4OG6ecaxvBQIGDGbagWRPQZTgdHZQ5DW1xtmCEQJgJN6zjaY
/LaRKqqYiCfDsd9JA+7UfmRbBGulSqLItp/3sQvaFxiE8lzJR1jKhnpPnzoPFU8V
UK2ohQezXAMzE2UA9Kwi9yL+ya3W/fUp//YqGGvqxuu1r/xTMYjHZdoPj5Ssp+za
cnetuCApQ5VHqaIDOZ+9zWX5ysxkOdE4IFo7YTatrqRLQw41QFNvC13hd+vHlSbB
kOo2qv/kXLPnhkTvS3QsX650DaqpSrWrxfpGR4CKrTvT4i8Fv83NPgmU244ZYHIn
perVO9UqqzfzqwumXP8hrf7u4v3Vn8Mxbfe9S8D+dd2tdCghJrxWkDsnHfAmh2HQ
4W2NVd/Y0iLwVvK2g3TjUwPyWIob7JAWdj629c9YNK+G5ulzb7hPpR6/NWVK2uy/
I1lLGC1iyq0eDfdRRl+ufeF6k5Crwba6hgG7k5/peJ7bQ2fqDQU=
=//1f
-----END PGP SIGNATURE-----

--wHj7YryhCG6w/+5P--
