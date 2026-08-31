Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D64A261D
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186834; cv=none; b=BA8oY/EfnWdPEcjs02fs8P1M4kiSnQ2OomUa3IqOws3MyClvwraAzEpEftYkV+cPoYMAThR+FKjZSrQASev6HB0dz68E455pqwS4TwhxYegkdwgWiLnd/8L/NzPjg4/SoW13Kpu0EG0JiJWXNox32Mf4OhI12XaCnJP7c1BdUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186834; c=relaxed/simple;
	bh=prlhcVljNiRp2W1Z20JEhA+o/AN7oPexzi3varBJUAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQiiQFm6po20buOe6XuZmzmt3s/4U+PfeeTIF2XdZjUxa1f5sw9tjZBX+YfTmqOBfdKQZibwQQY/KY9ieqIuS8XejVDH0ZElNP2wzDyq5aET0/ht23qH6r03Q1LMq0qgo1/n4cgxlReVR4DD570aZqbhs6yQ7ug82WOwv2PBZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A6Glctd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSKm4H6k; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A6Glctd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSKm4H6k"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 424581D00193;
	Mon, 31 Aug 2026 10:33:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 10:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788186832; x=1788273232; bh=/qLWsGLDGj
	su7DkvkbR9haToELRs1GiDy/H2SEPevGU=; b=A6Glctd7MNZ3CH3+IVgFLB4SyB
	0Vq5XzSHSOac3tWGvCBPZETpNtAks0xdF7hhF4CU/dahsC+dKQ8r2hqTjKs+4UoZ
	OYVIe0VJaBZj4EdVFMyj7BLjBITQiQWAEqizPKUWSLaq8mJf9ZtrFgIUC6PIxp2w
	2qfV2lO4PmlcN75zX9fifH7nRHWMA9E8l90PqSuAKV5cyPRtC55i/QhaUr9+TdOH
	YASoXlKChQBvxEM1j5t0i9d/4O+jrdHGMJFYEZdxO5hRJYWECsfB/S1eHLjEIh3Y
	VMyG4fkCsKDNQaJP6f9nmplIpxYuXGXRG7eAzbFypLQk5Eu/FuTiv6YP8vig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788186832; x=1788273232; bh=/qLWsGLDGjsu7DkvkbR9haToELRs1GiDy/H
	2SEPevGU=; b=SSKm4H6kme0R4bwXqeCvE08LUVndFdDnIYYPq1PrZwdA9QVzkUp
	WnKx88I60alNbj59PNG+i9ibv8bpzt2HXJakqooh4f7AjRu3iPwjTMt+zCern9PQ
	/zXvFaf6iQGXj2feumanO48yzc/J6KySynVyIcydTGOGwl0f7HNiko3ig0/TwxWU
	I5hkfSTFPAC61LYHAKWCzIlN4cohBQM8czxlk4zYu0WyhKu4PoRXr2njifwq+fTh
	fyXWPjewRDYHFhGzjbKTxBOOjL4C6iVsLk/AE0OjQgy1+P6aRmWGuNKmwOZPloy0
	xAtHaj8pJYCAABglmgHR4+7Ak0R423+7dkg==
X-ME-Sender: <xms:0JCVanzPPIoRo0sP4BLQewjNH4JDqLaU9eg3hmD2LTI0XR02gq7cEQ>
    <xme:0JCVamSAzK9IIb86o_eEN2hhn_aYI2XWyCdSzM_-6KPuOz9MfRP7BgSoq_RYOfAa7
    NAgudXkLdDuCbOAeQ0eFXrI2QUWNCH_aHzB2XEE4iIgL0mn-QIyUJY>
