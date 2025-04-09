Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037625DD13
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205385; cv=none; b=JuPSqWYcwlwQ/28x7K9mGLbup4kqerRwNoeRQpsXM+J1LROHy9f6wHDUeRdTnZgcPnTOARkzLJDZmbtIC9FPPlLEQwdFitRB9xIcx/nBARJSXFkz8H84cctUxg4pEykzKfWYbaUV5tt2ZKq1vaQf7Qazju4U70OhoBQZXP9lA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205385; c=relaxed/simple;
	bh=kciUrq1UtkfRXmpnekPOgMi9xqy3EO+aQTjMQM+GsZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jEjs8oom2mfLgAabYtwmaT+t+LfXvSP63i2dOqljAek+G42GfFE3PKeW0ixsOwX2sujNOrUv1K26KhZrD2K9v1KARxs9Bb/5CYnOr1yuT5aewgzE/yYvMkMyJlz1r6K63DSbkvEum7gpiITZa7VR/qswRb75ufOlDPE+c0BLNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LcFxGf1r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xl6WTNIr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LcFxGf1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xl6WTNIr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94EB2254019E;
	Wed,  9 Apr 2025 09:29:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 09 Apr 2025 09:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744205381; x=1744291781; bh=IynN/yWywk
	MNUcDCKZnK7zpaF9Gxx9VWNsEYEzWQjkQ=; b=LcFxGf1r8LivtHMIIgtu3DmbWX
	2YfkCi78pwA62DXw8VhjahlhL1Waa1V4Pp0PuBWmJREPtYAKrpZjc7icZLaP+9VY
	cIh9fo6GqQmn6ShelipF65h7KnjnZ8UGMeDSWK4Cgf/ouS+FZtIb72fDtqenRbGs
	h8Pg4iHYKXvVRyigQUHwLppgJgiEAg198mTiuGtQkfo8fqehq2cUzU5FShyf992N
	F9akQ3gHxYj9fH48LO+fgxPGmo1Mv9s1XEouKo0VAIljmsxqyOGfhVNfBf2syqOE
	y7z/FsUzpbHEG97tXKQLY0b+OY1GxXY2edOhEnONbEEgHEYJtP90B3kqmwOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744205381; x=1744291781; bh=IynN/yWywkMNUcDCKZnK7zpaF9Gxx9VWNsE
	YEzWQjkQ=; b=xl6WTNIrhXogPCwUdoheAYuGlu11U3kdrciyL23jF21Ch1Dmlto
	UpCZPQsfESy25HDbBMg06C641T8m2SrLqqz9oLdl6GH1QgGoM+gkRzc9uyHXp8Ky
	DxF9SnAOePjYkxizRWh0NYIVNRzFb0lIZk1jVOoX5Bo8+/8u9cDwLdrCypACjQG/
	7TkQgXesRLp0MCgNv9v+7vdMfFShrz0UgwGi6pbbG70uv+sxGPmIBnhBIVF7rr8h
	lwnmZM/caUZTWsN2wukhOI6LYJ/W20vx9FNbXQ+l49eFlY5b2ZWVJ83x4TxKbQev
	aS/uz2gStuIf9WsLueQ0qLr2nJgcOoQyETw==
X-ME-Sender: <xms:RHb2Zw99CvZ_EINhPO0J1kcSko8Bwb1eycQqCKOquaKN_SWYC02XLQ>
    <xme:RHb2Z4vVnMKpoyJ4cEopiToSddIuwcEAMoweqYkjxgTiAkNqvD0hooE9crL7YmsP0
    9aRAMs-oC0VmhkDJg>
X-ME-Received: <xmr:RHb2Z2AmJiIbMh9NMwZaMPLLt4QJEUNxzKtydiptY3VG2UiYzTSO7Wo8uxTd2tyRYE2sq-MHfl0jBxipeUZzvuKCLsMUIDNz1ZLT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhthhhonh
    ihfigrnhhghedufeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrnhhthhhonhihfigrnhhgtdefsehitghlohhuugdr
    tghomh
