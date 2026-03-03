Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAD3A5E65
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563389; cv=none; b=Z5bi+xAIy+UZPPEAi+EEaQeHe/19iQsN5WOHXnh3MSC1ILZA6FF8HkQD8nmrHekhw7CAEBBtLJVYWovOBlymwmE8VrtofAiOCsWbjD/jXv1Mum3PRMt31Hydarzw9XE5psoq4yOQpjOAtfA3NjEO5nMfqbs5q+lJ/lupKPSqHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563389; c=relaxed/simple;
	bh=E8EMGbk8zik3PfGOe7wJmz6jynEKZRuTojY4bZJ28qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iE6Gqk1GXuGUcvEiqUTBHwziOpJ/poWseYfPU0vOHjslwhmdUcj8aCxQcwzpBCcErhnxwFKQJzOdqKuEwuplH3tD4IHlVnZz9saNG0BJLjHt/DdsDTzZO37kgJ+d1BIOurw7yMsVDPCN045Ym+oOFNT31zWfr9BaFQOcAz6aAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q+iJxaRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgnGNE5+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q+iJxaRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgnGNE5+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AE51DEC05B9;
	Tue,  3 Mar 2026 13:43:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Mar 2026 13:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772563385; x=1772649785; bh=ZUiaFxINbD
	nTk05GY0RQXM6Gyy1HqnldydRMpiZNbvY=; b=Q+iJxaRoe/j2ZEJxi03qNzDl8z
	FO9SME/NR4EA4dx2vT5+RbFLpV3wp+fqd1xWgAE4osCrgXcYDSVHqDvlg//jThxi
	s9rWnywFmHsB2ia/I/nXNeGhrXOmTtwKtyKQLfbhbgHsk/gphZW1XYKX+FF7shy8
	SLfOZKj7ON3QjPBzc3eDrbF81Xhb/bo436GpGDvimtBt9+VVqDvU0Xr3xIruoNFc
	TQS1UqkexzlaNvnTCNZv5Caazslh4TTG9qEPZ3DssyoPplLAy+tbG9izWmyZPvaR
	r7QjUshMRBrczpQokESRv1WXW8AaOC6cBYLKOeAeHx9bmH02cX2gjCaDVefg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772563385; x=1772649785; bh=ZUiaFxINbDnTk05GY0RQXM6Gyy1HqnldydR
	MpiZNbvY=; b=fgnGNE5+imzMsZEwVMhKguzI01u3s6Eenq890zRVi72BwpRB0Pl
	YwV698YeAZn/dpyb9JRUHE/QMvBxoInxyBhpxg27DzP4X+F8VWPDK/QnqK7VUjYp
	VoKXThVfa7kLGqfCgpZQZyQ8KhTM5lp7HeDB4QI4ipFTqPm1LtVuwRbVJLTVakYE
	TeMeuEdgLYhD3tOYD73ySa4JL6CQ9DMEZAJlNssvlrS4iki4xtTb3B/TlofhzZ2v
	gRSmTy/PC7s0e0s0epWK/5J7C3qADxsrLNtCJbtY41gTAcey7znNSevEdchK1V9e
	1+w0IItKA09CgvfI+Uh/IXpOL9VoZqKjZrQ==
X-ME-Sender: <xms:uSunaelpK6lzzFqnhbRv8Zv3Ndl1TmUUKP-sDBU2WL5tdNPAu0Z-zA>
    <xme:uSunadRlQWsKDekYwxixCETiGTr_10kMpj5zKOg1d9IS-qK71rdYCklMZOPIVXsQg
    YBLtx3ZwCh-nN2ESerRsDn-XCi-jXZDqJzrJhnk5ShoSfFtsWVNHQ>
X-ME-Received: <xmr:uSunaaDbQlid3MVhdHErmOfDiZ_d6yl0tTV4nVt6jjEMfWSWwL0-UN9FUsQF0XQStFyxfMLtqtlZqv1AHXqYq4zmZDrpzR1CIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uSunacTGE8ase4DE81HD6aKnqpCWGVetGcObnh0peQVb-hj_FlBUwg>
    <xmx:uSunaQo1Ebq35g9mrFGNEBj4YXF8hQBTv0DWXZyhV4wGI3_Yc5r4_w>
    <xmx:uSunaWwSxErelMyGTeDIjsDpC1r1tFIZxEu4KBF9x8TWJ2wbN1bfAQ>
    <xmx:uSunadLpaw93dl8oyWJJ8-yqeBkPz-ODRYA86Tk-SBmZ7RG5aozeWg>
    <xmx:uSunaRQhpSSxeLPAQAHeq82u7s6k6Pvq1PjMBKBjoypO4wVoVvtj2SC8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 13:43:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #01)
In-Reply-To: <5526480d-ae9e-45e4-b8d2-c853e01af296@gmail.com> (Derrick
	Stolee's message of "Tue, 3 Mar 2026 13:10:54 -0500")
References: <xmqqbjh5fvsn.fsf@gitster.g>
	<5526480d-ae9e-45e4-b8d2-c853e01af296@gmail.com>
Date: Tue, 03 Mar 2026 10:43:03 -0800
Message-ID: <xmqqcy1kdaa0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 3/2/2026 10:15 PM, Junio C Hamano wrote:
>
>> * ds/for-each-repo-w-worktree (2026-03-02) 4 commits
>>  - for-each-repo: simplify passing of parameters
>>  - for-each-repo: work correctly in a worktree
>>  - run-command: extract clear_local_repo_env helper
>>  - for-each-repo: test outside of repo context
>> 
>>  "git for-each-repo" started from a secondary worktree did not work
>>  as expected, which has been corrected.
>> 
>>  Will merge to 'next'?
>>  source: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
>
> I just posted v4 with some final polish [1].

Yup, I saw it and it made sense (including the chocie of where 'int
i' is removed).  Queued.
'
Thanks.
