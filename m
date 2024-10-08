Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750E1F9AB7
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408211; cv=none; b=fF8ipDJf3R8SiHGgzzTbTpTTmOYrj4Kt8wKevTDVtSs2E4w7vrpOX8HtXgIQKVG95rezL6wnwAfpdTR/kFIciL8mKCQ4U+KzIzH569SOKwgcFoV5s5NEPlNVjq1N+d7zuxh0awf5bZeNocfL2E6LHsqSAyGNOEwH25pLZ0yrHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408211; c=relaxed/simple;
	bh=AxGh5BVJl+MmjjLKHq5EUJkie9/ZOPUjo7ETbQPAP0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pOLPcLqhLvWzMDOIzF9UdAIEk0eAHhjlWTLIhzVKTAud0cGg2TGkX1Le77Tgpm0jDd95/APTMmGGDi5Xi5N41cwow+vilaYFBSY5e/SCahPlX6GIg9MCem9Ke5SnPpOStfo03SmlOEdFlOVHH0Bd7R4rPxAFGdGA3ErbSYYbtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dzsvqhOS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhmVupis; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dzsvqhOS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhmVupis"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F812138029F;
	Tue,  8 Oct 2024 13:23:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 08 Oct 2024 13:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728408208; x=1728494608; bh=FWPVAFHNvo
	+OeQb3KSLYIGIH5eQR5dd2DO1JCZijM8k=; b=dzsvqhOSHZFBQeZ772i3cFpeEf
	TXq/0ZvlyOeZtmFGzs8Fo7quOxLWTiwTALCBZJpVz1vIfUvnxT8U7biVUGOSWxAA
	cFQNOLZIKz8m7AXwkodK4VuRShYibdh6cSdsOSI7q9StuM7MWzfKEblGLXZWLkUV
	biAbQdcfyHeFIkBGeYA1j/AVmr6ZjZOVyolHxPNYv2+UYvGHpWep9zSg77fo1bH4
	5WTAUoph79SJy90UwJFbM1nD/o6GMWE5bPJP/k0mjIviPxu9YFBmreMK2835qvuM
	ChFsUsx7SIFtzRSlm/GJ8CsWb8pABIUA3g7MKo+xicgpqcG3UKTDwB3ZyyOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728408208; x=1728494608; bh=FWPVAFHNvo+OeQb3KSLYIGIH5eQR
	5dd2DO1JCZijM8k=; b=IhmVupistJYHHFKlL56EnM43px8RybXPrCbAz/yK00Kj
	gHZ4apaKUUcRuxj7CN9R1Yaouzl4ilq5hi+XLpzI2fnojIDs0wLXDbpQyjnUu6zC
	2EXXkMgfQK4HBwKB6oMW4d8ZJk1LM3I59tiuyVmvikurM7mSgozXuJRzfWTlg7hJ
	cRRnAlvrqImICUHI3fA4Gf2tpgO8UlypH+kvgqB/t5b6zGYlIdV9XxpphDfF2Lj4
	UjuUBPvln51RUOK/sI3JcMqivOvjQQeCTJomSPNf+TwwGKK7cYeEeYFk2YJJftfU
	B31vTAUfWxVBlgPYXuGCYpidaPwjxtNN4Rwub0H/YA==
X-ME-Sender: <xms:j2oFZ_xyS0CQ4__c2y8PENAM5phrQvbZyyzIhErFtcYa8x0Yg1AP9w>
    <xme:j2oFZ3R5tPknOtZua4ZUYy6I-gEhipY63zRYQNxa4wqZWEjwO9kQ8whD3kVdpPC7I
    heoI5YtcrxB3Cucbw>
X-ME-Received: <xmr:j2oFZ5VGRv3C5zwzylTbfWDpNu3I6NyfeozcGAt-8zPrdG8CBwVsaJBmVjF6sxRAoBsZraKByqw9tk1muhBjrlj40dx6fBAKJFlmW9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeekffeiudegtedvheffveffueetleehhfei
    veffueeivddvkeekffffvdeiheffudenucffohhmrghinhepghhithdqshgtmhdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsmhifihhllhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheplhhiuhiihhhonhhgsghordeiieeiieessgihthgvuggrnhgtvgdrtghomhdprhgt
    phhtthhopegsuhhpthgpgihinhhggihinhesudeifedrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:j2oFZ5hXlYZ5h9FeLjja_6cwG1Rdvm6Ww4JyBYsf_vaXyaXUTtWqjQ>
    <xmx:kGoFZxCgrEbBhyslVDUOAnIPmnV33kC1OKfncqx_yYaVAvuGB15f4A>
    <xmx:kGoFZyIj9R47-W6k0_ndWqQpcpLHjWF-yZJTYZ8qmD94SoafjVrwIQ>
    <xmx:kGoFZwAT5r0SmyohKtMz-jU3UMa2o5TdxuRZiqNZXX8YMpTDMRfoJA>
    <xmx:kGoFZ13-l-4hHnhnxxvQrbnZB1Qc0EJ4n5NYDWdLqT5sESmF5oHpIj0R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 13:23:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: blanet via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Brandon Williams <bmwill@google.com>,  Jonathan Tan
 <jonathantanmy@google.com>,  Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
  blanet <bupt_xingxin@163.com>
Subject: Re: [PATCH v3 0/5] Support server option from configuration
In-Reply-To: <ZwSuRa_2OeAAv3pQ@pks.im> (Patrick Steinhardt's message of "Tue,
	8 Oct 2024 06:00:05 +0200")
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
	<pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
	<ZwSuRa_2OeAAv3pQ@pks.im>
Date: Tue, 08 Oct 2024 10:23:26 -0700
Message-ID: <xmqqiku233w1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 08, 2024 at 03:38:14AM +0000, blanet via GitGitGadget wrote:
>> We manage some internal repositories with numerous CI tasks, each requiring
>> code preparation through git-clone or git-fetch. These tasks, triggered by
>> post-receive hooks, often fetch the same copy of code concurrently using
>> --depth=1, causing extremely high load spikes on our Git servers.
>> ...
>> This patch series introduces a new multi-valued configuration,
>> remote.<name>.serverOption, similar to push.pushOption, to specify default
>> server options for the corresponding remote.
>> 
>>  * Patches 1~3 contain the main changes for introducing the new
>>    configuration.
>>  * Patch 4 fixes a issue for git-fetch not sending server-options when
>>    fetching from multiple remotes.
>>  * Patch 5 is a minor fix for a server options-related memory leak.
>> 
>>  1. https://git-scm.com/docs/git-config#Documentation/git-config.txt-uploadpackpackObjectsHook
>>  2. https://git-scm.com/docs/gitprotocol-v2#_server_option
>
> The range-diff looks as expected to me, so this should be ready
> to go from my point of view. Thanks!

Thanks, both of you.  Queued.