X-ME-Proxy: <xmx:RHb2ZwcDHLa_2yFctOXoUsXraGEwDaFmWMhaxpMqYcDRKPYgE75vAw>
    <xmx:RHb2Z1NYXc1G-FBr8n0tYIULvYSvn0Mryk7QbdPl5SalsfiOnwfW6A>
    <xmx:RHb2Z6nJgzUZvZWVGrNl60Iff1M-3NBBmiQTjIpKGKDstfcr5cT5Fw>
    <xmx:RHb2Z3tEtBjoxcyJK2JDB-WMWeWmfzitaaNOzZfjyup6kFRGzAAZOA>
    <xmx:RXb2ZwMWxbFeEG1NneMai4DrwDOBosKwjM9R_LLg8y5wIEsrRz0xgsMz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 09:29:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org,
  ps@pks.im,  karthik.188@gmail.com,  shejialuo@gmail.com,
  christian.couder@gmail.com,  shyamthakkar001@gmail.com,  Anthony Wang
 <anthonywang03@icloud.com>
Subject: Re: [GSoC] [PATCH v5 1/1] t9811: Improve test coverage and clarity
In-Reply-To: <CAOSofofyfDpFqFzApwMnmYdFb4nk8DS7WwWmYKLPbe+okOE=Tw@mail.gmail.com>
	(Anthony Wang's message of "Wed, 9 Apr 2025 10:15:53 +0200")
References: <20250405103718.25160-1-anthonywang03@icloud.com>
	<20250408114841.58592-1-anthonywang03@icloud.com>
	<20250408114841.58592-2-anthonywang03@icloud.com>
	<xmqqbjt6wdrk.fsf@gitster.g>
	<CAPig+cSo2hPpA0DOn7Tr3pcYfN6jxyyo+n0Y0QetvKvNVoLqbA@mail.gmail.com>
	<CAOSofofyfDpFqFzApwMnmYdFb4nk8DS7WwWmYKLPbe+okOE=Tw@mail.gmail.com>
Date: Wed, 09 Apr 2025 06:29:38 -0700
Message-ID: <xmqqa58ptqd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anthony Wang <anthonywang513@gmail.com> writes:

>> >     The tests grep tagnames they expect to exist from "git tag"
>>
>> s/tagnames/tag names/ perhaps?
>
> How does "t9811: be more precise to check importing of tags" sound?

Excellent.

>> > > +             git tag &&
>> > > +             git show-ref --verify refs/tags/TAG_F1_1 &&
>> > > +             git show-ref --verify refs/tags/TAG_F1_2 &&
>> > > +             test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
>>
>> Do we still need the standalone `git tag` invocation above?
>
> The original intent of the patch was to expose the exit code of
> `git tag`.

Is it?  I somehow thought that "git tag" is not what is being tested
by this script.  Rather, it assumed that "git tag" works perfectly
well, and validated what "git p4" left in the resulting repository
based on that assumption, i.e. "git tag" works perfectly well to
tell us what tags are in the repository.

It is true that "git tag" to list all available tags may fail, but
then catching that is outside the scope of this script no?  It is
even more so, since now we do not even depend on the correct
operation of "git tag" anymore to validate what "git p4" did---we
now use "show-ref --verify" for that, so we do not even care if "git
tag" segfaults in this part of the test, no?

> However, because in this case the test itself does not correctly test
> for the intended behavior, we should modify because we are already
> touching this piece of code. Is this correct? Would it then be desired
> to check the rest of the tests in this file for further oversights and
> correct them as well, or would that be overstepping boundaries?

Just like any real world problems, there unfortunately is no bright
red line between "yeah these are related enough and in the same spot
and it is better to clean up while we are at it" and "that is way
too much for this single topic" that can be described in a textbook.
A rule of thumb I personally use is to put me in the shoes of an
imaginary typical Git developer with moderate competence, who hasn't
seen or worked on a particular part of the system being updated.  If
I can easily imagine that the developer can clearly see a need for
clean up (in this case, "the part of the code only tests positive
results and forgets about negative check") while fixing something
else (in this case, "use of 'git tag' piped to 'grep' has at least
two problems, loss of exit code and false match") and the additional
effort would be smaller than 10-20 minutes, I'd say it would be
worth doing and anything larger would be better to leave to another
day, but a lot of ingredients in that statement are very much
subjective (starting from "what's the average competence level we
expect from our people?").

