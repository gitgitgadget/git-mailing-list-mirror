Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87257CA8
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719409; cv=none; b=EEKTBfXLAVdq6JEAKcG49xsBojFIU0fwyQF1KZebyuHa34BYt7NvN3MTDbPdv8DJliriz+WHpq95EWHgqk9fqUf7limnYekc1LL1X5lHyUlMo2sSoCmWmn4YLNmoeDJFz8J2oRYKGYUJbFRpgnsy7RoagEOseN251840ZUr6nV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719409; c=relaxed/simple;
	bh=c/6NQtl2RuhuFZIFY9rSjtygeXGCb2MSiP+k7fdjaHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tddyup+Byqfcg4Ojh6u3YWI1QTX45cjgdJcbtS6WW5VU/F/skSVW/WI3pDEoSMv1VvE+zorC9sGjt5i067DenLZtHIvS/+IWbv4hRJc/LgJ/ZwKnSYZV2ybITJIWs1uQ2C4uSLiDKgOY4oCWdn4JBgffUB0RRcpvAcFzCuHJ13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DRcxTiDW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=asfFE7zW; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DRcxTiDW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asfFE7zW"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 40E181C0013A;
	Fri,  3 May 2024 02:56:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 03 May 2024 02:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714719406; x=1714805806; bh=c/6NQtl2Ru
	huFZIFY9rSjtygeXGCb2MSiP+k7fdjaHA=; b=DRcxTiDWoT5yc1ywC84LquaMb/
	NEUi5Bi1M5aAY1rQlyFqjNUdRCDpMAeCV1A+xnsu1Do+rNv3UGxd0LqFuNF4JBF9
	0qhVR6ID0GG0MdLl4XN8r42LEGAR1UmhIdOpueP4F0nkLaiXkUcGf7xjppxoh+yp
	7xCzSvFZegQ1h3OUmZ3KwmupMJN3ItWYm1hE0fPBNsUI7zjRmhY8ch9R97H0vYRy
	b9im1aHpvKd9YXhESeXf0AD6hG1a9CbVkaAk2HGXS/4190m64T5RO+EonERFxH8r
	Vu3hsnPEUb4zxcful1cRXN5SBRCjgGVlTAPZ3wYvYZEm6Kg+JAfLH0Xx+XoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714719406; x=1714805806; bh=c/6NQtl2RuhuFZIFY9rSjtygeXGC
	b2MSiP+k7fdjaHA=; b=asfFE7zWtXvrHgvgv/wg+n63IiJRT1aqlH1wJhosZinf
	0qUeLQSj5Oa/ef8HUHxl6IYmZnYHl/y/v5uYpoSPHlKhqMB8076XeoE/55pzAFLl
	Y04Z0oG9zvHS0OTu3hser9b5Oj7OjGgnLBjrf1AoyN+01P4rzOqC26hay9nrnkcp
	SsKQc1CDYgSbuRV/dla/2rrGGqnOnKTv8zkQ9nqnyqpuoQ0X/KaQ7XGAxyJMs651
	JEut+mcamjsBiB069grBJqs3SrgiKPRc5wlpM+AGU99jcjozRJVzoVxSpZjDp1VE
	is33FcADUEASa5usNnqmhH09XbMXQUKrA57C6o9ABQ==
X-ME-Sender: <xms:roo0ZnSST_h-G1Yi2DH3oW9aCGKwdqnM3-y2T1JRRQ7DC-WTUV0AGA>
    <xme:roo0ZoyvWxrXGFWYOvXitUgQ6EoZZ6XOIvjF_DaF-PR3l3nuGRQbN5Jw9VWw0dThV
    ivArQsejLRYm2Bb8w>
