Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119612F391
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762647; cv=none; b=WahAA9BIC+iIWBkKZoEYrNCKHwokEyugexQ/z53/MvEm8ZefRDRf8SG9APBE+ZHhKGALQVVpt1VH8M1UyizT/4mDMdENsNDDTmijWEwTh1MXNR6ssn9yWnjmSHRua9xR5QENA3826BQy5s26dhRe9FxXlS/NbbGtyoiIgsnYldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762647; c=relaxed/simple;
	bh=ILJK0iUp8S4HQF3M/NFtNzUeEFAyrKhCPmZuvZVtP6c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSKmjLrYSms616JQbrd9PG4yOrIS2HirsT8SBpbFUSd3MrnYAk64LP/gZ1Z02/pQmK4MGBVjz9vOfE9GO27Ld4ZECyD5AoNdz9FaAaXDY7gYrpqAR+DZ3OSzeMElWQk58jlJ1IiDbC2O+yRdDWMyIOvU5LdIYrkHeGoVHWjwq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KTvX9CeC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOTveY1s; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KTvX9CeC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOTveY1s"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 47B0C1800110;
	Fri,  3 May 2024 14:57:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 03 May 2024 14:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714762643; x=1714849043; bh=6yW1R8/UE/
	+FnJRxnVZNHhoLB2jO9wYZd+H7f5np1t8=; b=KTvX9CeC4qu3sbCLUSVNWTYhwT
	tQU9S9Fs0MPznMcW0QSDbCqYY7I4z8cuxj6Uv101LiYWi5Wcs641FlBhTD72uYPV
	iG35b40gQKch5Ge9umZfz57xZiDWrPKFdd8sXVsGJJsZq5CaIsDP4zsAdnKWJA/o
	5eFQaJ9DZKzfjeQW6F2dssSmNg73zkU2ljJLQrD2g8SKWzXAlk0G8UMmEhqONd5b
	E9xC73/xPRTu3RvqqsKBLtDaJFR0OBALkbcwXz1mWF+3CRMGZRMDexXs9h3qK397
	xi4WTfzB3eTw1HVBEjMvBoKDH0y1skHBxLjraLBwwdQfFFLD7IRxCUiMTUTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714762643; x=1714849043; bh=6yW1R8/UE/+FnJRxnVZNHhoLB2jO
	9wYZd+H7f5np1t8=; b=KOTveY1svquv2JcknbLE6LhCyQrJ1+T/o3IbesCOkajE
	2QFmqFRFQyWxh8C8+ZyX/0oAeaP6pslYUGIftPKtVlXb/K9HhXq/+irrAqxdos9S
	HkADneF9VG7xLob3deaTlpooSUvmhr3Vm9x0FZqDMmJNgtkhxuHc9XC0jAvDMPb+
	sTemgoTNU10N9T6BY+0HmtA/yaLDXlTN81cWy4fZZcjlGiXHVkr5Uljjs0ZFZDBj
	dTBWRvSBhNOi6HQxZYDbcZYjuAM/NdjKsQm12FRtznmqItIVJzGazphY7+0I4B/w
	p9Gb3oULFD1Y4hp/aic1y4D8lU2oLwVDXFuHJYKUYw==
X-ME-Sender: <xms:kzM1ZqODKWKlTg2GkQg-Yy14Ld0V8qnK0b5OUX9P-bghsG-AtxZf-w>
    <xme:kzM1Zo-aKxTVmGmqhbdmHnbYDWWvRLtu9qOSiHud8AL_NTVIiB8zZ4FQTU5aqX5_J
    zgSzIoJEOCWEFLHwg>
X-ME-Received: <xmr:kzM1ZhShoTjhS4x3cb8N9b2lj2yVObjnTlZZagvShT6umdZDbdLBJcf6EXsy5ZVCjVxP-pKfdCIn5YuA4PY9KQgH61Eugk5mHcGXpZFXonrnkFga>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjeejtdeigfegkefgjeehveevjeejveeuvddtieekffevleeglefhgffgjeejfeef
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kzM1Zqv53G5IiwxGFq6Ym-6RHmowuO2z9QU4GsVYLSA5_g8XyZteBg>
    <xmx:kzM1Zie0TWywTM7XG0WGB-YQU5vqOhOVTxmYPgJlY5H1o2CLq3uP4A>
    <xmx:kzM1Zu1ay1Nf8V0vE-UvFKy_PoMRXZzX7gD9PT7OzVLlguRjeAxh3Q>
    <xmx:kzM1Zm82YCw-MnUUmXlaBiBvOcn0jMZu5cjPgDWZOl6sfNPQkeCQsw>
    <xmx:kzM1ZqQX27CIgjJIPuIub0LXBd-9nWeWShqJfLjtsJxWX2x7MvjCf591>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 14:57:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f1302304 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 18:56:52 +0000 (UTC)
