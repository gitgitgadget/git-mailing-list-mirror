Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D455E73
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545008; cv=none; b=PqsyVoWIAoXHq2EZ4rmsrW8zflt79YDHctQsQy8ksrAlI6MqELUThT5Yrn04PGJynqtUgkmM3murqkDc7BfrkaTCcfoFOyjUNcSbknooWn9baIWNVsgOlFnL2tXKhMrqQ2+dU1QK2cPdHg3nTdGTMgcfuylPD9kkkDbB3WyeH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545008; c=relaxed/simple;
	bh=J8V4HvcBqZDxFjWbBNtkk6NN0mXZIa8VxoPVxZQ+C+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/9E6TlXpxNpzcxV+VYgpQW7LV963mbZFJSJyKT2R9wT6aa3TjxOfe3xMZ50k6CXQRWea2n0wchqzRZPJ/X/76FFtRcC3qfy1F79uV5kjGh3suZQxFALX3UbiiCOQZBO6V8nY9HZG+iGgV07o+d6wSEvTnMCPXB3YZKTMORmfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B5/iVDb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCS4XYBs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B5/iVDb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCS4XYBs"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 694BB13800A2;
	Fri, 24 May 2024 06:03:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545005; x=1716631405; bh=7oJ/1C6zJt
	JT3BDyChiQsJverrLgfWiDtVP6NigrE/I=; b=B5/iVDb/Pn69B4odzWlQS87mYI
	AdnUsjq0POtQXalvL3ZMhFsl4yJpaG+Eidb7qNAx3mNIfoL0eC8DvQFAXqyUGtmh
	Aamk38v2JCllTW33D4arRYcbzBDQOomrh1BhLB39Gf+l04kPVO9XxiAlVLi/a7Hy
	e60wt9E/oDT9EepxKGMPayZQpflTxxKjJaL80qT4VfYx1//q25Xy+Nu7+gmxuyvS
	Sf1kdwPkIuescSL9KRFEH/VgvF09Es/2hIEraf2wl4g9pNKboZPJXcM3PrACLOUg
	EiZbBBXx6ETsYU2hs8Y3YIQJVfyr0oPEiDiLJqSJXJ5LpdhwmFF69B+cuRyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545005; x=1716631405; bh=7oJ/1C6zJtJT3BDyChiQsJverrLg
	fWiDtVP6NigrE/I=; b=MCS4XYBsdYi0PtvL2Nut9j+V+/MDa0ZUV0fB3HV7azEi
	70HnDonwa/C3e4C8smT7F41m67YV2Ddw+2fd8eOplKc7eAXTk8ikbmA654zTl0Ao
	CH6ifa1OQRPjAbUT0uD6yEpdgEYdBYIhSgcoKpFtmxe/XFzy4Nfn2dch/glSQIeN
	5Htl+X1EA/MK36XiNGw8La2APKzyRW8pkLSQ8161qlR87Y8vkJFKNaZxPff1Gz5U
	wUbt4DSgoHuDiSCQc7AuxkVuj8Lcz+8nrnJ0YnmRMmvlFQvp5kGrdSTjkwSMNsrr
	PUPiEWEvX0LiVqC0Qlrw3SZmjKbtn9XoVYN3cV1oHQ==
X-ME-Sender: <xms:7WVQZgzQkCU-VMPyArLVK9pmL_enrEN106cB86PewH4ngxazxeqMEw>
    <xme:7WVQZkR5mZSIHWX450I59S5-DUcYKaqJe-5eW9kzEJ6Me9ksJk9n8L60-3WCyKedR
    Q3qdVJ_m9xFdavWFw>
