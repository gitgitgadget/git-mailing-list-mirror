Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A471E4123
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501004; cv=none; b=iESW6lHWvYsmkWFUy9xRkcEnmKAJR6UQvpQEaFbPCujeRrDmfgYtkPDMSUBMRl2b2MZ3x82c0FztGmYYbKNchwcZqIlaR+TYl8z60nzKBDqGNSgEPjY2pf2cuJaD8T9SQflWxepacSoAINcnqUo68HQfmcKiymGDUwtS2y+p8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501004; c=relaxed/simple;
	bh=IXqRPzt4mZ/WxJXwRoAuAHsftUYbqkvzV7j0XVPJdbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP4HZoMJvLdBbOuiBmnjTND7wfXE6/BojtvkxFGeG3k0mXTOPky7kZmPIdBeBj34mDaJiIDhm9biM40mMazPn98sveGc2WDCTpDlKnk9GCfFTZGXS5X98zfuZcL5vPIM8VDvvWwi7g74FgisABB+eP/PcmQf4mOgRz1PKwNwTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N7YjMoO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mF87CnUC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N7YjMoO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mF87CnUC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BAA18138026B;
	Mon, 21 Oct 2024 04:56:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 04:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729501001;
	 x=1729587401; bh=06w3rdTlE6MZwJYv8awewXhQ5h3qy+iLdKbnMV74im4=; b=
	N7YjMoO1ORLVk/7u6miu9jPdh+LOMBugETca6l9oP3Otgr01Ey/7Vl6bICRHfnzb
	oQ36E/FFnlPGGibH8PlSVbdjE6ZtNmvSmzspJvEbTKMZqMdNVnbHWFhBA0hU//kZ
	CPp2oLPzDJx+LzxQfCmivpcGVOCBakHPegH2+UsGugkCKmV3jfWlavFdYkNcPYVH
	G5z15gnidgU2jJyiTNm3xpmizgOapIO+6qhL9OrjtajljzV6YyK7ZYtqlBpGNOwk
	6eEx+FUNbpLeaS2s1gj6AhHVuvgW7eo9FfMlOURrw3a2VQ0rkkvfurYV5HwG9M36
	BxCxZF/zqwWeXy/Kqcrqdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729501001; x=
	1729587401; bh=06w3rdTlE6MZwJYv8awewXhQ5h3qy+iLdKbnMV74im4=; b=m
	F87CnUC2aKPr8k7NUZRzVgRB4GOZ9qK6/kYd4/wCTMyf8HvoeC6ZOTTyo4Z9decz
	VjAxNM1Iqsh/XtJYru66ZPB6spZiq2WHuTgajFVAnmJqQRRGXjnajldJEPo5zRNz
	CCq22QqkRi+cdlw8eYWnHN8ZUVSaAUUJPTu48B2XA1bITYnJiCSdBe/3hr93osot
	a9N8WJt2NekR9cI4Um1KxhSAnEo0NSmnlSiyo5qjhT+2qnu9rngHnSWW27GblH/f
	IBXOaL/1M/mTDy/ZARolbLu30Oo8Sz53+3hdUN01eQ70u4eIcZAwhAB4Tm4fXBRy
	4pwUa9oeA1wcsKfvTu5Cg==
X-ME-Sender: <xms:SRcWZ7kYdLIZ1Jx_T03Keai9IvvUD380WX7N5cnFfAK6KjekDz14PQ>
    <xme:SRcWZ-3YJsrh_1EwjMS5WcyBkZTGe70n5v_4EUSrzCIyvtoXHKUerYS1Q-F1UziM2
    rtoUXZJM2WAZnLD1w>
X-ME-Received: <xmr:SRcWZxqjS3GtTPz20vlm-sgMBhJpFWPue29xNt6RnZD3wzVU8aDLmWvfIGhqflYCAdvK8nuLVZ8DrSbECVs957hlISDky58X6R2Go0Gt_hNL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepudetheffge
    eutdefvefgteehhfegveffffdtveeiffejleeuteekteeujeegkeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghoihhrshgvsegrgihioh
    hmqdhnvghtfihorhhkshdrohhrgh
X-ME-Proxy: <xmx:SRcWZzk6mV6IgQVOHRIIRpxYu9EeEh18z2JxANGhaTQyoetzw9YZKg>
    <xmx:SRcWZ53EXEgvoYmeFhigVFw4GWaiJoM4Br021BG2nGX-3v6GdXFEag>
    <xmx:SRcWZythxw_sbooczbuqN2SeSbuyh9QVshDqsFwp_JphkAGAGKUY3w>
    <xmx:SRcWZ9WScilJay78SUq0UbhreUR4sHOpgKUC9iuO-ine2-TR0DUBVQ>
    <xmx:SRcWZ3Dojpx4SRUmQdZ5ZnaRXZM0mbEuCW4YLMp-FgJGv8-m9hWqq_SW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 04:56:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f15e6e06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 08:55:11 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:56:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Freya Starshade <saoirse@axiom-networks.org>
Cc: git@vger.kernel.org
Subject: Re: Git build failure: v2.47.0 on Solaris 10 SPARC64
Message-ID: <ZxYXNTjRYkVaQaOl@pks.im>
References: <db95aa3f-f270-4939-ba3f-a964d46e2325@axiom-networks.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db95aa3f-f270-4939-ba3f-a964d46e2325@axiom-networks.org>

On Sun, Oct 20, 2024 at 10:56:11PM -0700, Freya Starshade wrote:
> Hi,
> 
> 
> Reporting a build failure on version 2.47.0 of git, grabbed from the
> official sources. Our environment is:
> 
> 
> Compiler: gcc (GCC) 9.5.0
> 
> Linker: GNU ld (GNU Binutils) 2.43
> 
> Target machine triplet: SPARC64-SUN-SOLARIS2.10
> 
> Target machine hardware: Sun Blade 150 UltraSPARC IIe workstation
> 
> Target OS: SunOS 5.10 Generic_150400-59 sparc SUNW,Sun-Blade-100 Solaris Sun
> Microsystems SunOS 5.10 Generic_150400-59 PATCH January 2018
> 
> After running ./configure, which succeeds, running `make all` gives:
> 
> 
> root@iris:/usr/src/depot/progress/git-2.47.0# make all
>     CC daemon.o
> In file included from daemon.c:3:
> git-compat-util.h:1012:13: error: conflicting types for 'inet_ntop'
>  1012 | const char *inet_ntop(int af, const void *src, char *dst, size_t
> size);
>       |             ^~~~~~~~~
> In file included from git-compat-util.h:314,
>                  from daemon.c:3:
> /usr/include/arpa/inet.h:68:20: note: previous declaration of 'inet_ntop'
> was here
>    68 | extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
>       |                    ^~~~~~~~~
> make: *** [Makefile:2795: daemon.o] Error 1
> root@iris:/usr/src/depot/progress/git-2.47.0#
> 
> 
> Anyone know what's going on here?

Could you maybe also send the output of `./configure`? We do have a
check in "configure.ac" that tries to find out whether your system has
`inet_ntop()` or not. Maybe it is misdetecting the availability of that
function on your platform and thus declares the `NO_INET_NTOP` variable,
which causes us to pull in compat code.

Out of curiosity, did you try running `make` without first running
`./configure`? Many platforms should work alright without having to run
autoconf first, but given that your platform is a more on the esoteric
side I wouldn't be surprised if things didn't work there.

Patrick
