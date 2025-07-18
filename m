Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E75A923
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880562; cv=none; b=ei4b/DJyzar4HwalEkPLu3lztUsVnZXWj60XiASpIwM2nwZdgiqjLKHgSFyhcK3VPbcqhkUoV5N4U7pkc7z0cK+2y9ReI4vP/78hN1G8bXANrl+WQhGZJjogsXkRS8uQ+JkSv4twAeNQpQDo/pWaa5cKI/+5N1cVk7Pygbbm6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880562; c=relaxed/simple;
	bh=+pV32n90Vc+4phxNmhdlMA2tUNA466eqjMC0ygupZjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOX9WpJ0EzSIzf7kFk/Na6e9ah2dmmZxWYLkbrU0ZDMA/y+onKTz+B/E+cLCcY0VcMHIuBNKPIJC2nCSb7wijLM3233jFUG3Shh/MAP00aTvzSqcirRNqKRN5NN8l7rqo9wazCWi3ovAsbGY3zmADcLyu6ZG91FxrHqHstt9D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nVvTiLyF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSKEPKod; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nVvTiLyF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSKEPKod"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BF5D51D0010E;
	Fri, 18 Jul 2025 19:15:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 18 Jul 2025 19:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752880558; x=1752966958; bh=5GdSUyjqqR
	tzRBdVTH4pHznhAKdj3X9oVH5fLGkd7WA=; b=nVvTiLyFymglyQRDWrOxoEamZL
	t8krBiP68rfDcsA+LYV+Nccr1JDI0241pdOGTvx2UqXS1sO5ONLbG+DypmWq+hbn
	jXYfJNpp4a+v6O6RUxm+igSgEpfxggBXhPoPDodIUeDu4wqepQlRLdIDWXpF8e8o
	UWVsTUkAU6whNZKRRG1+GCUHUUyJGeDkW/G+pCLDTXptW+tG8+wL1/XQvMMKiO5f
	9DBnWZryRGxBFZTT3RipCaYWIqs8M20+p3W9AgBqBuSSog8Ye7GL6nMVFd8hMt4o
	SGJOaWWt4u4z4tzY8AwWHUiAQqQFq1dcB/paE4LVhb1HaASfKNsTosNeXYEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752880558; x=1752966958; bh=5GdSUyjqqRtzRBdVTH4pHznhAKdj3X9oVH5
	fLGkd7WA=; b=nSKEPKod9y4T6yZ8B0Aaqu6xowG/h43Niu8LYEdK4PDl/EmgpP3
	DNmM6pAefslIsrb5x8QA1nilwoSNJelZwckCNaLs3q+BLSURXrqwd2Ax4hIvSBBb
	mj3Ios7nPOBB/euUkTljCaw9AGJdk9SSlSK3NnlfxG1sIrIfqpck+FIDVVYsLhRy
	z8rThfyx1kDxMyYKTKTdpXKYrHZ6ocbbiR0alaiqLI6X0gd3HV+3xQSSdqXV/znv
	ps3ESDl3N9JUBlImngabVesK6Dzt29rBTDNaZFJanhJOgr4QEcfcsGpcAlKQ5sTm
	KsR0RsJ0S7lFrXTaHjXeQ0d6RYcnirc0mcQ==
X-ME-Sender: <xms:rtV6aHPGVkdS3GWep_0RgOfMSYMK5EjlatvAZKyP1lMfDJhKnd0Cjw>
    <xme:rtV6aFPZvzaaOoJUQJRENYo3eNvwKFt1O9ASjzCG1HftvfRc8BsMt5PEzz4CS7GzG
    qDqSEkPYEOQQG5Nog>
X-ME-Received: <xmr:rtV6aPudPug0_AiDHTDdouuldkvVZrtiUYiJrtbzSI8h5NNSNI_SF3BCLyjLZoG3z9HLmghlR2zwPe7HRcnrvuJ9vHdtMruIcYnXqno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrih
    gtfhhrvgguvghrihgtkhhsohhnieeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:rtV6aHVBXtyBJGhRCpr2FwmFkaI-Gg1rqnYEnhUQLIDMPblZUjGLHQ>
    <xmx:rtV6aPt9XlvEcCjdABwbqMk4kJJRC6_yXbQ90yTJkJmg0Kkzw3nRGw>
    <xmx:rtV6aLUvogfXPyMKCRlc-N1XE3TFHt4GOyMHqygqxNYur62TAUKFug>
    <xmx:rtV6aKmu9UqfROENNDL34YZfS2h8smEnkPLYtngPCwtT0I0a3z7BGA>
    <xmx:rtV6aJ0TD9E5PggpDftshO1tzUG0LZTrjuB85NaFXywC4byAzKDwSGn5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 19:15:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Frederickson <ericfrederickson68@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: A Question from a Hopeful Future Contributor
In-Reply-To: <87y0slp23s.fsf@arch.mail-host-address-is-not-set> (Eric
	Frederickson's message of "Fri, 18 Jul 2025 18:26:31 -0400")
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
Date: Fri, 18 Jul 2025 16:15:56 -0700
Message-ID: <xmqqecud145v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Frederickson <ericfrederickson68@gmail.com> writes:

> Looking through the repo for a place to find todo items, I naturally stumbled
> upon the TODO file in the origin/todo branch,...

Please disregard that file (I should remove it from the repository,
too).  It is not curated at all, and the last update to it is more
than 13 years ago.

>> * "git status" on intent-to-add index entries (say "I" in the first
>>   column instead of "A" for short status, add "(needs 'git add')" at the
>>   end of "new file: $path " in long status).
>
> I am interpreting this todo message as meaning that the following behavior
> should be implemented:

I think that was done long time ago.  The entry may have been a wish-item
in April 2011, but not anymore.

Sorry for wasting your time.  A better sources of inspiration might
come from list archive searches for the past 3 year or so.

https://lore.kernel.org/git/?q=%22%23leftoverbit%22+d%3A20220718..

But even then, many itches have already been scratched.

As is often said, in open source, the easiest is to start scratching
your own itch ;-)

Thanks.
