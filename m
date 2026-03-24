Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83C3DCD8B
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343293; cv=none; b=Utn5lqzdheSE8clyP8yQMazK63Sc8jGDCL0Lg5Mc9sn1VlJzUNswIGWupKB3axq73rlMBD3XyiKAoNXxKwTgNAOXB/eas/+6NMJ8fI6/k0vQ+2t34OxxJ71hn24Wu2TbmPbsLeT2Pn09ZPvtLL0ZQSD08hrno+fpmXyPBfVP6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343293; c=relaxed/simple;
	bh=PLjZBUVNxaMHBMhuFY9WP1ymx0CugXgMx+Ih1GmOsdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1xEwVnm7ZZh39i1ONVl/JGZKmVmA7LWFehn5v/7wd3k1mRrQjMJkSXclEajWgtu9llxoISd5DNpS6Iyl6mUyd7430QG2Xd/ZyI4ZxKrLZkIKCoUgTURRmKmGs4/bHbqE/1nZm/TjFDZ3hqk68Cwo1fHjvC6PkHCqzn5pwgxbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mo3O4Hpb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3foOPxa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mo3O4Hpb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3foOPxa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FE32EC01C7;
	Tue, 24 Mar 2026 05:08:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 05:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774343291; x=1774429691; bh=pSBhbd4DZl
	ZEi1fbgeyWvMAn8blCUqlZtgGkwUnqoVg=; b=Mo3O4Hpbn+1R9ZlxdpSks+Mbix
	QPs9AbYIPb0+hXSpnjxfOI3HpmY6GDeYnv52Hv/t1Pr5U2XXflcxoUIeDqL9IiB4
	io0/7mGvQ4LsC0VV246s5hLVBh0+V0M+7r5HYi/ygDHkQydqZXxy1gEKEl5hbais
	u2RfJDx2CmqPVbYtTSsqi/z+8JF8jg+bN/UZExicbjEJpR2SGtbQW/NaML4Gu2aO
	htNoaVwWAibpBOW98O3QypKW6F1lMom/gkyy/NiRarCFhmdfd+XXwlxeTqcJWSvp
	4zUTdr9pGYjOsgQgxdF4RkQ/XYAJh1ldhHH8+ZPBAnvh6nhcc5EKh79HX52w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774343291; x=1774429691; bh=pSBhbd4DZlZEi1fbgeyWvMAn8blCUqlZtgG
	kwUnqoVg=; b=D3foOPxaVmErVD5475efH730fVcUptobtX8aAKtWnWrqd6OGyCD
	bvKP0mZwHzTLKpCKelFvvrNP0BQHFhKq/NDa2r4AGp2nHdWoyV3OvRxC0DKSuqgn
	8ErDQayUOC03tbRs9QtRrFWt3ULD5tehrZ9qKhTlhNifg0PkLSL0hMg3MhYQbf5a
	LjI+/U/7iwEJ40CntAghrRu5tv9rAN7meDcBvciovLWrfLhP2/UdWO7YJz4/SKFI
	NZMsB3927WZgLQS3r4VPReOyeuw9qGvA1g0AG1lSPgBoYnDs1GDBDtAdCi+1WuSs
	6mCcpwxeD6OFjTMKxG9BbH/EEhcwYX8qqjg==
X-ME-Sender: <xms:e1TCaS3Blu_wozrr5IT7RmAgUtXhAaT7ByXhBmftM3rh7d0lcV2-DQ>
    <xme:e1TCaUKpox6nPJJhVJbjBlu2g6Fa8fpeqzVSiEJBERUtuxxg_jEEwMDnFxRdqOveK
    -E4HtRqbq_9MShnSgIIe0Xwbcu3GvYHTYGkPUhU3znQvYh4sGpE>
X-ME-Received: <xmr:e1TCaREbJe6uaT6q8nJXSFB6ouibI2vh5yKr4tf3DdfbhTU2fQNcCXAE3237lYqZsSzSsgUfxAY8e5qRs4NGgLNlRajNkeolLbupTjXJGZjqVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsth
    gvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e1TCaQXqsuLnrAkpWgYIvcLV4CMa-Jh2X4Fu_nUw9gXnk49VEIMNRQ>
    <xmx:e1TCaZywSH_iz7ZsF_95xDHdSTysiKJi5JxqbCBY2VU-mm4WS9D33w>
    <xmx:e1TCaVRYJ3k3WbwlwDL2sCqlRpoXSGO4X3BzVl-6Vp67UGz35YO9Tg>
    <xmx:e1TCaVhkT7epHsDjdsR3scNwv2-mP6avr0UM4tgjT_jSw-TKdUm5yw>
    <xmx:e1TCacCCrQ0go8gu39eAwfddhx8o2XbzHUdagH853kauJ4Yj4o09D1yM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:08:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 760a6f38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 09:08:09 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:08:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 8/9] hook: warn when hook.<friendly-name>.jobs is set
Message-ID: <acJUdkaddmaSeJJb@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-9-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320135311.331463-9-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 03:53:10PM +0200, Adrian Ratiu wrote:
> Issue a warning when the user confuses the hook process and event
> namespaces by setting hook.<friendly-name>.jobs.
> 
> Detect this by checking whether the name carrying .jobs also has
> .command, .event, or .parallel configured.  Extract is_friendly_name()
> as a helper for this check, to be reused by future per-event config
> handling.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Oh, you already do so. Great :)

Patrick
