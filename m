Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B52FFDCB
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276347; cv=none; b=GfMXgX0MHjNO+U8B2vrL46F+oUY0yBSPuaBajiB7r5LUMVkk2yYMIVuZfipkwx5qujAAByxC6k//D+kE4/mAixSDYcN8Jxs8jHAtBPKU/KdXz3vujEN0ngfMzbZ9jPNTNcQ65SP6HpGb8bal8Aq0pOBm6F7O205SHangIiSSbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276347; c=relaxed/simple;
	bh=uLboFMWqgJSUZ0qlGQ62y3F6bNHbi1GqhhxoHeMFQro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jf24tbLy4/svCR5ZgF5RT3w5bfqZeG3uPqla5FO2/ja6LN2g7oE9DE8Cd6F6c5WBqrtt67iroNBO5YOcU776jLiaIbWv4khtdTMSYjm0RAG/gN4jpyMKcGHqF3hJFLNYLhMo+pgTXvMxngY3X4G8RUpfyjtMyIz9FMEATeIypOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LmvjrZqU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uLB+pND4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LmvjrZqU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLB+pND4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AFDAC1D001A0;
	Wed, 15 Apr 2026 14:05:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 14:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776276344;
	 x=1776362744; bh=uLboFMWqgJSUZ0qlGQ62y3F6bNHbi1GqhhxoHeMFQro=; b=
	LmvjrZqUMHz5sRkPq5PUS11cb5ITW+7V+Ovsur+a6fqMb235c+Bx+/XWgjKbltzg
	P47CmCQoNeXsSIOZwB4dUzwK9OUhk0QLTbnNOI6SAX0YlUmfvIgBr0r7LAzk5PCw
	WeMD/KCKIx4q0q3gqjaliREhSZ+ESagZpnoPoVAY89ves6DiHkM4YZvlGLS4+Qnp
	E0+dhf+sCB9nMmvcPPaq59MY2JVJAXrSN1ZT+hxThwlJYxAnyxN0XpAK8YgiXrgi
	ZSBjsSWTL6F5nlUzaQ+c6AVHG2nYlp4QDG0C/z4wg26CmQN723gOWIsUQfyDFLuG
	0nbcwT86f1WuJ8hU6f5JjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776276344; x=
	1776362744; bh=uLboFMWqgJSUZ0qlGQ62y3F6bNHbi1GqhhxoHeMFQro=; b=u
	LB+pND4reiAcyuK6KFkoxvSmJDrs96oFDRsTnvCzGbh4Ro/u8BOn+2VXwcrT8eJV
	SoB5eW0ZFd8PJa/VBYnRTcRxO2BECbLS/MoNbz699cVVoeoqLlAIqcooDDl/E8AH
	Y7RfQqKlx80BWA9XSvZcim366gpHV/REsoiDmgaNpLYVusZvQs8MU5Lkjj7uJfYU
	W3xKCxzbH2Fi6gl/OirDKzbqz8MgMVY3o6aU83KrHi2CUGS3Fbm9w5HnVqzEiFxV
	of6JkQ/eOYk9H5HpBlq2/+l0v9uVIQ5lulM4jIuqeF9senAVZtY/8xj+UJdRAvwR
	0itZqGrmEpdxgEC7uIt4Q==
X-ME-Sender: <xms:eNPfaRgWaCI44YhEGy3LlWJwRPKd0WHJHinZXODcc1PzhrM9TsCExA>
    <xme:eNPfaVHzs-YLy8TatXhXE5jA2iGyb7CnviI9ZUoEdeXIo5aZ2362_odyB98m6KcT4
    EvcYNj6JdnCviM-P3WvoS_hVs-rsx9PPQinPTdUn5kJfLQ2mOb5ZQ>
X-ME-Received: <xmr:eNPfaXQdcgeIoW14DS01DJYHyddDwdvN3qHA0XBxOuLt_GFeSKV9yjgZiAVkEj-Yc7JrdCSDEPUbm7xdRDcmBmliGLzP3V7XYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrnhigih
    hnrdhhgiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:eNPfaSzg5eWPo2G7OVCbumLmvI5pDFiw1N13gRqoPQnQDahfnP8f4w>
    <xmx:eNPfaTeJFmNPpWEQwlfDgoBQkiwltxAGjT8YhYr2UcGocwavk5EB2w>
    <xmx:eNPfaVPUS4ELk9Vmr5m3H0wnBEtLvfGKIYVt5Do0lYucUDeikSrY8w>
    <xmx:eNPfaetJU2eAjIawVh4EXjKL6KZXOXsBhgZRWRd1qiU92Zn0oF2V7g>
    <xmx:eNPfaedm6pM7zByB-rnMp2KK6JujowBKqPVorg8TYvqNIw-3ogXwW7N8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 14:05:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Tarjan <paul@paultarjan.com>
Cc: git@vger.kernel.org,  ps@pks.im,  peff@peff.net,
  gitgitgadget@gmail.com,  christian.couder@gmail.com,
  hanxin.hx@bytedance.com
Subject: Re: [PATCH v3] promisor-remote: prevent lazy-fetch recursion in
 child fetch
In-Reply-To: <20260313124329.75626-1-github@paulisageek.com> (Paul Tarjan's
	message of "Fri, 13 Mar 2026 06:43:29 -0600")
References: <abJqySqfdFoY8cEu@pks.im>
	<20260313124329.75626-1-github@paulisageek.com>
Date: Wed, 15 Apr 2026 11:05:42 -0700
Message-ID: <xmqqik9s6qvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Paul Tarjan <paul@paultarjan.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> I must be misunderstanding something here, but how is it that a commit
>> can be garbage collected if a ref points to it? That shouldn't ever
>> happen, as reachable commits should not be pruned.
>>
>> Or do you mean to say that the commits don't exist on the server side
>> anymore?
>
> Sloppy wording on my part — "GC'd" is wrong. These refs pointed at
> commits that were promised but never materialized on the partial
> clone. The ~77K broken refs looked like:
> ...
> This is arguably a separate bug: fetch_objects() should probably
> pass -c remote.<name>.partialclonefilter=blob:none to override for
> the single invocation, rather than --filter=blob:none which
> persists to config. Not in scope for this patch, but I could follow
> up separately if there's interest.

So, is this topic still viable?

At least I see that v3 was not satisfactory enough from the
discussion thread, but do we know what needs updating, how much more
work is needed, and where we want to go?

For now I'll drop the copy I have (from more than a month ago) from
my tree.
