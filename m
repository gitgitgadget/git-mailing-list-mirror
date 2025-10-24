Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595FBA3D
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321969; cv=none; b=M1vr4ikMV7siFOzuoB8uFXgsDizPqabnaG8KHqHX41pRsFccF1i5sr8wZqhdvEg2tjZ1fDyoT8Li6ivB8OZc3B8VHAZf3yevUsY/iZwYQRCc8Cr/t+LzLWcVWJsFEA1srhxc5viMNx/eJkdvRf4hk2A08g+h5iudQXWAoW5qLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321969; c=relaxed/simple;
	bh=H5lMgxMh77nE7JwHrLANYGJLw3P2eEuRf9QS+vi5ew8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jZprSjjUpQAEyRD8ImhH2oZaP7rZfw85W9G5xKPbqr7OLOppTFJ8kJ4uMb7IwntGWqhFDXxdVp7tiEynBNKHJvUgegnwonjMiZBqwhI7rIcD0DeNbUTm1kSChR6qVvESdDzdxdYwMYIBsLapHhQHRl25HRKq9cKc4i4FJdtyALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b+NqDrx8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJnKXvd2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b+NqDrx8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJnKXvd2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D78F1D001C8;
	Fri, 24 Oct 2025 12:06:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 24 Oct 2025 12:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761321966; x=1761408366; bh=QfBxw6+9b7
	M9UygfUNHhon1NlmA2ZJISI8C9ijS6eVo=; b=b+NqDrx8JtxKN6+R+Opm4D9IWe
	aTcvIko9+OuWUK3bmWWYWbWsa/BJY1XsB+5ZG0GxPuaBUm/VaFLtunuSPGLCwGek
	HU0mkhu4JyxLrzNrdO6Wzvi8efSRw23DhUUGdneUOdoVR7DSkH5vMo/tyg98+2sf
	CQYJrbpZ5bgO6S1vJMLS8U2yvhFlhpqw4jXZN2OzK8zrQ81TDmmE4ubvKClfFsEK
	WDV/zzC+HyC9OZ+qxjWi9rKUcWik9s87bdV+A6tyoqgW5YYRWTzZdKh6JaYnSc9r
	k+BY75NUjjv7JB5Lx4rxf8jH0jf1sNmS9JMJE/4kC1GwGJ744XFfP+1U9XaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761321966; x=1761408366; bh=QfBxw6+9b7M9UygfUNHhon1NlmA2ZJISI8C
	9ijS6eVo=; b=aJnKXvd2GLOu7PYB3ZIsQhHuFc3q7eeWJ0h9t47T1BoBrAskdfn
	qmLb3reBpz13w1J5A3FC93P/YEKkW/Z4jf+v4hw57rtNcF3DSOix9C+4qVqvAhjh
	nB68VOAnHovmcafxFE5bAdbI6lUgAPnW1DJg5C99YLLwmzD2JCAgTiMcy0tFNSFq
	GUy2jkcNky9fiRix1JUQsUlRpWV2725MLex5ssHEWN1E7mPcDlSXFgrtGifO31fr
	h90eeG1vTFqikC730AKdYWJR4RhpzQ6UXg0gcvQrM4rVG6Oe0Oewa1F7RoRnB9gL
	N/g439H5d4WG8z8wVZzWHJlKCmEz/VAfw/g==
X-ME-Sender: <xms:7qP7aALsrodJ_WBlJ8VJmVG_JmYMvP1HRf42V34aUfLsV9StVkI1yg>
    <xme:7qP7aHlALu35FXb0ZF8oQGQglfSyA5vm0NT45kUziH6O1bToQBXkXzJdPIlm9wStB
    cBVshgtbU6TRR973hjHJqBBNEoLwQ6u3ZdeFGxubtN54QuTo9tSrw>
X-ME-Received: <xmr:7qP7aOExqBws-KefQZmo-fnTLBnsqtdT5gbAGULn9FvvU4idy-Qc2JHhirgw6-8w1Ut_gJEf8IkyQrfP2ilJk3wxrvcgumI27YYv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7qP7aHHmo1LxqCdbIdMVM2WCfTnjbn5_6Z4bxFT3kARlF_hMOzcOSQ>
    <xmx:7qP7aLMfYEnm5z38n3OZ8wjzBLiVBKvPMkLiasconm5rNy2VyMAkQg>
    <xmx:7qP7aGHS_Rcx76P-u9IX0WmNKbUBu6eIYI5aajCHE1QRZtrm9BL9Tw>
    <xmx:7qP7aCPDVL_UuHKQqC8HbUUkySEUP5fbLMOlJgttvoVGjbhm7PXVlQ>
    <xmx:7qP7aGV3mUus7sW2wtxjcDXhQ84C2KYRSLM4GLJXtY3RQ880Gxg8NV5Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 12:06:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #08; Thu, 23)
In-Reply-To: <20251024154719.GA1779502@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 24 Oct 2025 11:47:19 -0400")
References: <xmqqy0p1qjha.fsf@gitster.g>
	<20251024154719.GA1779502@coredump.intra.peff.net>
Date: Fri, 24 Oct 2025 09:06:04 -0700
Message-ID: <xmqqsef8p9n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Oct 23, 2025 at 04:36:01PM -0700, Junio C Hamano wrote:
>
>> * jc/diff-from-contents-fix (2025-10-22) 1 commit
>>   (merged to 'next' on 2025-10-23 at fae07d2113)
>>  + diff: make sure the other caller of diff_flush_patch_quietly() is silent
>>  (this branch is used by ly/diff-name-only-with-diff-from-content; uses jk/diff-from-contents-fix.)
>> 
>>  The code to squelch output from "git diff -w --name-status"
>>  etc. for paths that "git diff -w -p" would have stayed silent
>>  leaked output from dry-run patch generation, which has been
>>  corrected.
>> 
>>  Will merge to 'master'.
>>  source: <xmqqy0p4wcac.fsf@gitster.g>
>
> OK, looks like you picked up the fix from the last round of discussion.
> Good. Is this destined for 'maint'? My patch fixed the regression from
> v2.51.1 with "--quiet", but I think there is still one for "-w --raw",
> etc.

The plan is to merge "j?/diff-from-contents-fix" down to 'maint';
any other changes that tweak dry-run are to be done 'next' down to
'master' but not to 'maint' as a longer term "true fix".

