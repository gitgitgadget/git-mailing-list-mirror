Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAD1FA178
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375512; cv=none; b=EOU82HPD+qBvIi1ImdIqv85+63hxYS46G/qNvcFHDKJwZ82/UZE2lzMmrQtvGk5YHFEGbh3cN4HDHt6+uVooo0JsYfE3tXo6+EQbgWfbKTJNh+SuqeL1zpk208bE9RdFgKWpKwplUCssjaRPz5MVmPz1Ev2DZ6bkVUw0Uwexlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375512; c=relaxed/simple;
	bh=NnZeIFS7DPbmhdvg7QWlbtPp5DtPp9y7Z1KtY7NAn3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrhQdS8WCudYlbAfqo/9LXS4FOMTLo0FbdMllpK+jpmqfgRu0/8ALlExIWTv57ZaIhcjRk5UzP1LH1961ExdbsD9pTMwa1EuaaLngLjAtfMMefBZZ2vsG56kVzj6BZbCMnIoA2Rixgzh1Bj8YKXxiuipqXR3Pq11sT000mcVZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GoF+q9xu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIJRbCdB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GoF+q9xu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIJRbCdB"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EDB27A0385;
	Thu, 24 Jul 2025 12:45:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 24 Jul 2025 12:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753375509; x=1753461909; bh=NiRfHN3r3X
	rnhrNCL+VCr14GYGdC3VzxWi1MDal+1O4=; b=GoF+q9xuaDYvqvSvVonNNwmjf1
	4qP96IJRrp8d4x4XlkV0zjfUSlcleVQe+YHKUMKu9/vC9H1YZ/mvjhn2FaADDxf1
	yhhk6YXf5pjcfz6WAllXAWBj3uXkYiBgtUB11qNSFHdt3RG8zYgvm+OjzNHW90IF
	smpuVBaezwhCFpIemVu1jzU4VvMa4y6zMjr95uPA21Z6HwM5zIrV/zX4dxyOTxiX
	gcfN7403NIgqhs9XNXZUGYbiWbR/VFBE+AQYeQqvWHkSMFJ/eUr3Zz0VBe9ynOxS
	lz72TUyCijD+FRlWpKgtIz6hVV/bKr1bB8xjx7Zk3t3F0wO6sYSke9zep4Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753375509; x=1753461909; bh=NiRfHN3r3XrnhrNCL+VCr14GYGdC3VzxWi1
	MDal+1O4=; b=oIJRbCdBtY/VwZQtNCn8oxpQYD9TFZoRBXYAmnXcj9mzLK8qBav
	yBr4+BMarS3dG+l1uVALiTM3iekd/19IpV7LulyFRwn1TNQ7i+zY4KLPaTJybcUG
	1+f5rA9TcCnzRndF3QYGHzcO/bvB/PZupGj/Fr4D6/4TTByjFhP2X9q3KiUkCf29
	GcDrLAb/s6H7cIo7auW7ysEoZBgOWAup7WXaHpMxORcPxIDEUMFDEfm1zkOixzz7
	ko+TfKJW8PjZc+AXzphljERuej8LyPiuYO6T1vNW65NpyehY8x0DZjLY7Z3LaMEf
	rfbXO22CgF2yy8lkp03RO52bzHbp27FsgHg==
X-ME-Sender: <xms:FWOCaKuXHXFypscJaunFKL6eEJVzjmSk46WN58-LQm4Nuymgj5YfMw>
    <xme:FWOCaK_Ik34Hh77jvcqCX8oywoyQem4VfyufxWXEvRQQMnni5IEYG5hKTrVFimj63
    rnjrJ-qxJDrzlEG6g>
X-ME-Received: <xmr:FWOCaMPWLvR346EQkspQlviBWsqIHt_xV2laff1hInGrX8goNUKrUqsVm9LeU49B6DVa1KGQwjHOhsN8GEI8Eb374JZ0zLn9-SO4mAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FWOCaAFgvlf2UoXIYPx8rNJBzMEhCcGKMWBZOq7T_8weuYckHmtBNQ>
    <xmx:FWOCaCQgOMkayB9Rz_dxlgS5UZOQDTEYJ9loAbUC1RPdACphkv65tw>
    <xmx:FWOCaFtPL0lOYD3OjCnmT2XHvrw8TEstLam_A59RoKo31ONh4Qwkxg>
    <xmx:FWOCaCLNxbMSbaoJeJHjML16GSo0R2Zv_dK-YsavT4Z0iuTFaeqk1Q>
    <xmx:FWOCaLdMIz4C1vZcy21wUJxhhpa076Pszn0y-YdMa6fCU3Ly5vvir9lx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 12:45:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH 2/8] builtin/reflog: improve grouping of subcommands
In-Reply-To: <aIHj4NWr3M5lXLtD@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Jul 2025 09:42:24 +0200")
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
	<20250722-pks-reflog-append-v1-2-183e5949de16@pks.im>
	<32gvkjmjz6otqwpaxafmz5xuznowhn4iwcdyn52qhbvzohyih4@oeimg3xvqj5u>
	<aIHj4NWr3M5lXLtD@pks.im>
Date: Thu, 24 Jul 2025 09:45:08 -0700
Message-ID: <xmqqikjhilm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 23, 2025 at 01:14:19PM -0500, Justin Tobler wrote:
>> > @@ -404,10 +404,10 @@ int cmd_reflog(int argc,
>> >  	struct option options[] = {
>> >  		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
>> >  		OPT_SUBCOMMAND("list", &fn, cmd_reflog_list),
>> > -		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
>> > -		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
>> >  		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
>> > +		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
>> >  		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
>> > +		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
>> >  		OPT_END()
>> >  	};
>> 
>> Structing the subcommands order in such a manner seems sensible, but I'm
>> not sure the pattern will be recognized by others that may add
>> subcommands in the future. Maybe we could leave a comment that mentions
>> the order?
>
> Hm, dunno. I feel like it's subjective where to add a command anyway, so
> I'm not sure that a comment would be allt hat helpful.

I'd agree on both counts.  The only pattern I can see myself is to
have read-only operations first and then read-write operations, but
even there, the choice of "is it read-only?" as an axis feels very
much arbitrary (another obvious one is to list from the everyday 
use to less often used to finally only administrative ones).

If the read-write operations are ordered by severity, I would place
expire (affects only stale entries) between delete (affects one
entry in a reflog) and drop (deletes the whole thing).  But that
again is fairly arbitrary.
