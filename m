Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE18236451
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724566; cv=none; b=oth058b5cKogHsiW1JWoKezJId2rIFgEef0eWFiKNRsIP9H5spLJ0V2v1JygUsXF+4HKgl7uhS+bOsCbyg042xYi73ONvpOKYSueYHh8dzlLUxvZHuXt3kYpj+bmJGUZcS4/QDpENOgt8IAhziFpRt0RG59y/5T4c38hc4RfV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724566; c=relaxed/simple;
	bh=RlUxLd0j3PLpokjQZ4ZebF1lw5HW5C9LnZ2UBT0ia2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHrwt3qKTQvJ7KXFmnnREzPnjxnW4sPqHDRMFI+povC0ljjHKrU9k25n5z2STYpyedRahqbl+cNtNGv5BmQT3AByVBkniIPrkJD5Kg3oEUZdjXEJZ6AKcHFe24szvqIHOYenSAlevhaYycQxPGUji9XjG5y8/0eVZPlbYnTRQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kJrBdS/j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5/RBWqt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kJrBdS/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5/RBWqt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2F697A014D;
	Wed, 20 Aug 2025 17:16:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 20 Aug 2025 17:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755724563; x=1755810963; bh=BWgyKfHqcn
	e+T3/Lw/BBdpNA5hVU/WRpsDKwUiRt3Zo=; b=kJrBdS/jWcyOrezjwPm2Ztib4C
	4SvUD0UJB6YOnr/bmmFKXft1yGZR56gJnrkfTrxav8vUpaQAq1qWldnau8uVrzyv
	w3LUAhlHkh+78TmWhF7fJ0LwpQZZI0CskADzWntUsZb2Co9SqIeu3hqnRNgQVgGa
	JbGcrI+Q2n5WbpRm9LgUxhjAPM+obl8RenUAhcA57MVzDhjgZlcHLwaRkwy6GCMC
	KCywNVGSDzlqhBGsVLKH5AJILdB+zV0m2KHyhTYRHNH1/7Ok4HKMzC1lj0m0KZ1t
	FJEpwLWp2ZxN5zaOCDi7uyZaJ9jqeLh6nuTIerGOr5oYR/euIWRKUEZjmMYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755724563; x=1755810963; bh=BWgyKfHqcne+T3/Lw/BBdpNA5hVU/WRpsDK
	wUiRt3Zo=; b=H5/RBWqtdwsXdY/5RSt4TZUVgkyckj9tqU6aNML0DdDBf/09nZL
	hzkJutMWC6mV+YOwCv2qHeYaYXh2tpZ5/tDCreLw+wAz2jJFlZylaQrB/vffgFUx
	NgKhzNTPUOSqA55QZAUZFB5NpCSr5oyFR5fJX62TN7u5tKCS47sK0AF3hKbYsW30
	9wsaxYKjIdUv5CvklUxtNW0sfJKJ7Lr8WdQa8rnyHD5ZOTJ7Il8EFthHKVeTnwfG
	9hvgNd6iczbSbsdZ10dnELtExPhglaLFZIn0bv/bSvKyGg77V/naOnaX8F2RdeDn
	cYwLJIpP8tc+qHV6mgcPw0bDYehNnh29SEQ==
X-ME-Sender: <xms:EzumaFGHK5kEPb6bbRG6jC26stjx4m9vBs7ZBzwrAv0pElQyio1iTQ>
    <xme:EzumaE5xsb3aEmMd_PLXWqZfck87P5Ecn7xGnLLBNBYHSWWinh_RV9_yRpVlDmpkx
    QSLxcOElERNz_uCxg>
X-ME-Received: <xmr:EzumaDtgYSEdHTct8liPyeLkzSqTd9SGD-T6V184W1R11biOrI8CXi7BLBsJ9zQBscJLU667aX-mF72AtPuoRAzQUlhlj7Cl6KmoT_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefujghffffkfgggtges
    thdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgfevvdefjeehtedtgfff
    fefhtdfgheettdekheejieekgefgteejgfekieefkeffnecuffhomhgrihhnpehgihhthh
    husgdrtghomhdpghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhgv
    shgrshhsohhlihesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EzumaN4wkEAiN8P0x0-jvS283fhtdkm_qULd7xPF-a8xzL0lBfYwSg>
    <xmx:EzumaGWQiugdmZ7GOy9W3CPk3G1p4l6dwFfbx6mDIIxhAc6VWYCu6g>
    <xmx:EzumaH9MwbsybYdO8kpHYuZJG9ZzxpC3hnvOLQb_-Jd4ratifPfAHg>
    <xmx:EzumaKmSSF7K1ztBdvGG9hd4SCqQtfDbtei03CmlJwI0PTCPSXUszQ>
    <xmx:EzumaMUF-nvgo6J3b4iZ351kkVxsfCh3nGqizZE81eRuHLC6ipdG_fmY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 17:16:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniele Sassoli <danielesassoli@gmail.com>
Cc: Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc:clarify which remotes can be used when contributing
In-Reply-To: <363ac6d1-8444-4d48-a66b-51ea139f4e87@gmail.com> (Daniele
	Sassoli's message of "Wed, 20 Aug 2025 15:07:36 +0100")
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
	<xmqqms7vc8mo.fsf@gitster.g>
	<363ac6d1-8444-4d48-a66b-51ea139f4e87@gmail.com>
Date: Wed, 20 Aug 2025 14:16:02 -0700
Message-ID: <xmqqbjo98zjh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniele Sassoli <danielesassoli@gmail.com> writes:

> On 19/08/2025 22:19, Junio C Hamano wrote:
>> "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>   https://github.com/gitgitgadget/git and open a PR either with the "New pull
>>>   request" button or the convenient "Compare & pull request" button that may
>>>   appear with the name of your newly pushed branch.
>>> +If you're using https://github.com/git/git as your remote, you will need to
>>> +open the pull-request from your fork, selecting `git/git` as base.
>>> +
>>> +The differences between using `gitgitgadget/git` and `git/git` as your base can
>>> +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>> Looking at the table, there is no advantage to use git/git at all.
>
> Most of the document, including the "Getting Started" section, points to cloning
> from git/git. It's only when it comes to the gitgitgadget section that we
> mention gitgitgadget/git.
>
> It's true that there are no advantages of using git/git over gitgitgadget/git,
> but I would argue that the disadvantages are quite minor and definitely don't
> impact someone at their first contribution?

Even the disabled things may be rather advanced features, wouldn't
it still impact them for them to stay to be on git/git?

Those started from git/git have to learn what different things they
need to do to use GGG by reading this extra piece of documentation,
and then if they plan to keep using GGG, they will have to do this
extra thing each and every time until the end of time (since your
preference is not to teach switching to GGG/git from git/git).

I have no strong opinions as I wouldn't be the one who is doing
something extra every time, but I'd rather see our new contributors
having to spend less time to get their work published and more time
to polish their work into reviewable state.

