Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893C26C39F
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399253; cv=none; b=MGcBt9BnV7BBMApy54qwi/qHeKZzNm0lNcPwJ9oVUGejahS/cAUk491DJY+wKmZ1PWwxhqxsxmKjGwbpIZD5BjN6zwXHC93VwIJq4DPLMnz+NpkCC4YPLEE4r+4uCsPRCGW90tDrIfnSnI7ocO3kGKmif+N1F8h1mN4Cmsaf64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399253; c=relaxed/simple;
	bh=x4Myj9a52z81Y4ZkNlVt8Js9A0GidSmM8QGCztfeIsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8qI8fgR8EqTeJ6wFENkXkW1Kra/cg3RmfWo9mDxCiRhkGmAU1yoQhJ0EIZ+UMm9JfXk9kDqor34z44u/o97FrkRB9WLYOyMc1rGpBc0Chac42E1ZOTjZV5kb474yE1jMc7Sgf6zsBG1DNJOmDlV5dLDJbv9PI8hkY/WojoUd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YhJuo7y4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oko8npKw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YhJuo7y4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oko8npKw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38FB414001CD;
	Tue,  5 Aug 2025 09:07:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 09:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754399251; x=1754485651; bh=ANMQczbA9a
	PBjcqD+biOdKZv6AQeN3ygRwNOK6E55YA=; b=YhJuo7y4QsOGH6t7qt3GQiiUDn
	C8x3yaHlMGmzVACkEKYXWaG5GEVvt5mWQMLfq+QZxjfRwKES/Qb6krDhexfSKZHz
	9IjQ6cATk8Sv0SwEZJn/IGEFwaeccSzOqcLChZuuYR1Y872vyO6v7qaYkFHAFuxN
	NdDpUVGvBg92JMFDsUO8pBvsCi5P6bwMTQqZ76TgAeQ8YqJGD2ooEJ/7uphUtwVg
	Hz7N4huZ6LvjFxJKxqN9fG+lsy2eQxbckUwiTjCnlHKLoI/qZDuzUZBlMolM7e90
	eiF7vZau141rTeO4ANr8X7xjswCO78q2CekTmTmL9ETVbnUBPqGL83Dx/qIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754399251; x=1754485651; bh=ANMQczbA9aPBjcqD+biOdKZv6AQeN3ygRwN
	OK6E55YA=; b=Oko8npKwbLkYV6tO7G0T5Ulipynpypkb8ytWD2DQd6fAMNn5rXj
	Xu9n4+v+yL/TLNzxunruwqjW4PsvziXisK6gnmwWhb9gN9EF0sO4Pi1sNv6uP9Aq
	U9shN0jUoXPff8FTzFYd3Jb5iLxhCbOE/r/emKF8XgOJ+QMa89ihsv0zeEYLmbdx
	AsJ0prUjugbDLH+lnOAJJEiBXIrCIzYa+AF6fB3LLFvIc7aPbj6vq/eDIErwawJS
	Bto5kceS1TzXO3FxuM8HGvLmgVSGqJtEmUjHgtBk73YbfNkW8aFf2gxGFuUMTI19
	nHKDxq8Ntak47f13+1/f550gEqxIHgJrZ+g==
X-ME-Sender: <xms:EgKSaErTCuLE-M6u-qL6wRGrp6D5_j_VfQhCjiHAY_yUtix-xDvZRA>
    <xme:EgKSaINO7NdsIBzNR_FB7aT5p3Si9nIh2s6mBBGMEM9Cz8-EYr-lIZf0kwjIOi-aX
    c9OqdHfYRi-XurHUw>
X-ME-Received: <xmr:EgKSaPqNmsfgY1AizBstBXgnj8DWzfoRQTOvi1jE5-L7diFjiAbEDiruh-YKWYfW8tBxlZP0vdOE1v6JtSzlTEtnpsK6zklaro1vn8EEAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EwKSaNfjic7V42fyzKAU3CX9N6Lxo1HV8G2Y0EywD_H6mMbRXIgF2A>
    <xmx:EwKSaFSM6qGi97ejWvrIpxy6NLapo6Gq8jl7GDkT0XrL1BvRFulD0g>
    <xmx:EwKSaGaTO1Qep23SSBe1_UFyp_qYRIYkhLeUCjUOzZqvUOOmbmda1Q>
    <xmx:EwKSaIdhPEg-y1Dq4bf5JuGzPPFIPrUAwF7aEM4AI54xJh3KwqAXlw>
    <xmx:EwKSaOELH_kK7sSsr-9ijK7_E_XN6FmaQsqT3L6B4eQyW04vwlc-KoTX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 09:07:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 918634de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 13:07:28 +0000 (UTC)
Date: Tue, 5 Aug 2025 15:07:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, karthik.188@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com,
	phillip.wood123@gmail.com
Subject: Re: [GSoC][PATCH v6 0/6] Add refs list subcommand
Message-ID: <aJICDeyvDjt569GX@pks.im>
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
 <20250805092758.5321-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805092758.5321-1-meetsoni3017@gmail.com>

On Tue, Aug 05, 2025 at 02:57:52PM +0530, Meet Soni wrote:
> Hello everyone,
> 
> This is the sixth version of the patch series that introduces the git
> refs list subcommand.
> 
> changes in v6:
>   - rebased onto v2.51.0-rc0

I'm happy with this version, thanks!

Patrick
