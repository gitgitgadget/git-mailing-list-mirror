Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD64F5E0
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771822987; cv=none; b=LDwduf3DBgyqmR3dbeDOkzb5B6jdH0t0jGVO0h2wj8DC4SjOZmEo/UHXx4qYbRV5Hms5kPmC+LXy/+VQUwsHHlgcXL1C4BuuNrVYMjnlPNiKqg+XdjPVWmfzso9TKkFoEyVaD/+wWwFdW/4AHOYs5jmU+wWSm9DwzUmK1OYWX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771822987; c=relaxed/simple;
	bh=+dAzn5AiSPI1le6oS5cPoBjky6z17Vnxo8I6ocf/8Lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jniNbMnq9rnnLOisJuSzmZC2yhbfEvKjHxizjGn2vkGaZGDEiuKkgBbcGmEK9/UtBzWuCqvI4NLDtCRP4vJ8/gWs5JM5BLAHK6gYiaRqeyGKQmesfQpKwDScgnpiGQtDDUpT67Vh48dgCulXyWz0NOYQ1PcAr3dpA2JoQEMMwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tJW4L/d1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VT/6oZDb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tJW4L/d1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VT/6oZDb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EA491400041;
	Mon, 23 Feb 2026 00:03:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 23 Feb 2026 00:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771822985; x=1771909385; bh=tONW0ZnFiF
	6FTZpSu59Xw1Vlstgyjul0KPuNZ9CCUCY=; b=tJW4L/d1YRgOmaTqr2bEqA7Qxu
	m2AOddVkNv08PJ/5Cu/8tDaE6bTNuErqUeI/f12zEFgVdaKmfiaNoomhMpwNOpNA
	c18+2/hNHsjWsQD1HrC/xJ87MoXIggNftgT9oRWKxTMh9Vh2wOyFpikW/Ddq0zg2
	gnkV7zVDpSmw4JO2XLKmkrBbEAxR0iQoSt2NtXEXnquJI7KKmvRkUBdqI/SyPi/I
	yAzCMIQUwbKDQ0VTHdFSG3oBdEFeMH4xnSBpEn3MlXS81MFUTUZhu7c6f6X/kHmH
	35WFd//g112InM45hhLbeuHgpNfLx3ugdwEXkK55LopVjnjx8Pt/yITvO/Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771822985; x=1771909385; bh=tONW0ZnFiF6FTZpSu59Xw1Vlstgyjul0KPu
	NZ9CCUCY=; b=VT/6oZDbXw4LPi0+FCaNXt430bhE4GT4hlZfj5lQCo4F6Nm+tQg
	cylYfhA4BGl5ORzITiCmSCibz/OuXbqQSBxU65WadpSi7sitocVRyYg9PCgOYntB
	MFokpskR+IHgwaRB5ohsLCbzCMFZMPY0mMaMjTKbsRwF68iIxg8jVpZEX5vUkCpC
	88b/O8EJtLaDPtBAv4GyMESlbJglVlSulwxCDgMYJVM0Hn3d1UYDN+8ofeMxRKY4
	pTXRethLBtxrgcaOf9xB7Ik5lutv7gch6HF1FjVBUyVO4qjoRejoeQBh2g4Iiaqq
	f1LnjDEsK/XVTGEchTtGy8z7H84JiNs2Grw==
X-ME-Sender: <xms:h9-baafTfD3Y4WTgFySjinRnWHIGuF6yij54NGG5rKRiGXPzeh_F-A>
    <xme:h9-baWwI9nYaTcIBvuSQutxfKUEdI1EXs21eJXujk1GfY2dCn5mJXTwdODG8LMVZ1
    -ZKe4HZAawij9xySJz0N-UgLn2AefyNglUJXu1mIjHTJYtg6JAZxA>
X-ME-Received: <xmr:h9-bafJyAKWtTcK9EDncn4C1S0KEWZ1J2o--QlmQrVbp1tLOgB19WWtFOnfwoQLGNxjJhzw7XI2TI4GlYQvfS6vkxGHWRGK6rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeifedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:h9-baYESG4mqevu-2qkbW0l0HKPIjzyYWyXaFmzxCtUmGrXjtKK8ow>
    <xmx:h9-bab_2kiEywNjAj5dnXukFzyf1LNc6JkSDm75ZkdrOU-_LL79sMQ>
    <xmx:h9-baYJf-ICNRudOjmvB-_ka-4cNkkADz9B82yALo82JV7RxZNEB0Q>
    <xmx:h9-baZtybqClOvPVtjx6DeSMZBWDtFoGEkfvIydkRrf6ZzIiLtE_Qw>
    <xmx:id-baV6IDRMGGl7W6VbjxnfYiAig8i_L8nJlGuLgcV2CA9dsL8bGn7wQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 00:03:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean?=
 =?utf-8?Q?-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 11/13] color: add color_parse_gently()
In-Reply-To: <8fae2d15-cb0d-4ccb-8cd3-c4775b6666dd@gmail.com> (Derrick
	Stolee's message of "Sun, 22 Feb 2026 21:12:04 -0500")
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<ddf6131ac9283bfbf4ec9ec000606765d887e6ec.1771026918.git.gitgitgadget@gmail.com>
	<aZQvT_fTlUIJd1DM@pks.im> <xmqq5x7ve3zw.fsf@gitster.g>
	<8fae2d15-cb0d-4ccb-8cd3-c4775b6666dd@gmail.com>
Date: Sun, 22 Feb 2026 21:03:01 -0800
Message-ID: <xmqqldgkoxve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> Do you mean that this error() call is not die(), the flag does not
>> fit the usual "gently" criteria?  In other words, should we make
>> this call die() if we call it "gently"?
>
> This is an interesting case where the existing color parsing logic is
> not following the typical pattern that uses die() on a failed parse.

I see.  I personally would view that an existing bug worth fixing,
but I ...

> If we want to change the behavior to die() later, then that could be
> considered, though I don't want to consider the ramifications right now.

... agree with you that it should be fixed outside the scope of this
topic.

> I think the easiest "local" fix is to use the 'quiet' way, though it adds
> some asymmetry in the config code in how it uses the 'gently' parameter.

Or, just add comments to the function that takes gently but does not
die() to warn those who would add new callers.  They can pass
gently=1 if they want to handle the errors themselves and keep it
that way.  If they want the function to die, well they have to wait
until the function is fixed to behave like everybody else.
