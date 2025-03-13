Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB114D29B
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884925; cv=none; b=id9PmpAhQ29KQo/TBgvUvIjsBmR9XyfAraSnj6sGFzHeYpWm9GLA7FhM7HdA3UMdYLrpiqjdya0zYPEGfhLROe7xDaayOqMP1b3AaO1smnmIKlHzL8KTVJFTENfd8xUsVhpCbjqqtR6J+ojF/IsOsD5OymPOVEI7AHFfmD+vZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884925; c=relaxed/simple;
	bh=4fWtcWY450r7g2pb+Ww9Gn+SaQK+K3fIfFGl/rBtrew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HikW+qeimkq6ttJtmIdIwFN1pOhdQz5LDGgrZaui5NcsKW1FgUKF6LAaBUyRUM97ccwQNqV3rnQ4JdsQ7sw+cYR62PZOj4+EmR1MYj8j8qdpH/ROdu7OHOFiFXg6ygH3AABZMbmQZMpB1D+uwMfcqvSDnbCIN++qFNQX3bntul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aNMVnZB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MK05uhDz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aNMVnZB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MK05uhDz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89045114020B;
	Thu, 13 Mar 2025 12:55:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 13 Mar 2025 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741884922;
	 x=1741971322; bh=5+gci14SZlKySF6gQT4kT9rqD5zWmCvjL8jyynlwQGM=; b=
	aNMVnZB/J5txketP0rxKc/oC9wZI1lDCI9n54GGNtu56XPie2ffPjjRLQjU4zczb
	rqXPmslHfFiMVpzrdWrov0fCldT8wWZHVd0tcuRpYDIHNsWOSov72sf5cij+dK8O
	o4TYDKKP7+6BDFnqyfKl8K+BDcHD5was1Hsu1FM6owIQ0m6axqjSkAfHrXU1ZhUN
	5unuufgBSJWbQ9lycQN9AuX7ltSlC0P7JTMNrmWy8yPD3CG3pUjrHCgv/fjAlqLt
	wN5eTY7o9o7Y9XZlM08uZz8zqUQQq/RkX4TwA0RPhNHi2oOgHYKLBXLT3bmzhRBL
	q6r2P5f2/eW8be6wU0KxGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741884922; x=
	1741971322; bh=5+gci14SZlKySF6gQT4kT9rqD5zWmCvjL8jyynlwQGM=; b=M
	K05uhDzfA1UrsPwEbGWNSm9yZxhDV7SCmm2YYqzqAmw+m/ZrFhEglG3m1qxNDE7p
	iMI/mkcCueyK42vpFlHmpikX62Mb6wJKxeybfu47rASQOlV63xs/CYt0LOXEgX0Y
	+/BKjv8JwHmBZcYLNojkJgwUcl3CAMy9GjhdbB/3j88sc9wUvYINndw7tpRNO6WP
	PNDs2G4mx3Nibp63e+ZbWrP6bT+WVLO7BoYieygNuawx6OKGGviULNzKURhMG8nG
	L+mi9zV9ySSPQ+QzZzfL3BM68I3kM9uDWo9X5vw6BZcDJLA+pXgBltt+y5C6fpDU
	WBtm6HEYKjQtpqx3MuA1Q==
X-ME-Sender: <xms:-g3TZwsqMIZdK6eAZQDGNNcUJykgzSLG1ul_DW4wmmchFzqeyZZnBQ>
    <xme:-g3TZ9fkYfz3Iy3E3XPtXV6gpo_jMrWd9DhHuo9TikX-aDx3bj7mmirSWshfEytus
    LTVKdqkhTNa6YfMcA>
X-ME-Received: <xmr:-g3TZ7zx28h2fI_4cLaesn_QfAYloQIJdqILvsM2kmyOZbgzOD76LHl69NkGBf6HLBoCTiyjthlXhi54YjwUefp8NVPv4xDzCIbbNzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegughhonhgthhgr
    rhhovhesuhhsvghrshdrshhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:-g3TZzNBCEc5KPNCIFUMXZZUYIivWpcEZ7TlQDz8lBH67ExSbXCxYg>
    <xmx:-g3TZw9ZXzrJsFTuZ-PfTHcgmY9r0i_4l0PoBJ1bz7ThVrXxYGts1w>
    <xmx:-g3TZ7UBVyFXboGcL8OQO4ItN5juC1LWWEoSvYVNMM9olDMn4WYolw>
    <xmx:-g3TZ5fpDVmI7JkWq9VhO33Ft0VWm4nU1Gto2RtSrxSmfBD5HtJIZA>
    <xmx:-g3TZwwo-Ep3uUKoiirXPBpWw12rNi8Sv276kBKvsQ7aWdJq_TdlPFiX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 12:55:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Dmitry Goncharov
 <dgoncharov@users.sf.net>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for
 rename-to-self
In-Reply-To: <CABPp-BF7iTvqKFvuOZ5wZ3vZADjCvB63iKR-4D5+WeTxnZGThg@mail.gmail.com>
	(Elijah Newren's message of "Wed, 12 Mar 2025 23:22:56 -0700")
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
	<f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
	<Z9ID/2zx25qesuJs@nand.local>
	<CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
	<xmqqr031x2gg.fsf@gitster.g>
	<CABPp-BF7iTvqKFvuOZ5wZ3vZADjCvB63iKR-4D5+WeTxnZGThg@mail.gmail.com>
Date: Thu, 13 Mar 2025 09:55:20 -0700
Message-ID: <xmqqbju4q39j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Wed, Mar 12, 2025 at 4:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > But it might be worth mentioning that having side-effects in
>> > assertions is a huge no-no, and I understand that when folks have to
>> > debug one of those (I had to in a separate project years ago which was
>> > kind of nasty), that they sometimes jump to the conclusion that
>> > assertions are bad.
>>
>> Yes, assert() invites such mistakes.  Why not avoid them when there
>> are better alternatives like "if (condition) BUG()"?
>
> I mean, I just gave my reasons above which you snipped out.  But if
> you feel it is important for folks to move away from assert(), would
> you like to see someone create a better alternative to assert, such as
> BUG_ON(condition), so that they have reason to want to switch?

You said "BUG_ON()" is better than "if (condition) BUG()", but I do
not see a reason why.  It also shares the same problem with assert()
if we make it honor NDEBUG.

Thanks.
