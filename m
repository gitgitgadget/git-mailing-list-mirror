Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1217DE23
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986700; cv=none; b=V1xiN1qhOmeeI3aZFwBXvZ9cUtm7Byf8pzYW8YFU2VUQBZKhkEtziWkqQmPTCLiFzZGkUM9OqtiWfIUZBHWeusY0Kx+7wHUlUCPu0h2IXILJpC0z8X9x16HKnuCrVyvNDBAl8bJ8R/ZTPwUGYWl6jE2nKr9ij8jFPS0FcFgetsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986700; c=relaxed/simple;
	bh=n9ltBK6kA1YfefChF2RsndvU9ab2GJp4H6r4FJz3NMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muGGJiQ6ZiB52+xqUhtacCxUZP50VwxiddU9QVkRG0ni7dSQ68jqSrGR9VSgxpQL+ALfYIpnPtAdjofMSLnejYPbn7uazVvqnXE7YRKvogL8aa5L4lxB9ZqT6LdxDUxXQXb9SgNR2UkH8jL+aaVTxRBPxh70i8cK+k3M09uyheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=izZpvhzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dsA/Vi6K; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="izZpvhzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dsA/Vi6K"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 120341C0012B;
	Wed, 29 May 2024 08:44:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 08:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986697; x=1717073097; bh=QEWvrY7Ioh
	5pxPYYIgtkwUPRFTUX+5AswJvln2Xlf1Q=; b=izZpvhzrHBIFSpnpt+pOrxf+Co
	W11pi1AsdOTn54W+HItBpsBY6Zn0F5UeQFg48JuDREScau4ii960TLkaK2wVerEd
	hg2TjLjjFg4/UMRC3CYnbUjHazA6S7ZQv7NMNyEkjwWnKSKU372ueRPtvg0dYeQx
	+61D4CGedna1L0EnnEyau77kOjVgVsLLd/azfzhNzTGiIkulRqtMRa7GD2ZdrDPG
	NTv3epk6UmFqbMQAaYGx1p3uxyc79epHNftjISEPrY3xzZMvLGeN4JZzZ/uA2q9K
	tndJoC/zdTzj2BG1wHhiL3oj0gEblPdoj4iTozBkP7yupsJA9+gUBNm67rMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986697; x=1717073097; bh=QEWvrY7Ioh5pxPYYIgtkwUPRFTUX
	+5AswJvln2Xlf1Q=; b=dsA/Vi6KzBb9zD7BFelXTMDctlEITvHbD39PhiFQP9UZ
	S2PYTy7cxgumb8HWWtq/9crTCpNvbk3AWKu4H9QkPgsQou3NCbYVYij8oQk+YNRR
	16ZFOZ5QCQ1MbAYAn5lm4/qUl7Zo++0grrI15Jr42ENM+nzCfJStDIxbgbz7Z2Mt
	xn2hoOI8MzaPrc01zN7qF0JGoTKbyq3uCgvNrWscfMJsqu/r+H/TREVjgOJtaFZT
	5uspDCA3sHVIUwEsG9KaTB8q2nu3OzxoWhbpz2ov6VSl9PGC43XXPIx10d7k0hhT
	ow4Vai2UKfpuSt8arTZJfK/4eqaQqnDY1Xbejox6vw==
X-ME-Sender: <xms:SSNXZrfftT-k_1kuFXmm1cbAnpBCSzBACVfCo2v-n_ODn2g_eTikpA>
    <xme:SSNXZhPHGL5dTag2JrlruV93RWYjPWcBHX7nK9mpqdI41SZUp4X5nXtYOdt6STFVk
    ggITbHbd1uiFyBQSA>
