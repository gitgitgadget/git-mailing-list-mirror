Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15897344DB5
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346827; cv=none; b=s70aP9qFmsd9HOTD9bblVC35tz3iJcjI6XqZZiwi4YbrgEsCzHEYZijBSSFreYCmly2mMnufEfkN9OclMtmLGhlnww44Plr5vOsZoyFZKSIPKeHoBGeUj3ArJpafABZmXkXbTC1q5UoF7tG6r2d4KVSLqe8ewU6oq7ZJGnoRwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346827; c=relaxed/simple;
	bh=U0RVRXa7bMAQgpOoiuxbHINxp+Scff9VK6Y4OukDSWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bV52oo65sBPJnDKh8DJmTOwBHDOns9Xhvmj4PAuXTblyONz9hnvk58+8/uflRJTeAwEXIkO5pNJOloqb9klcn8zUY1cEG1IFWCy6Frm/lFJgkjGEYCfWvh4jpCd5KrDgTNyZdSxfgEv+HdwXT3OlYPOHcGnpS8MUy64H3v1nX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kwU0u0UK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YC5ObWjA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kwU0u0UK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YC5ObWjA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 374E51400258;
	Thu, 12 Mar 2026 16:20:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 16:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773346825; x=1773433225; bh=lZQ45MrH64
	OmxZY4KgocbE+a1x8+WEuHRO110WZU9HQ=; b=kwU0u0UKoiIFyyBfKvOYUDvNtL
	HAvRRq6dllp/F7z3FI5PpMNP8JDwhODYdVxHPKxTHajdkYTENjq3oYJPUQQVXpvM
	pYkCWWWavOEIsKnKah1UT4nmanpwaLieXjCXYowEm8rgViNE9CzwcrSCUfLqQbP/
	v9eIh2RISSVDl4HFPhFC1JLcqlydOhcimNQA0I544h4mhcfJk8kRzJA4YjwYXDJo
	pWgx5wCkNYjUn+Ie6NC5uBXNo8E2o18InS8GJ7ge8Cz7XrEX/0Vtld4Sh4h6lt1b
	FD9QG1/dVri828QhEFBt6vgGdlc0clyw4CUrSSMOVSuNYKge5Efs4R1fhxIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773346825; x=1773433225; bh=lZQ45MrH64OmxZY4KgocbE+a1x8+WEuHRO1
	10WZU9HQ=; b=YC5ObWjAZirqzQvr2IN0lC7bstVWLlrz7pVYZB5PWdQtM1MQVye
	2VJlha5MPrSJAi1SMjFrwdUJ7j74MTZOY6AVzyzeQn0ch+cB5vuTDi4qv35koWhF
	txScDHeWnlD3QCAod0hU1DL0hoVRn90rWsVO+G0a5crasVHB17hCGkSFKCwvFFpm
	zGbyIqDHRkXP5OoFMyHEiJ55hP9T7SL55LmRIlMeYy1RGdHIvw6vFgd/i+JtvFzT
	S3BPRKJliRO1a3daeiSMCyU092q+m6aJ1EgVJ+PokEptGLjM+wNV6k+cg9RwyLxL
	mbiMnar8X4Rd9kUv7rtw9O027SSHVgaulOw==
X-ME-Sender: <xms:CSCzacfoyZeBDA0vM3sc3eEtCM4nH1m7CdokEp0NSLARJuIBoDExAA>
    <xme:CSCzaR4oACkPpuQ2mhvHy6VtRGRySfATtYTK1UI7RBOo-_gE7oDDBkYTPCBcVrgIr
    712ceO9PYHRIfr4GXjafv36DqXlv0TXTW8lyqHXxuqccpPycGET1w>
X-ME-Received: <xmr:CSCzaXVjh-HnTSAtiGD0_sVKqHi9UtWarYk3Go0LW1zlg-M0471laZnGUY17z8gEqGqWndANv0FdsjwXxkrhZIOi-McSdxIyyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CSCzaY7mybPstRBmyH8KTs5uy4gwK-bmPlMU_gLm_xohGJGk1pTQBw>
    <xmx:CSCzaaqNeAf5_5iobsxV0k8DLyTFoHZoe9-r6p2R2yswXTtKgT-vPg>
    <xmx:CSCzaTksgxGIY4Z1C_UlDYNB0DrDwYdOxZXUIPn2KKpyBRr9H79HOA>
    <xmx:CSCzaeOAKY-4vaGbM2hS9umyIlrrwbg0Y7Zhi0gqM6slN8kTv2h_NA>
    <xmx:CSCzaZLrE7fYJ8Kj6cfv2tJeg_4SoZyX_qqj0YcIumjITHQX5DTwqbcB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 16:20:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v5 3/3] fast-import: add mode to sign commits with
 invalid signatures
In-Reply-To: <20260312192228.481134-4-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 12 Mar 2026 14:22:28 -0500")
References: <20260311173147.2336432-1-jltobler@gmail.com>
	<20260312192228.481134-1-jltobler@gmail.com>
	<20260312192228.481134-4-jltobler@gmail.com>
Date: Thu, 12 Mar 2026 13:20:23 -0700
Message-ID: <xmqqqzpodcl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +	case SIGN_SIGN_IF_INVALID:
> +		if (subject_len > 100)
> +			warning(_("signing commit with invalid signature for '%.100s...'\n"
> +				  "  allegedly by %s"), subject, signer);
> +		else if (subject_len > 0)
> +			warning(_("signing commit with invalid signature for '%.*s'\n"
> +				  "  allegedly by %s"), subject_len, subject, signer);
> +		else
> +			warning(_("signing commit with invalid signature\n"
> +				  "  allegedly by %s"), signer);

A very minor point, but my reading hiccuped around these messages,
sounding as if we are adding an invalid signature to the commit.

Perhaps "replacing an invalid signature for commit" or "re-signing
commit that has an invalid signature" or along that lines would
reduce the chance of confusion?
