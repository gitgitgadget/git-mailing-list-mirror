Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C83AB282
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262352; cv=none; b=b4hGNUC/359LTVu8NX9eZfvWNFUm/GvHC4sDH5o+ewLuOjfoeMNU44IGzA7t6x19rZ1gpCrv8lDQ8x6dZ7Lt/nB65ig4ubL4DsWiy+crzVYs7gJjYr4aYHM8jo83uvIVD9GjqyL5fuiqT9mYgCrIhbwXXOgingWaZcSRd8VvL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262352; c=relaxed/simple;
	bh=rvYeljfpb/zFAgxIypYTitMDcGzzNxpFtVihkZMMJV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyilGvzdGAtzaCotOLc7OSt8HnxFstktyiyShkNUbPa6TlCLZa8s+9cDfghqj6nvANrZ2quzyIjJY0vO9sZEgAOJNgfYAIEYa7kr+1xKCUkr0mr3/brfOAOYCDmxpS1obNy5fl+5jzpy0RlAw1Uu1EdzDv2QJQRSw82/Csfz3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CZtL/2K6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pj8H4tch; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZtL/2K6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pj8H4tch"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F3221D000AF;
	Tue, 28 Jul 2026 14:12:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 14:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785262350; x=1785348750; bh=2vrLnVaweo
	yjEIU7INXebSVyb65a4Mg86BtoYs7Qvs0=; b=CZtL/2K6QTjekkS1E2ISvz8LDO
	veEoSLrHtGIL/5SRDxt3t4MzKLI7cAlC4nLB4Mcze+/AqjnGh5PDIJbPAFu2BZgq
	0rNP8n8bNo1ruY8jc0RJFKppBlPe4gPf978uZkrGq/REVAiXmDwb7d01Ct48Kw25
	rPqgwvMHxCJvN0xUl0L2w8R7RAG6CnvK0BY5Omk4ON8UtwEoBNks2Znbdl+/Eifq
	NcMDfyOlLxsuIxniVNOHaE3nQ2Ehbwk44qeED8qu3WW4YqXqvJQ/jUGBR+moH23m
	LEiIgjR8ODx9o2UD0bMQzVdhFGV4TlyDVzmXfifqO4b8zvL/PPSGgIyDb5vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785262350; x=1785348750; bh=2vrLnVaweoyjEIU7INXebSVyb65a4Mg86Bt
	oYs7Qvs0=; b=pj8H4tchaJcDMU2BlscCtKZ4aS17SqoWjzsV929lwy9ojJ+ESGi
	2BC9ott87UUlOcoTxRvDFnMZekro9izg1hHy4hCZNC2QUnonubd2pBtkP9l0CfnB
	A0d4n8w0JwpBYGdQ39yUmgs6tcwt/zMJtOTJrCIbu9/Q+QAXkndRC7YkQOCbx/NT
	PjmyEVPMKWgD8NHiOwh5+S8lMA/TyPrpBJPY+kHgxnDntH63QlcNCf4mXC7RN0UY
	anmlGgfzIEiyHrEh8Bigk5wvhQiKCDAIWxIYJ6yh4SI3cxe8jFGoiqNwx/Mh2FYX
	HbrHiwtjxWX0GDQuTEtW7rQOyst+TwSiK1g==
X-ME-Sender: <xms:DfFoajL8Uo8IE9ucCRP2g8ioZ_DvmhpRrek89uGWg8HOY2skIGgBtw>
    <xme:DfFoauINMdJg-ubGd8L-N7S1Xi0KHJEepMY1eAmZMDX6-YHvG9IdERFOV1ZBEE8ro
    bE5X54pUoHCM7-QlA1I18YRwQn0BTpmptrJBJ_UCdVq2iYhG7hGXg>
