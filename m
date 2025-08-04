Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF001F9F7A
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321713; cv=none; b=JVNzEQxNI4TNagrRxYJ4vmLZc13ImybUYSYpyqXvvlx57/ZKEye2E9swuEJVBHDAKZyE+qwMsrjCe/wb7RvsiHx8N6GmLIeLP6jyRz7rkGd4KRqzgsmxcXrPY2D63LkgK2I/hBJHHLIxnVGGUHDhL01L4PDuR5EhrpU5cv2f5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321713; c=relaxed/simple;
	bh=nsbtz4GDMvOTHkj2qyNfvh5MKWTZvOoVa8P/fgEVPF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oeVXbcJJ4kt0o0F5Z0yU4f1YnB02z09KXoChitYkjTDPSCmMzZmoeLnbhOYpPWpPQ/gR9Vt0JHMGQXPJJXbZat7DmaT0Q+sONqKF7Dcxh0pYBNT9/1MBDRYaMYi8fFQv9RemPNQM1vZOD+FEu5/mXdqmF+Dpe2gp7XUxFfvQ2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IFscuYfz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqRShrwZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IFscuYfz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqRShrwZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B5C8EC01A5;
	Mon,  4 Aug 2025 11:35:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 11:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754321709;
	 x=1754408109; bh=Ihf6f2uwaijqugSEKhVc778O2XtU0CHtGKw0VNfz0eo=; b=
	IFscuYfz3+OBa0cGJuyErKA3V7T7+1CzuCdZHBPY72Ig2JDtWsWXSlDD1K/WilEN
	VzNyB6m6LbjAHZDB9TpT/1wtvbjKfsIkJHH9wvZ1n4k0jYfVTwZ+NhT0EQzRM5NH
	4jjUHbm6t5AGimO634C3pWezQW6A+EcEIKF45jlW1MLr5K4uXHyV8qTwztcIvr6n
	FfEEenVNOgx2Lf5MelNvaUaWvLBtoGlwxBuEjTMqGfOd7MQNvKBwGjhEJfzeD9no
	xXUXo2RzLDzDA1ZQhL7t1jrs0oJt6/UWkx49PIPP/hsryJiukcx5bO6gfoTqf2Bt
	C8GK6YjAWjO2LbblT3IDjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754321709; x=
	1754408109; bh=Ihf6f2uwaijqugSEKhVc778O2XtU0CHtGKw0VNfz0eo=; b=K
	qRShrwZB9zA6BKATqVY2E/iljs1ciUqrCov6AlqbzTwdSxapYS6mVhUIHsepRRd1
	3ebUcOFlEr0TUSq/VPP5MBeGO2sQzpZvE7s2g2UeoBq4MZkHlAhZiWaTIeQznErh
	mFH2qrlRD8VaTNNRxxFqTtdgaubfJ13appvnt1Nj+qJ3gacmObdngsusLp+gsT9Q
	Ce448UXH5fOAKJXxj1XvIYlHdeyMKfXgZU2wYIM3VdMYUOItsT1QIZfIWF3aUt7K
	y+lDuYcYvCUSeHNjnpYASsLGNBqKitFIL1NGjWYU6oGjSAhqZXrgB0obI5p395l5
	ZBbIvDwTten3178sP+D8w==
X-ME-Sender: <xms:LdOQaAma_hwYHlx5OYwYX_R00sUdVqco4VVDscUoV2wHcBsnxj5JOQ>
    <xme:LdOQaMuANWx0mdQRqpl6gZ2KvbzbnOL3Y9DHu0P5oaxK63zCH0FuNF6DkbUjeb1g0
    ldTAH6r4HX4R_pqlg>
X-ME-Received: <xmr:LdOQaObtLve0TZMK31WkfKbutHwusbJXZdGDjqDiry4e0A32Dy5QQl-pBaBveRhRFDtV36L_IOqrPBS7BZ1WoVyjGlS7xvkhsEe-38E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:LdOQaMAeQK4me3m8HV2IWY0dQMA_EhpBdGnfSZ91vV-KfBAQ7U3NFQ>
    <xmx:LdOQaO9Nj7ctDf4KbOfd674Y1deNxpxaKyvwVJHluh2Ww7xax-XDgA>
    <xmx:LdOQaATlY8uJl8DnJbfVNAfRR9cNeuc0nTjlknR8si9WnubZgovcBA>
    <xmx:LdOQaKUBxmimIKV3aAz2G4Y1DpS4FvB8SDvS9TEahw8V6HCJyH-Xtg>
    <xmx:LdOQaP7VCjuobs8eN2J2-YYrj-Mh0J2nRDnkZkAaFZIGuyLmk-lcP795>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 11:35:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  shejialuo@gmail.com,  karthik.188@gmail.com,  sunshine@sunshineco.com,
  John Cai <johncai86@gmail.com>
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
In-Reply-To: <61933769-1992-473e-8d0b-8cd6946e80ce@gmail.com> (Phillip Wood's
	message of "Mon, 4 Aug 2025 10:27:56 +0100")
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
	<20250731090040.1625303-1-meetsoni3017@gmail.com>
	<20250731090040.1625303-4-meetsoni3017@gmail.com>
	<2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com>
	<xmqqseibm7ap.fsf@gitster.g>
	<c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com>
	<61933769-1992-473e-8d0b-8cd6946e80ce@gmail.com>
Date: Mon, 04 Aug 2025 08:35:07 -0700
Message-ID: <xmqqh5yn6qxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 01/08/2025 16:49, Phillip Wood wrote:
>> On 01/08/2025 15:43, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>> What does a double-asterisk currently do in these patterns?
>> refs/heads/m** seems to behave like refs/heads/m*. I'm a bit
>> surprised by that as for-each-ref seems to set WM_PATHNAME and I
>> thought that our wildmatch code used '**' to match any character in
>> that case.
>
> I'd forgotten the rules for '**' - it must come after a slash and be
> followed by a slash if it is not at the end of a pattern otherwise it
> is silently converted to '*'. I wish our wildmatch code at least
> warned when it did that. So one can query all the branches beginning
> with "m" by passing
>
>     'refs/heads/m*' 'refs/heads/m*/**'
>
> which isn't as convenient as it could be but it is possible.

As long as the rules are consistent and understandable (once you
understand it, that is), then I am perfectly fine.  And "** is
written as /**/ (but you can omit slashes at either ends)" I find
acceptable.

>>>   - "refs/heads/m*" matches all local branches whose name starts with
>>>     'm' like 'morning', but not the ones inside subhierarchies that
>>>     start with 'm' like 'mid/night'.
>>>
>>>   - "refs/heads/m**" matches all local branches whose name starts
>>>     with 'm' and in the ones inside subhierarchies that start with
>>>     'm'.
>> That sounds like a good idea
>
> Now I'm not so sure.

As long as the existing rule is serviceable (and you seem to have
found that it is), we do not need to make such a change.

Thanks for thinking it through.

