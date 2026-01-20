Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D047D93F
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942478; cv=none; b=EcCJvveksbYq+E76Wz4FVQAzJ4Yv0rXgMJo7jI1ZdPZJn6MSPnVhjjonz2GN9+SgyV5xvadKVaZDSo+UhhlB9k31lyHW7BR5qs1QN0Rf5lULnc7FWdIllTln/cuHGTFJd+0mGhK6by5jJuczqp/igK4EPSdI11AQ2iiBp47Btvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942478; c=relaxed/simple;
	bh=iybWSmxv23PW/Mx9RnND5xhDNyf3xq48f4yyg4McRes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/uWFU7d6fdoBGngCvP/hZuqUvf+saE5oq0qW4fjwsdaq2g3mVNBDn+ZIH41EheFggvS3WAYTNe75RS6JEthMtXu2eXcmjXkvRf8NZucZrchbDfbzkRJfV5metIPj+ARE1zIQdI8fWV1xfMjjYT3ObbjcZBCpzJ5jGqg6ir44gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h/juXEvE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AaR/2v27; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h/juXEvE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AaR/2v27"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F90F7A0113;
	Tue, 20 Jan 2026 15:54:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 15:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768942475; x=1769028875; bh=yTMKDNUA16
	6111HtbkTVEGMgBSKxq45wAkZfp8iEngM=; b=h/juXEvEoGicCfHKrBvLodJg1B
	aAyNu0Nj72EsalzRWU+ACczIOkC8jA0L530AQeOf0aL4wYA4SKev9LDnXvluya6I
	nyRJJEjyMAujqAVBCNVmdVuWHCyWyOThfAcRDvbmh6wFVd2hcyanOx/heSI8r2IL
	aPwIFZ3jESAXF/52xlAurv2+EnrDvCoujuVgR9322cy5/5nP3Rj5vDIyp0Qd1Bu5
	hYFlWHLA0C3rf+jefuS2OntNPi32myC4Mh/OYJNAa23K5D1so7Z5DeaR3LuB/OUK
	4cNQ1CE+TpXyZgRj5PqFQ+x+3mz5NpdDWgEaEYMtf4nITlmhcMB2iruO/KYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768942475; x=1769028875; bh=yTMKDNUA166111HtbkTVEGMgBSKxq45wAkZ
	fp8iEngM=; b=AaR/2v275oCnsHs6HI32O/U0wdd5FB8C1jMrKzp6KikeOnQsEgi
	lVm78rsK9xZ3kopxu7NqD2ifrZmCtqzUX/G5eiOlyL64SFwY9JGJNq24zRNqENIe
	q6TnuWaX9gNceIDt7Fqs+MfMi58iXEDF7QS06bNpN9putqzl+MY5qEV03xE3J8zi
	GOahIjLj5pcmI+KrtGF3V/YxTckhwW+C2dWLJFuu4hgvw2U31yxl8K2EkS9kK0Pr
	ZfvGGYQO/nMprGSY8ZMJclQkoQBWCdeBL9XM+X0B1llj6eBPOoay8/FTy2DbbmGF
	B8otBv0gy2RbZDSocrw/rbP0aqlH1VGjCzw==
X-ME-Sender: <xms:i-tvaUlZ2l_8d7jMOr8GmjOvi4BvNBaW5eGQ5cA0lJsAONNYIQWMGQ>
    <xme:i-tvaWGeSZhyeXDLPBIGzvan0_4s1m7YpcvXoeMC8FZTnEFl_RdITz0Yu_00Lkx2i
    ujOSaabMBXxPS23tNNQkTQ81fmaYqWGogYmwk_YIbX56tvnI1hIwA>
X-ME-Received: <xmr:i-tvaU5xUwb7o7WjsF2CLmLU7ZAAwltF08Q1O0t1CBQLDZZwcDHb6SJZfa-xxOYbMOhkma6J1puXVWfXbf5INXO1GhwVN5AHxdgPgx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtoheptghmlhhishhtshesshgvnhhtrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:i-tvaWnA6k-cpDv_ko-g9z7AtjwJdkRKwecp0GVQULncliKZ5xbNAA>
    <xmx:i-tvaRoXU6bVgHnvuZKfAnNjXhK2rfZ_rc5aqW3890Hx3mTDcPXEoA>
    <xmx:i-tvaduRZ6IFlAqcRTgLpOTZXYkR_dEpcz5oC2FhAhFnydHIPfYOuw>
    <xmx:i-tvaeE34gZCMHom-PA9IX4abn8wfRLzzSXn5PjFv4vDSOjztozaew>
    <xmx:i-tvacGG0M2fdZwdlrQZ4HDOQt6twj2z61ckfTC-vOGYr3VJhlarrYJD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:54:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,
  correctmost <cmlists@sent.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/4] parse: add functions for parsing from non-string
 buffers
In-Reply-To: <4d83375b-76e2-4420-80dd-6a04d3201532@gmail.com> (Phillip Wood's
	message of "Fri, 5 Dec 2025 16:11:15 +0000")
References: <20251130131351.GA198697@coredump.intra.peff.net>
	<20251130131537.GB199335@coredump.intra.peff.net>
	<4d83375b-76e2-4420-80dd-6a04d3201532@gmail.com>
Date: Tue, 20 Jan 2026 12:54:33 -0800
Message-ID: <xmqqldhsxawm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> There are a few choices regarding the interface and the implementation.
>> 
>> First, the implementation:
>> ...
> This all sounds sensible to me and an does the interface description.
> ...
> If we're parsing INTMAX_MIN then this negation tries to calculate 
> -INTMAX_MIN which is undefined (I've added some tests for parsing 
> INTMAX_MAX and INTMAX_MIN at [1] and verified that UBSAN is triggered 
> when parsing INTMAX_MIN). We could do
>
> 		*ret = u_ret;
> 		if (*ret != INTMAX_MIN)
> 			*ret = -*ret;
>
> but I think it might be easier to alter parse_from_buf_internal() to 
> make "negate" a local variable, change the function argument to "bool 
> allow_negative" and do
>
> 		*ret = negate ? 0u - val : val;
>
> Then parse_signed_from_buf() can do "*ret = *u_ret;" to convert the 
> output of parse_from_buf_internal() to a signed value.
>
>> diff --git a/t/unit-tests/u-parse-int.c b/t/unit-tests/u-parse-int.c
>> new file mode 100644
>> index 0000000000..a1601bb16b
>> --- /dev/null
>> +++ b/t/unit-tests/u-parse-int.c
>> @@ -0,0 +1,98 @@
>> +#include "unit-test.h"
>> +#include "parse.h"
>> +
>> +static void check_int(const char *buf, size_t len,
>> +		      size_t expect_ep_ofs, int expect_errno,
>> +		      int expect_result)
>> +{
>> +	const char *ep;
>> +	int result;
>
> Do we want to set errno=0 here so that we can be sure it has been set by 
> parse_int_from_buf() when we check it below?


After this message, the discussion stopped and the topic has been
dormant since then for a month and a half.  I'd drop the topic from
'seen' soonish but that does not mean an improved version of this
patch is unwelcome.

Thanks.
