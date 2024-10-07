Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE715B130
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284337; cv=none; b=l25ukukuBeSKOOoetcamtKSpIvvHe9S0eUi6NCdlMbXMbCWFlG0DRnPg217DqLC0y/UP18mk9aWn+hQt47t4/xo0Os8UuxxbpAG1bNPGByWzoh6pQHh3p2ZqdHqxHF9G1tvVS4MixL1C0K6miNJgzGFgHj42nwnzVrD5OZMe0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284337; c=relaxed/simple;
	bh=p6UJ9WlGhsJ87GargKrFPANbiEYm3G40ozeo2oy5aoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBeLcngOrV8sfjUmKXei4XDSo2O6JqWBD0Zo3QCO0SeCL56v1Aw4H1OBa3qCV3krTy1dEeeCcH/PSZpaZ2xwHnwMCoMvBcBlK2ldDiYdmlmCJQMF9zus+iW7MdrpN6PrdiogpQBtD5cYguAx+D4eVJobEMqnOjCa7iFgfGeVMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q2SAvk3w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=osQTiREC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q2SAvk3w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="osQTiREC"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 849DC25400CB;
	Mon,  7 Oct 2024 02:58:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 02:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728284334; x=1728370734; bh=p6UJ9WlGhs
	J87GargKrFPANbiEYm3G40ozeo2oy5aoY=; b=q2SAvk3wBIlLX0fW3nOVnrPVWX
	7Dk9E5zME4S6v9CGBGbVHos2u0Q1ZsCrgZJ6Tpnzs43YFHFGzbkCd9wtSzbN0S1y
	FGKL/xZFyd+mms5rWGl04HFHAsMyAX0MgJQ5gZS4ZWz5zzKf6P5GaDZD2lfd40tg
	erzuiT/k2k4UYlsJDyYCT1WLDbc5e00MJJL3wYOa2vu4rK3LHXwFXMx7zNtnwklc
	QPUghwbA8BZdcFSXhFq8DNtWOT2m7Z/xssMI5JHn9J0mTkE2xc12JotxAls2+WbB
	W0Ku9nr4ifi/08GQ0c1WRE8Dylda3Ghpj+mNLyMCjmjkrz0cEGACNdl/aDlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728284334; x=1728370734; bh=p6UJ9WlGhsJ87GargKrFPANbiEYm
	3G40ozeo2oy5aoY=; b=osQTiRECaqkMVM2ynzFCdg1WpJ8udUTFy9sD2d6aMMch
	Ox5XAI1Vj1ymWwfk/uNInMPG32KQ8dnPd5BD+54ooNQRi3oycqUNBbp6waexgTCb
	Ws+a73MgY7e3JIeM1C7YPE9sZYj6P2IL9h6Su3YpbHtyLJZwOifEUcXtKC54f5Oo
	ySrgq0ccUVoNuZqLs9rh1VaWiXL39PrW3R4pTe+Iwd8EWy6GG+XVet6Nf5jU6kTl
	+TwYmSQbrIULhDi9/odBPNvPwUwO5C9c3xQF9rIhW9fvmWNUyFghfkfNBrzupPLs
	fgrPyOrtlCdCs0xGRa8ZeWdNv9HGZ87LWGt/b49Shw==
X-ME-Sender: <xms:roYDZz4N6WTjyAr-SAIbczPpSyoUxFi1MeuIiCE-4akCx9MWfCRioA>
    <xme:roYDZ45zPpopdUrnJaBEakMYT8g3LtgmxU_3Fs3hdJloThYOFNI12E-xeG3C07_ZZ
    _1cxrktSUMdOM2WTQ>
X-ME-Received: <xmr:roYDZ6cfsWoKKOhfGMCjtszmg-TBeUS3VPgqd_ystCfK2DocYMZoPJNbVzE9hEJzq19rQIi9frNvGk8yqz4iHxotYuNQ-4XAxOcFOLGAUwsi7N7Dlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtieduleeu
    lefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:roYDZ0LwsdTEvXWBa0dB_D9AWKm4y4FSgb9fLXDstPZnAUv_01Hwqg>
    <xmx:roYDZ3JcumL0nIDWXT9dr1nYgUv7zE2aY-VdQejJ110dWdxyP4PozA>
    <xmx:roYDZ9xkZg6tm7jW098SWLbtay2SBP33A-zsmRQ-CtMhpGykJd-1fg>
    <xmx:roYDZzIrpFU2hwiTcExK2OXDtovLO78hOVllbKTbkI7Ph8x3sdI3qg>
    <xmx:roYDZ0EuKaLGYo87CMi1W9-Ebr8KqhLRU-RvVuToo2TSsQfe_Vru1Ati>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:58:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6fa73550 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:57:54 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:58:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 9/9] ref: add symlink ref content check for files
 backend
Message-ID: <ZwOGqpeYiKITgsoV@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj_EELQdMsN7j2w@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj_EELQdMsN7j2w@ArchLinux>

On Sun, Sep 29, 2024 at 03:17:36PM +0800, shejialuo wrote:
> We have already introduced "files_fsck_symref_target". We should reuse
> this function to handle the symrefs which use legacy symbolic links. We
> should not check the trailing garbage for symbolic refs. Add a new
> parameter "symbolic_link" to disable some checks which should only be
> executed for textual symrefs.

You're getting into implementation details before noting what the actual
problem is. So I'd recommend first describing the problem at a higher
level, and then note that we can reuse parts of preexisting infra to
address the issue.

Patrick
