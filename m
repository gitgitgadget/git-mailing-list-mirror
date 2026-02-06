Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11602AE77
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399186; cv=none; b=Wk3KEDupwKRgXLg0Usx7zrHDEXsG6iCg7v4UAs+nanHH8zrIskx3LkIRsb5iVwBHEAmePkrM42NjMVlkAHsXfbGaYn0yX3cJVyiVREeOtiASQBokbWGEoiIKIWpPy2byLo819FOxLa5BXy2pGJ1Xak0rWuZAl1a9d7wSaWTuf8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399186; c=relaxed/simple;
	bh=1WChsRNlO2TBwj3pW47OtSVBwWOYEoyd1Jl5QncbIAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpwq1lK9WV+POzINS1SLAFUusK8Gr5w7VVlf5ey0yEQlzrEyYbDZJ54njxkuL0wRMFCdCVmaKCtdPJMXtwQULKefD7vzJrCnTdH48k6wN4qLYPc9HQyLWjP282GvTUWOv9VnaCNnUaEXUghsepn55tvhCTjTCAX41r54TiqRijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hxhV/jMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+3zwEyg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxhV/jMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+3zwEyg"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D315314001B8;
	Fri,  6 Feb 2026 12:33:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 06 Feb 2026 12:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770399184; x=1770485584; bh=Nc4dvtMcdb
	2Ejq7zwNtij1YhQ9RZQYlrNCssMGRXuNI=; b=hxhV/jMgzrmGWm0eUze6Jyc+mL
	9aCRRIN4/it9qA3obBXEAB8cZEQKEZCJpA0/4x4kj8Xew+D48vlh3ZjzHXXgzaJ/
	WNPzLzSCksbuVRpFY2wNF46aKDesHapkKFB6dRQ6aBHCKrFdFdxu3GtiQGzTG9lT
	iJ3Kgg0GNLZufHzu1l3jkVXScg0OQkXRxeUkWwTB+b9IzmLyNx0usU0TTbp95uP4
	eLLUJ8wsxuH4nse/WUatkxDtPjCQgR3VudN4YxfBNU4T7kclR4HZCilHDK655Xj9
	gjWRn/1SgoXUEoG2YeQCOil5QF4dH07CJtOPe+bXPzacUFKDttUEnJII/BQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770399184; x=1770485584; bh=Nc4dvtMcdb2Ejq7zwNtij1YhQ9RZQYlrNCs
	sMGRXuNI=; b=Q+3zwEygqnJ9id+niu2GvN1C96XdVe18VOC+lubea21WVgexkNc
	4YeaTisZKPVZXQOOHw+Skgk4dNQXxuaNwJG1Asipj/5AJNXvUE5sEcL1ih8vKzVj
	hRLRRhDJhdMWz7dy8Gv+dsWGvrty4O4OqdYAnS6Ub7RmWU42xfwGEV5LpX8FWnSm
	mR2AWciO7amRSEccQJbv0Un5nHsetDXBNYiqrIXP/wUPLFzlN/Es/jda3sXbV1Lz
	K/Vqi1HoR79SOuKioMb5ksPecTOfXZGF3IvhETYZA5LbkGFDMAh8Un4752xwYDc0
	oNI/eHvXS/96SOv5O57v0/WH7tt0Q9cKXqA==
X-ME-Sender: <xms:0CWGacljm6p-GkfjAi93pN8dOTgxv9QmgOfOlI30xhfbBIUttmHFUw>
    <xme:0CWGaSv5SKbFNjpBKZLRgVH1NA3W30-vh7U0bGqD7Z2Q4q5Q0cO96MqLLkQzaJvFq
    01FJrDlV7kQQVtILh_193OQKd9TjoCH2Nl6n6AsVcS2i7dUcGvQLOE>
X-ME-Received: <xmr:0CWGaS9Mpf2aIc6opdDVjD97DCGtTp-U8RpHKfJbAUqbIzIvPu2lAWDZfn23w-brL18abZyZrtfGf0SMroEdS6flrei6NHp0Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhesshgrmhgsohhsthhotghkrdgtrg
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0CWGaUPUyATVV5ckJFHTev5PzIzpldKs5PNc2JnD0KN8fSSoBkA_zA>
    <xmx:0CWGaYFPEHWLprOA2ZzCn2epNO6iCHqI1xWNdWNGytSBpBuJFeycnQ>
    <xmx:0CWGaaQZSKwfXPQboJnKZfIKcfgXPdcptGPvk7NuaDGac410H5rnoQ>
    <xmx:0CWGaduKJVP8DmGllPsCMyksSk2VPN9SbOK0INxQBpd6hb17fvx0yQ>
    <xmx:0CWGaYoSLgT00p_7znB-2zc64pfEX4yWMvxeeR9Xbh7n7u5Whp3xOJyp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 12:33:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam Bostock <sam@sambostock.ca>
Subject: Re: [PATCH 1/2] merge-ours: drop USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <aYYCesJsZMdHu1Ia@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 16:02:18 +0100")
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
	<6cb970e512c02f0db11b8aae247aaa1675b31ef0.1770345124.git.gitgitgadget@gmail.com>
	<aYYCesJsZMdHu1Ia@pks.im>
Date: Fri, 06 Feb 2026 09:33:03 -0800
Message-ID: <xmqqy0l5g4kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> -		   struct repository *repo UNUSED)
>> +		   struct repository *repo)
>>  {
>>  	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);
>
> One important part of the puzzle here is that git-merge-ours(1) cannot
> run outside of a repository, as it is tagged with `RUN_SETUP`. So as a
> consequence, `repo` will never be `NULL`, and thus all the changes to
> s/the_repository/repo/ are safe.

Indeed.  It may be worth recording that reasoning in the log
message.
