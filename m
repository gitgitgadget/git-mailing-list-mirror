Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A517DA93
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042778; cv=none; b=pTxRlIqSd8F3nBWIVTAJ9dzkx7/U4kNCwA+ILIN5yl+SsXVlv170BoiFFw3kMZBuqsAYtCxYx4iWAOT7RS1sHJ2ahFHIHE9CMiUg8n90DUg2HaPeMOw/3qb3EGbkVSkmPh9uHatPnaAOWdzeDTIaDn+VYDDCcADUa425+nA6AL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042778; c=relaxed/simple;
	bh=1PrcWp68uVG7KF+lmZUJsKom9TLVZ4tApg85oYQ5x6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTGiowAPbXiGWjYAyRNCg/UZC1caaMSxSP0YRLRSvSAJip39WhbsgbFc1qkFbKHe80BFfwLW4vKe+RmnZvWuE86kqjE3qTk5liOGBUlI3rW13ErQPP0PInAF0g1g1TF4nQ981xnVAsKJgYwTPYS0n2hfDqQ0umTcB2Fo+eHjNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDNZ25Z5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nqn/6ATj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDNZ25Z5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqn/6ATj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 42C4D114012C;
	Mon, 12 May 2025 05:39:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 05:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747042775;
	 x=1747129175; bh=WTUvXcIpHIbjNxjVMcrURM+si7UtZN5FtcHsk15ugXA=; b=
	RDNZ25Z5c10YAsVQ+xKJJ3OnnjGIilmTxooqO1H+FUVklYhF2EkpOlokvQzmRiLb
	Yylk/9Wtt068ZGBJW5JrxAkUh/WpHeNp6vubSQ7YX3hUoc1vFCK6vDyC7nySTVfP
	qsy6SSwNA8ykHgeR8lRQDZkh3cmPHxh8UtnmKNFB25wXzpVmmx+mwHONgLXd7bj1
	UI/Z52i3GU/lcR9tKElldz/wMrwBenk4sCPbXu0ww4sark/1jCfndMPkiBHWcJ6r
	Nl2ctCA0mDecCtZVxqDt9cpFr48sJGF5qENHrBEtI3B4DAzGIfHbewVOh2pKyDJN
	u0VBp/zAFMqgrvru+gC3pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747042775; x=
	1747129175; bh=WTUvXcIpHIbjNxjVMcrURM+si7UtZN5FtcHsk15ugXA=; b=n
	qn/6ATjvxI4mNTdrv4JRkg9IuktBuX+q16Dx3aVdjaKC6xmJxVuSlr34EIqD6rUy
	sjT1Z8vSsOM6aAE9SWOqXr0KTbSvYnPCbQLY3WKzJm9OW24yGJI0JuINrMvyJmAC
	xttIn0GMSjvK0hzm1InNImrz3F0unim6S1nqe6bJeq1lunu9hoQpypI2nMOj/HEW
	+9MvyaGdLs9d1jNBhULusbvgqQWtnIqWNIZ024AOjJzBHJI605eb/Bz1+WsNIqR7
	acIdD7Tafuoci8FhUZyqNJGSyxC8Lvz5y/WL49xHDg/igjd3K+xPkdu5PIQGdKPW
	rZd8XsOvB8a7B6V5CNgvg==
X-ME-Sender: <xms:1sEhaGVfM3oQTz709WAhQnSJFg6DCSZd71QDdGv7aXIbv0d1gxFTFQ>
    <xme:1sEhaCl4pv5lTgULUtOo_1b_kHcZKh3Pebh4-bwChSQKVIliSHYoALUWW1WU4vfR8
    9qNjtc4Rb4QQ7LRHw>
