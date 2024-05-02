Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90E225D6
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632726; cv=none; b=I/Fx+yxGC/PVpNwxF9KAaOUkwjRfnALLkkm939pTadJ1Eh3JaYOupriRsAEQMMvfX+NUubxNJofS6EDYIm3BVlgOuZ8Omu+I8RWyXhzTSNy3OIBC7OGKyn2Yu8+nE9t5Hflk3jMopVyrGStvZIuPGtryQD9a9EUcK0KLRtA9ma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632726; c=relaxed/simple;
	bh=VIikiLqrQIA3iJ8tj10pb3LCV1AJJPcbCTVS2Pwu3iI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C36aPDuu74zq5767IVgTz22nTy0eOJmDkWRcmy8/QSygQ95Fz6INqBg+t89c8/tWgkBn/etfDLLmpfR0DVpziv4gsZ5OTGyeKCM4gGNpheMNwSX+KnbFSSqrYFIQ9KKXwmKTqFfMdlZfcVTZCUUKzouq0DLLfqxrifZtg4uqvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vlbMrutt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ck9U2sGh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vlbMrutt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ck9U2sGh"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 82ADB1380388
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:52:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 May 2024 02:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632724; x=1714719124; bh=KuRt2mfo/k
	HbfDB2W2AMwumLHOhcF7qO5bMwumE4LSc=; b=vlbMruttc3Ay/iA4JyQIt99ydb
	Dq3JeHf9i1sR9hyy8cGc/+Oxo2ilCdF0tQdc049EzsDmhFPUbB73rQ6cpzT2MteN
	gvkdgYbsJsvOIa2mmwOYrcpjsKOAwGOYgUf93hQtr/yIrQDc9FCYOImrR6uWPJk4
	yobgD/DD3SdzhUStOBY1PO7A+rfm89vW9q9mYOVzt7NiTcOIOoSwVmK5kaPlfG+c
	3qWYiZHDxxhnQtJUGJBLbRO4/1nzyChC81iPgyfgZpdFxJkGr+eZambZeqVGC0BI
	VS49wJ0xOljt7ggnD1XInPsCb0NYOlSWcrJMIFWK5xPlrm7HmfkdpS8+5QQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632724; x=1714719124; bh=KuRt2mfo/kHbfDB2W2AMwumLHOhc
	F7qO5bMwumE4LSc=; b=ck9U2sGhw0T5ojaEY3zKz1y4DG/W5tY8OgFb9TVLfqcO
	VTK5d5V32sfpYmNFU6FCJ0xBB6SkAgs+IVVIbyZrWTz1sUpJISGvFhDNIKE8bLpz
	dfI6iR2Oc0XEvqcnejZIFc981vQAddfKg6Fvl8BnNb/0ptDLERtbaOVJINHqwjDM
	LaJO53CA9CDpT+Ihg5O8Yiyg3kn38OLBNapVThT9owyeprjeJFrvIvzCbkoVxLrd
	BayKM11XDUNz4xPMCmHfF4bNnrWveBeczl6XenZhr43Jvz3kkHr4iBgkKyER+6dV
	I4Ju1cDI81Ab/XIydtg+q9mT0B8vVuHkKsfV0VcKGQ==
X-ME-Sender: <xms:FDgzZkkLvOdiX0isnmVpnsPJbc0QoJ0BEHFpAtoze5NfOAmekrbakw>
    <xme:FDgzZj2AdpotdXUbopM3-5rNXPSs5bDLE07CsKBLuhqWreEALI2EZO5pbxm48XWsf
    ZCYBykXTQplP-5FGg>
