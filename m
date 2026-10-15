Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E6381AE7
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085521; cv=none; b=LKTpZfZOPDMjB8V9czkWp0PcUPcUkhG6dJDv9tUZfyUExdKXS/eoUsi9sdVfn6Qfe9EoKxaSTo+5HII7l7BRAnhAl5Abc3/SNkLU82EvG/g38XpZeQ5alMzM2Em+mkNU4Cxq3I4yStU9yM/4pUE27Ra4R3ijZOzJ4sqF4tFRjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085521; c=relaxed/simple;
	bh=J6o6PZk6O8dF+7micBRn1tbRDyI8OTyVfYeQKVsRoVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QbQihKoKee0m1SvC1IaQM3E7ZMGGKIdbqfT0QjlWj+WycaPnrhdkV1NdCfwfOXIaqi4TFDqu5Na3mLUj6f4hZ88gt6xu/ArRBuHQOeeSMSdjub1aLP5dNfuSvUm9tLAvh+GqhxIeK7QGq+64rQajOEsU99ZiidDlZt6z/ldiQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nMmeIY2V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzWFQSKc; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nMmeIY2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzWFQSKc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 517547A011F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:31:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 13:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792085509; x=1792171909; bh=mBguA//S2k
	/RDT9KDLBRbNGjXgU5PrfkY6VQAl4Z7dc=; b=nMmeIY2V0D8uXIN/f2R15mFVJm
	gdjKF/iWgsa6lkWYDY2r38JX/wLaNCPDgg6Mf6UfvuIg6EuMPUCTOuzkNsxwolXi
	eXCOY1feppsG/qNPcxjb+Iuu6ixT3oau70bNGfLsg4Fa16h3hKhDnz735a5h+iaP
	OcxBF+BA6spu0+xIQasaQCt+AcoId1cn+WxK7nWO86yEcLQcAH8Sw3pYZddg7GPL
	TwuR8Fn5uI9mTUAXkyxchKUz3aA0d89nnnPmXbg9ZaP1WZixX45HJKc2k4c7Qq1c
	07LzpKNdDWKTnLY/HFOzTxzFv5tUK8za8SW20dXCWHIsZ6uvUwFjZ/IYNnWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792085509; x=1792171909; bh=mBguA//S2k/RDT9KDLBRbNGjXgU5PrfkY6V
	QAl4Z7dc=; b=CzWFQSKc6xYES+eUMLbZjZthgkHiqAf6duDOabELHbkLdqxSWVY
	ZZ8K2kGMcaHoySPbn/QHTcUPpNo5Rl98VOarCKUdDBTZ4LAJdobfbnMo0MjmPk4v
	t5VOaNwimEzaV68khI6V3QweMJCyAG4JGZt7wGMpt5GgsB5jZ1mC+D0xFB+MboPZ
	bzsMq3v6lkHYY5L4klMvwr5aZUBdngaDPLZLahc0jAFWbF7FMC2Amjf4rLKGCxj9
	jmZu3KvCg+snBqbbdNMbzeV5lJPaYG6GJCxax2MlnV/uP4tEMMx9FhYjuD77Tzuj
	XRRmeqOm7DNIS1Jfs6zPtczpyW3AhpXBX6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792085509; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kz9iMrvJDdRmL5phwCYMTlYEXI7PINRVtxT01mUhzAAvLWZ
	YR8kehxg+bOBVDR6O83DWr8tE5z+u8szOPLqGmRsWlbl9XBJvpHCIYwejI538He5
	9LH8gVczHHhllPhTVDehhYxwuz8QPq6lrtBjXq0sPQFbhA+XK+TR7CpUp4eEcUMe
	oFG0qKQPB35N5upJKaIzod7DdiG95Y8UOpj9tqSjVNOXGFvh8x17K1e1XgFD97TR
	9aF+unFrx6AwzQpRm+14yX4s7BV7W1oE/YNblHtbGPJio4Da5rw6tIDnK6mtl0t4
	tKxIzRJtNEH4+rLHmLPekmVhRtLY0hg3YPHhTqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EPW4Qta0L4Mwomzy7bCcgIDh1L9Xsh8qfnx/cap/xsc=:J6o6PZk6O8dF+7micBRn1tbRDyI8OTyVfYeQKVsRoVc=;
X-ME-Sender: <xms:BQ7RakkmmSiPIGd9vZNNtK5gg4yICGLaM0DHH9H37vIW8myLqgSReQ>
    <xme:BQ7RaqvJE5aZJEc-8GBdjjVbcuZXwJ3kWPpZUz9deZhg_pLvAntZVfITVwJG-toJ_
    ms66zjopMKDEro667Xlo8hMUzyQn5-5j7fjaElPVzZPgCS-ag2WfI0>
