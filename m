Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225018C035
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284193; cv=none; b=j/n+GgrUvXo9F+qIf9GQ2rMpSqAn3DpEm70ymp3gJIcgwLWrPMvegQhDxiXesSXXtbgzF9JRx/2Ss3UMtNlJx//qhr/zHAA5UEI8ngXh2JoRSPrBqEV7WRbEQSoNCYV95rEsZccodYB4KfwQ1Yv7fVF+3dGj/YG+kdgN+f/54FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284193; c=relaxed/simple;
	bh=3xUW7yP4TjSyN89KNnjcEsCehIJppq0NmHF/wwAJQfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W77zoMCtnSt9r6JX0hZoKd7HLcRC18jGIglAtU40BjTnuMYfv5z1z71YPPOl4wWNYBSB6jZsjq9JIoMWmMfZSDg1uOX0izUM17emAq5TcNmAYPwUpduyOoEDntdHqbtR9P6kbMzOGhEfwGsSuKONVUIl56XnczK5KA0oKaJzASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VRI9gP2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sb0hBrEt; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VRI9gP2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sb0hBrEt"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1764F11401B2;
	Tue,  7 Jan 2025 16:09:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 07 Jan 2025 16:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736284191; x=1736370591; bh=zIYS5ouzzy
	R7jUFUlNVskNZVFEHbrnFJ11Jb7yWW+vg=; b=VRI9gP2edEAtreHxuiylh6iecR
	khsKpa/ItUIPxUxl0466W5TASBur2Uh/RsWgDZe3GIUBzY4G2TJVfhBLuYVW2VnA
	s1lfs9RipYgVmD3S7bn5v5S/FypZ8bmm8B7p+sUd2DU/hwrOdylSv/Dmz5QZzbpW
	btpaXhFE6t7mPahO9SYEcfvSMa7wj0IGWWggaG6QxQPx5OsiQyLLvGrQISf5NoKn
	UOsv4Z63TWcePXbnRak1zm5SO+sMWBkYlSPnuy56oYYdkVjzGW2+Cc0qgmuI1PbS
	apehArqum3bf+rOONkaXFnZGikKaKXt0Waz/zU0VnXqZCSMqJwtSsOYV+cVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736284191; x=1736370591; bh=zIYS5ouzzyR7jUFUlNVskNZVFEHbrnFJ11J
	b7yWW+vg=; b=Sb0hBrEtcufzdIFAX6lY2T0M9c0bsWqsb1lkdKmozPlcHmG7GDB
	PYbueLZVr8G93g3Ivpatrjr0cFGyhUCBJ5JyTCRa4HA5TS8R0lAy5qTqD9rNhe5s
	ORe5K1SmAg4voEXLVEjhaAxskLiLNyQras3noRCnMSY0GOxLDc21Kx5liUQyqhZi
	jKubGBYAUK1aZLf/Fzcwrjbp/Jfdl0pM2p6buNu4N0dLmoyv6p8SKls9f/avqVVR
	Qx2e7HK2s3vT8SHIFUUJMsYVEd2+/IzpNCe/C3p+z+Ln2cO/z5tyBwRS1BEIQPNw
	KlEfiabVqZ4uyrrP0GAqy4f4cBshkZ3sqew==
X-ME-Sender: <xms:Hph9Z0Q16S4V1plI8W8jdaIOBKAaYuoQHmVq1pinjk_zYQCqausUqw>
    <xme:Hph9ZxzizNm6RZ0u2LjAfVip7A-WOnCTQtmg2d4YJuXCv4LppxmkE_FTLLZ5IpStR
    wIDAB9mbclQvDafUg>
X-ME-Received: <xmr:Hph9Zx3GkYDPrmjuWRu2UcoOs20YdHnL1plY5pgBOejcDB9GcG3DRU2EpQtOtrrxOd2AyIuNH0iWmFEhKoZG9d_ilhcoIRXn-g_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrh
    esnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghnug
    grlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Hph9Z4DUrsO6oQPTd9iurquToYE9ulK5Y_T3WTm6apwC2ETdMbsVPw>
    <xmx:Hph9Z9g-n4ZFQe5B9DlOdGpw8rRsrQSBmWppJrYJxA1Dcze1lc64Tg>
    <xmx:Hph9Z0puSiQFCOUoBuy-mYWP-yykxiE8kkw_ZzLAOG48UL4VhlwHnA>
    <xmx:Hph9ZwgDnZ1s-9caksdFTVR101IEQJRZ15yx_UHduvftTs3B7DhdWw>
    <xmx:H5h9Z7YdtvZK3paduVJPEDTii6JSwrcoo-amjfrPvVn07ygMAiAA6zVR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 16:09:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>,  <git@vger.kernel.org>,  "'Randall
 S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
In-Reply-To: <007f01db6147$90a24ed0$b1e6ec70$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 7 Jan 2025 16:03:07 -0500")
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
	<20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
	<xmqqzfk2qr62.fsf@gitster.g>
	<007f01db6147$90a24ed0$b1e6ec70$@nexbridge.com>
Date: Tue, 07 Jan 2025 13:09:48 -0800
Message-ID: <xmqqmsg2qqjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> I don't think rand() is what is failing here.

Yeah, sorry, I misead the patch.  The problematic one is git_rand()
in the latter hunk, and I was commenting on the other, former, hunk.
