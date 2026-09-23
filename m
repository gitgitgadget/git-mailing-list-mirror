Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1554B1CC
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177692; cv=none; b=N6yJ+DE26CaTQbhADzZsViF6OTT7dPJkSXtX+6cnyLa4NckwDZvqyyGG70r8lSHOvnlB69CTiyaPUdjGDcjC0bitTV9nuKN64tl5tiLRq3QqfdrTQP9HuHNrP8StFMLARSCaNRu1fvxyf/Yx5loHy1RKUlIjDAogAtijLmrrV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177692; c=relaxed/simple;
	bh=4qfKM+uuKbXXqsipehnx68rS8IA8HDgg9GNuoQK11fQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GpXucQABWt86rD8uDVpSzBI+ueKXc+e3BG6NLjyL2X9u5Yy8S2xwvc91kqGf7s+8HBCqWhDmnSJ/Td44/FqJ1HSg1ImEkxm6koJJd48aYSNHQ/26wiTy1yf+77xekw2Sem0JVFF8Bg0CblMJS4OCfoZkuE46+567uHafCdZhdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vHzhCuGf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aEwnj0Kq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vHzhCuGf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aEwnj0Kq"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEE407A00B9;
	Wed, 23 Sep 2026 11:34:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 23 Sep 2026 11:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790177689; x=1790264089; bh=4LRzUTgm2K
	pWUkEEV/yItf1itszDYBggd/9LZtV1X5Q=; b=vHzhCuGfJa6Yy4IXQH4eUcN5Tv
	TruYPqFf4YgW2xDcluQLaN7u0RMTqHIcOezvezSxHNPds1XjSBP/aQgfHmsLYYR3
	jSlQMBMBXv380OH8kLhnxSDgkNVFPDrmqQzHQ7SZSpk8I998PDU64Lg04EV+Ge4t
	tv3ots74XYS3sdmrzUF0b9CYU3F1nXjeTkGWZ+KOW9Z2Q+HE87mhfLdP6Su8jyWC
	NDGTwVypORVEob0VuSjEYe45LZ/5UR1In/3114QOjad2d8Ut7SDCv4sgux3SAjxu
	y36FuU5FdEKyNZ651MenXBm6FQPfGe9/3gfh3fJXoPX+mADwDzc9/B5VBWcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790177689; x=1790264089; bh=4LRzUTgm2KpWUkEEV/yItf1itszDYBggd/9
	LZtV1X5Q=; b=aEwnj0KqIG/Ucgs4qp7TEdK4cnyVF53z+yLd5b8USeXZET2BvAW
	6oP5UaOvyhxPyUK9m6qtgXMj80gInuH7oql1REyACQkY75X+PjHtrQ/FG5/zW8/m
	e6Mf4d1FA23twUOYijBkiAdZ7jtvp5IPufcql/EVzzeCZwrHSUdMaqvQXxDkxcNx
	aq3of0JUQZWn0XYKMxOVe9xHgXVuH9hhmMfQgA+C/Hha9NjhAk+8L/VP0DTXF/Fw
	YHSy/+v+QvOltrXeiQG2NSUc2YoxkRRubiOdCQ3nw1B4SxzbbwRdLM/mLvdcb1Ss
	4dCLd1EDgzGkCwSfxzzcGKR7Tm0d8SfU5DA==
X-ME-Sender: <xms:mfGzantdSWHIuLly1zk47DWBNGlVuK9ZixB84fNxVa31e9SzY0LUpA>
    <xme:mfGzavU1ykg_488c-vNRkoG-lNeEuyoe-mgVhV5UqGohxCrEDptzhiZp0BuJKhaHi
    VnCcxS216-05nsAP6shcKgBEnuMvsUMGhDjTEeMifxfYYKfPC0FBo4>
