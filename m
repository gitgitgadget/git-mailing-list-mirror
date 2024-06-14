Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004291487D6
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347853; cv=none; b=KVOrt6LGm/k/JNRfjpI+mPUmjVq14SF0ZyYf/bGgFoQUq8Js5x46qA9BPIx/+FzSC4b6kIPjMzI9BVwC8T/mWZ3hL8YNHJtBCwTw8QSGSHw9t3hkBRxQ1kzEW6u6YTiBs+L4/3H5U9zWu7EwLBIelWAq107nDIQcq4dNw/d8tzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347853; c=relaxed/simple;
	bh=XMvd5USmGcYQj2aWfebPpnriUnIFYr/96s4iMGphtu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNC3R9MBI+tYMUB0Bljp5G2s5sSJbu351L2CQgPSvaoFdzLgUsVomMsU8u0bVxDKl4J2OsWuh1phudeGmKhOuOwE6eH9eMkd8e5Il6GhO2iP1Cx1mEKh93jgwYzucnhZNV+/iJ68RrDyxHOW7tl9/FpGs7OJZnYq1CYhrtlzGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RwSJVrWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZEGle1x; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RwSJVrWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZEGle1x"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 31D311140258;
	Fri, 14 Jun 2024 02:50:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347851; x=1718434251; bh=8R6XRHziAK
	err6cMyBJFmgTM5ydnaZamWR2by3YLoS0=; b=RwSJVrWoe525ynlPMElBm9XEQU
	M6YYql8OsCQduclZV8SfU+MuPzBd55Dh4QV7YMaX5XoCTmUT8EFe1el7WaZPhqQ+
	KTBADNpkAmJ44r47ZJz5esQ4LTbIMqZmOyzPD6sfIdsOeLAJ0pMor0C4R+FnehMb
	6FG8l4VqzjutCbab+bS0T+Zgt3oJlgeAmbqr6gUqX47a2/C1Ym1DewKF4P7xq3n3
	uKoI2VMSNO62HcMkgbV98qJac9puYorLYuW2VQvXj9nf5hYGR09ncUxps7qc3xMd
	dY5+X+SysliYxsKvv8I9fHameEj8mfDTjnF1L0Gd+UWylaE1yv7AEsFZJCDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347851; x=1718434251; bh=8R6XRHziAKerr6cMyBJFmgTM5ydn
	aZamWR2by3YLoS0=; b=mZEGle1x6NxZjKatYC2OTzXhZfgczAEoTgNx7NCIREXG
	6WwK+iq9ZIrqkIG0VITCXF25ewaPDyfbTjgYzk9u+GI17mQChlNzFreGmaf1tDgR
	51yfyF+M0EaYWoFeUK2WphXn2Uyvq2HLOQcOSIbS6klNLqUZLhSyVpTL4pyTxNy2
	4afiQKqZo1kwqsoc7i5Hdqc+eXwRKLr8UPSnZaP9B5eLcgB3A7ahg1wfPryGP1z3
	bGvb4y0ByDrTNSqvUHwMZ2nhc9nVOx0kuwr2ovPoEP4AH7zdcz72+NJJEl9ta3B7
	U3mHxCJMxJzLW6ajlaTg/axuAGXSE4dCOT+YK9B8WA==
X-ME-Sender: <xms:SuhrZjO2QxKGgYLeC__pzXQN8-tgR0RGkdReM2ZnEZfyTc7NzdILbw>
    <xme:SuhrZt-BgBXNbklL2NSgKm6Wsq2OeJYii_nFJcc28N3vOvP70bLXMs55Ezuwu_5-b
    uCBjONU_x_UfC6z6w>
X-ME-Received: <xmr:SuhrZiT-Wa9LmToYdAavzW9D3OQTE1D2v5e5oYABYCKQ2WlYUOP43bZB25tkHOtpUPFbrGSpr3BnSvEDQDQJlwogxRC3LZei6hlzSIWnQTLkWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:S-hrZnv5uElmVvc07BN6KInVZFSOoOJybq_QgC9u6GGcp4-jh8bHdQ>
    <xmx:S-hrZrd_jndij40pbYFkJ116Gvv74J_2Q-yMSZnTWH1nck8H3SrtiQ>
    <xmx:S-hrZj1nBd7Qh6zTP5lknikLVTMLfku26jQ8eRNZSKfhjfaxmkImWw>
    <xmx:S-hrZn9U5-e_xhU-0Bcdr2ZfdEf8NYzOOQoM0VCW7qOn1cag9h1-mA>
    <xmx:S-hrZsEhm9veMUrMvcO_r7RqF8IlcyPRCU2GIpWPkPtrL60OD3EpYYOf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bbad79bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:34 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/20] protocol-caps: use hash algorithm from passed-in
 repository
Message-ID: <0b42208e2f675d6f7f24b842f42b16bf38e1138e.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KVUtNt/JC+922YJa"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--KVUtNt/JC+922YJa
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
2.45.2.457.g8d94cfb545.dirty


--KVUtNt/JC+922YJa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6EYACgkQVbJhu7ck
PpSlxBAAnEsq1IaRgOHTv3ybyOTLiunN6msCJEwtb5KcpQ+IseKv5MkJyIjRZKc3
3mh3LHvMP5VfBAmNmFqWPuliJEJtDb0Tw2DrXYkveaYU5qMBkR1qFEtO6fJgBONL
zEBWzeRAvlCHL0oGIbUg42SjEVHlDDtZWLKiBlJi9DKFKDELyNNxamrrKaqnGKVu
uZhTN6WZtXHm4BZqG+Sw3Onp5rsB7f/MjygSeyblKXReRZ+lE3Iek+Q4ZmAjW3RK
yZ+N4Cib4VMxyKuX6cqIRh8/ZfMazkSkCnihfhWzamKEuVidhhrdtbuz4KeNKcJ8
9VuXxbDMaSnth0KdleIFAMK5PMsxIfPl44xxvL5H5pUNoZcxm1D/Li2WYXfiTKNG
l03RqTzwnk89i6RvtlD4ccRuaTSPluWG3X/c3MDl5ygcVIYCFbKXDcKgiQlX/Q8h
CmktVGes4lXWeVL48+WLW0+X3YrwegXzD5H5eSCrQsTjQi5DEAp+881v5uybEM06
jlQQWKtz3h5MonEr4PIgTogD+12AroD4dG4XMxLbAjeSNUBQLv28f0wcZiZfQE2e
FwB4ape4QWrmQU6Lt2iOtSHEPciiwnmst809QMbiB8XGeFkkWb2WzS7IE+LAYx8w
ceE/qeiUsO6rIHQ2vqOvKAp80AyxFU4esOINz5VRtGOlFi4rQI4=
=O0zc
-----END PGP SIGNATURE-----

--KVUtNt/JC+922YJa--
