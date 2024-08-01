Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B1187FFD
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508857; cv=none; b=U7zN6VeZ7SURfqD01cEEVq2pzr5+cOYDET5LiuSma2/F1uoMNBGYQq1hiW2dj7Wwnvo9Nvx9NG8sLjVIRxrIq5liSDUaWPye6LKgUtlCrbBIe6MuuP7aL1vWLvYep0MkCDAQIit/MHW9ZswZhEHncqykaon1BUFHVJLseYyHt28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508857; c=relaxed/simple;
	bh=+jyaHBZmMO9HZrdbJUxqO76nlKJpV0w+nmM3zEa4RBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cObCpVNj/B9xT8tRy3Jy07Gw4WrcNGcGgu81OUxaMFzQQNv4kxxuAa4C/Fu2rm72+6aNZjyCUm4Sya4XSbUcBIucmwie41sghPhnmLPqGtA4qKerMhshGNzZEKUty+LiitBLAbPM0+sk3OvtgsGJIfkCqHd1IsyfOSKCWGMtkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aH7alLAe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IygkNAcE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aH7alLAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IygkNAcE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 78BA41388075;
	Thu,  1 Aug 2024 06:40:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 06:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508855; x=1722595255; bh=lhSS0S2Ebq
	Wr2fE6FQbtKEiu8z6y8YnXjZeEeLGk5Ik=; b=aH7alLAeNJTQ3KKLvEW0r32fhk
	r7k2YnwRZlZgZZMRpltrCGN0bOvDJtcPv1Ym+1+kg+YtQhINsIdJz7G243VHASZ4
	TtrYq/8unrUhc2ICFvx1a6QI3kAiFq6zvSyvSj52zTYINh040hrBcUfeRimvf9Cs
	YhzxAHSYXd0T4BEHFniQGVQyudbe84iq7lj0/1j+yNFLwsE8GBGShA7qbEeYsEjH
	f7pTywZyy4Q4nfcPkr75TlK1HsCPtfNVKdaWpyZOZ+IseL7j9CNOtqi9ZYpVb443
	xInXvYk/+1nxhEd0eEDjEq4qkk4EjF4WTHFwRbbKZw0/9kyA5ZjkQWI7gpkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508855; x=1722595255; bh=lhSS0S2EbqWr2fE6FQbtKEiu8z6y
	8YnXjZeEeLGk5Ik=; b=IygkNAcED5TrYcCh8zJfAK/pHwa99w9Q2ilqI9bkqUmG
	w9IrU+X0eTUAHy8XbHt+BYwE3tQtPj+7TuBBkyBOmiIosvASEIp/DqzC5MqUxPXb
	Qa3rbyG1buAhd8TcgL6MwMuCUK6IQyrz42bh4Mt63sG6Tvbom4vHqJDbZseLNLJP
	qCVM7vmfmnkgjL07fHxuaahUdHNdtIosXd/GPrOipoRsrROPRCMDReOdig9wH+He
	t/RpEKAD2VDU0nTBxrd4Pfr0lLwDmvszrai/AvfWL6oh293bP57FiYH3loLZj89C
	5CX+ZLGzsYTR1/1Cngh+nguiXQHZuI25B05tAsuwQA==
X-ME-Sender: <xms:N2arZu40x-fvhqxO9j96qqgOAIcvGPT-HjYjklTS-b3mhZr-ETOWLw>
    <xme:N2arZn55vSDrn7jSxPRJXwOtMHFe5wT822ihywPQam3HieawuTMQ6ECqU9lsb4M8u
    0GcgXtzDslG6Vcghw>
X-ME-Received: <xmr:N2arZtdGXGdEK7hoWdKxCZciPSxxs4AXQQNqF2PmovL4Z-enYxGLMAGUXrBG-onz-M_0DiuzqQKrYNPTFhchE2VZKM7HtFqPwl5YOB5NmW1gkp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:N2arZrK_Bu9xcWlFJiBDcJIwb3qkiD4vdNl8yMI8XLLPJzCYhn5uBQ>
    <xmx:N2arZiJPdSb1UxgM2x4FwD8dexKPOCa0lXVEtqfBMk4fJKSVraXmwA>
    <xmx:N2arZszZSbWKU_7WGjnnuc1C8Dwtjvqmekg_HEgeImfs5IQTf9eUJA>
    <xmx:N2arZmKVzKypvXYPkmlZGWe-zd0tYkwWc8HYPv2OM0EYwyAh6iJasg>
    <xmx:N2arZkjCkhTs99h6iVoWedpCGjqyxOdGG120RFwj_M9G9V2QXEbeAHPZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 27418c00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:22 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 19/24] builtin/credential-cache: fix trivial leaks
