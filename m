Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE317AE1D
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747151; cv=none; b=LmL5/FC/+UR9Dv1NkZ+zfpiy91B54piZrXTfpYV5+oyxnW0r8nWgE0kJK/fN6hQmht6hyCBcyVk7i8Bk7TC0W8P0tII6QjWeZWTgaFFzDHJl79nT7PNcNw2g5tOvGx350L12g6ExqZ+CQxyiHv8MkxYaJ8cxvnvN46Tl+Dwmq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747151; c=relaxed/simple;
	bh=QUl1IJ1iK6tdHbKWrEOyXZqDMLGuI4u7QlWwDKJY4EA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTwYgsTq3eutLcThiFWzIK56iCAeePkGXLp0iG7fJ9WyV4p/usZGSI4SiNWDLtUK10vlpRtVhGv/d3jMqlTiXAOP4F0+f3EDud5/+Wccpa5FNMtt3oICidlu/rlbgFEpXEJXz1c1nZB2LyfTnMmjgqY04c6XJXu8F89H7nvBvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JIVtK9Ag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSlCikQE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JIVtK9Ag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSlCikQE"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BDC6D138059E;
	Thu, 12 Jun 2025 12:52:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Jun 2025 12:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749747147; x=1749833547; bh=Dkl4wln8bS
	Vca7ejAD0XjakDZr9TdK4t85072sX5mLo=; b=JIVtK9AgL+2Oi3AEdv7YnMLLuK
	PGtNH+L9AVYEngob9iAiUG6Pykjtf9DC22uAT2GGCveRPgg3KEuZatBGcMn74cs2
	wYuWj4wNxeSh1pSIH+qd5qJZ8SnjMok2cRnk/FS0g+lBdFRCxRhAceKpVq0yoaUG
	vJp53JgeHh/EBIlEPzK+vH/P1KWai9YoQMgLkgHCdB4HUEYG6nnhPGvyo8iMBcEJ
	d98odBeXjAoFNRGIBA/WI8aGFEdVva0qkoVZRaWM0TMRQmNWWaHYoi9Tho8vSsnh
	cXGnCdH4EMXJrsRRgtNZHh6aDt9M4/xhy3MpAid7s2P8bVrhr99gOp/Mq2Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749747147; x=1749833547; bh=Dkl4wln8bSVca7ejAD0XjakDZr9TdK4t850
	72sX5mLo=; b=fSlCikQEQZY98v23Gec7iD2KyywlWbzX301Nrz/XmUjT1tCgqXt
	ocVc68XnVg6wJZc1g8J61wPcdNmkLcihl6Ts2KIXovm0JJbAmTZU11R/Rrg7EHcy
	GEv/MsQuEEr8NVPzuTo5/+07A3y0FCDjxV99rl1Q2QCr+d4QyTaQMEhLNG9pjgNj
	xp0US/oe59X0/ejQEQD1M+7yjW6+uwU57gh3hQ6yPSBwHEUYQKJoAIq4ALMBfYBi
	o3DIp5vMTW76DHmceXVa0Zaaj1DcK9z+/Ezkrzd16kFYV8eyMDwLuNlmO3M1YZlX
	o9f9DnanldoYMPTXfPgS6AFG3oEAJcIvBRw==
X-ME-Sender: <xms:ywVLaHF7wo_O3xVskciVYKwyj-Otb_kxDe96zjCoFnadNCBjpO676w>
    <xme:ywVLaEUx2AJyMsEf7aLqKQwOKiTumE7UlXDgLtEEblyRQ0MC4ebikBBOJA2entc3Z
    NENRp1xAo57L5KvoA>
X-ME-Received: <xmr:ywVLaJJQTat-6G1LXpKJij0lndO82n7EEJlTGaRw-kYyyoRS9WLvm8EYCw79j21nMkOm2Eo5eTmgxtD0jXr-wCEcEXbZbtmRwtwx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedvudeiffejudehffehudduleegffejuedt
    teefuddttdetkeetvddtkeeludffkeenucffohhmrghinhepfhhrvggvsghsugdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepsghrrggusegtohhmshhthihlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:ywVLaFHmyY0d3Y5kN2msoeJ2gSvaosP4JsbivaPY7hMYcljhHVwjmA>
    <xmx:ywVLaNWa05DDdG4ZG_Ja-iRXViwu8p0QpZbq4XChowW1Z6Ypf7NjAQ>
    <xmx:ywVLaAPndrrbdAQ_eRk3aeRcvRajd_cvIpy_2ZJgFt9hDQuRZt7Xvw>
    <xmx:ywVLaM2fjjuxvrUeAjeO6H9QhPDVt7Sun0tCLk7kx3C6-m8tvxBr7Q>
    <xmx:ywVLaD6v23sP4ieT8YHDujQhpTt8Gx_y7_GzE97FatZ_XgUIQSZQKc5g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 12:52:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Arenas <carenas@gmail.com>
Cc: Brad Smith <brad@comstyle.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] config.mak.uname: update settings for FreeBSD
In-Reply-To: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
	(Carlo Arenas's message of "Thu, 12 Jun 2025 06:52:03 -0700")
References: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
Date: Thu, 12 Jun 2025 09:52:25 -0700
Message-ID: <xmqqy0twewc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlo Arenas <carenas@gmail.com> writes:

> On Thu, Jun 12, 2025 at 12:36:46AM -0800, Brad Smith wrote:
>>
>> FreeBSD 6.0 has memmem().
>
> but AFAIK it was buggy, uncompatible with the "standard" and
> didn't perform that well, at least until FreeBSD 12.

Declaring that we will not support anything older than 12, which was
from Dec 2018, feels a bit too harsh, so conditional to check if we
are at or above 12 is needed instead?

Documentation/technical/platform-support.adoc is probably a good
place to start a discussion.

 * It spells out Minimum Requirements which includes C99 at the
   minimum, which in turn disqualifies really ancient ones and ones
   perhaps before FreeBSD 7 (which had GCC 4)?

 * It also requires the platform has active security support.  If I
   trust https://www.freebsd.org/security/#sup page, it means
   anything older than 13.4-RELEASE are EoL already.

 * The document has a space at the end that is intended to list
   contacts for ports on platforms, but currently it is not very
   actively used.  Should we extend it to include various flavours
   of BSDs and other systems, and start listing the minimum
   supported versions as well?

Stepping back a bit, do we already have some mechanism to say "hey
you seem to be on FreeBSD but you are at release N that is way older
than the minimum version X we support" and stop the build?  If we
do, we should tell that mechanism about our decision in a patch like
this.

If we don't, I wonder if we want to have such a mechanism?  I am
personally undecided.  It would help those "casual" users and
builders who do not get their hands dirty at all (aka "I'll build
only from the official release tarballs") if we did so when they try
to build on something we know will not work well, especially if it
is kept up to date relative to what the platform-support document
lists.  But at the same time, those who do not mind fixing and
extending to make it work on out-of-support systems will be
inconvenienced with one more roadblock to dismantle before
proceeding.

Thoughts?
