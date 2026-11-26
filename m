Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702419;
	b=32ruCzG+MclLnJv9zSdC2wtwyKbECYTzlpczWLTacOGiryJNpnh39FCOjvyYINuEiCEs
	 QanO5vn8jZDVUCByX/WQ/cBop611IjngtklrQoGqoYQEkmXa6qwJIq19EtL3CGnJmUiI9
	 ZGkmm2sUxgQn40au5QAMenYY1b6lTyeC9hoGltHqDxpZC39/BHGlnbGZR7LemzVg7LY3g
	 NDfFSJwJMwKJ6k/YHvLpfBu2fRCYZv4XaEvAlyNDY8nRgoYvJSD2N2oc7QAnsRtatShyD
	 KiUyRu82+NYHrSOWng1PmxJUPqc487idrSxY63opR0o7sR9QsR2qik0uqZxktVxsr3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702419;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=stA894KUFOejjkamNlesZS7I7AhadCSuhzhSmQ2+Hbs=;
	b=nGnoLO4QGLg1BixvgAnueJtIcig9992Rbk1FCGxl57Gi36MOuudnIXo8o0Pr3mTN+/6v
	 tXVCbTf5GWqLk8wUKoR6PZ9GAvjuhhhxNpqsQ5Y75bUDVrWuU/lMInPmzrmIy44E5Itli
	 sQW2AN0648HutpOFm3RwzA6agkLVF1tcaQKIoy27r7r/1SfSBIPhSZ3EoDmKceviyuIqK
	 w1h6HapKBQKb3y4j9d4HNz/fj/F8ZF9wyBQEv2k4D4tqW4IX/eV5jEcbG+d+qYxap3X4T
	 WgjWbVIv7QGxzUwKu91DiQroM3woy2p5ivYinlaMpuNZLpu+WQWjGA8qIdYat64aDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=Nt20DaSb;
	arc=none smtp.remote-ip=95.215.58.101
Received: from mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A5606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B7A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=Nt20DaSb
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A5dAvABrqOzBUJFlSqkrHeqsoTgygbXFXn68qg2y6vQ=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795702415; v=1; x=1796307215;
 b=Nt20DaSbumu+Rpb30jADAXboRW4arGf4ejPe983kH/meq3LIPkgbg/wwsCYvzIR2T1t9/4xp
 80mJgpTvXyRwGspy2JPwVz1S6G7sSXm8eevhgricQsMECx3kDpPlDaUnyvM7Hhby7wlwoMnGffj
 OI3Lh0MZAukLLzduy3IOwLdc=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ff9102e50b2d6c5e;
	Thu, 26 Nov 2026 14:13:34 +0000
X-Mizu-Trace-ID: ff9102e50b2d6c5e
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] packfile: introduce function to free a packfile
In-Reply-To: <xmqqecc9ncc4.fsf@gitster.g>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-4-19beb83b145f@pks.im>
 <xmqqecc9ncc4.fsf@gitster.g>
Date: Thu, 26 Nov 2026 15:13:23 +0100
Message-ID: <87ik1jsmt8.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> We have a bunch of callsites that want to free a packfile, which
>> requires them to first close it followed by a call to free(3p). This
>> feels rather leaky as an abstraction.
>>
>> Introduce `packfile_free()` to handle this properly. This function will
>> also be extended in a subsequent patch to maintain a list of all packs.
>
> OK.
>
>> +void packfile_free(struct packed_git *p)
>> +{
>> +	packfile_close(p);
>> +	free(p);
>> +}
>
> It seems that we have three kinds of free()-like functions in our
> system.
>
>  - Ones that make it the responsibility of the caller not to pass NULL
>    (this one falls into this category).
>
>  - Ones that allows the caller to pass NULL.
>
>  - Ones that not just frees, but clears the pointer the caller has to
>    prevent future headaches coming from use-after-free (the caller must
>    pass a pointer to the pointer pointing at the resource being freed).
>
> It seems all the callsites never passes NULL to this function, so this
> is fine as-is, but I wonder if we want to move it to the second category
> by guarding against NULL, making it behave similar to free(NULL)?

Yeah, I was wondering about that as well, because there are a few
callsites doing `if (X) _free(X);`. Having the _free() function
NULL-safe would simplify them.

For what it's worth, the pattern isn't described in CodingGuidelines, so
technically speaking it's fine. But I wouldn't mind extending the
guidelines to adopt the second kind.

-- 
Laters,
Toon
