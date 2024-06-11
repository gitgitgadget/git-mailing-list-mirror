Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575317624A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097691; cv=none; b=hWU6SMTmSleLxNqFd6/qImX71PXhfGp9U6quoXra1g8UQcJeuFveUvgffyxnUqp4DuqiTgqZ9L7BzcqQLb4eRKCYXug27vnGZAuYWM35eX3+KPMmHJbe+iBEjM9aaqBrotFdg2+SMWcDEoNbbBAQ0j+x56Imc1/kIzC9vuqkJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097691; c=relaxed/simple;
	bh=42PFJ5XYb9pgxXZiMSYNppbTzz+OH1S2uOItdaTL+oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF6D/5AttU4KX4JVsv7O30IdzwDBH5h6LE5Ij63FlLLhCAwVQPrQbsGtmorus2Z+cxWiz6zZHooFRuYe2zkvYY1yqaPIvB3s862dL2N4YhSSYsLgvH2my1jPzvb/O1ej5w4lW8GaFfxAdi+76J2hrMPOwIZOiejRaKQhsv1CGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gBorolxe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cASYCwQ1; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gBorolxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cASYCwQ1"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 303A61800071;
	Tue, 11 Jun 2024 05:21:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 05:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097688; x=1718184088; bh=OWRU9oorAR
	IsxgRD52xj1PWgWGkeurj/62G0VStNljk=; b=gBorolxexrCbFDh0H603CQI8Ld
	+t7DfgTAHG/ySx4VFpkvlgI6ubSV2Ye07CfCkVTg3MAVQbFvM6mg+kzW/YKGkLWu
	l9mQbVzaEexToHgDeeTpitYOsPzQGshCu7+WVpmGIwJCoXpLZPCbSF0JwpYmDnPG
	sa7E29bgG4Vo2X26LKYPrEfhJWVkQXZf+y8SDeaK6NiT3UO9hwXGTqbTskb3mPrJ
	QpfW0XctYTTZdRgt2bLqNMEqFPWzKjzXcR4Zn33sivHBdccWvV7eFlRxYfhXnrR9
	KS8u7Al+1E2XjImIYqtUnmfCRpXUJYiTs66Lh6Ak4YuDDVmjbUuQ1/9UqbjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097688; x=1718184088; bh=OWRU9oorARIsxgRD52xj1PWgWGke
	urj/62G0VStNljk=; b=cASYCwQ1iHHMsT+keO6k942/w3NPpVRaucb518GpOhEI
	rlxCOU4m5eSTkqo8SkPf70cqMpNI+hF7jIH9PdoplsiT1FtCoIQpgzpfSuoUikv5
	nYzN0J6ANiFSvj0DWm9hek/vyOLVJbrWevSKjd81bO5o4rd66Vjx+bRlK6Y042FF
	01R8RAbccqq+WULVJIYSTp37eXScjNTvZtAOAUsCtnGaARli2k9Kl2U4xMW+YNfw
	mTQbhMlmowM9hVja5bWIXdGJuORWqr3TL/FwebmrjmIGtioqt1gbKcXQ3RRWLm6l
	lcPB0syuUU1sdA1KLwWbDIJk8LGQTExeme4Bu3jeag==
X-ME-Sender: <xms:GBdoZm0SNhQEfCvfiwqTmvOuoUONPQHtudxcUU6cQVR1fcDSbi350w>
    <xme:GBdoZpHiBfoD7TqDiMABpVUBZW82QlPhzhTFgX-MUZipo0Ro3KB475cFi76hkaJE9
    GY7iZVXL8JJG29PaQ>
X-ME-Received: <xmr:GBdoZu4VHFELZ1GCZLsWtQfgREYoz5WO642RPFRy5YpsDdggCITY0p64dI4W42xTGneTvZfAfA-8IlbMkXDeh5iOK573MkqyKPUjIpGPutRdpppqx6mR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GBdoZn2W9KTgxk1R18CFAg2CFeJMyu-Vj6sZV7oHG7vCdK1J35TjrQ>
    <xmx:GBdoZpEl2FjilDaWE7Z818_QxJWXAVY8t2JIEZ69a93tB_TvU_02JA>
    <xmx:GBdoZg_hWuYnosHXbq7IZ6mvbknlwlNsGY5LciWnmnCgVJWAIGlQmg>
    <xmx:GBdoZuneVqnMgcov-nIbwURGAMmuFC3ZApsOkVzvDNG2kpcfW-lUZA>
    <xmx:GBdoZpC5UuFuje39go8emyvmsUU-QpVZ9RyHmsSzEbxFPe-EMLyzmggK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:21:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c9346034 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:21:18 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:21:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 28/29] builtin/blame: fix leaking prefixed paths
