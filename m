Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD222BF000
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766012872; cv=none; b=kNrgCyIhBaQ1PIY5TKUsML6CgR/KBN+9IkjINHJwkLghDsge1io6eiJTSKfpqtknruCeGLCjzt5XjGMo8RzgwZmweDEGeVvgc1hBUM705KPwYSZw311AzzbOLt+GPr+T0zEYhkefGWWLMKcYjHRg3ZguusrPOS9ptGR73Fi8oMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766012872; c=relaxed/simple;
	bh=LTZdj8v+ZhBYMx37HKfewkQXk9k9firYq5is/+sqkRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ImJyP1ChEvQzT0N4wWVRNPIH6pe6HPxHCHqxpJ5WvKzH15uX8AZvLOEali7XGGkyUmcfdaQK5wspxR7DK81/0KvDH/0UqcsAHVB4jpg9TBgBQAYT9RXa1fIhsnj2izt0AReioHbXguu6UeIoB0wwGO0g0cXYRbKXk5ROLzQmb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eCkX6paG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miHur3X+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eCkX6paG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miHur3X+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A75714001EF;
	Wed, 17 Dec 2025 18:07:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 17 Dec 2025 18:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766012869; x=1766099269; bh=f0cudMv12c
	kd3xpHzPCAAYDyKpp/+acm1PAWuxJuI6A=; b=eCkX6paGjfTTKjXafs0kvwIhBp
	I3By4+Z8eXlFKlDN9f6WlT+3X06d1n7L19hUXv5gOH4d9t/E2+QOz+tfXA2MA8WO
	d8atg1mTBnpGwTaMmNQs4XZj54iPsaMfGhJauiuJ+PMvUvPBlUIB/SErHsf7WKEV
	DR5QqlXSvOTA0ko+AMKtWciHegIcbVlC/foEZumg0cM1cxLEdYPQLf8m1g2agf3g
	DamgnpAcN1XEatWIrerwf6I0JHMnnjdF4P2r9NiDzIeMWgDBlp2v5EN+oXexSUSq
	UCAtlmzeeFFhiDALoTLm9pilnQXL9Xi3+qCcl5MPvD4xehG9uwriumU4t0WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766012869; x=1766099269; bh=f0cudMv12ckd3xpHzPCAAYDyKpp/+acm1PA
	WuxJuI6A=; b=miHur3X+B2+35q9zFx2T17gE9IoFOEzRHW85V0ubdKZLti+jGtS
	UX4u6A2AgzLqfDzfbSPB0MWwceCWzV71dmMZRgig6S89odWq+nwmVlD7p8j4JlcJ
	wTqISzsYEKyktCvGu2aK4vyPFzDApWrLcglPVhrxaQMmBNbgAjsdkotqHM6DceH5
	s2lXF8rLEgzCpaCl5LqxfZ5kZXbrxn590xjeJbLSfjid1IsxAATJPRppxFc09CRA
	zOPP9AfjbkpwY2doQv3y2/yoy2kkhvXdmilcO3lIHokGAN2RqYhgG7GLVQLCLuV4
	HYePWOwPAXSBKGLfJC0C4DaOo8MW/sayQug==
X-ME-Sender: <xms:xDdDaY4DS1chR9AclqBynvR63QKMlKityaXo8xbfEvIXaIy7dCNC3A>
    <xme:xDdDaSEofL0enQahJRwbvlNu0lOW6-SQ8pLoWjXEbLBLVZ6r8WfNOkrnCKvgXt3SE
    rMjgAqUBkwVfEwi1bSqaAbAps7RRbpRgFhmpVmMwjtIubBC11b_Jg>
X-ME-Received: <xmr:xDdDaTB-0V9llJ84VJasEnHCOyCMWDM8jIo1nFn3ZW9VSLszICdTaEnOv-NAirjoqH_tAhhYoPNf0RSj19XxNEMrK4ji4oQMKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrughrih
    grnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xDdDaXxgSlolcXpdNacA5-pkUgPNlsxFKu9GMMSHYotpqWyDsuC0HA>
    <xmx:xDdDaX7A-LUp6SSKnWKi4XGRuT9Oq3jf9MUwYaPMUPlRpWTEdrxXFw>
    <xmx:xDdDaYz856bBHXuakISbqbcRTXa_oAVIGF6ShSxfB52Tz1RG7JUNMw>
    <xmx:xDdDabdqh4bPJNOfT4VqxePhLqQQ8pyPZk_gta61KSYvk_PYSVijrA>
    <xmx:xTdDab62atSOHKtc8tn2p9Kyj8ZLiEnecv1mpiNYa4EoGfd9MFKE5jNK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 18:07:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Josh Steadmon <steadmon@google.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/11] transport: convert pre-push to hook API
In-Reply-To: <aUEmtv09kkEZ2cJ4@pks.im> (Patrick Steinhardt's message of "Tue,
	16 Dec 2025 10:30:30 +0100")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20251204141535.1986263-1-adrian.ratiu@collabora.com>
	<20251204141535.1986263-6-adrian.ratiu@collabora.com>
	<aUETgWJ5DJaEpugO@pks.im>
	<87a4zihjxb.fsf@gentoo.mail-host-address-is-not-set>
	<aUEmtv09kkEZ2cJ4@pks.im>
Date: Thu, 18 Dec 2025 08:07:46 +0900
Message-ID: <xmqqecos1zct.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Dec 16, 2025 at 11:09:52AM +0200, Adrian Ratiu wrote:
> ...
>> The reason is the list was not exhaustive: for refs which we know
>> beforehand will not be pushed (status rejected), there is no need to
>> feed the pre-push hook stdin. It's saving a few cpu cycles in some
>> rejection corner cases, which were missed previously.
>> 
>> I could:
>> 1. Split the extra *_REJECT_* case aditions into a separate commit,
>>    highlighting and explaining this better.
>> 2. Drop the new cases since they are just a minor improvement in this
>>    series, not very important for the series overall.
>> 
>> Any preference?
>
> I'd personally learn towards (2) unless it is fixing an actual bug that
> can be demonstrated. In that case it might make sense to do (1) and
> explain why this wasn't an issue until now.

I tend to agree.  If my hook did something depending on the branches
the pusher is _trying_ to update, not doing (2) would even be a
regression.

If "git push there next seen" attempts to push these two, we know
seen does not fast-forward and locally decide to refrain from
pushing it, it would silently turn into "git push there next", but
the hook may want to behave differently between these two sets of
command line arguments.

Thanks.
