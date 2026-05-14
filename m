Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9C25B094
	for <git@vger.kernel.org>; Thu, 14 May 2026 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793991; cv=none; b=Jcxg+ON1XQ8gOafMNY1Ypbjws6TvyZdIv9Yzc/yZrm7zbynN2fwwFVk2Nk/+HoU2l9A6xTAAKp9eYLUIWANTwOqGwVVYfQvNJznCbjb5gxu6lgEut9CgfDc1ITKFdLl8egZNoMPzhCuTt7QTeA1muBD0Gr1IMUJubOcusmck7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793991; c=relaxed/simple;
	bh=N3QMOSyYqZev6UOc2VJvxleYoct2mmo1jzqAOh/iDXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FqgPIX4oqOD0Kva26nXLX3t10CGYQoeVXOBrTKex7RgUvfZB+I27Wm4CgXzv6XGM9TSIlVotifLDi4hbUJn3BKeZFm+A8fjltcNHX/ZCpL38wYUnFLk9ucIDs741cL6N1Lpg1fOPGO6mA77ibksR5iCC3XKMErqSqrHbVb9/zHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=leDTrLIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sPcbfX7H; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="leDTrLIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sPcbfX7H"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C8942EC00C4;
	Thu, 14 May 2026 17:26:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 14 May 2026 17:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778793988; x=1778880388; bh=CpcPvEL7gZ
	mXKcXjQvhmSQaG9wbYmrh2Uks6I1kO8Go=; b=leDTrLIFhgwM8pozQb9RM5lb26
	q6AALmSvNzrkywjZwCn1LGPla/6B5a38IEWG62vWysgubhMJn/g/p/ZGuU7EXLSW
	Sflh5y47jh2qkE4ypDV1eNXdeJCSIz63gWHq2xErowEqokiEgLuzE6wRHMoWv7oC
	XH7Vd+cWAaUZxmWLFDmS7e6nQNMFWblomlhZZGs2xyT5vp+iao6LaFSAeEaRd505
	obZ/i0juoxrJy9+N02dhNehVKXFEtYpco5OvD2NMPv88iuCvV937+q6D9N4dcgqW
	iVxRTwFGlcth68a+J2TZmAHuU0ExdFF3M5hXE7tQwjHuiAsQ4+Jb71dGF0lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778793988; x=1778880388; bh=CpcPvEL7gZmXKcXjQvhmSQaG9wbYmrh2Uks
	6I1kO8Go=; b=sPcbfX7HiUGhF29Z30gu/122t2CWyc0guEGP4zLh7fVVUwBBboz
	Ms3PmXlIWlIHT3umzcoeRDEvY5O901SZMGnkIEWXHjQVqiQ/4jiCg7M+4qLTEXR3
	r+1uwx3lCf3s25/zh4+ZG1o1VEmnkBX/B/rbdveOeE599k8BbOkj9+fYsciBaa2E
	85ocNzs5WcO9ZPA5lLC4nt1/wYfEIPThr5mekSIXLOCDhah67FjDEqG0Gndm7LTs
	s44R80wutLqgIsrQe4xkOOTdOchax99roZdQKOxBhFCx8XndW/v9x2RXC0g97evX
	X5lsp+v4UxlH8G3jmDCkdVRtUt2D+gQaSCA==
X-ME-Sender: <xms:BD4GasE9AKinn6l2WCAFMjf2imIrQ3M4eSJJmQ7GVIKAO6vsANz9KQ>
    <xme:BD4GasVxsG5M0wBG-4g26mEWEyxl2F17BlPwUdJwGdMiefGH1JK-95V7Si2EV2olN
    bdxGV752Lb8SAB6wVEUssRT8vne5-dk1K_trbyB7k3qoEOFnFx4_5A>
X-ME-Received: <xmr:BD4GarJ83cwmHcdbGeHrHKnFyRJDxJU3odzquTCwAyyasOITGn2to9P8J4DlvxDE0HKLmBsZgAoMCo4Ahp6VgAtDOWNh4eIJ6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BD4Gas8RjmEJrQaX9JWHPzxtZudSQjLgH5trLz7F_KHRe2m0MjuvAA>
    <xmx:BD4GauLEksfQyIbVvQOjpYicdD_LP7y3jZh3HsvcL_02sZ_eQ0NUuA>
    <xmx:BD4GahkuT6GkXoCRjXBKjXQGXfG963yE7Ut4sDIhQ_eVRqe6IoSoKA>
    <xmx:BD4GaiMqGIeiaPNF8U1bd4ICoUqtVYbY1s1dmiUqzE-bIC5uMmZ_lg>
    <xmx:BD4Gamq1hkTUdY0qnDmlMn4MaFY-AmOblbA-BwqUG6pF1xTtCOYRNkkd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 17:26:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] config: suggest the correct form when key contains "="
In-Reply-To: <pull.2302.git.git.1778680725459.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 13 May 2026 13:58:45
	+0000")
References: <pull.2302.git.git.1778680725459.gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 06:26:27 +0900
Message-ID: <xmqqqzndel8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When a user types "git config foo.bar=baz", git_config_parse_key()
> rejects the key with "error: invalid key: foo.bar=baz" but gives no
> indication of what the user should have written.  The mistake is a
> common one for users who reach for INI-file syntax or for the
> "--flag=value" convention used by other command-line tools.
>
> Since "=" is never a valid character in a config key, treat its
> presence as a strong signal of this specific mistake and follow the
> error with a one-line suggestion in the "(did you mean ...)" style
> used elsewhere in git, e.g.:
>
>     $ git config pull.rebase=false
>     error: invalid key: pull.rebase=false
>       (did you mean "git config set pull.rebase false"?)

If the command line were

	git config get foo.bar=baz
	git config set foo.bar=baz nitfol

we shouldn't give an extra "did you mean?" at all.

The only cases you may want to do the "did you mean?" I think are

	git config foo.bar=baz
	git config set foo.bar=baz

And I think git_config_parse_key() is at a way too low level to tell
in what context we are seeing this faulty key to guess end-user's
intention to limit our "did you mean?"

I also wonder if, given that "=" in anywhere other than three-level
names, is invalid, we should just start accept

	git config foo.bar=baz
	git config set foo.bar=baz

and interpret them as

	git config set foo.bar baz

We of course need to be careful about non-invalid keys, i.e.

	git config foo.bar=baz.boo

is a request to read the value of that named variable, i.e.

	[foo "bar=baz"]
		boo = its value

so either you start offering unsolicited "did you mean?" or accepting
tokens with '=' in them as new style "set", you need to be extra
careful not to trigger a false positive.
