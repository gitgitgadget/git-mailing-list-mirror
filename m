Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A371FA254
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410238; cv=none; b=iWUrFZ+vyvOFB8IjWjOWMA+9LLE3ftgaPNZYsGMKjN5NcbnNR656G1GL/L/WmruUL+wzfDGsYbU0kb0vti+cB8rdblGN2b7p2iV2NzrNrAFhYHYPEMfOggZrysaQ+OFnIbYV4dogRdL8AfwCv1b2Vqw/CcgJDjrxv5qZHzDSs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410238; c=relaxed/simple;
	bh=B0OOIs3znPd64x47C7KdqVrXjNMCMD1xnhrJhzKKKic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibondDJY/UsZG7OF4dl+rAi7VWHdtLIRgNVqlLBg2qNzGCvmz7zc0y4v8gQ1+APP9kYFZFdrnVHGszAlxMQy05zr07P03iKJCc1BgpN0uESpoiVB/Dq7j8eFaaidysZdKYQLmKHSidvcpMM4lj/VoZKoi/Dny96CdBQpDpfXymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CaAQYewy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUHRxHYO; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CaAQYewy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUHRxHYO"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB37D1140177;
	Tue,  8 Oct 2024 13:57:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 08 Oct 2024 13:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728410234; x=1728496634; bh=MgEUk65w+s
	sgS3T9AV8Mdak3uLpS9HZxTjyMBpxeD8w=; b=CaAQYewy0AS6En6XfbzB4ITFO7
	ujI4LxKrY2zt2wvM/jbWGoLBeYTaot21jM1gmex6Nr0W7tXUqFLL7HqnZVLTms55
	ROSLJqo0+t239OYM0RmkdBO3umbam0192MKRXXD5Ew//n0yUP0Nkm321JUU3TB5s
	H5ydUPmhGWi3HG/r+gp/JJ1bY4Pk1SeS1IhCcfjH4VR4Fhen8oc98Usvr6QkfG3a
	+o5Xq14d+5/ZvSdSEytemc4VbHCKIu2hFO++iindtQISyagAsfC9J4RtogtzuxZ8
	NuhkB6hUfzABrZm7ItdgMA8LYRoWMtQXjrBIEmQm3EeN4shx5r5oPecLp0zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728410234; x=1728496634; bh=MgEUk65w+ssgS3T9AV8Mdak3uLpS
	9HZxTjyMBpxeD8w=; b=DUHRxHYOfQ7ugokJY1cRRq4gFF0/qm6892ymg9zNltLT
	Y6PoYDWucP+AML5S19hZV8S/iQHJiyhIaXInR5WkRrilZTO6n+HsiBXdJIvyoppO
	Ch35r4InS3suTodtFV8VL3eglEo3M4Ug0Xwv4iWYcGwXB76av2DVYaXp9BqZwHd6
	mWJf4ixdCA7T+oMfh4eNw0LC7ANv4rNlmTNp46hQCqqB5qphwcB5aZJjXpfKbnIG
	aH8bTQeCC41CRUMcjVLvctHN0ZPTkqywJmDhhlgl+04f0z+hyMcfzrpUmA02jlJO
	Jr9EAY/CGjm7QtIlo66QAKoHyIvha1kGN3IyJ1wAyw==
X-ME-Sender: <xms:enIFZ73osxrzIq7UNhLHi7MYbdL6GgqDF5QEplrLw5xFScTrKYAfqg>
    <xme:enIFZ6EC5r3S9xhFG60QKv17yVUQ7qSowszc2GhmXvTlY-Ctl5jYSVm0vT4TDSoIw
    GvNnGH9h4Z7IFcIHg>
X-ME-Received: <xmr:enIFZ74cGIOQzI0yO2Raq608hwr5d6oPKs9ltAGB9zfI22fGvLJPkRld6f9LT1-7gnf1CdCXp2L6lK9v02n3NroXYfSE216pMnSpRnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsghmfihilhhlsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtoheplhhiuhiihhhonhhgsghordeiieeiieessg
    ihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopegsuhhpthgpgihinhhggihinhesudei
    fedrtghomhdprhgtphhtthhopeigihhnghigihhnrdiggiessgihthgvuggrnhgtvgdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:enIFZw1dIgNhEQ3rqWE6E_i4ruORMJhPeH4xe_h04mRGdDVNfytc_Q>
    <xmx:enIFZ-EQe38Cxuui43imyw9YEN6o7QlvrQ33CE6Oh9uPVprWxrm07A>
    <xmx:enIFZx_y4gZR1Ad4Zvk9hpPTyKvxo41vkR4p0uCs4vVU2tPysSEvqQ>
    <xmx:enIFZ7mCWl0zsR8MFgEtwlA2mHqxBAmi0ybhi5on2QoWyFboaMHV4w>
    <xmx:enIFZxDbbDcx193xvVEzP97gOEn0zWV-m3szjftQI1ee_MkuDldpYcrT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 13:57:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Brandon Williams <bmwill@google.com>,  Jonathan
 Tan <jonathantanmy@google.com>,  Patrick Steinhardt <ps@pks.im>,  Liu
 Zhongbo <liuzhongbo.6666@bytedance.com>,  blanet <bupt_xingxin@163.com>,
  Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 4/5] fetch: respect --server-option when fetching
 multiple remotes
In-Reply-To: <420b15d9f37d2510d0e4f5390a4b93a5ead7c966.1728358699.git.gitgitgadget@gmail.com>
	(Xing Xin via GitGitGadget's message of "Tue, 08 Oct 2024 03:38:18
	+0000")
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
	<pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
	<420b15d9f37d2510d0e4f5390a4b93a5ead7c966.1728358699.git.gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 10:57:13 -0700
Message-ID: <xmqqv7y21nra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Xing Xin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Xing Xin <xingxin.xx@bytedance.com>
>
> Fix an issue where server options specified via the command line
> (`--server-option` or `-o`) were not sent when fetching from multiple
> remotes using Git protocol v2.
>
> To reproduce the issue with a repository containing multiple remotes:
>
>   GIT_TRACE_PACKET=1 git -c protocol.version=2 fetch --server-option=demo --all
>
> Observe that no server options are sent to any remote.
>
> The root cause was identified in `builtin/fetch.c:fetch_multiple`, which
> is invoked when fetching from more than one remote. This function forks
> a `git-fetch` subprocess for each remote but did not include the
> specified server options in the subprocess arguments.
>
> This commit ensures that command-line specified server options are
> properly passed to each subprocess. Relevant tests have been added.

A more interesting use case, as there is no reason to expect that a
single server-option command line option may apply to all remotes,
would be to configure different server options for different remotes
via the new serverOption configuration, so that different server
options are used for different remotes.

If it happens that the same server option is applicable for all
remotes, it is reasonable to give --server-option from the command
line and expect it to be propagated down to subfetches, so
regardless of the "what happens when different remotes have
different options configured?" above, the change in this step looks
reasonable to me.
