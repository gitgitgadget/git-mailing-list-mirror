Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE511DE8AC
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097078; cv=none; b=CJRcLVF2ObHGaKvW0rvViWp+7hrt+jzLE7EFKlk9q8bvd15XA3HfrrcSQElNQYP+D1GpMAlOeukNKJNq0WJI1ftXvBfuNFCEt11AYtSFcCLJoptQ8AubWG8o0R92sUkCPVWqC5hAeOnaKGKgrkZ+AaldvdGQokqjF2GgGwD9vQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097078; c=relaxed/simple;
	bh=33X89F3fArurEViWdOUG5Q6LUsYUrVZCzqe9XaL1YbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hqsol0K1t6nLHc397496hGYAEDfyQKWMs+UJi8PFVgKgaGt0PR2zOIcH6/pLcL1Kfs9bcWGhWS7E9NvTZ4l8FYu5CdwuXkSoL8niymRfpxhqJAb/ZVI8aeuQX2Fc5HxbIZlrVVKB44ACrK8zvzqb83cIwWvoEtqnOlLwi04aOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SELxa3r1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5QtJsKh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SELxa3r1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5QtJsKh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D96F0114018A;
	Tue, 28 Jan 2025 15:44:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 28 Jan 2025 15:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738097074; x=1738183474; bh=77/HbMHVKF
	uKSW77bzY1WPVblSal3qDphNk9BVJqEJM=; b=SELxa3r12rSMWrQnrTOOSUK9Sa
	F9b90P1WamM9bDRVdwinYPwR1fPB7ikjbZfDQo6JngGeUB+EOYYWQ34mryl5taqW
	oefLnDf8ayTvyOwo/5d9GWP3Po2m9dpqQwcI9raLq3+GhnEglbkEbTPdbcVXtxWc
	ix9wcFYBddfMjBFmT5b50r89pFCO7xDVdObnjh46ummbxT0o7Prj+wJRUpe/ZZDi
	/HIgB85+cIUcxkRX15epomHajupWVFLi8N3/wfMaYrMaWlQtPDrUMD+t6PXw/mgS
	vpg3YsDekPiqH5C9CvH3q0Wa3ylJWE29cxQMbEdI9ldR+EgyhZhgi3XyL56g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738097074; x=1738183474; bh=77/HbMHVKFuKSW77bzY1WPVblSal3qDphNk
	9BVJqEJM=; b=U5QtJsKhCM91UIe+7FQ1eEoKUJ7X6vdY6LUlmfX0GX2xB1HMrxV
	8RocOSCHIv868/OYTcpeH1ma41q29pFW5odwiggQuG++ZuuOphtRyqY/qoV2VPao
	y1dkoL8MLWKYVf4nyOnyxG5sRtiQggtALXF45rfH8Jg8nm3LCWIZGd3S5bJ8cxYf
	B1iHJXp1S7Aly5RXCwAu0w+XTQL6hknOASvBsAL45Mo1ZXZg3mgih+Yk5Fcb//au
	h4Dj+hNZkHhsADvjs3JFih/uEQenKQCeVJHSCqO1h4VPzH2ELRvOn6Y6hvzC9avQ
	OykpkogcPlwtt+kLEV6YnVrCWirJTPxtZug==
X-ME-Sender: <xms:skGZZ8YXruazHzd5EWK23GmIUOEiXRkoETKaPPq2XSZaB7kJ6UqMAA>
    <xme:skGZZ3Yf-ofx2MI6f-1kL7ZJ8yDjoRUjhyL6TwahKTXBcQY-iAS3pq_AnCDOgKJts
    xVM4ydwBcHA3eyx5A>
X-ME-Received: <xmr:skGZZ2_B6-m18wj4YdFdgYl3r9A_GBGOw49Dqo5OSuBpEzuvjG01s1kY7UCU7GJ8dXykWEMFMSBwPvxAS220DmgsUoVyCy31FImN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhrrg
    hsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:skGZZ2qCYkKIlMUPqjYOsFxZaCZd57qBFSQWmUL0YTVd0j9n6iLS-g>
    <xmx:skGZZ3qHGCeAEF55SY5Opgwb9u8tlPH2LHGHFbPUtUzyAg98XoDVfg>
    <xmx:skGZZ0Tnh-A025YZ6msHITnMeAi3l2odddnYlscqw_WMJki6xn2xBA>
    <xmx:skGZZ3oh8lDCql5RAsnAwjKR3fp4dCUI4UaiZp8HQ4VKCWzrQn_gkA>
    <xmx:skGZZ60RJZUVM2gmIX50zLErrimuO42orwY5rKrLqZGBbTMClhSxyF23>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 15:44:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  calvinwan@google.com,
  nasamuffin@google.com,  emrass@google.com,  sandals@crustytoothpaste.net,
  ps@pks.im
Subject: Re: [PATCH v7 2/4] libgit-sys: introduce Rust wrapper for libgit.a
In-Reply-To: <ghkzloozvlb2hx5jxiqjydifppwu5m46rotjqirtedmyqowngv@w3rehiaqhskr>
	(Josh Steadmon's message of "Tue, 28 Jan 2025 12:26:58 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1738023208.git.steadmon@google.com>
	<f1502b85901d81889d86597f31eca40e1965d56f.1738023208.git.steadmon@google.com>
	<3559a70c-7ed3-41cd-a45f-390134218c52@gmail.com>
	<ghkzloozvlb2hx5jxiqjydifppwu5m46rotjqirtedmyqowngv@w3rehiaqhskr>
Date: Tue, 28 Jan 2025 12:44:32 -0800
Message-ID: <xmqqzfjamzwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> On 2025.01.28 15:08, Phillip Wood wrote:
>> 
>> 
>> On 28/01/2025 00:19, Josh Steadmon wrote:
>> > Introduce libgit-sys, a Rust wrapper crate that allows Rust code to call
>> > functions in libgit.a. This initial patch defines build rules and an
>> > interface that exposes user agent string getter functions as a proof of
>> > concept. This library can be tested with `cargo test`.
>> 
>> It's great to see some tests. This is looking good, I've left a couple of
>> small comments below.
>> 
>> > +contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
>> > +	$(LD) -r $^ -o $@
>> 
>> This is a very long line and the ones below are pretty long - perhaps we
>> could put the list of sources in a variable?
>
> Done for V8.
>
>
>> > +contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
>> > +	$(OBJCOPY) --localize-hidden $^ $@
>> > +
>> > +contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
>> > +	$(AR) $(ARFLAGS) $@ $^
>> > [...]
>> > diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
>> > new file mode 100644
>> > index 0000000000..cd1602206e
>> > --- /dev/null
>> > +++ b/contrib/libgit-sys/public_symbol_export.c
>> > @@ -0,0 +1,22 @@
>> > +/* Shim to publicly export Git symbols. These must be renamed so that the
>> 
>> Style: Multiline comments start with an empty "/*" so this should be
>> 
>> /*
>>  * Shim ...
>
> Whoops, fixed, thanks.

The series is looking good and it seems that we'll be expecting a
hopefully small and final reroll?  I'll mark the topic in the
"What's cooking" draft as such.

Thanks, all.
