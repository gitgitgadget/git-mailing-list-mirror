Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BD1BD034
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823508; cv=none; b=JASI3hIQ76in7UOX+B83I1DlkDQ1CR5mpK+RT3YkRcgaYGY84CEA1MPT4pdeLK/af6Fo3bGh7ryfmZpBBYrsXtr9KYhHd3nSytfvYwKMZYw22ubpoBVKy8wjl8cN9gHkIqdIu2kdisjJ2eFzwxMOay2f1QzqnxaU/CZR7lrube4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823508; c=relaxed/simple;
	bh=KoE9/A1MiWNIIDmmPS1rcZgngSsha9ggD42gQdOtyc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WZGP4C49o53jD2JGWblfWJ/31E1cgrE1kA6gtEF3nrXaHS0S/pHPw8R6gijJnDuiBnM/axiWwFbbf6VXLIrdP4wwKmhMy1CnkhFgQ4W8bKFzxwN3N1oUjr6+WaKvPsNWDUMkpa+0ANFPvmLphYFAZBfjZQlmzl4BMOtbvElpg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ipsCXQlp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZmaNSvNw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ipsCXQlp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZmaNSvNw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E073D11407B5;
	Tue,  1 Oct 2024 18:58:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 01 Oct 2024 18:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727823505; x=1727909905; bh=03Er9kXxWR
	VIylzlORN6+BnxoN6QwiiBu25WaOPWHL8=; b=ipsCXQlp9CUexHkx/A+EaT4uSn
	sKbsJbnPZS79GK7Nogbba22w8MaIsINsmKrfOqNImsjksBV3vrJpnSFyP/hdJjct
	QlQIliPPyooJCLU4OKdLjgwf3v7AGewuzn0UB+bmUX0JhaNNtiEurAXWAHVHcmlx
	/aRfrxMBQQOJT/nSBq74V5lihvvJ2zgvBE9tLmqlJIOVb9R/90AlvXc2Ur/gqskh
	doj/r1M3esoj0ZJztKjxrd+fIHFun4GTR73RtB70Qq0ZpIS41tU5tPK/L90xDVHl
	5L4Kail9e9DL6SInEI0HwnWANEDN0fYLpCh7u2UM4VJnsQ+HRxHU3ABw67Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727823505; x=1727909905; bh=03Er9kXxWRVIylzlORN6+BnxoN6Q
	wiiBu25WaOPWHL8=; b=ZmaNSvNw2yP79RHFJcY5r2Y7Xiqif3VpIH6JA6dyU18b
	/q9oT4oMEnIwEZrvEk6gdbDf+Td++e40L5YklE4dxNGN7nV+BeG3cVWu1Qv59xwe
	reEElgi6skLDj7dsJ8n05FwBiES8UC9VGthFOUtFgLxMbbhDDlzvfURsS8ToQVha
	IsXnMc/TJr+jr79F+jvcchutyvQeLxbTq/ll8NzAro4jHklIft2HBzmJpZZ7Gded
	d5YplQrCTV9DKpkuiZxsI9cc+lgPaCFc+pDWk8R8CTMrUgvGLHbqEsxiG449lC0F
	LbV3mOiKTHG67Sg2pFdmpyiHuxOs009orftjjebflQ==
X-ME-Sender: <xms:kX78ZipsekNUs0IULNOa-DRmW-KPBbvNHGvlh-xf86LXz3ch3rUpuQ>
    <xme:kX78Zgrm-yLC-LZuiwswpKS3S1wTEOeZoF5k9cqFRVCQ6WAhUnFePgQtjr5lrXcv0
    aMxqYiZuHDbUCePGg>
X-ME-Received: <xmr:kX78ZnNGhupjENcb_RJ6VFGih0aP0WfcCG94hctuFzajx1TxtWArHjClGxB6dNZsX07VdWGK5W961wGatzZfLuBhCTj5ojr_blxsBA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kX78Zh69Xm9dV8kptGTA3ojMpRv-KPo-_nVEInMXv1fZdzWpFPiK4w>
    <xmx:kX78Zh4-KyEhQ0CuzfGvMEvsB9FN3y4vqeskgYJSxACYxmYcODNVRQ>
    <xmx:kX78ZhgDx8Hj-CslOekVP86isMVkpkT_lekpdwd7rJyi-4euGmPQGA>
    <xmx:kX78Zr5yQWsODBIcP_nfRr4cThbO94zOFRj8d4dHclrvbCDHHz6scw>
    <xmx:kX78Zk1bG2anYOKcV-MUWtosiFQvm7VUzzg6YzTuV9NlnIxozvUkXXAR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 18:58:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #01; Tue, 1)
In-Reply-To: <20241001225113.GA2317071@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 1 Oct 2024 18:51:13 -0400")
References: <xmqqr08z254d.fsf@gitster.g>
	<20241001225113.GA2317071@coredump.intra.peff.net>
Date: Tue, 01 Oct 2024 15:58:24 -0700
Message-ID: <xmqq7carsa5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Oct 01, 2024 at 08:51:46AM -0700, Junio C Hamano wrote:
>
>> * jk/test-lsan-improvements (2024-09-25) 3 commits
>>  - test-lib: check for leak logs after every test
>>  - test-lib: show leak-sanitizer logs on --immediate failure
>>  - test-lib: stop showing old leak logs
>> 
>>  Usability improvements for running tests in leak-checking mode.
>> 
>>  Needs review.
>>  source: <20240924213404.GA1142219@coredump.intra.peff.net>
>
> I think these got a favorable review from Patrick:
>
>   https://lore.kernel.org/git/ZvVtcJOsbbrnWukB@pks.im/

Indded.  Will mark for 'next'.  Thanks.

>
> Obviously they're not urgent, but it's nice for people working on
> leak-fixes to have them as a base to work off of.
