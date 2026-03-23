Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6A1B6CE9
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309159; cv=none; b=AG2qK8KItDaRmuVxXoVkyLVapOVEz4TrETwzRuViEw4LvBf6/f5pPkUdGep5jaP/dl7yIqP2rvr1kLXqBrc0iAGFS+x/OaNzFkw1fRjjbs7ip1SL/BDQBqtAadSeWr0VCpIvvnjOBuSJ4KXIuobHXgn0CLvj22GX8w7DAwj3DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309159; c=relaxed/simple;
	bh=/bydIPdc5i+ACtTbaRNkQQ4SM/oz8KdKFdfQdHbmNwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGQMdiD7JFibA6rVPXsbNgg/muO1N9ezI50dMfB2Dlnd+yPaSHJ0+LjuTPZcRzsaX4RGVKMqTuz1+GTbaxxi0CeQhEI50WQekV6dGR4LJBPa6mhDZBcsZapSwkQq9Ax5shV1QzmRbw2sS2LTjZDxzpYBjV0rHO2OqtWOXJs81no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aTgtlm//; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ekNvV3Dr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aTgtlm//";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekNvV3Dr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD9C61400019;
	Mon, 23 Mar 2026 19:39:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 19:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774309156; x=1774395556; bh=vtYcMgqw2X
	i8M3OH3ftjos5dH7fMt+D7kZgRzI9igyQ=; b=aTgtlm//nn9ygXlRs2AAfJTwHp
	gQ3E7e5DS2m3d538InMumLyGAFxYYyqFoLzw2tiVcn471MmfawiOTmrVKrFBx/HF
	fVJ407KsAr8HhF+AtrQ92nsVr4qtm5AdxTH7ATmZ3TJnp/w7ISWp1OSjO6tv9ka9
	qBhkAuEmcaa32toKj9MZPLGH6NrXVGQzDf7V7PjcQ7w3KVjaP7y7IUI+Lo0uPem7
	EyAqcw+qtde85DpdO5xJY3wjUZ1IV4NR3/N0lPyzB6F5NuTyNzbKwKeo9pAGGbyx
	koGIrIB6boEvPKWw6wecJ6BFTb61PyCpN/vc9Jw4KSBlh7nYc7KtwimToGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774309156; x=1774395556; bh=vtYcMgqw2Xi8M3OH3ftjos5dH7fMt+D7kZg
	RzI9igyQ=; b=ekNvV3DryXT6i1CvOv9kmQqRtGk2WzdnyArnSU1aSWIHRNI01Zx
	4xl5fvKZAPCKWIfkulLrw2My51vryfFiOJkQw6Q/LFrxlNlWEmWiTd3dGtygolix
	801uVXVvLOmKO0tGxKI6dn8sW7RMd+6ExiWuGTY/qVZBHzkNOYUeb8tzilKNFFL4
	wwyr0WfGmGDPH8MrJ8E5kb/s7hyeDFKs/ASo/zfT0qYuoTj/yyo10QXTvjTNkCrV
	F4YVwJsB9bvuOiZdDuDi9JFcN+HAUGw5OBVjuaV0i9L0bR0jyWv4f6XJdB36imj/
	mTmZWgCnGIiw005i2nBr9Bpa1zZQzYB2XdA==
X-ME-Sender: <xms:JM_BaRcs6uTML-vOHvTv8zXU4Slge8TdRUW8KRSDAy6htC9iCXj_5Q>
    <xme:JM_BaS6x9mkg9NH8kkOvoAO5EkPgzU77-aeXsAfMit8YzJamrg5TScJtN6MwtopXj
    2IektRpBhIxIc7ekBw-Yj1SnVJhWLCiG3-RYGikXOXmDvwsyY0>
X-ME-Received: <xmr:JM_BaUUfZET5aODPefutD8HnJMrmQdIksnBt6etPqOhUNXMfvMbiXxo4t3f_y5XKsW3Qe5Ld5BMTalkPpXeGa_bBlD_ITnGq8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjoh
    hlihhsshegvdesghhmrghilhdrtghomhdprhgtphhtthhopehjohhlihhsshesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JM_BaR6-QqDXb9N1yLcvbQ45zyXlaW1xPi9d4GNN_PLMxO41GLOlDA>
    <xmx:JM_Bafq1V-HJpcY-6xP9B0uey-J-Ewc6tlBu-7SPc7qY8U06QukszA>
    <xmx:JM_BaUk2f902zsWjV__OlK6Mt1o1XMMLd8kEUIgsHESBeo_SHYBOdw>
    <xmx:JM_BabMpRAHWhQkD88XHelp6KEkP1UyFfDb_7PgjpQW_hf3loAL7-Q>
    <xmx:JM_BaSNc6KaqKCJcy_mtq-YccoZ7Xn7ZXEVQCCjQ92cIR1fR8NaX82k1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 19:39:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org,
  joliss42@gmail.com,  joliss@gmail.com
Subject: Re: [PATCH v3 1/2] refspec: safely parse refspecs outside a repository
In-Reply-To: <20260323231049.GA23721@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 23 Mar 2026 19:10:49 -0400")
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
	<20260322053617.38951-1-jayatheerthkulkarni2005@gmail.com>
	<xmqq341q41wu.fsf@gitster.g>
	<20260323231049.GA23721@coredump.intra.peff.net>
Date: Mon, 23 Mar 2026 16:39:14 -0700
Message-ID: <xmqqse9q2k0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Mar 23, 2026 at 03:27:29PM -0700, Junio C Hamano wrote:
>
>> Looking good.  Shall we declare victory and mark the topic for
>> 'next' by now?
>
> I'm not entirely convinced the better solution isn't just:
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 92e40bb682..60774af929 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1552,6 +1552,11 @@ int cmd_main(int argc, const char **argv)
>  		goto cleanup;
>  	}
>  
> +	/* yuck, see 9e89dcb66a (builtin/ls-remote: fall back to SHA1 outside
> +	 * of a repo, 2024-08-02) */
> +	if (nongit)
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
> +
>  	options.verbosity = 1;
>  	options.progress = !!isatty(2);
>  	options.thin = 1;
>
> That would make the http transport consistent with non-http ones (or at
> least any that execute in-process within ls-remote).

Ah, yes, I like this much better.

Thanks.

