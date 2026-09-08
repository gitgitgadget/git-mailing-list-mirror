Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014356B84A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882792; cv=none; b=TZEmqu1dwjFxquxF491th7K9tBFL+Gu3zcvOvEf1DZu/UmBMnbbikeGvDE/cUbPxOqyrMI0o6j2pidL+ajv/0p9lx4KH2x7dUaSfiFmfEiPWYGPdwEpBfkexkgPLRn9GnUm8+X6KL2VXMOPj5sBwwWlCpVJgFSuG2NJuQ0IG7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882792; c=relaxed/simple;
	bh=b4/y2uN8Thio9q+evvExORIvwWNnyePbhwff07gnZgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U8pOIfAV3uy7bAmP2wpqrQFQ/cuEQaqvFQYgZp9cEnyqnRDB0ojvHi0S3ffW3YD4vqLzoGj7ja6fbphPZLoV1yTSNN+Olj/FhDx3uPMn7y31c7/c2mRVhKaSQfK+D1j4yKmbtmOoL00xh+96xfEchwPB1+9BDFQSSCRtDwf/xQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TGDnJ9gf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5k3c9ZO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TGDnJ9gf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5k3c9ZO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2330140000F;
	Tue,  8 Sep 2026 11:53:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 08 Sep 2026 11:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788882788; x=1788969188; bh=YweyuVWzH6
	CItNt0eLM4epg5D/6oT1P2QGdY3au+yqE=; b=TGDnJ9gfn/CHi8KAHqTXyzHOQ/
	ylKsvNj96HxWMcpIHs1T+anBHbDASVm4v4dUputdVzXOr1bVH7NlZtZCuIx4KzFj
	ahaKhWNkBjcaElqWyDEsce/APno+Rze5rXOiwwoGVY+L6rDDyHczx1PkMSasFYkW
	cRkERQfAmvY72DnYaCuZKwP5ScfhMfb+s/3cT4oACQaT8Y5Cxfqc4BjNV7P14ZU3
	CVUIAAWLmyEz4R/UatU4rV2FsMAPO4zdEa3LpFexUoQtEMJmNRHNZu4EbApohvyO
	7+P7Tyk/EoJY/DZU5XnWSEefxBwMxr7IbOj0CQ80wW3+82ETIqMuMdCvkfKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788882788; x=1788969188; bh=YweyuVWzH6CItNt0eLM4epg5D/6oT1P2QGd
	Y3au+yqE=; b=Y5k3c9ZOONjISfoyMlw7cXIlXc6cSKdG3ItnRbYGvWbHBQ9wPjp
	bx5Yo7ocyj5Uq94uGn+lk80tb4sH2+AT1xNZy9U0mEGlZ05GOOqcg95q8P0eKsxA
	3Kk5WlBTRsK+ZwZUtejxLzPqNtE0N9hVJYM+iLDxBJwWVzn0An4eoEgT4hww2X9u
	zRntYEHpWU4zis5n05I6f6a7L9crl7wTYbcz/M0b9dgQeFyRNGODLdmAF4BQ97sU
	FgMH7TxTHlUaEeK64oh/XkVWUnILmXMvfNoK1jFIViXDlZOhUrNVzMuhzHXDnsDr
	ugEtVfSOmRN6uck9qEc6mLvY0eZvcJd3JGA==
X-ME-Sender: <xms:Yy-gajOFVqpPTKLR3UC5j4bxjK0HU5ok558g2HI9nLRs7vgTSK-sWQ>
    <xme:Yy-gan-mb7y7PVZWbhLnfOXtzlUyNPar0dnz19UnuqnT0w-hvOvTPZ7wSuXfgkbNr
    0OgA8Rg4nl9E4ncYvmY00NOeeEEbdOaziTwEAHq2uYoWMwd-WsNgd4>
