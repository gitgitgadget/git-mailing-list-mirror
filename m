Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652615B130
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284333; cv=none; b=Ev6L869asineoDGazkIkJxV8XDgqw2VtEfcPD0eMHpmn4e1VkZdvPTf5a9AKTla2F4KrYUTdCAPXS81/jnWOUkg8zZ2bToC9Be0oawZsa2h+tqVshSerL3AxurpsSiD7ADfXyxKHB13dSfZYCco/8VkND8EgINSu3v+c65xmwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284333; c=relaxed/simple;
	bh=JzWFpolBaHTOttGRRZMlDFCDjntuwfI0h41XvWpv7fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfE2vQg03DoadHoUe4ojHXUzSWZn3ZcJej7+LF3NGd+p/L5Kvb5feEjM29riam6Xf8Y1YXruMtxgxpksUueID0F3rUN4044o+vKKMQBvuf/RlNFI414STK6PgDEaSbhJUawWDSFyCzaHjchgOR2WRGwuMIlEEWqG5WvqkskuA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YcgrETNt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMRnigR9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YcgrETNt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMRnigR9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id F35BC11400E4;
	Mon,  7 Oct 2024 02:58:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 07 Oct 2024 02:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728284330; x=1728370730; bh=JzWFpolBaH
	TOttGRRZMlDFCDjntuwfI0h41XvWpv7fU=; b=YcgrETNt0i8RY0fxOZ/XqmUFAq
	awF9O2N8fNyb3UXUc7woa5RNuTGvcJyZ+ITDEF6nrZrIQ0GLcOu3RLxvO+smifSC
	VtQt18DjSO5JkxXxkTAB6w9gzZ3ujhdSkbE7e7pHOFmuCiHRW0aioSwYxh+G+539
	dcwgZHgYAHobxuoGbXw5A3spseRbJrB5t6cg9FE3FuhJ89ZS28AstmLQB35xBOls
	lOoXNdV9TG7IKUAi/4gPbc+e3BhfXxAp4Pf9sfhViYwpg1ee1yWrEeQgYOiDgQma
	JY67Ax+y+4fWwrxA6XTKCIeW0LCI7r7lqVtkPYPIyCH6iUDkOu8LOFkvGSHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728284330; x=1728370730; bh=JzWFpolBaHTOttGRRZMlDFCDjntu
	wfI0h41XvWpv7fU=; b=DMRnigR92wsqOQAlR7rnyB3z5L91WFQJV2PboJu4FMI+
	tA/VIOvCIKwDjlkq2gtSW6L+epT3DRQdnCT0bDIEh35Z9F/LS/l0OjNQqrpJMvo7
	/tkuiyPAKa70yYhAjI4EdGBgvA+qxPycQ+jTa+gATMTIcBaJvYg3flNgQ0qI9+Yj
	LebeLm2zlzclmRf37tRCTuS6XuIXlhzyjTjP30xFGiSX0rYRRsnW8eKzuNX7Q5FU
	gTIjXI61peiYZm4ciF28jCZAds9IsHAlgXVa28IlKlUu+ENqFlvbY2XEGRzqS76P
	Lc2+/4DFuK/oSVOz6vsPr+jmdY8ftRDHw6GhihhllA==
X-ME-Sender: <xms:qoYDZ1u4JZ4ApLGpaLNtR5KPbvVWIabbLrgc9lmTbBJIFvyss25zAQ>
    <xme:qoYDZ-dci1-K0IztsEMXwq728N68QHVxTyV67lK9wFE9PtEvaqljhj_3sIwBQQRX_
    Mu_W9O1mqpetplCog>
X-ME-Received: <xmr:qoYDZ4xwItJZuHmct1IJKELxeYDuaM3MT9HrdurKEuNQl44-BTvkEQhTcTS3_GZzunKuSj7fd9_qyNSAhnqQKKfwIweUG3xNTlSSUrEPzG4FbouBRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qoYDZ8Mfu9fEzI1AmPLBYTZ13H1GNd9EKk-sb5Rucy1AxHAjZTLNuA>
    <xmx:qoYDZ198PZf5NPFE2LUNicxJ24YrlM8kAL0ZIC7Qjmhtjscq9dm8pw>
    <xmx:qoYDZ8XqZS1-ptXqK5R0DwRXsE__PDvXViN7B5lC1zhuif0_un2PYQ>
    <xmx:qoYDZ2eFi5txBGtOU88q-bFgjeX3B_6h9U7JSb8Kr31uoUJ_srMGKg>
    <xmx:qoYDZxa6q0r6QpVnkQBWwIUHnOQzJxv5Sr5u8Blj0PSOdKYi-d5SHvYj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:58:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d768ea1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:57:51 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:58:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 8/9] t0602: add ref content checks for worktrees
Message-ID: <ZwOGoxXmn_J6pgh1@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-_tO_Qtp6EDBy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-_tO_Qtp6EDBy@ArchLinux>

On Sun, Sep 29, 2024 at 03:17:18PM +0800, shejialuo wrote:
> We have already added content tests, but we don't have tests when there
> are worktrees in the repository. Add a new test to test all the
> functionalities we have added for worktrees.

I'd squash this commit into the one where you introduced checks for
worktrees. Or if this exercises errors that you have added in subsequent
commits I'd squash it into the respective commit that introduces those
checks.

Patrick
