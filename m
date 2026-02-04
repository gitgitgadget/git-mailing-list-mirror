Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EF727A476
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230825; cv=none; b=HJBK/R0S/A2ypmDtq1yzDXaDMir7MRNB7W5x/sDJ6tBC5h6wyZJ9xEWOVhHsIEuJU+NmTOPSHUnSmWO16UAOCsaZdRAf7CsWPe8SVN6BDmLwSZOsLGm900AS19mojFuabRZ56DlILN04EZO48SA6nlJiJnsjSWuddKpQhd9o8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230825; c=relaxed/simple;
	bh=iiFrMV1S1bmQb96IfSBxxJK368INbjjrQqealSfyy8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htEUX/+59FGorX6A2fJIITQvH4/YYflm0V8Lcs/EK4GyuOEKzZ75EyaJegIw/s5haG/Sx4mBzzeLL+HEJoLrOjnrb9BRfoibwrH6RgSWqwnlFaxTMMyo4Ik49ohzZFHBGc/vtngrLrHcaBzT/SGqtHtTBbfZdT48m3TUK+a+CKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X5PmUVmB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DH0LaAQQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X5PmUVmB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DH0LaAQQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5925C14000AE;
	Wed,  4 Feb 2026 13:47:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 04 Feb 2026 13:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770230824; x=1770317224; bh=KQJHXePBDo
	nEmn1HZC8p+c7lZAbtubhwMmEH3nozKU0=; b=X5PmUVmBCuTJjsIwOdql55+9dy
	r/fKyB5Do8Gq7NB5cj+SCZGYSJyyelvxApH+iajtU6ir+sHS9vCoowxB0AAKvAYG
	sIUGhvOrzynGR7B0tUW2v/PGOsvyNXCkevrk/msmFETNa6KRWe221OZKcI8iOeM0
	bbMNYCM2T8cD9EMk992K3xkZAJ1DB7G6e97YX+yEHLtUIiSxRwTDyUfq8bpMM2Ut
	iL99RK3Vv4clDF2+U3P0jg8waI9Qp43RdNHu1vqHHlQUitC8Tkmapyvg1qf1lsEo
	NU1LjTTwR1OOYswamo5bF1C3Tjv9TUGkU6A8kiNvfxC3QtMgjMY8i+aFfcuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770230824; x=1770317224; bh=KQJHXePBDonEmn1HZC8p+c7lZAbtubhwMmE
	H3nozKU0=; b=DH0LaAQQNXw3BLoMlOXzwtztit1QZtII0hxxgaTCSXnNo7UtM0w
	DI17BTMJg2R5roWlYlnk5Ry+5EjiY5iyGQ40qro030qn6GOPPA1idl0F+43zt9d3
	4RfFTZ4JbRehguQ8krz50KbwlRpS9eAbZyIOIHLItoB2P4FiAwnEG3r7OlIcx+xZ
	VLp10Y48OHFVYuI1FAAOzf1y8a9Cd01Gn2XUxNOmRU9uuW/Y4DsseI2afw4vgC6a
	Dt/9xW3S0ZiwKg0D0OQSfaAZ8ziOcmXviWDmcRBVz6w6JMfowaUHaQUybjoyFY6k
	H2j15yx+WKZXjeemtJ1KCXloxg0PAgKeREg==
X-ME-Sender: <xms:KJSDaerM8B-YVMASARJUyWBJDtTSBaHVFnBPgMQxMI1KKimWeLe65Q>
    <xme:KJSDaTo8iCgUhsF4ntnCtbEuei0jA8GhMc7eNYMqO2xl5EHEN6hJDxke-g9STQs2T
    r-Jd3GR_Jf8cVxC1uVJBiO_o42UZYAGlyHNm_hvdzMtPKN8zkkX>
X-ME-Received: <xmr:KJSDaYPOf-eu_BXh2ivYj4MIfKvViXq6O95nqPLUBc8BWcalhy89ZgX6Y6Fje68di73n4TVDA2bMjVcGejoCO_e_GRvV1CvIKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhnvgdqugdqfihiuggvse
    hprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KJSDacyt2Dik7VlXzKZ9OOvh2clgt4JLbys3q6f77kipumZ-1ZGLUw>
    <xmx:KJSDaZt9uK360pQLeKT3QFCwAmtbGoLecbrEFGBKHbtytLY5ZBpAsw>
    <xmx:KJSDad4K4TumpbZXleIEwmafI2DsOI60ye3f3bEUx-Xe8bFHcPKvFA>
    <xmx:KJSDaQQoKL9jSNnQedo--sy-mGAt5Wx5be2O-JhXi8ir76Fvj7fodQ>
    <xmx:KJSDaZMTAsBNxmOh6dZEcn6eKPnK-7eft-FF-pB7tKwtDB9iDtsM85KH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 13:47:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] fix git add :!x exiting with error when x is in .gitignore
In-Reply-To: <9c5be231-f340-4a97-850e-d43c78b2c889@gmail.com> (Tian Yuchen's
	message of "Thu, 5 Feb 2026 01:53:05 +0800")
References: <20260204132747.1564157-1-one-d-wide@protonmail.com>
	<xmqqo6m4pi84.fsf@gitster.g>
	<9c5be231-f340-4a97-850e-d43c78b2c889@gmail.com>
Date: Wed, 04 Feb 2026 10:47:02 -0800
Message-ID: <xmqq5x8cpcrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> As you suggested, The loop needs to verify that the path matches at 
> least one positive item AND matches none of the negative items. A 
> possible way to acheive it is:
> (Notice that we no longer return 1 in the half way)
>
>  >bool matched_positive = false;
>  >
>  >for (item in pathspec) {
>  >	if (item matches patch) {
>  >		if (item is exclude) {
>  >			return 0;
>  >		} else {
>  >			matched_positive = true;
>  >		}
>  >	}
>  >}
>  >
>  >return matched_positive ? 1 : 0;

One caveat.  The case without any positive pathspec entries needs
special consideration.  I suspect, but can be totally wrong as I
didn't think things through thoroughly, that

    git add "!$y"

would want to behave as if an implicit "everything matches" was
given, i.e.,

    git add "!$y" .

while a pathspec with one or more positive entries would not need
and want such an implicit "everything" treatment.

> By the way, I think extreme cases like 'git add x :!x' should be added 
> into the test scripts.

True.
