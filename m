Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415B1D531
	for <git@vger.kernel.org>; Wed, 29 May 2024 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962421; cv=none; b=Ee2b6aSNwZNtFUIFFMxM4vFLZIECr9LH8Ec8QpIlBecBGcd6ATobr37DAejMejR/hmbvkNfsxMj6hLIVAWQmCS1AHCFpa2Xi76vZ7u9HJUNbvID1FVegJipWU0LlO2W1RBHZOJ1reFrRe1gDVl+PtLW+lt8ZyPQ0e7BsMW0TIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962421; c=relaxed/simple;
	bh=1cBN2NpcD/vRqnj/RbF8iKNNtQmyQms45ZaFTC/ZYlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V10P1BUELS3Nt50OdkNJjrcjvYjVtnbrghhGrqtJ+AbAJw+Uv4Tffx8Jfg8aeJFZYIsMDEs44/IY5gsHRx3SolwU/7HM33Gj/+Yr+A0Zwzw1Voaem53QyYSPGtMHRkrVSfpV0C6BUSmikyCMQj3CXoyBtmOeJcCbivYdtm4EiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nVGJlXoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4YVtn7j; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nVGJlXoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4YVtn7j"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 9862F1C0017A;
	Wed, 29 May 2024 02:00:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 29 May 2024 02:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716962419; x=1717048819; bh=1cBN2NpcD/
	vRqnj/RbF8iKNNtQmyQms45ZaFTC/ZYlc=; b=nVGJlXoh4OXZ//Bu+mb6gxJX6e
	jNTAXh5Oh8awA1VYCRyZxceoDxYTEJUdo1x4dTnjPSsOSVd4yuJyy1aJqeW66rvM
	LlHHY8yUwnBz0vZITEBxdcuYaG3NpHz4QqVdTKEtT0/s5L2YEafbmzykFVzCeHYD
	yYDwmBwhHxMD8pVFx9wOuiaf9ADVH7gq2IWTFixI/83m5npXMcY+csXdV51duat9
	2hCZ29o6v1NM1m7rWkGeh4TO111Dxicm47RQFO3+vGtGcltoGDaFsw2q97CK36Fq
	TIeub06QKWw/KAmgrYZo51m9+WkMrkfSRQttMQdyz0V6l3Z7PUtpE4qeKKFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716962419; x=1717048819; bh=1cBN2NpcD/vRqnj/RbF8iKNNtQmy
	Qms45ZaFTC/ZYlc=; b=g4YVtn7j4LlQmdt7sT7DWPxMAt90Ec5TlsnmkMc/gwds
	wd9Oe+a5iPSpDX4FTYw4J9gOeO+21uXUH9mSGTAj6ni9GMQ/wNV9sYrhibehz418
	bba51X5AT30+WWVo+04Y9Wv9KFlF3kPGZpnuP/iAHlKT4VR/rGerP4Iwxa4d8r66
	lWNlVawwQUh2I6LDpFHSQbL/x7YKbIeSB2b8IL48XckYXNVyhwYtC7APVUL+zUZr
	/NtvVVG2j4r7dvg24kGv9JBFIyFbNJvS5fQkfDkkU2K7VHo2JONqvI0Pp3yBdaUq
	DWWvWKmh10des7xulLcnNDGY3bfmMMXt0fR2g/0osw==
X-ME-Sender: <xms:c8RWZvGKw5YgtwVdPbh7eBGp05MGF4duSell5WE2bD8f05l8viz0Mw>
    <xme:c8RWZsXKODzFivqBwJFqTqdHxgDwibgaMWulcPW5x2kJoSlC3GMFbFE3C9_hToffD
    cK9Ov3KOZxZK6LEyA>
