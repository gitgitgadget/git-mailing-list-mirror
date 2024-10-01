Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A3158218
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825095; cv=none; b=a74WZKO7pP+W/pIVtdzfHrXM5sLlRqqF9gNtGz5FWZPqjB9gJYGGSXNkITQ/voIEp/QW9q7czNT3Klj5yJcpxk2Q/BD+u22YodR1i66KYgHAO4eRq3pMdznUWlr0jJCZ61m71rtCkYQYqTSbam8lPePSCM640lRjdfXpLGqS1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825095; c=relaxed/simple;
	bh=QSeTEd3IprbmPT3wcOqGumFlHaSXjbLG/fxu26vvqFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jq/xjyuyDAvbHdrs6gAHO0M7NWEVws9mEwosPX51D5DZu3mv2JBTE7wUpaJsou4oWvUUm2XLnIlRy2gWC9vDtzF2Jv4quKdwoKI3pHJMpJTIdHk/WCx+eIVffcKztMK3YeC3cT0LaENq7fKOrSZObEvDl2Bhl0JtgGUb2t1bFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vFIWIX5d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCAgfIBf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vFIWIX5d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCAgfIBf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 975CA1140617;
	Tue,  1 Oct 2024 19:24:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 01 Oct 2024 19:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727825092; x=1727911492; bh=RHKAd4cGu3
	8hOOdlGe5hHEr79MHqV6musWKKvnUNL4M=; b=vFIWIX5dm2PtIdXjuTgwzBg2ON
	IEljyCzzPD9b9ZOffptN4WX9rzC9m0zyYC7Hwz9yIjsHa5iy7ZXgWk74XDqrk3Kd
	HIs3pMFiBUw9e1gG/Xef+qrG6z4gSIUYt6C7tidPSMs2qEEcZRJhzc4XaG8PHeDd
	DLJesj8i6ExNwVbvu6hH0OLRq69IA1tCp55CGuSM+3DYzQhJ7LUU+7hYEnkr3CfR
	HiDC7RRNE3L/7W4B+3x34bLNZqSn+dseM9WKIQoo7EEOhTaZdYzpKKxwTuKJCbgb
	eu8h1d7aVpwuHGpOKIWre1JQPOUg+Qh5EgtR6+Mj7T59aNAJ5gbMLznq2SJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727825092; x=1727911492; bh=RHKAd4cGu38hOOdlGe5hHEr79MHq
	V6musWKKvnUNL4M=; b=VCAgfIBfgBCw2YL2+XH03fypF9T5Wom17H4se1oo+yzn
	xvhjMPvGTsrLFwDr7Bmvb1GC54d3dVPbWBfwbotPJVooEpyKYf8rIZU5ti+atdAR
	phL2JIlGXuMi826rIViNf2PVqsdOPOFcfeFnFlfqyFpMRNUYFMu7mUQzRfpTysL+
	lNNTPKPhmXwPYRb5h4+OjKLdLoIDYHalQvdFkjWHFfMEotiqeL52mPFqXt7uvrc3
	2Fk8Y7qOQa1OSdT2Mb+Z8O8l5jM9YRnl46aoyueG166Q/uuOWVNNkbu2RNVr6pTU
	F87TeWC/YZHL3JaQHbXdpWSwMEeSgX2xZjfuVcf2JQ==
X-ME-Sender: <xms:xIT8ZkugbOcy3-IZtQ-549eA4ok481w2h5G19s8vPOEzpPFT5ctY1Q>
    <xme:xIT8Zhe-XTjv8EefRcvAYXvWv-S1sE6k3fTkoXjmDPog6wpOMPliA-6PjqKH6IDVi
    ZOe1iffNEWp3pr3hg>
X-ME-Received: <xmr:xIT8ZvzxRl9LskQV71EVVPytAusVyl6wM5spqTJsfIqHXkv0AZ-CzobFWM39pe24r-UqBTa0xLi-GB6UYZUte0KOwoEgVj4_C2fyYQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtvggrughm
    ohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xIT8ZnPc0C8tC5KrOKgGWwVahRSjTzVcisI9w7WdbWBvstlZRAllEA>
    <xmx:xIT8Zk_zRDLZeZAU9qgQAIon58ln53ws2sSYEZ8BJ7aTsHP5tZMQzg>
    <xmx:xIT8ZvUur6kqzvmtFSwI3AdPAoE2A4tylosNQgf3glZLHZLAMFINDQ>
    <xmx:xIT8ZtetQNYhd_R_Tq8_S_55HqR96ElhZK4Ba2ScHyVcNHofJL56eA>
    <xmx:xIT8ZoRRxhzn-89vXbzS7EkhjgRVbegewMNmQmM9xTAuZIt2ydb1WOka>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 19:24:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when
 preparing transaction
In-Reply-To: <20241001225425.GB2317071@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 1 Oct 2024 18:54:25 -0400")
References: <cover.1726578382.git.ps@pks.im> <cover.1727155858.git.ps@pks.im>
	<9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
	<20240927040752.GA567671@coredump.intra.peff.net>
	<c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
	<Zvt6LxWm8gtJGw9S@pks.im>
	<20241001225425.GB2317071@coredump.intra.peff.net>
Date: Tue, 01 Oct 2024 16:24:50 -0700
Message-ID: <xmqqttdvqud9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Oct 01, 2024 at 06:27:33AM +0200, Patrick Steinhardt wrote:
>
>> If this is causing problems for folks I'd say we can do the below change
>> for now. It's of course only a stop-gap solution until I find the time
>> to debug this, which should be later this week or early next week.
>> 
>> Patrick
>> 
>> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
>> index 2d951c8ceb..ad7bb39b79 100755
>> --- a/t/t0610-reftable-basics.sh
>> +++ b/t/t0610-reftable-basics.sh
>> @@ -450,7 +450,7 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
>>  	)
>>  '
>>  
>> -test_expect_success 'ref transaction: many concurrent writers' '
>> +test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
>>  	test_when_finished "rm -rf repo" &&
>>  	git init repo &&
>>  	(
>
> IMHO we can live with a flaky test for a little while. It's not like
> it's the only one. ;) And hopefully your digging turns up a real
> solution.
>
> It also sounds from subsequent discussion that Josh's issue was on
> Linux, so it wouldn't help there.

That's true.  WINDOWS prereq would not help there, even though it
would hide the breakage from CI.



