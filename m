Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5E17580
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623398; cv=none; b=RzUDj4MJXH4h6uOs5TmSar0c1RIGxms8DWyMUyy0i7/nx8x2zjVhz6oMeMLtR0apib/NoQSvWNLNfYzTQAXNDQouNBKIv0T8dTenw1p7lxlBEeIp+AWY70LR4TxXBb8T+QayI3oVYn+UHh4YQyHJuk61YdyEulbdX7BkSQ87sgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623398; c=relaxed/simple;
	bh=boz7XF9JDX7lrM6gyPPXbvv5NBc4HhX1D2I0/npsdIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i1HTbrW6lRdau9FXy4AS4Wm2V3ZByjfZ3XMtL+fbl1mTd8xDwzfnuJg0xsDBz+jfuLXw/cYs1oHe/82GGooPNLKmgAkekBbWf0ApRZZOuB5MU/9eC3oRwC9+MdlASaFS/eRtZZauLdGTn1drmH5L7k3Ef1RpRE3VspZ4SqGCd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=voKFnICo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwRSflIt; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="voKFnICo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwRSflIt"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FF9A2540104;
	Mon, 10 Mar 2025 12:16:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Mar 2025 12:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741623395; x=1741709795; bh=cgSxuZ85WV
	i2YUAABYrxFucCrpERu9UbBbzdXgPP2eI=; b=voKFnICo9eB0iAXlj2YGtzGzbf
	8M7sZG2t/Zw/U9ldMhlHvKWH8Uu5bp4oCSen9EZL8n1IBOj+TZUI7bakjhEABCvJ
	4slQlpe2Ekyh9PMheS3gkp5GzyE9LVzQu1CLRKEmdgBMV0TjHXPdSfNFMI+yBZ2E
	hSSIZ8iktS30FBFnDwE7opADpha5SInbi5HyR651Ox1BiuQa4g5/PvsU8jwLEsWO
	efvp6u8OvOpexV4EEeiyMHycklTWZMgw3GcaliwhiJ2pkOaS4m0pjC7nMDTmQ1MN
	T1QMLrjqjcbnX+YSvWulVpaYe6DE5iwGvXgfvZ1grH32WKQrbYJG0mb52pRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741623395; x=1741709795; bh=cgSxuZ85WVi2YUAABYrxFucCrpERu9UbBbz
	dXgPP2eI=; b=AwRSflItLFBFvLtlYV1mk1U2Ux7qEzpMWbnyC+8yO+LtnPWUU9h
	+AXk5+YoWJnub940uCq5MhtRi1KCgC1Yxe+WSOzqv4/KhYcnBqwsVe9L8IiaxiHA
	MAsa5GUHs7k3pvGtC7T/ZYChDcZNTr7u4VbiEnwqSuwifL75zJkJfZWdTz9qvCEA
	fJEky8XA18W+LBZgwILUS0NvL3ixPzUkA9Bn+DERujCz1IRvY/zkB+/NaURhSBTi
	QpMoHC/J30ex68Ueg/WwYzO7x4HHgjCei1121/zC5510HXF8d0fAnPAgLH2YWoxj
	T2J1xeukvQ4xA3PJQwtZe0IHvorFFRD/kXA==
X-ME-Sender: <xms:YxDPZxl5yYV4bJn1E4MJvy-qEsfrnk6awDW2GM6vb-frNvrKwVqfoA>
    <xme:YxDPZ80hl5ID__ZuwEQleu1PEvKm4_7t1DdFUfHYyML52jCUQV1A3MC8rRDPCaI_0
    CxweoXISeDohsQmBw>
X-ME-Received: <xmr:YxDPZ3rqExlm1MmMFaYuxpqX91rg-mkQ-3fOtUT2sEiBFLsqVaPgqS7ZugCx8jpgVZISJ9MZC7zzmHpByApbQLHr8lfhEygkay5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshh
    gvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:YxDPZxnef8t0gRsVR8jOPu91j8blB1b82SnlEztj42sKk3pMkeKx0A>
    <xmx:YxDPZ_3KSzANlNe6nU-JZaAJHXrIck61icZXJNUJvHPmcZBKOJ0Wjg>
    <xmx:YxDPZwtYx7A0i6Tt0DNObnpu3czOfIvis29JToxo3cqZ14NfHV44mQ>
    <xmx:YxDPZzXwu4S1hem6VNKoa2q_3YU3y0Tz0fBbKT6I1OK48FD6abUWZw>
    <xmx:YxDPZ_9D_d6m6qhYiofrG1PL1CF-fS-dnDAIu0UpqnVTJcjDifvG7UHc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:16:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com
Subject: Re: [PATCH] environment: move access to "core.attributesfile" into
 repo settings
In-Reply-To: <Z86PUkJ1sbSH2VTU@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Mar 2025 08:05:54 +0100")
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
	<Z86PUkJ1sbSH2VTU@pks.im>
Date: Mon, 10 Mar 2025 09:16:33 -0700
Message-ID: <xmqqwmcw97z2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Mar 09, 2025 at 09:03:21PM +0530, Ayush Chandekar wrote:
>> Stop relying on global state to access the "core.attributesfile"
>> configuration. Instead, store the value in `struct repo_settings` and
>> retrieve it via `repo_settings_get_attributes_file_path()`.
>> 
>> This prevents incorrect values from being used when a user or tool is
>> handling multiple repositories in the same process, each with different
>> attribute configurations. It also improves repository isolation and helps
>> progress towards libification by avoiding unnecessary global state.
>
> We typically switch the order around a bit in our commit messages: we
> first explain what the actual problem is, and then we say how we fix it.

A good suggestion.

>>  int git_attr_system_is_enabled(void)
>
> Hm. I wonder what the actual merit of this function is after the
> refactoring. Right now there isn't really any as it is a direct wrapper
> of `repo_settings_get_attributesfile_path()`.

Another thing that felt awkward about this change is actually
larger.  The current attributes globals are built around the notion
that the functions involved work on a single set of attributes at a
time.  Even in a single repository, when you are checking new contents
into the object database and when you are checking objects out of
the object database, you'd need to switch the direction manually,
which means you always have two sets of attributes active that you
can switch between (one is from the working tree and the other one
is from the index, if I am recalling correctly).

But step back and think.  What does it mean to make them belong to a
repository instance?  Whose index and working tree does the attribute
set that belongs to a repository that is not the_repository come from?

So it seems to me that removing the reliance on globals is a good
thing, and introducing some abstraction is a good step forward, but
it is dubious if the abstracted "set of attributes" should be part
of a repository instance.  This is a bit similar to the_index
situation, where we can have more than one in-core index instance
for a given repository we are working with, an index_state knows its
repository, but a repository instance only has a pointer to its
primary index_state instance and does not know other index_state
objects.  The right way to deal with in-core index is to pass
index_state, not repository, through the call chain for this reason,
and I suspect that we are better off to make sure that we do the
same for the attributes, i.e. pass pointer to an attribute set
instance through the callchain, not a repository.



