Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F535CB6B
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433260; cv=none; b=CrK/KS3xU9vVoGXICjtmWs1zrDHpr5ixp1Tm0SpzAbxYY9ClO3+QRScHbUFIqFjxpMbQj7k/27lbuGETjecvB49rtXFY4sXGn4neikzn7Bg+ScBcHJYY30REzTuaRNcnN5RnFd7UWcDzmbhohQ7gQ8LXI+doWsX2f85p+UlRoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433260; c=relaxed/simple;
	bh=WPb0oCnGhlFcxDty5see8FjeYkjub7c19kbNtRs69Vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cajSu0aJ5CVgxeZq4umbPYJQHMXSdEHv12pJc9u42yQNVVZLDj+RxhZ8+7eLaxlxQseHuatSRiPGk5yyVikeyi7iL/x2jG7b7K7S+BjQnh+VVBydvaod7bG2pPqIh0eTwiXBd3jR1/1FrUqRCVqSH39icMDCoCAX4mhTmzDRLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HxYFtsuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxccsS9q; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxYFtsuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxccsS9q"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 193F67A0133;
	Fri, 13 Mar 2026 16:20:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 13 Mar 2026 16:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773433257; x=1773519657; bh=dhJYz9wgzk
	rKo6aHPGfBB8v+ttyBp2SYABjCIvRuWTQ=; b=HxYFtsuYSim3euAWbpgB2veeLr
	8CU0zEku1Cp2VZ6Ml6Nz79XzzM0tJ5e1ycCNDdKys4S81WELEn5tewLxR7mnBzQu
	UHZfOe5wy+YKzcmRKN/0i12rAVHrx+vrbbaLpakpCZCcNRO2RmZKm1/9dntVhU8F
	QrwRwI54pWGOhCuYIHe8lHCv4+X0bx27taOVLS1PtI1O87j+jiWo8FdwcM9rmACs
	iSEKskt9MBxLOAapO8mXEbeviqbT9BzNOzpaY4YjZQL4WADfGIxWBgL9EES+eOiQ
	yDhKmcgrdvJgTKFVTAH96ko8E6xdKiO9j6TrP067D8X5wW4UhFjKdir/xYGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773433257; x=1773519657; bh=dhJYz9wgzkrKo6aHPGfBB8v+ttyBp2SYABj
	CIvRuWTQ=; b=LxccsS9qbS1m+onvdiNk0Txdt5zsMWy4Ilmcg6yaciXmW7uPpAZ
	WrzWgoLBDlFClUO48MqOncFPKOgH8gSAaPNAxX1h06RL4woKi/zapgfKhz1EPOVO
	KHZDxNDB4uCHe+qis9r/MtJFrag9e3J9ghJrAm7a4agMBeDy7pT38AjyDyWAPL15
	ZjAg0PZPQWX9un+nRPzLhwZRnfvP7bp9eN1qMwZf5g1pvqerLowk5e5nw8XwEmdE
	PcFgBcC7IEI62A1xnmAHCeeQwXdLICTAeLwkQVdqka52Ug0QmmfW4ef7z7ekzRh0
	stoodQITVrktBkt5gOVnRC6lMkvGwujcA6g==
X-ME-Sender: <xms:qXG0aThmWRfImrtJr5_LDfJjvNezrEe71lcosyd3UJKQqlGh_EO1wA>
    <xme:qXG0aQtENp2ja4dlFBlM1QFFWf-kStoh4-4RBa3S6VkowmD179JJ07P2Cq8jyuwA2
    MB40CcfD1IgcF2NEKjtRKvi2GAC_JwHnqv9i2PlHWb9RkWdzDCLzw>
X-ME-Received: <xmr:qXG0aRSvFT2TEoxWYtCYHb8tWBseMchBHfnYkpg8yevwYAEt5t0aCMUjFZj3HWtOCp-s2DVBETPumcWWxTYwj4q2YSR52z0ChQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:qXG0aU3jRI6fzDC5h_cq1ss7aCBGDftsQ9GcUUvDDNlsqfmoxvAd3g>
    <xmx:qXG0aWtRYjzSkGl8sKYeIQuqFFGhbn_X78fPbmmRhC4rr_y7wnXHaQ>
    <xmx:qXG0aajHD3LlMMpNR3iEPR44iOHq3yFXJUAPojqwCjyKMkndmJvZXQ>
    <xmx:qXG0aX-whRDbHcuphb4uWq6VCcdaRSMNMStZfOgsnAt8r1TzaWNQvA>
    <xmx:qXG0aVuwJ8bReQhsy6Sb5H7Vm0CrXFSobVAEQ6bFv2Tb_Mb7s8UL3PVv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 16:20:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  karthik.188@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <e448f98d-58be-409d-9ff2-ae45442dbded@malon.dev> (Tian Yuchen's
	message of "Sat, 14 Mar 2026 02:12:07 +0800")
References: <20260311181704.958509-1-cat@malon.dev> <abJjYNq_sxeH8yLQ@pks.im>
	<af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev>
	<xmqqpl577m3y.fsf@gitster.g>
	<4fb9c915-7246-4c55-b7c6-b4ef7ca91230@malon.dev>
	<xmqqzf4b4ntq.fsf@gitster.g>
	<e448f98d-58be-409d-9ff2-ae45442dbded@malon.dev>
Date: Fri, 13 Mar 2026 13:20:56 -0700
Message-ID: <xmqqh5qj4h1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> On 3/14/26 01:54, Junio C Hamano wrote:
>
>> I strongly disagree your idea that 'z' is more business logic than
>> 'h' is.  Both are equally relevant.
>
> Perhaps I didn't explain myself clearly :(
>
> I do understand that *currently* both are part of the business logic. 
> However, what puzzles me is: why is it written this way? Why isn't -h 
> intercepted at the outer global level, but instead handed off to a 
> function like parse_options() for interception?
>
> Is this due to historical reasons?
>
> Please forgive my slowness. I would appreciate it if you could offer 
> some guidance!

It is perfectly OK to be slow.  Spend enough time to study the code
so that you do not have to ask for forgiveness ;-)

In order to make a useful response to "-h", that business logic
needs to know what options are available and what argument they take
etc., which is already given to parse_options API.  What makes it
make any sense to split it to separate codepath?

