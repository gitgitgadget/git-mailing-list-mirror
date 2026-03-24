Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5C3128A2
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381708; cv=none; b=SNMpouKZhsJc82DOX+QPPl59YCMuy7ihWLl0hkWYIlX7CKDu9AC+GTnDuCxulxsKiExvcdYbah3P4yDSmwq6V4qOmfMNpE7mp74MG92TV5CU1qL0JwIWu1Z9aUfNbbaCl/gf3IGcPlJ0Xo4ycbJ4vUlmq/Mj63Gu7VSO+0i0aJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381708; c=relaxed/simple;
	bh=2P1GYQBcOY+A1VK6L+Rtbu+RJIVtK1bBjagM+2+WDds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lb474vUpdw6JJsPGtpUFdptydkFFoQSIR2bOTukdYqiXvtqth9FO2OKIGuH1AS6Xq2xWxK/eRIIIXLr5fAxyFEt3a2Fz3MLglqMkxZEVwKPE9If66OQ64dKHNvp3x1bEzO+GlyyLdMWVnVyiVhlQOJ5/u8IaRhvyXrW3g8RvrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LQjRTvS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3LIqVJRs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LQjRTvS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3LIqVJRs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69EFF1400144;
	Tue, 24 Mar 2026 15:48:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 15:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774381706; x=1774468106; bh=qieVUMR8vO
	erwNT+8gM41LSRsmuiFgRwKs1063yR52s=; b=LQjRTvS8zJ3bAUxOgxm097itUO
	/E24ZFbw1rxjCkqXBaSckTKkHnz3w9KBDw+hhBSxx/9yrELq1iFs7pnAEwYND1n7
	3vpo/BYkvxZnkPJXxzfM4hVhFXFXjldznuFwyByGIwGVG4m1cddmthcH3ZfjCw3w
	4VHINaacdmy+25X+RSV3jssSHQv+u8i4Y45Nsp6cse0mmQzV4fAs0mzbXhQVI9nT
	6xzCAZVAvqo3toVyHIb5zWZvSu3FXg8lrK20gw7zef7rXxI8Aa3vDCrMasaSzF2C
	IVhJg4V6qt4FCcPLouiPg2IKLLIwVAvQIQOFRE7VlwFqfDWunQdYOHBJJsRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774381706; x=1774468106; bh=qieVUMR8vOerwNT+8gM41LSRsmuiFgRwKs1
	063yR52s=; b=3LIqVJRs53f5YSx+Wi5hJEgiPzxh+f0n2xQRtT+fKqyon/b5tNt
	TlkQdC2uRegDJ5fmZBIBReAfByAmLiusNb9ZziKkKFCRGqof+zo1TMWjyMhk1LEH
	kQoqe3zRMNn66cjb5Ap9exBguVv919HXXZwmsPSDsD4X+CSOewW4UIVVUEDDFqDg
	fzGwva9mwvhIZYNaBPl5sDK+m48ZIcETaW1nHCYVkoe536qtxdZgAkpp8cIqyBV8
	4sSbQctpWgR5kI+Qw2ooFIBJDwAU3WDZ9c+ewxIO1/it8dpl34wGqbhP08tj9dor
	87t5BGUufx819P48IJISLE/DjEeyYjfqj/g==
X-ME-Sender: <xms:iurCach47-P3fTOMUyZucp7OX6cn5OcQqCvH-P3ikr-H0TvgUG8wXA>
    <xme:iurCaccUrK0lYGxrwOH6dYXcsPTVGWyMFpc3PIBAMyHeEd79H6Mjr05Nw4y-wAhvs
    BU6F7_l9URVOIcX0XekTFkfh227SWOUZe_FZ_dhNNy1qV_SfG7pXA>
X-ME-Received: <xmr:iurCaRer4XqfajMeFHTY68dhSnSr0OYeIA2fR9zngyLHujwJBa3WPmPGszZl0_JmF60RfAiiAnwHo_-gz03B2dkC2JsddTfQTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iurCaW8Gy6W9ZTGUN3nw1nKbu3EinTKxoUj4mtpaa70chs1SPH0z8w>
    <xmx:iurCadny7pkBzvd808H_b7zcXTTjOuRZ3DwTgifiJ928WrDvGZaKXw>
    <xmx:iurCaY_diVHpM24hS9SVQWo4jXgzBSxd4jJF0Gxj05fD-5OhjPO89g>
    <xmx:iurCabnZaETCBLCXGRgp7HxvSaysmKBjgGIB_FUD0wjZZu_QeGDJqA>
    <xmx:iurCaXNmk1JmuMLMKtv-pwdNwgaGYW1uC4ggSkBNwoXlSfBAIRhcBeu9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 15:48:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] test-lib: catch misspelt 'test_expect_successo'
In-Reply-To: <20260324193514.GA1870130@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 24 Mar 2026 15:35:14 -0400")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit> <xmqqo6kd18sr.fsf@gitster.g>
	<xmqqcy0t178a.fsf_-_@gitster.g> <xmqqmrzxyu2h.fsf_-_@gitster.g>
	<20260324193514.GA1870130@coredump.intra.peff.net>
Date: Tue, 24 Mar 2026 12:48:24 -0700
Message-ID: <xmqqy0jhxb3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Mar 24, 2026 at 11:13:26AM -0700, Junio C Hamano wrote:
>
>> In order to catch mistakes like misspelling "test_expect_success",
>> we would like to eventually be able to run our test suite with the
>> "-e" option on.
>
> Using "-e" makes me very nervous, given all of its quirks. Granted, most
> of them are related to it _not_ kicking in when you'd want it to, but I
> worry it will create false positive/negative headaches.

After looking at a few scripts, I am not suffering from such
headaches yet; it does not look too bad.  I'll stop this effort for
now, but with a handful of patches I already sent, more than 80-90%
of the entire test scripts that I run are now "set -e" clean, I
think.  Note that I do not run svn, cvs, or p4 tests ;-)

> In the past I've caught errors outside of the test snippet by noticing
> cruft on stderr. This is especially obvious if you use "prove", which
> captures stdout and gives a nice display (which the extra stderr then
> makes uglier).
> I wonder if we could automate / formalize that.

That's a thought.
