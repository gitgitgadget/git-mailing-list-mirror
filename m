Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5E37BE97
	for <git@vger.kernel.org>; Sun, 24 May 2026 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779666261; cv=none; b=P3zN9QS9qPsPElNRva5RTW55PaFGubUWeQZZai010GB6F3+SxPbpuosCJjHc9wyYWFs0QQwQjvASD6y7SQkClYSvR/uLN4UtXYcgc3mplbzbAl+/YnYnveyWMumSO4RhiCfUrnSSagnmhhihPDC+PdpGhchkP+JyZnw3e1ULcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779666261; c=relaxed/simple;
	bh=ZHR1WDxsXFPrSbfN5buJ2KJA/9FKjXtQw9NDnm6XMsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEPQQ4BrZLX7AgYbCYwaAfLgKrBNo/IacV1Tj2wfPdxPupYnz7crvFWPWEsQuRArw8erIByCEHGrkicjgjCcnPqFHClSBu08Z1GedkmaU2yUfy0XlNC6PA7C6R8WT3gtxwTnz9Flk/xUazBLvs0ijzuzTD6mohqGoQ25e/1BiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wk5+GgCL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ciWxjhml; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wk5+GgCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ciWxjhml"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 763B6EC0212;
	Sun, 24 May 2026 19:44:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 24 May 2026 19:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779666259; x=1779752659; bh=pCN1LBkQ7V
	DFbvFFWDQ5V2mVQK0tTELlbSXP5qWpoGs=; b=Wk5+GgCLyH4bOtsA6n/FvPlXKx
	KoBD0yzZuDm4z5f9PHJKhy/X2h63bh/fI9vyI5Q6V3+wMtLJ/1FpIwuRwDFuqCg8
	BSPo/tEfslfm5gDuNfvZKILsb7Gv3qH94hvO+ppYI3c2XycV2goCrsA7S4/0TWtS
	DXh3gCxznrtV7Oc2jHI7G9IQ5XEE0itT9O5lGyOlmt1Qz+EJ6RjfI9ykwJVCNUM2
	uS0KU/1SoaxJOaItbv/0BYXr+hdzIjKcs3zBRg7r/V0rO7AR0e8lr9G58DLzKXVQ
	MYTt7hkKuHJgVuvEjxKfMAFSxHPzFbhQz+y9TjlxqKr04xT64o43EycDoE/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779666259; x=1779752659; bh=pCN1LBkQ7VDFbvFFWDQ5V2mVQK0tTELlbSX
	P5qWpoGs=; b=ciWxjhmlVaZ5Fl4ffeAjPvOfGPY8cvxU/RvjT2/++r1/UWdrtfG
	whMk1XQ35g0ROgIZ0y4TFky6B/BtlNq5dnJZ3bBY4R/+cc1HTIyPxv7GOkh8CzLg
	M4EkL6BDYSvVrWPlqHz8ECPagjtqIowo2WE0S7m7Q7T/Uuwn6ySfdWPKUwi6ydIV
	W083gHP8/9vgNZZJL4YvJMooaGgKZW7p9KowflmRsXdtmBy2v3jSjevmVbMBVzID
	7dlEEKOxwSV3PI3axD7fLMQBvfsK/u1bva6Fuw2mhKIrRx4dRUs9tOVv1BT8fQFp
	1Zo7eX3221sKeB64q04r9e04aeYo/D5aXIQ==
X-ME-Sender: <xms:U40Tar9QKnxhoqYROtYPxP2DR0uiMAl4tS5yqmOklzoZj5N7H5Li9Q>
    <xme:U40TauF5DkfOaDVgqJsQ5RQjeV5dOYf6JvXDJDolK_85bp90Td2lDF7acgTfvecwf
    K_OMiGwucdVgD-OFez6e4GK-z2U6QR1W06CeYtlspK_ky752EK7xQ>
