Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3D38F621
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116006; cv=none; b=mGkiWNyDrJXSlWM05oAp+KX2878C07RTUXOggAwIduDBOW0SkCSdL1uMlju76XSH8qTPZvIOvhQD4IQeMW1aOMJYKu/3VW93n7QbsME+rqWQpvPvaxm7zSLoSM9Jd3fle8YccuAns3PjDX+zNnbXavGyOxttxAmwZIDxYmi0W30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116006; c=relaxed/simple;
	bh=+9qZme/6I75tavesYAqxfLvsnsjfpcxYozmlFWiLdZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay8X4Sx1UYrc+hnOOXFzMw2j8N7wofyxfJGtUwOrhwHmqeSo8bne01iwy6UDdC9ZBVBo3T870zv5I7arJldfcOzfpXCYOMFHskUUSXn/dY0XVqLncrO07wfHJeXcAr25gmQhganJvvnenyIRBeLcrJmauB5MGnBCci/nlArwIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKqDtC2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOiL2CFR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKqDtC2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOiL2CFR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05BCA7A00EE;
	Mon, 22 Jun 2026 04:13:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 04:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782116001; x=1782202401; bh=uZIYVam1pC
	PCcHtlTB/O7rOQRtykpCwIIWAAjkRmirQ=; b=BKqDtC2p64qIdNj8Idkj6onoX9
	DzZixW/BkjvIyquCARC4Zrg55sILrDCo1lyfMVl2+YSzPpnF0peCxJ6SPjVs8tXx
	G6l83YbIMne1gpredG5F3LHLvYchI1di16eMcY+6CE0DxG9LHykx6A931GdEkt3a
	2y/iQlpqWQ+zfhA3cvh4lVGgwm1jUD8DQ+sP4bdn9nQ4ynDtNkiqmgamLQURz0zM
	b0eH1m2oghiHBRcdqDQp+cufY82puFQXOWUAl8TicImRkRSi3j5DtGdmAcLQjHKL
	r2Q15Gl3M7s6gdYA4j75lKRtb4nS4VT+13QawJa812R+gmu5WaYA7ktZvDmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782116001; x=1782202401; bh=uZIYVam1pCPCcHtlTB/O7rOQRtykpCwIIWA
	AjkRmirQ=; b=IOiL2CFRAoWQ09Tx+4vljPwW0wuZX7EJYj9c4XPBtBApxiOLm8Q
	/qUwUuvEmjD01FYIswmTYlIPcLDaTGUSqM1sKIM/W1aUNwxWQgwZ+20jmvRWetSn
	LPln5lUfSQwrFpd6NBlkFK8DNLXX6fonDJw5tnZDz8WVQAyykc/E5UTeTvAXQKsS
	Cn3enNh4GDpgfZyKElKmsEtOZXA107Khr9WxPMBvc4ORkRnkui2vjd2GjRxf64/v
	kRLCEGrmc2JF6Tu98y/cKOg1eja1JikRNNAb3eWH7acVbG2jTN5tiHVRhcJ6ejSS
	iUA6OI9W9LgqQ/exKrvSzdW6V+LvBuC8qSg==
X-ME-Sender: <xms:oe44at49tR7sViGcW443K5JXNBaI9-9vUexbHbv5ja2mnIayD2ReCA>
    <xme:oe44akM7Vlk3Pxzoy6cF_6zY0qRe3BC_pMRGW7a1cNyyMghsF3RrRxATEyEJnkb_4
    BzYlMN90UqkmMosRJMhUGlYAJE6IEJi06AUZiZNSvQJeFV8qkxFQg>
X-ME-Received: <xmr:oe44ars8L6VB0pPhII6Tz1JtTg3MoPOgJE3OUX-nJf0qaXZxgJa93KnmQfjp9i9rAcqNsw8xQqAm82wagRHzpLki0n5lt_HQ_jtjDpJdgA>
X-ME-Proxy-Cause: dmFkZTFmFW3gFpwlGAQNXQnKxb09gp+VjueU4iv2/CeHUQWjKlrYb2oA4uiVsOuzaLXogu
    lTfZYy1ulrvQQ0s0bLqP/FNINmHL1us+GOpLRalq14usuZOxW9jJw7frX+h8iEjNtCAQyL
    Tv1mOi5vIzfVs6eiR53x13X8LQ0O8fHa40qyXYY77ibQVMm11+YdhkfE45w9Eg/l0KJSfy
    zAPabS8lmHJW0QRhuA6IhEsuvyfM2DJgDC02tyWeKTGQr7SAhcdFNZ83K/97gDWDhlVYvx
    KoVgfUePMj6ortK5LztTrMkmsWMSC/CGrZaIrEtqgJv6Ew/SFz/rAydJ09usUh9eFSjaVL
    Y11C2z/obOygvfrkHYXr/wj0JApXsfM7UKGqd8KV9xtD1LcJCVNm/lfyPLGEuFGMIvFowp
    h2JBvVkI8i/2Ff/t01nWhyKbW6JQSp0NmwmX+OjBO1jx7ZFMXrF5+RlgYpsPV8iT+NTfR1
    kFL08u/RWxBEbIF+vvHXYsR7YzLa/y8DDMD3Eg9U0cyPAP+9/zXGR3Y92gsKPzf0q6HL/0
    VsN0c6W8Y/9URuRwALNBbIbTBsR47KrqqA6rhG7n/r43MTpKaf5BYPm1Nq1423Je1EaCpX
    Pw0rBYEr53mh3t6yYWqINw+TUhTiKUMqC76WF4XFN7URzhfhZW7TQIAgXYPw
X-ME-Proxy: <xmx:oe44anb8QHvFQNuIQY9HZMmg8clubxF9D79zUPQ9gz7CQriFEgit7Q>
    <xmx:oe44atz4TfxcdmwrSkuOuAiQG_GyrfnTDnsPSfxKf-NJ3j-dtV3WrA>
    <xmx:oe44avihZqwdx_vsXcRD6oGzZ0wbTKLwtra8k_ARteA4NGLf7v3Erg>
    <xmx:oe44apmiG-kXkBv24XiP0m-AcN1iVMCv1AAA44cv1jtpf4uo79mypg>
    <xmx:oe44atB23LTlbuJsBzePfJR4Gzyugvujl5HPBpdo24L8UviRomKWjs5O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:13:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47461b78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:13:18 +0000 (UTC)
Date: Mon, 22 Jun 2026 10:13:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <ajjum9Cf78N-VCH1@pks.im>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <xmqq5x3cg10a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x3cg10a.fsf@gitster.g>

On Sat, Jun 20, 2026 at 06:01:25PM -0700, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
> 
> > Autotools-style builds permit enabling USE_NSEC for cases where that's
> > desired; the equivalent knob is missing from meson-based builds.
> 
> With or without autoconf, Makefile based build can use USE_NSEC.  It
> is a welcome addition to the other side of thw world.  I do not know
> if 'meson setup -Dnanosec=true' is a name that is easy to discover,
> though.

I think the name itself is fine. As is the case for other options, it
can be discovered rather easily by just running `meson setup` in the
source directory, which gives you an overview of all available build
options.

Patrick
