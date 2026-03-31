Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E64418DA
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979752; cv=none; b=dN3SigFXfMOqbl3Bp4QsxBdHJr6PIJbS9t4HTsbQuWUo64VLY9e4QFMyhQEHzhYXs4tNZOVdDwQqr/hc9SWx0uW3HP5Fd8xYLMxaWfWdRNH3p72qOJEL+YbK3jpteYZrF3T6aDCfp55KhHpOZ+3/FCQW7rRNqlhPtVh4wyXqaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979752; c=relaxed/simple;
	bh=oCrJQoSIhWDlXiIGP2v0cR4m5z8YPAAKi5F96//GW2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlqcadghzzOIB1istl98x6aEu+8lLnlVLn+o3o3FNo3B/y7rD38vLn+Mq0NM1n5tE5/nIQSuBYYh+rlRge92to3JRXbhhgljdQeKvDMhoqOuOx3GLyNtPjOgylxKt0NvZRuJ1KKc2ce4QvhyXWFfsxF/LHyDFakGpzyyP8Two6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YlthrfC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNbtH/pX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YlthrfC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNbtH/pX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FAE0EC00C8;
	Tue, 31 Mar 2026 13:55:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 13:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774979743; x=1775066143; bh=ZcE+rVVvy1
	84TgWsXhnAgo1VOQTD4zQ1wGFEa1uu7iM=; b=YlthrfC7PCu7dYSno5h8AXcv3H
	8Rp8Ny8s/UTHBj7QPA/71IaUKamx81vB8tz/4G0MPK0ngjox4PX1WsUpSWpBhsAz
	2+4IStIl7u9q0BbZuF6F9nexlzHcpk9Y+x1CHw8u3D69Kn5/z0ERzDKQmIvHUx3O
	jTwvGeApSSYXmIKslm88k4mYm0gqTZXgzX2J37kxTnuqmS/U0c2+lu+E6h9zKq7K
	+PFgPGk4+gonZlp7NNkklbPf/yjloBnwsOtZxSQ9J0InJk4v39RpHy2AOuRyGsZU
	l1ziSr1KrmdY0ecvnQPGWpYs7M6FIgqy4BByoZdCAsGEvUckim9pqVDaAUxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774979743; x=1775066143; bh=ZcE+rVVvy184TgWsXhnAgo1VOQTD4zQ1wGF
	Ea1uu7iM=; b=YNbtH/pX95AsyZd6mQQ3J5YOiB9naIVHCB1Ytw7HgHF4NIHJdwZ
	tIELIMuKPYwY1BbpOgj2+rtpc7yYFvSgPb+uiZHW3WBgDh8coC4JE3jvcS2U5WAU
	+WY3GqooV/BrgRem3CgSYXaWdN831DKNX2XpjloO+ZVTDj2gD6gGGkGsCvUAPnwk
	5W+8cw2z5hXpw7Jw8Sz5+AMJFs9EwH40r/eVwCTPlUO1qjEks3tXANcCrJwtUQUP
	4enMELbK0EB7VfHgjLoj5lH6XfL2bmF8y7fqMy1VcBApcWQxhLUDCPKASaFpXYk6
	le1y39MEtcwdCMbDS6IdZESYsoXes8xtxrQ==
X-ME-Sender: <xms:nwrMaWi0dL9LMzmHCBQ4ebQ3NRRGqdzhaROuRiWxXhE4g0MS5UQO-Q>
    <xme:nwrMaZREdN2orJnDf7VOQYx700dduQCNQYF48U7y53q58niTr43tPFFsy3Q7CAfS6
    nw39jB4Cw0H43lWs4vC_OYLyC-fJvFo23qJwsyHitVxtnro7Teh>
X-ME-Received: <xmr:nwrMaQUH0jsAPl19kp0XrsiufEvkTZ2mEtZ_z3Da6ueDD7YQtTy8gxs9sOrs797Hfgb5rpY0TvOr2RLL0-o9V3Eh4LJSC0Un6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshht
    ohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehprghulhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghpthhtohepghhithhh
    uhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:nwrMaVTpBohx79qeV0YP1Nf-MMVV1avHF7mwER7spArvRKDu_7dLig>
    <xmx:nwrMaSmlt1m8WBSLK8nzr8tYc5WMoKr2Wn4UscwDh4IvmP5fc1eJlw>
    <xmx:nwrMaT6IrVM0L88MhF3VFpicy0rV3xTV41atSYoATkyqSihhxMZhmQ>
    <xmx:nwrMaQgSTVooFDmsgVOYGYEKuhc6u-a6IDs0qu5kRZeeEGRoUa3bog>
    <xmx:nwrMaZg5ty7zpprLydbPHWORlplWv7qyud7TadhdzciYQQJqNnEcN6xD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 13:55:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Paul Tarjan <paul@paultarjan.com>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in
 tweak_fsmonitor()
In-Reply-To: <xmqqse9g0xbx.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	31 Mar 2026 09:37:22 -0700")
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<84ddbb30bb3862d4230ba1775d4c061832f2623f.1774937958.git.gitgitgadget@gmail.com>
	<xmqqse9g0xbx.fsf@gitster.g>
Date: Tue, 31 Mar 2026 10:55:41 -0700
Message-ID: <xmqqfr5f289u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I also have to wonder if we should bury the issue like this patch
> does, which is not limited to the split case (i.e., the assert
> should trigger if the requirement is not met while split-index is
> not active, but the patch castrates it), instead of mimicking what
> Derrick did to work it around on the test side, leaving the
> production code still broken, which will give us better feel on the
> urgency of the split-index case in the real world.  I dunno.
>
>> Two places hit this:
>>
>>   - tweak_fsmonitor() calls assert_index_minimum() without the
>>     !istate->split_index guard that the read path (line 98) and
>>     write path (line 128) already have.  Add the same guard.
>>
>>   - fsmonitor_ewah_callback() unconditionally asserts and then
>>     accesses istate->cache[pos], which is out of bounds with
>>     split-index.  Replace the assertion with a bounds check that
>>     silently skips positions beyond cache_nr.
>>
>> Signed-off-by: Paul Tarjan <github@paulisageek.com>
>> ---
>>  fsmonitor.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)

Let me ask the question differently.

>> diff --git a/fsmonitor.c b/fsmonitor.c
>> index d07dc18967..5e5a4fadea 100644
>> --- a/fsmonitor.c
>> +++ b/fsmonitor.c
>> @@ -33,7 +33,8 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
>>  	struct index_state *istate = (struct index_state *)is;
>>  	struct cache_entry *ce;
>>  
>> -	assert_index_minimum(istate, pos + 1);
>> +	if (pos >= istate->cache_nr)
>> +		return;

While this may avoid this "assert" stopping the process, what is the
implication of returning from here?  Who are the callers, what did
the callers want us to do to the cache entry at the "pos", and what
happens to their expectations if we simply returned to them without
doing anything they asked us to do?

>> @@ -805,7 +806,8 @@ void tweak_fsmonitor(struct index_state *istate)
>>  			}
>>  
>>  			/* Mark all previously saved entries as dirty */
>> -			assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>> +			if (!istate->split_index)
>> +				assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);

This part does make sense; the minimum may be relevant only when
split-index is in effect, so we limit the check to non split case.

I do have to wonder if there are some invariants we can/want to
enforce here in the split case, but I do not mind punting it to a
fix that is more focused on the split-index theme, as Derrick hinted
in the earlier commit you found.

>>  			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>>  
>>  			refresh_fsmonitor(istate);

Thanks.