X-ME-Received: <xmr:0JCVamWQhhctJofQcGlW_awJnX225-nUKB0oooU9TwtGe-JwRI66wc12aEpK8Cwqu0pOKO0N4fU00TtxQjTleeMr7V0jkhwdcA>
X-ME-Proxy-Cause: dmFkZTFK6JCetpylcFb/QC3DUOfHZYhQNvr8p/1HbCfwvgZQHcI9LCLkufFvrpU3BSPLWZ
    4SuePi6pon+499CE7jgFl0nkFz0ScccOojkukvHRKYRZCO1pkdh9aMKCk9zX1ZSAgWypZa
    bPEW2iQKWkKdda648C1LsvWAMlPiGSwqr+tMMSSI6vUyLgxYr5L59tZ5TrjMhUsKQnoa6E
    EYVf1Xd+Q/yWby6TokpYLyjSt5ceK/iBPKDv68QR6frK2/+n5dUVyoAvvGXwFHaoFgjQ6B
    /nDOXEp32LrxzwIP982wi0SiJkHJ7yLjR4qCCg2rbCLebEpeUZ5RmJO5Zhf1TjbV5rsCA7
    LzeqyC4ceevE/QbtsfRmABcg+SDDhrMihrWEjIX5zB0c9TC5P35FVCYRn3MZm/XaYlbc/n
    wjlCwyZRfZY5fbAGGX7Hx5qiz6e60H09FV7qo2looY2T5Z6+0TS1zKe7QMmFtXzeWnvny5
    ONjxMrWisx7tKVGWKfgwH32A9ypmouwTYrzZE9s2pPxgy3py87FHaBtkbdRdnc+swAQMhP
    0+a5G41ZCCRu/GRVa2J2sY0Zajqqj6aleq2jNboZYfntIN+i/b78MtCUmClm0epp8YhyfH
    lahGmGrLrC2BRXyuFwxkbCtYFHi4MVA5smTYoj5d+vrIzwgEECx5LuyXpjCg
X-ME-Proxy: <xmx:0JCVagZHQna69692D_IQheHkBZvTE1mV2ZHl8HWixsM2_kRX53hycg>
    <xmx:0JCVak3X0EAgnOEtwomn69hQRBEkI5jwxBfp1-hn7BYVHardw2th4Q>
    <xmx:0JCVaqgn7cnpIwaI8IWBRpKZ70OYsC0LQWEWxDhZUAKuLUNCRGb_Eg>
    <xmx:0JCVagbmZdIxDnESSmra9DVozDMb3HpwCwh6gh9toscjowcYbVUw-Q>
    <xmx:0JCVat1GVyxNrgF1m20QDSE_CqzmF03kxmCFuLCDuanoTgb6a88hIsQH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 10:33:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] ci: cancel stale pull request workflow runs
In-Reply-To: <CAHwyqnV5YTJsAnDDHQj0gwmoWXEgnPSJ8tJCcXrg12vBvtwFfA@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 31 Aug 2026 13:12:32 +0200")
References: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
	<pull.2369.v2.git.git.1788087560290.gitgitgadget@gmail.com>
	<xmqqqzjfz0ba.fsf@gitster.g>
	<CAHwyqnV5YTJsAnDDHQj0gwmoWXEgnPSJ8tJCcXrg12vBvtwFfA@mail.gmail.com>
Date: Mon, 31 Aug 2026 07:33:50 -0700
Message-ID: <xmqqa4q2z7e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> If a user has CI enabled on their own repository, pushes a commit
>> there, and opens a pull request, wouldn't GitHub Actions trigger
>> two events for the same commit at the tip of the pushed branch?
>>
>> Before this change, both events are assigned to the same concurrency
>> group (the commit object name).  One waits while the other runs, and
>> the skip-if-redundant logic stops the second one early without
>> wasting cycles on the same commit.  With this change, the
>> concurrency groups for these two events are separate.  Would we end
>> up building and testing the same commit twice in parallel?
>>
>> I suspect this may not be a problem in practice given how our
>> contributors use GitHub Actions in our official repositories (either
>> those owned by gitgitgadget or git).  They push to their own
>> repositories where CI may not be enabled, so 'push' does not
>> trigger.  Still, I thought it better to bring this up before the
>> change gets merged and wastes build cycles.
>
> Concurrency groups don't span repos, so I don't see a solution to that.

OK, then I do not see a need for solution to begin with---it is not
a problem, in other words ;-).

Thanks.
