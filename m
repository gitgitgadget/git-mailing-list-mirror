Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0CC8EB
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817231; cv=none; b=AZbs5ty1gHJRMJvsAe60omI7RoZp/tjgN+kh9orxo8UhdVDOAKpoYmprG73MKUqBw400yT7NnywE8iAXfDvLRh/dhznjbI1aRSlfHmsJeNHt8hLtZwuPH1f2XhudcUEuIcj+Vqx1Pik5Khd6VbwS2EniHldnGoi3AAwBzLg21+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817231; c=relaxed/simple;
	bh=zk2nWWxMfoOlluzMUwo7n+qyHLG8eDU1oiY51nLOLtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2W8UF1mmwk2VAIo6TzXXTVpoAKHOhuk0McrDcgGjVDJk00STHc8fVOctGqF9y0nF/Jo8CotpiCIDaqHlb5+GEdBr5mXIurNne7JDDEHR34mz9VSOQ9p9zFDkjSHHAdgBRw2K1/b6IEN3TE0O8mi4XCJXHuKEaDAJCcrBdoy7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EVchSLsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLDKAy+z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EVchSLsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLDKAy+z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id ADEB21D00070;
	Wed, 11 Feb 2026 08:40:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 08:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770817228; x=1770903628; bh=wYGRrjqVmT
	yG6E1NABuFkszHtkHmpDkjBy+xbZJilvI=; b=EVchSLsZsoNjpbZxZD1aW+PKb9
	Eqe6hy4qhqtihVgOz2wvOadYO4elh7jRtGuiajc9TYf+Fyl0HYspWw8Uf9dHkoPG
	EEckwB9DercSgx8l4mwquGmE1P0h7yXylHBvHriIqX4NBmzfrrPM7HVnk9hDcVwG
	CFUbrglp2sE6Q/TkM9QkAJhW3aS87lHUF0P4wBuSX3aatxR+TXiziYgocEicxJ5I
	f8ziEdNYjxZeOV7N08Il6rPXq5YxXTIWnVgrpWe8EZy5F0rk6tJi+0kIIMYqI9Za
	NnCoR4SkbFMwdLm+J7mG2SzvSovUEuuk2KmBpP7WDerzS9UA0eCRwM813KvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770817228; x=1770903628; bh=wYGRrjqVmTyG6E1NABuFkszHtkHmpDkjBy+
	xbZJilvI=; b=hLDKAy+z8+vb1VvAKjlrShkazo7Ut36Bi+OjNmA2TSeasRktoRo
	1XBefVG7ibcu1Qc3OrYH7TLCQbCoug2WRn0xNcaX1CJheuPFHnuaZ+uM4i9BuTxa
	7Z+t4+mQ35SXrjl02xjEUCAD9L7Xi6od86HYoCHUPTYq76Eqob8O8NzKkxHh7ir6
	jZL6g8qdWyVq/DjnwDuTj4swLmaN7AnJVz8cUh8knoWcCYK8HndZcNM8e1hlnHIX
	ihlXsQWV6iiyZVXtPHyOJ56LJaJ/xXDxvnjv3sso65eg28RpLKPvqzUzBx4gSBi2
	skcDgIKkg6FrPUdkjRLb5/kXsm6OcbF4DTw==
X-ME-Sender: <xms:y4aMaWo78yYS1zZC3ksNdzCjQ2qnXO6yC8ZT0VI69-Fx57DskX1wOw>
    <xme:y4aMaXuJHv8BFN_CWyk3kNZRiznDHfWRzLx4p2y4C_hKS3ota4cw-wHE40SuCSe7i
    i5GN2E9JvxmR-QpPbym5e96wq2iDs9WNeP82S9yeYxU7FYoleE>
X-ME-Received: <xmr:y4aMaV3jBtNyWa9ZCPzQywwhwHczj72n0GWQ7yKOBVNvl30WzNxxtcqbnpjFqyC-FcoYS82GjSf7fTjhJfO_5RuOCJXFXhHwEB2FEg2xuYJ_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrg
    hsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgt
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:y4aMaSHU8iJV5Zb8dq99mSHBhKwDG7pjAhr9iwA5Sm3Vhc98cgzAiQ>
    <xmx:y4aMaQthJsxSM4GH4bmGzORlwRumJg9bknAFy-EiFQKDh9n1sMPE6Q>
    <xmx:y4aMaVpEHSqSoocRaBhG6u44IdJBTXKf5cQIZikuCyZE_nrh5q3b3w>
    <xmx:y4aMaXW4UdIGtw4RTehSAnHtLalYXCX3fTnuoHZn_naRkRpA2-1ppw>
    <xmx:zIaMabzUEXyR_W9ZVG0fJGE8Z2zfp_a1Bvmjfoko2Rp8B5zm5d5TXTXC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 08:40:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 082758cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 13:40:25 +0000 (UTC)
Date: Wed, 11 Feb 2026 14:40:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, newren@gmail.com, gitster@pobox.com,
	phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting into
 shared function
Message-ID: <aYyGxdYKZpzz_Euy@pks.im>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-2-siddharthasthana31@gmail.com>
 <aTLDA11AKs0jlxFJ@pks.im>
 <ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>
 <aTZ5RrjnwJ2ZnT7A@pks.im>
 <87bjhvqvol.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjhvqvol.fsf@iotcl.com>

On Wed, Feb 11, 2026 at 02:03:22PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > parameter into a `flags` field that tells the function whether it is
> > expected to use the object ID or whether it should try using the
> > abbreviated commit info instead.
> 
> I was considering to add a bool for this option alone, but I agree flags
> is probably more future-proof.
> 
> Patrick, I assume you don't mean to revamp the `struct replay_opts`
> completely, but only the parameter that would be passed into
> sequencer_format_revert_header() and refer_to_commit()?

Yes, exactly.

Patrick
