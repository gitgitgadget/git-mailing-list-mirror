Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E4253B43
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380541; cv=none; b=jaXwSQVaTz4h7i4UDLELwk7Yvdux2YlWo4hcjxeZSTKDisNtn4O2rSikC89RV0ZcmFBQs2kqbc5W5huZ5cG3ZPoLjggSBIr4PkLKjikIsa0krKK0kTvuy45O1X/7quP7o7yD+gZ8i0x5zJUu2Bf+qMfRfKRQhu0n8WGBVKXDrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380541; c=relaxed/simple;
	bh=uxnBTsVqlKQaia67tH8bgUb6Ch0T5e9nfC8R9zLC8D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=agNPsaOXaKIiVUsYlZOoMDW5C/6ZM3XJDkrlLXjtoHaw5gP6L1qxlCRYaKrPNfToG+qGyf/CxgsZtgU+usDKtYmq+PTOVc6RROFIc/Oe926evw29pbTXxbBCTui0bCGqWi2Uw3vfXQwK5xal2hEQj86zApS4TWw4P/j1yerl+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kSBRPE2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3e+SRZYk; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kSBRPE2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3e+SRZYk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AEBDD1140142;
	Fri,  7 Mar 2025 15:48:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 07 Mar 2025 15:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741380538; x=1741466938; bh=AalRFrXawK
	Ad2WUaGuB8RmZDmcJx2nJuHN4Ne+dxvZg=; b=kSBRPE2iwEydBvwA9opVSneXB1
	9t2J1QOrlf+kgzC/uD/8zk/I7DSKZ19sdkFLO8Z7UvSndsOI3d/NA7kv/IS1XUMk
	8RuLJRg3GdnYpOKg51bbeGvxIRWC9BKu508qqHGYqN2RpzQvv9c0PHR7rhInZ/rO
	iEf/VVQhV8mYAvPPlXFo7zhKC+uViG1Q2jWJB3+QwiiPauMdEVY9DqOtcfjXjxci
	Y1sFWYVBcHsGtF3izyvcZAWSEo8vtKvU4+jWTHzWc38svWVxBqTidiHSWHtb34DO
	LBjuJIbYbAxKHYIM8fwVb+Tr8BGkAWqgvqVXNejnY+v2CrbSFGz22lFm7aBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741380538; x=1741466938; bh=AalRFrXawKAd2WUaGuB8RmZDmcJx2nJuHN4
	Ne+dxvZg=; b=3e+SRZYkDey9uKwuqg0dlMn0lx+qYUEuCAwNJVb/Oy0TWPCbcc2
	EX0zGT3F/c13J5rFhHfbqQM1mvB20302U/vlQLaIzRVRDspKxpATqVRE4+v/ZGIG
	aWqiJLHZPomxFH50z8M/7ymspjvCq/KB8T8POayYih9tZjmY2KaA+0TIHKU3ZGw4
	rppb9yAySlnD6a1vrh5WxzFd2h1cLK1zMuUg2exKq8F6sGeD4vieWEcvDpfpXnrm
	bZRw2ki/AtZvW9btgXsy4z6dwEMZ/7CX21m2cp6UsJOqJV7ArRw3OpqdpiFyW0gr
	vCUxHrMhXCMzedYRdosckirL4Wu/DwsnqIA==
X-ME-Sender: <xms:ulvLZ55Jof6UP1Unk0hRBqiAMPlRNOuIE9rrbR5fhnyvwivktxNyXw>
    <xme:ulvLZ25obnycpue3JNpMCSDg5pXeHh9IxCgF8n_a9m2NDuPvWHImDLycKavdZHR0A
    QCKbPdFBV0sCS2N0g>
X-ME-Received: <xmr:ulvLZwejnc2xtoL7jFD525oTKM89fJv85jzONbh7losjHvwmCg8Jw8IXEar6NTPUgA9yQflse_4JwEdwa1KTxdgablZkTK5RGhEa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ulvLZyIg7s13NCLr9Q-h0xuipdmuuYQS6tbbCu2LASTxKkzB7f3SSQ>
    <xmx:ulvLZ9L-3fbkxRuINkk9Nr3BumJFIGA3PQh5rxRlOCF2nfesEReH5w>
    <xmx:ulvLZ7zH9BU-YhnidZ7zDpiwO4kggrSrJmBxwdlMSmCcynz_G5QX-g>
    <xmx:ulvLZ5KEmeBuVVm7dgoMT5IGbde1I29cw31zRS8pfEKH4ZaJS4xYXg>
    <xmx:ulvLZyrqGvlrmyPZD_w1pOZUIn7nir09kfTSBY7-pfwo_iKfh2Gw_WKa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 15:48:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 6/8] refs: implement partial reference transaction
 support
In-Reply-To: <xmqq34foefh8.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	07 Mar 2025 12:46:27 -0800")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
Date: Fri, 07 Mar 2025 12:48:56 -0800
Message-ID: <xmqqy0xgd0sn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sorry about that.  It shows that I lack the bandwidth necessary to
> go through fine toothed comb on all the topics I queue.  Perhaps I
> should be more selective and queue only the ones I personally had
> enough bandwidth to look over (or have seen clear "I looked each and
> every line of this series with fine toothed comb, put reviewed-by:
> me" messages sent by trusted reviewers) while ignoring others?

I forgot a third category.  I should be able to queue series by
those who have track record of being meticulous and not have made
silly mistakes without reading each and every line.
