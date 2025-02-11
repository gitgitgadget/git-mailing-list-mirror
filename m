Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE82627E1
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309046; cv=none; b=lVnBG1gJK6pCKaElpCvH4PVgAb4VGIhtYWylpVwvZIgI3zFv8fEBSIGD/6bnD2tcxxlUSjwBnwW3Q6VnkoHRuE/EqjrEBVxvaNfUrfI+TcaQ6te1qBQI3srbLgcfrdDe6/Sv6qpzep9YWnbjKlV9ADFcemr4WAw/kRNt5yrdYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309046; c=relaxed/simple;
	bh=svGf9bxzY4kb5A6yDnY/rzvryej2qmelJutwLjOdrCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYo73DRmcX+MfpX8TvJBGPNabukFGbFf+Rrub8SudxSdCzB3DACENZgODKtyMYenbnpYAdNUs8AxEy94GpafOrGy5Tt1oZAQyl3dLCc4SYwSkcES6sxng6/D7K1OuqjZ1Wtfof32EEOr0UtU77vHyusZqaQasriQkbcgBAe4pCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IHCrAdHT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZbEyrUAV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IHCrAdHT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZbEyrUAV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA3251140200;
	Tue, 11 Feb 2025 16:24:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 11 Feb 2025 16:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739309042; x=1739395442; bh=nMHPjwXF+8
	91wgzprSDLA0LZ5Vtz4kFObZbdNy6D3F8=; b=IHCrAdHTPyU/SGatp6DAhMngIM
	b/P97h9M2IC1IFq5GXqyX/ic/t85aDo5YgmyIvfBIG4QZCcf2bk7dQEuV3c8hqpd
	lWBFkT09kOYxa7bb63YwtJ3dPXJp7n0Mfxq/CIVmkmuAxi8fVRv5hOUzOCU9NS83
	tXITaaK1wFGuxVWm+FuQZ1E9xl4GyFfSUuudyPD798yCWqPDJjmm38+ZOC3s3O8s
	ZbGquTxnBQBdwYiFZ0ogsypzJP6GWFEosGn7NFjt0kNrT095sbx3rB1oWeyZcsKn
	erSGnk7jQobQMhorqNnwVkk36QFc+gqM1V/DR0ojTAGfeJW378CULCbXAhpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739309042; x=1739395442; bh=nMHPjwXF+891wgzprSDLA0LZ5Vtz4kFObZb
	dNy6D3F8=; b=ZbEyrUAV3BDPW6cB3kOTwcU5d2+/FMAiz7BbvfIxQ4isUXWo0uU
	wZdle0pWb7f15Rp9jJIbZNjlNGqSOxmrc/vx17xnyKXLesENSkq5GOqbfcvjUDFF
	AGkwkKU4DNT+Y51M5osd/zfEUt4Br+4f7hnSR62xlhYepBvKMs18IU+kh6aWXgrA
	wmwBRC9Jt90QzOmMps2AvteKrJ13V5//j8dn8F09+T1sZ5nlb1fNi6TO6NL9WFVu
	qTvX1LrZm3ZTSWyaZYRhmrv/GDGu9BRkyCX9Kf7EIvL+YYag5C3ZkcCOlwPpmq3R
	7UPUiL39760+SbyiejYDSGrrsh/q0zsteHg==
X-ME-Sender: <xms:8r-rZ4g0db2_39A5VwHDS50PC-rTflNJb2647kCRzm7bGqKbjRyN1Q>
    <xme:8r-rZxCqb519FEl73feKPeQIL4zaHbeSQsZ3lERKeSMS9mz01udQcj_ce5aqzKLUo
    3lN6W9y21EIhSeJPQ>
X-ME-Received: <xmr:8r-rZwEhdvnq6wNQOU17qerwMnU5lFD32ai9uMC_uraydki4mnhfqBUYguRzvMZd4hfyRqXRfhxN1nljOEJyBCuAeC1DGijh6sVzZSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepihhnthgvlhhfgiesihhnthgvlhhfgidrnhgrmhgvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8r-rZ5Rfwui0geDmMbaXm6r__JPS8RB93zRHYzZLDInY0uk1A4-w7Q>
    <xmx:8r-rZ1xuVW1piyFcIU5hrroAgx24CEwljBNjfPNwkZ-DcHR-jj6WGg>
    <xmx:8r-rZ35BPVTvkmhQ4oUFn1ta16tHtMqyWixlne-jh49jHBNUZ_4x0w>
    <xmx:8r-rZyyosf3aW4NOQ9W4YzfCGssub1e3UDSNap5uv97ZPs-3ROwbeQ>
    <xmx:8r-rZ3uQpwLKTD-0cd5j5Sb6DxOHz4lCUZcMYxTWyEEmjPE8nXl0ucD6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 16:24:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 0/3] clean: add `config.exclude` and `--remove-excluded`
In-Reply-To: <e7e0c581b4caab142989df174ee51e454e97dee1.camel@intelfx.name>
	(Ivan Shapovalov's message of "Tue, 11 Feb 2025 22:47:09 +0400")
References: <20250210191504.309661-1-intelfx@intelfx.name>
	<xmqqcyfoxr7o.fsf@gitster.g>
	<e7e0c581b4caab142989df174ee51e454e97dee1.camel@intelfx.name>
Date: Tue, 11 Feb 2025 13:24:00 -0800
Message-ID: <xmqq7c5wxjin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ivan Shapovalov <intelfx@intelfx.name> writes:

> On 2025-02-11 at 10:37 -0800, Junio C Hamano wrote:
>> Ivan Shapovalov <intelfx@intelfx.name> writes:
>> 
>> > This series extends the concept of "excluded files" in `git clean` to
>> > make it useful to protect "precious files" that might be present in a
>> > specific developer's working tree (see below).
>> 
>> How does it interact with "git status"?
>
> In the same way as `git clean -e`, i.e., there is no interaction.

That is dissapointing.  I was hoping that "git status -u" would list
precious and ignored ones in two separate sections.

> There were no implications behind my usage of the word "precious".

Then you should ;-)  We'd like to see us use the same language to
refer to the same concept within this same project (and more
importantly, avoid misleading people by calling two different things
with the same phrase).

> This email was part of the `perl contrib/contacts/git-contacts` output
> for this patchset, as documented in Documentation/SubmittingPatches
> and Documentation/MyFirstContribution.txt. Should I have not done that?

No, as I said, I was curious if he is getting involved with the
project back again behind the curtain.

Thanks.