X-ME-Received: <xmr:1sEhaKZXAkg1xf9Kxk97RbJz2c4ZKLbn04z_fipdGP7NQAhGs8Ic-yldstbJMfyooZaSGCzxfBeLgYbZxQqAYmA6Fo_NHyHlhqXRz_PLnI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfh
    hrpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:18EhaNXhqcnyW4k7xO1lbgtqTwSyJxP7vyaa5lht5mRsD7RZtbRK0g>
    <xmx:18EhaAlK2qDstcAVNWSyGo2iTdxjjokyN8SJa-FcU0r_uT7AjXLawA>
    <xmx:18EhaCc4qCrkfhw5dN6vCNDKpPEnCyOAFJzy_axvifuyXLX_s7hJ1g>
    <xmx:18EhaCGEpFSVy7Wvpd-oXB0uGlD7lU9GF5Tc4-BO16Jt_542o9Daeg>
    <xmx:18EhaHmJNEeQ6WyK_hG4qBLA6tTfM4wsuyDr0XGTveiTllzW0lL1OstC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:39:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acdb04d3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:39:32 +0000 (UTC)
Date: Mon, 12 May 2025 11:39:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Matthieu Moy <git@matthieu-moy.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 00/11] Spring cleanup of "contrib/"
Message-ID: <aCHB08edPcxWCMiP@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
 <CABPp-BFYuYnbHG9uUOig8gpqrLywESf6fs62e_CMi2uCtNXYYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFYuYnbHG9uUOig8gpqrLywESf6fs62e_CMi2uCtNXYYw@mail.gmail.com>

On Fri, May 09, 2025 at 04:53:54PM -0700, Elijah Newren wrote:
> On Fri, May 9, 2025 at 2:20 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > as I have lamented multiple times multiple times already (e.g. [1]), the
> > "contrib/" directory is a bit of a mess containing many bits and pieces
> > that just sit there gathering dust, without getting any maintenance and
> > sometimes even in a clearly-broken state. So I decided to finally bite
> > the bullet and do a spring cleanup of "contrib/", which resulted in this
> > patch series here.
> >
> > I have used the following reasons for removal:
> >
> >   - The tool is clearly broken, e.g. it doesn't even compile.
> >
> >   - The tool hasn't received any updates for at least the last 5 years.
> >
> >   - The tool has a clear alternative or just isn't useful anymore.
> 
> Do we still want to use your second reason listed as a reason to
> remove?  Junio brought that up on v1, and it bothers me a bit too.
> Now, if you couple that with "contrib is meant as staging and projects
> should graduate or be removed", then I'd be fine with it, but you said
> later in this cover letter that you were going to post that
> information in a follow-up series.  That makes me wonder whether the
> removal of tools for this reason should be deferred to that later
> series where that new direction is recorded.

The only part that I would count into the category is parts of commit
11, and I'd be okay with dropping it for now.

> That all said, I tried to do a count of which patches used which
> rationale (though I split out a fourth because it makes more sense to
> me that way).  I see:
> 
>   - broken tool: patches 1, 7
>   - not updated: patches 4, part of 11
>   - better alternative: patches 1, 3, 5, 6, 8, 9, 10, part of 11
>   - already removed with just a stub left behind: patches 2, 3
> 
> (Here I excluded patches from the "not updated" category if there was
> also an additional rationale given in the commit message.  For other
> rationales, I put the patch under each category that was brought up as
> a reason for retirement.)
> 
> So this series doesn't rely solely on the "not updated" rationale very
> much.  Even in patch 4 you allude to the fact that you _suspect_ that
> tool also falls under the "broken tool" category, and in patch 11, you
> also argue that it should be handled differently if it's useful (which
> rhymes with saying that a better alternative exists, but isn't the
> same since one doesn't necessarily exist yet).

Yeah, I wouldn't categorize patch 4 into the "not updated" category.
It's the ecosystem it depends on that hasn't been updated, which isn't
quite the same.

> Anyway, I like the series, I'm just a little uncomfortable with this
> part of the cover letter and the wording of some of the commit
> messages.  "not updated in 5 years" is good supplemental information,
> but I think other git contributors reading those commit messages might
> get the wrong idea and apply it elsewhere.

Okay, I'll try to rephrase both the cover letter and the indvidual
commit messages to make sufficiently clear that this is only used as
supporting evidence that something can be removed.

Patrick
