Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C7293C42
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763614; cv=none; b=GvGXXiydfBvNPziNBlhDtZsawvgc/3T5L5wbfTeh2zQR477UgTF+HZk4EMWLnwO5dPjlGyg5C7mlLereHLF26qIwXDtIUCAMc3Pl1r8NxHxbdosPbQPh4o3R7KZgMlpN1yPO4KtOc2YSu0Z1ektJwS/O34IbBu3L4gksw9nhywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763614; c=relaxed/simple;
	bh=dthdX1CFZV4j2D/8ZFyNDLOysi1p22DvJvmiTULLPH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VXxozi98iHj8SnS4S6uTQAoyhs7ic1SLzqmdS+TbzzNK0gqnwDBFb/jQ5cdxlPHpWuadnXJ/yifRI0RpV9sxQe9ck0/lC/6bRYBMfGrK0Ma9UOzOYfmhPqTjBoA1XMP9jBa4tUNGdivHxtV+0AfgBIZtKJxLXbzFXYeV/5a8dAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TrjuIjgp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jk9gdMhq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TrjuIjgp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jk9gdMhq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 863E37A0033;
	Wed, 29 Oct 2025 14:46:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 29 Oct 2025 14:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761763611; x=1761850011; bh=AQ5MLj4YW0
	bq65S43CJDGTCA78eQIw2zkvXip2Wqe9E=; b=TrjuIjgpRZlRVfjk4F0746Um6X
	nEulFDuxmziHLOLdRj+WD0KVg7mYdZcIbLCrxHaKSL6cW4n9gyXBSjfOIz9+ALsw
	m8t0vWId+BTGZvalCbqV2WGnNUy6RsZfkR75N19/Jj6fWA3ruOzJAvGpNOS7PrVv
	U+zO9rGosQ6duRao6zYKjc/PfRL9MdC17yBLIezhSmhFHPFPrfQnQORxeEuJTQ4N
	7ThFRZkwjCidB0w3cYvaBXJqpT735+5YMKqSfILjjge3Ke+jthVmP2G4K/zLU01K
	fVh7efTWVqITZsdpg3wDs1/eXsVrWXoYRBzjk0pl6OgtH8+oxrNS6NSo+wQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761763611; x=1761850011; bh=AQ5MLj4YW0bq65S43CJDGTCA78eQIw2zkvX
	ip2Wqe9E=; b=jk9gdMhqCqX5/b/UdrKSncu+qNUby98yasOPqF9bt2P3ngDG+8+
	EidGAcceUijdx/C1SFMgMSxiy7bUBQGE1wbSAwFvfd4K/ZBEio8tDTv87vH020y6
	RciYKJrBJvus/i1xuDmW5pBL2UnctzZLd1KLDrdTT/LnW3l32kNVTck+o9QXnwfN
	bC6ffl1bBc1ZzrpCtTVUXE+w5m4uLSTBp/1dz9cne3QKW00rVugC2lFJJZM1bzIP
	mzA7REy0+K9cxrVU2Ya4KxrcYR4bNyKtTohe48qZHRikN8uWUD0i6p89vXQmOWIr
	wt7dL7PcR8nfg0wHez4qCd8O2TIKenIGnKQ==
X-ME-Sender: <xms:G2ECaUF1BPZQEc8DcnBzsKZ4E6UMp2YMV5GSI6Y6Vhlml0FBoUPU9Q>
    <xme:G2ECaRCUmy6gOiKOGOwdA-ZYyuA5AffyMyqhEWi5o93Yc-XKUMdH840qjpxXbT9a7
    uq3AIrg1up7o1cmZo2TBL7N2fv_W_rY4FrUc5EBmzH2uzC3kjQd8Q>
X-ME-Received: <xmr:G2ECaX_Fx0afW26z5lMvif2rn_4ZWTSVLMgJvhx_vYG5WKCN2EC7_gfekwkpGIb5vRjm9NvJvALiGgtwJ1vHcErKaWBHF8GfUM21>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeggeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhonhhinhesuggvlhhp
    vghutghhrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:G2ECadCggLWjUDNnGMo7GQndOvSt4SJRUGKhdAAhcULswR9HS9Fkgg>
    <xmx:G2ECacQndd7BzUCZ8WXmUvG9SNQ4RqrCo3Cvyll_hk7li5AJvmZaQw>
    <xmx:G2ECaUslfClNu1_YRnORRl8ZtuyQvNIotbBPclXp38MExvmLhGisMA>
    <xmx:G2ECaY25iaxcDRFd8XTRyPCxhmEksvVCF6IOVGxv62PIXhFA00GI1Q>
    <xmx:G2ECaVJmeOPQ5m3fV89OBmA61zdqF56F9wMGV6hFeSqlWt1GIcqfVGeN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 14:46:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Antonin Delpeuch
 <antonin@delpeuch.eu>
Subject: Re: [PATCH v3] blame: make diff algorithm configurable
In-Reply-To: <fde3dae1-bb11-45e8-9211-50ae003ca497@gmail.com> (Phillip Wood's
	message of "Wed, 29 Oct 2025 10:16:27 +0000")
References: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
	<pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
	<fde3dae1-bb11-45e8-9211-50ae003ca497@gmail.com>
Date: Wed, 29 Oct 2025 11:46:49 -0700
Message-ID: <xmqqms598s12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +static int blame_diff_algorithm_minimal(const struct option *option,
>> +					const char *arg, int unset)
>> +{
>> +	int *opt = option->value;
>> +
>> +	BUG_ON_OPT_NEG(unset);
>
> This is a change in behavior as we currently accept "--no-minimal" which 
> clears XDF_NEED_MINIMAL

Ah, I missed this; thanks for a careful reading.

> As I said above using PARSE_OPT_NONEG here is a regression
>
>> +			       blame_diff_algorithm_minimal),
>> diff --git a/t/t8015-blame-diff-algorithm.sh b/t/t8015-blame-diff-algorithm.sh
>> new file mode 100755
>> index 0000000000..efc4b47ce1
>> --- /dev/null
>> +++ b/t/t8015-blame-diff-algorithm.sh
>> [...]
>> +test_expect_success 'blame uses Myers diff algorithm by default for now' '
>
> I'm not sure we need to say "for now" here.

We shouldn't.
