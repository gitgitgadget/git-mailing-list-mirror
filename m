Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45321E097
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375854; cv=none; b=kDFx8rGSAjw7sRNqnv4YNcFMDBXh0WEbxvDv7t0HZ1JFebkv8xcXj/gnbP2Wpht8Vu8rprIBvKDqTLTB/V+08CAmysW7BJ+zI4AS2TFI1tIyO5Og46qproaa7r80JAiuG8EvJUfHNgXhruZB6UibYAK2DGcoC7g6iW6SnLXmqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375854; c=relaxed/simple;
	bh=DjHl92VFD9YnNJLkIWRukbfbDQ42qTFgfIoqeV3brjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B8D3Crq+eE2uGP88rp+vt9gFTJzwXaIvlbS0hOZQXkX01YsgSVQVf5EmBxCUkILco4PWCH1HlyupVmqPKc8C5xW1ZOGga59ZDngJ6pdtBWDlTYpwVLedrMtTZqQ5uRGryxM28yKNvBug6otV6qnikgaN4YJxnZQROTkPgdjGe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dSgJQ6Mi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dl6IyGwD; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dSgJQ6Mi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dl6IyGwD"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EFAE1D000BC;
	Fri, 13 Mar 2026 00:24:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 13 Mar 2026 00:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773375852; x=1773462252; bh=6CznM1cCO1
	7z0st8jMbsIOZevL59v5LTUqhyfwYyvOE=; b=dSgJQ6Mi2Q0dHVPw1KTxZYpEhO
	gzLlkVRMVv2ZajthJC4+yKZfjI+VTDvk3fhnu8/KYIIMqspvB2Dsh3IVs9Dmq686
	uRuW6dojB1CdASXAfRqoR5Trd5Z2AbpPx9p5dyTvAzcDc+RkT28RalPwkbP5LBbR
	znOuly1JsJ1EvaAoQGUdgLo4rI2UMQVYQ5/SaiXIHlJHW7AFIW1tgn4CS2gHDdxF
	MCEwvdlKCdh2vmUTNoC7TxyU5NY1G7BwjYcmxhzJf4wQSlK8HzTcMwxpypcNf4SU
	iLhuBiQm5VbNoOW4yYT/mBuiaRU9kpE3jDiIEVB5k6/vxqMuOHhdTBOcxwdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773375852; x=1773462252; bh=6CznM1cCO17z0st8jMbsIOZevL59v5LTUqh
	yfwYyvOE=; b=Dl6IyGwDjAAd9WitJ9pY3LDZ3fAHGt4SW3i4yiji5vTqsg+t45K
	oeT1v8j7ADOLzfaPdQU5nvy/4JIRkBFx7tN7T1f0qCUhRGYcO6aMurg21ubqVjvC
	Z2T2BfuEDIH8JVxEfCiqEng5FU0wS2W+EcS1lVPg2a0lsO9Do6CMTpN3Ovmid0VC
	6mhwumFGxHApbvTHznZw4BxScI9m7ZK2qCkjrLMPdYD1ljyIqMc/JEp3y3be0YYL
	TXve/lGioLqQAmeVETHWrPESrhrcd79pA//bLy/g8gtnYaZgx+dYTONKl9uKVhtE
	OOiU0qg1k1by/9Hp32GLD6Wjldl8WSZslHA==
X-ME-Sender: <xms:bJGzad7EtIqF-0VgyrpSNXdUOHBayj9w6llFmwxKbeeFxYvi1avFOQ>
    <xme:bJGzaSU-USoYZZwstiwWkUDZRFMW32RDYBePbAcOLmqLU2oa104kj5xCzzwmT0Kuo
    fp8DXeDGMjaRssebbup7mPfd7EnVQnXoEPYVqRAycEZnV1QoItwyQ>
X-ME-Received: <xmr:bJGzaR28Bpdz5zxVZ3yh4CMaPE_DM8XW-pB-vOQh9BPKP3Oe6_M-Qn-Jd9YcfCYfAWjKMv5VaBfrt4oIGHQHcocacb8Knj3DQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bJGzaf2pZtRkw9jranyOE_x8FRNUVQ-PciNcdL5RzN9DJv1txDceQQ>
    <xmx:bJGzaU8qDTJNVLlbFMWQ8_E-2vZVkoh5ksM3EgvvgBtRC1GFAQFN5A>
    <xmx:bJGzac1-A7FQ41zHFxTpIV68qWB44WyBUJPBr7eK21aLu3OA5G2MyA>
    <xmx:bJGzaR81OJteCMD8g1URPW9cjQpoyqOj_RrL3HSAcaJXIR08tok_yw>
    <xmx:bJGzaZEEFTNDM4mYashI7CwjJiCvxHGdrsTeeHweXiMH2KBvwbzZY-Nv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 00:24:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #05)
In-Reply-To: <20260313002431.GA3200726@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 12 Mar 2026 20:24:31 -0400")
References: <xmqqh5qka8so.fsf@gitster.g>
	<20260313002431.GA3200726@coredump.intra.peff.net>
Date: Thu, 12 Mar 2026 21:24:10 -0700
Message-ID: <xmqq7brg9x1x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Mar 12, 2026 at 05:10:31PM -0700, Junio C Hamano wrote:
>
>> * mf/apply-p-no-atoi (2026-03-09) 1 commit
>>  - apply.c: fix -p argument parsing
>> 
>>  "git apply -p<n>" parses <n> more carefully now.
>> 
>>  Will merge to 'next'.
>>  source: <20260310050621.3849719-1-mroik@delayed.space>
>
> I think this is responsible for test failures on Windows in jch/seen,
> but I'm stumped as to why. You might want to hold off until we figure
> it out.
>
> From the output I doubt the code change is responsible, but failing
> tests in 'next' is annoying.

Thanks.
