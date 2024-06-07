Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141514F9DB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742386; cv=none; b=iJxaZJfWnXRfos8ucN7Dt7Q8cVB6bKH23A0/wcitetF9YoifY9PiPVm5AWVhYhiWkz9jCLL7D1Ap+vxI4qdc9GuKKz6lh5wU95ECplPeJfDzAyno3upuXgxrnjCCjaEfuUkp03xKjF4yud3jAD44p4tkqRukditezm+LAUYhGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742386; c=relaxed/simple;
	bh=r/Dr4J5dqqHe0+talMGC3P4zBSI+n8PLzoM6CQ6Luqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVXDLa58UpokpYZr3HTyrEGM7fegW83NuZB3EG0rTlwmJNbbAqmXXqY5wNj+IP3kOjSfA1IlWi4k0GncM8LCUmNsxkfpvxxrg7m9sPnd6409dKitLwtuYl+0tLWAbFUtKtNDt5+UbM9mUBhrCNMKCiDu4RwTYY1alAdZjAwnbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C7aIX2M0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRaUs4Ll; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C7aIX2M0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRaUs4Ll"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7145411401EA;
	Fri,  7 Jun 2024 02:39:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 07 Jun 2024 02:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742383; x=1717828783; bh=r/Dr4J5dqq
	He0+talMGC3P4zBSI+n8PLzoM6CQ6Luqc=; b=C7aIX2M07XO5jKCidvPC+UG5HT
	qkJkoFooxdy6x3ikHL/QJydKnuaovKMwaiM5+3Zn9KgxB8vQ5Va5d2GuFxMo2L31
	gnMXKyeKZqkR5OcXcCmzVUefZwpNudLcBc/BPczPQE+x7+++E4QJ/q7nFBVveYMl
	/IcO3Ro2hYPJYV1KSBr//KlTJXmubf2C0vy7f1eUWGBJZtzU9Z4+OdN3r6idDvzI
	W/tduyDQ75RQgoUFGMrvpRyxZO+lRelJgyh45Ev5I1w9nH42XhoVyWIsQNhAGI4+
	40mCs4Z64evH0ulZG6gPYiUR5vn1M+VmDM/PUbMRoFjbzZZo9aWwlzXNG+Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742383; x=1717828783; bh=r/Dr4J5dqqHe0+talMGC3P4zBSI+
	n8PLzoM6CQ6Luqc=; b=RRaUs4LlWHRN4mxr4OPhq2Xopc3Jit2kL1YcyD3rprGZ
	smkuCM5ThkQtRtVHGw/3yUmqaS9yq5TTSZjFJB4cQllz+CNUZDTnAlrqLf2RgCtv
	IYLz+4ZaZAYc0UoZP7V/cCoO1NGTs++OenZoqpbl8LuxIAIAYp4LmJCqYwqpVcm+
	oEmgpF257qhcDsm1D4CMtriN2x6+sfXOBWXefiExIW4+wOpvj6Dbgnt5PI5tmjY1
	1Ax8anR5mSRHWkPUlQGpqxOs0MD9/Y83J8326yzDZOcaHPnl3UHvQuxVyASygk/8
	HaYncPmu4dyZKm/V4VaeQExtY2ZO93vYlaLw94M2IA==
X-ME-Sender: <xms:L6tiZi7YQeniin2RBdS2lLV_8oh8gPkfn-5CedL8HaeDWBYreDQLiw>
    <xme:L6tiZr57oO-i-ps4s-Q4DR0H8dCwcqoMB7w7epLpCvo9_mBQysSzl_20EbVMBUcjE
    kAztaLTwgYa_pzMpA>
X-ME-Received: <xmr:L6tiZhe8CQW9eZZsPWludugCB90yfpJa0RUJZpo4B6QvsZaUnk6Ub1ivn2Z2D-hS7Cwv8U22d1sc8LrZcTTULOr3iffGuJUPkggYuWV6hEDtjwT6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedtkeefgeeiiedugfdvgeeffffgtdehgeefieetffekleetgeffvdfhveejudej
    tdenucffohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:L6tiZvIrOYCxFpKYy7SoIyH5xtDAjHOTj3_qGy-sdilY7evFOQNxlg>
    <xmx:L6tiZmLmLpFWVV4ViqP0EEn99-ySdcw782GLOt9pQqZTPrwB7lxecg>
    <xmx:L6tiZgzAMtP1igxiLvgD9KbUqkYE6Ocb3OvcUts-2qW2od6icM1MdQ>
    <xmx:L6tiZqIe1Gr4NamhV7gA7lHww5vJi0vsGI-Ehi68iXLkW-RV3jXSUw>
    <xmx:L6tiZrEfuuRMbUH_m4G3SAzIn8ciIwZhaFaifZQnCfYokR_8Ip3reKtv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3fb67da7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:41 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 27/27] config.mak.dev: enable `-Wwrite-strings` warning
Message-ID: <2c051d1fe64b087965bc4d3b51a19afbfb1ba4bf.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sOlRzYUFocOFHawr"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--sOlRzYUFocOFHawr
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
2.45.2.436.gcd77e87115.dirty


--sOlRzYUFocOFHawr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqysACgkQVbJhu7ck
PpQoIA/7BMWWi+kykMod7zv4J76azhe32JU74Ca0jXVK3BEQXBLEY3WAUIasv1U/
/lm5132u3UB5vIjnFdCRHTQRrmoyd2SMHa9eFG5JKKDJ/9AgFVrPa8Tu82T3/AYh
SrO57x5rWG2+pZ5H4fXnc1if+yUCKPGJffAvUevIBSwtk7IHAAy1SP88Sv8RF6LM
cOxj1wqPQASo3Jos4b92mB60fTQYFON93BYtlndUbpQog2Xnr3bKjLBExBNZXbVf
GPA5URWl98J+XdBa39l2AhajuOWNzyGzilzq/TNCnZ5RBwdV0yphtVq52W2/VtSP
ldJCHVZLGGDio1FMmHJb3a3WpTqfJ3GKB3/sUtANkMc+2NUpg/3ox+KK9X+FiUCT
rwKCTC80e5bik29K8CRC6FgfBtMUhMlua8qCUJnrmZyzdhe2tTrkZr3/5/qATDAb
rcSEsw5EaERBKsZD0V5p65losbkNohI+d1KLT23kITQQi/4hES51ThFcoFE4ABWW
uC8jOuBXAoqgqqLhiILWlnDkGMoowD8jUkUEvb/iYwESGhV5PCgdVZ4n2SOIwefN
IcJJIF2twdmwvi9nkeIbHnGf1nXCyXe2XVbhbKS+FZ+ZaLredMZyif6HAhXa7Xih
U9GfW2DUUEeESwLHcABXoI/xcGfvzid3i0SNRuJVAK9J5YhkHtY=
=CJ3n
-----END PGP SIGNATURE-----

--sOlRzYUFocOFHawr--