X-ME-Received: <xmr:c8RWZhKsV2U3nkMc_aIq1PxzxRE02pLs6aXTpuwtYh7ao4DxgVoOepvHzniQMosfzExxvuGhftDfPPkJd3o8i1RMqRDKeop4Ytv8RD0kf3WNfxY6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeegiefhheekudeuueefjeeuteefleeljeekudekhfeiffejveejheefleelheff
    veenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:c8RWZtHbZ2yzvxmrsbUFpA9Ud6YhtNYDRxAOyQiqcM-IZ2bgTiL3QQ>
    <xmx:c8RWZlUippZGPXKr_inZfEaE8ThAfmkcq6BQdNJWmtBTmVN5RSEEMw>
    <xmx:c8RWZoOY10Qk9sD7KU9pTSiN7vvW0vgD2IQ7geBfdaTRerdd70uRlQ>
    <xmx:c8RWZk0zM6iKYv4Ey6uHp74tD3sxnFfBZ7BQ849FBL7R_8rP1MDZEA>
    <xmx:c8RWZoRrGxXVGr-VyjuIdoyS7gy7O7fs63ZfiWban18ub3OKEFAAnqfy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 02:00:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e7e33270 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 06:00:04 +0000 (UTC)
Date: Wed, 29 May 2024 08:00:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] t: move reftable/basics_test.c to the unit testing
 framework
Message-ID: <ZlbEcHL3fEFXbt-H@tanuki>
References: <20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240528113856.8348-2-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+P9HgH0apaQppmiv"
Content-Disposition: inline
In-Reply-To: <20240528113856.8348-2-chandrapratap3519@gmail.com>


--+P9HgH0apaQppmiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 05:00:02PM +0530, Chandra Pratap wrote:
> --- a/reftable/basics_test.c
> +++ b/t/unit-tests/t-reftable-basics.c
> @@ -1,16 +1,6 @@
> -/*
> -Copyright 2020 Google LLC
> -
> -Use of this source code is governed by a BSD-style
> -license that can be found in the LICENSE file or at
> -https://developers.google.com/open-source/licenses/bsd
> -*/
> -
> -#include "system.h"
> -
> -#include "basics.h"
> -#include "test_framework.h"
> -#include "reftable-tests.h"
> +#include "test-lib.h"
> +#include "reftable/system.h"

There is no need to include "reftable/system.h" explicitly as it is
already transitively included via "reftable/basics.h". The same should
be true for all other reftable headers.

Patrick

--+P9HgH0apaQppmiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWxG8ACgkQVbJhu7ck
PpTfCQ//YahbJnuIuB+hCRTYT3Bha2W3ygisNt94RfcWeVVQnG564d/k/wG3WXrU
sPI9gZN8a5vk7o4lJqg1n2m2VJp/tTQtEKFXO7/W3vAOMYgSaLLn/KC1KtHPSGto
12MDDbUbJvLZEPs/Y0BZEybumfUt8AvG0DsVkOoWl3Yt9UOltR4Q3IkyuJ3KQo1r
tL/TEy3bMmXNYjAvxiWyz/dr3sV1FczAWs0Rc2jAa26sbzlVndLtu8JQIQIWQwfe
odjzUKZo+hgYEzcLAkTr2F4XYciNtv2VzWg0iKPh+X0MZOhoB/VpJTIvstipUfQt
FPD1xLD7kV9J80zRgbc25SX9y2iD9Ys7JiR17JIQDct4d1Gt1vFnp+ZuEqYp8IgC
9yBQzf7XAZHPGSQKGuTfl/EMBtZx5f+B8pfp4t6x5IQmi5uKRI9W99z+ObkV8Qao
ZLAe+y2bFohngHmp7UsWut1ZhLoNjzp5INU40n7nekksmTNbubyTa/ROXAgg8FYf
QzHcivLU3wDPDtzJnDOchotj2Jv+LRAV9KQUe0WaPH/7bWrYR5+4xJ6wKWPqB+/5
ers8ZJegE+ROChx8AV9bZSxrm/A1v21LWkiGA0NvE4PNYFfbQmgCF8SS/Fnym/5L
00Gs/gi8Y8nOemf2hMPwnJHoS9PVsalAxW0ylC0eIYUuk5VU8gY=
=KgiE
-----END PGP SIGNATURE-----

--+P9HgH0apaQppmiv--
