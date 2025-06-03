Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21477239E69
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958692; cv=none; b=CiJisMUi9m9QICHTfeg2jS6x1ZYDR44qf4s0SVH2Gq5DK/UZv+RWuc0h9mFDBbeZUUbZaJebykWhGncwqvjhbMNMjmOWU4i0FTWtKZzNZYz9YhIm05R+mnM15toifDKdtdA5OeGsouZq6IgTV6pgNMJ0hbaI3N8lghoLRTP6L4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958692; c=relaxed/simple;
	bh=9iEsaoBe27+tuWootgezLaegGC4lH+6lf1C4KGAfxrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM3g/zv72v4FXNXHxRlTtJY6icsuZaP+kG21O5XtujddcM5SRY9QW46scErDsZ+DZCMk3YYpxmvE09/1hkwFm27+V7JwdtZmHKR0DY7hjWNj+EWT1WsarkM/neqIWwHL+rDpyUkwRR5E8D1hxIpNiQ3VC9ZJ6yC85CUySthmcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LS6TdDzp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqLAC2pJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LS6TdDzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqLAC2pJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D944114010C;
	Tue,  3 Jun 2025 09:51:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 03 Jun 2025 09:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748958689; x=1749045089; bh=Qp52fDeZNt
	x5dedpt6Vt5HNE5NQUUufm6thVRm8FLfc=; b=LS6TdDzpQvHBIk7fRr65hHHl+g
	ow1zMtoEVjd5bIxJ0nNBY1PQY/heMnty4t2tatZ3qhWK5S2UH6mbboGQdRXzIJ8/
	vmcDQcEb7azAHPPPSXtBGzOlE5Dxn8zuSFY9w/E+q4w56vb40zihv098iQAQw34c
	s058x4WgZXPmEPIUpia5RojdCHgBBbNw9fKs1x7Ui/PWFCzPUqUjjqhVrbtLE/0I
	tFIVie4sqMGb5mzFqgZWaJZw5aipp/MQ8l+CQVWO+/NXD2HEWsOKqG6/E6eErz+B
	IxKJKbAmjunsbHQPgWN8Nq9JcaubWTGCu2bBRmSKyFkqSJmzbYnQbLxzEo+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748958689; x=1749045089; bh=Qp52fDeZNtx5dedpt6Vt5HNE5NQUUufm6th
	VRm8FLfc=; b=IqLAC2pJYXi1JyNTpOq6+BjjbFdSghmFXiIz8L287GqWURL+grP
	Eve1gFxsjU0mvf2ZNPLPZ0iIIU0NAB+OJDCmYUdawQpTxTQE0ItunMh6tkpP+wvT
	YlPODrgRsJxN7V4GU2ZrVk3EZ5dwWoZ2dP1geCz9lXY6w2z/015+P2YI4rHb2sCO
	kz8k2hZepbm6EVBVhfLF08MSlkZpbThAiylCHjAEIloKApp4Rdc1NYbJ3svJoI3a
	osDO7mI6eSS2AAAPA/gdTzhcrBwd1BH/R7Jf6cyitF9w+T0rp+PLDNSeYa6eIZ0l
	DkriLIGarFxY/B8Ku8dlruR35q+JV96DmDQ==
X-ME-Sender: <xms:4P0-aGMt69EgtaYL_wEFFn_P8ClfaEdgdfV-qzUyub8vyosuiJ1oRg>
    <xme:4P0-aE9hI6Wv5qP7O3LXo94FoaC218Tjq1PYOcogZVFSfHleeMiuMWNuzaWxMNNVY
    FkDAjTtRrnPEGuHxA>
X-ME-Received: <xmr:4P0-aNTAsUebWmN0hbag1doh7o0eRNSw1GuWcrKOYzVrT9o-zpWbKlL6JrPcNXUVdA2FD_nTz8pbBjczixRMhlQdCltarMNh1eaApJG56A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4P0-aGv-QBrphZt2muqV1Ts45u3UoqZHfmfZnT7CaBqCnATaiHC-5Q>
    <xmx:4P0-aOc5KCNTRg96mLr_VH-iiMLxHIrEkmEkrK9nx_edxmg9cjIDsg>
    <xmx:4P0-aK3NAFCGlAMEYCOJx9WRoCl0pDBWvI7krDAakaWI5RD2InX6pg>
    <xmx:4P0-aC-SOt2nZDngkFHVgNbugIecn6QuFysZZ9I7hDeZl6dU0txMZA>
    <xmx:4f0-aKyyDtVPmgB5Z8INR7UCKI7i4U5M_HK85GDPT1HQVk0t8Jw4unGC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 09:51:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45dfce83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 13:51:26 +0000 (UTC)
Date: Tue, 3 Jun 2025 15:51:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/10] t/unit-tests: finalize migration of
 reftable-related tests
Message-ID: <aD793WJpsHm3d3Q8@pks.im>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
 <20250602122559.208780-11-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602122559.208780-11-kuforiji98@gmail.com>

On Mon, Jun 02, 2025 at 01:25:58PM +0100, Seyi Kuforiji wrote:
> diff --git a/Makefile b/Makefile
> index 8ed8f234f4..8d8f2d574d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1380,13 +1380,11 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
>  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
> -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
> +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
> +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  
> -UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o

Can't "test-lib.c" also be deleted now?

Patrick
