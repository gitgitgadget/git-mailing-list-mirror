Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300018DF84
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122377; cv=none; b=P6Y9GqUDeCpMCUQO+LDoMfNxGnoLkDJuOdNSXNCrw7XQVn0zoIzqAOJgryZqYGh1UDPWvaRzZ1iZdPvkM4/e8781/7ZUm2JgzDRPE69RDDMibGD8+Z310JFZRiV3FMFiVYGMbF4AoeY1LCGipDvRMb+tcabMofb+YwXPrtXQv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122377; c=relaxed/simple;
	bh=GIlxa1HODxkm3hV8nIa7Dtqbo7cbrCwwnRK+XbQETh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQgQZjLH6QwBMAvrm3oBq7Q5fo9bjHKbmcJ5J4nYJgA+jHsbSvvgLxHM4r36vtgq9g2BONpagoLDKBEWkepaId6ytdgONYhAVW5ZNWouwe4symZxHlydT9fDLQGoqq272RI0EkKdb4+eFF1fs4gYwgP3qrWF3aRxOz0LUe0PaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iaTJsETU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r2VXH4ZP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iaTJsETU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r2VXH4ZP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id EDD26138FC83;
	Thu,  8 Aug 2024 09:06:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 08 Aug 2024 09:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122374; x=1723208774; bh=bj+vfxISpE
	cIZwT0dec/TuA4lSrpWQ3tkTj/ADbEMlA=; b=iaTJsETU+K9Iz6ERjhI8gi+sTz
	FEzOeuACNpfEvSrwb4NTM4kG2g0C5kuZi0gIGnvOs59tlWrH12cndAfd7DpWuj9i
	NORIf/0vQZw4pDp2sv0WKXbHf6acfTAJO0MNcyfMNhT/XvE9gCtGQy9y3ngt6wWs
	M1ZhSDA8VbIqmTQnQC8UEgt8rSQqoUGimrs/MqrjS+ej3oPy5eXqJ/wATj1PEosw
	mr2hBHOp/asiNsExa/HMh9cuHP9F9RfYG7UdKPihvOVzGoOamR5GZ0qL25+EszTp
	ZJytrl7LJlj44InvczgoBuh7uIPA9Pmhx+t0wS0ROvrnLodgCy2hX0n1WtZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122374; x=1723208774; bh=bj+vfxISpEcIZwT0dec/TuA4lSrp
	WQ3tkTj/ADbEMlA=; b=r2VXH4ZPRX0+FoUNC9844ZeRaolR//KTi07SDKuzUBcc
	5BfOj70v15mjxEvljZQ4M2AXOKxZtBoUGD/EEbMAFGY4GSDyUy7t5JrrhWPK1g9C
	PFmYGFAAC3G8IR+j8IZ053ZZGd5UMdQ0BF3+/iF/2rncNj1dVWe+pV79jR4iQJjA
	hrIxh07OC6Lf8wuZlwKUC2+Snn1oTVI2hHgdC44Dxvq/qAV8rp0oK9UrtHYp2mAL
	g9p+T9BHilbYboqoQkoX1P0B8dHXIU3GVi9wO9BOy3u4YSgqYL3SJNzaUJ1AmdHv
	GObl/v+R6pCYEIQEiUYIcKDKYXe54uvVFNkEWX46tQ==
X-ME-Sender: <xms:xsK0ZjohQbbuJ7yZYfnXe8JBfUdY1uFdzEankJvbJv_NSD9OtqRTuA>
    <xme:xsK0ZtpdA1OZ93pPv895RaHgNtDJgFXb9FOYnZBY6iI7FwRLeLsRaLojiW75-IehQ
    063mNG3fXBPQhWWQA>
X-ME-Received: <xmr:xsK0ZgMqGeeCfY8WDFzzMO90uxKRhoUiKm4D39K1sdlAFTzByHyK0dI20ufRIIFRE5QNgM8dLM34LdKFFN1KdBQViFT0UxZmLOr2uSwHI3qp-T6q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xsK0Zm4BHZul3AAtT7EJzMxmb8JrrK1D0me4B-sQLwk5O-98PNtEcw>
    <xmx:xsK0Zi40TgyFZUSuHpOsXRR0DL5AJVeBg3tMJhw_V2z-5oXWn5me6Q>
    <xmx:xsK0ZugnfP_m2nQOwSi98Ck-j3MhnfpjSiHEyUs3OzT7COtK-IBilA>
    <xmx:xsK0Zk7_NMA9SraY256emIjbiZGs8e8nl_OLCQ8pPzvLBo22UlewWw>
    <xmx:xsK0Zomi-s3_iH8b4CF30B1i8g2hMN2wREZEZzbhJ5m1XpOHIbC1YB3D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:06:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0291d78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:06:07 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:06:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 21/22] diff: free state populated via options
