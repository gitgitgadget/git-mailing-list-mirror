Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DE1474B7
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435112; cv=none; b=IqsDM+agNKNuOUYNkLVRNt5AFXqyKFG1mCfzLeD4XjwhsiRvXeFi60Rp/4lCyuSwet4EypdlCzNyqPfqsJwhmDZq39iS8iI3MkIq6G5vIzjaZO2r+u8J4Lmhv6Ca6B0VSQcezr3AbQijK+ftrfyIExUx4J5QTIG5ncBaVRyU0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435112; c=relaxed/simple;
	bh=1Vuu6cJAJz2m2E3gsTJcr8r2D18GPTvet5zMiABfuxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C56QYk/4bA5daBMPeOv92kR0Ll+IS9Cfzds3epKGfX1GZnGd2b/5hZMoex5RNGLBAaXPcNHRhcSZz6WBpDKpLeuK3FgjNypXpXkBTAzDE3Vw+9iEIjJHyVQMQjLg5x0F90vN91PYRM3R+AZ3H8PEeHTjY8h3c/xtT5ZCVjNBGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CVqD9pWC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oMRuDT/Q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CVqD9pWC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMRuDT/Q"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 230AD11400FE;
	Fri,  1 Nov 2024 00:25:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 01 Nov 2024 00:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730435107; x=1730521507; bh=x7Q16a/Pw8
	EILq3Co3XQtAqBxhBjRsHUMhz2E4IZEn0=; b=CVqD9pWC6Y6yzgj5Qy+ta9T4er
	6Vm9z3m2/5mFBqAFn3FVkcs23cw6yCsXPs3FhkLzX1rasQFFNQRW4M9h+phdv5uf
	ypJnlsK5mxNjhOEO9F1RYvEs9xOZtiugCA2PpfC4E7WDEjOkCC9JfAwq2GjV5Y5i
	YZrhMBw8x8nmIMJQuDAHN5cEAwCplkNz11zd+Y+xwp6ys3br3TCGFUvGKPclBI0z
	Lvjyb9By4R1NIPHnXtarTbQ0zuXWGzqMZCJqMRiel14oofh2+gf3qnOzFxEGio1x
	w3k0Tj4LawdqmAIXiF0CMoaNSGv6ur/S/N24EyqlYRaMLLEljOYoM3/pvFEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730435107; x=1730521507; bh=x7Q16a/Pw8EILq3Co3XQtAqBxhBjRsHUMhz
	2E4IZEn0=; b=oMRuDT/QKWsbX0cmPyQzw+ySAqI9TOTpeE/J1Vno2CTZaJDsuxz
	frRWcS8H5JOXj9+lECYXbIzHeABJSURfv9/M9wCcyecTLf1GQp6s2ppCIhPaHbTx
	7raEJpU7p+xwdGhlwnbLNnWQyh30OnuP54wk5qC7Ptnt0mHFpEaPwQS6GZMashU9
	MQOIiCuaCQGDCHd2MuVsTBVKdmrXu6xMwHIho/vMoshzPowrqgHJEpvcdttShvFF
	oSZpjIwfv3KpnaTlBbHpvWA05ljI1lz/wdC+m8ebvn+X8E3LL1XSyJ6V+yo71a8c
	k5oM7Z3sSE7sVMQhU9bgIQXUS4EHxpAYiDQ==
X-ME-Sender: <xms:I1gkZ6lf5bsgH_sQYHosqibRt1Gb7eSh0eDau46_apCImfIAMHnB2A>
    <xme:I1gkZx2tXRoJe1FSeijBArZpo_vdhzPdal4UTWlxUYuCMQ4fJtTi6RKo7JQLuc7bG
    7WAo5EkB7GzxV8vdw>
X-ME-Received: <xmr:I1gkZ4obhxdQybFo-rbTkybwVz1BuWhpK7Svk4riQj9vhxb6lmyPXoDclRr9RSY9uPxd5Ox2qJ0Xj1i1A8QmyXI58bzJkTW1nR-a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggr
    ughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohephhgrnhigihhnrdhhgiessgihthgvuggrnhgtvgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I1gkZ-khYLtHivYmlwzWcIKLNzlaW_uumrgF59D4A40vhz6xj9SnnQ>
    <xmx:I1gkZ42KdbMWEQRspX1iaFNQTwUGzYpDlmj8MYlLSA8NHmbnpSNjLQ>
    <xmx:I1gkZ1tIaYQHFriL5Ml4YGi4mdhiwXASZ0deFwoFWNPPSN9pXQ6vjQ>
    <xmx:I1gkZ0UiVwiid6jVH1XLJs-hAuB6_KzANEZsNseVH5IT-RpVvXwY4Q>
    <xmx:I1gkZyoB_uOBW6VHPzwAeo_2qdSxwlAlDKXeErXpKAH_tF68s_V9Ibfu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 00:25:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  me@ttaylorr.com,
  hanxin.hx@bytedance.com
Subject: Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
In-Reply-To: <xmqqikt74rs5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	31 Oct 2024 19:22:18 -0700")
References: <cover.1730235646.git.jonathantanmy@google.com>
	<cover.1730409376.git.jonathantanmy@google.com>
	<631b9a86778f15b7086e5f17fe850ffa151dd341.1730409376.git.jonathantanmy@google.com>
	<xmqqikt74rs5.fsf@gitster.g>
Date: Thu, 31 Oct 2024 21:25:06 -0700
Message-ID: <xmqqcyjf4m3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>  	commit = lookup_commit_in_graph(the_repository, oid);
>> -	if (commit)
>> +	if (commit) {
>> +		if (mark_tags_complete_and_check_obj_db) {
>> +			if (!has_object(the_repository, oid, 0))
>> +				die_in_commit_graph_only(oid);
>> +		}
>>  		return commit;
>> +	}
>
> Hmph, even when we are not doing the mark-tags-complete thing,
> wouldn't it be a fatal error if the commit graph claims a commit
> exists but we are missing it?
>
> It also makes me wonder if it would be sufficient to prevent us from
> saying "have X" if we just pretend as if lookup_commit_in_graph()
> returned NULL in this case.

Again, sorry for the noise.

I think the posted patch is better without either of these two,
simply because the "commit graph lies" case is a repository
corruption, and "git fsck" should catch such a corruption (and if
not, we should make sure it does).

The normal codepaths should assume a healthy working repository.

As has_object() is not without cost, an extra check is warranted
only because not checking will go into infinite recursion.  If it
does not make us fail in such an unpleasant way if we return such a
commit when we are not doing the mark-tags-complete thing (but makes
us fail in some other controlled way), not paying cost for an extra
check is the right thing.

Thanks.
