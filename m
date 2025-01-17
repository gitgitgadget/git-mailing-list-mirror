Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D02D613
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104703; cv=none; b=RdkCrccv/rg0ve8NkXnc9pmphDkBjCtBCqzyi8pmXZ+2LSws4mN1QMQit7sFETysWL7H4LrCKEViykiNoSE6qcut/dT1TZV9NTimPn4mOGcbQ75gybIh/QNbhulShtIbVf8tnJKgDEl0V6MKtz1th53BgemmXam+1MGTUjOne0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104703; c=relaxed/simple;
	bh=fv41zkF2khwtg76qNyPMQdZJfebP/qpxr5k9/Jc9gIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/oN2sV4inj3HqQfY296+W3HBRBYSKGoCEs+cyb809SV5XZguH2Nx0NnZSchFGqOV50cKjnPwVmsoPSD9PQzdtkR9vVkVWRHWGksit/Mhe+WIVpgwUryVpjNngZ51/csA4IfcVo/youM/UcSHzhrBKmU5NKOjWc5GqIFe4AheOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vLzOx5iD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGsB3Sun; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vLzOx5iD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGsB3Sun"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AC9F11401A0;
	Fri, 17 Jan 2025 04:05:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jan 2025 04:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737104700; x=1737191100; bh=fv41zkF2kh
	wtg76qNyPMQdZJfebP/qpxr5k9/Jc9gIo=; b=vLzOx5iDXARg2JIXfvRSLc/dlF
	qNIDB/rezN1HqTarYq890XIW75izEr19Gac6sGn/LBiYS0TNB1elWX+EvZ2elejX
	FBofbZ75ZEPEJsIO+w89369JScu5inETaGlyUY2LsIhhx141+cTfcY8ufpwMKQRi
	4jiFn645KPTw+5prM0RyLYoEW+Huz+2NITF06GI/Q+L9n87EzkcxgL77Nq0XNmcJ
	5iFRa7ZlwOQRNSemqIeXoYLQmZmTIh5eKlx9Xs14SJpZNRXhw29VuL1Xgi//oACB
	aoVl+vrTjquF1f43an/8nSD52qpAafWrwf4Yg9FpS+WHZ3duZd6Q0RdJIYAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737104700; x=1737191100; bh=fv41zkF2khwtg76qNyPMQdZJfebP/qpxr5k
	9/Jc9gIo=; b=gGsB3SunHG1GkOiJUx399ol6mgiKS1PErPIvmDMvfrfcppJgSQp
	+Q/XWQS7d6+iLV1zUk0orzy2n7JZy+n62Ta3IkzxmdLqAqaXEsrpiGH5ThKFEdAM
	SWhNYWnfXuihD/v/QPu03QTleQG/7cns1BUZRyVQaVK1knAG6GIAV4HIpT3+pOzF
	7zmuOSnEgc/9PfLFFMtXy0/KCg7y+q9T1szH9R2EV/HCq3VYdnhOXLD4iZ4LZHuC
	gS0XXJuFEvNUwWbj2CSYafrZVFFJDldfOYJKtSpldcp5Yk1YwQJqu2jwWwFLVit6
	13X49xdux67OCl1O3rQ+AEgjUsqI52gboxQ==
X-ME-Sender: <xms:Oh2KZ7rmMNq3ZaJYzMah5OwLjkr-THJFcUN1sw1T1Vwm3FIseUF3Fw>
    <xme:Oh2KZ1p1ix3QtJoZk1ZNCuBdHWz5zLGKRRc_ng-5lmalWVsDJDUAgC91pSBROQbaM
    Uzqz6Gp7lS30_A5Gw>
X-ME-Received: <xmr:Oh2KZ4MrKBLDGr0jT11-YsD27k4Y2b1vUv541pUQfA_Sszc7at9Y1dFmD8zTFYp_SCQ9t09y-pEiwYYUljrl210Ft-4ZWLqkg1vfpYWZ2ND5ofs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epghgrrhhgrgesfhhrvggvsghsugdrohhrghdprhgtphhtthhopegthhhrihhstghoohhl
    sehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhi
    hjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhvihgu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomh
X-ME-Proxy: <xmx:Oh2KZ-6k2c3ZZBM-D5YdJ3XVeep4WCsoa8UtLb0UnFTWZozBYLXXrQ>
    <xmx:Oh2KZ67RhNsBFEwjYgnBGHF44S17iKtIjdSco41eELBDXFzfLjUndw>
    <xmx:Oh2KZ2g3Pn0lU3a6jtJ-n1GrwfQvkpS6humLZ8tG_lqDKcZAI80_Yg>
    <xmx:Oh2KZ86Ywu8UE31ruNZkYW0E04USUVCY4OG33uZOIcGI-HUq0FIWww>
    <xmx:PB2KZ6xonokJDGwe9ttoY9uekOrWgTHGmCSdwSKZeGUqdyEZSDynkYdr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:04:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d026b0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:04:53 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:04:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Renato Botelho <garga@FreeBSD.org>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v9 06/23] Makefile: generate doc versions via
 GIT-VERSION-GEN
Message-ID: <Z4n9gM_U2ZMgqAlO@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
 <20241125-pks-meson-v9-6-1c6cf242a5f1@pks.im>
 <8060f2fe-2749-4d31-b913-5453155a8063@FreeBSD.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8060f2fe-2749-4d31-b913-5453155a8063@FreeBSD.org>

On Mon, Jan 13, 2025 at 05:17:50PM -0300, Renato Botelho wrote:
> contrib/subtree/Makefile rely on asciidoc.conf or asciidoctor-extensions.rb
> to build, it would be nice if it could trigger the build of the appropriate
> file during its build.

True indeed, thanks for the report! I've got a patch series cooking that
fixes it and also wires it up via Meson.

Patrick
