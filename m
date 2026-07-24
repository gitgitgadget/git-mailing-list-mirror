Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCE4457B7
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910369; cv=none; b=T1tSkIfYDT9/ljnXYSeKoE9cIdbM7grdVNBpnTfyodtahzpHNjDx/oxFpvRuSzPcUONl7u936HQ8EdUI07MX/GXvPPyn5otyvzAfk5riJs38tYLNVUcSH+gaBZIEqGuG4sVLJ6rDS5UcJYIYHRC0UrvlD9SyGvqCujVaWovU7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910369; c=relaxed/simple;
	bh=37WjvLNReaBOJYWvWyKrDzh+a1vO3gJhMgMYf5jMp3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/VDEZSNmW+mTtbVwZLy48guIYF0M/KNJl7/OOQ/muMfkUI3A7meZknpIrBDXQnHoFwHkX7QMKvrwGYJkHFTBVoZvvUMjfdB3t+aQF0RLxXb7bc0uZT0NM4ep+CoBpDbTaQW+ztjusgB5OXXm1Y/QCk0MEvOOupOKi4ywnz3jdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=guF6ngCA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIdo/Tjw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="guF6ngCA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIdo/Tjw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 321F61D00101;
	Fri, 24 Jul 2026 12:26:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 24 Jul 2026 12:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784910366; x=1784996766; bh=mMgtE9ggUH
	qV3jvaTE4c//Fz4IUQRWerUds6KPvhjf8=; b=guF6ngCAywPI5c5+6JZqHh2mp0
	V/rGcr9sh5mEQSqkqtHxDSNPq2wLWsXUY2vX3YMv875KziA3COzHXP5FtUn0L8al
	rkappvmm0arLHruKZTWlj0W+Djusa3nHIAnHCTVT54y/zs10lew7GGwqkw5GXMNE
	2KZRULtWGWqU54fOSofrw4REOGnsvC63og7OTSinaBpN4UGbUTbUL64zjZ5Kzzg8
	Id3brM+ZzIjklftUzCUaXsWcKHWONf8leezPWkW3cJ6bYKJrYBpMaIReivpak6o3
	5Mgx5qsH/zRTjIssM5ppPItKpNYX0RaZC3HPkj1K6bP9xYavBEGNynh0hA1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784910366; x=1784996766; bh=mMgtE9ggUHqV3jvaTE4c//Fz4IUQRWerUds
	6KPvhjf8=; b=kIdo/TjwyAs6Po/dOjF1lP3K7JFU/Ixqr4ig9wQ0zgr6+kzoYkk
	cfYc4Eqz0cA4G8pPvXzMDi6c1wiPtMpFLCpf4Zf6DujIzquy5HXch4xwbOOoOyL+
	oze+GNhfS8ro8Wlu0TfI2FqUQ3mCqMTDi5nOov2Rk9dTwjHeS0ypedh9tU71leXs
	Y4zqfxk6xRxIqEJaNCEs0r4tQD7G6qcayLosgfsOa69sLcKJgq9QX12e8eAlhHaq
	wcB/nRJAKoRbwpW90KDr8WgNDZ7/j/fnnYGK/mOFiuGX0gNMiV8LMhpqVbUiBK3n
	XeHpwHMbxHViWFecFwl4o2vu64F0pM4cKYQ==
X-ME-Sender: <xms:HZJjamegScvgVqTaIixnieZJDvl4tEiaURNQBEPkOMxf1kmRg7ZhGg>
    <xme:HZJjanG8lgAIdepk8A39kDSyFsqFQbjPu4CWRxspcOoL6qElmBbxqvUl4XoX2MZr2
    lItqcdVqt6dnYoC2FILSeFEjsDZFWjhaW6M0FMP5WUPnYRBk4YQaA>
