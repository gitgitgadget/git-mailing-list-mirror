Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CC2957CD
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410873; cv=none; b=iRu4SVJ+PyX/FQnpk92baj7tQgWJ91hRRq2OjseO+2f6wvAplRL1iEelxDCeqzjUWvwSo4YfCT6uLVypw3kQrI/8MwdyscjmokBCQVbj1vzedfMfW4qDSWydoVObsvVLY0xH3GloyzKcsbaAI02L+rPFVSs6rRmCa+Mth4k4Jbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410873; c=relaxed/simple;
	bh=cZvHMHkfGFe18AfZL13MSJKdlbZq941xtGhGItiTtQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QjUpsM3ByuYpoGJzkdXLTizYssl3a01PW1NwiIFOCgVTUuy2Qsl9sApZ/S0hnzEc2n8cyfEH4ht83Jup5kqVsTTt+r/C5XvVMIBX+0Ur08gi9WhgGvrqz2wJccjaqQmPmkMZJF48Bv9anMoRKrwATqGT1RIc8BJDfGP6dsoJmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pk1m5fxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czzRtvEn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pk1m5fxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czzRtvEn"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 6150A1D00013;
	Tue,  5 Aug 2025 12:21:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 05 Aug 2025 12:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754410870; x=1754497270; bh=fFrnBJD0I7
	MH1TQqI7OBSBRwtmvBLjXAwdn0AcWkDss=; b=Pk1m5fxLF9Ken1DVpwYqvRrjTs
	f1N7/pR2PSg0kJcTvkSPNyuKEQFLkrIUNgwRMVaG+eQsbSS3GfC1c96+7bQ8k3kq
	T5oGtac25ziLYCGR2aXa8q2j0hYWaEde1Fp4NWZGYhjEYRN8ASs4uCS0glnkP4gm
	gvALK61hKGaLAM4sdfnE6GEypxuD4wLOaQUSbfewSobmSXI3Jog6GeVhrk3iM6bQ
	CxLttdHykW9OECcxroZuJLWCGwjcUs8TKAWgK3wEEr8FyjHLh41JbD+DBGM5m+PB
	f4TOZcrqR4qYNFjnmSvBdV9Ya+yjkrj2gm+y5QjdnuW3AG8jA60zmEqzK4tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754410870; x=1754497270; bh=fFrnBJD0I7MH1TQqI7OBSBRwtmvBLjXAwdn
	0AcWkDss=; b=czzRtvEnNcmmG48sX8Z/FXXoPVVDLqdxeYZ+NfjwiKB7H+3vOIx
	4oIYrpSoAE7oV8LaGIi8BzL2FoAhcJrWKXCY195fAOCrH5sR1h1xGg2c/b3GUJqt
	yZHHmFn4Zwc/FM03VcF8Mlp7WS08aTnA0d9Foq0hkyYYUT4TqbXScbQqXDCqf12H
	3ZN1DYRXWIzD4QaQK8AzEI8pQ/mpHhGZzqCrPcnryZM5UhHHv8HRxEuUDNMrOEi/
	svLX/yH37GR7OZeJey+gH6Xp18pMlxdzJVaD0VhiZrkW334y7JPIFKpegaJTGGSu
	aqhQQrmoi1mO0c4aFK6qfrT0mKpdSBR73Hg==
X-ME-Sender: <xms:dS-SaJ_TaQcF1XUg-_K-WAxRrM8mj5x231bRBptP-rnLWpbYlSXT-A>
    <xme:dS-SaKnJ4buduxBGV8iLr03tRNe_1_Ra27qSuxwDubCHWMAJyG1Jo1psjZvt22EBz
    P9LZlnY8Yl1QifY0w>
X-ME-Received: <xmr:dS-SaGxoqV0g20qxmUinjeALO46tsWBU7UPTGIdC4y22Z1OIVqIgRo60P3ReLJSFrQomJkk_3gXyqqgokQXzMaMNMis1hPM3jf1I3Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dS-SaM6tAoJFVCmcLxT-uqarFwii1qrCd3l1EoUWpx5N7f2FgIVZDQ>
    <xmx:dS-SaOXK1LKGDbS7emJtADJjrSSQhs3UyoVb5HOfctucN7Ly7q668Q>
    <xmx:dS-SaMIdB70tO7nFi0FgaQ_hhYQAix_TFBGhhQLz18p8hxDFqS5nIw>
    <xmx:dS-SaIveZwOoVRBUkluG0eJAhsUNzIOZ8TD1r1U5LRcCsA5K6aCPQg>
    <xmx:di-SaM8R3Fu5Cna95JZFTReuVHxbzpPUSkwrbszmz4t7ydD3WAjrYK0N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 12:21:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee <stolee@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <aJIWfLdMOqEL861r@pks.im> (Patrick Steinhardt's message of "Tue,
	5 Aug 2025 16:34:36 +0200")
References: <20250730175510.987383-1-toon@iotcl.com>
	<20250805093358.1791633-1-toon@iotcl.com> <aJIWfLdMOqEL861r@pks.im>
Date: Tue, 05 Aug 2025 09:21:07 -0700
Message-ID: <xmqqtt2l20zw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 05, 2025 at 11:33:55AM +0200, Toon Claes wrote:
>> Changes in v7:
>> - Fix case when bloom filters were used and a commit range was given. This bug
>>   was uncovered in CI.
>> - Rename the long option for `-t` to `--show-trees`. This option no longer
>>   implies option `-r`. And resemble these changes in the documentation, with a
>>   few other small documentation tweaks.
>> - Move prepare_commit_graph() into get_bloom_filter_settings() which no longer
>>   requires last-modified to worry about it itself. This is similar to
>>   repo_find_commit_pos_in_graph() and lookup_commit_in_graph()
>> - Bring back the call to commit_graph_generation() in maybe_changed_path(). This
>>   is also called in the same function in blame.c and in
>>   check_maybe_different_in_bloom_filter() in revision.c. I couldn't find a test
>>   case that triggers this exit condition, but it should not have negative
>>   side-effects.
>> - No longer call diff_free() on the copy we make when populating the `paths` of
>>   `struct last_modified`. Because we weren't doing a deep copy, this could clean
>>   up fields used later on by the original. Instead only call clear_pathspec(). A
>>   comment to clarify this mechanism better is added.
>> - Add BUG() call to exit condition that shouldn't happen.
>> - Switch some int types to bool types.
>
> This version looks good to me, thanks!

Thanks, both of you.
