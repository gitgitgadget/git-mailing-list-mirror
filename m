Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157921A449
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290667; cv=none; b=YFYDDoQvie5gNtMrGjSmIqoXZY1EopmkoWCsSgaGOHETdthGt/XOEeam5/7KUCrzZLrbW6AaCLXeXOy3miVKl4MbzQSPq2YkT54dWu2kC5AM1kt2uy36fPs28Hkf39efJOLveC/8gC5siJzjKXSky83xYTg89gu8GsXyOXQ04ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290667; c=relaxed/simple;
	bh=20ucgKsrqLJJOheF94oIFPRPJ2T021x3BRon553R1aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0CzDjf8kdAU5AywcfwfMeWFVfBsP+gfVgoCrTG6reoZTxXwS2zuZHxPncWdI37rI0+cUiDsrdm9tLGBXNDWLFC8uMp8gjCoV/ZcHmKflCPlM8+ddCb9Yz5EBotJxUQUiPXnJuDvEFA8OicLcejsQPSImkl4hhV/+d+MguwehsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HmIfuQdL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjnEn4cK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HmIfuQdL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjnEn4cK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 25A98EC02D3;
	Wed, 23 Jul 2025 13:11:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 13:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753290663; x=1753377063; bh=20ucgKsrqL
	JJOheF94oIFPRPJ2T021x3BRon553R1aU=; b=HmIfuQdLPV8AQyA27pqg3FWuB3
	F48oshwKvUKFYnsqPmSP4AEUPBHot9/7uhCxRXjCOON1Wp8WyFLFsEewPzmpK/nt
	c4ye6PiggI6OBG0PuChgPLBefsyzxx3QD2VTLm5z10Y4IcjJTpbyQaC1+7EAM28F
	5gkHite+sINfbg0pRvms9d9evLa/WO6INOBtDl6JhAnpl6sVlHOrqjoWrSntJlws
	OvLfjpNrjmIRi9yAUXRsMYTQmBi8QKQYwNXbGgdsHEJMOLpis+RQlBJt/NbWlt34
	QZqtLXpxGYixhCFEK7xwSfuZu7iBaVMt+5HV1Wlr081UqkNm5Oav3RCL9a5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753290663; x=1753377063; bh=20ucgKsrqLJJOheF94oIFPRPJ2T021x3BRo
	n553R1aU=; b=hjnEn4cKR+o4803HnQQioePf/QCn/Rk9C7DxPnjAm85nHFmPQvJ
	MkhurCf7IAyAboFVrVBsknHlAQabojjcJzqXeHt+l8i5+miAMzRMOFd3g8qu5C5z
	cHy1QPELhfKfR3CrJJibX0+T0xgU9DJO1YPhWVEd8AEWvwz5A0fzqlOKfHNQz2FA
	9VkOT/q+2YP4nmllUhe9lvD/MvBlVx0QJN58OC/f7h8UBmwfvesb8RpPO4HAWwKQ
	KdhyDY3kwp1e2phjtCX3hEzTrVO35/NxgkGN9xK7g/9OA4dBxZiiIhh2wVyPh6Qr
	ewcCOcG9hRIJYgMwodQoWTVa4/bI/Div1ng==
X-ME-Sender: <xms:pheBaF5LhPSTgjwi7L3lOT-luwKQ-jKqf2TLpNpnCOKpLfQVuQUGXA>
    <xme:pheBaOYdxZnYPwbX1jtrJxqVhhIAZ4Ik4t_oEwYOkpixsI19jv4QtvGbgVBDby0rd
    G513LSZhw5obdOXuw>
X-ME-Received: <xmr:pheBaC6Jcxu7dRoxA4Y-1yYhWVwCO-8R8cwzgYu3vgdO1w3XE2UZiDPfDMCZmLXsbn-qdbOPTWi1E_yydv4KbNEEGsTU9Wmnrt_ysrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehlhhihfihk
    ugdvvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pheBaJB57gxXDeAXwijtrYdKZVjbVoHw5XtUtABpqx3cuWAA5nh5NQ>
    <xmx:pheBaAd8fbe4XhgCXRJ_qQQOvDr3Awzzw1OAGKVFEwXRhcFPC1LqFg>
    <xmx:pheBaAJhiZxMDXbtVXwlJoQwy_MGst4pkqC66oDHi0inv92t5OEM3A>
    <xmx:pheBaD1b7zQNpX7iW3kSImquSyvwkmEvlybP0fYh6EaDJfFfUh9CJg>
    <xmx:pxeBaJYa309w9tWmQNXLmfB7mq0s2voyUx0cTEP78duCq9pcRoHt8lSa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:11:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  Hoyoung Lee <lhywkd22@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
In-Reply-To: <CAPig+cQ2p3muA0-8O_u-rOW0uVGQ_ZE7hcz-7qq8M1U+PdvtpQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 23 Jul 2025 04:11:26 -0400")
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
	<20250722174102.1876197-3-lhywkd22@gmail.com>
	<CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
	<20250723075513.GA570540@coredump.intra.peff.net>
	<CAPig+cQ2p3muA0-8O_u-rOW0uVGQ_ZE7hcz-7qq8M1U+PdvtpQ@mail.gmail.com>
Date: Wed, 23 Jul 2025 10:11:01 -0700
Message-ID: <xmqqms8uomsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> For completeness, I'll mention that I even had the thought that
> another "fix" would be to tear out all the cleanup code entirely since
> we _know_ that this function will be exiting immediately and the OS
> will clean up any dangling resources.

;-)