X-ME-Received: <xmr:mfGzajGqgYG72oEqaGo23rttAtZjU81B3rLaul73sRP8ygd66I52yD9fco757yrncvuXi4e5ar8rz03Tq_mJ7TxUZe3ssFdt92fK>
X-ME-Proxy-Cause: dmFkZTEcbv6dLfybkZQCql6O7jNkxjr9Y7idKm30jtD9RadbXx+01otrzAQiM6+qr0bhBZ
    +p93ykj4UalMlGDBDrQtSNP8/NudWOIu9DGi783hIdqQBQ2Bqrsf+aj7lsyD7iiUYeI/ku
    q63qau6dsTUEKjqOaQh1HuRzqx+eNsDjwRaqV1Tn8W4Z83EvcXbPVE2iFEO5KQjrU7I5fb
    wEEE/OqYaah6O4n02tCcNVdjpI/V1xoyE6L1+dNlAVCHSnnjLPggoRVIFM/ZzTfNfxg0Xf
    6BPCvRqje20F0KeC1yCM1N6wQtjeaH9E5Ag7YwZ8dICTrCQScWlNGhBUPJ+QqYW+76CKOO
    2H4iEuRxPfvvO9s4cqM4nrXJrhIvTDYpjVBvNyLXD8kHMH9fz/4mJtMozoQdUzSP+erw6n
    bld2lFXaIadNXOah4geMcvOmFrjWMFmIO+gE16XgkFXeMDLRZyWoKtkbsb07OsznqGnU5P
    L3eFDdtEf5wv6czxGM40OMzXKVrddLIZxzgVF3/KXValBR5bgUnu2ME3TygINhhntvwfpK
    ehwSp60mRbJtmSJ7hTIj9k+dzIALN8hTpAkv/elXfcw17ThnTELkirdIHcQgtXOgn5F71K
    JqUGENqCw01CTKBuqGI/6VElL3+v1m3Ek85dqSMO4TDJjO2R9Pm19llktSbg
X-ME-Proxy: <xmx:mfGzah2n6otiQ6wMgaJxrcYjar5EmKS0YO0nA_xRdevBmHxL5p6qHA>
    <xmx:mfGzalPy3s7g1GDn9e3_m2uPoOfkA0ac9D5adyIsYgVmVGiOl-KM0A>
    <xmx:mfGzag4ZJMXw0t7QkRbtbcdATtzHwPAJGNwVxxIWUhlsN1q7ByAlww>
    <xmx:mfGzav2GAvIfHVjEem6aQwvWvQx_BMOz7m9xquAzpSgpr5WtwYCekg>
    <xmx:mfGzaok5QUMMcZpY3y5tuqRWS06X8Zo0NbJQeLbsR9SBwmgH46O-Hh_H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 11:34:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
In-Reply-To: <05d0e6e0-e156-4a2a-95a0-4986ab18ef49@gmail.com> (Phillip Wood's
	message of "Wed, 23 Sep 2026 16:19:06 +0100")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
	<xmqqh5jhfbyw.fsf@gitster.g>
	<05d0e6e0-e156-4a2a-95a0-4986ab18ef49@gmail.com>
Date: Wed, 23 Sep 2026 08:34:47 -0700
Message-ID: <xmqq5wzwc76w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> when 'remote.*.fetch' is configured to signal that special mode,
>> 'git fetch' would:
>> 
>>   - Find each local branch that has its '@{upstream}' set to a branch
>>     at the remote we are fetching from.
>> 
>>   - Fetch these branches at the remote that our local branches care
>>     about.
>
> I can see that being useful fetch mode for a remote that we've already 
> fetched from, but for a newly added remote there will be no local 
> branches with their upstream set to it because "git branch 
> --set-upstream-to" fails if the upstream does not already exist. So I 
> like the idea for fetching from existing remotes, but it leaves us with 
> a chicken-and-egg problem when adding new remotes, so I'm not sure how 
> it would work in practice.

Just like with "git push there :", you prime the pump by explicitly
doing something (for "push", you do "git push there mine" to express
your preference to work with branch 'mine' and share it with the
remote).

So if we are to allow customizing the refspec used for fetch with
"git remote add", you might do:

    $ git remote add --fetch=: second https://ho.st/git/second

which creates:

        [remote "second"]
                url = https://ho.st/git/second
                fetch = :

(Note: I am not sure if ":" is a good special token to express this
mode of fetching, as I said earlier).

Your initial "git fetch second" without any other arguments will be
a no-op.  You may decide to work on top of their 'main' branch by
running:

    $ git fetch second main:refs/remotes/second/main
    $ git checkout -b topic -t second/main

At that point, the local branch 'topic' is built on top of their
'main' branch by having its @{upstream} set to that remote-tracking
branch.  After that, running "git fetch" will update 'second/main' and
no other remote-tracking branch.
