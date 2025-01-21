Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FD1925BF
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737441873; cv=none; b=uNHoyzjbqfDMYEbFWRNOEqOZNU83ukbwmHinJrQCFwvjnXl6coL38pRL+ieTzCmHgetbhcSz7UC/Pr0wo744TcKgHyLhY0j6XG0E5Agc/CmnTXskWZ9IZuL5ySYgulGEPyXaFVtg3TmSK3No04kVec7OyJNzBpVEfpQcR7+efGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737441873; c=relaxed/simple;
	bh=TTiJLu/FqDEPeWoFZPSL+fJb/A8Tbiny50vFEVjE1AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK6YCRHUjXA1GWbuDjJ8YH9/4cbSq6G8+qVDGjpHtzXUy4LlfNTBu/yKoCz0HBuPscWZm63UkvWbh+MlFSexS0w/khWqHOjMvfqTZy4LImW7ArylENaiGjLGlpMjdr0QkiaUY+j4cXXtnCjmfV8smjeZSbDEP6uPPuuIq0rzM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cM8536gQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p4b0liI8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cM8536gQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p4b0liI8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6BC3D254017A;
	Tue, 21 Jan 2025 01:44:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Jan 2025 01:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737441869; x=1737528269; bh=7dcOtQUUCc
	j66fnxr1h5I13E83p6wz7DG+F6Sm1LMgQ=; b=cM8536gQH+gFwGn/WDFeiJ7uLA
	0P8kInGw8FRNYDXFapqH+eiLYHLBRgwiVBK+3BhNTk+zgs+lskNmFU9qlj28IWsH
	1gkS00Sg3CZswoRtfvgmwxTUayg8K+tSYSbql28bcSS/0EcRlpWknFOKZaGWkwxY
	ulMPFi9nFjO9G3zNzENNuglc08pmTWCblr2aKKXqr4ypkJl7JFXUThaCImzj2Iy+
	BGdKL2UIiP9bkFxqZFezOzyzW86ZI+eojNf3vGqg7J6x0fiwA9QmFf/aGkD33YVD
	K4edhGtxF/nQe3LFyNOlsVTdHfaE5JOUj13n1HTnGteJkeGZJsojX+2deamQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737441869; x=1737528269; bh=7dcOtQUUCcj66fnxr1h5I13E83p6wz7DG+F
	6Sm1LMgQ=; b=p4b0liI8NErdjG2gQSRVD00HqiLWOxcQ2bAhslL0spKXk/1Jhx/
	KIewHvWj7LqF2OMGfvD5q2D/iK3HMIYoVyRJrISQp8Unrn0MVZ8pGkqE/FWR4X6+
	VqUcItBU8f4RNK+oXGjw1e2kBeStAx32CT0jORTC3Quw8/FZfWp74vwyjQuOH/FF
	ohCbfEgWj7IrN5zCSxrvL0rdq1RDDJWGYW22A9VOHp0Wz30XoPUwKKhvd2p1OdFY
	zo3tylYvigpVvZNnqhDQAuSdGB+ZyabHfe72J9YXVdYOQqEh5BmBd8KzZeMhiacI
	YMS+ROCblUSwlJXVnM8XLBsXanScpCv0ixQ==
X-ME-Sender: <xms:TUKPZ09kmI8Qhq9VZWg_fTEIzqEw76iwj1KXxDr6ch40XeZfsDoJTQ>
    <xme:TUKPZ8vLy1DBskb3_dY77OvqCAMKJSOgID3rfTn242ZOGCzY9t_EzK1l89IYs8nBn
    vD1TAWdaNWs18wVgw>
X-ME-Received: <xmr:TUKPZ6B_YmAddgWRQeA5Td82ZtET2_xEGiRvriG66IX1XyxWhguJkzaD9YvQyTAmG5zZnhdPa2-08ZT3Uj6y4hr1pxvZCcyxUNFD7ZsPzvp90w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesmhgrvhhithdrohhrghdruhhkpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprdgurdho
    lhhivhgvrhesmhgrvhhithdrohhrghdruhhk
X-ME-Proxy: <xmx:TUKPZ0eD_TSXqX68s8Sxq96i4AKCJQ1gPDkuhvieH5lDM-eFBxuE4Q>
    <xmx:TUKPZ5NzmieKBazVWmRwzuMEPl4AS0Gd1vPu1Z3NbMgPiskav4rS2w>
    <xmx:TUKPZ-njAydwAQEhEr1CKW2mZNv_3cs6CjcpWYL1RFe_lBxZtX4--A>
    <xmx:TUKPZ7vx1LaHkRjVxdSLDjqWC29fOQ6MGVvajR8bUrTwTyAWs9EJrQ>
    <xmx:TUKPZ6p9Y__-oAjuuK48mf7tjx_-mG-gZqzwB0Gm5toZ80oT0n8NshSn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 01:44:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 397703c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Jan 2025 06:44:25 +0000 (UTC)
Date: Tue, 21 Jan 2025 07:44:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Peter Oliver <p.d.oliver@mavit.org.uk>
Cc: git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: Re: [PATCH 1/2] Check for Perl 5.26.0 from Meson build
Message-ID: <Z49CQaW9n86Uml_l@pks.im>
References: <20250120160301.121245-1-git@mavit.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120160301.121245-1-git@mavit.org.uk>

On Mon, Jan 20, 2025 at 04:03:00PM +0000, Peter Oliver wrote:
> Commit 702d8c1 (which landed not long before Meson was added) dropped
> support for Perl versions back to 5.8.1.

Makes sense. This commit was another thing that landed in parallel to
the Meson effort, so it's not surprising that Meson still requires the
old version.

A couple remarks for the commit message:

  - The subject should typically start with the subsystem you're
    touching, followed by a short description of what you're doing to
    it.

  - We aim to make the commit message work standalone, wihtout reading
    the commit subject. So saying something along the lines that the
    minimum required version in MEson hasn't been bumped accordingly
    would make sense.

  - We use `git log -1 --format=reference` when mentioning commits.

So, my suggestion:

    meson: bump minimum required Perl version to 5.26.0

    Commit 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) dropped support
    for Perl versions older than 5.28.0. The Meson build system, which
    has been developed in parallel to that commit, hasn't been bumped
    accordingly and thus still requires Perl 5.8.1 or newer.

    Fix this and require Perl 5.28.0 or newer in Meson, as well.

Patrick