X-ME-Received: <xmr:Yy-gao6MclKp4EGFVlm53pnlcv5FZpmYx9L2-BcassDQQ0QXgRstwDMpNlfZzxR1bcIz995DV3VjOjiYpwkT3wr94bMY_Npdile->
X-ME-Proxy-Cause: dmFkZTF2I0Q9YZkbFgcGJxq2rAuBLzDzh461OlyqllUr7YKDAOiKtpdma96l9Kxmp3S8Lb
    uUbTqWW7cgMpzAa1+E8yC+I4aPsxDb7aHG3xFIgshd4lSMvzgnnPvK9LiTISARhIKa8see
    Aj7cBKquTAJB7RNF8zsxQccu5hI3bASxsVl5EAo5JbQmFrGD3b5D3DAMWK1eQTkHwr9jRE
    ITBGtwHrgcGP1fnW7SOX5GwCdrfp12B+kIAlw1EfrkrhMskRa7vtP7452k7sXM76FYdnK5
    RvOmS60i7sxCLElX5GPC5LwhTj75seiCbtEFF8f2dbXn10/wVMoxSvscmDUnSFRSZlOJEt
    X9VT10Ibic3Gdk2JQlCVCF9rXiR/ZV+Ta++ZeVcOUbQCoCKz/QjWHKGEm4ZI4YPQSq4/9p
    Su6Po1cXL9j8CDUUCvz/SWehbPe6AfwTO0aozvaUGH59xnfIdBp0/MPHZ0fPtB6ma2rwBh
    p49VlYgezj7NlFyGSC7G6LYo2SjqsZGQNwKGgxVkhHgHsdhYHa/iVb7GfOxYtlhjpWs5uF
    p3p/Ir+Utj5KpZ7UY8MQg1I+L24t/HUBxo76aXv6o+BJ6piZevMrWiX04Dh8eincS2n1nr
    uPPQ+TJYXUDdgxscDjXvA+ldWQKgB5ENOKqaIYssWppOiK/YKFP5jQJDOSyQ
X-ME-Proxy: <xmx:Yy-gal5qrZyv1uhEvSqyddWR3I3k2Xk7Njigf3uDjyt8ngjh5LBIlg>
    <xmx:Yy-gapoO0phJYCSfkYHrvsSz3-jcTnb_e6KBiBKHkO_8v4OFXfWePQ>
    <xmx:Yy-gauNzOv8G1jk0XsVzN1rw38hthNSGXvwKD-9lDLZylHGp3VKphQ>
    <xmx:Yy-gap0eY2YIzpiQRSbFUcesd4doXfa7aRIrLpG_L0F9MYVpd8xB2A>
    <xmx:ZC-gaqi8mPjEkR5DapaUtJGaiP0XxvsL3YqIZmun07GZmdj8w0jTQBTW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 11:53:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v3 0/3] sequencer: leave auto maintenance to the end of
 a sequence
In-Reply-To: <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com> (Thomas
	Bachem via GitGitGadget's message of "Tue, 08 Sep 2026 10:28:03
	+0000")
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 08:53:05 -0700
Message-ID: <xmqqse3jyc2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2:
>
>  * Auto maintenance now runs from builtin/rebase.c and builtin/revert.c,
>    once the command is done, instead of from three places inside the
>    sequencer. That follows the apply backend, where "git am" leaves it to
>    rebase.c (Patrick, Phillip).
>  * gc.auto=0 dropped, maintenance.auto=false is enough (Patrick).
>  * config_parameters is a char * built once with strbuf_detach() (Junio).
>  * Patch 3 extends the tests of patch 2 instead of adding its own. They also
>    assert that nothing runs before a stop, and cover a single pick with
>    --edit and a sequence ending in --skip (Phillip).
>  * Commit messages rewritten: what GIT_CONFIG_PARAMETERS is and looks like
>    (Patrick), what patch 2 changes for the user and why the call moved
>    (Patrick, Phillip), and the comment on the helper (Phillip).
>
> Based on master. Independent of the rerere lock fix in [1].

Will queue.

By the way, is it just me or are proposed log messages getting
longer and longer with more irrelevant detaild these days?

If it is not just my imagination, this trend must stop.

Throw "Say the same thing in 1/N of the words used." followed by
these proposed log messages to your near-by LLM, see if the output
still makes sense, and adjust the value of N.

For example, I got the following from [3/3] with N==3 and I think
that is far easier to understand than the original.

    Sequencer-spawned commands like 'commit' and 'merge' run
    background auto maintenance, which interferes with ongoing
    operations (e.g.  'rerere gc' holding MERGE_RR.lock or repacks
    deleting active packs).

    Pass maintenance.auto=false via GIT_CONFIG_PARAMETERS to all
    spawned commands.  Building this value after user settings
    ensures it wins and propagates to child processes.

    Auto maintenance now runs exactly once when the sequence
    completes.  Commands run manually by the user while stopped are
    unaffected and continue to run auto maintenance normally.

Thanks.
