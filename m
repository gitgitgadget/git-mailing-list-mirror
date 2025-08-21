Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96EF284696
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792588; cv=none; b=HF4KOGc872GjEtXfqhSZ+KIX1CFtGGmuKrJZXlm+7a8ez/aRZ8VnG+1r4CGC2c27+S9TCr0bDXqWO70JKFXqXD5az5dwdv7KEzM9W78y98yQAOYkFDwW1Q9xdfdLzSdDL+Q8idPufEIQlialeQOQoimjkIaZGCumhagWmdB73cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792588; c=relaxed/simple;
	bh=0F35BmRHxdKMXwK6qOaIvrBd30yIP42d8/0Zo+JtprU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RO2EH3bxQ/9DGTmrvDJqxeeeYQwjxz7IrETUScNneajuB/HLbxjEUOAxoYbaHe+4L+zzSbEHE6o5Itlf7g5oD+pqsZFEHqI0OVFrldQB8alBGfKz1/heVEYrv0JI03AzGUgURBMLt+NOm6uVzgCj8iqZiXbpFE7lp42UCYHREHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=alqZ6c2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNRk/2F9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="alqZ6c2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNRk/2F9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C1CB7A018C;
	Thu, 21 Aug 2025 12:09:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 12:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755792584; x=1755878984; bh=WFU5Wti041
	doM449O6FmFMAYWn/R5nXI41oE4TL73z4=; b=alqZ6c2i/B85SIYoZuZUOA08ij
	L4B3+D+4xKIyFjuppnhIOMioxpB2AdQPXuyMqJiDCZN1628cwqeTJVWzVui9FyMZ
	GnFNtwJXtH55TXzCUI/Nn8ik9MfQUYsCOx+yFxx2suvSPiLoCiz9HainQ328NoOP
	0uDKPjJp+yPMkQQrpvqi1kLT8o7LW+WNryGofMKDZqLDLfiX3PLNH/8TZycydoyC
	3vh2EVO8oyAVjue4PDRLl+IUnc9N8kRRZyhft9K0gXq15qYSCnLIaIp+trq+uj4U
	ZIT6yqf0mCbn1kT0rcbway5fbdnL+m9NADbz3QUd4s8oDC5xrjJQvycvzPiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755792584; x=1755878984; bh=WFU5Wti041doM449O6FmFMAYWn/R5nXI41o
	E4TL73z4=; b=lNRk/2F9N7UrW2SuwR7B6mMrBeZk9RMV5gP/BtinD9sz6KmRIN6
	uOANHwMsb4M+ch7owQwQlPugbhlc5WSSLdjynjrtlkI1txbdebh3HLZDLuCTOIo3
	msTp7qfiGL1VOPE/Chpd+Yrgej89CVmwEApw/oNINTFrH6oaXUNdDNseKYfYItN4
	rBXzbn0RMGO4OFNVwI6VYbfMPnM4ApZwbUyE4NA9+t0BifbGk2kQDOJXcJxPn18b
	MnBZZOSS3+9oHFyUmBoQmHeghIemhwIDRgi2C+ZJ5Tk9/LmKQFJe1RAf8eUXJGV3
	H6WJQHXsv1ZvzFvfm+7t9w3gnUpkcaYQMfg==
X-ME-Sender: <xms:yESnaPe38ERCcgVw428QfTNove2c3f1cz-4OLJnAKiOYFTy7ISbY4Q>
    <xme:yESnaAvRjAwGZTdd9A_zVg2AUzfLGJVpshmnDcszPKnwXAy7aSV8Cbf6DEM1mxT2D
    Yb22Se5_03uSshU-A>
X-ME-Received: <xmr:yESnaO8NiqGK4JNh0ChaNqVrM2hGb3fn_W3F6QeEXx0pXs29HzMekrWYW03NPLi3EwyHLzrPxBGxsxJSmvfD9lXotbCsfjFx9_8FJPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yESnaL1lth9rscKPg6tidcNr8WA7FC-7bjhEI4fkqTv5vEWbkEMk2g>
    <xmx:yESnaDB5SRSZmUOm1kJx5uHFh4vjjZGUnYESSyW7gPVkbTX9q-D-Eg>
    <xmx:yESnaHcBo1SmJiTrfCKTEXKoUoPcek4NFoiMleHIGI0jsDvVUwYFmQ>
    <xmx:yESnaA7L3f_GroTdSgR-mDqqYs0UrCGXKeTHev-2tk5mJryf8C3kvQ>
    <xmx:yESnaHNV-RasSgdmOiHest9Z1s0XOXBx82uBJ_FpsMn7-rIJ6i_LnmHE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 12:09:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for
 --format=nul
In-Reply-To: <CAOLa=ZQZCUsa7M0mh1oCq8hhBZS05=jw4y2Lr1r3rPe0-ajbhw@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 21 Aug 2025 03:12:17 -0700")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250820144247.79197-2-lucasseikioshiro@gmail.com>
	<CAOLa=ZQZCUsa7M0mh1oCq8hhBZS05=jw4y2Lr1r3rPe0-ajbhw@mail.gmail.com>
Date: Thu, 21 Aug 2025 09:09:42 -0700
Message-ID: <xmqqsehk3bcp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> -git repo info [--format=(keyvalue|nul)] [<key>...]
>> +git repo info [--format=(keyvalue|nul)|-z] [<key>...]
>>
>
> Nit: Perhaps we can leave a space around '|' to make it easier to read?

Documentation/CodingGuidelines (Synopsis Syntax) has explicit
guidelines about these things.

     Don't use spacing around "|" tokens when they're used to separate the
     alternate arguments of an option:
        Do: --track[=(direct|inherit)]
        Don't: --track[=(direct | inherit)]

