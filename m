Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883122A7F1
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636756; cv=none; b=smBXn5CKP0znToYfNgyB9qKhQYenHFlzrdlhEYgEmZZVh2ajwDAdzKKKDpiRb07fpPm7QPnY14ExaVXAspcAdM8r44O5mpholnQD4QhRtOMdZTQCIVzJRDlAYZLBoWaZvpFCEEklR6igxmERFUP+VlCroeYdJQ+9iYKJ+kM3BA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636756; c=relaxed/simple;
	bh=6gyH+pKoiu0vCXCtEN73aHFXlWpcnrnWLCjRW+c8bbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVCX29zM6QHIctaGlA+0nScw0lRnbHvgPB7lSe0RwJSLkF1YdWxEydRTt7WN+8onqPfmk+M/41GVLLhQdg6rO9IsM2Vd0PQuijjsSBdvKoIQv9prqXbzHAEJnTmhikZxksUOchLS7XCBVxse3MQ26hQyi3pSef0SNneo+Lqz4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RfEYWErV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQdTwNBm; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RfEYWErV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQdTwNBm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 78C601D000DC;
	Tue, 23 Sep 2025 10:12:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 23 Sep 2025 10:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758636752; x=1758723152; bh=JYDwcObeOX
	p7avXvMfxT67DsUZ64vrzuz9mdkZfB4TU=; b=RfEYWErVMLFvLLTI0SV90b/Crl
	ul/7fBC2PuznXe+6M/xLapOkszPDA6hB8N7cTWw5ISc2j0sIsihbchgtOwJ2PwxM
	J/+aLOnbSZLy1tIcr4mNCD4r8dtStD/Gm8j31aMFpyqENDRXDRjTeLIRCw4F2lq3
	EX5twmG3oiKw0kXJmnw3lTN8N6hzDc6GL1/sXIeBGEX2lI6gAZTPS3I8bUuY2x8f
	/Jmjtv4m/O+9qIsm6bfxiW+QC2LplDa8pbIB4MvwAAz2YNNN1bfZSKyrs1As92SN
	yvUygG70yIpVlD6qJy75n6wuDVzOTjdbIk4YOx+gfnXxeJI/fyU448YlGWkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758636752; x=1758723152; bh=JYDwcObeOXp7avXvMfxT67DsUZ64vrzuz9m
	dkZfB4TU=; b=QQdTwNBmGLz7GdY/PFp0OgL4n4RRWbgd+N+hcCcytHokLXebAtC
	Buhj0+PhtUZdTLJVJAlyth3WSHgZWpy4N5bzNeVQyDFPqZYbKyeXvrSp5vQgWd0i
	AaWBLQzn0YwGIlXeZJbGhv47P8iu0kQ2SbQgi0ug4uubMsViRxDzxozfAGjzi3Dl
	SMYwtz9wXRGKzfG1gyVazhE2l8NYC6xMveyrKtFTIzRlKxh3P1wh8bhlzLgBvCiR
	wIQ65VAxzkw/19Z8C6eMGB7tZ6k+ewhVDnFAjrDTg/zqNJZpygvmCJtY+ix1M6mr
	wpFGqEjHkzfeNFSwd2I7MV9ydDInILXCOKw==
X-ME-Sender: <xms:0KrSaMdYA_DWVV3vCzWXdtmoLNgEMtZlyihDP76-rG_5Fle7_yvFsA>
    <xme:0KrSaNSRDCtQcbLwnWKzBu4u8YAf2R5btjcp-1mMUohZ-LLPVPqcwa-fa47azlfnS
    e5kVAx4wHCnD6SeBY3TQFgdt7sRxYPbFkEPTrCtbgE4nYGx-VO6SQ>
X-ME-Received: <xmr:0KrSaDtNW3rAheeUBzDSvz856hmQpeMlS2-oH_VttOj8ZtoVTKqj-K97ViQwqCwY5oSJdXhzlDRH_jQ1FhKdE_F0jcSZAOXVgqPd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0KrSaOcBkPHZ5OFm5sIGdxyraVndbp4xX7gEg8TVQj0KSWwhqFqmsw>
    <xmx:0KrSaNbnOHc_5FJtznXsj8_mwHK68m092WOIOpUefU_K4F14kvft5w>
    <xmx:0KrSaAb4hBFWyQBXsE8jaGTekfInTBkV5Akusn5ZA7l56wU3kdw4dQ>
    <xmx:0KrSaCJPvkh47VKl_64Ufp7h2nj4z5ub2qTE_VXhvZHrSlDSwAwjWg>
    <xmx:0KrSaINydTUbo94ekcfd5QjLVFc21CVjA4XNIqKXqjimbTc5SjfvMwal>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 10:12:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v4 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
In-Reply-To: <CAH=ZcbAHgCLjpLMzditOg8CW-L1RPohGuQjst=h-rATTSoio3Q@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 22 Sep 2025 19:30:54 -0600")
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<xmqq1pnyru1f.fsf@gitster.g>
	<CAH=ZcbC5Y04D4bGjfH3rZ8GKabDttFez5qb9i8mXVsfE3LF26w@mail.gmail.com>
	<xmqqecryq8o9.fsf@gitster.g>
	<CAH=ZcbAHgCLjpLMzditOg8CW-L1RPohGuQjst=h-rATTSoio3Q@mail.gmail.com>
Date: Tue, 23 Sep 2025 07:12:30 -0700
Message-ID: <xmqqa52lqmup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> I apologize for my previous phrasing. I was not very tactful. Yes, I
> think your suggestion is a good idea. I'll incorporate that into my
> patches.

I didn't get an impression that you were _not_ tactful at all.  If
the arrangement is like what I outlined in the message you are
responding to, I am perfectly fine if the type of changed[] is an
array of bool.  The only thing I found was disturbing was the idea
to assign 2 into a _Bool.  Comparing a _Bool, which can be either 0
oor 1, and find it is different from litral 2 (or MAYBE that is
defined to be 2) is perfectly fine.

Thanks.
