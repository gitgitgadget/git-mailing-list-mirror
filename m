Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8E253343
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731707; cv=none; b=evIeRhJkQGooa4ssNuM4SEPgS9xxyL0nC3yaqA+mJm/tuAlOWfULuUTF+qcMIV3/Y/ebWwUo+tPigcNGNlIPKTCtt/aYACrmBp5ZFBoqR60hVJCnrAiXMaSmwNPmCJHItvJAHnGCipb6lak5aJhFI9pYpicGI4H4uEsd/U68sGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731707; c=relaxed/simple;
	bh=0/7hbae4HOZYnTwmOfugPF0/wtqneP53nYSRKMs5MYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlfFKDqq4HO6RZxjXLvVfJSZRehyDHKGB0ZwrPD3RkrTMOq0xCAUxfi0XWH24IDpt4AVM8PC5ez2NTod6eGyyL0MZgU0vaG7LiiLO77molGrd4wx98IS5Rm6c/9d+xUdSh76PPya7hlN1+6goOviUqFQ9gdKgQa1m0sTFaE64Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tx6Tut7G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sjCaj5+x; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tx6Tut7G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sjCaj5+x"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9079411403E3;
	Fri, 28 Feb 2025 03:35:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 03:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740731704; x=1740818104; bh=ueMdjF/Lct
	pE+njJQobYMLYkCjDkZjAMaHVLRWltC/4=; b=Tx6Tut7GqtE9RCRhOjLj+ccc3i
	He8ue34ESSuqcUTckefmd9dSw6JRkYSUDZDTHGP/P203lwU1e53g4Y/mFGeIstXD
	1HudYy4vyPnu4GhUqXzxY7TL6FCDUQJ/hzSTUXEBAVtY9xhJfSwV0wOvQRvwSQff
	GkIQPhFrpH4BbeqSmMjNcz82tFjsDM9RnWQYO8AeSuI9cSlAVMg0f2wr9OVQkzsm
	zAeK7CV+KPUYrxwWokr9+eh11NL8TodlQ6n4OoGvxuPbJzfKz56g4kizcfBk0kJj
	PbnDliMjF+fQaaMrug+9dAh5onD6/hrEElIm1fF2vOZLnGChmbEZ6XO6f2zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740731704; x=1740818104; bh=ueMdjF/LctpE+njJQobYMLYkCjDkZjAMaHV
	LRWltC/4=; b=sjCaj5+xydDR+eI2wlHTJSipTyKznirW3U1pDtwwg6Ej47wiXOJ
	8ZohGBQ89ZPKEWFvdPmoCKZE0p31TFUEkkRUZ5IaoT8NSFyifcbdsWRYamRwkvbx
	eMGD8AGhvxXJ9T2aHUjnkniVODvJnH1a5HlwVf5hwvQkTw9oCC0+hu56w39cd6pe
	6As/o4UnJurCn7JX5i070EEyaxaIXslSZB5U34DEZVRX7q18F4L5MT33CuV7nKuX
	zouCRsCpeKWnyPfw34Jocb233Q3ajizIKhMESsE1sUFINHyzlllV6T0QXHhUrEUp
	qiHV/KADcRCzDhbs4UAkbzDZSlP8dBvACfg==
X-ME-Sender: <xms:OHXBZ3mHtGr9N1fxXeFgfkdd94ui4EKwfXfaf7XbOz--3zgvkXaydA>
    <xme:OHXBZ62AFroxeJaln006ObQT-tBKzHVu6Hj5_CXgQ0R-7rO1kETrsb_sHnEyXUY0C
    vtEtfvmVtY4aBRtiQ>
X-ME-Received: <xmr:OHXBZ9qPDBAD2bIxRJDyz8CU3AUbUj0uPCYZ7t8Txfwf4u-Z2PZ7484JqDY2Kzxt4AO0IcjXRo0w7emb5jluDG_QlYYJBFN7gYHXd2xa3Z2Omela>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopedvtddvheesuhigphdruggv
X-ME-Proxy: <xmx:OHXBZ_mHcgwvXXg8RhXPpdQQGEskwg9617CazYOlwtF12woLNPEF5g>
    <xmx:OHXBZ11fvbaWwaOy11xzHf5KDz28vHvMxiFg8JwonKnMMEygtcLx2A>
    <xmx:OHXBZ-vE8QJj53R07pbq4nVobi8aZbnEWsKhm7NenAYEMEcpMQYehw>
    <xmx:OHXBZ5WLHT18RpQRi2JWIGS7DLvjwiYDmFlNlIWThG7R3pCLMHz3Xg>
    <xmx:OHXBZwQY-0b1XNiQ4qRF3kpSD3e9JtxR1aXAauB451JwQ1DQ7e3TnQJv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 03:35:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c00f2884 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 08:35:01 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:35:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Markus Gerstel <2025@uxp.de>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
Message-ID: <Z8F1NDvWgx1S3eze@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <xmqqikow9o5d.fsf@gitster.g>
 <Z8Auzjw29t91tEuq@pks.im>
 <xmqq8qpr9v9e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qpr9v9e.fsf@gitster.g>

On Thu, Feb 27, 2025 at 09:01:49AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Feb 26, 2025 at 05:23:10PM -0800, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> 
> >> > this patch series introduces a new "reflog-expire" task to
> >> > git-maintenance(1). This task is designed to plug a gap when the "gc"
> >> > task is disabled, as there is no way to expire reflog entries in that
> >> > case.
> >> 
> >> I think in the longer run, "maintenance" users should be able to
> >> treat the single ball of wax "gc" task as a mere short-hand to
> >> invoke a set of often used maintenance tasks, and we would want to
> >> break down the component tasks grouped in it and make them
> >> independently available.  This is a good step along that journey.
> >> 
> >> Are there other things that the "gc" task covers that are not
> >> available elsewhere?  "git gc --help" suggests there are things
> >> related to pruning (unused?) worktrees and stale rerere database
> >> entries.
> >
> > These are more gaps indeed. I'm happy to work on them once this patch
> > series has landed. I don't know about any other gaps.
> 
> Or maybe leave breadcrumbs and invite others to help advance the
> cause?  If we know we have achieved consensus that it is a good
> direction to go in, that is (we already saw a mention that indicates
> that there are populations of us who do not care too much about
> extending maintenance but are familiar with gc).

Oh, sure, I wouldn't mind at all if somebody else picked this up. The
question to me is where to leave the breadcrumb, other than having it in
this thread.

Patrick