Message-ID: <c1291025fadceed5a92d9c8f1d611e26d9b15d2b.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9A6RkWPPzIFe5fNJ"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--9A6RkWPPzIFe5fNJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `cmd_blame()` we compute prefixed paths by calling `add_prefix()`,
which itself calls `prefix_path()`. While `prefix_path()` returns an
allocated string, `add_prefix()` pretends to return a constant string.
Consequently, this path never gets freed.

Fix the return type to be `char *` and free the path to plug the memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c               | 5 +++--
 t/t6130-pathspec-noglob.sh    | 2 ++
 t/t7010-setup.sh              | 1 +
 t/t8003-blame-corner-cases.sh | 1 +
 t/t8008-blame-formats.sh      | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e09ff0155a..17694410ed 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -687,7 +687,7 @@ static unsigned parse_score(const char *arg)
 	return score;
 }
=20
-static const char *add_prefix(const char *prefix, const char *path)
+static char *add_prefix(const char *prefix, const char *path)
 {
 	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
@@ -865,7 +865,7 @@ static void build_ignorelist(struct blame_scoreboard *s=
b,
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	const char *path;
+	char *path =3D NULL;
 	struct blame_scoreboard sb;
 	struct blame_origin *o;
 	struct blame_entry *ent =3D NULL;
@@ -1226,6 +1226,7 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 cleanup:
+	free(path);
 	cleanup_scoreboard(&sb);
 	release_revisions(&revs);
 	return 0;
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index ba7902c9cd..82de25d549 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test globbing (and noglob) of pathspec limiting'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'create commits with glob characters' '
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index 520f96d09f..d9add2162e 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'setup taking and sanitizing funny paths'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 731265541a..6288352f57 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -4,6 +4,7 @@ test_description=3D'git blame corner cases'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 pick_fc=3D's/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index ae4b579d24..fb5d225a67 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'blame output in various formats on a simple case'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.2.436.gcd77e87115.dirty


--9A6RkWPPzIFe5fNJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFxQACgkQVbJhu7ck
PpTonA//aHHdTdXLAh4ZT1hqHwxCrQ/IUuucgFv8Su+Mdbfpnln7XFkchcsAyyvK
6zB8DGzpwByRnB2JLF/teLKOkE9791+CNuUKhLZ6++vee5+tLSqJkE8WqvVR/q7l
fuEjtrYcrmV/7NxZ8MbgDZV6P+HV+EGTh7EX3q6xwRjg2dQvivjwX7csuHhHR6wS
24VJjTv9t1ZN/oC0NlNcOwZEYXoQ8BJ04ZEyBQrB8OHr3FIvvzIo/uc2AveuZZ0p
t+C4ZQK9q8GRlqQbNNBYKtzcGHqCAhCa5nDTzktwGb+a+i4crXO7dMPJaxU7/GIN
/Eo0Jndl22LfslZJpi9aBDXvotA9VE2W/8KX4i97UX7sjuwY/CorP5akZ3Ri7vpb
xqstZ4/sSbAyJy3ckTFMQWl0mkTcaWiDJTvlxJXYJoVip2wGQvimz2EfsEwK1gG9
FEcem7la2qWzTX9fRzUhohIyCA3emx6BB6X3aE9kW++O8uM0olHKPneLDqq/oYWT
0WMGHn0FSSgVf3qfwUQcORIDEimXg2uFsVeY6k0O9CjiyVV8/joHEniwBr6OlwH4
RxKWtSPhATrlZiAIkl5r/3y754AQl0TvbGzifzd9ji3ddPLIoFIiUXRB6PwII50o
44BZwPi3Lg/bBIqEsrU/xz7OvohQp3k1cpeCmBZE7QJAi+ZIFEo=
=pcGe
-----END PGP SIGNATURE-----

--9A6RkWPPzIFe5fNJ--
