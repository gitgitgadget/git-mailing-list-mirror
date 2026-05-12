Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228B3C5842
	for <git@vger.kernel.org>; Tue, 12 May 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602188; cv=none; b=jcvh6hd/VJK7rhrd2x0UL1AFH0CCm4oUdyzYkC2P40yOMKAiMEuSh/0cAnCI+YBiNn/qm63jyTd2MVjo+kWB5GLrF3O9EXT2EQQH590DAVXWx+yzqnhwIUH5izWhvoflwFktSETzoCfCbRB4Txvm38CoP6yoNsQBCem8kBqneJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602188; c=relaxed/simple;
	bh=/tZ+UUB4CltN0lln97/+nQrrgUiH+OUUen9EeNu5JGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rMDgnYsdQBrBRtb1u5721GtPVMytdzaP9vBcwmxfkxcBWXFsqyy6Zrzux8ih6Lk73bkOZu1bh5gwu9oQIxQzfpyhgqiKGIvlXQxJ93LVm2cQoNozSJmMXaDPjK2aboTZsKoFsySxIutqSioiVQsPXqXyRk8HtUf+GAUjTHwSA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=doLjUyZq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkfUaofx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="doLjUyZq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkfUaofx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A4A3F1D00065;
	Tue, 12 May 2026 12:09:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 12:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778602184; x=1778688584; bh=BA9iFMdqvC
	l8r3sr9ItnO4qoBaZgl+hrsRJ6ulFo4DM=; b=doLjUyZqYEZAF8Xd11hfPg0RsX
	U36qK0HYv9g/F9QewWJomBpLinRZ3omTX2vK9tBTdvLm5PpqQCMY/72gU4ir7PIA
	ONGxV0E58MilL6VVgg+nJbJrJLdYEs1nbHPLdfrjjClQPMHuOlhL+b89+jDF9XNE
	sur8ogUzbTZd9zyFifomj6frsyICceovjLBHmFCw1cKJRrERRuTYDzpPVAj/VyF0
	r5ffj2kSLS09KR7lXgomij5fKSHLV0tXbwBF/loOOVkpUenjj+e+6rE6P1RdYg8B
	IQMeRg8/trJovIhkk2LSCJz4OSXZUSbHN/51c96BdOLNQ6RgIAB8gvlvXQ5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778602184; x=1778688584; bh=BA9iFMdqvCl8r3sr9ItnO4qoBaZgl+hrsRJ
	6ulFo4DM=; b=OkfUaofxa109Xvs9qmIQNbXpCBSNXTPjc1i6W+4TRLazNHm+vBV
	lUdCwTqxWs2sf13YaYUePFd0caR8AMGSnrpNy4gaAfoZ2tEt650nzfjiGwNkhSIK
	GlAWzlEnPWbeDTateOIzzaFz6HlmxtiX9yyOAuXXYHEaeUKjBx8dRQPecA1/gYEl
	AXH0O6yieUY+w/Pqkksjf/vdAlDxezWp5g91gq/nrzhCtMoKJtZgFkU73+P23MOl
	oK5fNAWxMAxD6W7BvQcaTxCy/YUTCPbKyd0kl944mtWTCuNegRP02XsgReA/xFow
	73lfuHFYBSx5FLLg7IngZL2fntM4IeqIJTw==
X-ME-Sender: <xms:yFADalSIbXK14s_W-8Ns-RO4KyZQpNmbmwgCNTO0mXGyVmU9cnu7Ww>
    <xme:yFADaifF_50DysFmPzSjFUi9jVm4vpodgmYfjNJV4-CvjDIlE_wHVsec0q67Gprcy
    iToi7ERqBJGt66yEJuhgnWKs2XIx1nWq9nMUOmIgJV9khBff1mbbA>
X-ME-Received: <xmr:yFADakpWv-s77BrmwwHLXcSAK24czqRHrLfP5TjOYECmsjQ47p35eg20ZWS578hl5sRNXBxw7t77bNbvBCBDUUAph3N2vHmBCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsegslhgr
    tghkqdguvghskhdrtghnpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yFADaj-pI-Sd94Wew_MpHIy9d4cJCOVXmNVc-XZh9-cNySZCd5yMKg>
    <xmx:yFADagd5xzvOzKWkdZSWnNpBbbTJy-2SjGNdxfvREFIdHbpmQRINDA>
    <xmx:yFADatLwTt4D6EkIp1gfA6CdRnjgLvWoS9pldFQ1zVVOr1MTsumfVg>
    <xmx:yFADagismb8A5v6fQm33Mi3JJ3jZL7XAbHI-mvlylWT6kOioQbtXXQ>
    <xmx:yFADapafVq2wtyomSRWC4wqlxtSI0vqweOg83WOBAKmIO6CSYGJnUZvx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:09:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  me@black-desk.cn,  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 2/2] config: add "worktree" and "worktree/i"
 includeIf conditions
In-Reply-To: <d236de15-f03e-4bac-9eb1-c14e50a271f5@gmail.com> (Phillip Wood's
	message of "Tue, 12 May 2026 16:07:12 +0100")
References: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
	<20260403-includeif-worktree-v3-2-109ce5782b03@black-desk.cn>
	<agLTO0amktCWMsiE@pks.im>
	<d236de15-f03e-4bac-9eb1-c14e50a271f5@gmail.com>
Date: Wed, 13 May 2026 01:09:42 +0900
Message-ID: <xmqqo6iklid5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/05/2026 08:14, Patrick Steinhardt wrote:
> ...
>>> Introduce two new condition keywords:
>>>
>>>    - worktree:<pattern> matches the realpath of the current worktree's
>>>      working directory (i.e. repo_get_work_tree()) against a glob
>>>      pattern.  This is the path returned by git rev-parse
>>>      --show-toplevel.
>>>
>>>    - worktree/i:<pattern> is the case-insensitive variant.
>> 
>> Seems sensible.
>
> We already support per-worktree config settings via 
> extensions.worktreeConfig, so it would be helpful to explain why it is 
> more convenient to set the config based on the worktree's path, rather 
> than just running "git config --worktree" inside the worktree. Do you 
> have multiple repositories with worktrees checked out under a common 
> prefix that you want to share the same config setting?

Excellent point.  The documentation for the new feature may have to
be strengthened to suggest which one of the two approaches is more
appropriate with what use cases.

Thanks.
