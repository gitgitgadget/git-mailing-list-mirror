Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C2149C61
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950526; cv=none; b=J+q6UWRg+Ap/8FRH+zkYAK7mpwUuV1rR9snGSqQJVz88KzB+uGJvE1vHwrTwWYCnhSDgQc5KjgjQ5fGQOxTnGlz3KWQeLka7wYQhNXHPVxtdYn5YTNDkzcKDAqxwsDJuFaw7ws4Sak7whcK8sO7PCVoBLE+JkGiwXKKt/2HiEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950526; c=relaxed/simple;
	bh=ihPVzJ3WiDRjv11uG38U+A6eb+kNei+bTh8e4AW9Ksw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVqOM3lnYSvSjZ3BiR93sR/iYcWKfvnKEirH7H2JtH3xyYdOMYY1/bEx7sVYX+PIxu/8Utb55kQr2A57wnF6MCGULndLd6cxF7hXtmF8xMuksKPa9uwMqAxKaQJb3KAPzg//PHnL87Ozkqe18qgYnkk78n6VbUFeesB1gqUEKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TUlp1jNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flkirGEA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TUlp1jNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flkirGEA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 767BD1140120;
	Tue, 10 Sep 2024 02:42:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 10 Sep 2024 02:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725950523;
	 x=1726036923; bh=J0XachkKJHLp2/Hfhd6413YYh0hJzzZ6DAynBowRcQU=; b=
	TUlp1jNRWAnDTIGz9qWqTn1JeoSAmksn+IAJnZpdGSiFJhoW9P4fz4MNGL6Thmo3
	2Dlb22df9IfsM7L2qB1QtGkovnPA6vT/DLXcAKVQjvd5mR5Kz5WcGsWKvmoVbuUN
	H1x3sDNcftMt9EHIiiGHtsmoXbq5t7f3gJrsSzZQfE+u0JI7Po0srkz4PewEnHbi
	kU9O2lPjw+W+mOtXHGT5gLf/Dsw6MSoI8NRTsnKynkJmUIeAuCgCtr8VmemAAmxm
	8zoKIY4mWRTpp1xKxbqk8zO8YnUKLpBDwfXBE6PhZ1AGV304RUv5EL7J/DuiiMvg
	f4RT16vkUNpq3sP8JUz/pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725950523; x=
	1726036923; bh=J0XachkKJHLp2/Hfhd6413YYh0hJzzZ6DAynBowRcQU=; b=f
	lkirGEALsYSPSf8p9x+NK3mUTzNIBCj+FqlsUtHlIvCmLthhgym6cCqj6kIp+zNG
	UwUOR4bk4XwMe03sX6eYfDAjkT3OGyISuqA1Sess0maaVzWgpKu4nuBSKswsdQFN
	atQTSkcOWom2d//whTdGEQK0TCc+6emHn1vngj6+DrL2n2myrWggn4JUczvQTzNt
	gvLC+fcpI0+mdJk086BVoYJhhaL2vH46OyXcxVYGajY3inUvWOlXEbc9IUpacVdr
	5CwejGZxIdIjnt4B2LMw7boAVxk4q+m0tsYn/zcY8L45i487X3/UOiWAenu4VN3S
	LKgdlnMUDNKprs9iKMBVw==
X-ME-Sender: <xms:OurfZksEf-_f-xWp04MrlhB6uJ9tqgW1-4AvOeXzDdUXYXkHamk1dA>
    <xme:OurfZhdSCl4hlnWqRlJZgtHibHq5lKJPMbnoWE6O4BPypvuAeCwNfgL7JF4Ad8qcV
    wwhN7dH70IjOS0mDA>
X-ME-Received: <xmr:OurfZvz1uebkFboVYaTXpaZycInzn1AlJx4u4Aj0l_sCKtxtHY0dYF5ziec-rkxG4Ihqt8goi8rRi-BYDAbYbbVLI1kfb7s8MpeefCAThzvQdt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedufedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtph
    htthhopegvmhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvg
    drtghomhdprhgtphhtthhopegushhimhhitgesmhgrnhhjrghrohdrohhrghdprhgtphht
    thhopehjrghsohhnseiigidvtgegrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:OurfZnOQYeGs9IcNKUnokMORCRIGgtWjcSieJdabOlz1e2bkqJi41A>
    <xmx:OurfZk-Xmb5gtWvcTGifHXrxcVLIdEqp6fksuxDRA-NqbGxyadOq3Q>
    <xmx:OurfZvUCEaVYHzXLv215CY5eOEA1mwx1iL7Zr0dXS-TXShCPjTD1Nw>
    <xmx:OurfZtfxXzMxQFl16yJu7RdMuw3LP8izBxq4KkhnAsgOYnlCOgIJ8Q>
    <xmx:O-rfZufyeIIRucupGia4NSSeoiLF7H--o_j9VhV0U1YSvJF65FlcVbjc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:42:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ec87800 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:41:54 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:41:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	Josh Steadmon <steadmon@google.com>, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com,
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net,
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 4/6] config: add git_configset_alloc() and
 git_configset_clear_and_free()
Message-ID: <Zt_qM8ZGN4fnqUoY@pks.im>
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-4-calvinwan@google.com>
 <CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>

On Fri, Sep 06, 2024 at 07:24:22PM -0400, Eric Sunshine wrote:
> On Fri, Sep 6, 2024 at 6:21 PM Calvin Wan <calvinwan@google.com> wrote:
> > From: Josh Steadmon <steadmon@google.com>
> >
> > Add git_configset_alloc() and git_configset_clear_and_free() functions
> > so that callers can manage config_set structs on the heap. This also
> > allows non-C external consumers to treat config_sets as opaque structs.
> >
> > Co-authored-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> 
> Almost all these patches suffer from some sort of missing Josh
> trailer, so I'll stop mentioning it now.
> 
> > diff --git a/config.h b/config.h
> > @@ -472,6 +472,11 @@ struct config_set {
> > +/**
> > + * Alloc a config_set
> > + */
> > +struct config_set *git_configset_alloc(void);
> 
> Should this documentation string mention that git_configset_alloc()
> does _not_ initialize the configset? Alternatively, should this
> function also initialize it as a convenience (and mention so in the
> documentation)?

I'd think so. I don't quite see the point in splitting this up into two
separate function calls. Is there ever a case where one wants to
allocate the configset, but not use it?

Patrick
