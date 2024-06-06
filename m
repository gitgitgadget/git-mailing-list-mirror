Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60A328A0
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669796; cv=none; b=FhrLS9tMoy10jMfaZVjExIVpRFYc1bbXheukmyDVPXT3qagdfeNYcf16OSu1Tz5hvWMdergvqvwb3tHxUNIYMiSuIm4DuI/eWt2W38PsM7tSz2308M7PR/4bWtVRuSdcY6INQ6OqCZi/pOzJQxNKvp699cxvUIU+5RYo8Im2NE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669796; c=relaxed/simple;
	bh=Wg8Ibk8or/7z8xJwIXVd5CFD8/x5CwiRs96t+WIi8o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUQHBtUarZcc/iU6ra9PCWFUnwJt9L3hQle+ijYhK3LAYBYj8ggF9nQZ+sVTI0lUCme41PMq1+Tm2+qOBhlVEMfa3JMhREU3vcYdtS0qLdLEMvJz8YgGhqfL0ARdLoY+b1L36p+xAuSZFcKdp0DgWYcJidDsYKSSuRHnHZ/SgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Boe1NjIM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bc2bw3ha; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Boe1NjIM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bc2bw3ha"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9E3CE1140138;
	Thu,  6 Jun 2024 06:29:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669794; x=1717756194; bh=Wg8Ibk8or/
	7z8xJwIXVd5CFD8/x5CwiRs96t+WIi8o4=; b=Boe1NjIMQBDu2WnGj9k0YvSal1
	jBDs/NlGcPGNSrG9746mVk0jjiA0WfFMdBa3BziIJmmexjcQfujK9BI3cQGoexDy
	6z27ZY3YYlivFwVzgNre+/lFHS7p3br/asd/J2IRyMF/KFWMgCISJGbjxg34zbjt
	FnXvljd0gcpdJO3Lw0p7cNWJ1ikfsqgZNjJCOGGvowkYzTGghkQqWZImoGeGGn+H
	Ajk5etVT8BHtPykW9THrOr/Q/+gpJ6kunTlK621tLNRm4iSbTOzx5HGkWv/SIPrl
	usSJ2MZYS7+0mmZA9oaSSVp+nSZ2L48Nvuv4QQfyyw3+SGy4APs2WrETZvwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669794; x=1717756194; bh=Wg8Ibk8or/7z8xJwIXVd5CFD8/x5
	CwiRs96t+WIi8o4=; b=Bc2bw3haTqVUYfdwAlq4bw5c6y+tV8YeNpAI6uGNnDOg
	QnGS3QCpy1UWeAx7KZcEcco3kXdRGdv2jY5H0traTBI/xB6W1sypFiIGW2hoi9kK
	KrfyGhkKIHOvynA3BRO9+WZMSaBuBaxnUzkZkyy9ePlWSinFEeQmQOjIHTPneUg4
	phRmigprwCx8I4VmnS/MAPkqCj3kCSatUxfNHQMXpLn3lmCrooJFBk64pr4tHF3F
	bheIsPcYHwHcuKQRQQDqESxq9bxOnp+puoZffBUZKAIH4IGRJBEsy8E9KFZyiD1M
	q7MqspAMzA3w3zSLqU8RPGusSKsQOQuszULngLAtow==
X-ME-Sender: <xms:oo9hZhHwQbcEbul-dk7vDlngTlpEUhY77rAPiT4SqrOnYFD48FFiyQ>
    <xme:oo9hZmWZZJp9OaqOW2hqAvLcMSlArFRdKAiNPyPvgD95qfCdmcCW6puIj3rJs-k05
    p1t7rYd7E6BL-l-fw>
X-ME-Received: <xmr:oo9hZjJmIhU5STVXaIG7tA0A8KbcGPoYnUgSyGYpTgUav9hC-mSIiDvhzsH3wVPWktSlBGGfT9Lp2CNgVA5_h5CmVyz50hnDcLjFsAuCuQyAUsLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdekfeegieeiudfgvdegfeffgfdtheegfeeiteffkeelteegffdvhfevjedujedt
    necuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:oo9hZnHbcb4owncQmZyujJOJmjSvNZiXFbTuVBvxm7PPFTkvp0wI3g>
    <xmx:oo9hZnW5EegNdczvPFinkKIApU2UOaoWg_vmk5l38yWVcWMPIKpajg>
    <xmx:oo9hZiOx7ap1Co_P_eE5sShqibcKWdVh47YOA_kHphPj3Amo46XGLw>
    <xmx:oo9hZm1vO22W3wIgeaXodqltsTF_TJ3iZtyMy0dNQgbEev7E1ZS5lw>
    <xmx:oo9hZtyekCHT7Nzlz6dPDAUa0tsJRWJHxXn8TMR1TPnJx28ypU3xnPaz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1e98475f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:29:22 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 27/27] config.mak.dev: enable `-Wwrite-strings` warning
Message-ID: <c714b67199572b9475852cafeac3133081306186.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eef1rUjtYHz8fm/5"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--eef1rUjtYHz8fm/5
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
2.45.2.409.g7b0defb391.dirty


--eef1rUjtYHz8fm/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj50ACgkQVbJhu7ck
PpQbEg/+OdWekNeQ4RxRGqnJGAO7fb6cbnQYMsed7RNmnerOL9haIKQM4TrQInpZ
5RJy9hojCEv31ojDGPFZyi9CpwI/6VzJHn2Q4AEzXVgih1qj5mWiBeGqYDzFd/dm
YI/gEAvjIIOHnUN6trwSK+eU/jdi90Sdds7446Npu5/efzz9S71IK5vRPUuc0azl
cpgLtmzjVhBUYTqZjFPB9Vyyuqyvy7NG3Vr/uqAeg6L3iZnM0ckoE5taL/t/urgv
jiP2qTpnfwVXLi+GcpQc9qvrOkbLiShzlulxvy4m27/KxmlRUjmhDur1LBwDvLLR
HXoznrdGJmX9g+EHKiRhnXpm0eYXaZgMgAXvA1/zFpfn0S7oNqQ+uIvfWyJfuhFA
zpOjmceFbkZEdpgFcHYEu4V7BomLzUQaXqX+lCI69XD/wRR5jvkyBH9wbKR6HB0k
lDwFY3WMtIE4nju1pwiTyYSjWlavk0UIuG3f7v7qpngTug403eTJTUjFNL+4ekEy
nm8eBBZt+QaTHrVWZx3rEtUQmwMvlkzceRDYsphgrl13A3eO46F+8rxSRJKbe1yP
87ESnkxHEQUY94Uay57wvov8YtLDTJXL+IDNy8yCKS9zqJCY98l2nKjbkcxeQijs
x4FIhdhiFADQLUdFuTPnS03vGK3379sdsexd5s+RCCx82i7ybBo=
=PpvO
-----END PGP SIGNATURE-----

--eef1rUjtYHz8fm/5--
