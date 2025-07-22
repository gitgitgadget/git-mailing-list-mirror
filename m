Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58390266B67
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197710; cv=none; b=LGiqJfh1OZngtMhWvF3eE46l9Xqxw0X23SMpKHt+awPrvWJDqAMiQ60MVNKab2DJwrNcLjmM2y56ihR3+IIVyRCnTD8XUerhIKD9Lu66GKa7PnoQEvoS7ZUKyH2gClMi8ntr6qLYvG/t5BevjcuKliT1cjJ3RuS+7IfsDWQIjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197710; c=relaxed/simple;
	bh=LkTOYaTs+fxSBiznhf4o5DfudU1Zh9KQmjU0CrdjSEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BEQGPPBy2HuQoKKB0SSRAImV+mhmVt+rL0YWcBCX1ybwXKCa3SL8aAVZIFQrofEEJyKFhKiSOtWbCwu6+9fRKAFqLdlce+Df5DMY+hjtGsjLo2h4PnbJGSRuixRXZdNejCSNurUHaRNQKqaFrAqJSwvh9M7jjKP8rf5VX+Q38Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r9u5hccg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfpKcv9z; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r9u5hccg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfpKcv9z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 611DC14000A7;
	Tue, 22 Jul 2025 11:21:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 22 Jul 2025 11:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753197707; x=1753284107; bh=xOZcp72q7S
	FMu93pzlklPtQV/IAtVQ00Dx+qKwejOkw=; b=r9u5hccgknVSVLntQnP8aZZZwd
	t75n41veFq9hEcnQkKlNZBRJA2fuLHcZyiuWaLw9OZmt1tMp+6TxjFJX+/zpmv7C
	GCOso7b33d8Wfu9du+dUvqZUWxEsF9GlC9Reo7JDJLZT2V5mq87Z5J7sm+Mw7Mn4
	jXFVYK1G9qqdeHR1Qhzze6z6BTADVovhWKYrHBjMVTZa5jbKF3ZZvV5pxFazwImb
	6Methn4aJl2g8S7pJ4lHZsaw57OVif/v0NNHiWuW9IwOye9ir4nGQtm4pjBW+uC4
	b+y4f6y7VwVK8LOh7ccgcIdw7TAVWrBeIwAMH/luGzov25o/qeZUgStZfebg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753197707; x=1753284107; bh=xOZcp72q7SFMu93pzlklPtQV/IAtVQ00Dx+
	qKwejOkw=; b=BfpKcv9zK8Hctm+4h1QwXWPUYaEtpLIGyUgCuRgK8BFgzXvezUd
	p8zEVsWts9qVLvOh9jc4c688WOFv7erackiVXdPvGzK0BIOfiKa5UV9TRJze44HR
	1hdCUoTTKY2j2XE061M83MHvM92m8hojllrwWnhLhDt/oqqo3TeRupPjR3ReIanM
	CtLwGOb3P6JBrOG/w7SY2w7tTgLfKYFyaFqrjXGKjbp4H274C01i/usCGvTx7mgt
	I4+Bvp0z/GfWHrEcCI6Pip6M7pZGrxXfEdahkjbek0eqUhoCTrqdrXQqKwm4LLjU
	qT3iaxU6Izz1vssNpFX5BAm/4f1VkdQTHSA==
X-ME-Sender: <xms:iqx_aKZcBEC8FSlExcJe7Luaoo-UAvuyGY7jsL9A2PSOItzIAEdDHw>
    <xme:iqx_aIDGoAvh6PAf1KG_nWayUZ6c5q8OpKm8hiGrUdameU-FADMK5ynG4GJgK1uG7
    9LnJ18aKGy9Mlwnig>
X-ME-Received: <xmr:iqx_aK86bXWaI9I-RHhBxQ_Vr7vLhlIRQPTZszDY820HFtDsDYUx5LgraimjFL2lAwOyTs6irKxQ_5_B-rQwiFONyXnB9ISWBh10Ecc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehosh
    ifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iqx_aMQylsaUoewlNYbFOL4mlFX2PG6NsbzOMS1R1PQFMsyzGNNcPA>
    <xmx:iqx_aGWcC7zTtLe064PQpOE9t8zOocF7KYUKtxHePzCARlGJMY9i_Q>
    <xmx:iqx_aOSNNraw7c3KxZuAJqXoeKHf5sj9d9s1cXLql6OFWjDxney6fg>
    <xmx:iqx_aG1DWk8UkvguOwfZUb-MNWxgeIDuMGn3cUTVJ_yoINELzfkNeA>
    <xmx:i6x_aDbaSTcM1sJemgf00LHJKF9dXGphihOI0T8xl1p32ISvthqSfbv9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 11:21:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  ps@pks.im,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
In-Reply-To: <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 22 Jul 2025 09:03:25 +0000")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-2-lucasseikioshiro@gmail.com>
	<CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
Date: Tue, 22 Jul 2025 08:21:45 -0700
Message-ID: <xmqqtt34tfna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
>> Currently, `git rev-parse` covers a wide range of functionality not
>> directly related to parsing revisions, as its name suggests. Over time,
>> many features like parsing datestrings, options, paths, and others
>> were added to it because there wasn't a more appropriate command
>> to place them.
>>
>> Create a new Git command called `repo`. `git repo` will be the main
>> command for obtaining the information about a repository (such as
>> metadata and metrics), returning them in a machine readable format
>> following the syntax "field<LF>value<NUL>".
>>
>
> Doesn't the latter sentence only apply to 'git repo info'? Other
> sub-commands may not follow the field<LF>value<NUL> syntax, no?

True.

I also wonder who it helps to use <LF> as a field separator.  Once
we require consumers to properly handle <NUL>, it does not make it
easier to write such a consumer script if the format uses <LF>
there, does it?  Besides, wouldn't it possible that field may have
to contain any end-user specified key, including <LF>?  If so, we'd
need to have some quoting/unquoting mechanism in the syntax anyway,
so the behefit of using <NUL> to simplify the parser would already
be lost.

Thanks.
