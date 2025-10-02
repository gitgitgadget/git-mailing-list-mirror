Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4531329F
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411934; cv=none; b=pQBIay/4w/9h6100YPZsv4ONP3CuGG8nB5nFsOwgTv6HrmCC/OxzYEWRx26DZADco4oK8i39RbyA0fWYBOyhGyS3JUWA5lyCjrXYW/CpoPQGhxtM1PmTjowjcyR0eAj1JWytbwhnkeD0IRLE/vh4LLUCBw4J0PlSrgg5Rm8pOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411934; c=relaxed/simple;
	bh=KO3jvBDTyOYEfMndesQfVnR2+hTmhk1nwVp///298do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YYSUJnlxIGkChWXME1oi4GA4Ky7TkxEBGIOxtuI/9eyHvEJknjqYP+H1F91g4tYHQTmU9+fiChoas4fzZNNbss/XxFZvF+QS2K77sX+/L0YYTrlX73hBVL9tHADVPDcIq6DNhYP7wuwPbh2VXvyOOW1CsDVfkX7TIR8HAmdqNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bYr0uKVl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yzBul8dF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bYr0uKVl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yzBul8dF"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9A737A00B9;
	Thu,  2 Oct 2025 09:32:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 02 Oct 2025 09:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759411929; x=1759498329; bh=Zh5APE5c2R
	x5Qp0kfgDJMrcxGSLzXCcX2tbmK4cupZE=; b=bYr0uKVldrFfqJIp8U1wri2WZr
	VjdUWv7gGYEkLJktyd+OuHiHe/adoabuHlxTSekjocnHhvFyU02bw7d+Zyh33kmn
	p4XkaUZ+XRPT15razvakMYgRik8019O4dywbAlwsK6zn/r34Fau4cGUzibuP1Voy
	pD4r7ct8WacJ8rhp+MbCzzpQQfDBDzAwqIeAJStdwvnMCn2iS43V5urrC6AGvO6g
	n9LOSjzGnWl9zGvb0JHzK+B0qN3rsdxY2upBUIwbpPGpmz58PPC6e7xQvJ0mkDLK
	Rw1NxXnO1qEjojMFigI6Yt2/VEjjv+Emzn0bsBrSf4Ikc1//TkEqpBB3dKRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759411929; x=1759498329; bh=Zh5APE5c2Rx5Qp0kfgDJMrcxGSLzXCcX2tb
	mK4cupZE=; b=yzBul8dFlUcUaRkYVDMMpBsKPUlYfUWULFPwzfaD1VRfW0xdVJF
	d8QIVJGPawLlEuy4EvIV+0Qlfl0wTP1gKujRAdPLjdSOS5qVaKe62AaoTEFj0jYR
	0Jx6pxkJvjXJGhNJQ5yEyiX93w2zC7HI7ik8dhgNO20Opkk7E1gF2YIHZZplLLgX
	p6psi/W3bZiNBkZg/8eFt7IqwmM2M0yTFSywbOa9zszFol4ddkZz93hEYsM/fcUy
	p8zhVvWXI57Xr84F3HAIMCZBHl/XJxL5l76UIi9TDG134Jq9kSmmSe+sCqngmuF0
	UP/zsHtHbrXQ6JkJNMRG6KPM2sEy9oNOUMg==
X-ME-Sender: <xms:2X7eaNYdQBteRdL1OIPc_KOA05vFdsmVr6Ndxk2JGQZsyRNBhEo9ng>
    <xme:2X7eaLTej2XZk7IPzPa64olqW1DmWvKeoITyUAadt-uITzQEV1IIde0sXfUCqG_LX
    kdmxaTW5hDhdH712xc-b09_zEM4gcn0sxp8RAp5cXjOLuj5TtndiA>
X-ME-Received: <xmr:2X7eaIQdWon2YdqaZ_YAUFOlBk9KIBALROAUkvuMRq5TyWIkg-kK76_6vgxVUrjGV9z5l8_wN6h8o4HfyxKscnUUJP1DAV4B14um>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekiedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2X7eaHRTNKW7yFm4lIVcF0L1J3pmxHit_LXK5_BtzGMEPA6ADJqz2w>
    <xmx:2X7eaF59RxZ2STdlijz11A9d59-Yg-KXx8xGwBuPe3OUMSSpqc2UhA>
    <xmx:2X7eaL0ut9GRpSRK5P5ducQyxzoMiEWkC5Z-X7Grvzr9tcgtNXQV0Q>
    <xmx:2X7eaID8cTGyyE9EsjOb_1rqTgL6tpMHkBCXrGjhzyy3WL9SFRLm0Q>
    <xmx:2X7eaKgOvmnIiozvm7nwBE5zudY-PiLmfBCnzbx3r6JI2ANtgjHj8ZJZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 09:32:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/3] make: delete REFTABLE_LIB, add reftable to LIB_OBJS
In-Reply-To: <aN4SU3lLFi2EROsF@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Oct 2025 07:49:07 +0200")
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
	<8549f634153b1ab394a2e6630d8cc1209261a31a.1759341748.git.gitgitgadget@gmail.com>
	<aN4SU3lLFi2EROsF@pks.im>
Date: Thu, 02 Oct 2025 06:32:07 -0700
Message-ID: <xmqqwm5dxwdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 01, 2025 at 06:02:28PM +0000, Ezekiel Newren via GitGitGadget wrote:
>> diff --git a/Makefile b/Makefile
>> index d89ba03286..4c63045443 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1411,9 +1410,9 @@ REFTABLE_OBJS += reftable/system.o
>>  REFTABLE_OBJS += reftable/table.o
>>  REFTABLE_OBJS += reftable/tree.o
>>  REFTABLE_OBJS += reftable/writer.o
>> +LIB_OBJS += $(REFTABLE_OBJS)
>>  
>> -# reftable lib may in turn depend on what is in libgit.a
>> -GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
>> +GITLIBS = common-main.o $(LIB_FILE)
>>  EXTLIBS =
>>  
>>  GIT_USER_AGENT = git/$(GIT_VERSION)
>
> Same question here as on the preceding commit: do we even need
> REFTABLE_OBJS anymore?

Same answer as before.

> Other than that these patches look sensible to me, thanks. Even without
> Rust they simplify our build infra a bit, so I think that landing them
> independently of Rust is a good thing.

Thanks.
