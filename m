Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54056448
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601936; cv=none; b=U/2lOmkfaRh71H7H7GTifoaKbouLayNujo+dem6Y4mKEzG+e+J8uB748ikydAHP8lNHocEvXZD53Tg8P1yuLdraZlxsh0t/1cnQidq+bJ3NOHC5uZZSjxIKnhfserkgrEVnTLtODw5Bno6LQXA31K6kwjN6ts9ma+7shpY6GPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601936; c=relaxed/simple;
	bh=+6w2CA/rUMkIbaLmXq3vRoKGW0xEZXvnqlLUnaDnP14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2ApNHp3d+TAZTQ/u90jwxd9FaY2akmRd5p1ILVcT2Spra/HEN81DN02cSAexyqsYun+BURE5GP0qGpTZQrFWMXKlEI31DyKzD5l9dK7OGrCVOjVw21ez0h6FneaF6B7jOOQZa6hN1JkarawM6/06DZ8T9N4s49przyrjVY0zPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SHShMTU4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pIHqaBnr; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SHShMTU4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pIHqaBnr"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id B4A553200B67;
	Tue, 30 Jan 2024 03:05:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Jan 2024 03:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1706601932; x=1706688332; bh=X6sK2dnJUY5KIv5L/rXlCWC4R/Fh4/hC
	pEgSXJUkR1Q=; b=SHShMTU4bq/3vi6yr8eQLukk7TQRUhysunSik9WulrDolQPU
	AaiUKrwi9/HkUH5neWDMr0KCiUxWcVMCViRYvoTvA18arHn250s3FFhdyQlhHRbn
	xYNrfX12lpE9ytwon+I/MW5C9mMUUPiJHsrF7AADZh7WleEnWa5tCRS0/kQKxQBR
	vsBHZdx6dACQl0ROpKkqKF/EbKWzo9+/UMRbN8brDj3nFaunHzKCSRoMpfkEEkiJ
	sg9ScyndDBOd+1C4/hPZ+60gBwUH7cdlYrsqfeX9ZHeZ4oT949yw2v2ZTQq4So/z
	fDND9O/tTnLN78DfMIMPq0ffXQQzh+PzT+E0HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706601932; x=1706688332; bh=X6sK2dnJUY5KIv5L/rXlCWC4R/Fh4/hCpEg
	SXJUkR1Q=; b=pIHqaBnrIPt8kawP1EPZJHNNghe+GAVU0US5EHqibSyO593eSDX
	cfzSaV5zikg0zk5p8CLQyQZ11KaaKiaIMTD33gDk7cnmiH2vGIID3oxQBOlmnWc/
	/VuerTeyHfcf994kmsTDAD6U3P/Pj/VP2ypQ4L1BBF2ZMNyUB/P8ZufHowBG03GL
	WduONygIukQGtCRjd55qNKjO9h9T4lJBAM87LSORSmELJTs6APCMh4ihuyLhyNZd
	vBYRrMrcg0egsBHs6aVwTGHNdbih8sx+EzNu/c2zJUJsK3TGC03pIwL4aoCdrm4E
	pNlsAok3HH9sbMNqbLLXIzKPZDzRQ8zUNzA==
X-ME-Sender: <xms:y624ZfTHoEpm78twlJZMHglu0vkcwkxFg4iQirTtRIRp91QHpeQNJg>
    <xme:y624ZQx3AG9Uj5WAhclx0NqCofEuP-mS1qAp-QjWFVvNsWIQNg0Cvaa1Ild9X4Co6
    q-SaLuoNa_gOtekBQ>
X-ME-Received: <xmr:y624ZU3Ql8xyDDk_6hKRfOlG2ErM3JQp6qaVjTP0NgrCDEbfAnxZffv6pB7tUcQ-Cpp4XQJrjrzPmIriH92jo5zNRpHccLgs9PaLrNbgN1q5zLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeuueeiieeuueegfeejieejvdehleeffeffvdfghfeutdfgteehvdevhfdufeevteen
    ucffohhmrghinhepphhkshdrihhmpdhhthhtphgurdhshhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zK24ZfBKqJOgxKZXZgSWhMtokS6Ew51thfFb0YJvTezA1j4OCBY-fQ>
    <xmx:zK24ZYhMf4NcDl-BPsELQ3aD1bTuC6yzl3L7hc91iUjXQa-z6O5KGQ>
    <xmx:zK24ZTpiPFp34OkOKKnn-otF-zhhn4RnNvZEPELyvf2gLgxLLLAwvw>
    <xmx:zK24ZUbEQ4-0pGrAr3a4epw1dDx2hcdwpiii3c0S0DefVnyg5xVY4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 03:05:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c85ec642 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 08:02:11 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:05:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 0/2] refs: introduce reftable backend
