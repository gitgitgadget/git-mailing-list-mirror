Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5EE55A
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777231; cv=none; b=n1CHo2lJkiMfBhQp7fvJ9HscgLMYEHkanLPFcI1luGx5EHhzQF53J4cZ+5aol6jXCJ6vLyjZlTYi9Xtxvo2jhiPCMiRj3N1Y+Hk1lJZE4yDsTPkUALTHtlxTKIkCP3Q0AUIJgVN+3dmzFgQt1ebWwf7k5on/nHa2x9olanUJbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777231; c=relaxed/simple;
	bh=Mqa7LWqisizyBr7bdAbf7sRKW4Vbs+dbSQ+tGw8Y80U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pjz+tYDU1K8hBioc0hEEmvcBQBYOY0rYF8A6XJAA8HuNl4hu3t9i43zJkkyqMy7wLXqiJhF/n9Zl3VzebB9Ibvf87Cro/II5wp6LyJ+3qE1DuZOBlfEGr1qmxiEbTNqdqZrEHz2jmft6N2jii9q4di2Ef80UNsY6YA4SesVOJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HuWCFHMx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RiQGby67; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HuWCFHMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RiQGby67"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B55AEC0178;
	Mon,  6 Oct 2025 15:00:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 06 Oct 2025 15:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759777228; x=1759863628; bh=x18ii6Usbf
	kfNGaHqCgoa8DRBI1oZVoRps8sVl64Qs8=; b=HuWCFHMxzg+z4zC3Eh1jdNF/Qm
	W/t9BWAB2Q9z3XxfarMVK1VrbM0Z+R/ab2Ge1odfeZRt2qetRMcUqRgeEbKwhdpc
	qM5FuMmI12+F+36VcyXfzSMFXdfKjxTqZh27ylHtiy6Se3TFgN708b8mt+VMFjrU
	v4f6B5RkYU9VPb0so518csGVgoylhF83qwaUUnv2uAevbAaTgBTphUTf5yNI1LWY
	oxthkMSijd4rTbYgao+z6tfyzk3DUKOUObhkiVnAva/mgSAJwoEz+hsHp7j9wB0L
	X1s3muiqn2amM8zPJ4ST5pMqpeq/vdPG0TE28hUgSxF94wRZaIBGy9eLmdyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759777228; x=1759863628; bh=x18ii6UsbfkfNGaHqCgoa8DRBI1oZVoRps8
	sVl64Qs8=; b=RiQGby677CuQtNAXkjGgiKAmsN7ONz3FbG6ukWljvQC8b5PNHey
	TJJ/mNNaIrD6OG1sAbO0sCXOGLx7j754PtMGJ+Nuh+AJpctIg2011pSe2YT/81v3
	PUMoKc693dFG/Mdt035wJD69l5zXmoS+86RUhQHBF25t6jbJCmeAnC4gosz14EM7
	l9TqB3XsJfn4SrG5YcbPVA4PZePN2PuYtF/0g1tpDVVZh0HRRRAOPlGgfpOy9IVS
	LtecR+hhLK0nxmpOlJqqWkDAr73NesTEPaz/W0GU+UBgi64a4KEeyKktgYle/6r/
	isV8xTvHhdAHQCcHbAZpmoZpY/5osN2aM8A==
X-ME-Sender: <xms:zBHkaCe2wWMA6rrFFJE3Q0yk2m83tkZOL6_1SZWrOSyvQVVhWJIblw>
    <xme:zBHkaIkY9oHvr_MSACt2SkiUJkyKC_mwfVzC7aHX2Vt908rCucPJCjMc0yD3C6z1E
    G1DIHVp2wjFmTHwATI1E7nTGDwdexj4w-HVG2l3QmymkNe4LJVJxQ>
X-ME-Received: <xmr:zBHkaH8Z2x4G8vVJIckTIVY5Jkjd3pR-lRNmeDoyNfl5kTsDRzfRGqW-TN63cWQ3U2lCQAwWxE1G-_-zo6FBVmu7ZfyBYjXh2_j8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnohgrhhdrphgvnhgulhgvthhonhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepthhhrhgrnhhurhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrhhoshhsvghrrdhmihgthhgrvghlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:zBHkaOEJeyYtYlNc-A9pCzGxd3NNrSYRS3ch6QP_7SwbC9DwIPIGlQ>
    <xmx:zBHkaLL6ddOEVGsdalu-8jWQWrIPl8Z9VemHUXrJvQVhjSA2tj7riQ>
    <xmx:zBHkaOnN9pt5U6yztv9694UPv6aMA0xaIcvlOxOV2W1vQvqP9k2iBA>
    <xmx:zBHkaEwHDJqJNsn-qTXEqTNzXsoj-XdTbjfYjnNKZ80STe-hAwxnlQ>
    <xmx:zBHkaGDd8bhGX2TM3Jq4LXTIGGRuVXKFaNogWjs2nJTHF6jIm1p6vmSU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 15:00:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Noah Pendleton <noah.pendleton@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Thranur Andul <thranur@gmail.com>,  Michael Grosser
 <grosser.michael@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Taylor Blau <me@ttaylorr.com>,  Matheus Tavares <matheus.tavb@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Calvin Wan
 <calvinwan@google.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed
 with :(optional)
In-Reply-To: <a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com> (Phillip Wood's
	message of "Tue, 30 Sep 2025 16:26:36 +0100")
References: <20250501214057.371711-1-gitster@pobox.com>
	<cover.1759094936.git.ben.knoble+github@gmail.com>
	<5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
	<a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
Date: Mon, 06 Oct 2025 12:00:26 -0700
Message-ID: <xmqqzfa3onxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	test_config commit.template ":(optional)$PWD"/notexist &&
>> +	(
>> +		GIT_EDITOR="echo hello >\"\$1\"" &&
>
> when git runs the editor this will be expanded to
>
>     sh -c 'echo hello >"$1" "$@"' 'echo hello >"$1"' path/to/file
>
> I think it should be
>
>     GIT_EDITOR="echo hello >"
>
> instead

That's interesting in that I find it unusual.  Fine as long as it
works ;-)

> Maybe I'm missing something but don't we want to ensure that we have a
> non-empty message here? Also as it is a single command we can avoid
> the subshell with
>
>     GIT_EDITOR="echo hello >" git commit

Yeah, that does sound better.