Date: Fri, 3 May 2024 20:57:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <ZjUzjhN78lqYtXqT@ncase>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
 <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>
 <ZjUxY7kqgy-iLIzG@ncase>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N23shxxlq9FOOF7B"
Content-Disposition: inline
In-Reply-To: <ZjUxY7kqgy-iLIzG@ncase>


--N23shxxlq9FOOF7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 08:48:03PM +0200, Patrick Steinhardt wrote:
> On Fri, May 03, 2024 at 01:42:32PM -0500, Justin Tobler wrote:
> > On 24/04/12 06:43AM, Patrick Steinhardt wrote:
> > > Hi,
> > >=20
> > > here's the (hopefully last) version of my patch series that introduces
> > > Git/JGit compatibility tests for the reftable format. Only a single
> > > commit changed, where I fixed two typos and added a missing signoff.
> >=20
> > With 35e293e6 (Merge branch 'ps/ci-test-with-jgit' into next,
> > 2024-05-01), I've noticed that a subset of the `test:linux` GitLab CI
> > jobs have started failing on next.
> >=20
> > https://gitlab.com/gitlab-org/git/-/pipelines/1277877090
> >=20
> > I'll take a look.
>=20
> Are you sure it's related to this merge? All failures are on
> "ubuntu:latest", and the complaints are about the "python2" package
> being missing. Given the recent release of Ubuntu 24.04, maybe the root
> cause is that "python2" does not exist there anymore?
>=20
> Patrick

Maybe we should do something like below patch. Basically, we start to
acknowledge the fact that Python 2 is end of life and always use Python
3 on ubuntu:latest. We might go even further than that and only use
Python 2 on ubuntu:20.04 and slowly phase out support for it.

diff --git a/ci/lib.sh b/ci/lib.sh
index 473a2d0348..3967a5af85 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -325,11 +325,18 @@ ubuntu-*)
 		break
 	fi
=20
-	PYTHON_PACKAGE=3Dpython2
-	if test "$jobname" =3D linux-gcc
-	then
+	case "$distro" in
+	ubuntu-latest)
 		PYTHON_PACKAGE=3Dpython3
-	fi
+		;;
+	*)
+		PYTHON_PACKAGE=3Dpython2
+		if test "$jobname" =3D linux-gcc
+		then
+			PYTHON_PACKAGE=3Dpython3
+		fi
+		;;
+	esac
 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/$PYTHON_PACKAGE"
=20
 	export GIT_TEST_HTTPD=3Dtrue

Patrick

--N23shxxlq9FOOF7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY1M40ACgkQVbJhu7ck
PpQrCBAApodHw7f0bBcPpucZRfwhpKxb/PlLUdrIonPbaRFhuA8f1w/38e/qDOB0
C1MUUC9CMQy9BTpCZhiE9L37+psRirMq9iT+jx2/K9KIcNzcqJsyV4MRoskeHyUL
OKt/r+ySzNqoCvWjGFhaA2emmQXudNu9YmsNd81SsLiECPxaiGO/BhSbtXTPxkD0
P1gqEZ8AOCJZew9OIcgqV/TWU4dy+r2mjOMqtz2H/IAAD66exEMSKxEqd54NDa0A
tLe2BRVTcElx1WTQCCbDgILdgIm8MsfHLedXnxW8bUEYTQxqYYy/b5KFZNNiaHTQ
G7ZkdNdCQLPdZwAAKF7utt6Dtp/3j1mOG4LXqUKVxCd/ifalYURAKQ1/r3W95GpY
gy5E9aOMWwhB+4CjRYAdRaqA+7nEPj/u+Bjx35Y0swstVcsH7PvpuiWskNxY+aiP
aQI6zkgYTTNKFGjNBZH9Qt1IWUd2eZzlRkQbYJpRCFFzfGKxqJQhf7h+ttZzsqBd
g8AConGkAEMUSBbcTXxoNmV9JQnp31LVn0CjDAT9ReJDn+QsP2QViyS8g4iQPYTx
iUhpXZnKNgxFAezSLFlBC/aXG+3S77o74RNVZolw+asGZyPCbuT6Vcg/1TXRG2RF
kdpxPzqmEuJ6rCTFoI04REjzQEFLgQXnEhkqfDftF40ZZM/I+e4=
=Ugge
-----END PGP SIGNATURE-----

--N23shxxlq9FOOF7B--