X-ME-Received: <xmr:roo0Zs3eMc3erXPY-UQfLq4QLKIQKADt4FbWq8G6sFfRIHP_3d23h6WJ9V8OJcM3X0A-a8pfuJnLP-t6JpYCzXJTPqA3RpUo_ejfaLdRAPqk5Ibg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:roo0ZnB3R5y_Pgyhi0smLGBHO6n9umsu4ZxYApCHrMKIw1j716-rqQ>
    <xmx:roo0Zgg_QDcR27euYXavzt0_WkjTfwwWRmFy5Z8xrYQWziXLMAR7Mw>
    <xmx:roo0ZrqiQsthFUOSheCVUBTgtCzZYlkZbz4ibWPbhc_DzL6k_-rFEA>
    <xmx:roo0Zrj2pyupmWzXPhDvy_oelTgWt-cEAxkdEEC9IMBQoHdWKPsDaw>
    <xmx:roo0ZjslYdfqjqi4uOeLZ-NvtWwX9behrkV1qdPhuDPLqKSpVl968IMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 02:56:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c1e70aa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 06:56:16 +0000 (UTC)
Date: Fri, 3 May 2024 08:56:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ci: separate whitespace check script
Message-ID: <ZjSKqaJxd55328Fn@tanuki>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
 <20240502193840.105355-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="okPGIobRWRzQgIOQ"
Content-Disposition: inline
In-Reply-To: <20240502193840.105355-4-jltobler@gmail.com>


--okPGIobRWRzQgIOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 02:38:37PM -0500, Justin Tobler wrote:
> The `check-whitespace` CI job is only available as a GitHub action. To
> help enable this job with other CI providers, first separate the logic
> performing the whitespace check into its own script. In subsequent
> commits, this script is further generalized allowing its reuse.
>=20
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
[snip]
> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> new file mode 100755
> index 0000000000..f57d1ff5f0
> --- /dev/null
> +++ b/ci/check-whitespace.sh
> @@ -0,0 +1,74 @@
> +#!/bin/bash

This needs to be either "/bin/sh" or "/usr/bin/env bash".

> +baseCommit=3D$1
> +outputFile=3D$2

I think the script would be more flexible if we just didn't have an
output file in the first place and handle redirection of the output at
the caller's side. That for example also allows you to easily append to
a potential output file.

Edit: I see you change this in the next patch, so this is okay.

> +url=3D$3

We should check that we got 3 arguments in the first place.

Edit: I see that you add those checks in the next commit, but it does
leave the reader wondering at this point. Maybe we should have a strict
check here and then loosen it in the next commit where you make it
optional.

Patrick

--okPGIobRWRzQgIOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0iqgACgkQVbJhu7ck
PpSx/hAAjvDR3QUSQQp/rfsdVxrFb1450f12lET23TuS5Qv13/3yHwVdI12Ru448
r0ACv2ulhY6nIivVAFo5qmTX0aGTnuDNZJARSmyf914aZ+s/LgnEbDxcoIatgQsj
4F6zksI82Ki+4VHGd4jDSjibeX4quQTbZZU02JDqHsJJv4UPYbEssWcK/rLXs8gn
oYCAgVXlPTn5oufWV55jSW8RcmD9efag6TOB2OSls/3mJyRzcNm5/209DISgvuy1
AVS3BYU3q+60z0fCiSqfenaAatiQEoMu+yeNF9GlV0aTRAV5Bqpytqxne5+wDY2R
ZsgWXuOUzR8HrWp8oXrE1wUnNd7X5bfpkQ9MAZCgUAJROJGvhpLqcrP+Tau4kMgL
Y995jUvItu567o+/zn1Jg02hpqnqf0Jyv34G5nF3BsqlRUWOab1ZNrMBHvApIdOp
dfUsRpCVm+WF7IiLQ40cGZ2A/URKEt3whmAbmcYN2rkRKnI8GHOQ8qVx4YXMPrZX
KIGhBOjRXWcnV35Dze2Cio1SRqyaxWOuKTV3OJUZTbAPUVIuW60g5+7L+p9h3PWp
QpDnh0c3QR6kWDUJvHKoCOpcH/PVzFjMPgEPgGaPmCWV9tPIgj4+ChWuLcBrpfyI
goJpQe5mVBzisZJiqYK8vmBLDnBSibEtXc5on2YOSAg1bzcoPNw=
=Y739
-----END PGP SIGNATURE-----

--okPGIobRWRzQgIOQ--