X-ME-Received: <xmr:7WVQZiUSXOL6LGo6evLIFekhJYRqLg_EnSgGsjHGQv4SMiIK-AP80rLi6sKH9CE-HCACU6o7629lWgdZLDuXfNeQ-ttPb4ptMCcW4cQqzbPX6bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueeulefhhfeivdegffdvgfelheeljeettdeivedvtdduudejvdffheehteffveeh
    necuffhomhgrihhnpehinhhsthgrlhhlqdguvghpvghnuggvnhgtihgvshdrshhhnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:7WVQZuhjgC7hwQghs5icVOyU_HooxnAHevq28mGYNTj2OGEZC5OkEw>
    <xmx:7WVQZiC-kKyRTtIV6brdsC-UFpaVDYYqD9rQ5MEOjp64vnmdSiduRQ>
    <xmx:7WVQZvJP2ArcA5V_VBUUePUrMRcezn5kNw0GA0xRg42mTYVzhc4pYw>
    <xmx:7WVQZpAHo_cVvnI7BMp4_xTOzolBRo9b7gL4lhdYeWUsnj5OR86cNA>
    <xmx:7WVQZtMBLIFWqAtVPjKIDVRvKkF7Ms3O61IZrD4uhHzws-q-BQNrsXtk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5b52cedc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:14 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/21] ci: add missing dependency for TTY prereq
Message-ID: <857b8b14ce519e3c473f1808da7daca95ebff8ea.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VJGNB9tL11QNFB1l"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--VJGNB9tL11QNFB1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In "t/lib-terminal.sh", we declare a lazy prerequisite for tests that
require a TTY. The prerequisite uses a Perl script to figure out whether
we do have a usable TTY or not and thus implicitly depends on the PERL
prerequisite, as well. Furthermore though, the script requires another
dependency that is easy to miss, namely on the IO::Pty module. If that
module is not installed, then the script will exit early due to an
reason unrelated to missing TTYs.

This easily leads to missing test coverage. But most importantly, our CI
systems are missing this dependency and thus don't execute those tests
at all. Fix this.
---
 ci/install-dependencies.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2e7688ae8b..6ec0f85972 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -27,7 +27,7 @@ alpine-*)
 	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev ge=
ttext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-=
dbd_sqlite3 \
-		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
+		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*)
 	dnf -yq update >/dev/null &&
@@ -42,7 +42,7 @@ ubuntu-*)
 		language-pack-is libsvn-perl apache2 cvs cvsps git gnupg subversion \
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl=
 \
-		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sq=
lite3-perl libcgi-pm-perl \
+		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl=
-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
=20
 	mkdir --parents "$CUSTOM_PATH"
--=20
2.45.1.216.g4365c6fcf9.dirty


--VJGNB9tL11QNFB1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZeIACgkQVbJhu7ck
PpRCLA//QQUIdyON9JzFKhIJVpHiQfpnzAgMkby7JLEeOXOOpcfneB0f3871IqmT
PnvKXlq3KL7mPdx3k/YieLne4Qstk8eyubcN5RajuCwpOxKmSArm0oOXo/3CuYR3
n1okd21QQj7l8IJKt7uvxcZXnVi0RrXKCUNdAdZkpQQKwoWvASW6IesiYB3xkgBt
fgxRbaI/2dEL6HAF9qLjDxBt6tD7HgasJERYu68kAYiJ05MeW7eC1Ob2LlYbd3X6
d2kjD0C2+dXsFNkbBeYocVrIGWrcVgk4SGYQXC51QGndm3YfrqyZaOn0573R2sHx
4aeomcz5y4wQj7aUznujUWDhWWaProNCDuhT8zjXITt7Eamos9fobSDCoi/OsWX4
qlAcrAlE1wKAtG84rud/0KtxeB9UoO82yXEdEgJFTq6YCZQzdlv24irnPjszLs0/
eEVLV0ut0rmlO1ndLnUsyQnhKJIcXRhjJYPHA+NQNhtbZpTd46iZjdkz0Ja+0d1D
rWe7dDr8aw9v8fS+e4u/xFHkrmY2/BeN0xiNThFL80XFRFKYFSzkDesVIJ6NZ0j2
7fPN1iP/AiOiqiW2Z15suc+vDEVstGKD/dcQvx4aFujNA/OWifEJmJ8ZsKC+MUVb
ykNYDY0fx0kKaZhWRJ3WsZCw44Va5F6A/8Fr7pyE3cfCHX6wzX4=
=tfJO
-----END PGP SIGNATURE-----

--VJGNB9tL11QNFB1l--
