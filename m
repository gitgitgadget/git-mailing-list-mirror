Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB336D9EB
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302505; cv=none; b=kKfHc8PS5R8y3IbAh0S8sfxt4GLrgBTfTH9hY3JVzGEMYoO9wjszxdO0DSa8czBbE0INOWIMuBxxdkgkO6wm29rep2e2ZWmITFywcHF1W0N4IkHYr6rTdHfW9s3iQ1H3pIyRKnhAuSu3l7vTKOqR/rQ2uPlI8NhCqXKnUOB0BZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302505; c=relaxed/simple;
	bh=xxtYBHx6LSZlAhcJQmPRo+unbVstZe7nemrkQjZ+rsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHE8jCmfmV6ObVVYXoQCi3omjtSsAw0HMCVds48i3uIhusmv5mXa4vpmqJbpwIdTNp07Bzcwl2mmI4bcr2h469XNjZQUNSo7qqgV8tS2StMGAZqtKvCgN+XpD1aX+fsDOBIX5a5vUBTWAVxUSDWXWDwxUFDRzdU/dI2lJ4GEmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V7EQgyQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1T/tBTgG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V7EQgyQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1T/tBTgG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4B9514001A1;
	Mon, 23 Mar 2026 17:48:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 17:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774302503; x=1774388903; bh=CWlcOu33rv
	NtCxQSWt7TnDbud+g4t041gy7LwSS/onY=; b=V7EQgyQ7wU/F8kEeN60e8qZZPP
	o1aLSx+k0HrlRl9xppC7Kbz7z6Wyg1nbgHqBkycMUt5AJEJmm4KGKJxZUWp1SN/q
	clUWt59ehwfT8otEWmOB2MgXz8Shbiuw4JTcBBnT+a/1Tl3499Ln8oXUHpTCmkfZ
	zD7t+bSqX0TKam6tQg+8Pz5utyiNlVi8D4UKHbLWteR+t0lc9V6yGJ4H4MfyQGGY
	kOVJoYBZbmfjWGnE8nH5V7JawaVllHt7lJ10IPaWiTl93jpXczUCV5UwMPnm2ka0
	TLUSRKt4F88S6je+rkAWqbTgHJWD7+zBiZ6jn5nYFnAQrsLs2aRRMA3K3Vrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774302503; x=1774388903; bh=CWlcOu33rvNtCxQSWt7TnDbud+g4t041gy7
	LwSS/onY=; b=1T/tBTgGDRpP28AAm8HEqSsq5nQMhpXADbTAoojFZ6LJA7NFU9c
	6YBNt2CwmZ3VKabDJpdnT3kAGFcovh6oJIC1tnyKKD+HcGz2bSnnLJXm1fgMI7EI
	o7OIIfS9Jq+H/MTc9lwge6CYLYONw0cemowS6w2rv3r7aaqHhyH7ULqsP0yWqw9f
	y8R1QbEBz/Wy23LNyUAQnSRVKBp+oP4boBrZ5ofGZZyFIHbrJoBG4bZojk6XRMvj
	Q5gp4BciZK9GoM4x6CWArXjEVOsUltOTVOo8muTnmeMgQc7/wDKHbGPznPlHlJzF
	cWg5LjIaM8oYKBFMz6IQD89K30OSohBEI/A==
X-ME-Sender: <xms:J7XBaaw41UVJ5IxXiHfcrGw27R8eVMi8wmbywUAzSJzsQMjPMy95LA>
    <xme:J7XBaYitEbI9ldeCKa5ZZeN0ZZ0vr5_ohFZUiCBqMva22ze8MA5rxu_5Ne6SporZQ
    nNkBv6ua-e9M-R5Eup1PjJddhILSp5ds2pd8D3y2IGqnw5l_BeGuw>
X-ME-Received: <xmr:J7XBaenuEohgrvdckqoi6xP-7a6e-srSI7a15DLW18tylG3F3lLHTnk-V87UyaCw2nAnji88I7gCfw8nWMZY0_RkaiARHxdGeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J7XBaWh9MM69P-8c7OK4-OLUkREt5PHy2iREC87S5fBmsc4Da479VA>
    <xmx:J7XBaa2p5W4_v6YSwqUC4Ji4hQwDlcmd6xzgvpqLQjXKXiPjX-dktA>
    <xmx:J7XBaXIMBFIWXPgWmWKlXvfTLSKAHqqMRN2VkBwc7wU5FyxZpopAdg>
    <xmx:J7XBaSwU2lfwSDHMWGVxHxYK8pIGO5K2Z0W-D1i6P9S4ZYlEzbf4bw>
    <xmx:J7XBaQbPq9OfZTVi9S-BWKch_Ie1cQ8rOgSzNobUCPTqNqqkBTSEjcUw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 17:48:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,
  Taylor Blau <me@ttaylorr.com>,
  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v2 3/4] repack-promisor: preserve content of
 promisor files after repack
In-Reply-To: <3dab969a3942532f49f6f9cdcddb5fb2be11e232.1774205661.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Sun, 22 Mar 2026 20:18:34 +0100")
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
	<cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<3dab969a3942532f49f6f9cdcddb5fb2be11e232.1774205661.git.lorenzo.pegorari2002@gmail.com>
Date: Mon, 23 Mar 2026 14:48:21 -0700
Message-ID: <xmqqa4vy43q2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> @@ -40,6 +40,7 @@ static void finish_repacking_promisor_objects(struct repository *repo,
>  					      const char *packtmp)
>  {
>  	struct strbuf line = STRBUF_INIT;
> +	int is_first_promisor = 1;
>  	FILE *out;
> ... 
> +		/*
> +		 * Fetch-pack sometimes generates non-empty .promisor files
> +		 * containing the ref names and associated hashes at the point of
> +		 * generation of the corresponding packfile. These pieces of info
> +		 * are only used for debugging reasons. In order to preserve
> +		 * these, let's copy the contents of all .promisor files in the
> +		 * first promisor file created.
> +		 */
> +		if (is_first_promisor) {
> +			copy_all_promisor_files(repo, promisor_name);
> +			is_first_promisor = 0;
> +		}
> +

Here the underlying assumption seems to be that whichever one of the
two potential callers of this function, repack_promisor_objects()
and pack_geometry_repack_promisors(), would handle all the existing
packs with corresponding .promisor file so it is safe to coalesce
all the debugging comments from all the existing .promisor files
into one?

Is it really true, though?  Especially with geometry repacking
enabled, wouldn't a regular repack coalesce only the smallish ones
into a single pack while leaving an already largeish ones intact, or
something?

Thanks.