Message-ID: <cover.1706601199.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0B2437nXFdhrNeqz"
Content-Disposition: inline


--0B2437nXFdhrNeqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

all prequisites for the reftable backend have now been merged or are
about to be merged. This patch series thus introduces the reftable
backend itself.

The patch series is built on top of c5b454771e (The eleventh batch,
2024-01-29). In addition it depends on ps/tests-with-ref-files-backend
at bbd6106967 (t: mark tests regarding git-pack-refs(1) to be backend
specific, 2024-01-29), which is about to be merged to "next".

The patch series is impacted by three in-flight patch series:

  - ps/reftable-compacted-tables-permission-fix, which fixes permissions
    on "tables.list" when compacting so that it correctly honors the
    "core.sharedRepository" setting.

  - jc/reftable-core-fsync, which starts to fsync reftable data to disk.

  - A follow-up to that patch series [1], which starts to fsync
    "tables.list" to disk during compaction.

The patch series does _not_ depend on those series. Instead, I have
added a couple of tests marked with `test_expect_failure` to t0610.
These tests will start to pass once those topics land. As I don't expect
this patch series to land on its first iteration I very much assume that
the in-flight patch series will land before the reftable backend does.

Patrick

[1]: <7bdafc9bd7f53f38a24d69a563615b6ad484e1ba.1706592127.git.ps@pks.im>

Patrick Steinhardt (2):
  refs: introduce reftable backend
  ci: add jobs to test with the reftable backend

 .github/workflows/main.yml                    |    9 +
 .gitlab-ci.yml                                |    9 +
 Documentation/ref-storage-format.txt          |    2 +
 .../technical/repository-version.txt          |    5 +-
 Makefile                                      |    1 +
 ci/lib.sh                                     |    2 +-
 ci/run-build-and-tests.sh                     |    3 +
 contrib/workdir/git-new-workdir               |    2 +-
 path.c                                        |    2 +-
 path.h                                        |    1 +
 refs.c                                        |    1 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 2286 +++++++++++++++++
 repository.h                                  |    5 +-
 t/t0610-reftable-basics.sh                    |  887 +++++++
 t/t0611-reftable-httpd.sh                     |   26 +
 t/test-lib.sh                                 |    2 +
 17 files changed, 3237 insertions(+), 7 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0610-reftable-basics.sh
 create mode 100755 t/t0611-reftable-httpd.sh

--=20
2.43.GIT


--0B2437nXFdhrNeqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW4rcEACgkQVbJhu7ck
PpTGmRAApcMiYAqXVfv7MBjFeU1SCqDeW6gqnfD6TPVrPDBmukrUWU53SrVnA8ed
Leqx4pjwrqIE7wzTGJ3qgYwIth/6KTRP3jmeMx8XHqa6F4U58x8YCIuhEVRgFo56
eyecsNo35A6yCWuvp13VMYUaQh+OgMPomvFdrfv8Aioz6EjUSE619GpSXBvEHeoQ
Ags+1sieGB3SieObp/8QK+aR6t3+zAiYockaunh+LkdySZMtwHDkJGPejsuuqzTu
9sahtL6o+b2fUYiUoZ8IHGN09UEUyukvD9+jXxh3xbVZV1cgxcQtgW6pp3bw6KQf
H/AE/Eflv90gwMqwC0mW1mftk4PP3gaA+UQ5nB9Sq2XSSoNhD/F/yt0ugvdBIWcz
+RjAWrqU9srQ33rP27+iYlDC00caIW8gfRkmFjJWGPLtNamWA+wVwtxiSqHroRCf
oRgWJP8hj65ngzFt/fgzzrGFIoblSRNA6Oe+q3AuS5FYrA3eGaYQ3p8STPaJ7Tj4
tnoVJWeANR4nt1eoEt0gzILeXGTJ+gVPNPm6nXZrxbCgkOLtssNxSzjjyUdk0iyd
qC0GzS+sVKqyJ95+OYdyIR23PfwNT9FVA2NaWAt42hgdeBmHVLYR6SPnZN6+sJCb
isX+BPWBxzNa8vE7b6d70rhPORu8O44818xLLSdNjvlgnP/YgJc=
=Nm0x
-----END PGP SIGNATURE-----

--0B2437nXFdhrNeqz--