Message-ID: <788f0bee7bb332e32c305a41a809e82289829e5a.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pKIQvXZIbmuFdfvp"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--pKIQvXZIbmuFdfvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are two trivial leaks in git-credential-cache(1):

  - We leak the child process in `spawn_daemon()`. As we do not call
    `finish_command()` and instead let the created process daemonize, we
    have to clear the process manually.

  - We do not free the computed socket path in case it wasn't given via
    `--socket=3D`.

Plug both of these memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential-cache.c  | 9 +++++++--
 t/t0301-credential-cache.sh | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 3db8df70a9..aaf2f8438b 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -88,6 +88,8 @@ static void spawn_daemon(const char *socket)
 		die_errno("unable to read result code from cache daemon");
 	if (r !=3D 3 || memcmp(buf, "ok\n", 3))
 		die("cache daemon did not start: %.*s", r, buf);
+
+	child_process_clear(&daemon);
 	close(daemon.out);
 }
=20
@@ -137,7 +139,8 @@ static void announce_capabilities(void)
=20
 int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 {
-	char *socket_path =3D NULL;
+	const char *socket_path_arg =3D NULL;
+	char *socket_path;
 	int timeout =3D 900;
 	const char *op;
 	const char * const usage[] =3D {
@@ -147,7 +150,7 @@ int cmd_credential_cache(int argc, const char **argv, c=
onst char *prefix)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "timeout", &timeout,
 			    "number of seconds to cache credentials"),
-		OPT_STRING(0, "socket", &socket_path, "path",
+		OPT_STRING(0, "socket", &socket_path_arg, "path",
 			   "path of cache-daemon socket"),
 		OPT_END()
 	};
@@ -160,6 +163,7 @@ int cmd_credential_cache(int argc, const char **argv, c=
onst char *prefix)
 	if (!have_unix_sockets())
 		die(_("credential-cache unavailable; no unix socket support"));
=20
+	socket_path =3D xstrdup_or_null(socket_path_arg);
 	if (!socket_path)
 		socket_path =3D get_socket_path();
 	if (!socket_path)
@@ -176,6 +180,7 @@ int cmd_credential_cache(int argc, const char **argv, c=
onst char *prefix)
 	else
 		; /* ignore unknown operation */
=20
+	free(socket_path);
 	return 0;
 }
=20
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index c10e35905e..5d5b64205f 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'credential-cache tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
--=20
2.46.0.dirty


--pKIQvXZIbmuFdfvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZjMACgkQVbJhu7ck
PpS9Dg/+MCLGp1l6YMiZkG5ptlbDRlEmnafiMs59zfVe2s3oWAiEwgRqIooj9jTo
t1eI3KL1SAt6I23YEST+q+GiJRz5dKrALc9gWK9kxxGPu0t5+ZEq8LNIJ8iY0cKJ
eBn67+xZqLCOxdu+NNLMIAHuGhtTNed3G/387Yz3jomz8IqeibMlijs5Iy2vCbcK
p2YqWRY4PnHQKlZPs2AN9s7dMITrYm+KXYnLkjyhH5IE4UNjBBAmioZLhQ2gk0VR
5FvCsyAw60CSRY6VL5oWaDq86mBDqyPyCWXZ8ioDW1h8Wn/1JYCUGKMe7EIXFFPX
cVq7RXaLTpwe5t0xcOaceGIZsXFbDtixtrDTFEyVVyFoFsqCBgL2TdvLqCdaz1Lq
ccGTSAo/28SAdXM5nGp1EW+zKTmTqjDyyuPzyNkHvrzdYvaauQSVSsrQfkKRklc/
wjkaH6nDyiiTMvcI+Ych9XM32ggUSHNzCnKsvbrrSD+70zS7XBziTvVtfFoGcrcW
+r4wYXLrcdkjEeP4yPyhWVDs/+Cz/cYIm/STWhOBdCBLN8oYy51OuNkYgbnGBy/S
H7xhhvjgEq3JBTlmF7ibTrY2QYxVVBNRMS2RJnUbE4LqfglqXbUFzOQbRGcjlrF4
UiohXpcB9wq8PlLA/nJNCiS8Wvy8rxYdkNoB+jm/Av/U1qHletg=
=a6xf
-----END PGP SIGNATURE-----

--pKIQvXZIbmuFdfvp--
