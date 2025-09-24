Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DBC313E0C
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739884; cv=none; b=LX4fLVjohpDYlPiFBsHEU2soln3nqAphZY7tTQC0fIaq0kVeAWvsg3LNK4OqWCa7J52BzuievemLLCguA0APOwjTFfK/CQm0VMV7jKOM/07VIx6PAbYvDJ87g8NeeNzIL+3+IZz5HGxVd5WMrBIyTUrtSuspvApUHz0Cv4K7kPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739884; c=relaxed/simple;
	bh=4c0o1c+db8bEHhodDaYMhbiUEbOlQFN1GK32UzgM+OE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSUK1Y64WcHd97XBaLWOAXfnvhvrTlKFe0LM+GoQ6+b/hBgnFfWf7e/g20cfoBDv5uIzma2bAhWfJrbH1zfdJD1NpTOP01OwlQUnx78syHmPtlOHBiE6bQeg/4s2ai7GVxcNkdARQO+kHnTCldOlkWTayvGRo1FgzaWtRiPQoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QNc1W0hX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7hrJBZj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNc1W0hX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7hrJBZj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34950140005A;
	Wed, 24 Sep 2025 14:51:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 14:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758739881; x=1758826281; bh=JKoeODgNbb
	IaChIb8RqmGaeubrcVvXzpUs6sScEV1B0=; b=QNc1W0hX0AtNWF06NiAAk+Oj7h
	tY0Hj6spgREO788WCAoOWclwo2HRZQCWh0jddkPeAQNP0jm4QF3W8A9iTvxzLrSf
	bjNcFhsG+h04fT8dTr4nSUz6ON2n2nWbvK+b8JZWWr8K7ClOvS8KXEBQ82BYwmq3
	da2rYZWhim1d4GRgvC2vcRv4NG5bPMqNLeQHkhVb+tfB382+P967BBdZ6bK2zoVc
	vlqVS1zaUvrsNm6FwzDH+HP7IQqaEIDmMXZuQ9Yx0CylEvAMYAzzT2fxbEeF/6hr
	W2FNgvjEw2NpINLxBTKzudqPm1k3B2g7qGfKyl4w8vMet5Kph7okfTVk+pnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758739881; x=1758826281; bh=JKoeODgNbbIaChIb8RqmGaeubrcVvXzpUs6
	sScEV1B0=; b=l7hrJBZj+iYDlhLh902a5mjiRm6ht7pzOKVUFY3UeiqZMBFpyYe
	R+K8tlr/vxSg2tCjMSC3wrZ4iUbjlMoyfYQraicpdyuUomld9sZhsDYrxWS/rJvC
	WWfZfQJ01d93zDWhxuIymuDhtQC8uv4CBowiPsqVhn75s7tNtAE/80ls41cUY88/
	9foK/0swwWLkQWBlRxf9uX9MNJxIF1FqEvOPYKOCeQUaLBUkywCAgjk3L0V4MVVL
	+66bnGD3Tb4FudAuolUwcjwW3upbfoKOX7FBB/wfsqLwxebiyNiLsNlj+g+Lsjay
	7rH4j91WVZJteG90GsSJdNGTKEVFrZwUuig==
X-ME-Sender: <xms:qD3UaGk-EdpCE1W47XAx2_uCNaIKrWcnsnBieecewx4rTCJNAroBNQ>
    <xme:qD3UaE2pZFF8l0XgstoOeoO0BRo8yBAunjNbG1HaSEWMl17bl0mwGlfxWVwEvnuPi
    SMXMBhQIPf1IU9VQVJiLdKthygSvwxYaCYz2C9tykIrc2syBm8dGA>
X-ME-Received: <xmr:qD3UaJpR3V7XBhCxE35hMCClujQ5iZkc_kxk-uykjs_QkRqG4Cr2rgpsvTFjFfnW6Dh0_gxWSIbUk9aVcMwHGmIysFAHNXHrZAws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehvvghlohgtihhfhigvrhesvhgvlhhotghifhihvghrrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qT3UaJcopNp7PtPoDyG4Ba37_-VBnhYU53Z8VTEdoofyzHSCWG26UA>
    <xmx:qT3UaAoo0p4n_wGLaHRiY096CJVCA2m-obL0Xf_dbP5j9Th8nHeRkw>
    <xmx:qT3UaCFWQlNT2xQXSjxncZxD81Fa2aKt8TXqCkZRhIJNCRuxqs1qvA>
    <xmx:qT3UaItl95gPZwF9an5P9-2_OMR8Q0O4n1uaGSu6za1iFrIFQ8YHwA>
    <xmx:qT3UaLqBqBzZuksQa6E633Bn4JuJdIVofJFy8zgUqidoyyDX4i9LQV9I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 14:51:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>,  git@vger.kernel.org
Subject: Re: How do i get news of git releases
In-Reply-To: <CAP8UFD0t76v3XYgoLjZ-527EePQKihSNyA=AO0QjJHDy=u32JQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 24 Sep 2025 10:38:17 +0200")
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
	<CAP8UFD2asXf_4_02khYRVWVQruBdvoMkZVE-6cVHttT9gHdWqw@mail.gmail.com>
	<b5867a92-c516-4a66-a108-8cabbc166336@velocifyer.com>
	<CAP8UFD0t76v3XYgoLjZ-527EePQKihSNyA=AO0QjJHDy=u32JQ@mail.gmail.com>
Date: Wed, 24 Sep 2025 11:51:19 -0700
Message-ID: <xmqqcy7flm54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Sep 23, 2025 at 9:42 PM
> <velocifyer@velocifyer.com> wrote:
>>
>> > The URL for each release points to the announcement email on the
>> > mailing list archive. That email contains the release notes.
>
>> If they already have the realease notes on the mailing list, why do they
>> not have a seprate "git-announce" mailing list with just the release
>> notes and other important announcements
>
> We try to keep everything on a single mailing list as much as possible
> to not split the community.

I do not see how the presence of an "announce-only" list would
fracture the community.  You could make such a list strictly
read-only for participants (i.e. only the list owners can send
things out, responses may be routed to those on whose behalf the
message was sent to the list, just to /dev/null, or perhaps to the
main list) for make it even clear that the secondary list is for
announce-only and any discussion about the items announced would
still happen on the main list.

It does take resources and coordination.  It won't happen without
anybody spending an extra effort.

Because those who would be writing the announce material for such a
secondary list are making enough efforts to help this community
thrive already, I do not particularly see the initial "why not a
separate announce list" question a very productive thing to think
about or respond to.  Unless the requestor is proposing to help such
an effort on continuous basis, that is.

> Also what is important depends a lot on the reader. For example
> Git for Windows or Git Rev News announcements might be important
> for some but not for others. So many people would have to sort
> things out anyway even if there were separate mailing lists.

That's very true.
