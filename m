Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB6132129
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073528; cv=none; b=DKPa2/rekRnf2x2fnPbRuzEM6xkZetG6kIjV6K+q+vxSD15T0QPQ3SHo/jXLFzJMQYWvjji7j0+3nrhgiw+ARaz7kLojiutgoFRdaUVmCuvfgKlBGwp7phc5xkEY5VQ03rwK+I9knLbZLBf06dl2iD5SSC3CkHh9CKAhTfbW/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073528; c=relaxed/simple;
	bh=qYCJYV+8zxZwI+GnMsqoX2sXB8KbhRcrhoxS3gBDPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv0IGOb/oppS+7SW4daerD70THJPelht42eiXAtryNHH2u1yxbKGylJC+W4Kz3Xwuuv2WdvoHNVXSiP0h/PZYOsAQIVk2KyOgpOwXD6jUhhoXM2KOo/Jc98nSOskIB7VJjPNIFlU22kq++y92PG2uRGvtBDgTT/ZqO6bJkyvsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AyPg69f3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnMEleBs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AyPg69f3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnMEleBs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8972B13800DE;
	Thu, 30 May 2024 08:52:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073526; x=1717159926; bh=qYCJYV+8zx
	ZwI+GnMsqoX2sXB8KbhRcrhoxS3gBDPpw=; b=AyPg69f3oKiDaD/Ida/vCT4juU
	T72EeDVI4CaEj1GtVupsbtTTwszuB4L8sXV5RH2vTobZLe377dkktaxKpzjCLnrO
	bbpqEVVVo3nGKzC0ucY2dVvo0IWHFsmSekbQomcX3Tt9Fk1AxRJu9LFa0BHxSFQT
	1rTAmBUBvVwNCHPACyeAGZxtVSqnsL8QIo9p8MqtsqV9y4qbLkLvth+7u8b4Yhai
	D+gHist9YtjrnsmNVJiqTIasFXZZEm+V9R8hrBo208/rL7uk7xZUUF4WfOgw7W9F
	FPZqEooFtAetZY9du7NxsWCuGcNQrm9WhmSe7YktMr2A8x7n6+okkJechERA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073526; x=1717159926; bh=qYCJYV+8zxZwI+GnMsqoX2sXB8Kb
	hRcrhoxS3gBDPpw=; b=YnMEleBsj8OWFGdjx+J2RZMjTsrPJhErqRK8VIfjGmuc
	A2+xQE2Fqygl+3xnp2btai1zylRW9e7wVM4h0SMK5Y0OVs0fe5GP+fIXUi894r2m
	owUeZs6qWkNyn+L6Uqrwki+HxK9mBoEatRQDFqwr3zW4CFobbz9iXEIW4k0pBT3z
	Gx8/Wv7FEvS3u5aU3ICXQjvnW2is9Nc59apVyo9l7hSSLfMt9mSX7nW9Qf9FPs6Z
	fDr+dqE+gIg34ll8uuVnjMvHTNiVfTHfsJpqHGcZocFvw5VBNpjGKx5kv/KJsgtT
	wZE6lLhrU5v/U6bhSaCNvVLf58CaZMPINuRk+QbGpw==
X-ME-Sender: <xms:dnZYZoI730qLP5qszdd4zc2v98ifWd3x4TO42--qoAlUmJZz_8fOvw>
    <xme:dnZYZoI-UVDha1ldzmAlei8gAfBt_mAGUvFDtj338hdMYfQk75jucahIURY1t-gXT
    bnts6C93nwKqlustQ>
