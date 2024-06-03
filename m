Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6585656
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407674; cv=none; b=pXcgLvlxEv7ZQLT7kAyh7s9E7PCid5vSQIZ6YgXMQufE9e2CS+nskoKMGWhrxh4l/G13nuMmrtseqOH3pinfjcOss1Fu5lTEg2z7nTbuhp+jB1CxXOu4JSnZy3Eawj1g+PWEgSCNiP+QfMWhH3NmWR9qCbV+b2TsLllFTwqlm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407674; c=relaxed/simple;
	bh=oM8UMIGhh70nbcMJkwU/VQ2LlmQ9LJicyVF7ByQ7Z4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S05Pnl0hJHIuuwXSOC0otEqTH0Kog7csbLr/nS3vw1IIeK1SZ92I8UCws/4+u6aPn9Xa0VIDfFFlM6X2DrpKh4eMIQnhD2zGGwgVcDnKu6AHdxQ0BmdXBjOYlYfAIzuU/li0JEXOedqYv27UPNFJFar5R68FRaLtvoFzF9Mn1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ecg4oKY/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNkIBHrU; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ecg4oKY/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNkIBHrU"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 330291C0009D;
	Mon,  3 Jun 2024 05:41:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Jun 2024 05:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407671; x=1717494071; bh=oM8UMIGhh7
	0nbcMJkwU/VQ2LlmQ9LJicyVF7ByQ7Z4A=; b=ecg4oKY/6S+2TfP9++QDx3B0LN
	20Pu8ZaxmajyEOM8HHiMiG3AOwgzfDqGfkL9IHTGZnvgq7H2QIMAdXcMep1NLYzO
	G4W69Q+yie2ISrNFJLN4Fgq/BTqvs2rZDuiWK4DZ2iAHmUnR21Zg5e+gl8SjoWBT
	tRjoe7xcMJiWtjr1DLgBUc0lFiexP2GGGMS8ujvd1aqRQWNQ/7qXtgqawm+efxZ1
	YzbJum8kcf0V1OahqLvZU/TQ/Yhy1xoXw0tNh+VX1Y058GeOkfDzucwuuL/otIYI
	JWW+eNg/kecLsLxbkG6BRNsVyyLPJPEacGNo1wigP1YbZPkt/ukH5/lTyjGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407671; x=1717494071; bh=oM8UMIGhh70nbcMJkwU/VQ2LlmQ9
	LJicyVF7ByQ7Z4A=; b=LNkIBHrUKW5+yZWhsXtG1/UgLuzVhpQzNb0XGp2E4kmS
	loCzMgHgKMQ7K2NxTvqfNNZD8VhEZUA7xWkuua8yEPfWBpqhPfP78Snka/SNcWSY
	4dLlDRakSkgrfGQycKUuItRWo/7nRgmPXDubBkqGekZI4+Z/eKnJPT9fHlcUpxIO
	IXwqvSeNOC2gISnruMi3+G2RQFDt9fvQqA3c5ISGw3CNN7lmqTwYshuxD4NagXPD
	UoaRWRdN3LovI/3u14gtaM28ttEnRNSUB9arBbOfgJEUSKr0t7bu+vCDQ2TmZ17A
	rwAuPqzs3F3Mx293+e1mggC8OfpPcKhjFOK398q+pQ==
X-ME-Sender: <xms:t49dZh3QXCQ_CpeFw5RnHVjuFc7lRaXj1kVal-oA2LwO6hbyp4yTAg>
    <xme:t49dZoHGMCclUVD6oIAZkDwfWZavkjrv6mMJ-geyKL-MK7fNA3S0smS5tTqwG_TqM
    IUN_glZ4ez8yHiisw>
X-ME-Received: <xmr:t49dZh7DaFZaU848pkdluk7YMGueAsgDaOUor9OspI_5LZ9AI88rV8iqs35QLfFszgWoOg_96tAv14eTD8TMeODnCkZpqwgpJvUpOmamnvunvQJh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtkeefgeeiiedugfdvgeeffffgtdehge
    efieetffekleetgeffvdfhveejudejtdenucffohhmrghinhepmhgrkhdruggvvhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:t49dZu1zcxLTrMD4im2M568G10Jghn29Y1r7LVmbXRzDiUk76sJkwQ>
    <xmx:t49dZkEODzZb8w3mHycKLRypBn1PrtEGQJ54rNZfwrq0LmO7v_B0Tw>
    <xmx:t49dZv8TCo5RkKBsWpJGCuUf_cAnpefX-imUSnf4vUqMTDMTwTcuBQ>
    <xmx:t49dZhkv84twKQbF0H_ltftQxzLmTqijQwrf_O2ihz66vUYpVq2fgA>
    <xmx:t49dZoBaO7yEVVe1ELINvnove-gut6xhKvz5dtz1AeWPMPETvvsvEKRX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:41:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id efb4d162 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:46 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:41:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 27/27] config.mak.dev: enable `-Wwrite-strings` warning
Message-ID: <342754713476cd680b31420681fb1da624c91675.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eeLfC/rTjZWtfM0U"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--eeLfC/rTjZWtfM0U
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
2.45.1.410.g58bac47f8e.dirty


--eeLfC/rTjZWtfM0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj7QACgkQVbJhu7ck
PpTSbg/9HeiHJAdosvGeYwo9MtbQnpgSFiCIF5+jjXSkthCC2WvzFDVRDq/gNi7q
6LTgEQPYga+oF2cby0d430PMPjK0KEvDk69WnH3pKkGdPWbcnXoKqbfy40tg7hK7
upIywuO1ONL5Ahhe/P9rs63aczNX0um6EyMgyF/zKPYBJx5Iy9YkfxF91TI3CdSU
CMpPgnhRb09xdSwp5Rjp5YsxC9jqoUp5DR/ZXTlByO+856uVG2TBTKt4+qUU5T0Q
w43OcGXqtMNAijD0RWKOD1j5Qg/Dl8mHOWPd3Kc/d6aBXFShhewO/Zp5HSUfOpvR
p8suhiAiP4AXsUozgalPY5ZyLyl7h4LOQ1sBw6M/agMhn/+TpL/OWrB/45Jjia/O
qzdN9vrXFBZBdA2Q4nL3CWh3zmwIQm9q+cZNEbgqbIytlz23X/FDif9j4nOdb6tt
es/juhANpSu0Ek0gFSZ+B3z268pL9rTv0GbibPHq4lbGbH1DMNNnx1tyLlx1C4Xe
YqrZjELgjsaJBOlEa8k63NNzdi0wAzMMS+Rcf1F6ovPGTIlEcrMITT3hbtiV+cdV
tuhaaXK0CuurAzI9vTlYnF9YlyccOYYyd0tgPKpSyuzhDrMkluTH8c17WtVCYfc4
/6h1u9J/iJUypgKLCqsfDkXEyJr0UDo5zQUQTR1WEY/FQus7fZk=
=sJuJ
-----END PGP SIGNATURE-----

--eeLfC/rTjZWtfM0U--
