Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15535382F18
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656214; cv=none; b=uSMRr/EbLutg/pJtJgEFGKwpXT8NvsfMQEdl7t+o74RIYUWjLvuP2KzhJ7EP2FMwpqblHZFypMtudpZImsQtIeACZYfu2hzx/OGwn/wyGmKa2FMUSr14xzJWVF9OeI3I4p+40q1HytNjJpmz0q6qF2AbVkspwDAoQ3UiMMG0jec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656214; c=relaxed/simple;
	bh=5mTmfiMzhxqYYEesuKQdyRiw1ecRM6fMgKQ0dYTeN6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TamMkkKcaAYaM0uonrB5k1z0S7YB+72RClHPHVgcBK1z4OChZlP4omNtYReI9vW3wP8Np1m3FBLjfgKBdzlSC6G8gC08E+X2sViz8T3B+AzmqbuV8QqYkZArxc8aNwbOIUvAmx5MHw9tAqCgNSudfu+zKhLLW84F7oW8eJpR8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6IP9ctW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjGnHldd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6IP9ctW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjGnHldd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 099247A0288;
	Wed,  4 Mar 2026 15:30:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Mar 2026 15:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772656211; x=1772742611; bh=Qd2Jn82im3
	Wr0zPdRYCDNAfkZk1S+gaabT0UM27cl4Y=; b=C6IP9ctW+/H8Q0HCqZCB2JLEdY
	5cMg1ZwPxiRJ9G9rbp80qG3yB6i1/hE6rDjUdrUSYDZL9kyMJ/QHHwAmTMWMUt5/
	ZKnioaguBPe/9Eh8zQjfbkoI2ZVNJew8tlMFUboASs9JdFVhkYuaYCuxLrv4+RIX
	jJAuSTKJ/I54jRYq1rXqmCHYpMMpKIybtSYFtMkmFYZQlNH2ax/6pGFnhGgJgmzj
	lScGSmT+828q1XMOqP3eTKL4bVjUIHxrTP8G6/ASnEoatKp5k7WjTOjlgHBieqsj
	EZVz+Sv/QB+EWt6mAxjx3yINTMuHnxojNdMRxNdwW9Shc6OIe7uNZGsoI5Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772656211; x=1772742611; bh=Qd2Jn82im3Wr0zPdRYCDNAfkZk1S+gaabT0
	UM27cl4Y=; b=EjGnHlddOXupktFZHBhs9/L+4orgMpYjYPBuO50LC1U0nA3D+5Q
	GuL+hi2rn5ud8r54lTV9JV59GzuOhHuWNN80dupmCNFkqSMPloo05iVho21hBYMb
	bqyi/4EBqjm3rFdpFfyb/wTEn4b4xTRpovnQHz+XM6c/9G1rNLuWAArb5bOCTO9F
	FaRjdaaXfQpz/5yKtUdw3PlHz+LAZmBQmbAItV3m4CHwBDUzdPtzwn9Jp/eCXlL3
	hVgYsvUWWodnOauH46NQWCzunP2QdjDdYksfFx6PD/WquW5ihI8XFV7rPY620JfR
	AQD+1TsgQHRdIx62F7E/vV6LnquyTj2DEYw==
X-ME-Sender: <xms:U5aoaSFgvHQeWW1CUiQDQNTne-e6DGS0H9m4KrMWWNjjpn-sPPUZvg>
    <xme:U5aoaaVULZL8OHBwxmhCBgKOuyB4hGMFTGuH80VBPQwcFQiqe_W0udsoakdSH5q9V
    RmEJir6s-i-oAxiYyrqZGtv6nrTGgGUApn-8ZsKcqneYHUryZfd>
X-ME-Received: <xmr:U5aoaRJWX4NoME0px89ZmcngGHEjDyo5ixvLFFaq7VgCVGcRdjfDXi9TKQi70dWBrETYBW5rtSs7KpOR-Q9-stce4oq29GjfoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U5aoaa_fo2RkdZz8VT33Tn0Bg7dGovNuRryAEP7raO_3Ljj3QV1pQA>
    <xmx:U5aoaUKtUrkN_idvXkTpJHr4CXJhbUrEeTSbnbxtlpEqZDZxsuni8g>
    <xmx:U5aoafleS3MWUIwxy6PFkJstR4QP0GnioRW8YH6RWQMR4OEvce1dHw>
    <xmx:U5aoaYM54tHxR99TBEHb78FW_qHQ5SWo4dqvwqGGM2-zuHiDQey-lQ>
    <xmx:U5aoacoG8gjY8q0_GT0dAUDbUf1wMIuOOX_Fg5x_B6Vo_By06BsBbHzO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 15:30:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] list-objects-filter: use
 oidmap_clear_with_free() for cleanup
In-Reply-To: <CAGedMte09S1FE2nX5SnamzqZyMGfme-kL0skZ+e+st-b2HbQMA@mail.gmail.com>
	(Seyi Kuforiji's message of "Wed, 4 Mar 2026 20:29:01 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-4-kuforiji98@gmail.com>
	<xmqq7brtyids.fsf@gitster.g> <aafX6qva_badx_RM@pks.im>
	<xmqqjyvra9xg.fsf@gitster.g>
	<CAGedMte09S1FE2nX5SnamzqZyMGfme-kL0skZ+e+st-b2HbQMA@mail.gmail.com>
Date: Wed, 04 Mar 2026 12:30:08 -0800
Message-ID: <xmqqcy1j72y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> On Wed, 4 Mar 2026 at 16:31, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > Agreed. But I think with the current status quo I'd rather drop this
>> > patch though as it may otherwise make the reader scratch their head why
>> > we do the exercise in the first place.
>>
>> I do not think too strongly either way myself, but you may be right.
>>
>> Unless we are dropping the "we optionally let you free the shell"
>> traditional interface, it is of questionable value to use the new
>> interface.
>>
>> Thanks.
>>
>
> Hello
>
> Thank you so much for the reviews.
>
> I'll send a new version dropping the [PATCH 3/5].

I thought that Patrick wants to see only [1/5] and [2/5], discarding
the rest (i.e. 3/5, 4/5, and 5/5).  If that is the plan, I do not
think we need any resend.

Thanks.
