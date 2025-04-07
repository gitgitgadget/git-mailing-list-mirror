Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FA205ABF
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058260; cv=none; b=Y1Gb20pd1ccS/NneNzDFQQDYaNTDOV7AGwJmNNz3ZuWEx3GAZ3ijIt6rpmoAQxRQHIFpPTRrCkpnmnt9bJoGi3I3x5u0aW4pjJQxwHLAl/PmUPZ+688PnK70gz8vZp+tUtLLKZKH5e4oBjn9JawmEYk5hE7NtPxXxqi4oRz8Zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058260; c=relaxed/simple;
	bh=xZ6W3f6ZgKlRRb/5GFUCk7VjdH8UkK25Yxm/Lu1kLZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xuk3qgcKHuWcIvYt+d9SPU/v7CJ4GMtbh6mTZe9Btua+aV3N3L/L17X7LTc0HbamJtt6wcgs2AuU1Yhx5J4klRjKsLuANnDu0SwgHGe0EmC2c4ngSSeL15rifIBnYZB7zX60+awDWhtb9aV79QGUX6dvePJXcCVO3JTjRdRikaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ArVjdkyh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RT/Nup6r; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ArVjdkyh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RT/Nup6r"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CDF32540194;
	Mon,  7 Apr 2025 16:37:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 07 Apr 2025 16:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744058256; x=1744144656; bh=nux572oL8K
	r0mTirt19UVJDHO+FskHoZQg4f1jtL6+8=; b=ArVjdkyhYj/tJK+3PxzSD8iEjn
	FRmvtEnEp/kSdstbNNsbLGiMt2KLe4Q9AaS9UBPjqRn/CV0+WejA02f9bNu4Hf6A
	xKhzBeggz6E0vVjEkt45HxRc3wrfejPAQlVI6FVTdpwX9F6i7h23oB2BPJDnbBE0
	AnSS9bjkpgmFt/du/TTfbE3Rd7xGcwL1KD00sUVIozJ/ZKRQq6+Inl7rozHsDg1r
	mgYqn+TH7SUteBkmMgX+IP3V5WxPT0MSNcRaVUMp4W+ByVwu+F8NZxSmHtBOy7cF
	frGiIPRm9p0qu0J2Xj5ZkY1HdF+iC5u6TYxuX2Y5DdkxDsjTSFi/YyxyeAFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744058256; x=1744144656; bh=nux572oL8Kr0mTirt19UVJDHO+FskHoZQg4
	f1jtL6+8=; b=RT/Nup6rhDXmoR8uG1Cg3g132SUz6KNo4idnLapax9bVjksKp/E
	yXunT1g+R8J+bq/qxsWbdpSM0VCtzKCZRtdW23REH8sFd49332pnf4r5B9ADixwB
	zUpxOcVmvpniB+Kh2ZVPltHuwjANxmnCFH65JFY78f/PA3uCiNn+Vq/d1+npkje6
	HwJ4ugM5Mk/OqOiU+mf5vajYsfdNQRJII3pHY2Z2HXYooFeZviCckBPbRpjKx+QA
	XqacgzT8AJp0bdCRDeGcENPHjaZ/2lPtDAuxmat7g2EGqcE1isyVHn/LohRiXBpu
	Ct/zeKin4PTcLANMC0SrjpcCYMHy3GHoYBA==
X-ME-Sender: <xms:kDf0Z_I8Xfrjv-gOFABQ6QzkRzFR1nYaHoi6crKTJQwxw45u8B_tmA>
    <xme:kDf0ZzJ7grETUDMGs44XRHMDkkxT0qB7obAbTf4dcOYF8kEdHMTIWCvrx6kxm_vuK
    wJDnJogrPgKgy41bQ>
X-ME-Received: <xmr:kDf0Z3u4tbSMKBxDDyazzSGAUNtpPTELfBXyQKYJ3uN2RANbUyjgB9wj81by8KtUzGFEK4VSTxDhlj15LjKegwq3X7TlcoYHkpsy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkmhgrnhgs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kDf0Z4Z6ZTU292AW3kVG1OHDJHTlMeQF7hmp1xte1rcBdHiXqUkc8A>
    <xmx:kDf0Z2ZTFUzuCZxSU7vxRRizzDvhj0mgNKzr_g57zzDRCMemd4crUg>
    <xmx:kDf0Z8DC8GRHwA6fMMVo2Av9mIQ5anJ9dYPMRFonH98XDvUXaQvfNw>
    <xmx:kDf0Z0b9GMXWLFXcJSYzbulNbyNqLxOdKwUx-xeT1z9JGsl8xWmvCA>
    <xmx:kDf0Z7v2MTSwtvDixg7I8rIJnkdxTFqEH9U-0DZcQXd0sfCj5F2ivv9c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 16:37:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Brendan Jackman <jackmanb@google.com>,  git@vger.kernel.org
Subject: Re: git-interpret-trailers and period characters in the key
In-Reply-To: <CAP8UFD0SxKOYFegN=DnmyY5RW7dMqyohGzeCfoVLNOtwjY2APA@mail.gmail.com>
	(Christian Couder's message of "Thu, 3 Apr 2025 13:07:27 +0200")
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
	<CAP8UFD0SxKOYFegN=DnmyY5RW7dMqyohGzeCfoVLNOtwjY2APA@mail.gmail.com>
Date: Mon, 07 Apr 2025 20:37:35 +0000
Message-ID: <xmqqa58rn1ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Having a config option or something to be a bit more lenient and
> accept more characters in trailer keys could help some people, and it
> might not be very difficult to implement. On the other hand if people
> start to have a lot of weird trailers around, and abuse the config
> option to make it too lenient, then it could be a bad thing in general
> as more and more regular text might be interpreted as trailers.
>
> I also agree that our doc about this could be improved. Patches welcome.

Thanks for a concise summary.  

I agree that loosening the rule, or even adding an option to loosen
the rule, is detrimental to the ecosystem at large, and
documentation can be improved.

In retrospect, I supsect that it even was a mistake to special case
the #BUGID syntax when the trailer was pretty much about lines that
look similar to E-Mail-Header: fields.  Let's not make it worse.

Thanks.
