Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD661DFD82
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504294; cv=none; b=FqruZ7Je7+PPOMw1c6IY3tZ3risCfZgRX8evP6VZPk5hjG29gTckI8sgCQ3VDigX1ow6cud32DID1h0mRye0q54h6SfnLz1H6N04rCIMXlQfZx96nAlcjoRD1Irhz3+8//9JltT9d2V7EQ38FNr69ZTAt6oak8l31ukROdwGxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504294; c=relaxed/simple;
	bh=gCcUVi8nTA1Rh/e72WDlCoqhhXVQoWR/s+UdYZTSvX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5KKWQIUGZtBaX8Zgwl9l/qBDAF/ZBI/T40zWbsWczEYLs3qcVwU05N+vaFf66ldrKe+oPHl97SrgR6QTwoy1ECpXKyWdR9JqlY+FoSDVkLVXd6sQhkdemfycskZ7TkEyRIBJ8aMi7Gd0nPVriPDQinAgXnNt+I9mggOu6SPoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oW8zFdTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPKHVdP1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oW8zFdTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPKHVdP1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E1A0113805F1;
	Wed, 13 Nov 2024 08:24:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 08:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731504291; x=1731590691; bh=vHrO9Tgqwy
	GVUAOt/ed7vTA+3sly0B62TCrEuRFuDy8=; b=oW8zFdTrxt1iYk8fs3+AuulclO
	0xWBbmmQUma17LUZ3nGFGLdUQZ7xGszsKspw3y8gTKrCzMO/y2xbdDfVT1Lbrjks
	06cdDp2x2oxfJ7BZwtfwZXABygFDnCsBWF0BM4Uvl97Gowx7ky3Fyr220aG1MrgT
	sbOO/n3nITyD+5uQqR6ezhLjM6ViY822jRwdFAtmkxspgBubgorr+Evzxs9XLU0T
	kbDnTFbTD4C/qjRfXwN8GvzoyqbwfX4jtS4+jEUVllEwl7wFxADQ9fQlzeMxB8+W
	yQQp4CJo8u0n54i19/IbjrMAArjyosu+bQ4Gk+9V4RSoYvt9Tx7sfQv9wgwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731504291; x=1731590691; bh=vHrO9TgqwyGVUAOt/ed7vTA+3sly0B62TCr
	EuRFuDy8=; b=HPKHVdP1aZXFFWlLhxePCI1IIh9uDNRqsU11rMKIhvMsn09hgST
	GfPF8YgMF4NI+TxgYOu7WkHBkqEnQlEhjsEFOYPKBma03iUkPNtvgL8Ln7cq13zb
	SfPsaK5PRUM8zWBuLeb+VPqFnlG0LLVr1HXx4O/AQTLEbjNoPKEGhgZYdcgU+bdw
	Id63EUFK29S5FOZx+iQwXsqoAwn/0w2I3WyZzpKsFkGI7HEoWsI9i97sZa5jLD0v
	uksLJaUu7Q88DzBY5UIOG2KUud6eqBMH2F2pe6gRehysejo7isO4eH+oIk77FNAA
	ejofkJh/HmYGaPvMB3QbH2zb7M35i3OljrA==
X-ME-Sender: <xms:o6g0ZxIl0r5XALMxspoQkSI6bX9NK5oBiD0ulJHZ_mnk6baS4J7COw>
    <xme:o6g0Z9IQVh0sG7SMNMpTznIHeJLWg9-_gnqzSWPnijZl5WtOHp4Q5cRvNMrl9SZ7a
    Haq_T6OiIuF7_kfFw>
X-ME-Received: <xmr:o6g0Z5stumWQko9R_hH7dzww4qpv3LsNUpWaZf9XSlsJxK-ZdjfD4l5_XJL1_qDhqb4_v5kcFDYFeBjvgNRyvmx1d_LtZ7vK_Xl0rGjNyQiFwOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhm
X-ME-Proxy: <xmx:o6g0ZyYZBk9JGjZzRBH8lugBDFZwgqs3Zvjuk6IWL-Be_wJVssPLew>
    <xmx:o6g0Z4adfH-brBDvqHA92TNTwknDtrMNVP91i5JnIZgadzH73YYDMg>
    <xmx:o6g0Z2ASBCrwfAPHirGatDbzbZXo9KFXufa7WUbiyFqyDAowhlG8TA>
    <xmx:o6g0Z2akWy9KIJ1apGPA4dHAyXN9hYFJEpvIdDKzzOX3oPUf2qgB8A>
    <xmx:o6g0Z2nPC9_869IIYuaPrlbk9WcW7SOB691dbqRYAgqoCCz32zk5kpPU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 08:24:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22ff0def (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 13:24:11 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:24:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC v6 01/19] Makefile: use common template for
 GIT-BUILD-OPTIONS
Message-ID: <ZzSomRWEQZtR3yew@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
 <20241112-pks-meson-v6-1-648b30996827@pks.im>
 <xmqqbjyj1u9k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjyj1u9k.fsf@gitster.g>

On Wed, Nov 13, 2024 at 04:13:11PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Note that this change requires us to move around the setup of
> > TEST_OUTPUT_DIRECTORY in "test-lib.sh" such that it comes after sourcing
> > the "GIT-BUILD-OPTIONS" file. This is the only instance I could find
> > where we rely on ordering on variables.
> 
> Doesn't this change break those who use the TEST_OUTPUT_DIRECTORY
> environment variable as a mechanism to override where the ouput is
> sent?  E.g.,
> 
>     $ cd t && TEST_OUTPUT_DIRECTORY=/else/where sh t1000-read-tree-m-3way.sh
> 
> They do not necessarily want their output directory affected by the
> value that was in TEST_OUTPUT_DIRECTORY when $(MAKE) was run the
> last time.

Ah, right. I only thought about the case where you set it up via
"config.mak", but you of course also have to handle it when set up via
the environment. Will fix.

Patrick
