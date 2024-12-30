Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7733C9
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735578521; cv=none; b=V5PjLeMwVrGXWQYdasTJXQTXL8dUn91IqLT5OW7tAEF+HFnpDgtc5p2C7hDsGgbaFBebaBjwSUI+oAcbMJcH1oAR7kkT+rcaFhBRRQzALFBxQYaOKaqvdmbx0NWtqGPbXNzoYX9LoYQ+TktgIexaYOXD9Ri4xG1hsk4Hy7DWkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735578521; c=relaxed/simple;
	bh=KNRzxVSl4TZKHLvppaYqw7Mc7O+/1ofgxsAmFI3yv6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1lVjgT2zY80vj+T3RrC6+xoGLKUlYyXyfAtd5OfJeOYom8wLJJi/RT9ACMSDS0+ci88PqKZWSMgN+3wYAzu9IDJb2QlsmxbY2yLKoP+Et63SID0gEUbYBiHOco9dGF0iv8iLefOupEpD1gdYIkqjhk2j5Gme1bPZu+jy4yhJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KkUkDfgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSX6Zwo2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KkUkDfgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSX6Zwo2"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0288B11400A3;
	Mon, 30 Dec 2024 12:08:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 30 Dec 2024 12:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735578517; x=1735664917; bh=roD5qBfPVf
	R9wGClsPH3flwVgQnMK9tMsPku95QGswQ=; b=KkUkDfgyvnGczRYvWSMarZU441
	EQMstjDf5bvU/Us+m9YrzWVnPHKKQg9FfEuLPkeg8HfMknejsMWwdDzgX0H/EESX
	hgFbZoWA04JRZAW8GgkRWUjz7fIJZijhvtblljw57KsYL2InyqkqtZU9kWmrEoHQ
	CbEk6QgXM4SPiOphZ64tBwMsufBpWYbTTiU270uxoeHe/FHMbFGKn5LKy4nfF8QO
	SN6VHvJnUJKb/M8VZlyWt1EUG6XL4jj5LXeM4NuTIKhHHTNTHilem0opTt1EBYhT
	WJzuZpW/P783Ou6XT4iwG7BblCryISujNG6r2wrjgVhFMpyhyBJZh/GQO3xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735578517; x=1735664917; bh=roD5qBfPVfR9wGClsPH3flwVgQnMK9tMsPk
	u95QGswQ=; b=ZSX6Zwo2oxF+bPT0t/IrEM7RgtHN/P3Ru0f4ia5nIWpmtrIxWzU
	w7LfofAJQP72IqFROPHiDujchnORwFYaGADvbjlJeS4Br6OBjGta5dQj6Szl7nvR
	7yYVrGl2ReUbaqI1wZFL7UjIe7vMPLaFs45FwCt2VUGhO6nVt9sVgQ6jgivaFf9l
	gIYhjBJ2Dj4oe32NXCAytiwPFgtDv8u4wwxfxjuurt9frIGgCAFBM+Oxe6KVsSuW
	5EhYl2RGbmOU1wE4gwAENZL8b2hBWtu14qGAAT3Q++QzOWdPzMW+0lphXEcZk+AE
	WQlHlRdqIloHtPNQJgyCKhnofi3ZN1nPGTA==
X-ME-Sender: <xms:ldNyZ6e7Q0wDTXAJf911tnTIYOmWsDbsmJQBd2uvHSRwYictXmL0bA>
    <xme:ldNyZ0MMWWsvnlWkGpn3s_oXXW8CAAKlPqaHEmcQu9Q8M56CVpt4IwqD-WVYhthgB
    mE9kKtuLKTJ3yBWWg>
X-ME-Received: <xmr:ldNyZ7jCEhWFoS_2Zgl4pVVSmkohl0z-8RVJ35n00gYsr0uVSKA6PxxxITRfXJafLGdsPp6fv1ciaXRN04Cs9TwlzRVtm4B08g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ldNyZ3-kcSqZcdtWAiFhlgm9e3ehv3xXvwOdT_Ckct8KMvMwLNeKhw>
    <xmx:ldNyZ2vohC8sFErYGo2iCrw8r6SBKJnZEvzYBGacc4z0Voa6J9iHqw>
    <xmx:ldNyZ-Gz8THMau7nzTrI1xbCXzagG10dJY9hJFUxm9mFFCV_lR9uIg>
    <xmx:ldNyZ1NOj89W1yZEA4MQi3ItIw9Syt6LP_E9sI-k4Ez0Nt6sm5elow>
    <xmx:ldNyZ4UdxzL4ysOru9PnkBNhz1DEVEqlCSwKwTY2rQJwbNC_lMVOy_0E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 12:08:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 1/5] test-lib: use individual lsan dir for --stress runs
In-Reply-To: <20241230042401.GA113400@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 29 Dec 2024 23:24:01 -0500")
References: <20241230042325.GA112439@coredump.intra.peff.net>
	<20241230042401.GA113400@coredump.intra.peff.net>
Date: Mon, 30 Dec 2024 09:08:36 -0800
Message-ID: <xmqqcyh9yu7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> When storing output in test-results/, we usually give each numbered run
> in a --stress set its own output file. But we don't do that for storing
> LSan logs, so something like:
>
>   ./t0003-attributes.sh --stress
>
> will have many scripts simultaneously creating, writing to, and deleting
> the test-results/t0003-attributes.leak directory. This can cause logs
> from one run to be attributed to another, spurious failures when
> creation and deletion race, and so on.
>
> This has always been broken, but nobody noticed because it's rare to do
> a --stress run with LSan (since the point is for the code to run quickly
> many times in order to hit races). But if you're trying to find a race
> in the leak sanitizing code, it makes sense to use these together.

Makes sense.

> We can fix it by using $TEST_RESULTS_BASE, which already incorporates
> the stress job suffix.

Thanks.  Queued.
