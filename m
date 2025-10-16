Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D2262A6
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633805; cv=none; b=mBBKHATc4Q9pFBVw8mwrsi+JRu4A2g/esMheLHxUypH3FN336dSCmtqRLf88mGHKhDCUP8DWnDZ3YTGzfuOXhO6za+11lg8W3cWIrcAMTh+EYnlKj3tx3MJ434elmHSBH8ytl4hVNXLM7GP3X2n5xnspieMowEB61fBrHAPx9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633805; c=relaxed/simple;
	bh=GseXOSOE25rpunIC0erNOZpK3QwRFtK7hNGHRVKF8Hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZyQ2YlxcfxItyJqg5FdsK6aj4g0UZPYQbcbwqCh5K+Uxi4hfHIUYzmVzxjf0FtcvAAen3mTVD4TPT0Y1fWJZpXzByPYQ/UcYy7M1ECfbBmkun+P3Guc0aHS2fVWXoPEYWtsmjfep2gfObWWRh2UmsYqJLuOPqv9R0o1J39Lug7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B4qtgueV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flbjpLB1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B4qtgueV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flbjpLB1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B8A971D00101;
	Thu, 16 Oct 2025 12:56:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 12:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760633802; x=1760720202; bh=bd0R0W51zU
	86CxuZVG0m06l0/j8lhfv2545A9lzQmc0=; b=B4qtgueVUts2KfmUR2WPoW1THt
	i2O955DcE5Tn3OvkGDKMr0OsNfU6DL319yBeWdvnmzVneuCMAI2o7xV7OuwsnhNw
	1nrBLAtk2kZVUhHZZTk8+jgnT9vnMf42eMJuZ/wP8VuO9Dkf07WVW9vxVaK56By/
	Q+GdNvyPYziyuwDRAHSBZJkz8cb9vB6sj9rN7mbRiQGosIR2uZPrCUSmu+4OkvIs
	McXZ3ei6ohuWiobXrdxEyWDch86KPWjPZsSO+KxR+n8wo9J0NbFBZE/1EDSikRma
	UvHPlGYsJRw41oWMMTkleOqEahbIM2t0EEBmIBY+TuihQIjdXMousj9cXefA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760633802; x=1760720202; bh=bd0R0W51zU86CxuZVG0m06l0/j8lhfv2545
	A9lzQmc0=; b=flbjpLB1bkKo2MxK95rz4s20HeyaJkmLtajYSidxhMTLK1Srdwr
	68JGJzPfvUkmec/WRLS2E8f0iO48CtHGDahN7loifYlSoxfVFZkwa+1msWShN9ud
	CAzi79aSyys1OkMskk3w7N9S2lBFnzkqLuGEWV3FKPu6dI2aL/9UXN1hBNH20e6r
	BPSX+pg7xozcpL0unnFHXhWHhDE9W9MdFE4KdS6sFcpaqHRFuZBaGP6SPkL+L19g
	I+eIFT8w+hypHGXqnHb1Na4DGbc9i5bTTSeJtXNoYK2Zn1uid4ddiRQfmmgK/+Gc
	86i8NU//rqysTh/TNcZsjeKGRkHx8r1XhYQ==
X-ME-Sender: <xms:yiPxaFxAV8CzwCD5tDheSzsCYdXtq8T47SKpWmASkAJd0KnGf21F2A>
    <xme:yiPxaF99ePTYxEPdLmUWaDne9Yqv7BzVNOx5wAhfiaDenJvusIKUG5I59rE4V0N5Q
    Ovm_6hiyfdEmMh9ma1YrCbli2YuXA9EqtNoNQy__CelfupLJGtquSc>
X-ME-Received: <xmr:yiPxaNiPOZVuFnhL0jCMiLbrBFkZFjSR2ww8gCq0XHUApQtp6Hl5CWxF5sndFSeaG9BPNBzM6LYC76CstFcUL2RpsIoGl-E42e3Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhi
    nhhvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:yiPxaMGuK36X_V7PJQtKbJBNFpld7hK2GXqUapwCqYmwt5NjYePQhg>
    <xmx:yiPxaM8pYeM_gJ5dKd3_WVYC88NKOAED9MIjPACqVO6KPMVy5nDZVw>
    <xmx:yiPxaDzCK7e0RUI1q665IwzufS07EywslJk2HZdh9lBEnO5nlqpF2A>
    <xmx:yiPxaINZAPnni72DTQVIBhGd1lBWHkOHYjJ5N7DfVdVHDvXBcKKk3w>
    <xmx:yiPxaK3-M9dz9v4kKmufc2jcAwJ0xWLsrEGPFIGCHaXFBH0swTa_-Le0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 12:56:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Martin von Zweigbergk
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Martin von Zweigbergk
 <martinvonz@google.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will
 be removed in 3.0
In-Reply-To: <xmqqh5vz7ygc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Oct 2025 06:44:51 -0700")
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
	<aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net>
	<xmqqh5vz7ygc.fsf@gitster.g>
Date: Thu, 16 Oct 2025 09:56:40 -0700
Message-ID: <xmqqy0pa7pkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I do not think X..Y (or X...Y), if accepted by commands, would never
> change their meanings in the middle of the commands' lives.

Sorry, double-negation bites again.  Please drop "not" from "I do not
think" when you are reading the above.

> Teaching "git diff" to complain and barf on X..Y is a possibility,
> but to do the same for X...Y, we would need to come up with an
> alternative syntax first.
>
> The same for "git checkout master..."  that detaches HEAD at the
> fork point of the current topic (so that I can "git am" in a new
> iteration of patches on top).  As the syntax "git diff master..."
> is symmetric with it, if one were to change, both should change to
> the same.
>
> Thanks.
