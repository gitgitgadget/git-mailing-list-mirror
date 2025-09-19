Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1365257852
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312851; cv=none; b=NwCodtPwV9vkAcpZDoaKXz6CSsAfz0CjtkUV1SIqoygBRVSSGlDNNFZkP9A+WoLxYFdICsZnoPWf+3P14FCLN8NgRWUkuQeDE5iJClXbtqkrX35fbJ4/F6lVB7ZWL6yqmZFyGSScc18uWW8l5hopJHAwufhYNoTbaScGac52mNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312851; c=relaxed/simple;
	bh=P2q60rxdv/V7RMWtnSH+Fph0LzJF7QZUChLFmZ9sP8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rgk0LGypV70AORaLswWZooipTX5P1wcgpQ2TDDPoMnj2iFM7FluwgXG+EBAshDiBKi2CrnvTI3R1Dev5DZkDX4ws5ZJyT7eucuJPvgcxRojEanWwu8BwGvHC9w2efqwTgMqq9wVy5w7+p0qJuihsYmu/sdX6CpiAPMJQXF+7b7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pMazxOLP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNVwUpHB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pMazxOLP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNVwUpHB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C63591D00096;
	Fri, 19 Sep 2025 16:14:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 16:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758312848;
	 x=1758399248; bh=L6Yx9nGkYuVi1ZMUSjMF5wfVO/is9/feFOvsZsuzyHQ=; b=
	pMazxOLP17lM+zzYWyYnhk1MqsazE4WwqSVw64BkQwF6qtg9ijBGQrryUqeDR0qn
	aQZVZhH6y9sTnnAjNZ2+B9SOioX7LuTJEm0sp3LwCE/AJFGIQMGTe6EefvAissjR
	uThVj3RYUA3mr0lJQvoqf0FUXZD0j2UNkpdMOuTnf5ii0e5W7hRNLsxDK/88nwiy
	y43ch7oqpO97E9LHpjZwVOm1cYFAX3e5s0VaFpCEepOULA+4JYEoH5KezkpfzWNv
	6QCH/MjlsClqQIPm5xvRwXApYnfEkObvIDF+WxU7cG/GoMf5DBrnK/q3/W2mTcar
	rwAa8FiOXdvZU+imYEBNUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758312848; x=
	1758399248; bh=L6Yx9nGkYuVi1ZMUSjMF5wfVO/is9/feFOvsZsuzyHQ=; b=b
	NVwUpHBJ/u5J10qZDCc3DLAV4e55OnZOPtgEA/mCuvyuEMVHJmfaielC/n654RLF
	3O2LXn4dF7L8x2CQWNPgKGVHaWiDjBPjRjLNWuS0XqFhDQy+aDQMIZuY9WbFwcx7
	dal9aOXgoiDaAwjW6zEVKlDC0WO42chSp0MgB9bcJmb3ow6Ev2Kxx56d71QQzDoD
	WsKw599rZZD0XyO8/jic/GscVpmvGsWVFkFgbbwwUk6A7cIt5v5G0E1Pva+/1B0L
	tFt1kEuTg3QfE3wNiAhPclBwJK2vg/enlPfbGRZ9OgrYQzh000bNssruXEMMjB/W
	JxmixW4ojQ3mkMhuadKLg==
X-ME-Sender: <xms:kLnNaH7bwNQh9ADCFqwBT7SWIG7SbSUwx1mtBZlF5SSSMcDA8cNIPA>
    <xme:kLnNaHe2YuXGwRgFAWWr0b5ARUxz1kZdgeMSuukuowauRLo4Zg5JLkKqKJ5JpuDKA
    6lRYOT1azGi58cfhw>
X-ME-Received: <xmr:kLnNaLCoypst_OoEvLto33At-B2-VnoX988gRWuyg7E4bPAiWjptO7NzicOov9gSkCLEDbWrmLBufKMtI-I3VUfYr5uIbK-7dubbtZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kLnNaK8oWTivYp1SfYtVjZ7xk69V59_fN79y85KQd06Vt6r38t6pvQ>
    <xmx:kLnNaGLabaptwku_BEm-jQS1_cLvuuCXj1CxUwJKVNZBHAUasLkkkA>
    <xmx:kLnNaDgbPRncCZQdfcMIKh2FMoCK7WPcVH_7f6wzc_x7b6151aqukA>
    <xmx:kLnNaG7NRWgOZ1Soz4bEnteKWJj3kQP5QZjfLJpE4yU9i8Jh_NaiOA>
    <xmx:kLnNaHqSEUCTgZ64Og9Asqribmyfc43U5P80MX9sstCS5bHgAde_NBIv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 16:14:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 04/18] make: merge reftable lib into libgit.a
In-Reply-To: <CAH=ZcbCRzGGR1RFTWV1Zo7bm+DScx=zOJ=Ov-WkaQNrDN9w1Nw@mail.gmail.com>
	(Ezekiel Newren's message of "Fri, 19 Sep 2025 14:00:30 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
	<xmqq348i5kqx.fsf@gitster.g>
	<CAH=ZcbCRzGGR1RFTWV1Zo7bm+DScx=zOJ=Ov-WkaQNrDN9w1Nw@mail.gmail.com>
Date: Fri, 19 Sep 2025 13:14:07 -0700
Message-ID: <xmqq1po242uo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Fri, Sep 19, 2025 at 1:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Aside from the comment already given about the fact that the
>> proposed log message does not explain any reason why these change
>> are necessary, this step and the previous step are fairly hostile to
>> merging the topic to play well with other topics, especially given
>> that there would be topics in flight that may want to add, remove,
>> or reorder these two existing lists.
>>
>> I wonder if these could have been arranged like the following instead?
>>
>>  * Drop "REFTABLE_LIB = reftable/libreftable.a" and the target that
>>    runs "ar" to mantain that archive.
>>
>>  * Leave "REFTABLE_OBJS += $objects.o" lines alone.
>>
>>  * Add them into LIB_OBJS so that they are included in libgit.a,
>>    perhaps a single line like this:
>>
>>         LIB_OBJS += $(REFTABLE_OBJS)
>>
>> Wouldn't that have worked equally well for the (unstated) purpose of
>> these two patches without incurring unnecessary risk of mismerges?
>>
>> Similar arrangement for xdiff.
>
> Like the previous two commits; This one continues the effort to get
> ...
> The reason why ...

Neither answers my main question, though.

Instead of rolling everything into LIB_OBJS directly, wouldn't it
have been much easier to work with if reftable-related ones are left
in REFTABLE_OBJS and then RERFTABLE_OBJS gets added to LIB_OBJS?
Wouldn't it have been less prone to mismerges to do it that way?

> However I think I'll drop these 3 commits since 'cargo test' doesn't
> need to be part of the introduction of Rust. It would be nice for make
> to be able to run Rust unit tests at some point though.

As we can always extend things more, getting something close to the
minimally viable set with some tests for sanity checking would be a
good first goal.  If you pare down way too much, however, we may end
up to be pretty close to what Patrick sent out originally with the
varint conversion, so let's make sure we do not drop below the
minimum that still demonstrates that we have Rust integration that
is viable going forward.

Thanks.
