Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEC13B2B3
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046383; cv=none; b=WJUhnbWIykiq2e4b8SglUmhI8GAC0tpXZq4lTlclaLK2MBRWP2C2lsDJo1fo6rDyXXDgYmreAVdgqIeH52f1VYJhYzUsFD40Y51OJ2LPYWy1LEpMl2SZTeqHoDmM/c3axn8N0RmUELWe2BAaz3wU3cSxUdiC96cmDSQ2t8xDyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046383; c=relaxed/simple;
	bh=o1x3di21jZSSV3O6HGNFTA6NGS5uGU0yhTw+vDTdEKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqEphVjUC782XmwQ3p6zFO3SpKLZK6A6zrVADoPZg55WjuXso2lS69TDOQujIY+AVb1Urnd1Ew2+mn6FhZMPiNWn1OiAhs3JV8ZE7Cq1yQPPOQMqv3fHz7aOPOR6MsKp07z9vCBPVTEBwxs+t7yRr/FORBV7cJY6r/PcR9rDZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qac0YOWn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nHyMYqCC; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qac0YOWn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHyMYqCC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id B82581C00076;
	Tue, 27 Feb 2024 10:06:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Feb 2024 10:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046380; x=1709132780; bh=kNljyxlGd4
	z8pd1D93eCcRfgr/ks1BPuuqe0Wlql4NU=; b=qac0YOWnYTxHrdRwgrdRmWYXg1
	OJPQz2gaPA/BPOAbEvf7mP3Y675g/wMofjDwtpcuu9SeMGy2552mMZLq15KEqzam
	IPEh7ZTLg4kk/hcSYOBWgaWjFepf/Q1dokBUuEOyeznv8kJKjLJ4QAkVV1cyD/PC
	W4mOlTf7G7SJmYxTD+5ZpLiRVzdz1PjsI1HYAGtM0oGkISYMCme4C+ZZPQydHyCy
	GdDpHCDfaShrcRBJjyLYEbDYD7NjndA92iCXqRW4D/IiJ/wd5YfEDhPBxV/VhYf6
	G4ScWlwlMv/fBIH00x/BWnj7eUQwDiYH/ColytnpLAoYazYnm70wwIGas00g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046380; x=1709132780; bh=kNljyxlGd4z8pd1D93eCcRfgr/ks
	1BPuuqe0Wlql4NU=; b=nHyMYqCCIDNNZezv7gfWJSqoUloy24qCW+W8SuvfrLnA
	jkOCo/zytiOC5db+pu/I8J0bjtdzegREoqhZcWnJdeTkl9g3PtRwk5xpYvvn4MT+
	vOdI6hpXPObnD4Fm+NppLHJXLn++UCBq9oa6ohkDmhs/eoBXQtIWYwwTMDaNwrQE
	gUQ5/mrlEUvJ6qmFjZIpL60DRpkY4kXWup2nMp1kt4sYA8JAveKmVGkDFrgtEi9Y
	08xd+JTbotYOMI9av7zFV5vRq1jWBMMzSccuT0zLtf1EAbiPxPZXOf3XFEZ3+6Bh
	R/41RG27F568UmtqV3C8Df38GCyiuCjmLXpCag2fEw==
X-ME-Sender: <xms:a_rdZQLJbapTNA9jkeH6oAjgzNCpw4PLN05IzIV76Dsvtanm6f1Bgw>
    <xme:a_rdZQJ-JIV8c67VlCG8Ev8wHnfKYHVp9cZYGLzWvbNwak6h74YqUdXtNQ0W9qZqX
    BlrQ2JR8jX7JyGsgQ>
X-ME-Received: <xmr:a_rdZQvL91aHomfFWPqd0r_oXB894lSG8fM3g40ZvXmr8OWMZ8rasRPTpV6DcYNFX5aFWIYsr0r8GBzUCOCkNIbaKLbOWLyH7KnONJIjIcqXaGf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:bPrdZdbB9KTMl8eeMOIGpcWdiHeo15qbFdDgud0tPFThUmQfOA-e2g>
    <xmx:bPrdZXaQ6KNRNdE6Mt4hUQjVujhEfMikEAv2TcYgAYS6JBwr3UJeZQ>
    <xmx:bPrdZZAifr3oGwmvsoUesIlv6ZhigY3e3zD7yjRNtb-HWivRfSGJXw>
    <xmx:bPrdZWn2jHob_uYvt2usUVuGWpr7fqpnPWOOrOAsDpLizlPACVurO-lU2zA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0be84a19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:02 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/13] reftable/pq: use `size_t` to track iterator index
Message-ID: <292e5f88889142eb29ced96010b02025b134e3ae.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P1aLlChXFsjcY6Qa"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--P1aLlChXFsjcY6Qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable priority queue is used by the merged iterator to yield
records from its sub-iterators in the expected order. Each entry has a
record corresponding to such a sub-iterator as well as an index that
indicates which sub-iterator the record belongs to. But while the
sub-iterators are tracked with a `size_t`, we store the index as an
`int` in the entry.

Fix this and use `size_t` consistently.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/pq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/pq.h b/reftable/pq.h
index e85bac9b52..9e25a43a36 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -12,7 +12,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
=20
 struct pq_entry {
-	int index;
+	size_t index;
 	struct reftable_record rec;
 };
=20
--=20
2.44.0


--P1aLlChXFsjcY6Qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+mgACgkQVbJhu7ck
PpRZVxAAjCNKatNlVebLZwYabN8fx2gNehGyNYVljm3+78HFzyy1HEig5VpMft5k
IgcRltqNUuHVrb6kZW0KQaz1Gf7oshGwfBEryP5GQuJVDu1WycUPtMP9TTymGkiu
33K3EGqXaXc9mSTL7+29/eBj+GU3vaHKoaVKSHZagGs2AERqHZcCUU+TQ9pMmMIK
/x+a+WInPMEXGCo7fVc2iEuiAjMkjMVmc22ElkXdXszxnZ2eTJpoFHeEJzMXZ/Sd
ZCDcsTvJFdyMp289sje2tr24GTCUZUNX7UfnyFkER4o41VCU5Z0ManTVgbvedw9e
QdoGbDd7C7JQSQw23L8aaTrxbMunhiLBjcqUlINqBDMd1tpvhxZIMeZAvuhhN5qW
l8GpWtmXLY6cbFs6Z0MRCOYpR3nT6sPvhLKBA0IgTxv6QT1MY5om6qY/p5pVF/rv
3db3hLddBGubYqdXAxoYAqiTJIP8QparQZRUDy+lLpM+IiycraspXhoi/bpkNgLU
i0/vZf6Kj4FJWQnxWCQUx9I8UWSgNgLv6pWlxFC2gHDo5BMh+gV3pVrPrScqZcoB
/HAOxW10SGgYmUZsFBwInTv4dxhir5iGEZPc87/Gtfi0Cwp7iKJ4ann26poG6/2i
fHndqpmtinTVdXRRFVvO2i39wSpbTnY8772ya9p7+Y1I5Kj+XA4=
=LkhD
-----END PGP SIGNATURE-----

--P1aLlChXFsjcY6Qa--
