Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD42857F4
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188969; cv=none; b=Kikk4tPZrFgraBw30SwFx02VPmmN4lraKvoMNtNU7l7fFbVJKHGDfNVFBLGB2KVdkrcli38kLupRgAylV6oqKgjOlKYpZd11hb5XLOdXQs+M7XyQL9DT4IL1gdeTEK9InDgHK2r8+ZjXl+Q9c6jZtYKeuf2hId1CEVccdts09/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188969; c=relaxed/simple;
	bh=CvFxzYZDTcxWi5MmnuXFBeiw4JL+9ffj5DFdqwDsM98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1J8lmbjFzunjYptPLTYL+9Bgs23d1d140iy4kXvIiP58BOo8agtFPiQmcskeJtyBIJnb1qCUXysp3UyZhVTC9kDk75rptsBaleyIJ5KuC/zfc8yrYI1cROtGVRGUypKTRwFcCs/hcmK9zX3Hv/k7CFL7abuHtSTf1hoxsX16Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UhGCckfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z3SCEBri; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UhGCckfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z3SCEBri"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81C967A002C;
	Fri, 23 Jan 2026 12:22:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 23 Jan 2026 12:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769188967; x=1769275367; bh=avMawZQHF4
	ad8wltQDU6SrLVQ06nB5ZRkCh/CJGf4zo=; b=UhGCckfW/zu2LAGgRbzvo0AvAq
	lA1O21a6qe1IpL8L0Wgps39ashWWSUbMzpJ3UNaoIRrIGDu6uHAtrEdjqDMj9VTF
	kNnHTPnlDq2/G9dEuTLxSCiAzz73epjoAviTKHYjTgcn8/K6llWjZEJfHH/IX9YH
	pNtbKMizDwhoZz+I5EPrC0xHXQ4cdMzL1f/S9227cdKNHI1RjjY48srzvHzoZyzI
	KjMt1kqlbyhYF5jp2z4J+vYH12DqaFWuBmVSDqL1/gtwl0er+S8r3CMm9yjgQTW7
	ZzTlhXgPNDlcMc05PCAxrbqFvEkIRK9ayoaHZjVJ5xnY+2jEEaVnEiIL6nGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769188967; x=1769275367; bh=avMawZQHF4ad8wltQDU6SrLVQ06nB5ZRkCh
	/CJGf4zo=; b=Z3SCEBriAzI32wTJzeOoKOIjkD8iitHVzTlpuYED7r3xGN01IU5
	gOSqbt7isfijtFN6Wnd7YViOz1BitbyjTpx3vBJE4bcE5qau/EXL4Rvl0Eog4nT+
	MjuKDdrS2WuiGBFfGqCVkUD9kA8LqBtPqnR2o9pS1k9EMRHctdCdQ372mdVstb53
	+6Y/aLStB7SJHY80bp8pzVwPPOXrx/ogtzNKVWQKiCy9Zri1slH3LQ5Q8hW+WkB9
	NyneEL/2g+LhTbtf0nUahYMUamhy+MMtsdBmLwyPpkfrSaT/JjAK1fcWWVVTu0+s
	u0nVwqfCc8Api1c9YOb9o9VZ3m8PqUlwMQg==
X-ME-Sender: <xms:Z65zaZNcB3xkPSSVeMQ1sBUgzhd0NjOdRgGV2BlhIZD-DSCHXCin-g>
    <xme:Z65zafOEUHKtwxq0_YwjRT_WOYBfaIZHH7F0rbcPOFaAx3i3lfZFNyrBEHtSNDCGh
    9tKg0ncMDyp3FtSd8I323-hY0JTes87_Fp-jBhv1sRTO92c1QL_Ww>
X-ME-Received: <xmr:Z65zaRtxiTYpf2sTWQgNZDSPFmL9jDBoXr__IDms915GxrL3Wymv8tVOT4JIijotP64knvsb_pOpalgYmABSC_p36YtdMbl3S0bhEz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Z65zaRXmaM0V8hNe11FGVRKfQkRPZX_RJC58gaew2p3aEtpRuQaiHg>
    <xmx:Z65zaRtWThAIWwSETCW6YAZDyfSWrm5PKSzysZ29AeHkvc-PWEdg9w>
    <xmx:Z65zaVX1bYvSNnUOpeKyI0sfVZRiz51e8jt-24QkShHjFkD91H7p2w>
    <xmx:Z65zacmTxmt5pTX80jd_baqSCAFkT9c4hKphTazaSJnT7yuHsaOZQw>
    <xmx:Z65zaTcaql3HTHIlbVZ9q3ppLsina5ociW4MRj8LX3uaeOjtzkB1j7Jc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:22:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #08)
In-Reply-To: <87v7gsiehe.fsf@iotcl.com> (Toon Claes's message of "Fri, 23 Jan
	2026 15:35:25 +0100")
References: <xmqqikcsk5qj.fsf@gitster.g> <87v7gsiehe.fsf@iotcl.com>
Date: Fri, 23 Jan 2026 09:22:45 -0800
Message-ID: <xmqq8qdoi6qi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tc/last-modified-not-a-tree (2026-01-16) 4 commits
>>  - last-modified: verify revision argument is a commit-ish
>>  - last-modified: remove double error message
>>  - last-modified: fix memory leak when more than one revision is given
>>  - last-modified: rewrite error message when more than one revision given
>>
>>  Giving "git last-modified" a tree (not a commit-ish) died an
>>  uncontrolled death, which has been corrected.
>>
>>  Will merge to 'next'.
>>  source: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
>
> Sorry for the late response, I decided to reroll this after all. Changes
> are small though.

Thanks, I just took a look and had a few comments on the first one.

