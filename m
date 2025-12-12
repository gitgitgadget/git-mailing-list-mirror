Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9404400
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515903; cv=none; b=JTnRq6elxcezgjewbbbB92jBU1MdPqyTO6sTEGMs3+pIajFLWcobJ6CnFYYswDIfIjVdissVPg+Nj40yEhiUD986xObwYm5rdlJPmocY7wTPr4RKeaVb+3oPEeVPp2CsjRj/1DfJn/s8nLTqckFxKOTNTLlXKPb3ehDLoO5Y424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515903; c=relaxed/simple;
	bh=g4srZ00G+WQxQuvcidJcsTGYdU02SnFUDO0JZa7OBKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1iZDseBTbx9IHWW18y1hHLyhmKQaEAvGC/yIxnE7ZOrPcl4bqF4tw7kXwV9Mhszk1e8hCQDvvgbRe8FTvyp4rRk6TAcT/vk1rZ8ZbYM3vnlB+PEvosdsRUifk7Z0WMsJY9iDxef4wWtKzCy4+bFW+e1pymfpKfoPz5iFTM/7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RzJp2qvb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nug6uoIJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RzJp2qvb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nug6uoIJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BC134EC03A5;
	Fri, 12 Dec 2025 00:05:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 12 Dec 2025 00:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765515900; x=1765602300; bh=jD5TVtLDsp
	bz43mdyCuJIPTnbiinEtLTk+IYcCjyl/w=; b=RzJp2qvbKEJOnoaGPIICkQt+wU
	6rcpuLXESEY5tJMb4Ju9BPqDOT+5gRWyTy8wjc6XohjCdtXDNjHtxphW16I0kKFY
	3r9KGnZFAYyqgdwFXysyR7gBJAG1X+tERV3pv7mNJ2pJ1Xb3o/XJxM3EavuipBE9
	Z1jr5IJbdP6VlHYT+55CbRLuRfU4XnjqDqxDBr7J0axEa3WB/xG2pSpfQwQKeSgE
	tmbCfFcE+dbxjEiR+QiZE89dZEzzw6GlySr5PAkxNNDSmRdTEX58tcRkoljsHbRK
	obiOyBEwe94TdW3k2XwkAK2kIklHzHjkG0M5bbdBC9SqZjRiBQoa4rFm0qyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765515900; x=1765602300; bh=jD5TVtLDspbz43mdyCuJIPTnbiinEtLTk+I
	YcCjyl/w=; b=nug6uoIJXLu30Dlz/Zt+7YIaujs47y0QSkGaho5aBAfbBOKGCBH
	Z7vOZaNbZQooEwO3zmSXhE6gr9vYX6ngZQhxsrWc7bRS/dvL4+AzSnrAEOjVTGPB
	2es7qR9jcVSXOx5mwluajpazU+ErYyJ19JhtpJWB6xXecpy9U37cclpoxZAWsIx3
	SA/xB7WFhVPTPwef9Ykj3xqNLSYyP6czacHVnqcV5XH4cb6yYJ8WndYecT2XHmO4
	mT8/k6GzhA3azzUreGinN9LAFgsGrPCePy9mDqSqrzrAdf//soP3YqwtmBwooZpS
	W5J8Uyi9VOxGf4WeAxM6Si61d1kuUbQ5Nvw==
X-ME-Sender: <xms:fKI7abrc8KZnY5dyev52Fv47aD6jztk8bW1bHSVAIyfTKDJDGFkeEQ>
    <xme:fKI7acj9gV2pEMeV0ppAX3b2xoVeMZcffMIfbpMnqlbPXEexCXRSfbYj-oTqKDH8B
    7F3lhzBhKxHEl_cnmUDk6HBzWgSQLzq-UaQ2drYJcJ5u6PqnqWTPA>
X-ME-Received: <xmr:fKI7aQhRzaFEzCYiqRBTt-EdYAp_IMM8Fmk4BIlSI9jCsPLXmCUVP-Hrv0F3xQwLiKGz_PO-Kng-h9qboPe-lTvRa7ZiSV2iqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fKI7aajaOYQep5_TfgYVG-3cYO5iLtMvqY7-sMpUbsL7gbcevywPOA>
    <xmx:fKI7aYLGCr8jXhZw807q6ZITpK7fBJmi1Nx8bq05DC4goUXKbBlriA>
    <xmx:fKI7aRGrw8X5ZWw6d_XkkiTjq29Oy8JKO7f6srnuaUgIEvM0z36DHg>
    <xmx:fKI7aURk5sd13Vg3kfodMMOHKWVI2_dyHvIjAjGzhFHDf3ZbeKQ9_g>
    <xmx:fKI7aRpUvW1teJ7p8aVc0q5NoxeySycKDFDc0bm8I-ZxvBgNd3Pt9F5k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 00:04:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 2/2] contrib/coccinelle: pass include paths to spatch(1)
In-Reply-To: <aTpieqFoMmZiSzWS@pks.im> (Patrick Steinhardt's message of "Thu,
	11 Dec 2025 07:19:38 +0100")
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
	<20251210-toon-cocci-memzero-v1-2-ae916a79065b@iotcl.com>
	<aTpieqFoMmZiSzWS@pks.im>
Date: Fri, 12 Dec 2025 14:04:58 +0900
Message-ID: <xmqqecp0cmth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  # For the 'coccicheck' target
>> -SPATCH_INCLUDE_FLAGS = --all-includes
>> +SPATCH_INCLUDE_FLAGS = --all-includes $(addprefix -I ,compat ewah refs sha256 trace2 win32 xdiff)
>
> This feels weird to me. We never pass any of these includes to the
> compiler, either. So why should Coccinelle require them?
>
> Coming back to your example of `eword_t`, Git knows to always include
> "ewah/ewok.h", and that include is relative to the root directory of Git
> itself. And as the header doesn't have any includes itself, this cannot
> be the root cause, either.
>
> So I'm a bit puzzled why this patch would fix the observed issue.

Indeed it is puzzling..
