Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B124EF76
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540746; cv=none; b=XRgQagQcoSyznNLiJIWvwIKqSML/FNdK2z/3gmAn6HUwk1T63aGoAz6UswR4mtj0owuU/YlKtE7hFo5fHOaDCVEW593PZVkReuMpsYDIwdbPyFWtpxvX1I9pE6zmDavLFt0ry3f/QbPyPuQACl7tbaFOqXhIfRFyN4VCNE7uqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540746; c=relaxed/simple;
	bh=uoCtaw1Warjnxvt+IBwKjmmo4q3G12uGKQXOPoO7adc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKcWjOO3NS8BnHZhKPSeH6YDObSFFiDAeggCEkVOqljEF+61bvOLl8xr16RJ8TuE7pNKzt9OIBTdbLWQj4ROKMHS+qSIek7mjIBlqKo1vcDD35Isjp0arrXQzDljlcZLYEu0WhAhyilo/aoSrCbaCwU5lShUhjAeluOAxq7MZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K0hY4pSk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oa7eY2/F; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K0hY4pSk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oa7eY2/F"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B4CFEC0304;
	Wed, 10 Sep 2025 17:45:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 17:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757540744; x=1757627144; bh=dsHCXJ9qUh
	tDsjNmZTbrrp7yW47YGn10FpzjUVGT7yA=; b=K0hY4pSkI0f5eYfXoJ0FB1nsfV
	dTMg92zKezqN0sq8AHaaILCmK6CHbW4JsIlu+C+s7cz5FNERyu5YTdx1evVFMA8z
	7PKCkjbGIaJ2mXH2DiiGmtLG8cFI4o1qYBKqfl+FJXsWDrJ6ZzSfS0lYYOFHTYfU
	pB5yEnWIH3REY55dyTduhhpc/6E4z8U34+N1byHRQncdMfVXzlRn/ePRtH/RjOaL
	9BQzRv5Frr1m0yVosOnoSN4j+W3h/F8oCRXvCSKf8I7qiSaB6NEwa1Ps1OpZrA6y
	g/g6v4zws7I4HM2Sy8fpFEd3hDJE9fDSeV/5lViaXaQwl9sPAPXtu8NZvZbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757540744; x=1757627144; bh=dsHCXJ9qUhtDsjNmZTbrrp7yW47YGn10Fpz
	jUVGT7yA=; b=Oa7eY2/FGLM4qvy5WZ74mwDKMjTZBf1irFvFLgERlyaKZr2PyJ4
	UEzt/A6hs/YvnmUWGRYRdhiW2gsFMoDtO5FcyWwU7tqu3EFKxUXh5mHIfZYMZnCr
	SMZMzp7DE3wnvxA4er/IEueeu4ZzNWoIxg1YsZ9fnyYu3ThienXfW4bhOQr9mZrM
	LyZ75PH/gkVKEryqopBDfRrj22pKdXcPWTdczPrP0hvg8GcIqXbqzt8gR70fb02q
	nIBIbCp+86YU0M5l+Ol0L000e5EpvFXZPg3nJezhXlnJE8ApvkbqoqryaMzwSIEs
	oV6Hm/YLX/YE2g3rR/SL2x5J+MXdOYS9avg==
X-ME-Sender: <xms:iPHBaGyUbXoSD58p4WNIbsiEynb8kSoT24T1aqKTSN8yKuWtjq2olQ>
    <xme:iPHBaFhCD0QaFoJ02AFjGZgaG7gIKodrzHsVcrpcUBI5gCcSEFCq_dnQS86deTO6u
    duAzqRXP-hs6zqe9w>
X-ME-Received: <xmr:iPHBaBzTBBLwJpfTX1oPfGIvVrt5NKqvKfega2nc5p1MnTb2TPtdpcQkvLujtJ6FN27I57CJ-B_BzP0TrMKmi2TpP737HATQCN_8sQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iPHBaIKG6lEFyZRz8YsAvpAKJR8F67hFTIMppXsweCFHPIotwhxu2g>
    <xmx:iPHBaISSHVywyIs-ki0xMrFf70SirDM2W1HxUZW33TCtMTmmujA8BA>
    <xmx:iPHBaAoEvcH93gTN77BF4Zb-UcV0Q1NtjC35f5Oa2hpIDcPbgLbP9A>
    <xmx:iPHBaNp0ghfURaMhuGGKq0N1s3eh0h1LEBhdD3AWrt4aiyPGVifK3A>
    <xmx:iPHBaFEZPFeF7lMGp20k8f9THCwMsorOI3LU6iConZoIkmB8m5eKon8n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:45:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #04; Wed, 10)
In-Reply-To: <ef86dd0f-f581-49d8-97e4-d20aed50d671@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 10 Sep 2025 23:12:24 +0200")
References: <xmqqwm66qauy.fsf@gitster.g>
	<ef86dd0f-f581-49d8-97e4-d20aed50d671@app.fastmail.com>
Date: Wed, 10 Sep 2025 14:45:42 -0700
Message-ID: <xmqqqzweoubd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Sep 10, 2025, at 23:03, Junio C Hamano wrote:
>> * kh/you-still-use-whatchanged-fix (2025-09-09) 7 commits
>>  - BreakingChanges: remove claim about whatchanged reports
>>  - whatchanged: remove not-even-shorter clause
>>  - whatchanged: tell users the git-log(1) equivalent
>>  - you-still-use-that??: help the user help themselves
>>  - t0014: test shadowing of aliases for a sample of builtins
>>  - git: allow alias-shadowing deprecated builtins
>>  - git: add `deprecated` category to --list-cmds
>>
>>  Update "do you still use it?" message given by a command that is
>>  deeply deprecated and allow us to suggest alternatives.
>>
>>  Will merge to 'next'?
>>  source: <cover.1757446619.git.code@khaugsbakk.name>
>
> I need to follow up on the leak that Peff found.

Thanks, both.  Will hold.
