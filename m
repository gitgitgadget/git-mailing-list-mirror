Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5214F9FB
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469766; cv=none; b=RvFtYSDPPA+DlHf5l1jBT5dy7IpitMwywdoBltLALEtD5eq+1Ri6xLyaG0IaLzwTa/FzihvnHhL9S/ybsSMQcDqgh/GQMOhMW0OzenjSZq6tR3FCVBrKlziLtq7gVHmDUjdIINjmc2YetTvSrZ7ZEKm6kfLS2t0Ullh2g5T/pic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469766; c=relaxed/simple;
	bh=y2rMXy52341jlr9iev8CmyELrFjyoCN6lugJagUJ7QQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZGYSO0s4hUCLa88krX1mVgsGcsZ9HGteebcNiQMUcFXqUauParWfl49ApMEeErNEkhuymfeNOyWvbgaNg4Qv3r/7KVgp7Sxwd8fuII4vczCJza/lijiMrcCat2LD+0+sJG1I6P/J0WU/nI4OPo7ecPuLqdwI/r7NyzwUxHrpQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kj8BQDSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2WlYHbw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kj8BQDSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2WlYHbw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B9DC31D0018C;
	Tue,  9 Sep 2025 22:02:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 22:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757469763;
	 x=1757556163; bh=9Q0+LTetGsIh+fxEjZMIRjIzaeeSKVKSAGik1KyORQI=; b=
	kj8BQDSXNvqamuPzes2CFnM0SKM6k+UF5LmWpHJScxKlY6uLthfmPUOsbAu5D//t
	Rj7kTrQfnVOAFQ5SQJKqjgwJei+caBB1NyPejNveKGYQw0qtOfp1tc5MQYdCKHtc
	5BcEtDBaxyRv2JI8FKP1hDgTPA77WWVOUGvm6oRCwgFVNNG+NewP6miQMKb0mvjQ
	eig0oh5uM3pRYscOxAkTxYojKiy35oM2kZb0SMY3CbaeMxCB4GPdVuNluLxtYaGS
	ujavh44qA7YOVuJAMqZXKXdZJW5nBz2wIpAr5wQ6YSxS0riKDrrQq0WtRxIeqMtV
	aS5S9JwWQC85UZJsOcLLig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757469763; x=
	1757556163; bh=9Q0+LTetGsIh+fxEjZMIRjIzaeeSKVKSAGik1KyORQI=; b=Q
	2WlYHbwKgmfxYBA4Q1RKIFHQNCxwz8HKbs/hX2zQFjZcgcXEk3rx+NRFxk2S6N+G
	dwJcC2KXjXVQiqXQXNrAdpsrZmLM6sXtGQWyVrIIAKCBu1IvjPa9LTK0l0qHmoVl
	tVHR5zHQLnVgDkdc3c2plupvQ5esanbqJnIcJGzLcpmA8pbdvONah823Ygw0x0AM
	jMuxoswfwxBdKAIRah2OzSqr2ByRyW3KMu7QTwDqe0WXF2+d0XNEeviCQ2okUzH+
	oa8ETqkrRDPRnR/yKhNvsuDeWiCFgXBqGUNUUlzq2IemxdV83FFjxT5UmEZwmF1A
	7/NY8w/X/GSWKIFB5s/vA==
X-ME-Sender: <xms:QtzAaOjYjBYTATFK8PXRboNX521azgjHWE7k0D9qdABOsYLBFNdWKg>
    <xme:QtzAaC2fbZIY5CmeWkCnX9X68yxrTGEayUnIpMLig0ulDecRXc9uzm5FzrE8JAbmQ
    iI90FtHhyppAah7LA>
X-ME-Received: <xmr:QtzAaPKTeOsFwS-PtSerqrp-BuBQ47IIZQm_2XfNVftsfXff7Hi_SpfgFod9QC8bDcRZuaYbhgOfWuz1IUPf9cScvUfI9Mpg7vmG6MY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiigrtg
    hhrdhfvghtthgvrhhssegrphholhhlohhgrhgrphhhqhhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehprghtrh
    hikhesphhsphgufhhkihhtrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:QtzAaKzFNEokRZP9OacUqOQOPR7ic3LT-OBlDOVVghMQfU67MsS9Ow>
    <xmx:QtzAaFWtCfNuGxi9saZ8foOve8mUU5pSM15b34g4qID8Wrhy0C6PrQ>
    <xmx:QtzAaCjpwUB1if6s0JfPZlZyZ5Wj8OOviGEb--TcJ9CmkgfWDDtZxA>
    <xmx:QtzAaNBT09_HwsIvT3wDcKi-DNHuyCeovva_YqDMGYKKcP2sJ0fIRA>
    <xmx:Q9zAaEeqxbWQEyZuZXElLPP3sq4pz4a_jnUPRRNREFMwxicpoVmelADW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 22:02:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Zach FettersMoore
 <zach.fetters@apollographql.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  Patrik Weiskircher <patrik@pspdfkit.com>
Subject: Re: [PATCH v2] contrib/subtree: fix split with squashed subtrees
In-Reply-To: <8d341a51-2135-4c62-9df1-5be351e73275@howdoi.land> (Colin
	Stagner's message of "Tue, 9 Sep 2025 20:56:07 -0500")
References: <20250824191048.1938340-1-ask+git@howdoi.land>
	<20250905022728.940664-1-ask+git@howdoi.land>
	<b78639ee-021d-49fc-8b8d-0140ed8fc010@gmail.com>
	<8d341a51-2135-4c62-9df1-5be351e73275@howdoi.land>
Date: Tue, 09 Sep 2025 19:02:41 -0700
Message-ID: <xmqqbjnjt67y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Colin Stagner <ask+git@howdoi.land> writes:

>>> -    if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
>>> +    if test -n "${subtree_dir:-}" &&
>>> +        test -z "${have_mainline:-}" &&
>>> +        test "${subtree_dir}" != "$arg_prefix"
>> What's the idea behind using "${var:-}" rather than "{var}"?
>
> I write a lot of shell scripts that run "set -u" (aka "set -o
> nounset"), so I do this a lot when testing for empty vars. In this
> case, it's not actually necessary since `have_mainline` is explicitly
> defined above. And we don't run `set -u` anyway.

Besides, "if test -n ${subtree_dir-}" without colon would be the
more proper way for those who care about "set -u", wouldn't it?  It
is not that you want to substitute with an empty string that comes
between that "-" and "}" when subtree_dir is unset or set to empty.
You are preparing for the case where the variable is truly not set,
and the variable being set to an empty string is not something you
are worried about.  THe same for ${have_mainline:-}.

>> If you use "git switch --orphan" that clears the worktree for you
>
> Very useful. I'll start using it in v3.

Excellent suggestion.

