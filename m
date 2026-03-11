Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2683161BE
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252821; cv=none; b=W1p+a0pO+6E6lIr5OvE7qoY2nJ6Tlwug4O/ZjwQXyXn6x1nBaz2jeA4lwv1LmnGX051FADkrDmFSa7+vXpozJarwjIU3UbRYyp2z6Nh8fX1/2z/0wlkCpFfOSsDxz/z70MHsYYUjkN5Y9spyRH6ZleZPybJSXOSk8/nItpbQtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252821; c=relaxed/simple;
	bh=fV+0kHss4LCIjnL1BV00m5e7qXFHRIu3MKwOCKpCEAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DlRsKrGJOn3S2lf6yiC+py5yOlW8ze/ukaBgtdm8x2S2TypUhpHI0pUWf6zp/JBOLR6D2WBPOHMHCwd4kR+NKA1PzEnRj9sysqdk+RUgqdgi9dvSmhayK9NgZ51ynDVngXiRkbKBPUdDCUmgD3/9CoN3diMOVJ1PD1J5fd2Az3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NY78sRgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qk45OKJd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NY78sRgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qk45OKJd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F7091D00111;
	Wed, 11 Mar 2026 14:13:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 14:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773252819; x=1773339219; bh=F7qsSSulqk
	SK98JtAkVlCJ1UEKKaZ5sLnsUzi8BqTwo=; b=NY78sRgy/TiYMuN/PxpFGrMZ7l
	V+kC2VDDukNxifLrxfPbAHviDhMQSKsU6W4KOxQa0k79RNP0OhBDGFh8j7wuZDqf
	1/lmMGq8CWI/lzNhOMhn9KL8qyYcwEv7D/uF4dkfSPq72nEJ6NTnikml0uRTMU8Q
	esYv//TSia++3gu0ipBRsMQk8HTk5I2WFuYDbBNO6Z7FXx1d4LIrpVawUAify7vl
	IhG4tsj9+8GbFgYHLd9UCL32Nc4YgHBoSftiA1hVBuZDiejgFQnxeW2TkAoMJVle
	kpWfTZzWN7z6DyqDifSagO0+17CZvXjjoJFSNu64CxmZR8gUhNAg+5hqSH9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773252819; x=1773339219; bh=F7qsSSulqkSK98JtAkVlCJ1UEKKaZ5sLnsU
	zi8BqTwo=; b=qk45OKJdXP4qpwyAMCiYP8p3PtUZv8278al9nLpCkh1ln7lY5Wj
	YFhF+CQ4SZhpRUquhPPrvgjjZ2ZudoOjh2sLFeZ5nim8zOvyIapwQZa/CuE9L1GZ
	bHsCFarhuIsdVRlv2dFaHmccoUfhtUmNErr8vbqv52QgDhezfDkkE4Bxy6Q3JbTi
	ENd/+1sUM4YoCypHoHor6UFCISXrpTsh50ZxW+siEYV16BPgYuxxs/nseIGn7kBb
	ct6Yrl0nTxw4a0bjhmSdSDOObkKUGw5JlAVtfhH4WvRMYBz7SBdl1xH9SKPZnUA0
	peDt9TQJhbQT/I0UzMnej04fv73dMrJFx/w==
X-ME-Sender: <xms:07CxaWNPXOEivzmiVWZ4LwPE0yI_CyE24vihj_uF2poj9LrP9HOmKA>
    <xme:07Cxab9_E1AtxI9PPRhWrAUf6vs5XqDdNcTaetdeNf9qAMuqnQrwMrCQKPzYJph5X
    HjasnFrKDArs4ItRi0SySrkN1ii0cb26b0TJYigQ0L41WFD-kmpKg>
X-ME-Received: <xmr:07CxaSQMEXEPKKVpP9kKeHMlxKrKkfc9AJmePjg4UifFgwTHMHtsJACO7_iihppzc0LDUrNtou4mfgUrLJQPJIb7zu528pq7nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepuggvvhgvshhhihhguhhrghgrohhnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:07CxaVmRercavXwAGw0oaOd1F2HG8NWvdCDX1mMND-rrut3yOpSMpw>
    <xmx:07CxaaQOExeZ_vWVjPxgUCB4lPSaZYh5S55Wq1HlAiBvmUwYDP1VGA>
    <xmx:07CxabPhCvj8LN9kGzBFG-9phxucFGW0wFq5uAFzbmokfg1ZVrTr1Q>
    <xmx:07CxabX-VzZdp9sdbz13bgu-Y4pf9DPor_6Cu5TVr6JkJqi7fH9L7w>
    <xmx:07CxaePIsIAV2STqyGEo-xAsjJuws4hZL9JjavYBOhnPebUUc3TSxKTM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 14:13:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
In-Reply-To: <20260311174816.GB1900488@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 11 Mar 2026 13:48:16 -0400")
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
	<20260311173336.8395-1-deveshigurgaon@gmail.com>
	<20260311173336.8395-3-deveshigurgaon@gmail.com>
	<20260311174816.GB1900488@coredump.intra.peff.net>
Date: Wed, 11 Mar 2026 11:13:37 -0700
Message-ID: <xmqqjyvip73i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Mar 11, 2026 at 05:33:36PM +0000, Deveshi Dwivedi wrote:
>
>> +	while (*p && !result) {
>> +		const char *end = strchrnul(p, '+');
>> +
>> +		strbuf_reset(&sub);
>> +		strbuf_add(&sub, p, end - p);
>> +
>> +		if (sub.len)
>> +			result = parse_combine_subfilter(filter_options, sub.buf, errbuf);
>> +
>> +		if (!*end)
>> +			break;
>> +		p = end + 1;
>>  	}
>> +	strbuf_release(&sub);
>
> This version of the loop looks good to me.
>
> -Peff

Thanks, both.  Will queue.
