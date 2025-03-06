Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57F502BE
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272905; cv=none; b=ecwqqpNPw0vd6uTtKwQLmeT3qb7sy9fPEMzm5yjHS2uzCHLk+tqKjr10pakR1PjGoaxDK6NUeG0Lf/+rA+vxkXu5w4l/G+5Npiz1+S+ovydLoCNe4HRJghyhIhDGSHsGZFwzmSnZOwe6kOb310ITbLA8F07nTEqIxDkeQ9soEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272905; c=relaxed/simple;
	bh=JMLgrIXvyq/mbaZ7UxZRbyIUYtyQNKb2C5ouHolexMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYkXMKyMZ3IKG48JYFj31kymlFuJ/zFewkkGEgxHsN3/ep4XDDZINzV8DKrtM5CayyEUzwb369mxi5p2kIgDnVtR1Ia6vvABr2x9NNIbKL8r79PZ4sSXYSOwfc2HBgsSsoYxr0Fpe/lJeTsPxAuFaXz939/idahP5radRfleR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GGhgtti0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPy7FidH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GGhgtti0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPy7FidH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E9B911401AA;
	Thu,  6 Mar 2025 09:55:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 06 Mar 2025 09:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741272903; x=1741359303; bh=W1+QSOKhGh
	+mAWoYqPVKsj9IIcD0JoJnavvP8PfBSOw=; b=GGhgtti0nqCHR4gGOJGz1RewHD
	h2VuoW3sVYEAs0UN1roPle3fyueccrsWlbpezjYYnB4cOwQlzRW7eKotVxIt1628
	eCqW+4JILFrukg0r7Z3p+SVF/r8tA8vGWyQdQt+dJCHdTIU0KmoUYnNlwr/NAPVQ
	ISxtohOLyXYuITb67Kkog/jT67LM7aD8MCuOuqjJTEGsBfS/73torAWGg7Tg//tC
	kns2kZ2Owj2Iki+v47+gAKbXHlzwZLo6Ah1aEY3zRFQ5fBKlVerR2f9NiUW6723p
	AXaylvIdDxzVlavVc0xVyGWoe0A5D0lOY0slj5JbZoPy9jaNBXop5N9O9/XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741272903; x=1741359303; bh=W1+QSOKhGh+mAWoYqPVKsj9IIcD0JoJnavv
	P8PfBSOw=; b=TPy7FidHy/AXaYPA1b7NKuB8Xe9CzDfplWgjgDMBtHwGueylwTc
	okWlMllAVXljZKNPVMKHrOTWvIBmG7oiU/qbu6dZj8f9oxpogGExiPNTyxYLjg8N
	AdVvj/DTpO7auFOi9grNoVId2iep6szInu7RZyM/P8wFP8zXCknYWmLStig5ZaG4
	75RQKLyjENOLgd+z/3KgH/MUpn43/9r2NOiQEoD9McFAb4CLmjA+BqwjlmdUJ2jW
	xz01n7UdaUHUGhtsZD3x3kLbuZArGaaomJgRZefbIvLPrPvzwzrqVt//nagliJD2
	Ng9IerG48kxb6k9AhPIguE8cw7TwQwXZ49A==
X-ME-Sender: <xms:RrfJZw-SeuNMc7O62UcaEOo_c8wHGVmE4ay0W397jLG1D41bRHYW8g>
    <xme:RrfJZ4vGM-p9_ZLIqC8rFFfT8A9wACtu3KWeZ6g_uyLOpFdyZoIHRf7L8EJ2pQTNf
    ITI17X6E8dYUUnHOg>
X-ME-Received: <xmr:RrfJZ2DD8MUakD8PU5Q0_DDWe4lOLh2sIFKFwIVzhKhEF7GeP7-pw7kZgWSCFm8PWK_s9v9csrPRpk6KG5g37X0oGPLyHI_TFT4JSFB_MF67Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:R7fJZwfcbji6vMXSLn7cemm_y1IXeHnE-1I_ZrPvi1F_-d-iXvBepQ>
    <xmx:R7fJZ1O9mcUkGOyJCGvdiRn7muFJLQ6gqEH77KYtcxqUfOHD08vaUQ>
    <xmx:R7fJZ6nK-EWWeX18PHb4QAExmvnN2vdhUAEhUoEQCepSP5zTycspJw>
    <xmx:R7fJZ3uxayU4nI3_y3VYjzwHhfqSb55GvsXj_AXB9naFvfs8ULQJkw>
    <xmx:R7fJZ-YBMpxCcGGeeWvio-3x-cIN35NLuk_f8WdUImOs80Z4BZp3-Y2l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 09:55:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be800e09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 14:55:00 +0000 (UTC)
Date: Thu, 6 Mar 2025 15:54:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] environment: move access to
 "core.bigFileThreshold" into repo settings
Message-ID: <Z8m3QJPX-A_Bj3TX@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-4-c5dd43f2476e@pks.im>
 <rjhdutonrott3a3gpmq6t7qc7qtc4covk7gnp7kqvt3nh2676d@l3wkgwyotv2t>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjhdutonrott3a3gpmq6t7qc7qtc4covk7gnp7kqvt3nh2676d@l3wkgwyotv2t>

On Tue, Mar 04, 2025 at 01:32:53PM -0600, Justin Tobler wrote:
> On 25/03/03 09:47AM, Patrick Steinhardt wrote:
> > diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> > index c71932b0242..5be273611ad 100755
> > --- a/t/t1050-large.sh
> > +++ b/t/t1050-large.sh
> > @@ -6,7 +6,8 @@ test_description='adding and checking out large blobs'
> >  . ./test-lib.sh
> >  
> >  test_expect_success 'core.bigFileThreshold must be non-negative' '
> > -	test_must_fail git -c core.bigFileThreshold=-1 rev-parse >out 2>err &&
> > +	: >input &&
> > +	test_must_fail git -c core.bigFileThreshold=-1 hash-object input >out 2>err &&
> >  	grep "bad numeric config value" err &&
> >  	test_must_be_empty out
> >  '
> 
> I assume the test is updated because core.bigFileThreshold is now only
> computed as-needed. Is that correct?

Exactly. git-rev-parse(1) doesn't use the variable at all, so it won't
hit the code anymore.

> It may be worth mentioning in the commit message.

Will do.

Patrick
