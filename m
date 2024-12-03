Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174926FC3
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733203988; cv=none; b=clqn9StPfZUcsHjg3SPsEHwT1Ympo31CQuviTp6bQ9bsWmceABd7AE8k/izL9HaF+sdp2vRzbAoiKUTTWJfnPEKlVlcgNG6Is7//XPhGJap9onWP4THg9xhZuqdSV9bl6j9NP0FkR8k2DJ5yOmH+Ep5VaywR/roV8NQ32KjVkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733203988; c=relaxed/simple;
	bh=N8/kc48L5+mcwa3Ddpbe6Hf00vc+ocbQfBK5vcMily0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NuqEVEL0xhspymZPlOtwgrxhnmkkRsgXN8mMmf1zM4CajNbAltgL4srhTdUL8sf8Q2V1SPGgvIdkgyEYGAsvvFzp1zGebPWu3lx3ovU521WP/BO8QQNyV9DwYHDWn0o6JnypeFRnRLWhm+eSPLcVhww5uHn3G8hGRd7ReGGfeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iy2N9FT/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iy2N9FT/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id CFE2C114016C;
	Tue,  3 Dec 2024 00:33:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 03 Dec 2024 00:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733203984; x=1733290384; bh=WYzwniXy1WuQGYvg2c1OqfEZK18A0MdKXLW
	mNY9OIEc=; b=iy2N9FT/LgPJRalioWAUEqESnNbbKk17SlN1Oxm5f+2nbjSHfs5
	tYi1zWyfFmHnTM8VXKsuDfiHXoLjMNoJ0RnZNczSr+Y78AQlc95aKA4u2374Fza+
	ORTHaj+wVR87xVJMmPnq9egnfd0AtSWfq9ScLbee6QpsfQJ5gAGMKbXX1rCJUzaq
	G6KFUy9fKfk9YOshqa935s/IT46DeYY+knW9N1ekNGIFmQqMGNzQ7qOlF1QB9gLf
	g23+8bQ7GqynRd1bleIs4FuOVdbcKXDa+crXMeTWmojondeenLAaQWWIBdjNxaGv
	3+IERM8Av4gNXJR1h3WHo+wjZT9VckLZHrw==
X-ME-Sender: <xms:EJhOZ1I3LMt16pvcGwg7ez2iFtT2AZ1uLcmdwjusPh_Nbm0NENcheQ>
    <xme:EJhOZxJWFZ_YrXXmteVMo2RAfQX_ylCF9lZogwG3oEuuowZXWha5_GGoG4kuP8o64
    lwZIH6RKGGArJWYjA>
X-ME-Received: <xmr:EJhOZ9spYtNhHfwEL0FYB66r7zUbDCpLhrG9j92mJMA7cMkcB-Wv7PzItVSHzrgOlLi0oiDP8smal_T0DkdSCE7kCt5-uj8fiG33p7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohephiehtgeglhefsehprhhothhonhdrmhgvpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EJhOZ2YALvdSvTv8mbWTt3hk6rpkeRsqpguoNdgR5KilnfzhDPB5fw>
    <xmx:EJhOZ8aTPaFTpRmVOMl0jd9zn5LO-pYQNcIzFywjinxdW3IQs11Yrg>
    <xmx:EJhOZ6Bramk0Q5e28jpswItWhc9j1YH26hiqRllvgl3eZTzVrCS-4w>
    <xmx:EJhOZ6YkH-kEEJyhymXUbzHFOa2G0fNeAIJNymgV_Oo2o3sE6m6Bzg>
    <xmx:EJhOZxMVPms2kTcvMN2w-5ej827ccq_n5bF7Nf8AHfgY_BWwbVhZh5Jm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 00:33:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, Philip Yung <y5c4l3@proton.me>
Cc: Taylor Blau <me@ttaylorr.com>,  Y5 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
In-Reply-To: <20241125113105.GA1070162@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 25 Nov 2024 06:31:05 -0500")
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
	<20241019211938.GA589728@coredump.intra.peff.net>
	<UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
	<20241021190045.GB1219228@coredump.intra.peff.net>
	<ZxatqdBiB+NoMP+j@nand.local> <xmqq34jpl5sl.fsf@gitster.g>
	<20241125113105.GA1070162@coredump.intra.peff.net>
Date: Tue, 03 Dec 2024 14:33:02 +0900
Message-ID: <xmqqo71tcovl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Nov 18, 2024 at 09:55:06AM +0900, Junio C Hamano wrote:
>
>> Taylor Blau <me@ttaylorr.com> writes:
>> 
>> >> You'd need to identify all of the possible diff code paths in order to
>> >> add tests for them, which is the same thing you had to do to fix the
>> >> code paths. I was mostly just commenting that we're not likely to be
>> >> able to rely on existing tests to help us here.
>> >>
>> >> It might be worth adding a test that shows off your improved diff
>> >> behavior, though I would be OK if it was a representative command and
>> >> not exhaustive. I think adding to t7006 should be fine.
>> >
>> > Agreed.
>> 
>> It seems that this topic is waiting for a reroll?
>
> I think we could go either way. I outlined a few further possible steps,
> but there is no need to hold up this first step. The only question is
> whether or not to add a single test to show off and protect the
> improvement.

Hmph, a few messages upthread
<UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
(Ugh, why do some MUAs or mail providers use such an overly long
message ID, Yuck) was where I got the impression that we were
waiting for a reroll.

I am not all that convinced that sprinkling setup_diff_pager() call
all over the place is a good idea from longer-term maintainability's
sake to begin with, by the way.  What problem are we really solving?
Folks who run "git diff --no-such-option" see "behaviour inconsistency"?
All I see is "error: invalid option: --invalid" followed by a help message,
which is quite expected.

So, I donno.

Thanks.
