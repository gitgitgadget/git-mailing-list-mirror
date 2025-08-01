Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CE2C9A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754020034; cv=none; b=SafvPItesDvF1t3LQIJy51F1eHbs8DeFK5wCsP9rwmgs5TIIKKcc7/2PYDHx91t5SQGqbDHJKsvI69sNXNEyhahnwJuIlGRbLzqjtaPTUgobib0N35pm6QuTh3gbgKpSxcp+SVkoCBhdEHwS+0VImfnAW39MTOs/hkGhWWVYB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754020034; c=relaxed/simple;
	bh=8JIXUWAQBzZuCS4LBMnDtpd/EgnfDFxj1Y5vMN3Uk/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QqDhwSsQhI0Qlc2hfFxKmFy5nbi/58fWcJEKumVi9gPg9/ylBnnyjKGvtbFp1JUiPPiRTuWKpgNialEc0Xg0iQ1+UdIFW4KmhduFk5Eib7M44mY9dykoSYiRJO4RG0+jVz7AZUKxRD15kt7TVEUnceC24ipl1Ejt7tZPKLXQwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AXs9UaI1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQhAO+hO; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AXs9UaI1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQhAO+hO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 320491D0012D;
	Thu, 31 Jul 2025 23:47:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 31 Jul 2025 23:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754020032; x=1754106432; bh=rzqOexuaV/
	ZJ0cIMbQ+ITEka8mrzsTVJJBgKgm8kePg=; b=AXs9UaI1bnHuM+QNufMjlbvqxm
	h81J1R3YZsKfVa2/Ofq1xgnK7xHuZzNVr+G7Em9VO+ZOl0l/lv87r+jOHytUAP1Q
	GbM3hNwWZECDlCeh2+WWbammeDvaGtXR1p2fmD7/bPmAsFeCUVgaA5/aw2F71rMe
	taW0b1aJyOfjzdClzrUBPZSASBQY2OFA+BlKDr0hdyDSA4MeOsUuav7RJteG/TF0
	ImX6g0Dg13IkV/XvyEzUqy3y36yRL17FezFp1g8Wf1pYVUtUe/Tb04iD0SRlRHG/
	yQvN6MNzE5bt141CkOh2LAIv1xjBqEGsjGesLLmLyJVL80VqYm/aqi1idYnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754020032; x=1754106432; bh=rzqOexuaV/ZJ0cIMbQ+ITEka8mrzsTVJJBg
	Kgm8kePg=; b=TQhAO+hO98vBMJ/1TVGvrZH+8kGRInoLVu3LURZjy7P+iRb1TDd
	NbFAsmXGO0Vfy+hiqnqfqWWj9HjlTdb59wHpYluZJKqr1J/e04UIq7PFFP64Mcrd
	cixr0IVsFJ5BeGhUURwEy8FO5A9X2VKmUGp5A385c+12Cw9Fkcatzm4KVzvp2UPR
	DC7GCgFt+sNley2gjDPnMQpzLenbQNIpd9doWcfVGgV3u3WCfhGerP3SM7ybnWC7
	ARRXYlA1INCMEmvbAn8sv54Lw0VsD5QqS0Sn+gHkjk6va/rnzljFDRoViH61nPE4
	No6kFoO2kX5Vi2UXNBkQEjUXg7EJiaC5PHg==
X-ME-Sender: <xms:vziMaOQrdN9Yaj-RYOtU6RHfwA8zXcllHbXHSmTH2744zJC4GW5f7g>
    <xme:vziMaHCQk-YTn0hzVYs0KTln1DYBKQsbCab0Poc-7PCiLAv-uw2MaD-Hh1XwCoF2N
    F55D4bdOzCKT8dyLQ>
X-ME-Received: <xmr:vziMaFSjo_DJPTACIR6S7LTwM677rQjmV6e5zr0NdEMtCl24jXFoZ6c5XoZtlG_ma1ronMR840lT2QReUpEez72wTCJiNw0nMo5UwBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vziMaFp-O06fPateX-uewXuVjY93cs-ftmgEF1m8n9IGeMtakDX7eA>
    <xmx:vziMaHwpY1TWJ1Tk_pCpEZT2XT0NIJaFK_t1nMNSrAFBCDRSynIrBg>
    <xmx:vziMaKIboTk6JJ2lRKrT_qirnZrMYPjewixRdYz-N7AaEd9-H4WzSg>
    <xmx:vziMaJIQ86CW8uSKliwI4uz_gNT4hNC1om-E8xkLMcpEDHWopXfKJA>
    <xmx:wDiMaPrwxuZ0ilDRmBaVplVTRoIcOE6FQsIcva5eE3KqcEkEvFdRzdBi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 23:47:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
In-Reply-To: <aIwyIJqEIdSdKINz@mbp> (shejialuo@gmail.com's message of "Fri, 1
	Aug 2025 11:18:56 +0800")
References: <20250731063949.1601669-1-gitster@pobox.com>
	<20250731224607.3942417-1-gitster@pobox.com>
	<20250731224607.3942417-5-gitster@pobox.com> <aIwyIJqEIdSdKINz@mbp>
Date: Thu, 31 Jul 2025 20:47:10 -0700
Message-ID: <xmqqcy9fog8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Thu, Jul 31, 2025 at 03:46:03PM -0700, Junio C Hamano wrote:
>>  static int split_string(struct string_list *list, const char *string, const char *delim,
>> -			int maxsplit, int in_place)
>> +			int maxsplit, int in_place, unsigned flags)
>>  {
>>  	int count = 0;
>>  	const char *p = string;
>> @@ -320,12 +327,18 @@ static int split_string(struct string_list *list, const char *string, const char
>>  	for (;;) {
>>  		char *end;
>>  
>> +		if (flags & STRING_LIST_SPLIT_TRIM) {
>> +			/* ltrim */
>> +			while (*p && isspace(*p))
>> +				p++;
>> +		}
>> +
>>  		if (0 <= maxsplit && maxsplit <= count)
>>  			end = NULL;
>>  		else
>>  			end = strpbrk(p, delim);
>>  
>
> In `append_one`, we would tell whether `end` is NULL. I somehow feel
> strange why we need to do that in `append_one`. Should we just set `end`
> to be `p + strlen(p)` when `end` is NULL. And then we could do rtrim
> inside this function instead of `append_one` to avoid passing "flags" to
> `append_one`.

Sorry, but I do not see why such an alternative design is a better
idea.  The helper function's purpose is to stuff the substring at
[p..end), possibly after rtrimming, to the list.  You could compute
rtrim in the caller, but that would make the logic here more complex
(at least, you'd need to introduce yet another variable similar to
"end" that points at the real tail of the string, and you cannot
reuse "end" for it, because of the exit condition you see below).

>> -		count += append_one(list, p, end, in_place);
>> +		count += append_one(list, p, end, in_place, flags);
>>  
>>  		if (!end)
>>  			return count;
>
> Thanks,
> Jialuo
