Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1D263F38
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662446; cv=none; b=pfLxKssz2G+DgXBlF9KGgwQzduSFfYKscS5eG5qIKgD3rc1OxZw5jV5js0KEG5uure/PQUwGGSu95fFDYJqT24DQiOTZb1y6Wj9VzNqPQVxOXWc7vBp6rdqW+YjhnYLY1vqjmkxk5HL+bUTj7e6ooYwxBZ3N9k50kEbJusdrkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662446; c=relaxed/simple;
	bh=AqVIn9oQIvrM7TFl6xOQy/WLzvOoV4rrgBj3GAYvEo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLjy8BVXvGg+YWBbgEpft+O0vkI5hdISTTrHWdv6Aaycxy5FFt6nqZ6yI1zjagmLEtnT+XeuLa/9U0P7ZJLU8Oo4nymzN359fVbUHthh9CmQS9kwap11PFX1XUdSPgO25wKhSnyJkYHDgenumzNUmjTJlqPt9xyrvFVk60FEqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DUlFa6l7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOl4OXg/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DUlFa6l7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOl4OXg/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E4B9AEC018C;
	Tue, 23 Sep 2025 17:20:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 17:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758662443;
	 x=1758748843; bh=HRbL1gyYm3EHkcz5kxWGsXoqrcGQwQfvDugr3BoQsNo=; b=
	DUlFa6l7e+d5iQSh5j/W7mEIRkb5XmtzkCY7B2Ll+j3pwx9/odrQ98mzTGD9B1NV
	Gjq4ln+4gjQLJ2yHv5g1fBwrqZpM05imgXlfGFhLA1PUXCLSE1jeyr5cqokMrqri
	ynfaWkMj5XuC7hVdHC9iL+yRUnDYzMuAaDUXXFwR84VzWcoJ5Kx4uFHEuhGf4RKY
	wYOIm7jQ7UkTHIN+La9eL4ybdyGPV2ij5hDgeoX/YlOYtUsIr5IWyyFd0M6amwZg
	lO0QKzmzIVFrtRr2RRclgLRfX7a8T4jPYxcKXa+Aix3dW+bii2ayYtZ7KgZ8vA1C
	dg3HHmtulB5fWhN8NO1osA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758662443; x=
	1758748843; bh=HRbL1gyYm3EHkcz5kxWGsXoqrcGQwQfvDugr3BoQsNo=; b=B
	Ol4OXg/BFKc/PUo79CRUsOLPQQ7ndBpf3SuukuCTyK7xBB1gnruDzuR2MCwowL7p
	l/V0iVdEOWWQW1I9IEnttxg6jWmTg+BJ0vtrMux1jiGf/vfYchY8wnlBolyeJJ9C
	8fUQDPuL/Jr78Y9PU/f5t4CY616gi826t/NBaKQB3gDPP3+7AXEUN8fX23PNdO0v
	PEeDLmHVb8rPxt5Yw7Tx8xbLvMRxuFYXaqYNhCfPsoMPlvDLTaykcl7RFQW7gjy5
	iC69edgAFgDDQxx3vcLAvBrzdZ80XPiN8W1LOBPEfaD7vZB6RiLaBrqKZpbMJkaL
	xaV9hhcYODAFEAQ0+GkFw==
X-ME-Sender: <xms:Kw_TaNmRq6d-BSKQOtucxGWOOJiymhQqIHsqGBZKfiwb4yEbPWlrQg>
    <xme:Kw_TaAQH9NwQ1hLM6Gw3Wzqc0M0jM4m5E2QMoQTQT8uksma2JvCMyb_RhWgYX-zue
    kY8R08ZL7svoulhHuRdaYhneimaO5ZDQIZr9-6zbc3UKNWt1YZQkA>
X-ME-Received: <xmr:Kw_TaBCdYnaggkgGfgsOSlXR3dx3FIhKX1RwYmauIZeTE4wptvYqSNhDYEKM87BgeBtOlzojATtOr1EoA34AG5OVFoy9Mn1Fqakn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Kw_TaHTDo5SHghlchQ6OgfH4z1R1owbMOE6lVqujnygcHxBBhtQEAw>
    <xmx:Kw_TaPrrpZzrabZtJW9rxHFcF1Uer4Tjcf023YAL4srQERejQ5PO6A>
    <xmx:Kw_TaJyWsSWXaMyLQsxpoFJiDjNTtcFXUSNgNo_t6MDNt3mgIlLYRg>
    <xmx:Kw_TaEJSkCcsoiN2cEUKmTCe-7Fs225xuxhu-lofR2TgELyCN4U3lA>
    <xmx:Kw_TaAZHc7LY9aX1kdVmlKb3pJkiQ3insypXMtuGEY2fom0LIXCk6lO2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 17:20:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: handle range-diff on notes correctly
 for single patches
In-Reply-To: <269dd1ed-e8b0-448a-a85f-fdcafafbd0a0@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 23 Sep 2025 18:26:33 +0200")
References: <cover.1758574974.git.code@khaugsbakk.name>
	<7f2487af433.1758574974.git.code@khaugsbakk.name>
	<xmqqecryrvt6.fsf@gitster.g>
	<269dd1ed-e8b0-448a-a85f-fdcafafbd0a0@app.fastmail.com>
Date: Tue, 23 Sep 2025 14:20:42 -0700
Message-ID: <xmqqplbgoogl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Sep 23, 2025, at 00:01, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> No `--[no-]notes` options are sent to the range-diff subprocess in
>>> `range-diff.c` when making a single patch.  This means that you can get
>>> different Git notes below the commit message and in the range-diff
>>> part.  (See the previous commit for elaboration.)
>>
>> Would this also mean "range-diff --no-notes" would not have any
>> effect in squelching the note output in such a mode?
>
> Do you mean `git format-patch ... --range-diff --no-notes`?  Yes,
> `--no-notes` has no effect.  range-diff just does the default thing
> which is `--show-notes-by-default` (act like git-log(1), which shows the
> default notes namespace unless any `--[no-]notes` options are given (and
> there are no such options in this case)).

And this change will fix that too, which is nice.

> But like the previous commit this one could maybe use a rewrite.
>
>     No `--[no-]--notes` options are sent to the range-diff subprocess in

"--notes" --> "notes", as a required single dash after negation is
already inside [] ;-)

>     `range-diff.c` when making a single patch.  This means that range-diff
>     will handle Git notes like git-log(1).
>
>     This is a problem when you ask to use certain notes, or none at all,
>     since that set of notes will appear beneath the commit message but the
>     range-diff will have whatever notes that git-log(1) would have given
>     you.
>
> That’s at least less dense.

Thanks.
