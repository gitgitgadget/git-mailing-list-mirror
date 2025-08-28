Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5123E356
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393331; cv=none; b=Tn3yHvN3xnOO30r2Xx22gTj8tSTGnecjvMRQ4ys2+bVmn3T6H4GEb79qD4SlRZUSa7DFNbS7JP7q3SiewPsI8AbM+RCpOZPXIxYCgBCXAeSrBypx26EZ6l+Tn9IlvxzXdA8OMLtshbktbbHz+3th+ZJMJAZ+2Ivbl7+gOxzSyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393331; c=relaxed/simple;
	bh=JPbU8OG3HQoxYepHIiuKeoOt3wFo3GPxsMAZhZf3aGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YDN7RbDZsuI2n/z7A04o7wkyyx8QnUD0NbLb01pc8NvZPBkK43z6rGCU36vnHuYePpYfaj5cQTBmtldD+is6HBZodamuSHSGMZLI2J7r8hM6NIbLPtGbRZzffJoLr/MRauN5r48EM0+B7p/5/dQbkSMGtXGVd/sc4UP7WRxZDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ztoKgPNX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmDVq+IM; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ztoKgPNX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmDVq+IM"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DD701D000FD;
	Thu, 28 Aug 2025 11:02:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 28 Aug 2025 11:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756393327; x=1756479727; bh=K1zq9gwm7i
	cDpybOz67GDAOawu247aRFBNthkT+BBgQ=; b=ztoKgPNX3v1/efZTP/Oakm4Xlq
	An9M6WEeMkbtC/JnR2YqpaEKTXL5LFj2f4FhJEP3ljG3Mnp6hL/K5VNCSJ25jp2O
	HXrkzr1dhgEwa0buHLlbGwDnkV5kryLvouVWmG3R0S07/oOE6oSpmi2SaoGXLyJM
	QTcf0mseV/OPCG1lK3gmjLcWIfHlh7v0IZqI2xPBwrBoGp8xmhkNqpsxgKmEXb0Y
	RmKiinkwRmPSPXknpEqebP1C84SnH+aW359AJBaBcKcl4wP5LoaaY3hWsQrUK2QE
	We6X6sIO4eyzU58xauLPheG46Qa6ptPycQUqwLyP7yeZthBa4Ajoen5rj+Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756393327; x=1756479727; bh=K1zq9gwm7icDpybOz67GDAOawu247aRFBNt
	hkT+BBgQ=; b=FmDVq+IMJhG7wfshoJEVg31bqZLBwDmGL6x5JpxP/TxhjuLCfMC
	WDatuAcfIr6csfsAF0c6+6/Hwqoz2PodO/dW1y89OkN4tGnbVdpDRKWGjGYYCzos
	fZueWHMkmuurqN1tuhm+0je2TweKqtfLjCklvb2x3YfbI4nserfnbP7mWIiA5ejv
	Kf768xnZs9z4ePSFiL4rSBpKr/+XGG0WoTHba3c9lJBEcfM2qyVPCAlatIBYwzCM
	jOZ3Ml0r5nqT3rYoY17zIwZ7PdytbOlgPSfnaSIOmTponP81tNMOJYe6O2Ie5NAZ
	hCQs3qoTHAYV2nFAZBLSXxprxDJkt6OB8UA==
X-ME-Sender: <xms:b2-waFPGRhT57tc53B5LM1gheTypAayq-UF87Wj57_qPbHNZghG9Yg>
    <xme:b2-waDeW56nr1wRwkFuST-YDk4szYxu3eH0J92xOdab_bB_zVpmhJpMnBU8e_KwI6
    185-s4mYR_pVuQvgg>
X-ME-Received: <xmr:b2-waKuJ5Rpr3_VqO4KNt1wTIb0ravdzsUf4vemMTtCIwLoYizxNNL_knM1IDxM3J0MIi-Yys4i2mFXbf0O8nbH6UJDOVvhTtSqdCLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b2-waMn8JBYbu2Rx8k44JezsXPrUsFWNR-B2Do-LLPRIvmUa5RK1Fg>
    <xmx:b2-waEyRJAQJ-nmuqPGJHRmLv5b9alKVHpPZ_Vd5V1Skf1STqvVlsg>
    <xmx:b2-waGNtZc40-YCSb4eF5gerijybwrJQnTOnghSEd_MCYI_dhXpRpQ>
    <xmx:b2-waIrGK6pufLkPAgJ-36kELwCadf2fS4vXJHpOYDUIlNkUsZ0JIQ>
    <xmx:b2-waH-zWlrOK-N_RiPp7nljoUx7MrAq5MDu9vaByTb0X1AIA0u6_dc6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 11:02:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] ls-files: conditionally leave index sparse
In-Reply-To: <5c19f2f4-1d04-424d-9720-6db4342aebdd@gmail.com> (Derrick
	Stolee's message of "Wed, 27 Aug 2025 15:36:18 -0400")
References: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
	<c1f2e7b1-7583-4e1e-8f20-584a7a768286@gmail.com>
	<5c19f2f4-1d04-424d-9720-6db4342aebdd@gmail.com>
Date: Thu, 28 Aug 2025 08:02:06 -0700
Message-ID: <xmqqplcfxzf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 8/26/2025 12:40 PM, Derrick Stolee wrote:
>> On 8/15/2025 12:12 PM, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <stolee@gmail.com>
>> ...
>>> Replace this global check to expand the index with a check inside the
>>> loop for a matched sparse directory. If we see one, then expand the
>>> index and continue from the current location. This is safe since the
>>> previous entries in the index did not have any sparse directories and
>>> thus would remain stable in this expansion.
>> ...>     Here's a small sparse index performance update based on a user report.
>> 
>> I know this is small and somewhat niche, but it hasn't had any review
>> or been picked up in What's Cooking. Could someone please take a look?
>
> Thanks, Elijah and Junio for reviewing.
>
> By coincidence, a user reported an issue where the sparse index was
> expanded during "git mergetool" and it was due to a pathspec-focused
> ls-files subcommand. So maybe it's less niche than I had thought.

I do not speak for others who did not comment on the thread, but the
reason I did not act on the message was not because I found it niche
or insignificant.  I simply missed the single message in the sea of
other threads.

Queued.  Thanks for pinging.
