Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A299463
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240072; cv=none; b=pb6ZqWokQ+gMx/pz4/aeY5kch9YIMSWQnWDiHrXj/nuLGeUc3CI9IiPur8sAM2DOa31K+ZBfOo/Ar9gywP/EwN6tyTEfdCpRlO535FPbB3QG1GtLybTWUzbj1fLoQe+KdU7J3zbH8aYyp0HvpwEP/3ObBUqIrFLwy+INzx3Ig2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240072; c=relaxed/simple;
	bh=WI9CqmiJK6A1kXiFZHck7yQHjTbRzltMZ7pk0h7VdsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IoTgFmfnqbwZbDLHKH4pKrHYLoGrSLHv2rAkYQhoYT8Bt0aC1lc8Um+CbutI91yatObhkLgeyUoQicnqLIcEFEuDFA+Q3CQp4/NpHnzXmbrz84oRrSa7GHcWo/R5RlIvL9Rw0X99RCwkDGJl95d8lKObCy5E1v5lCFPU/hyuKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sANC75xQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+QzkUaG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sANC75xQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+QzkUaG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C6FD1400032;
	Sat, 12 Sep 2026 15:07:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 12 Sep 2026 15:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789240069;
	 x=1789326469; bh=jXcXChSXMWLGFbvzQDWpeRm01ecXJ2YI78VAqMTWVcI=; b=
	sANC75xQ7dc/yfWkx6Q9jlivTO0BcElvo48oNCdQ4t4M4QOdpv9CB3aQwaSXU9mM
	7X9fTmNJVCb0z3BAx10xAkjg7uHc6OrozOZ+YTt9o9Vthnn3IyKAqhM+TWtXQ3ma
	RYNANIvL4S5Ay2pzvWECrw6NqqXBfhAfvRT74OZ4uT1pCdHpgcMcDA8lsS2yFfQK
	4cDYM0cuCmDIfX0R87jsgSbE26T2DYtXGTUz5h/JzIbfV5gQvCzp0kiCXHkPvSQO
	Ej7Dfl5Lm7bPdCsOFT7HKlc1mWHpQVCFO90eF35TAFjcdxQ7BVMsmlPh2RZUPfk4
	hw1uQRWl+w+Ggsi+SV1nGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789240069; x=
	1789326469; bh=jXcXChSXMWLGFbvzQDWpeRm01ecXJ2YI78VAqMTWVcI=; b=b
	+QzkUaGcKEU55LOvJwIlrxprGOEfnVaN5x7G8mWnjY18CjrcZCTCYVuVHNiy48N8
	nADZMtjOsuV456pRw2Vkjy0TU1mVdBYsO/4+go7XIe6YGpNRA+i904xRAnvp6e7m
	1Dn7D5p9z4ZQOJKGiTB7NEuC7WvfLJdek8VVXtj42pqkKJXSSaH6wlSvf7JYIhBw
	b0j8okdTHfM/24cFvaNNnmfuKBsp72SN4mcluEuDe/mQZQoBhyOHv2SPUZ3J/T/C
	+rDOTnEiQoojdVnaJejMUUMX2+Me4heNS2UYnhY/UqAHSI6Mee1TIVb9vPM0sNuq
	L3CFMX4DeXJmIHKQZXwAQ==
X-ME-Sender: <xms:BaOlapuDaE2LqZGmzw9Nea2GJTfRurDWj02ZM7FHfCceIhAyd6VWGw>
    <xme:BaOlap5Cc0qQbN7gaaPVvotQAJlUw5jbgWXOhzqMCr1ld8guOZz-XC4URGfIuKori
    NJRk6tHDSQvBw4LbPoR5HYkL2cnGIoQW_JRcUCG-W_2SLAVY4ijYgs>