X-ME-Received: <xmr:U40TalQsBjl__jtuZ_mZj3XHbSmZWWSYPIo9oSreqem00hdhdlDaGlsi7Uzmw9-ZBNrJY02ptvgUZGqeX8dmsWlDN-f6j0tyuBw1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:U40TalT3Ue6PeiQ5QqDT6KiyqfasZYFcp_loRUU6CllNDlqFOMK2Cg>
    <xmx:U40Tao3RdY9dcWPuuGf5Ax71sPEKx3TEGVCv9g5CrD_up3NZWb3Fbw>
    <xmx:U40TavwyFXGrgVr2Q32mCEL6tg4H4xCiv_gB6sCGLfz9SSq0bgw8NQ>
    <xmx:U40TakwAEzRVOysfgyBjNRjaOSAEwI_t7jaiWzB1VpigkI4QtvhKMQ>
    <xmx:U40TapN72qUx2eUfROYUxiPN1EBaoQ3aywn1YbMq2_QKUvsrI6vZVzyh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 19:44:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  christian.couder@gmail.com,
  johannes.schindelin@gmx.de,  johncai86@gmail.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  newren@gmail.com,  peff@peff.net,
  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 00/13] pack-objects: integrate --path-walk and some
 --filter options
In-Reply-To: <ahDbS+CtwsGx62Q3@nand.local> (Taylor Blau's message of "Fri, 22
	May 2026 18:40:11 -0400")
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
	<ahDbS+CtwsGx62Q3@nand.local>
Date: Mon, 25 May 2026 08:44:17 +0900
Message-ID: <xmqqldd8gypa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, May 22, 2026 at 06:24:24PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Range-diff vs v4:
>>
>>   1:  0840110116 =  1:  0840110116 t5620: make test work with path-walk var
>>   2:  d7c87545f3 =  2:  d7c87545f3 pack-objects: pass --objects with --path-walk
>>   3:  fb8a0f9c43 !  3:  697ef716d2 t/perf: add pack-objects filter and path-walk benchmark
>>      @@ t/perf/p5315-pack-objects-filter.sh (new)
>>       +		awk "{print \$4;}" >top-dirs &&
>>       +	top_nr=$(wc -l <top-dirs) &&
>>       +
>>      -+	>depth2-dirs &&
>>       +	while read tdir
>>       +	do
>>      -+		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null || return 1
>>      -+	done <top-dirs >depth2-dirs.raw &&
>>      -+	sed "s|^|$tdir/|" <depth2-dirs.raw >depth2-dirs &&
>>      ++		git ls-tree -d --format="$tdir/%(path)" "HEAD:$tdir" || return 1
>>      ++	done <top-dirs >depth2-dirs &&
>>       +
>>       +	d2_nr=$(wc -l <depth2-dirs) &&
>>       +
>>   4:  e77c8a6bbc =  4:  91845bcef0 path-walk: always emit directly-requested objects
>>   5:  f4904f81e0 =  5:  fdb9361198 path-walk: support blobless filter
>>   6:  f37467e46f =  6:  89726faf7e backfill: die on incompatible filter options
>>   7:  133c1b156c =  7:  3884d4737f path-walk: support blob size limit filter
>>   8:  0f517be8e3 =  8:  31b4ef0fa1 path-walk: add pl_sparse_trees to control tree pruning
>>   9:  b4dc09ab69 =  9:  7d8f0aa036 pack-objects: support sparse:oid filter with path-walk
>>  10:  0b1eed0790 = 10:  a68676d0de t6601: tag otherwise-unreachable trees
>>  11:  b23244c4c2 = 11:  b0db73c6cc path-walk: support `tree:0` filter
>>  12:  7e1e503361 = 12:  6845988f50 path-walk: support `object:type` filter
>>  13:  a615b1a707 = 13:  d33d899251 path-walk: support `combine` filter
>
> The range-diff looks good to me. Thanks!

Good.  And as you in <ahDbS+CtwsGx62Q3@nand.local> were already
happy with everything else in the previous iteration of this series,
not just the changes the range-diff output shows, but also the
non-changes from the previous iteration, look good to you ;-).

Let's mark the topic for 'next'.  Thanks, both.
