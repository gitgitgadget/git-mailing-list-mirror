Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA719C553
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191718; cv=none; b=JJPvlJkVzaheoyAGftW35AMVpmCi5ZhPmUsklBVV34jjl85sF8KphROzM5bl8LPhN7Rhlm8uVg7gr94d1XGMdud+ZNgKrGK9XHEbroP1QPEVpSwa0SmiDGdB5DKwz4yhqGZad5Z2NrvzRX6UzvoXs6DL3lW9NnLkUB585lF9ROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191718; c=relaxed/simple;
	bh=KuD2SkWjdS/Iy2xHZBj0kyAu/kFiVwoVF/m5Jl9T7jE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAb43lzTjp6hkISZmvW5LH7eO9zWl1aHnp1eBIAH/uAQmdSYavrGlryIPCx3ial3L0Y862J6KqLQnGtVB7NbgvSC5aLDYrXn+Xjf/WmtEMUwUOViMt1OAGMxqeU0K0KJ1pXZFKurnLA/uiKWHfCkEfnBvZZlCJ9eISGs/6aCv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZV6D2TnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jxa701lH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZV6D2TnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jxa701lH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B71D1D000F8;
	Fri, 23 Jan 2026 13:08:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 Jan 2026 13:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769191716; x=1769278116; bh=xlFqFUAdUC
	xtuJiAkinEYpXCN4fW2Vbqw1UjVOk52b0=; b=ZV6D2TnR/jUxdXRqS3bjnDdmJI
	Wf2M82I+FPzoeLwVwvq33LyXx2WzGFVz0sYG6NTTt6Piq1a6jPq7KdiQFGKPej/p
	MRZB5pNZB4afvXzePdnBcW5BH+lwx/85ZVjdNqDoo5maPCsLgg4hel0T7ltZ/2t2
	BEJjMkDuGZHBYTP/WRl+UEFfJjYDE+sad5A3jOoz1zLcGE4XMjK9vYwU3DkomNUl
	3Ix7KnitOlZqcB4/W45BXTfZL1k0P9ErGLfT574aXntLOEnpzJ8WfBlKMhp+EsTX
	QFB//3OIwLyrUfLcr9hFYcGFpfCZPXxGVZttSNneUG5VBvD3qUUUBMGUjGrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769191716; x=1769278116; bh=xlFqFUAdUCxtuJiAkinEYpXCN4fW2Vbqw1U
	jVOk52b0=; b=Jxa701lHQuUprtIps1dDeGdwyjv90ZBa4JgnPSW8IQHyycYkikI
	wYwci72GgulK0jmBLNAralB8YLvINRmb83cdsh1lzwxjKfHBeMlA65XVxPzWTiW+
	+BYYrrnIVkQLIFzRSclFYdGfqjyQKqGbK93+jPASGTsU/zbSZ74WkKpHpzIZkQNI
	0yP3NNeNMKCKdYQ5csJgTeBkbU/Kfgi6SK7aZT/gO5UyaYSUP7iV3EePZjAHpbcU
	M8+SlpUqYPmQnK6tcj46IBSyJCr+FkY5ZiPeEu2sHAabi9tMOducccNLiDFY5Vfz
	KQQA1R9tH9tgQEvcVF2NMvYj0fzgr9LQMSg==
X-ME-Sender: <xms:I7lzaUPex3G8ZRpLKXmpavqbllQkoA3TfTkiugOXJ_z4_FZxoQhCVw>
    <xme:I7lzaR27uh41tUp2Bmf03lTCcjFJCv30MfKFT1K3vwgu2siO6wAgQy-KfpN2nED8N
    LEsLQfLB32BPnMRmFEOU4hIzJNghpGEOfzSsR50F87TWdPp3N33JtU>
X-ME-Received: <xmr:I7lzaTlMbCHyOH2AJgVko4fB3ag7he2xBFrT58enUvkeE3-FS3MAGjNERTJH0jRwf0DVQav7NpEE4YVlw5tMAOEAPH7pQ7TZgHCNdYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I7lzaYXUxL9mf5uvv7s4sIMyUaVciOIENugPvLmxNukqd4G1cLZNcw>
    <xmx:I7lzaZu3b_P5syx3ObS6UrFGtLkJO2eErVLkzT5pFjw6OiayiJyj9g>
    <xmx:I7lzabbIZrZVdbEpNo3cqCrkGgBgOKl2u3-CWSzuuQE36pYgJQCw2A>
    <xmx:I7lzaYVBGDSAOPfv4yqvBRuNPZLtPCErK8CEk-N_bW45SSI8EuQNJQ>
    <xmx:JLlzaTFWmyHipsVUph5m9w4uAOkqKZ4oMVvG0rQEiVvmu7PboG3m5Xjy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 13:08:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  git@vger.kernel.org,  Derrick Stolee via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] revision: add --maximal-only option
In-Reply-To: <f363c16c-1c36-4485-b1e9-22abe32b3a25@gmail.com> (Derrick
	Stolee's message of "Fri, 23 Jan 2026 11:55:49 -0500")
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
	<pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
	<xmqqikctl3vj.fsf@gitster.g>
	<7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
	<13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org>
	<xmqqecngjp87.fsf@gitster.g>
	<f363c16c-1c36-4485-b1e9-22abe32b3a25@gmail.com>
Date: Fri, 23 Jan 2026 10:08:34 -0800
Message-ID: <xmqqfr7wgq1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> Interesting. Thanks for the correction. So we _do_ have a way to
> get this information for a range that doesn't have negative refs
> or other custom walk modifiers (and this implementation would be
> faster for this case).

Perhaps.  If so, perhaps we can improve --maximal-only (and possibly
rename it to --independent?  I dunno about this part) by special
casing the logic, and then steer people to use the new implementation
that can use negative ends, deprecating "merge-base --independent"
(which was written to be a better "show-branch --independent")?

> My patch includes test cases that are not covered by the
> merge-base command. I don't think it would be valuable to extend
> the merge-base command with even more cases that don't actually
> output merge-bases / intersections.

Yup, I do not think show-branch nor merge-base were good home for
the feature.  We only needed to make reduce_heads_replace()
available somewhere, and "git show --maximal-only A B C" might be a
much better way to express "show only the independent ones", as it
would allow using all kinds of output options the "log" family of
commands support.

