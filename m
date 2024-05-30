Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F2132121
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073498; cv=none; b=lQw95o57cnww673qwhfoqOMEDYaFhzqvzm6+TVJMSxeCfVNgM+EIZBZlbPsq+3MbOYrNdhxmusTj3WHC5VYEq+jleBIU6TwQvt1oaQeujJFoz1M6I0FqdbQZWy+WhsMSGGttj7LR2mygodCsH+950z3SbuEw/Iypg9pT+VxYyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073498; c=relaxed/simple;
	bh=jR+U+drIyHYLyBYosy5SJHyh0/9eaIZ7eOa1ABOYapo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa/I8z0AEfw5CqNT5a5G+vpz0oFOJQRi6wBBK9UxRU0ULR1anFHVe4UnLZuhk8LWg7dgbeoL/dDbyuxD5mXvNjARaSS88zwHbNOBjvCajsYrtsmaCMOIGX8QEh0FKddxDHemCy3O7k3Yd15PRSpxO/dZkwgMFSrsHppkgt6BYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gRcpkQTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oVu20DWW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gRcpkQTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oVu20DWW"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 35FBF13800D8;
	Thu, 30 May 2024 08:51:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073496; x=1717159896; bh=eeAFlJlnxA
	hrqdVgVPL29pYAjKpL3PpZii2VVD/UUGQ=; b=gRcpkQTheA8SdeV/wvI5oX+s06
	APdP8X3rGRARa16ncWUIGb4pOdhEvXcWFmhmwjmDNdtYmYR6M3AH5EmgcM53DQYu
	I+yZVkmJDp3CEGnpohjG+FekciccT0mPcMIhPa8Z65PoIgTAnZeXAZsmskrmpNFB
	fne5D+j1Lsc2w9peQZvPdmEZhyMY6HwGZM1APLPo1vpWbtL5RbAWGlxalcV6nrMK
	gToihWJ4wlXpowNNq170umwzZZ4boltLmoWkKihsFOWkNSh5hv28BlwpDwPXghqJ
	WPmq04SG3QI7MrXOoeTA5rY+1kXzn1fRVUlFPZcpRvoVK0cwKeeqHtatXfdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073496; x=1717159896; bh=eeAFlJlnxAhrqdVgVPL29pYAjKpL
	3PpZii2VVD/UUGQ=; b=oVu20DWWlI2ZLohrft5DMKeBcj68EimPEZ410ZM7zSWf
	rjIkqB+KinHtpufTS1pCw+uHY7mU7tqH7jAiIEoy9GxBYb3Er3xG+H0nGPopISsv
	lbrOEJqQAuD7cRuhAQNTFZA6kJTQhbEqhygPMB7Rmsa3LJgT72JYjgcIbnFwSJ7N
	9FPsYP/cnO8fCQwjicPWQ1HwJxI2zq/3JFtr6EXS4FWwH4kuKmJkDYqw6pA4LVDx
	L39w8Jzh6FguDFtaf1Kr1tM5HY09fvAjsXNkceQzXNmAime/AtHC6/HFJwwwaVhT
	GFZa6xFTlZmfmsLWBJjadOK7cOj4abZpwKsD12i6BQ==
X-ME-Sender: <xms:WHZYZipIMgsStm9foPJ4cZxCSK9bJHajvqmw8NSHDsmkeVCvEc1Y8g>
    <xme:WHZYZgqS7CsiAtvD5Us7ERyukBS23Bxzw3MwOH_W0zPUQWkp_XWPXF1sZesNpiZGs
    3V9ESK7Nl5S9846mA>
X-ME-Received: <xmr:WHZYZnOCh4PVtgsbGKffoX-e9nJJs0UyBQrf3uLVw2GbOOkXx3xOBdgPLzjCuWtZU9o5HXNK00vbzArFSpHAV4NwV2OBRhSTh6LfxcuUNadvSFejyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeehnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WHZYZh5JzQAcVsFC2rm2e1f0XAzW_fxFsS5ZVA39oLs2WREUBsizrQ>
    <xmx:WHZYZh7aBG8XMEm2JeuiDdHgCFrs7E1papRI-H0mR34mbkkBcoqpKg>
    <xmx:WHZYZhhvljkh5o5AOuoxMIvLEjNn8ewnaCGy-BDjlv7jfP4w1fZa6A>
    <xmx:WHZYZr5umll6JNAfsLdlf3ufgXRY0f8KQZn16I9bAgnc2evIg0ytpg>
    <xmx:WHZYZrmfhLd6iYJeUMZpUNDZ0ddSgYBkYezd_9CAeiF7M3Pf6V0yA8P1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0162e285 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:19 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/19] mailmap: always store allocated strings in mailmap
 blob
Message-ID: <ffacdc37795dd5350c5a3e144eaaf5272523a499.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JMB+3KdZDspX3bWk"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--JMB+3KdZDspX3bWk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as with the preceding commit, the `git_mailmap_blob` may sometimes
contain an allocated string and sometimes it may contain a string
constant. This is risky and can easily lead to bugs in case the variable
is getting re-assigned, where the code may then try to free the previous
value to avoid memory leaks.

Safeguard the code by always storing allocated strings in the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index b2efe29b3d..3d1e092fef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ int read_mailmap(struct string_list *map)
 	map->cmp =3D namemap_cmp;
=20
 	if (!git_mailmap_blob && is_bare_repository())
-		git_mailmap_blob =3D "HEAD:.mailmap";
+		git_mailmap_blob =3D xstrdup("HEAD:.mailmap");
=20
 	if (!startup_info->have_repository || !is_bare_repository())
 		err |=3D read_mailmap_file(map, ".mailmap",
--=20
2.45.1.313.g3a57aa566a.dirty


--JMB+3KdZDspX3bWk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdlQACgkQVbJhu7ck
PpS5Pw/9ETYvC3uWrdp85huMH8THFeJ5YQS8VswG457IBVg/7idwOYYruDdKLBJd
p72nfbwpKP46c/omkriis9VfPtTX/FywVPGczed6izM+JSQMSizsm9N+dxFw4Y3K
4tpFHl01cKySoRzxkIwLwL/Tp9yMchhKFaNHp5cX53uWGNbN3yuY4RKb2uIbF4mv
m4oQ2G+iazRiWfhdtJ6e4nyjGmoS1QAZjaFzR5Bi9622PKTd2JZ3Wle8BFtHL/6w
8mt0AxW5VlalsfroVtRR3rXdQA2xFgp0PsMq1xL3Anyz6L068Upej4m0eIkBzyjo
4pv9a64TlLF+ZLJrwz9MdHNr+QITXneXQpuVlgzE6EyCAHViGDVW9GpyPrM9yVCE
0ATeKHGMw36lSLZLieaB2/OynGKT5Cj8yjgRPMkoH+Th4p1N6Xc66aineGLbE//5
gb6tpzA01/Z7FAFWfSv0UMXUJ2GBR9cxH8p8aZK1VKiuT++lw5kg1SX6J5vxfchw
21VHIw9xPf39PntMnlgwcXyXhv8V+2jDLW5k82vAjGxCWItUkIaTxlgFM+t7UA1s
0FlVCt3hh2hXUlPNNfnzA347zXqNbTjuXMvwe4lF5rhc5siEV/32Hg26GaAaHv2d
d3irDcq5JmfUWp5VasB3fyQKVhieFLDV75Ya9Ego6vcXXWafO8Y=
=QTOy
-----END PGP SIGNATURE-----

--JMB+3KdZDspX3bWk--
