Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEF178378
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996294; cv=none; b=QTajkTT5tLz9ykqXJOxv7Xlw9xl8slfW7v+wRWHx7Q9NYa5nQEq6Vh8i/4FZLEU0tFc6aSjdTyo4sa+AKoc0wJWC4pAujMQ9Ci4TLDEBgy2Hsv986pyZqfWZhTWE1SdsJcIcOlFsJ6jJnjjyGTwTEYee7mw3vVNYuOHnzCY4cbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996294; c=relaxed/simple;
	bh=FGEooeWHeD4NOrWlUr0g6o3q+d/vNwxkkoAl1aT1wcs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxzRB5SNLnbdqFK7vzoOY5f2msYtjF7d/9th6tU3Xg5WZAvawCRtRaY0YMwMSv/P+5MOaU2O8VTp83RipDOCysoEWuy6pwEbQOGgecG1BhLh4/8dRV7WhAIKcyEnW7Cybn1+ryxgdngnsnNkWVRfmF9PvjzflCm9uVj2PL1cXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EEDtMOvT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mOW/2oTh; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EEDtMOvT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mOW/2oTh"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7829C1140205
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:18:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 26 Jul 2024 08:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996291; x=1722082691; bh=6G5HottkRB
	NwQgrTc9kobVD/9Cbq5r8DDIkmuMKDOJ0=; b=EEDtMOvTTl1bFqWyOs9KfS731Q
	lie7EZvLKWU5OOuOql/lMLRxpfxbcDMBWTHevD2sK5pOkB1oSKDbA249vjjy8BZF
	mmWL/uwataM4q7PGwqWKedtXqJsTagyns3UL1UGHwgFhH8C7tqbzgxk5zB0GLMnE
	1okc/t7d20WXjk3LHLoLG8SoQiJi1JnscbVdpsG7od+/vSWTFKcPdVgYTsZ2y7wm
	C6kC8yGhQjJ2tqEBH3rRZgra7Nmm92zxQZKq9ybPCScI2SoVyL1pBLO/g6PB8QW0
	0d6UMiddy/fqyT9esrUzgN2LvjR3tQvqU++1T03IQNQ6eSzYVADibKV9pycg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996291; x=1722082691; bh=6G5HottkRBNwQgrTc9kobVD/9Cbq
	5r8DDIkmuMKDOJ0=; b=mOW/2oTh4fRS2UvMVHM8SuL7n90J577FM6IFZJwRusN5
	X5aNGxV03JOpWKGmzJJ5e+D/V7rug7ROh4HSVEvjgR4D7kufo2d5hQaFxeHMSg8S
	3hMGk9hoCogMBbZmn81sj/1+ljR44c9q3Xyo/5NkmjGZ9oaLgeNCLb5tXk6O0ZFQ
	LZSAMLPJ9VCtxx9m6enwKCJxJnk1RXjgBsjPo8b7dQ+J/UXvAo9HkCBFjGc8em2c
	DVgyu20a28Qf+sEMcKk9eqes5yz1vmz4PW31dmr+QUDFQ2yjAgCzLyq3sAbrnTiQ
	SxdCCq/muRo3Knf7GfnLZwEGStskOzwrGm9OdN0HcA==
X-ME-Sender: <xms:A5SjZj-8GnD_vRbO1weqqaJuBY8PlVeKiq4PyEUZMI6DAf4MAS2dRA>
    <xme:A5SjZvvcjDTNsRjrnDzPrFoLbLIFWNRomH3Esw9j5r60LJmqPe9ziO1NiyAxl_45S
    b0vyIm4BcwR4OUrDQ>
X-ME-Received: <xmr:A5SjZhDxR0c2Nulp3nJPS2egQCgD7x-zR8yBDKNl9pEaj3P5I8SzfDYtSfK7tISvGMTQxgoiy9-Xadfs9RAIijJF7EgdobBm0KEmtqQv9y1vKi-O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:A5SjZvdv2VsPQTpIFOdU3A4FTz8nV-Ga9JHQKce7E4otwmCb3tXQ3Q>
    <xmx:A5SjZoNaJBwvpzsO4VGzf09SJ1kX8mDffe8RT-TQmzSA8aijBLGiyA>
    <xmx:A5SjZhnYdjAGSFXM-1PDDPWrvAE7AwsitkIkG2p3p8LkNYTXfqqcOg>
    <xmx:A5SjZisKasB84q3qZ5J4exPP58WLTedrJpISvRQzzlZrwYJlDfMJnw>
    <xmx:A5SjZi3jm5aykBEvkAE8DRwYIm1zbium_aEnaW96uqTw32GJOjY8kTzm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:18:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ca5611e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:16:49 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:17:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/23] builtin/credential-cache: fix trivial leaks
Message-ID: <2c7a3694903e54dcfa2eadb3b7fa7828da42f5d3.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CeWK5H/kg7qFOMGx"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--CeWK5H/kg7qFOMGx
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
2.46.0.rc1.dirty


--CeWK5H/kg7qFOMGx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk/MACgkQVbJhu7ck
PpSofxAAh9pron6RfGy9YCexsz87zjhGo5oM3nKSaUj6i7u7RNu1HJzaGlynXgbK
owsSOfLDXteG5cnXkGEO000vJmwo1O4HcHlJm33oDswSH2B4RVW6krAU6Wng/YIM
EiJnOGALngvj0cU5WcuiQoo/qkMEbRRH6AXXhTFuYUJiKTp3dYjnx8SoxUoe6m0E
B1dk1x56imePNUJ7LNL0iG1bCWU5zmtmjQVT/wM6q4fkjzdCyA+1cDe/Z/pBn6Sm
FZ0feEunjsW3867qgckm58UJnbJ2J9RStPQeIXDhD99+jQjzxPPinS4CO4F4i4aQ
k8iJ5HAKtrhIiEBJyildth1HEl5a0swFa2yaUnAk97ZctGzMT78yHaFtylCEZ5X3
9W20LqzKiqt4pDxnwp9ketNIJZycJXahwWFoF5dzVHpetnaJNMJM8sXqvI3oDY41
SsTDdQlhcslbnOs4ZRBv013G1z73hRMlDhB+zPy4EH3lc7gHFISOPljo5T6PA50j
8ATk4ond3QGV1CHew4b9Pnqy0huvA/xDzP7gSCkcJE2cscu+mb1WofToEdAviXtD
/1lRrQQWPHMqwUDdU4JD0uecVtBqRsDQlnC2Cs96cYnjX8Kh5bwvdXHVVF2h3u74
IG3SwfbmqI1XTmz3YkEfEaEfIz6UevixQeiLkJdxB8iG8h4EZPs=
=0I/r
-----END PGP SIGNATURE-----

--CeWK5H/kg7qFOMGx--
