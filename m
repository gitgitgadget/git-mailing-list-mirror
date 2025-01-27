Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B721607A4
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001432; cv=none; b=KkjHJvT6AmRlscfuT6da7xgOaLRSjZjAMklAFh4J2fMUGxSQQyv79icWJkDu0X7nLKnWzBwsyNsd7jgO9/pb9T2Zi8ruRYCiqzb71gnOS8ztkbzYYYhCxNtii1k9wWIUT6Lj0xjfo2MQOEf8oKwHrll2oKainQ2eBq03bIsMXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001432; c=relaxed/simple;
	bh=k8/cq/BhFVC6URbzf9r1O0/W1PrXqSRw7P1GLEiZ0E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cx4EhITOTbak530dJEaaXhxu+DtaBXUXKIhd4tXC5bvNbdRh0jXn5ufag4n8C6B/q9WpSMIk2fW5fQfYt2aRQXZoF/NLuVPsTJ1Bny2mGRAYEMso9Vt4XZ6DDD9HkX8cwNYMvdllAbT3ot1EsT9FDIHvZPwXoj5wot3NAENBx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OjeRIqHo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AAVuRgF9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OjeRIqHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AAVuRgF9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A155F25401CC;
	Mon, 27 Jan 2025 13:10:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jan 2025 13:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738001429; x=1738087829; bh=4SlshXmL84
	+HWGqR6OabZPijurUCcVUrsZuzu4XE4KU=; b=OjeRIqHoPJTRxuRoM7lTgQR1nA
	dXIQci2ZFazodyfp2puHQy5kF+kbV45+3Pf0dXahY1bW6g4amJoizELSnyzchjLp
	GdfyTTC9KRUKiYkQELng16wK0Lz3wK1QKYF05Jd+10x1dNCVGjlDCFqnMDxFWk3Y
	EJ6W6TG7xQGYyD/jharsRfZWI0LTqkt6q37N3lmnraa8Qv5A/ES7yMDMzKIbsrzl
	0WHmEYKvD3/NJCP5TqISIrV5gAU6TIcGhPPpNolp7UuCK6/QDVoKgExJcNDGZKNF
	en3X2n3ayYk8TEbRZD+8kCltse4nvakg8LrWvfaxLdvronpeCHKUrwECbtBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738001429; x=1738087829; bh=4SlshXmL84+HWGqR6OabZPijurUCcVUrsZu
	zu4XE4KU=; b=AAVuRgF9WlHmxtpjTGdKGmB2u3TZk123JCOICw3sdvJzCjtemQt
	cyUcVkmZLp5gvn8PcofQErEXpRDnCrY+QVIbP6A6YsO/kk/QvP/e5l2msImYp761
	7icVX0XrgaI6C48byv4xLCyCwItjwtHi1bBJ0BPyMEn9dkDDrpV8CrYjYIPbFA9K
	cEI9LA0SbXdVD7CuCaLTovbUWTmlbZvGDLy8xOWAVQM2nemOqI7Q89mRz7GLHt8N
	6YD9vq2NiWH8B4LmmnCWHpZGoq9SICBuWJqdXBysgFiXKu+ulAUraw+cRrOnAnva
	XI+ADkeX7CFiysmNmRW1jyvBwJPEnIMG8Uw==
X-ME-Sender: <xms:FcyXZ5yuJsMHCxwz-xr84iXPIRfsACP64UBP5JeizNoG6oGq4nNeFA>
    <xme:FcyXZ5ScHmDF0hVPZZwUKMlrEQ0Rr2K6aS2RycMiHpXBVzAbN6jaM0QBmJt42Yu3R
    q-AZQbM__DLgiUQsA>
X-ME-Received: <xmr:FcyXZzX7hRX_i6JlUCfo_fCPYUGthzQu2OlaSw4af4IOPp60UtIytI6fKk3jz2EZ9DJ1CQM3srq6WkeqRaGiygZAde54JxtF_jB_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvvghtshhonh
    hifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FcyXZ7j_fFkcj7fF9JoFzIojEDtFYC9Oj8qa-Grt6xhIFBlk8cfPQA>
    <xmx:FcyXZ7D12_EAuKMuAJo7DvJO1jmSeWFDG-8SJYwMCs1V0smNDuBnBg>
    <xmx:FcyXZ0JYijgIBT5A11r6d_FOofO-RaOD-YNqRCiu96yca2w1cr1ZDw>
    <xmx:FcyXZ6BxqGm4qsGIWF-cVH3rewus4m9UmX3_WayEzs9vyu8FO-RIxQ>
    <xmx:FcyXZ2-UWl6EGT2CmpoyjvJEBXn16YEWdrOYTTCC4eMbMUeXAVzahDl1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 13:10:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  shubham.kanodia10@gmail.com
Subject: Re: [PATCH v2 0/3] refspec: centralize refspec-related logic
In-Reply-To: <20250127103644.36627-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Mon, 27 Jan 2025 16:06:41 +0530")
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
Date: Mon, 27 Jan 2025 10:10:27 -0800
Message-ID: <xmqqikq0ruuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Thank you for reviewing :)
>
> I've added documentation comments for various function signatures to
> better understand what they do.

Before saying all that, please help those who haven't read the
previous round (which wasn't even v1 IIRC but RFC and may have been
skipped by some potential reviewers) by summarizing what this series
is about.  For other's convenience, here is a key excerpt from the
cover letter of the previous iteration:

    As Patrick pointed out in [1], the logic related to refspec is currently
    split across multiple headers. This patch series addresses that by
    relocating refspec-related logic from remote to refspec for improved
    cohesion.

While I was working on an unrelated issue, I noticed that there is
one function, "extern int valid_remote_name(const char *);" declared
in <refspec.h> which is only about a remote and should probably be
moved to <remote.h>; cleaning it up does not have to be part of this
series, but since you are doing a similar clean-up effort, I thought
you would want to be aware of it.

Thanks.
