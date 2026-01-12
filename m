Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E452F5328
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768187623; cv=none; b=qQn/JbyOqWZoFGqwHTIpBUUSdb5IV663nof9FNFvUy/7npM47HT06gaxwPaE9PzjrzyQFPkskYLx9gxzparMb076Fe4kgoEroeFXXOZY6dy1nHzJt46d5eZb6LlXVT8jM7sUlwBzYxHaqTbcSEjVWsuB2wyTZNeL7PZEVYz5gLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768187623; c=relaxed/simple;
	bh=w86wztf9oE/GVf6azmdNNkrFftVLkLbnTd5wi3I4NqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SWHy665ZaQ9WIlFsL/spaw9rUUW1sT+7XMjoCndla2rAtRD5QDD5gjaZUnMmL6Dom/8tH+j+RYKM3gxNmzvAh4wNGKls+jnod4wRDHr9hNZWbviEwyfzl+J0sTgC6YYELL610UEd+tQda2HXT0SC6SAqg7wSfqPh6ZpuPWDuJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cSGWo13/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bVMtKR5N; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cSGWo13/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bVMtKR5N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68DC61400033;
	Sun, 11 Jan 2026 22:13:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 11 Jan 2026 22:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768187621; x=1768274021; bh=zKTFCZvJTv
	/ZiehNvittvM88+dJ2kzF2phkTIHJY8a0=; b=cSGWo13//lmxpO8zmUh6h9Ycgb
	44yoEFVuK9fYOAjSKvAw7zrzbFqDB6PcdH7Uqn51SrGcTJSbhIsEPCacAH9jo9Aj
	ixnPbjFx/786dTamH1Fbf0nR3YR3gcyxpQykxEfrU4oVNAyuZZhJZ53eKSZFJSNw
	Fwb4C0Tzwo85J73RMHEOWQqFWU4dRsG0m14xrDPks92DqH75PD7smfJXliZooqht
	60j66MY7XlBEvBvXUN42Z7O2LjAjCdHhXeKesB0pDu5ChWf/pQfbvvWDuKZVHtNi
	9UX8Qf4yXL7tqjpiREuRJXWhH/mzArDrRuotIv6kxDPF4PMt+dR9pvI21jHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768187621; x=1768274021; bh=zKTFCZvJTv/ZiehNvittvM88+dJ2kzF2phk
	TIHJY8a0=; b=bVMtKR5NmPvsGFUZGYaDLsiS83Zs9BdRH75+Zd7mSE+3cDEBBK7
	gZDDn/EjWEhloeaWINySTh6/eNCwp4fXsB5yzB++oxRMWdpnFrgLKUmPmoE4o2os
	IVhz4v8z+PRWgWj0dXOqXhB49Zw3/IHbPvalCttYtrdNofMbnUn0sjR36TGJgxpS
	Rf6GRaa3jsnj4OkwvhK8Z+78WKcBhFw5yQDjQu/TH3jGGMBiP3zglvKfbk0iEu1x
	hUbVZn+C2Wlv+lDoJeS8uKcsGwYMq9pUCs2vDmvjkWsKTSe/meSJ38Qukp+ogqdl
	noGr74KA70rEezD4Ij3UrZjk/PE20dM/11Q==
X-ME-Sender: <xms:5WZkaWP_xDhqB3RxvApETfL624MxGd3tEPO_jzQXaqvESb8ZL7ODJw>
    <xme:5WZkacsyYlvSebZiDfxFSntt0onoKLH0wJn8Jim8V6EnxnRY2mxXYkG0HWP8x4W80
    21H0D0MAKiyOB7zGT47JMyv0_dRasDIJIJ0yuDIDfJn2sjWp0wH>
X-ME-Received: <xmr:5WZkaQV-92lZFmJpwfOrYXXFni3oNlid8Q8PSdSLClyX7mGN7leaLsUfGC4Khg8uwV3M1kKljuLgXQWpMeD6TIezPRlNKKayuu9PNFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehm
    ihgthhgrvghlrdhlhihordhniidprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5WZkaUunxgb2_FoEod5aqiRpKxZR4hNvYDpW2Xmjv6eWrwTyPwB6Bg>
    <xmx:5WZkacWm2Q2zN2FWYbthxeJ1Xz-S1b02kdI6wG5wrGOKXnRDZCLLzw>
    <xmx:5WZkaXnAS2gcdtkrCHVCaGV_dWXp-t0fvmcIWfDIjic9XwsFDQAfPA>
    <xmx:5WZkaVa3o0Itz487H5MWDWf5iKeRazOEE4TF4rwve6xuLbUfyq5JAg>
    <xmx:5WZkaceoLVUI8-WiScbo5VJX2KRaMDHayI9kLRPWebbAWHz_Ww2q7Wnn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 22:13:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lyons <git@michael.lyo.nz>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] doc: git-bisect: convert to new doc format
In-Reply-To: <20260111204316.836446-2-git@michael.lyo.nz> (Michael Lyons's
	message of "Sun, 11 Jan 2026 15:42:48 -0500")
References: <20260111204316.836446-1-git@michael.lyo.nz>
	<20260111204316.836446-2-git@michael.lyo.nz>
Date: Sun, 11 Jan 2026 19:13:39 -0800
Message-ID: <xmqq1pjvplp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Lyons <git@michael.lyo.nz> writes:

> - Change placeholders to glossary terms

I see you changed <rev> to <commit> and I guess the point above is a
reference to that change, but I cannot be sure if (1) there are
things other than <rev> that you changed for the same reason, and
(2) if "glossary has it" is the reason for the change (we have
"revision" in there, and it is widely known that "rev" is an
abbreviation for it in the context of these documentation pages).

You can rephrase the above, perhaps like

    Some parameters are described with placeholders with less common
    words, which is unnecessarily harder to understand by new
    readers.  Use <commit> instead of <rev>.

to avoid the problem, if <rev> -> <commit> is the only change for
this reason.  If there are more words you addressed, perhaps you can
replace the last sentence.


> - Refer to placeholders in prose
> - Delimit runnable commands and CLI args with backticks
> - Link internal heading

The same comments may apply to these three.

Thanks.
