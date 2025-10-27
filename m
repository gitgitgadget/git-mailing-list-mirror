Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8042F3632
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559072; cv=none; b=n7qr9ptWuWat8sUC4RihxrwUIKx5lH8krbA/+SJU/fIPdEByarBwJ5x+4HWBWV2w/i9StFtlZRhppJF+PNPlbnlcYvHswrnP9UCROXu/6QWlg6R7s6CUMB4n74w8+WBhrPpmYc0aU1sLT8vjL9bdFaEortLMwTxFRQFd/0k/Sgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559072; c=relaxed/simple;
	bh=xwC7VFK3BsqMYcSdJbfFiAeNeqwU5uzxMwOAaibVk3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsVPJy4r4yGkevyK6kucSa/eAwJtIJBYY7xqqarDs6Mfd1Vq4KI1vy8ZNL/iAfvVRO4irSiNLl9r+VFaXTOSQ3onEERw7BK3z4K5bWtl9npeMW6b30sHxFGhdI1YkMH18hU7Xs96rju6JfcXsQgZIreW4qrxB5veEZfSD0vNjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gXd1pSPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dl18CnFF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gXd1pSPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dl18CnFF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B696DEC011F;
	Mon, 27 Oct 2025 05:57:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Oct 2025 05:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761559069; x=1761645469; bh=Vupy/pkexm
	zBI09RziOW2DVHHJs52Qce2MdCMqCSdAQ=; b=gXd1pSPikeBMqN2giQZ8CxVxRK
	cAfKGc8ad93oEKZz9C40YxkdgxgnvWuTq2NvaHE6ZUBlB8ESokLtoBlmoYCpYqfa
	w1kWwteg+c+4Rslz1vREvve2dpMGbHd+UiuMMqzREnklvPO4lT0ZJARmTPHIUnBL
	+Co1QLY8jGVicCE+2CPAUpPRwKW2+PI6lQt1adND3Wz2cYFZ1F9EFNZHeS2Fc14v
	OEuu+orDweqLDBaYDLNUjBNbl6VOsgvfR3+Svc+o1sJpaw6of/7zzeBsXpI2y3H4
	Cj2/q3LlX6Sabt6HS+t7L1ubDGE/vmyOFC1jc92ZsSyCMZ3G7KJ1oifc/ECw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761559069; x=1761645469; bh=Vupy/pkexmzBI09RziOW2DVHHJs52Qce2Md
	CMqCSdAQ=; b=dl18CnFFeH2KtbSeb7aYIWt1AhMCnL7jnmqq8k42kABQGfvVUnb
	79ZSKMMVST5fwW3z9D9eSPfpfgEzwwFK8MKOY5M6rbWiVjheYA7oHW9o4mPLYOcF
	38gtIOsJKKFnk4lw+c49SzywtsbHQRJQA6Q5zBPGPqs5EGPTbnuXlfJ7OEn+CvDE
	BytIE+nfxENqip1BlIqNZE888AO/6yfKpJbmpLPqxhF583jUbziA26R6x7BQmXdz
	P9/+lC0O8I98diHuH/1grdHphiisFE698qH6CQKGWgMmmlsh/vGqMZ1SA1WpeNKN
	voevAHaGygG4rNbxT4BQ4FxH/UjIbn9/wQw==
X-ME-Sender: <xms:HUL_aHqB3MX1h6kkRt9DKwEi-prF2FvX-8KPLlDZ73Dqvdz3MluKCw>
    <xme:HUL_aEOdYrZEjFAptqtqaditJxh-PicKw_EXPouzDdiW48UIPhJBn3QVkfL8cumil
    fXbYZMNlGH7U8zHB3HYzb4iCYhPiwyuM8ni1MPpQnM9uaOf2RU92A>
X-ME-Received: <xmr:HUL_aH38KNy5PWp79K6b6oK1b2O0WLsXyxapywGbtlMl5EV1-9cdE2BDkwFUTuBVim6L5gEFd3SUCwJScMICXEU6_tQo3wCVW6fBOFxrBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HUL_aLCEFMe_IDlDI-xlXJmVltDOWmlfF1gZZl26-FiwxKEe-mCo0A>
    <xmx:HUL_aMLOsqZR4DvtjaNQDQ4xdJC3wLr0sAChfJQvag5EfjXvSEuJ4A>
    <xmx:HUL_aMkKXojYDDwwNn95hcfaHXjDjkev8XhIr7-swlX1y08t4S3Epg>
    <xmx:HUL_aNYpDpbe62wexRviqUmJhc7l4uLPirygHvbZoGDE3p8deAEO2A>
    <xmx:HUL_aImWAim9gILZfX29UdggH0sXLB9qhOzYyc86mm8fWpkFFeFnOnKB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:57:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dd065d0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 09:57:47 +0000 (UTC)
Date: Mon, 27 Oct 2025 10:57:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 04/12] replay: parse commits before dereferencing them
Message-ID: <aP9CGN39LSaFU-Ru@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
 <20251021-b4-pks-history-builtin-v5-4-78d23f578fe6@pks.im>
 <xmqqo6q0t1kd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6q0t1kd.fsf@gitster.g>

On Tue, Oct 21, 2025 at 01:57:54PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When looking up a commit it may not be parsed yet. Callers that wish to
> > access the fields of `struct commit` have to call `repo_parse_commit()`
> > first so that it is guaranteed to be populated.
> >
> > We didn't yet care about doing so, because code paths that lead to
> > `pick_regular_commit()` in "builtin/replay.c" already implicitly parsed
> > the commits. But now that the function is exposed to outside callers
> > it's quite easy to get this wrong.
> >
> > Make the function easier to use by calling `repo_parse_commit()`.
> 
> Two-and-half obvious questions.
> 
>  * With this change, can we lose the parse-commit call(s) from
>    existing callers, or do the need to look at the in-core commit
>    object themselves before calling this function so they need to
>    have their parse-commit call(s) anyway?

There's only a single caller in "builtin/replay.c", and that caller
parses commits deep inside the callstack via `prepare_revision_walk()`.
So we cannot easily get rid of any calls.

>  * Can new callers you plan to add decide without having an already
>    parsed "pickme" commit object if they want to call this function,
>    iow, can they decide to call or not to call this function without
>    looking at the members of the commit structure?

Not quite sure I understand this question. In any case, I was hitting
segfaults in tests when I didn't have this call. But your questions made
me double-check this now, and I cannot see any of these failures
anymore. And we do use the same infra to pick commits as
"builtin/replay.c" does, so things should work alright.

Let me drop this commit for now. Things work without it, and in theory
they should. And now that I'm revamping the infra to not use the merge
machinery in the first place we don't even hit this code path anymore.

Thanks!

Patrick
