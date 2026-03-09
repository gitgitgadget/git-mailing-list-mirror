Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD73D9042
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068842; cv=none; b=F9Y6n56p+oanuZjlHm4lvZu+yO1YOPDhMkpdeNN7KYIXlSfbZwHwVhMhrwzLvMmCbkBeWfRE9gcUWscnMASIOySI+Dyi2HveOHMYEjbY5hqFgBkSzUxM2ccYuPlJEcXKwGr8PLbBjWGgCp8Fa27XHXrMK66b+eytxDkMngPvqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068842; c=relaxed/simple;
	bh=Y2sa/uyNVFRvnQI/8YE6Cec1zfJsZl9FixgwU/7P98Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PiRF0/yWOaqvDWMixlUwQiuuIM8cY9NblgtvJcMCrcELvlWJtuvbo3syyjkVa1e2Ei3Yh2PE+2RS1z+D0yJsCTnB/0By6TO2K/A7trx62aOKgdgqJqJPg9v7c7nZycuftICeLoT+DHU0vGs3o0uP0BzF7NTTm5xF1JvoFCjLnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FnEFKKwX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=macEjanX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FnEFKKwX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="macEjanX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C337EC05BA;
	Mon,  9 Mar 2026 11:07:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 11:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773068840; x=1773155240; bh=5FP+XOfk2N
	6XSqQoxutRTLn0rk5aOehqo3t0oYG1qKQ=; b=FnEFKKwXTyeEA7Em2jUpz5fU1T
	WVQf6UhF2nBiH+5fOSp3jZJ+BIKv1U3/sZVIPr9CbcqLOEdkgKXRQstrdLH5M8l4
	3mI/BPPzwgAQlB9YBDKIUrjL1LWTOmp0U222lobO0nw+iOGe5nNa9xDZqYftkA4Q
	daopWPQ/DFHJceoqfabgLDywlsfXPOAhPVwT4nKTpzwRIIzvZJOoXPvd+AYY6rX5
	OMfDwPvtsKhlVyMHzc6i6nWGo7zysaWCV9+d/Re2Zb9FsrqBTuI9GTH9oo4NTfG1
	APY3dCQogD7cnKsN6HfkVCBUW/VaIuRQBuwW1IroKY4WFt6Pe7ekXesgBONw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773068840; x=1773155240; bh=5FP+XOfk2N6XSqQoxutRTLn0rk5aOehqo3t
	0oYG1qKQ=; b=macEjanXFtzjdcvx+lWitPlYHVB8mgO1+15PrVGz9fLfFKBXe21
	Y6i0KThLhKOqIIf1lOqSaT2aZJAd20m6yA7usB2T58Lt+lDXg/7tlaYcv0gic3gE
	KWp3Fo9TDClcfcKY1mmgdHOpYkZF+nhReC/gzONn0ur+ECoAGWfruXikGjlu59bc
	Ix/XiyspqSZFw3/OOAwgiUHzeeD1Zy1JpweMvTfDezdrEZg1DoZTlYk8ZYFTJeir
	B0/w54Ugf4VO1ZlQNlV6+8lZ0VbbSy9mykEeoxkRO8ZfU8OFFZAiL80UDc3gUTjg
	qo9gDzyNBM41IzpaNVWlItwjbzYur5VVpXw==
X-ME-Sender: <xms:J-KuaTqlEYrUR4QdNF9bRGC2DTeyWS81XsyBUCUa_WbXwTlmj6XGWw>
    <xme:J-KuaUo2nKRt0BVJypgnHHxYGFrz3GZ1uSnYUkiD65qN591biib0Vczuhly97PX24
    GK9WB9zycnJeh3GoEteff_vDx3tJh-HyyHNDy7Qhi5i8X43KBho>
X-ME-Received: <xmr:J-KuaVOnaxVEGZzwrdElcEJ72af8FsFLIMqU77Wp0PH_Xxpa0IJEOsdmYQOJNp94ezWKpxLz0zjFjai6WcfhtwSigMAvLzQF0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    gurhhonhgrrhgrjhhghigrfigrlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:J-KuaVzezuoR9DBloQq10VgJv_JXnr0zVgQ0oAYrd1Sr7pUX9kM1NQ>
    <xmx:J-KuaeuK7Ec4QiRBB0MFGx9vlRwvsKvyUCHO7ZX7bt5-_JuZVnCL0A>
    <xmx:J-Kuae6VwE02WqLMclcieIY1f_SgV5mu74vnlbPD9Dq36oKk5hV6nQ>
    <xmx:J-KuadS9BkWPf4RFCP1EVKxMmdGae3RQSLHr3yhLtKoXmsYxRnIVJQ>
    <xmx:KOKuabccKWQX3vQC2TEmUpol87Bq5j0zT9Wc2rChXPOIr94fhjTgwEpN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 11:07:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: cat@malon.dev
Cc: drona <dronarajgyawali@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] Make 'trust_executable_bit' repository-scoped
In-Reply-To: <6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com>
	(cat@malon.dev's message of "Mon, 09 Mar 2026 15:13:34 +0800")
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
	<20260308183756.31860-1-dronarajgyawali@gmail.com>
	<f03d40072ab106d1a0a7852718d42f56@purelymail.com>
	<6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com>
Date: Mon, 09 Mar 2026 08:07:18 -0700
Message-ID: <xmqq1pht6nyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

cat@malon.dev writes:

>> Hi drona,
>> 
>> Thanks for the update! Just a quick heads-up: it looks like
>> you forgot to CC Junio (gitster@pobox.com) on this iteration.

No strong need to Cc the maintainer when the patch is not ready to
be applied, even though it may be nice.  I'll be seeing it either
way as I rarely look at my mailbox and use the mailing list archive
at lore.kernel.org my primary source of Git patches anyway.

There were discussions on pros and cons moving global recipients of
configuration values into a dynamically allocated strucrure, which
can change when they are parsed and when bad values in them result
in warnings, depending on the way the change is done, and excellent
pieces of advice have been given by Phillip Wood.  If anything, a
change like this should ask for input from him.

>> Additionally, I think it's a good practice to respond to
>> reviews before sending new patches.

Absolutely.

>>>  	if (!strcmp(var, "core.filemode")) {
>>> +		prepare_repo_settings(the_repository);
>>>  		the_repository->settings.trust_executable_bit = 
>>> git_config_bool(var, value);
>>>  		return 0;
>>>  	}
>> 
>> Regarding the code, calling 'prepare_repo_settings()' inside
>> 'git_default_core_config()' defeats the purpose of lazy-loading,
>> doesn't it?
>> 
>> if (!strcmp(var, "core.filemode")) {
>> 	prepare_repo_settings(the_repository);
>> 	the_repository->settings.trust_executable_bit = git_config_bool(var, 
>> value);
>> 	return 0;
>> }
>> 
>> I think the standard practice is to drop the variable from
>> 'environment.c' completely and read it directly inside
>> 'repo-settings.c: prepare_repo_settings()' using
>> 'repo_config_get_bool()'.

This "v2" applies to a mythical codebase where trust_executable_bit
is somehow a member in the settings structure, which I do not think
we have.