X-ME-Received: <xmr:BaOlaqJZE-M2uTnyO3aHY2aceldpV_hagcKB5jERK4vts5at6D0P6BRtMAXRwFrGi_dFNYX_Pm7kH4CaXtFUeSSu3YE8f_UOo8ks>
X-ME-Proxy-Cause: dmFkZTGGa7p5g9/qUcWAnuiVJepWbTITMw7dGpi2n/KlM3vHBu8ludVhBPDMoHr5SCBcqL
    5i/CKgSaQfxRiz8tL7eOo3OC5Qlap/44RyYMFDBWsf0N70KcfPwZUgeQbbau6KgTDTjBPo
    hG3HbbL/p2VRBodqcTEipwAqhVpTrlxfwRJGhVFkkJAzlq4XN2kSMj4CeI8qLKSmJ6jJ08
    z+H0jhfH4lY7aPxMpm2hozz8GLDt6Ru2ClI4klzLL7fuaFdrILq9xbQK2mPRWDgmRlqZaa
    6EV3uQH0tG2526JIVGLNTpk0EZ6hzcuJEfYGOGKVgCnabSsBE7HQAGO03MKhtSbboMSZjS
    +/V1l8Hn3vcEesNfoVQQEqUQcCGNU614Uh2QDHnxyXJyDjqYsK5M7AlKMc6b0FaTPvE3R5
    EqLe08EORB06dHhJBTpzPMwU5EtNopTv/LR9ksUzDDjBzInloVY9+6wq4N3xKS9AlRuDxF
    bRqHGx3Mh8WipJeuQfp3ho0u3+zhXpmyXkmaoST7rMlE6fHqAyfGgfIiTEfP5BHSWkP3NC
    6CcyKeKKixzfRNj+CxnLFYGUzSkUdbm2FZLLqya59YzFT39MkwOb1FYfUMAKQE8EC1cWY0
    aSpQ0L/Z/FqMyiCGmkpw/6ueQS0KvB8jJIqyrAcmjOpHn59yXwAXQbWYUjlg
X-ME-Proxy: <xmx:BaOlap455xe23k0Sgxrocn02lorT0Y3Js5G8zp85pmc5seSlV5Xo1Q>
    <xmx:BaOlatz3QHcbTBX4LmYoDEsbrT7VPKQW0qMsA1JhBFa1JqaFTL-UPg>
    <xmx:BaOlataxunahQ6ke84QcmwGsX3McMj9AkH9e-Pr2j-m4YnOMw_FAVw>
    <xmx:BaOlavQFXzzHmzgKQYnijpDu0mslbcUvWk0GKM8IbDAgPm25AxrcGw>
    <xmx:BaOlahh9yA0bT4qfKDUzCqyJo_SXOu7zFCbeaQEKjQxHs4rQZmGj6BYz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 15:07:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] cocci: remove risky "if (!E) free(E)" conversion
In-Reply-To: <caa39ca4-b35e-4fff-80fb-af6856cb2098@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 12 Sep 2026 09:13:29 +0200")
References: <xmqqld978mok.fsf@gitster.g>
	<caa39ca4-b35e-4fff-80fb-af6856cb2098@web.de>
Date: Sat, 12 Sep 2026 12:07:47 -0700
Message-ID: <xmqqcxui8f0c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 9/12/26 12:09 AM, Junio C Hamano wrote:
>> The current cocci patches try to convert
>> 
>> 	if (!E)
>> 		free(E);
>> 
>> into an unconditional call to free(E), with the rationale
>> 
>>     cocci: detect useless free(3) calls
>> 
>>     Add a semantic patch for removing checks that cause free(3) to only be
>>     called with a NULL pointer, as that must be a programming mistake.
>> 
>> which came from ec6cd14c7a (cocci: detect useless free(3) calls,
>> 2017-02-11).
>> 
>> Leaving _something_ in ALL.patch output to draw programmers'
>> attention is a good thing, but this changes a piece of code that is
>> originally a no-op to do something else, which may be even worse.
>
> Good point.  It's likely that the programmer just wanted to release the
> object in question and got the check wrong, but it's also possible that
> the free(3) call is wrong as well, and that could do real damage.
>> We could change it to
>> 
>> 	if (!E)
>> 		BUG("free(E) is certainly not what we meant to write");
>> 
>> to force programmers to think.  But it probably is safer to just
>> rewrite one form of no-op into a simpler form of no-op.
>
> With that last sentence I expected the patch to also remove the free(3)
> or commit_list_free() call, replacing the no-op with nothing, which is
> safe and simple.

You mean

	 if (!E)
	-  free(E);
	+  ; /* no op free(E) */

or something?  I guess we could do so, but I feared that a compiler
that is smart enough complain and trip -Werror on us when E is too
obviously a side-effect free expression such as a reference to a
simple variable.
