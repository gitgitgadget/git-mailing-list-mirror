Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA417C219
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685911; cv=none; b=RxT1c6RmXEaGPej6EgugFAqyq1QJevHmHDuBLhsxIJu1xe/Qpt87eF997wQOd8MPEajl10NlGumqxJ0sz2FOASBlz5y+4Ub4TejiDKnTLjD/8D5yAnArgjGLEovQ148N/Je1R0b7GP8DztcdsRSM6H7p0D4nd/+Nu2OOlukK8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685911; c=relaxed/simple;
	bh=lt7e+sPcZ0BgJPexKMq5VNtTT0Z24Ft7dTgZvxtiQgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAQqAe90ZP5vosnEio/VnDUhTSnJRBCfUS5/tSpNa3OXegeHEUk3P9JfSW48U40A7/5fEI8C8/PtPIVvhV70+lz69WaMRMD1L48tHJcUXemjoJy1C5IUVW0ed2tAZe+0bZjCuJnCHJTTv3ZvsqTD2xLu4dtC8dqx6rl3GyndVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fNu32fIG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRq/rgYp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fNu32fIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRq/rgYp"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7925F13805C5;
	Mon, 30 Sep 2024 04:45:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 04:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727685908; x=1727772308; bh=ysVstqVHxM
	kFKzgX3vWS2d8cUYFrz/V3+sht+JqYRbI=; b=fNu32fIGa2RLAx/9TiQw4CE41I
	tMGkxEfeyzhFRMdwXdANHovgz9Cr2BDX2a8M3MbKC4BeVSegn4BU7MGi5rehObLj
	YaBefBxsuqzXnNGYir481hxUK031Wz9HVIb4L5PCz+7ZhTV/4nXdC1tMtFWw73/1
	ylMNdVU0LcBEzy9LgBYabr7GpjYunEOVX21X3cYMo1GNdT4O4q6EFIj6n9cTN5RG
	KQsX9dGTZ5BhR4/mmpJx/BtGD+B75y2ud3jG0wkOr3eXaHQHJ5HbcIJIGzcKSYzB
	2If2KvkrEFZWsOraylnSi+2bKgwNUzdGDoOXbOIWCp2z51Eg2SkaNSEXpFsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727685908; x=1727772308; bh=ysVstqVHxMkFKzgX3vWS2d8cUYFr
	z/V3+sht+JqYRbI=; b=PRq/rgYpSA7YYb4zOYhwy0Wc/bVI5+CgxRIJ48E/G1e6
	ow2pvUTDCn8up1D12BzFhWgUWBqFkEhKPUJMRQgKx1oZW6VuQ89/bkH3LvK2qBXh
	8PL4nvYXF2/iR9lVLIY2JSyPSI4ktOpnwM+Nktr7MSByH8NLCJDhf/sjiDtKHx0D
	fKWR0zQw88+eg0Z4kyYBiAwhq8gVmIcVOq90YGIE3r3HDQZF05Tdhma275t3Ilqn
	Jyo1oLb27tuO0z3XA5IzxFeXaYUAjjFSbJK2j22s9zBS4rhEklF8Ko8OIk3KMEvC
	hbDxebFtpl4aP8s+LxrcY9NAq/pBrsRTPWIaFip6wQ==
X-ME-Sender: <xms:FGX6ZifRpsMvFT-K7gwUZBJkgznUrojpngK9fYnwzOatzybdL7qEYg>
    <xme:FGX6ZsMz2hfMjJaN_NE4RtTuZ7G0KFT2djEHslGrerw52wNujXp7miEMYmg_Nb70T
    i2W2e3zrogS5Q5mMg>
