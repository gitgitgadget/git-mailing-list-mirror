Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7A2571BA
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306796; cv=none; b=Hb8sYwJAlyagMl3rz40FSH8EPWWHEe3VeoGjRTCedRRaQoqI+g1wM+BWJfZqNTR1mTveZ8WryjbDVGRoUDAaTYRD5RdYqtwUTkkLC8Gb4yQVgnEQ9GTpXuoqvXaj7K8WVxLcexT5poe7vx8UlNm2Du9+9zun4qlMWH86PiwhyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306796; c=relaxed/simple;
	bh=JO8TXncT41txCxp97kKOQICjspuooQEH1y7V4DrpJ6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr6mFS4JbhqRXl14A7u/7g49FqRNFVHJnPSVVZpeI4e9yqGaxcR6bhK1f1ir1FcTtcIEhJdnGohYGRrP0kKjC216fqmmvBUC4xSSZTBcrdJL7W5ZTIiAMSKqlhn/mhMms8fWL5bxAqj+ME/daq10/ZogXnUKm6b1EmOoKj8zguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nsScCVp6; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nsScCVp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1751306792; x=1751565992;
	bh=JO8TXncT41txCxp97kKOQICjspuooQEH1y7V4DrpJ6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nsScCVp6vcVHDuUsYu3xwRNIcp4qXFj2Mf1WKsS5CFkKthCrdzHv3Gx9rX27oIlAo
	 vm7J6pKogfghbe7uVxHMKFT7E3prRzfXe5BX4P0Y2hxs5Vyl/bDpiJhEPo+XacUp11
	 xgsw7Z9X+1bQgIwIH87OjL6dRVLFBkKORQNqF3z6g0Aq2GnNc6+tNpfGD8R/11+j0m
	 Fy48wIQpNA58Z4boiaiY11BNSpzO6vKKBAYi8m8R0q9qhMizNu+x0loo9M+KeV0H5J
	 lPM6vb8JgwPW5sdE4GN/RT6uA4v8r9CvNZgLdJ9/GR3P29t0q9dD9qfjDcbHe2Mqj1
	 i3p6wjbTvI1ew==
Date: Mon, 30 Jun 2025 18:06:28 +0000
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/5] docs: link OpenSSL's verify(1) manual page to know about -CAfile and -CApath options
Message-ID: <20250630180511.499-2-gargaditya08@proton.me>
In-Reply-To: <20250630180511.499-1-gargaditya08@proton.me>
References: <20250630180511.499-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 98d66d9fc51f7504959dd3f758170c93d5678c8b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Aditya Garg <gargaditya08@live.com>

The description of `--smtp-ssl-cert-path` in the git-send-email documentati=
on
mentions consulting OpenSSL's verify(1) manual page for details about the
`-CAfile` and `-CApath` options. However, the way it was written was quite
confusing, and it didn't mention that OpenSSL's verify(1) is the manual pag=
e
to refer to.

Fix this by slightly rewording the description and also add a link to the
OpenSSL verify(1) manual page.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 7bd09c254b..4208bac44c 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -280,12 +280,14 @@ must be used for each option.
 =09Path to a store of trusted CA certificates for SMTP SSL/TLS
 =09certificate validation (either a directory that has been processed
 =09by `c_rehash`, or a single file containing one or more PEM format
-=09certificates concatenated together: see verify(1) -CAfile and
-=09-CApath for more information on these). Set it to an empty string
-=09to disable certificate verification. Defaults to the value of the
-=09`sendemail.smtpSSLCertPath` configuration variable, if set, or the
-=09backing SSL library's compiled-in default otherwise (which should
-=09be the best choice on most platforms).
+=09certificates concatenated together: see the description of the
+=09`-CAfile` _<file>_ and the `-CApath` _<dir>_ options of
+=09https://docs.openssl.org/master/man1/openssl-verify/
+=09[OpenSSL's verify(1) manual page] for more information on these).
+=09Set it to an empty string to disable certificate verification.
+=09Defaults to the value of the `sendemail.smtpSSLCertPath` configuration
+=09variable, if set, or the backing SSL library's compiled-in default
+=09otherwise (which should be the best choice on most platforms).
=20
 --smtp-user=3D<user>::
 =09Username for SMTP-AUTH. Default is the value of `sendemail.smtpUser`;
--=20
2.50.0.windows.1


