Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181D34CFC3
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691013; cv=none; b=Of7tZaOeAIo7iaFHaEIUd472Cbtl74frIqNz/GtOLUthZp+l6Hvop1QDCb7cnqx+g3QGz3iUbhsDAy/2iDXG2c5JjTWPI7duFOB1VG12AK5NfWslIyzYE6bUKebTxrBEIXsv04vKDKqO+v94ALQ/TD+RhSBAMbTHddRv6AfRyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691013; c=relaxed/simple;
	bh=JVPZw9brC0weBZ2F7Xop/eqpQ3kMTSaRMGwHB8ZfHRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nv9Hln+Cbu87DdWCM/TQ+2pkDMt/8kCy/OTUASh6B/8r+lZupngDNvJIQw7ELfe3o6sf+fVvND1ZYnJ0Nh0mShQiAjqmDlM0N+v/HQZD40T79TmDNAuR5SOYdeYTnDMXaKlzHmXvS+TBc9M+Ao2nGV40ev8VMTqsh8okDIIAtwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c4QjPvrE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8UWhP95; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c4QjPvrE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8UWhP95"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 547757A0050;
	Mon, 16 Mar 2026 15:56:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 15:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773691010; x=1773777410; bh=MthBZMnc3i
	Fr0NIwOGHi+PEZMCsiPqff3WM9iby8aS0=; b=c4QjPvrEU3GiYayzUG/KXlSKsA
	f3eU8JoX8/vHJY5Mum+Umw0DYNz7FEUe9KpCc0eHkSAv+lZyk+1vCCZ5N+lmYeiX
	5I4LDA4Ltg7JKgwlhyOcARcMsfNY0QzWmlXxF8x+i8NN1Nkreiz35bTyPedLVXnS
	fIk0Tv0z3wvvrSM1qMZwXxccRyuNi8g/gbdFw1XquBFcmipKF+7T8OMFubfNoV10
	lHKd15ajSDgFJZWad00TG0hSTXevIpKRG6ywpTCd3aax/hHi8b38EhBXkJXpGmCX
	MsfbeoBUD3ieRylPy3xwZqFQe6ZwCUVlglj7dCUHB2dB01l4xuwQBqqM3CuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773691010; x=1773777410; bh=MthBZMnc3iFr0NIwOGHi+PEZMCsiPqff3WM
	9iby8aS0=; b=e8UWhP95N8UZSwfTyFNbrkzUrM1PvmY/Uu1UDD+WemjenMlH84H
	YzFK64dXwtj9ynGG3MuayoIIiH3TSr6Gmu+X6Pgp8K+ERpv+ylavWHzLwVw62qT6
	/9fSpVUJHO87EyFsKIMJtR8feo+09Y+Lg0kDXF9Zp8vp9b0qiI/8QqDqr8yYGEP0
	2NkxjuDluIIYAyY2h37rba6Dc5HnvcvbF6kjzPx7/3DuJOzwKSVR/mzWWuxqwMnb
	Nz5Evk4iEjBhznQn8SWwDs+5Lc+AU0QN/9DeRqCZi20gmJQKCw+5MVMXciYDL4fz
	CVvJk1DMCrCrXidUNEdrUVpBmcdvkvUSIng==
X-ME-Sender: <xms:gmC4aXGM1mz-bK-rPQK8bujLNLf755gNGqU11Dakm56UCl99s13C3Q>
    <xme:gmC4af3kxTJF1a7v7vdHu8ozx0gRjw_vMJ1Xs916JLYQTgcjQDBoxuADGxq0yPETu
    nG4EeL9Ctb1xohc8nSrIz_BqWMTpLz5VkCYddDpMNUTcWAmWZ55zA>
X-ME-Received: <xmr:gmC4afn32m7-xA1-vzYnrM5eIR3ZD1z-4PhhjYoPCnnEkwf2w_gbv7BudB4I64QOXZQ3f_hKu8FK2c-qWiCR5fn1QjHjnk4ORw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    rgefvddtheduheefgeduieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gmC4af8Hp6p4ZkbCEbXh68T7iefIhbpZybBfMVA0M1rrS39i0Sgyww>
    <xmx:gmC4aUrbXT_5Pqg3iVGbwWx3MMWj7yaVwmGtGmvD6Wjx9XpFtFRFAA>
    <xmx:gmC4aYkibPgzGS6q1vNcoOZto_qUI7k2-tD6VmxvXze3siIOdsfK7A>
    <xmx:gmC4abgLz4iaD_nZq2hcez607jULTDybbfq2jlGUb_sMmhn2jX5O1A>
    <xmx:gmC4aXViaURuzZu_uFRePIqUFJupOKr9qDHWGvPZkxYTX8gj-OZcx9pO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 15:56:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Tian Yuchen
 <a3205153416@gmail.com>
Subject: Re: [PATCH] apply.c: fix -p argument parsing
In-Reply-To: <20260316005120.7079-1-mroik@delayed.space> (Mirko Faina's
	message of "Mon, 16 Mar 2026 01:51:16 +0100")
References: <20260313031950.1695103-1-mroik@delayed.space>
	<20260316005120.7079-1-mroik@delayed.space>
Date: Mon, 16 Mar 2026 12:56:48 -0700
Message-ID: <xmqqikavo8e7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> "git apply" has an option -p that takes an integer as its argument.
> Unfortunately the function apply_option_parse_p() in charge of parsing
> this argument uses atoi() to convert from string to integer, which
> allows a non-digit after the number (e.g. "1q") to be silently ignored.
> As a consequence, an argument that does not begin with a digit silently
> becomes a zero. Despite this command working fine when a non-positive
> argument is passed, it might be useful for the end user to know that
> their input contains non-digits that might've been unintended.
>
> Replace atoi() with strtol_i() to catch malformed inputs.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
> Sending a new version 'cause Tian pointed out that the die message is
> not explicit enough, and a user might not understand which option we're
> referring to if there are multiple.

The updated error message does look more helpful.  Will replace.

Also the post-test clean-up in each test is more thorough, which is
a very good thing to see.

Thanks.
