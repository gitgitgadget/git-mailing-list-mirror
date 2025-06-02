Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFD13FEE
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748899961; cv=none; b=cPrcuwzKbbiq8g1Dyoa+3FIYFTNkvFJKTt/IqngdwiDT2EULQu7KeMv9Ppac+iNOwVuFI/oXwnoTFQIhqpC/WAbQQXMFCEgDktks+FcuBFJKHLAKXOQ78HTxZfu4ZBs2lnDOt6BQz9AtX3/ILzgw07a/K3AdgR0/PXcfvhoHtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748899961; c=relaxed/simple;
	bh=jS24QqxAoHssVhu0ZmXsBUnMVSkTn8dn9LQIW6ojCak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ne/aTqIpuVQiY1prIf/nktcXpKYftyjAOF/RcUgsxIybuZX0+36xqOplK0YfEOvTNdilmDqaF4Ksb7smALfub9YpJAl52sHb4A7jD0aTRkq9u2udRo0VAVLPwPIeLR5amKKsZoxOdxgJ/2DO9+7LMg8Bv6ntIS8/K0CKXWg04g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EjZv9Zjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKcMI26C; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EjZv9Zjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKcMI26C"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 660561140187;
	Mon,  2 Jun 2025 17:32:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 17:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748899957; x=1748986357; bh=McAWdmGzkW
	l86Zbv7VuXBDbeCoEDbq0AEDjQT11dHbY=; b=EjZv9ZjgWkuWLsjaYmHx+zY0N7
	j0tkpo2Ea6KRoVZ0lwxChtOIedOmQrDErfQ5K4H9gcjHx6oZYy9FhVOgkoM3QOc6
	kWSjAJaTkj3J219NgkQxiG9UNEDQ0V83U+IA0sh9Vs08PLSBhH1XcfYEfYrsoxcZ
	HCxDWcZca+Q2IDb1ScreaNvSQZlI96gcUBSFRB1XFY0S2rZUOJrEk0mCd475Xue9
	qB90iKqWm+A8JdtDcE5wA1mzzlF75Sr8cHLRzB3N90kmYmlJrOJfjsjyc/ntzPmV
	x5+MTTb7Pe4gybRBgai6OVJXsoDZnzJIZTZL7b3dYmEAcqhi70cBhPg1f7wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748899957; x=1748986357; bh=McAWdmGzkWl86Zbv7VuXBDbeCoEDbq0AEDj
	QT11dHbY=; b=MKcMI26ChO4TrN0pzcS3iJ5tSSg1VKX1OtmETiSjOADzzRpG78+
	AbgT+gmRbIx8OeqDKbhK2Pg6WCc8dvs28HPpSeFgh/GuKL005k3YMY6jHfU5jyTM
	S9yXan12ckZmkD5jgOItG3EdcNuEZETEZm20xKh3mOd27iVqczdhy6syymg3F42j
	hbI1csTnLes3TU1JXvDaln0zKzPPD6yrwUY/HvxaFFe03NHDC/pqXkngHQIc4JoV
	o3Q0f5CH2zJJJImNR/cdoPvx0vE7XpiotAYGMDelIvw269UaPAKzOV70Uk8fB6D6
	ipKkXX/053ljbX1MfS0atZOW5yXiaKqYVmQ==
X-ME-Sender: <xms:dRg-aE5wVo9p-N6J_H0HTXjSNtGxk2pROg2CQJeS0H2rveqQH6mqfw>
    <xme:dRg-aF4BkiSoRMawWFG4NrBZTUjtCbe4jS_f1n7S8oeA3m7IvXuWFQxWRAs_VsIc6
    kCXFA2JMFyHC1tTWA>
X-ME-Received: <xmr:dRg-aDdhbX2QcHQd95N-RlJSRdnfjF_BQY_vG4BJDwexmm3dT665ZXL-mBDRdVMXqCnNOIRDNbvlrtrAA56tQwO63d0k-FRe6IZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeejieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepthgsohgvghhi
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dRg-aJI6gUIWlIQe8lRUAe3DFpnGAZeCP6SW4CZQPsCZO9BSMVpnoQ>
    <xmx:dRg-aILggEKegMoliuKyOklHAIR_IPkMks_jgfbVh--a7MRjzlO7Wg>
    <xmx:dRg-aKz_Uk95LNj-fCn9l6yWTsl5QGeZut-kbrVKLIs3uscX1ZukyA>
    <xmx:dRg-aML1OKXBXpNvWPIvFzDxDbkcea2q0E6TdV5akWRVk0y7u1iuuQ>
    <xmx:dRg-aPiodMd-TSq8Em-9VUDMYNYK9zrKZqX54SGZu2Lck9SI6s-u7YkT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 17:32:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Git Development
 <git@vger.kernel.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
In-Reply-To: <f0d4c85a-b833-c52d-b54f-77ab81f22451@chromium.org> (Mark
	Mentovai's message of "Mon, 2 Jun 2025 12:08:05 -0400 (EDT)")
References: <20250523193722.68344-1-mark@chromium.org>
	<20250528201737.55268-1-mark@chromium.org>
	<20250528230804.GA16856@tb-raspi4> <xmqqfrgmhep3.fsf@gitster.g>
	<20250531054618.GA30443@tb-raspi4> <xmqqcybnxvr2.fsf@gitster.g>
	<f0d4c85a-b833-c52d-b54f-77ab81f22451@chromium.org>
Date: Mon, 02 Jun 2025 14:32:35 -0700
Message-ID: <xmqqy0u9subw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Mentovai <mark@chromium.org> writes:

> `realpath` is a library interface that transforms paths to those
> having the semantics at issue, but it's somewhat obscure, and easily
> confused with "real path" whose meaning would be entirely
> ambiguous. realpath(3) documentation from POSIX[4] explains the
> semantics fully; glibc[5], and Linux man-pages[6] provide full
> explanation while also using the term "canonicalize".
>
> "Canonicalize" alone is too generic, because there are several axes of

Yes.  You need to specify what you are canonicalizing to, and once
you are going to do so, there is no need for that heavy verb, i.e.
you do not need to say "canonicalize it to realpath"---you say "turn
it into realpath" and you convey what you want to say just fine.

> All of this illustrates the difficulty in choosing a single term to
> unambiguously convey the meaning. I chose to write a commit message
> that favored technical precision, even if it meant tending toward what
> Junio called "the more verbose and repetitive side". I believed that
> to be necessary to fully explain the background, the problem, and the
> solution.

Yup, that is why I said I thought your original was clear enough.

I am tempted to say that we take what we have from you and merge it
down.