Message-ID: <245fc30afb4d9993381ecf53f8c081b17dde3539.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rLPLeH93sww54h/s"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--rLPLeH93sww54h/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `objfind` and `anchors` members of `struct diff_options` are
populated via option parsing, but are never freed in `diff_free()`. Fix
this to plug those memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                   | 10 ++++++++++
 t/t4064-diff-oidfind.sh  |  2 ++
 t/t4065-diff-anchored.sh |  1 +
 t/t4069-remerge-diff.sh  |  1 +
 4 files changed, 14 insertions(+)

diff --git a/diff.c b/diff.c
index 9251c47b72..4035a9374d 100644
--- a/diff.c
+++ b/diff.c
@@ -6717,6 +6717,16 @@ void diff_free(struct diff_options *options)
 	if (options->no_free)
 		return;
=20
+	if (options->objfind) {
+		oidset_clear(options->objfind);
+		FREE_AND_NULL(options->objfind);
+	}
+
+	for (size_t i =3D 0; i < options->anchors_nr; i++)
+		free(options->anchors[i]);
+	FREE_AND_NULL(options->anchors);
+	options->anchors_nr =3D options->anchors_alloc =3D 0;
+
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
index 6d8c8986fc..846f285f77 100755
--- a/t/t4064-diff-oidfind.sh
+++ b/t/t4064-diff-oidfind.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test finding specific blobs in the revision walking'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup ' '
diff --git a/t/t4065-diff-anchored.sh b/t/t4065-diff-anchored.sh
index b3f510f040..647537c12e 100755
--- a/t/t4065-diff-anchored.sh
+++ b/t/t4065-diff-anchored.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'anchored diff algorithm'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success '--anchored' '
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 07323ebafe..888714bbd3 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'remerge-diff handling'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # This test is ort-specific
--=20
2.46.0.46.g406f326d27.dirty


--rLPLeH93sww54h/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wsMACgkQVbJhu7ck
PpTZ1hAAhz8W3W/I+r1ViLLj6dFSqbCHzxz1jJr55lkdJMum7F6HApsrGX8GEhu6
oEseTPpHdIHPSvnp2CIN4FnyJAo0yzAA5dCcz2WB090NZ/cYLM7ofzKbW/sjGl1S
zvGpE74VtFH5rz9yTfbNQgca9CPAbCbI3Iccn+37Qgx4d9p3uihtbSgy3z70pt+K
nYrX6Q7Lz5q3ZSxlktfjlyNvAJZncCpHrX/Rr4VbGUQMLJmj3w9oHGzYGfRfhrHq
jJI5vyh7Hos8FC97ws06B7rJiEJmN8eDZVVnGG2mZRijh3R3b0+0Y5JzYwz/Qm0J
tsLnF4nuAi2SwDhO2AI0HJbT4Fu0npmzDQWe47S3mDN8zTpY6BTLPIsN1O4tfaGr
5KUA5rDqoqtW8GP93q7yDlWODkwB41JyZNDsXDbe5b5pRkdiX/TIWyyozz2r5Gnp
Ip0tcFb4uvBhcSSQySaBtLeNuSRVlojqLhGsCNO5x8xRGWMltoKmvumt4qwss/8M
O52Qq249GaJV4D36xZGQ3e6pha0Z7/SJRlz/gKinkfsI573fXD+HGw0SS2d412OT
daCnzqwsK90prIPXC5ln8Qpkk68mTFiczDNrL1oieu9Ar3TEtKymFb51Qo1rh2YJ
7JiQerqRpgfH8kbfwfsFjXU/+p/zHtJ5vtWxnwcN81RzaIfmCsA=
=Yhzm
-----END PGP SIGNATURE-----

--rLPLeH93sww54h/s--