X-ME-Received: <xmr:FDgzZirAR1FY1A-8Fxq343NrnLMvDXR1aKozzKVLKj3yJqcsFoLMQ9yY1Gj0p8N1QwKVKcd5xoRxcNry4HZMX6SqZX_guSPFUXNFYoj6QICt43w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FDgzZgn6zenzX4mh3KpJOSYs6gOjrYtSHQviGJYC5Nku7XRngPj51Q>
    <xmx:FDgzZi1Q5yX1dqmRWIeGlTr2z5MfBeQMXuYs3cnH-6-bN-mdeJjCWg>
    <xmx:FDgzZnst6GUX80glDld6ASPoIER1b9al7arkXkE0XT4zX-UtZrtTrw>
    <xmx:FDgzZuVwuQYFUedm7d9Tphxya41S0T0Q7YLNbxQqNUXL2OpD_5bbaQ>
    <xmx:FDgzZn_dfOdXOx12za_OmroGzqIzVqIOu-M-PMRQhBq7EGlqZCevHQPI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:52:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 46023e75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:38 +0000 (UTC)
Date: Thu, 2 May 2024 08:52:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/11] reftable: use `uint16_t` to track restart interval
Message-ID: <79d9e07ca92baace4b729b0b9b9227735a84286b.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5TR7ktRh2Z5RS1wG"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--5TR7ktRh2Z5RS1wG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The restart interval can at most be `UINT16_MAX` as specified in the
technical documentation of the reftable format. Furthermore, it cannot
ever be negative. Regardless of that we use an `int` to track the
restart interval.

Change the type to use an `uint16_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.h           | 2 +-
 reftable/reftable-writer.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/block.h b/reftable/block.h
index ea4384a7e2..cd5577105d 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -25,7 +25,7 @@ struct block_writer {
 	uint32_t header_off;
=20
 	/* How often to restart keys. */
-	int restart_interval;
+	uint16_t restart_interval;
 	int hash_size;
=20
 	/* Offset of next uint8_t to write. */
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 44cb986465..4cd8ebe6c7 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -28,7 +28,7 @@ struct reftable_write_options {
 	unsigned skip_index_objects : 1;
=20
 	/* how often to write complete keys in each block. */
-	int restart_interval;
+	uint16_t restart_interval;
=20
 	/* 4-byte identifier ("sha1", "s256") of the hash.
 	 * Defaults to SHA1 if unset
--=20
2.45.0


--5TR7ktRh2Z5RS1wG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOBAACgkQVbJhu7ck
PpSI9g/7BN5iwEh8u/qyPG4gK55Uh3i+Cqq0lwimXnh3leh8rFjgWWjD8slnErvt
p/YDzEQr8BtHtSLCpNejZECt0geNTlcKUYaRlP8Tn3vSEgjoboxpXyzUYRbFSbiq
U94pCi06XDZGIdTjdB7se4dSz3BO4XtdH6dnPN4hU7kXXACpZSoAWQyFwGHxzvrG
VyhtWUfEWbhr5sEASaAgCpf4cWIT8NWiMHvveHWJjOxz7sC84O2CCMZZxsboCWPI
1lubzIGqdKAlqxrgWjqkHfLnmhTE+G9SU0ki2L9oqg7foJ/mraYBJyh05sQnnSd6
g0aMgL23DdzMlqLIH5uzb1yR+ZJ6YUBilFtWZQBzQ/my/iSHa0T+EefuvD5PNOGn
KgjguYv5v2lZKqW+vdT9Q+vIy3daXrLLMBEE75CpzVPN1nS5T0E3LvOnbjOmmf/2
yfL5ngaKBpnlOHEShvSpk47kpHKWWGERPfyL2+ZY4u/EGG4dnQOb1cpxIfQbJnwz
3HiyNOIGrnbRc79Rp0Y97r8BnMePLt7/fjdzu4sok/wiiBRl3EaBEvbwKTBuwKNs
CkxHXYbjY6M1v9zOC7HVQCOnED0o+0C8jSdzwXQLaOlxa8FcngcHq/0FqtMdhrYw
dGoturvGO87rq3yVQQkeiDM0ToglS81ReR+ldYtbkJQOY8Y5s74=
=dTtW
-----END PGP SIGNATURE-----

--5TR7ktRh2Z5RS1wG--
