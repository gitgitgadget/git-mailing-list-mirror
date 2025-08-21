Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2372580CF
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813009; cv=none; b=qAmA8QqDBCdy0dCXE97llxi1R1qfFcPMS+4zXE7u0y+UpiZ7A2VQH7d2NwS2qexteUUdTG4OLayy5RnuyWnKCo/zqbPO/sDGsuwErLNq1dJrwJMd7ufLqIEcwqOKUyq5cAG8K44sQsKaAPuq/oJervEAowscpSKgroUDg0KXBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813009; c=relaxed/simple;
	bh=dAFaq4KKWF1T04TVcqIHkQi6Y0WAATALmy54YyEcXHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KVBb4iBagA0SQNYEOoaPMRvMAwJqtPbpU7eIwpiUcwWVCU/Mp3vOiCEvsdCiXzu5uhcVyZv6LP5q6rZhagNbvS/fqrZ+5GD6EMVqgCoPZUJb9cMQw5qrCkK25zmQeXbmJqJXYb/9bJRhU/6gaDQzLUItjn3LBg/M5HsnkHG0dkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KDBu3bqu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsEHteqq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KDBu3bqu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsEHteqq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A29B51D0020F;
	Thu, 21 Aug 2025 17:50:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 21 Aug 2025 17:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755813005; x=1755899405; bh=MFGBb9KKBp
	vArqRwtNQQi4n9ieb/1btLjKi//0kpTKc=; b=KDBu3bquM77WWbxMW8PqfzF5tc
	vs5BHE5PdWTS89Dl+Bbj02/rvuhGmSJ8wEmMte/BVdhjPVkfY1ovO7Ggrzzx90Tt
	lc4iosPWvo3xMmt/R1rFpJPX8HCEtVk3REob8pP5eEEl57J0Po6M4TKym0qTjzNa
	1EAhnUkZ/iBxU0/rgipUGIcUoMN7vtXMK0qpCK55bHJ6sZBs7Baa4i182zmdvpdt
	ZvYBO+IyrBPYdNBEidr1fQbZSA2e/PFlWeWmwhdJJePxaDeTpmXKI7u28Twv1+md
	38NqlEiLxvJSHEumBfg3eWF9nKe4bGvSVA1QCfkcoSPy58/tEHpgNOb5ev/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755813005; x=1755899405; bh=MFGBb9KKBpvArqRwtNQQi4n9ieb/1btLjKi
	//0kpTKc=; b=UsEHteqqW5cQyO1NRPkJRarg9sWM3nD8aRuMYwfxmJkodf1z9Jj
	PFxL+sibWT158HLeXVho99gXsYue68YNmv6hl5WkEwQOBq/BBP55pphroanVPHo8
	7YAfoIwzLGnnXSe+kysW5IYrs2R+PEK6rMSeHW1Tv7z2ikl3sK1XG6X/OKpOFZ2Z
	Z9i2Totr3fcZysSxLRs1kISZURnfcXXp790XneRBa1cT9Oa/0xJlEN9x4sOFuloV
	1wqWu/7+evdjGTqN3tygIzpK6W/aktAKoT4jML4STx9WioheNaMtio2lEEuLbLH5
	FzYQaNTGJu6udBrnDrZ4GZXVFkeBHhxDQFA==
X-ME-Sender: <xms:jZSnaAlbjBwUMawMbvt_y--Nq_MwOxWy6_yzlXCgs3Htblf5RTih9w>
    <xme:jZSnaLVr654VEhIvfLbi7N5Ouq4VSnEvCTso_4lZFcAhXFN8neMNM_urcf2Pg520Q
    DnYgZtrye4piXcm9w>
X-ME-Received: <xmr:jZSnaFGkfvM8Q2ar4uRuql0c-gmnRxfiXpXwrN6Xoz0NeBQwj0cG9ffOgXfCV6PupRFM1yjfAxbpUp6ZzHnKHjCo2vbmEb8-cjdg-XE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jZSnaHd5TmJkDHp36zV7OZwdDRmA01R0vhRXEaMi_5UcWMkcgH-ZlA>
    <xmx:jZSnaGL7OoyRmMRoa17uonQonnPcUKbluxMJzWzw_AYnocnll9vktg>
    <xmx:jZSnaMFciMMumhhuh9wlYTl2UyiM2i4vo0deYQDR70FHy5Cr05Sz5Q>
    <xmx:jZSnaJAlwptHAwOPRilHyfleiF8smtU4pw1z7BNoLMuCkg0OGXN_6w>
    <xmx:jZSnaK2VD-XF0yptTlRfTQ4wNKQWxUZpbILihPuocT8DL9GWX7rKLINZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:50:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for
 --format=nul
In-Reply-To: <7E449BB1-224F-4B15-BB0B-357E4FB79429@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 21 Aug 2025 17:57:04 -0300")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250820144247.79197-2-lucasseikioshiro@gmail.com>
	<aKb1BjPfmjBvHrm0@pks.im>
	<65E661E9-B926-4EC1-B0EC-CDE2CD1557E5@gmail.com>
	<xmqq4iu037p1.fsf@gitster.g>
	<7E449BB1-224F-4B15-BB0B-357E4FB79429@gmail.com>
Date: Thu, 21 Aug 2025 14:50:03 -0700
Message-ID: <xmqqect4z6no.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>>> But I don't have any strong opinion about that. I'm open to suggestions.
>> 
>> Don't ask for suggestions before consulting CodingGuidelines,
>> perhaps?
>
> I think that Patrick was unsure about adding the external parentheses
> to make it look like [(--format=(keyvalue|nul) | -z)]. CodingGuideLines
> is not explicit about that specific case of having alternate flags
> with nested alternate arguments, but I don't see a reason for using
> parentheses as it isn't ambiguous...

 Parentheses are used for grouping:
   [(<rev>|<range>)...]
   (Any number of either <rev> or <range>.  Parens are needed to make
   it clear that "..." pertains to both <rev> and <range>.)

   [(-p <parent>)...]
   (Any number of option -p, each with one <parent> argument.)

If we were saying that these things can occur multiple times, it may
benefit from such a grouping by doing

    [(--format=(keyvalue|nul) | -z)...]

But the outer () without these extra things, i.e.

    [(--format=(keyvalue|nul) | -z)]

does not look like serving any useful purpose at all to me...