X-ME-Received: <xmr:dnZYZovB-IOUazLrKFUozbVzSo6SWA4Abu0DT-h6T-oU0_0_1laoKDzn-30nFWDfFTzh3VHPjsfaE6bAarbEOu_n3-hM0ekiyNh2qxicVf-CBxueFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtkeefgeeiiedugfdvgeeffffgtdehge
    efieetffekleetgeffvdfhveejudejtdenucffohhmrghinhepmhgrkhdruggvvhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:dnZYZla21OnoE_hBKFAAfs5TrJ41QiMOEcH0zsV2uY7bMXvN7z0qsg>
    <xmx:dnZYZvaq7pJ-YD--7axwIqdpM-EFBYSpHzzhivlxhiFRgKg0_9LjGQ>
    <xmx:dnZYZhBr5mxHb_Gu7tltnHUl2qQfK-OCc8vX9UbpcmdM-haiB2h8AA>
    <xmx:dnZYZlaHqWdAjVQpDlBb1cZbWnk1yQE4JVNxz-FdWxxQYH791xtOHg>
    <xmx:dnZYZrEiK3XsC4XIpDMAmWM8sFw0JM8UKADy5-MgKSvCpfJsIOregH2n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:52:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df18a44c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:49 +0000 (UTC)
Date: Thu, 30 May 2024 14:52:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/19] config.mak.dev: enable `-Wwrite-strings` warning
Message-ID: <9b9d57ae8432bc0f638bc784b23526d5a26627a5.1717073347.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yUYs18z1YDJz7FA0"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--yUYs18z1YDJz7FA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Writing to string constants is undefined behaviour and must be avoided
in C. Even so, the compiler does not help us with this by default
because those constants are not in fact marked as `const`. This makes it
rather easy to accidentally assign a constant to a non-const variable or
field and then later on try to either free it or write to it.

Enable `-Wwrite-strings` to catch such mistakes. With this warning
enabled, the type of string constants is changed to `const char[]` and
will thus cause compiler warnings when being assigned to non-const
fields and variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 981304727c..1ce4c70613 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -37,6 +37,7 @@ DEVELOPER_CFLAGS +=3D -Wpointer-arith
 DEVELOPER_CFLAGS +=3D -Wstrict-prototypes
 DEVELOPER_CFLAGS +=3D -Wunused
 DEVELOPER_CFLAGS +=3D -Wvla
+DEVELOPER_CFLAGS +=3D -Wwrite-strings
 DEVELOPER_CFLAGS +=3D -fno-common
=20
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
--=20
2.45.1.313.g3a57aa566a.dirty


--yUYs18z1YDJz7FA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdnIACgkQVbJhu7ck
PpSb7w/9GgGQR2FPhguJCB/sTM6ozYt0yu5OzmHjbHhOf7qHhRAdCK49Uf8wea9y
dCwOTrrLS+hMSzNKtActSiIGfvZcLnqkr10rJF3Zkc3DRD2TFjv2dhM5Qamnfqfd
L6sIDkpXuTi41VmUnxfBxpUBdaM7RzZWlCobV7jaws8t/hr3/ieeYLrnUcvDchlw
zBCenrBaIr8HtswhN/GHXWWO2IwZzBg2F41sGV+Z6YTof+Qx/ZSXuBtXERe4PIW7
AWC4nE9JeX7CDFBwkJJO7tHkYmtePNbV7xF/OsboYce4H0MAoSNNxWQYXWsK+s/h
mwMe0e5jAWHDccHenk6yKRj9MPdjytFQyqlQfUDWoKXqc5vxc9yJ1EKsMa1qt3//
qnEq4VHyS492hHQG87ZiSMUL1ACnYARv0aNGTlKbhtFkuAjZaftZ8RSjdeR5AuUK
IEJ+39P2asg4uukRe2yUVt3DeaQKffFQSaKbS7Vt9h4iQfgbbXxkBGSibXaiW6sJ
b0IlGFN5WJv5zpiRfihzVXkQ3Frbsy5FDbRM3x3gGzyg8dMof1Py2DppXKZPmQxD
K71nlCXKYYPsusS8kDY9Xxp6rAFJUmS2LyIINS98pLpqtE+PiAVDGJ0e/CgoWJDP
xAnhK0GTDKQN+bi1HB+pSwHR0FqH+HlOM6kBIo5b3bbmO7hE6rM=
=vBRt
-----END PGP SIGNATURE-----

--yUYs18z1YDJz7FA0--