X-ME-Received: <xmr:BQ7Raq8SU4Q9j0PiwEzbv1-uVvXSTKxjHC4f3ZDeILoPR-aysleHMDbp11xJkqrVxhCmUdYCslHJGfVRVYy60XZ8XEAFZmSPupzo>
X-ME-Proxy-Cause: dmFkZTGKblyiYwGNS4d3crV2c1iQWTtv87F9qrH7yg89lIjLvsh7mLJ/39KWpa2UTPAt/f
    Di16UcxyPsF6TjrJA9Q9h0ZuVJJKiIZ7SkDadFy7T66KLkbWDqCbwmbfcVG3Eh3NIWr90t
    XRrNFgne/CyOkqTFdKFw82W+htp3EUB58MBWQNvqYi4ZT3uA583uShzlpG1H/Se6URjyRs
    eUQyjTzVBOCzTADH4ewopvi0IO+9SdtWEhE7WJk4WMDqUvNIPotSf5sKv7MA9hA4VP3apd
    KnCKLZwfZgbuUKo7Nv8edvN/7Sy0TnWjP4LxV8bEINxwUq/CzfnYLk6dyz1VQeIMjoyCDF
    nq42+hqRUBX1dqlYHu2EchJxUZxClu7MZoxtD1/xILsuy0BiU5rw8RTeO1Kq8Yvh+EkZbj
    WwUY65JLQrNua28oRgG89PRBv3OruubLDrAVLIH/Qikv15Peiu6qW6/nLvyO5UZweWOh2O
    28HNO9UAZ4xGP65g7hpIWzqeyJoi7k/Eq2TKv/XG5RMCAZJXGDwdd0EAYsQEKimpa+utDC
    7x2d3F8CQjNGvGK6BAGymDXWONDrLrhjIRG0suzNlFMuKwg6J5mSffUP0L5N/wZbb6jruT
    j4MFnV6OueePX0AjwhhQde1sfR8XERRIq77hZV48kD2wXuqgpf43lf9Vzn2Q
X-ME-Proxy: <xmx:BQ7RasNYHXs0d5OChm-ptatWGmrTRI7e1UGN5UPweIikXS2uTgMhrA>
    <xmx:BQ7RagG6F-zVtk1S_jgTQjbtbtWPYAZzZXSXHS9FMx9uxZpR_0NgKQ>
    <xmx:BQ7RaiRyHzIdhHntGANQ1aKqYLk4JlyEG0VAPduvrE6nfY_S_J-Low>
    <xmx:BQ7Rals5WV8_EZ9niwFpUdQes44_zY_GvtvqZTW-i1BYh3KqcNj2mw>
    <xmx:BQ7Rarcsdsad-z03TzxWks2XeHsYVA-6khonVNwNXTbWEx-0mlWvtiZ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:31:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH] refs/files: keep root refs out of loose ref cache
In-Reply-To: <atBraYoY1SVwnezN@pks.im> (Patrick Steinhardt's message of "Thu,
	15 Oct 2026 07:58:01 +0200")
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
	<atBraYoY1SVwnezN@pks.im>
Date: Thu, 15 Oct 2026 10:31:48 -0700
Message-ID: <xmqqmrseooor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +/*
>> + * Create a separate ref cache containing only the root refs. These are kept
>> + * out of the loose ref cache, which may already exist and is shared by
>> + * iterations that should not include them.
>> + */
>
> This raises the question whether an alternative fix could have been to
> teach the cache itself to skip over root refs in case the caller is not
> interested in them. The answer may very well be a "no", but I would be
> curious to learn why you settled on the proposed fix instead.
> ...
>> -	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
>> +	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
>>  					      prefix, ref_store->repo, 1);
>>  
>> +	if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS) {
>> +		root_refs = create_root_ref_cache(refs);
>> +		loose_iter = overlay_ref_iterator_begin(
>> +				cache_ref_iterator_begin(root_refs, prefix,
>> +							 ref_store->repo, 0),
>> +				loose_iter);
>> +	}
>
> It's a bit weird that we recreate the root ref "cache" for every single
> ref iterator we create that asks for root refs. Is there a reason why
> you have decided to not actually cache the root refs the same way as we
> cache the loose refs?

Curious.

So an alternative would be to have two caches, the primary one for
things under refs/ hierarchy and the other one for those outside,
and callers can choose to use only the primary one or use both of
them?