X-ME-Received: <xmr:HZJjav1Uuga8kicjsMOLt7nBVgU_UQOG5aTp_YztUnn_g8kmgT5_vie6PGhaKcjdkGI9Gb5oFecmtY7JCTLbS9jEGxoegTpTSA>
X-ME-Proxy-Cause: dmFkZTEkdCq5+Za+u7m1xRZfINpDTQTRx4jj5cp5aXc5X/uu3GxR5gl1hSD6M90H45W+sT
    6HUDCxcmMirhsMK9yBbM87powUYGe5hUWk2IEfFbbV1NbdkYvbyDanK7PLpQD93M5qF8QW
    XcwjtggZzs2e/AOVXOjx7tf+ed+JDc8xR5myT8ApGqd7botNe63Yc3U7dTPcG8NV9MYHK0
    Znd0P5T+ssGBl5IhvnZ/mjcpVk0BY1vmSY06hdx716wIfr2GH5mQdrwjmFq7P7UIJSjuA6
    zfgKsApui7YIaA9bTfBnWFBu+7SIEYXCj1p6dGfk/+bqlEBRuL8C+LYgC4RR34EF7nH4dA
    aW5HOez4fM3Zxm3Xmwz46MjS3EbYzLHfCqNKab5y8XNbEqhBqreu+pZXkHlSMctO5iXJ91
    /01cNT38FhWbMltdYCi7GhOvy0K4ChPoCzhdy1kgimpwq5Auq0Nvd2inVR2O/SpSn/E1ex
    3u9VVMM9Rm3myg2qeaU6BoazBtYhSSIoTkssKXE/ruH21FLLwjxZNZ6mRnmfUylkNqN7sW
    Dv+JkZKcegfrG0RO9qzfy2PMQl3dmw1aHZbFMrnz3idEyJhBkmyrHiQEq6Dtq/xxF+FS4y
    +6UQnRCXhllLtswrGMeiFJnKJazBiu1yJRQkGaRMpo2kBtIZRiDNiBRbWBhg
X-ME-Proxy: <xmx:HZJjavmnjooJ0xtdJtmQQtRR5SmqH6X-F_r0ZO0zMZ9RlXQ5AtzptA>
    <xmx:HZJjav_3SCb1jc7XxfiJOeOD9vAakkMOosyGoh9GA9yQwdxjb-PBbg>
    <xmx:HZJjakoL8aDxnKCSa6ZcqJg5R4rb1YC7JPLGQLb2nvk2r5DCyYsnsg>
    <xmx:HZJjaomSNwESprdKUNJKydwtnBFcnGw4Q8gMJSGaBAwOUmL6JRRXKQ>
    <xmx:HpJjahl1yLc8QhBm2djVzlFfkVcg4pgI0VQvoM1Q6AmbsFgJzF0UHdJu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 12:26:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: tnyman@openai.com,  git@vger.kernel.org,  haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
In-Reply-To: <xmqqpl0c8jml.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 Jul 2026 08:58:26 -0700")
References: <20260724091152.27794-2-tnyman@openai.com>
	<20260724114948.GA825505@coredump.intra.peff.net>
	<xmqqpl0c8jml.fsf@gitster.g>
Date: Fri, 24 Jul 2026 09:26:04 -0700
Message-ID: <xmqqbjbw8icj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Notably:
>>
>>> @@ -809,7 +808,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
>>>  	filter.name_patterns = argv;
>>>  	filter_refs(&candidates, &filter, filter.kind);
>>>  
>>> -	for (i = 0; i < (size_t)candidates.nr; i++) {
>>> +	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
>>>  		const char *branch_refname = candidates.items[i]->refname;
>>>  		const char *branch_name;
>>>  		struct branch *branch;
>>
>> This hunk is not using a strvec at all. Because it uses the same
>> variable, if we did not change this loop, then we'd still have to
>> declare "i" at the top of the function and the other loop would
>> introduce a shadowed variable. That's not wrong, but it is confusing.
>>
>> However, if we are going to have our own variable here, perhaps it
>> should use the correct type? candidate.nr is an int, so probably this
>> should also be an int, and then the gross cast can go away.
>
> Ah, very good eyes.  It is a disease to try appeasing -Wsign-compare
> without thinking, instead of questioning the value of the warning
> first, and in this case there is no reason to try forcing the use of
> size_t, even with the unnecessary casting.

Having said that, another fix might be to standardize the way we
count the number of things in an array and update 'ref-filter.h' to
use size_t in 'struct ref_array' as well.

It is not as though 2 billion refs are too few to satisfy our
needs, and in general, the platform-natural int should be used to
count things unless there is a compelling reason to deviate from
that norm.  However, "somehow we ended up counting many things in
size_t, so it is better to count everything using the same type"
could serve as "the compelling reason" to make such a change.
