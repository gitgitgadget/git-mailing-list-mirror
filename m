Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6E45023
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609610; cv=none; b=n895aLF4UJGTdT0m7CvPo9j5HiKIb5thrxUPRuEZJNpGlZ0279raoVg1sQLunEYUSKiicCtayzOKZkyE5++NgoSks8CK4U7r7OmS+DVMwsv6LMODn2+FdKq6Fddw+xh9EP99HS497HSXD23pOVm/UDgQPuagrWKMmhAFEs/2/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609610; c=relaxed/simple;
	bh=AB7OHN0rLjsRUveuHvROQK5kibYLtXDsGKVabqw3Nas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiKzPjC04qFNIGjcenPDIxGnZNUoWZaPm6rSkOX9vjmBsIp8nKM+xRNobpRuRkT5VKQrACEn1w/v4OmbYp1wL9E+yAR5evo9x/GgtRSsDQDFDz0mmQbS7bxyQh/Hb0AMBXBbLJ3Y3pCDkTdZ4hMBGnf+tJyrIKnngeQ8rB6RxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZAn1SMSu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A661TWei; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZAn1SMSu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A661TWei"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F4BD1380793;
	Tue, 26 Nov 2024 03:26:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 26 Nov 2024 03:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732609607; x=1732696007; bh=eNxnhBGtlh
	4zHFNDefkjK5Sc7KUWON8VwmbC57UfgGY=; b=ZAn1SMSuEUACFi9D5gWUgUvA9S
	AjdX2S/g1liWjQHZy8OJsyfdpYcDuKsLl1iPnNex098UeMW7cxuPmRmLiDnL3hdu
	rT6gY0k+e59BBuq2/rylyF3u0bFYoSwwijH2D50XCvvD3EzJMuGQk856HLd5AYOj
	hXptv6LLnDjls2HQ9mK7BemyQyA2WLmQbEHa+CXK1JOJTckUFf4uHZA66fAYiofl
	AM3KgGueIPh2HrXa5kCqUkTgQWrn594ndvrpbWQ6+Y59Q2rAGhq7sqezpAxxOvpX
	LSeQDBFmYPNDX9pFNZlYa3kELu9f62FM7SJvomJOWKORNTaDHpHLY3g4Dm0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732609607; x=1732696007; bh=eNxnhBGtlh4zHFNDefkjK5Sc7KUWON8Vwmb
	C57UfgGY=; b=A661TWeigBOC0V3b0LPeJSVI9GsW8rNYRFhTzKBnLfEBHU67BsT
	0UV/+LGWFpUDqM9b2iiOmzfNx51oNQudRmkeBPCkqlTnuPPR47CHZ1I0oZux4PyA
	4SJG63BZx7nHgY3xF9jJAmo1MGreDRzztCHA4FTCN27+tjBsJZCiCcxZhyzw2T+1
	q2z7LHLWiugn+BGgDRJWqV/v1tcJsrhqd1dhMnh3AlRYRs4Q0iTnoZS+vEdi4u8P
	HwXsKpeNhxuaAgs3YkifCRRdq8Nf0Ywkdotgn8V79R1T9okhS+AvOPacn18lrHa/
	29RvjbxU5/PMqgqbXh2KX5IKwjG6oJpIPkA==
X-ME-Sender: <xms:RoZFZ4nMldeurX9fNt-fHK99lTzriAz1duK2YRnYzh_iCc30h4Q_QA>
    <xme:RoZFZ31IzQRB7oJSYumUyr4aiB2cJRGPqcNHfmGcrwTtu4z2yFse1uwpVGqhl0G8H
    fgP4vrNjnVQtXjPIA>
X-ME-Received: <xmr:RoZFZ2qDJKvxaZ4mnP51Sm0vOg0q8XYMa77JxFNCKhJ1wn7_tF28q1YMBKzYOHjRC-0iEDBfO5_yBgENbc2vcOs3378M1i68dpeLMQH881SQIGfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RoZFZ0mcOAObvLSgVfi2G4IYZPKkM03COQvtbRwXhfFwm0-j_Z0VIw>
    <xmx:RoZFZ23lE9lrnmZpENDtFeepQ61dfP0ng2MOPbr_diYUWbGfyJAfFA>
    <xmx:RoZFZ7s5-9RsvW1bx6jY86nCieCE-UkN0jwpMqaDlgVTleaW63x7Ug>
    <xmx:RoZFZyUo1zlsZFvxKLRLnRixEWZ72xMvpuE48wVU__E5u7he-3dT3A>
    <xmx:R4ZFZ0xhwZCTKBiuN7mXd_pInAxrhEODXjzjXNt9rrmXJgbAq0GmfJPU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 03:26:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a237b24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 08:25:40 +0000 (UTC)
Date: Tue, 26 Nov 2024 09:26:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] pack-objects: add --full-name-hash option
Message-ID: <Z0WGLeI2TA8m6Gpu@pks.im>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:01AM +0000, Derrick Stolee via GitGitGadget wrote:
> It is important to point out that the name hash value is stored in the
> .bitmap file format, so we must disable the --full-name-hash option when
> bitmaps are being read or written. Later, the bitmap format could be
> updated to be aware of the name hash version so deltas can be quickly
> computed across the bitmapped/not-bitmapped boundary.

I was wondering a bit about this: is there any reason why we cannot have
both, that is reap the benefits of "--full-name-hash" but end up writing
a bitmap with the old name hash so that we can continue to generate
bitmaps?

Forgive me if this question is naive, I'm more at home in the refs
subsystem :)

> diff --git a/pack-objects.h b/pack-objects.h
> index b9898a4e64b..88360aa3e8e 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -207,6 +207,27 @@ static inline uint32_t pack_name_hash(const char *name)
>  	return hash;
>  }
>  
> +static inline uint32_t pack_full_name_hash(const char *name)
> +{
> +	const uint32_t bigp = 1234572167U;
> +	uint32_t c, hash = bigp;

It would be nice to have a comment here detailing how you came up with
that number, and what its requirements are. You briefly mention it in
the comment further down, but I think this could be expanded a bit.

Patrick