X-ME-Received: <xmr:DfFoagsDnscm6itB9wZlLqFplBvTu8tcwsBmfxXH-N6a7EGKaq2PSLFVokfIwtgh9oFrYf2Qs24BoJS48JuXF-E6kgwackMmaQ>
X-ME-Proxy-Cause: dmFkZTGDL2p+eacNVu1zhU6sGpWz63uxhNKaXyCqf7eBRBZ64BaBCJv7wRp6lL/Yi2OkZj
    Q5SV7RJnhPLBgBHrszOWsr9sdL61bGmSmYc3aVYxr0zitzMYtPABUUOWkhle79d9mjle1d
    VrN8XUxYPc19tnThg0DBZ69ub0N57BbhxkNwz1L6qLAuOQRTQGQvWevZUMGaLAAL87tONh
    x1WN7IoeD3mGmtO/ZFSO0vjlOPskxsme8sBPUALRShWu7wfz1utkjxb094FQganzM0Jawn
    /oZLS5ykcstgb7YZV269iSRtf6Cv67rQhmbFtdThJA4ztlYyJzsX1jN64Ame38g5nHoKBC
    eIvZuRBHVMMsuPrDI0fq9VSMtVbF+qHm/0tNw3xWQp++iROKXlerVuSTAIv8tvRLG8Nm/W
    IYaFIxeGmFnroaTNKhKJ8Jtx93sswZvAwtbS7fBEFZ2by4AU5FByvuqIkwRmZrH+oh8Pdb
    YcUZ6jz9laCTQDw7gKeNCwsvH3Wm78HyYWEJhBEs6NzE/BdMq3ahxa0ozVmHdspahgSD9k
    VKKQghSTEARuIgJtSINP1FlP4bwmAkn29OdgC5z48XObpDVBp+FS9c1FK+AkdbTJ5V93wY
    I2NQBBdHb3l65HsEFJOl00u2s6mTJkXeCDzFozwuXOccPqULOosDYUEUERzQ
X-ME-Proxy: <xmx:DfFoarQ7RyZ77ZSy4gcC19Qx_JjVsZred__urrnVznYPGzFf5Rh0uQ>
    <xmx:DfFoamNZKRsu-KcxxaBoD8pUw5JhVENrBe0POMhifod_dwSdHhsZzg>
    <xmx:DfFoagZPxEZyiOnIQRBBWw_Ct76kVb7-Ef-DkEHRehQ6aE1JEYop_g>
    <xmx:DfFoagwdCBaBV7aNXTGrV28bzwR6sn0XeBnZcv1Giemgs2NBJONE2w>
    <xmx:DvFoanCenIOm8zjZIfyUJRVW0lvmAQkJo9syTSNdZoj2gcwaNQ92a1iZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:12:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH] merge: fix leak with merge.defaultToUpstream
In-Reply-To: <20260728151959.GC41931@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jul 2026 11:19:59 -0400")
References: <20260728-toon-fix-merge-leak-v1-1-d6bd161a3acf@iotcl.com>
	<20260728151959.GC41931@coredump.intra.peff.net>
Date: Tue, 28 Jul 2026 11:12:27 -0700
Message-ID: <xmqqfr13dlv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Jul 28, 2026 at 03:00:04PM +0200, Toon Claes wrote:
>
>> The leak has been present since 93e535a5b7 (merge: merge with the
>> default upstream branch without argument, 2011-03-24). Although the leak
>> sanitizer was enabled for tests in fc1ddf42af (t: remove
>> TEST_PASSES_SANITIZE_LEAK annotations, 2024-11-21), it went unnoticed
>> because no test calls `git merge` without arguments, exercising the
>> default-to-upstream path. Add such a test in t7600, which fails under
>> the leak sanitizer without this fix.
>
> Wow, I'm surprised we didn't cover this case in the test suite.
> Increasing coverage is good.
>
>> @@ -1517,8 +1517,10 @@ int cmd_merge(int argc,
>>  		option_commit = 1;
>>  
>>  	if (!argc) {
>> -		if (default_to_upstream)
>> +		if (default_to_upstream) {
>>  			argc = setup_with_upstream(&argv);
>> +			argv_to_free = argv;
>> +		}
>
> The fix looks correct to me. This whole argv-juggling is pretty gross
> (especially the part below which overwrites argv[0]!). I suspect using a
> separate strvec to hold the heads would be cleaner, but it is probably
> not worth anybody's time to micro-polish this.

Thanks for heading off my OCD before it showed ;-).

And of course, thanks Toon for noticing and fixing.

Will queue.


