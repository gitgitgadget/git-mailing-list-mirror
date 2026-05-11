Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807E6FC5
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778458841; cv=none; b=ggRDYMP6HfnoWvwUxE+z3+sZmahdb7wlGEtmC00qJ/BbXQ47dyPAbYlCJS1M0EiuLgF+wPqdXF6taq2pGweichxeAhNwId8jIdnHjK0R28t2gBGhdH5elBS+dpGW7EDHWbG/AUMvhRVHjadUqKVD0QOv61HMkVFxLHkVbwgynz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778458841; c=relaxed/simple;
	bh=Ma/sKVjB+yAkjB8IfLAUHSq4W/m8GwIvX4t2HxFkCLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aOASeXqO3y9K89VSgpHZCLv6SgbdeMbfYTdy3HIuhpfET+mbci2h6JaTw7PkjUPRYgaXhqBQ+LwneV+iggnbZQPOdwqJOR6+V08x4uq5wTWl+rCp2otwoxumtN9l0LTya0JkH8ny+zH8g741eWIMEHTkx9FBwVwoqzLyl+hGnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H2XSAIIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AG2kVncB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H2XSAIIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AG2kVncB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B54521D000AA;
	Sun, 10 May 2026 20:20:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 10 May 2026 20:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778458839; x=1778545239; bh=SLF0exfcKq
	lLDORdMFSK52ngEguNZIuguxRRNrlFYXU=; b=H2XSAIIEXNUYBUZIYe6pw8CPsO
	uXz0BjN1vRj9g8HYFGFebbxRV2a3sZKFVWbminHGaPAzmL9ytr9C7fwL6Q97BSxr
	OktjQTz/vzVCk0hg+MSvFkkPzMqzHlAJ/ZtLs3Npszu383E9g6oI/EZ/v2M156nL
	f/xROBupS4UhJx8YPJvnEv3vRjCbC160EC8TIncJj67OABtseJcyq5zY74q31Uc2
	OIGCaiG7+eIqoh961CgOGHaSAZSEvpZ0nZG8Nqc2uxxh2pgGmnurnZT10qfGZc+A
	gf/r0gw8sT733NneNPfpn1C+5JXLxS8OG/jXEq5MiFo0wW8IWQQVdGmcJgeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778458839; x=1778545239; bh=SLF0exfcKqlLDORdMFSK52ngEguNZIuguxR
	RNrlFYXU=; b=AG2kVncBkc+MUEhbkA826rFuIUBtECq3Qt7lfDCgeedsW2aGjyU
	DlPv3WQqNQnwjl6y/rNy7769GUjjR5d1NeoY43hO/FDByzDsuGDNOYASr5TBgNoE
	uu61Qm8nDEQ+PSMIvNuv5Wy8topKyiEEpM19hfp5aI7BIHYofrEwznZw5m3gzHBy
	asC5DrJD4y9UZ+4lViQSVkrXCcWBCtzEOHwZFwbEG3jdBK2ZPBs1pn+fAdRfbLO1
	82CHaOnkTjftIHZxh80q//PTXs06xV40AMIM7WVW0+076PX6VvHGdUvW+L8h58Vk
	bt94do4yMPMMqZWax4K9qgsNIDLjmsVTDUA==
X-ME-Sender: <xms:1yABasg8Ep3fXxzzcoWFyi7p2DJF6DdIoHnbaoFJCdajvCoKyh6www>
    <xme:1yABar537NYrIFmDDA0n_f_G9LvUazpoj6MjnHp2JAAqDqvlFhvKs8VZHTUEplpg-
    3P4KlC56F6EAWzTvzturH-oYz6Lxs29EScl89ymCw-v9DTsbwgf0Q>
X-ME-Received: <xmr:1yABasZCfsDKmecbQKXuzcGyAS-wS7qJTy0zZX2-BuPAHpPBDulSi9mhpyxW0sbViYjo363ISBgB_abNIySOxlt9RRfLSKbQzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrihhlsegrsghhihhnrghvghdrnhgvthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1yABao586S3DLKRipyFNfXetD6FLEPUeQlZflhm-QSzXO4OO_axkhw>
    <xmx:1yABanBZT352VmTxZ6rYQK9E9NwpW5GTEA9KD76F6Ug7T0ils8ERNw>
    <xmx:1yABamcOYKkiozzhoCYneGcILeWP5We5AJxwCc_lpulb6Mb_bS__JQ>
    <xmx:1yABauLzA1pZlbRxGOCgMyWMRjB2SGvyDi51skadUPrhEFIv6m2-dg>
    <xmx:1yABakLcvStyUQkC6xYrs_nbQXPhAYB-pAetLDbfayrWC8DvJ-qRZ4dv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 20:20:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Abhinav Gupta" <mail@abhinavg.net>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  "Derrick Stolee" <stolee@gmail.com>
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
In-Reply-To: <63e04828-5895-4deb-a698-5d6f494d23f3@app.fastmail.com> (Abhinav
	Gupta's message of "Sun, 10 May 2026 17:15:42 -0700")
References: <20260506023944.90691-1-mail@abhinavg.net>
	<xmqqqznk9ih8.fsf@gitster.g>
	<0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
	<xmqqv7cu96q4.fsf@gitster.g>
	<63e04828-5895-4deb-a698-5d6f494d23f3@app.fastmail.com>
Date: Mon, 11 May 2026 09:20:37 +0900
Message-ID: <xmqqmry6x0dm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Abhinav Gupta" <mail@abhinavg.net> writes:

> On Sun, May 10, 2026, at 16:37, Junio C Hamano wrote:
>> it would have failed to work due to the "HEAD" thing, so even though
>> existing versions of Git may have added such local tags to the insn
>> sequence, it would not have been a workable configuration anyway.
>
> Yeah. One additional data point:
> non-interactive rebase is also broken under this configuration.
> Given a branch off main~1, it runs into the same issue:
>
>     $ git checkout -b foo main~1
>     $ git commit --allow-empty -m 'do things'
>     $ git rebase main
>       # ...
>     error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
>     error: invalid line 2: update-ref HEAD
>     You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
>     Or you can abort the rebase with 'git rebase --abort'.
>
> I'm guessing non-interactive rebase works off the same todo list so that makes sense.

I smell that you'd be suggesting to replace the patch we have
discussed with another one that declares that it is a bug to use %d
in insn format?  I do not think how well it would fly.