X-ME-Received: <xmr:FGX6ZjiUjfvN3VvMOB78A9enIDL-hXOYCb7l8khe5-6A2-5xXf3xrK9UoUvRLBI3p3pjea1Qkh21kXR3UsnNAaD6nCe00w0pH2jXYNUf8DbY1ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:FGX6Zv_X9ca85JnTVMIMyP6AL9pnEfqBCuw4WZvqjy--PpwVF6T9sg>
    <xmx:FGX6ZuvVExTkia9kaKheazl15U7UNWzaDcyvRws8FmiZOAyVUJZCLA>
    <xmx:FGX6ZmHTLd4MZ6Cy9oyoSe75IBgk6mur8N5oihoFB0eIhF8BHdlfug>
    <xmx:FGX6ZtO3dTM9WAgc8T1uBvIY_BlmIFvvOzDp5iXzgL_HzYS8Nl2WgQ>
    <xmx:FGX6Zn6VLYV3XHVkIs_yctYFliEFZ_WvcdiM8XsLesleGf6JwXT4LKVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:45:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d30f988 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:44:20 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:45:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] deprecating core.preferSymlinkRefs
Message-ID: <ZvplBAl5DrcX-Q3u@pks.im>
References: <20240918232825.2627999-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918232825.2627999-1-gitster@pobox.com>

On Wed, Sep 18, 2024 at 04:28:21PM -0700, Junio C Hamano wrote:
> Removal of support for core.preferSymlinkRefs at Git 3.0 boundary,
> so that we only write textual symrefs for things like HEAD and
> refs/remotes/origin/HEAD, and still understand symbolic links used
> as symrefs in existing repositories, is a serious proposal this
> patch series makes.

I probably don't have have to say that I fully support dropping support
for the writing side of this :) I was also recently reminded that we
still have ".git/branches", which I'd very much like to drop support for
with Git 3.0, too. I'll send a separate patch series for that soonish.

> But at the same time, this is an RFC.  I wrote it to serve as a
> candidate for BCP, a guide to those who want to add an entry to the
> breaking changes document.  I think anything that is described in
> the breaking changes document has to become a patch series that
> spans multi-year effort, and that must be done with care.
> 
>  - The proposal phase.  A breaking change is outlined, transition
>    plan is given, and the first step of the transition (often,
>    starting to give a warning and offering an alternative to the
>    feature planned to be removed are involved) is presented.  The
>    aim is that after N years, the user base will be aware of the
>    upcoming removal and would already be prepared to be able to work
>    with Git 3.0 that lacks the removed feature.
> 
>    In this series, [Patch 1/4] does this.
> 
>  - The Git 3.0 phase.  A breaking change is actually implemented.
>    It optionally can offer help to those who procrastinated until
>    the last-minute to break them, but the feature itself is gone.
> 
>    In this series, [PATCH 2/4] and [Patch 3/4] do this.
> 
>  - Clean-up phase.  If the previous phase added an additional
>    transition help, after M years, such a help meant for transition
>    would be removed.
> 
>    In this series, [PATCH 4/4] does this.
> 
> What I want people to think about is how to ensure quality of the
> Git 3.0 phase.  We can iterate and polish the proposal phase with as
> much time as we want to spend, just like any new feature.  But Git
> 3.0 phase is with a solid deadline, and before that time, we cannot
> remove the feature for real.  Would we cook such steps in 'next'
> forever until the actual Git 3.0?  To those users who are running
> 'next' based Git, it would mean that some of the changes the
> breaking changes document listed would come a lot earlier to them.
> On the other hand, unless we somehow have a way to expose willing
> volunteers an early access to these "big changes", there is no way
> for them to be as stable and tested.  We should not plan to scramble
> and be able to perfect these changes between Git v3.0-rc0 and Git
> v3.0 final.
> 
> Or perhaps use the "experimental.*" configuration stored in the
> user's ~/.gitconfig to let users opt into Git 3.0 features (one of
> which may be that textual symrefs are always used regardless of the
> core.preferSymlinkRefs setting)?  That way, we can merge these big
> changes early without worrying about accidentally affecting the
> end-user population.

I guess you've split this out into a separate discussion by now at [1],
right? I've already commented on that series, so I'm not going to repeat
what I've said here :)

Patrick

[1]: <xmqq7cb77810.fsf@gitster.g>