X-ME-Received: <xmr:SSNXZkgtTCogUedpcNm2iYL2C-XxvfS2RuJR4MJiV9iMxi-Ejq3QpUrNR6rHhZgZyGli1O3go_8biwnmoW1ml-LEWtsw6PJOtEnWxd5yw3jhp3Bl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:SSNXZs9jYeaVxBVOVILJFN4bKHS0w7VcrsHqS1I-3h6CWD3NtO2F9g>
    <xmx:SSNXZns9O1jXHNmHsErEeRTQSYqLmKLcBxJC_AYJoul7AWa_e8RFvg>
    <xmx:SSNXZrFLwKIZOLxCaxjlPCT92ujh8ehEO4uTrWuWuYS1BCECr4qNIQ>
    <xmx:SSNXZuPRqsfa9VqvgQlHABoTvuas2j-pWKd-CpC4dpfmaAbpet3qQg>
    <xmx:SSNXZg5fZC_rwRyW7E62jpSvl2rwshwwkeUZiClbrZDFGZ-egI37koC3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1464fc60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:42 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 11/19] send-pack: always allocate receive status
Message-ID: <3cd28ae38c46e09607c06cc06868ad7692082d57.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d0UKhZlKD3PnPJrZ"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--d0UKhZlKD3PnPJrZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `receive_status()`, we record the reason why ref updates have been
rejected by the remote via the `remote_status`. But while we allocate
the assigned string when a reason was given, we assign a string constant
when no reason was given.

This has been working fine so far due to two reasons:

  - We don't ever free the refs in git-send-pack(1)'

  - Remotes always give a reason, at least as implemented by Git proper.

Adapt the code to always allocate the receive status string and free the
refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c | 2 ++
 send-pack.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3df9eaad09..17cae6bbbd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -336,5 +336,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
=20
+	free_refs(remote_refs);
+	free_refs(local_refs);
 	return ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..88e96d000b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -259,7 +259,7 @@ static int receive_status(struct packet_reader *reader,=
 struct ref *refs)
 			if (p)
 				hint->remote_status =3D xstrdup(p);
 			else
-				hint->remote_status =3D "failed";
+				hint->remote_status =3D xstrdup("failed");
 		} else {
 			hint->status =3D REF_STATUS_OK;
 			hint->remote_status =3D xstrdup_or_null(p);
--=20
2.45.1.313.g3a57aa566a.dirty


--d0UKhZlKD3PnPJrZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI0UACgkQVbJhu7ck
PpSiGg//TFjDMPFyDnXQ7xnu9wmRVPx+CkAkw0PzqvyZ6qNfIuqNA4vqAN6McLyB
eAzh/AdrI7JUtYaoG0FuGgyQk5gG15lzOyfCNQYit/YLISzIh7rtGuwU3PwkIUd3
M3w8KF6LhjsaTYdjxcPPCaTSgw8LG7hyl7KqoTwm0NY8rYCErnE0xFPONrlHXzHZ
1YK25tDmqGg3zSWcBwa/nFYzoAKjr9ceTuNlWUPNH1KxX6sv6Y2oqNBiaaIHlAx3
gTdOZNjEezgCUEF0YFlTeMwjtdbs0SOmH9ynZ4oOzq77uQOrAGX/NJUSN40FK2O6
JtGZlgUcSJ10QDgaO0IPYPFJGHwjfGfSzNgXkbNTHmcq6nXSvuSuDX91D5Mjgl/M
eqPOIwPsP+Fk4V8kM6UEH4p12RFmStOCxqUZziIy2PkCA6OXYPYMgT3yQBku8FC7
edoJ0DMUtpz5jn8+f5LOtROyDySNPF0FyCxyA9k9DooQvEUf77PZ+l7ub54Gybb/
K+wWbiWb84RFVXx1JHLpbnIOssDdFfFy1YpetOzgOpjRzzJtWmF2MUODuNYjaFvO
xHcFO41F5NSCe1lj1mq5R3NAcGthjiz91IHpo9u6cp5kQK+Ez2lQ9kVKgbWNmfRo
X5CTF13sW8NeKqhG9vRR8NGdUYYW3zFGru2+DqEyQXe+qtkKfww=
=bEHm
-----END PGP SIGNATURE-----

--d0UKhZlKD3PnPJrZ--
