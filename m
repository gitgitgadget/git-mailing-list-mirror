Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A93FFAB8
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341801; cv=none; b=B6w6s4MVVM1gasAtBFk95h7/4DhSKEEmwqgJnWkxRQ5+8ncge2Fo+mgE/mNgyOcQfXrR4cqjuppj3WU356jvhamKH5prChTnw1g6dZvOgtgphoCkUZXWFZ7IJe++jc2RMwPbRnIwR36I2hEijJQjkV+funlt6ClMpSeliKsJe3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341801; c=relaxed/simple;
	bh=pR9eKrZUAaYc0BEKCn2v5sQ6KADuptVyKS24M2iep0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5fn0UhfyI+35MZ+vWXMHqPcTmnK8mgyfkA4engFaROO7VnhDZKUhGpktD13w2WJ2fSlcLQxcqdQrerrdUsiE2oR+rhe192gqsO/u165gTVK5Gj+q7xJrllKbpswgVmGK1udc6xTHLs8G1XH1XOVh7zGz0LNgq11+hozjhsnTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mdz4w20z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oEYhqCIr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mdz4w20z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEYhqCIr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A9BAEC0080;
	Thu, 12 Mar 2026 14:56:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 14:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773341799; x=1773428199; bh=nFClG17EDH
	U5Ux4EZ/YDDdZes+42FMs1yFOI7qLXsvc=; b=Mdz4w20z+Wp5RwdpjWzhr+FLEV
	P5poB+bnJZySKkQ/zsFR88Wtd39Id9U8658dcCc+PiwX8ByowTLbRVMvmVx9cUHf
	7Ufg7rl4lzVFg4AD9j3xdhLwSYcmhHUyBYrEpVL3bAPq/yqvc4RNbU4q0qN82neQ
	VECV6ieqm0huGk/dZSua85iLVAjpk/WBB4U2Lcmah+fyMIBxEtU/8YvU/1/50NT/
	XiE3IQL0Pa/zYGDdfv8oKFNMAuvZa/XxlR0Z/9p9JAtFeRQcr3dTSLehIHLB3Kfl
	mxWAWYt4EOqFm98gI05Pxy1sS7k0x1n9GxqBtpAqsKIAEU7Ku4QxOdrLZclg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773341799; x=1773428199; bh=nFClG17EDHU5Ux4EZ/YDDdZes+42FMs1yFO
	I7qLXsvc=; b=oEYhqCIrAxSz9uq9c/pP+FiB8ryXY4ADOQlsuzOdEqfmNx5eqWk
	spWYTyd22xnFQ2b3faPUngB9+VLmmcHBoLdpAuM6fyeeSzn8j6DCwaGrBGuYdoBn
	PEaAdSh7ghDJzouYBSlN7IsLSbgBiZUDh3g9BweCmjPY3rWdYNFSHqa8pwQhluBb
	dPiz9yucNOJ8DjOiu2/GAircpqCBIA3waUS2geFytVYD9DFvCFj8JmXmz2ojnlik
	U1EZ2QsQVrvgNmBSoZph0lLsmnanV99M/V0xbshvmtqf8TTytH5/DadiqyWob4eS
	M8a+krre4HxZEeEZx/alcC8NoSrxhDsm3xw==
X-ME-Sender: <xms:Zgyzadxg6z0EyJi7-bOXcoI0KtsiYK0hYWuH0oSwb6sXeIgEW88hiQ>
    <xme:Zgyzafjp2-ckdBrVhN4xCN_AhryOS5XAg9SHm6LfHikajFlKF4FPs_IFCj6ed-kEw
    YcvW9B5dwVOKr0ul_q48vZTx_bZSZqg1dwvc2MKFvWuHTWpUuiX>
X-ME-Received: <xmr:ZgyzaZlKu_jzHrSwnX1eN3j15CdtiI0htoXkqLgguYpRAD49-ormf56yJJUjUEi3Bc0M0lORPFQUHjfIe10h91NfFBQ3idXYQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZgyzaVinfy5A8jvIbHVWJMBxYTUFcyQp59egF9-9T34eMZ-RvkCQ-Q>
    <xmx:Zgyzad0kiFkK7SqOJkXEn8HEKenAzGPIAfITHBUIRKPwO8gLhjC2xQ>
    <xmx:ZgyzaeKfH2QvWHCif07I8fY5WWMS6vBhKvdXD-9LUuokjcDCp7pJQw>
    <xmx:Zgyzadx6Tt-cHQ9x4UWx_OYqgKqUIwC4Mi9_ZPye8vjn_K1qSVxb3Q>
    <xmx:ZwyzaaVCGvehDcXGMUEkNSVCAMiiKl_u02XbMFeMFctSBr-UAuMErD3h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 14:56:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6] unpack-trees: suggesting 'git checkout -m' with its
 repercussions
In-Reply-To: <CAOAgETN-UVtee5OjjcLE45sRxajCkgF3nipBqXpec4JjN8+vfw@mail.gmail.com>
	(Arsh Srivastava's message of "Thu, 12 Mar 2026 23:43:15 +0530")
References: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
	<pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
	<xmqqms0dghgk.fsf@gitster.g>
	<CAOAgETN-UVtee5OjjcLE45sRxajCkgF3nipBqXpec4JjN8+vfw@mail.gmail.com>
Date: Thu, 12 Mar 2026 11:56:37 -0700
Message-ID: <xmqqwlzgev16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes :
>> The commit message should focus on the "why" and "what" from a user perspective, following the project's standard format (problem description, then solution).
>> Also showed an example for the same.
>> Also, note that "extention" is a typo; it should be "extension".
>> Having said that, I am not sure if we want to suggest "checkout -m" in this situation after all.
>> Pointed out the difference between "stash" and "checkout -m".
>> When advice requires a multi-line warning about potential data loss.
>> The goal of these messages should be to provide a clear, safe next step, not a list of advanced alternatives with caveats.
>>  After all, the users who need such an "it failed, now what should I do to recover?" message the most are relatively inexperienced users and we do not want the advice to be overwhelming.
>> Suggesting this "one-shot" approach to a user who is already in a state of friction (and likely less experienced) might be providing them with a "foot-gun" rather than a helpful tip. Generally, advice that nudges users toward the safest "golden paths" like stashing or committing is preferred.
>> For a microproject, you've successfully demonstrated that you can modify the advice system and update the test suite.
>> it might be better to drop the 'checkout -m' suggestion and instead focus on making the existing 'stash' and 'commit' advice as clear and helpful as possible.

I wonder where this came from, as it is quite unusual to have a
rephrased summary of what you respond to.  Is this LLM-generated
summary that was copied-and-pasted without much human brain effort?

What is more usual is to quote the message you are responding to,
trim the parts you are not going to comment on and not necessary for
bystanders to read in order to understand your response, and then
sprinkle your comments in between the parts of the quoted message,
instead of saying only your thing before the message you are
responding to without trimming (which is highly frowned upon, and
people often tell you not to "top-post").

