Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027E234969
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632839; cv=none; b=UCHD8i7NqdIP2H6+5ud6hOaHXRp530UMCQZFyHlm4m/PdWeZpIjDA5PG288Geyz5X51l3gH3rtg3xT//QicOC8utoKVo68/6rzvtVgqwWEoLnmea96M7a3CIGXuvW7OmNqkdjdD4o8ucSlH+VvSLI71FesklA4oDsIOnHmAhMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632839; c=relaxed/simple;
	bh=S1WTG7JNodraBppt5u7+BX5Eg19y/zAUxLI1P1INGO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mz8g8hgwXkLwDCdZhBu7y1H7qKONBcCxvGIXJHPmirAG9AQdPH1J4w2oGB9Wi6AUC3FItk1Se40/YXRmV4GqHqXP4z7ayTGc0vwyooQ+/anrvHKistoWAMwxms61Ir+tQsDdAJzSluwyrPx+cEuvXbVOuH1jj7XTTLHDEbxgTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FGd74W1n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xo0o8Z4a; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FGd74W1n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xo0o8Z4a"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D13911401E1;
	Mon, 10 Mar 2025 14:53:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 10 Mar 2025 14:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741632835; x=1741719235; bh=kYahv6ZbxP
	CtBOGFxxTkG9ij9s255BxRUtgjHTSHNU0=; b=FGd74W1nw2DwP4OO68GMMOXzjd
	QWZr2dQqouYEb7Zpvz9F9ecV0CIe+Oy8d5Y1+fPvV1zVzpDJ0ZWcVEsmxv88Xjlg
	uUjx7duS0y6pY8kCYB61o7PyaBhvsJVJbUkcTQt7y3XLdZPCnXnso8ETLQ42KyTK
	vJ0JP7QwJ8+uKTM2Ky3YSe5DrrJ7v4nc8Kk1IVGcx5eTpSyU1mEN+VFVsrtCnhAu
	Js7uI3DKV7GlQaF14XsdaOhQshkkMjzt8B2BuFIf6sekYUfMRnin/saq0jfS0ddq
	YUdUurCjmuzMTyScKp0c338Uxhay3lZa5F26Sg7X0insS1lUTwaQ0agkSI9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741632835; x=1741719235; bh=kYahv6ZbxPCtBOGFxxTkG9ij9s255BxRUtg
	jHTSHNU0=; b=xo0o8Z4ab4/hQQAujK4WHzO0PmApQe23mhDuhqt4oRHA/+VfDM6
	zKnRQLqjwvw8LJjSP2fTh3asgTXcb+m6hiX603tbwWCabNjh9o5Q9qO8d71nlsWJ
	XrBd3/2N0/uchwkkvh7Rm3tizRAaLn77BtSYRTsg3jCjX4Lx+67DcCGhsqEzmMq0
	Q2zP7ZctA955mFMlJFxKpeM13neK8H+vMuNXn3tu+VvMD+i5mbeZG4n8GBcLzm81
	kTPLlnk0h+WaqF1TCZ2dgVpDAg4TfrvkaUidLDXc/OU2HGdIb3zS3eQIIHm86CyT
	Uzd3MpTb4lIbCk789333nn/jOsvOquyTyYQ==
X-ME-Sender: <xms:QzXPZ61d4mNEyt9Ftsv_ejbEKw4Di_OwghMzXr_qmzobJ4YFVzkfbQ>
    <xme:QzXPZ9Fs_ZBuG4_M7vcixaa9ag-itjeya2IlDUXOxZkew4pW0sUEdsHcl0Wja_hvS
    mT-vVYnOZaDYMnU5Q>
X-ME-Received: <xmr:QzXPZy5zt_FVl-kbJ_0X4No-4LijG_c6tjpuFbm2qbwKfSVyCgyhp8thSbMQD2NtvZgKeRPPOMvD7RCcdWteyV9tjB3Km-joSivO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhhuhgssegsvghnjhgrmhdrihhnfhhopdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:QzXPZ73K4hPtyt5dx6Rs_D7m5adXwokQuw5LMM3GJoPHR2ZtrKc07Q>
    <xmx:QzXPZ9HkNUJSrLxWuA-yTGzSZ8129wdRm6SXBsbdHLlaVH8WyUvK0g>
    <xmx:QzXPZ0_PGEwUd8z4YGjs7tb0Qrf-Whk0xVkJwes_I8Ftzc540a995g>
    <xmx:QzXPZynQQsKC75le_ZR9bvAJGTOuZSHGRa77cMfuVoBFqkooJZrhQw>
    <xmx:QzXPZ2PPEb68aQEYaG3sjXSvOehersJXdlBKYjKhtyc9k0Wj681KTFJH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 14:53:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Benjamin Woodruff via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Benjamin Woodruff <github@benjam.info>
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
In-Reply-To: <20250310160837.GA26308@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2025 12:08:37 -0400")
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
	<xmqqo6yejg0y.fsf@gitster.g>
	<20250309033908.GA2361799@coredump.intra.peff.net>
	<xmqqwmcx9io3.fsf@gitster.g>
	<20250310160837.GA26308@coredump.intra.peff.net>
Date: Mon, 10 Mar 2025 11:53:54 -0700
Message-ID: <xmqqo6y87m4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But maybe that is lost in the noise of reading the files to actually do
> diffs, etc? I dunno. I expect it is more important for status, which
> probably does not need to read the whole file contents in most cases
> (and which may be run a lot from the user's prompt, etc).

Yeah, and old timers who run "diff --raw" as if it were a quick
analogue for "status" also would notice.

> It seems like a big and possibly risky departure from what we've done
> for so many years. I'm inclined not to rock the boat too much. ;)

Certainly not right now.  But adding a command line option is even
worse as we would have to carry the support for it for practically
forever X-<.


