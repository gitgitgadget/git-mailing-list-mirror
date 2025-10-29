Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608861F1302
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748327; cv=none; b=qZ0yCDKRpUQKuDhjwgQ0xLVOHK8/D3kEbwb+adJyApXR8f8nSf/DzXpYJmChezkzxSywPLF1ShtGF5Yd9zfbcdsxI+CvyfZQIoHi7cRHVzW6mAM+dAgOINL91pOypLCAT54ClPbMU4e6ignkTIUqAaNfJfre4hlLaSJbhNdkgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748327; c=relaxed/simple;
	bh=Q3gJDq+rpuhkZ9hOXlhM2Sim44m1LoCNA9M13YU05wY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t36PUJdWcuuR92RDZNHoZQ7kRpxku/lwSpyfZKB25XhtOmMmnYA24crRheMohU9T0Dw456305k/u6VDpbhVAKrHuBMTZ0ZxbWAaXr8A8LvuWtbd/pxVAd37tDL1hflhpcoRqmRuegcQqO1DquAJcs/5ahiMEugcjU4iHvDfaU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D/lPjiDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wSlaOBXn; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D/lPjiDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSlaOBXn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 747B6EC0283;
	Wed, 29 Oct 2025 10:32:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 10:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761748323; x=1761834723; bh=9q/1dpHqv1
	PIlRVf+nualDLBSl0GN5ZqcCAmY1yYMQY=; b=D/lPjiDwK794AS5C858zFMbE0Q
	uckmSHYvZp9/Z0cE7ng5aChzrMd5zSuA+rW6nRDFP1Zy9RO+44NMWLQr3ru2vIzF
	4LpTF8TDxYbqOiHGzCC+1nmE8SywW46rrhM5h/z/KNZaER2TRHtK1CwFLrngnbDr
	n4YPuhYDd/0xgtazUf8jcaqxco1ULNSPcL4rrwp+9Zf3Yr7SPP+PTUdfzM1sK9wo
	wZRJcZzczJoUINlRRvQay3P8JmG4nAsVZ1Wqe6i96K6ODPQw1Sd9/DTnqmQUnFHp
	vGMQLeCd3Apq4t4vhEi8fnBkQNHcYK4TPG71gqCB5aOdVZ3N3mDiT3lhzVOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761748323; x=1761834723; bh=9q/1dpHqv1PIlRVf+nualDLBSl0GN5ZqcCA
	mY1yYMQY=; b=wSlaOBXn3lVasYt/NYO4vfyxcw0kga3Xz/3tQ2brW1RZc3IptQ/
	ubnLpO682KupswlwKdoSdDYPV8LHxMB+lh/kgwVXfjE5N7SXBuEtmhGXsZuixyGN
	tDs/goWzaZhkAXyr9x0zXCpx8dBw5ldWTvfoWL2tBL85ZQ6iW3IgUJhVrwzuTfpX
	vBPt6TgTWNqkmhyaHASjVfuLmVNg7DQve45Re1ZJ/PEmGO7UocRcsbR7AL+990wy
	qRNEnt5isK75zUIUoagTFzP5GW6EUP6pTuTRjdiQ0oAOIpEAqk7uwNzlz5ngkLFV
	UbSH5pJuhvE1HSM3EyAAr52N6k4ahOl2Lzw==
X-ME-Sender: <xms:YiUCaTJRjKr8RyDSLM6N2RMd-XPqqahdYu6_dVswciKLpVZtpWIn7A>
    <xme:YiUCaeBk9v9QtO90H8CfbqRCnM5GPc2hIlIQZnaLczNrns9sjS8TGY3iLErOlHV0H
    IaI-zk2eAzaaiYtiyOOdtx5t2f22o49vFlyuoYz5LQtZtEaRVuSxA>
X-ME-Received: <xmr:YiUCaUDGHDzUhldKKPO1I-wN3ukUSS7jLwfpESRNaQE2Y3SdzARNCYsIMyRhGivHcNLTmj4PHzRxzqVi3eTEkZJ6DHLAAggrKlZu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:YyUCaYAT_zq2G75qpFt3xpNUWTzbQSZVH8w1ruPyGA6HKnqi_WQBqg>
    <xmx:YyUCaXoKNnnOwDcxsIWwlOqGxiHNCqF1cd6Ehj-qgU09_H-H5ojhgA>
    <xmx:YyUCaalr4KFdbrFPNVib0vTcyPKpr6d4QEgoTlquf_ztMR4bvHfQhg>
    <xmx:YyUCafz0TLH75AYkQwPLrHaTnC_NaEGqKqJdDJntY80Cke_WCxPkxg>
    <xmx:YyUCaRR_McitZ793Sh5vEIbLUtX89bf8SghzyEaZr9I8tQk9_tPCB11s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 10:32:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/14] rust: add a hash algorithm abstraction
In-Reply-To: <xmqq8qgtbzyi.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	29 Oct 2025 06:27:17 -0700")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-6-sandals@crustytoothpaste.net>
	<xmqq3472dcfl.fsf@gitster.g>
	<CAH=ZcbD80RGeuxqcDiWr2KNaQzFCrd=9fQOGo_+pW9E6+HmtQA@mail.gmail.com>
	<xmqq8qgtbzyi.fsf@gitster.g>
Date: Wed, 29 Oct 2025 07:32:01 -0700
Message-ID: <xmqq4irhbwym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>> These cases for "None" surprised me a bit; I would have expected us
>>> to error out when given an algorithm we do not recognise.
>>
>> I think _Result_ would be more appropriate here.
>
> Perhaps.  But the Option/Result was not what I was suprised about.
> ...
> Perhaps as_mut_slice() side is justifiable (an uninitialized
> instance of ObjectID is filled by getting the full self.hash and
> filling it, plus filling the algo), but the same explanation would
> not apply on the read-only side.

Rethinking, I guess the "why doesn't it fail in the None case?" is
exactly the same question as "why Option, not Result?" as you
suggested.  Sorry for the noise.
