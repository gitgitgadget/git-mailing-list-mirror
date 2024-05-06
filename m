Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86A14264C
	for <git@vger.kernel.org>; Mon,  6 May 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990115; cv=none; b=KVNumvCasJI5L5jW7jd571cDLrENi4skP7CnWlU042nZoCDIqs0Qf67rqeU3PSvojb3BFXl9+D+3JDXu3nUxe8FPFkGIE9s5O5pwdA9gYsWTa2bHbj5ogsDi2rcD1ZHl+3O8J9YQ5Ck8wlul5hdpVfaAxfhXrNu8v9Tp8T/UwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990115; c=relaxed/simple;
	bh=dhK09pJUMOC2LRDfQR3lGCYS9+jXilwd11g9U7U4EfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm9Ua7+so8E8t0eFVdRSTL7hGVjGX7BC252DTXKQR58yACHw8JxZl6ie6aJ6MMRbwlFdQQlgeEL3TT53C+E6NYrhv8Br5tygWEmdetd/jbeCCeEltRoCYuQvqZ5oKGhZlRci7PYmyflfiCd3i0g4jUA4/WpnGWvSVSohgso3pQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m0ahl/Dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGWg5Cgb; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m0ahl/Dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGWg5Cgb"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id DD86C18000FE;
	Mon,  6 May 2024 06:08:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 06:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714990112; x=1715076512; bh=dhK09pJUMO
	C2LRDfQR3lGCYS9+jXilwd11g9U7U4EfU=; b=m0ahl/Dq3OXuHMhCd0NiSz6dWp
	4eHnRTzIEWtKLnIVr+zjscJbh34ZUzlSwQcgA15TXfsneQMlFkvqo4VOTG8fhpCw
	mK47xSOSqg0gRuee0Wf3wK4l1sSA0llV9QmueL8Mhf6xvMwZLZXInFlXA/wyLwYi
	c0sQMGhRlmnnMozbq9z9N+iUFr2jZnuNuoqkgx9SSCfZAuaS+adUGJY5FNZu2sAR
	vJYzvSTn5gSe/FhWNkDl1ZqP6hHDg+WcC/WpqIM3GXSAw94jQRE0P3ryQ17IDDSR
	Q6igmO7tdFY2dXc+dO8+QApkAKAI/nehxGbUwT4fZhng+xlTa8JN2iQ7qJcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714990112; x=1715076512; bh=dhK09pJUMOC2LRDfQR3lGCYS9+jX
	ilwd11g9U7U4EfU=; b=cGWg5CgbPPOzVnMJFYjhOMniOkqgbTkwziKGNyudYsRi
	aPqLZ/EJBGOhOoScrcf6BV00MiOABPyA9+99EMbhc8SWf6RWNDcUggjh4wpN1Z6r
	MFaoAunCZsu71AZiyReqBARMJjAxd8XGyvO58LbQUblgpXeOVfMY1IDWq8wdqFQr
	cb91TtvaYM5U+amSYHOW09HtR3a0dMPTc/R/s05PfqeEAOgYBHl1TuHdZHKczgfQ
	P8RZGbWQYN75EgayKD6qzm8f1oQIbcAOf6xG7RaSJaOFTcJAhUQtrDL1iTaXHig2
	Ls0bn1JvcPXMDvvFUgLbQgPM9BfCNJzpznJH8Yvm8g==
X-ME-Sender: <xms:IKw4Zk7qu0vqKUVyWqMFS2_iJlXjG8xVwwmemuA6uztMhQnMpK-jJA>
    <xme:IKw4Zl7zYv8tkw6L9f3xOIeWvbaf_6oIqLs9NutRbVECC7Nuz-7mDDENN43sC2yWj
    nbOUx2e4SScwHLBaQ>
X-ME-Received: <xmr:IKw4Zjdr0HkHIc8LXGtUDd8ClIGsgyV-DuMKjn3LAAGkiO4ZJCkmLZZnTQsc357Wp_GX41Y0QV7L3USred2HaaOOp7_ApQQHEARMJZw7PIpUrhk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IKw4ZpJ8qOtZTRRzi8U1M2yrj-xIww1F2gKGFg5BQIKjIHfonDTmIg>
    <xmx:IKw4ZoL6g2WCEkzmUiw3rG89PGT49f83CxYVSyPqB2H527A-XYL_VQ>
    <xmx:IKw4ZqwRAfkdgUeca9BKR2Ml_vE24q-LTh_uBrEMgBMVKBtZW6VOEg>
    <xmx:IKw4ZsKfguDqND4y1eX9gpD6029mboPtv7uPDLmtyNzJ2HdrEtZ3Rw>
    <xmx:IKw4ZvUVL759i1onKN46dHJKQXXjxx6aPtw6Qz6YYd4iDX2aLvnPvHhr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 06:08:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2f5479b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 10:08:23 +0000 (UTC)
Date: Mon, 6 May 2024 12:08:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitlab-ci: add smoke test for fuzzers
Message-ID: <ZjisGhU66kDKkZsZ@tanuki>
References: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTtOhcOc7EV+ImP3"
Content-Disposition: inline
In-Reply-To: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>


--jTtOhcOc7EV+ImP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 08:13:23AM +0200, Patrick Steinhardt wrote:
> Our GitLab CI setup has a test gap where the fuzzers aren't exercised at
> all. Add a smoke test, similar to the one we have in GitHub Workflows.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Junio, I haven't seen this topic getting picked up in your "What's
cooking" report yet. Is this intentional or did it simply fall through
the cracks?

Thanks!

Patrick

--jTtOhcOc7EV+ImP3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4rBkACgkQVbJhu7ck
PpRrcA//dUZg2Vc6nIxadNSC9qjoG1t/E4ncf1z4M8kNq8V4DGSSw77JmuVuotIn
pMOWaLK4j7GAuOk+tdA+RG+RizOF0T6saYVth8Yy8zodE5DuF+iAvYOoR7iT0oHO
BDg70vtqOklX04r5zr3iDlzpkBW01E4uSwSFQcZbn82aVAeRdQMAQ3PyiC4oG08B
53Cms+TcRmKmqMtfzNpHLW5bUTpIKbXrQytJalEf4Z3zOyTbpbNcDsImPFhMln02
JKxOpZSecM+S+9H7o8aLCVJ8lGuZptyf4TiUBo6GHmwRP6euEcM4v54vQQe3Iaha
fWD+/srOkdDuc4LxwYLNaOXfyGzCDUU/LPImc3VXYkhoxkR+apvv2cnI8uIrNIVM
i4O6+hv3HA77Oo/zKtLwihTjQieWyUi5bQLU604vEYTA1BhHZf04f/t3KqwcyPRE
CJNZz79+gbwoe/K9ZbavJVLilS1KLWwYc4KIt4NbpbiMqlbbqWukqvL625or8VfS
MMzDWSsnNnOK9NuHknNTbWSA5FSWegvxGO6hzM8VWG+CG0Xqp5aZKwGiglj8v/M0
sHsN+TAiBn+UZ9ivqFoyoh0UulvAXP77BPItu7+P3YjO6u6gkuK0iSwpaZRLAiQc
5unTY1VKm5i1IGyGXKqfuVSdbfRFJuxD668Cs8k1TIzx4ojcEAQ=
=2GrX
-----END PGP SIGNATURE-----

--jTtOhcOc7EV+ImP3--
