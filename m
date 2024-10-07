Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65476101C4
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300783; cv=none; b=Z0GACZ7b7RoM1hvYSdvD1ybjoDDs9gr0EtHPUG9GqLvw+ztwuocCkoQo6+34+x1FOprZsc2/3ja409MXwN2vj0Qx8FzrlhfGtd8ZT6GSWxyWlmY9ncvUZv9CxyJbNVOHUajB+1mDlM+GTnU85W+/e9UVJxGVA7A8W1EGIZJaDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300783; c=relaxed/simple;
	bh=Fi9PMm1scW7tlHOWftkaTvy7LE+aJ0XkvHrxfnvUNi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnDmMyp3iuCzinf/8DXwALsr5wEuH/7PgHAIKd1fO8J3L5FM1XgRHAvgwMPlR7z+NjceFhISBEito6gtNis8l/UZOrowAe7g4wA4cubnmu7oM5ruzxzw+AJujcMmKe4uBYYnbqvCH6hkF0nPPTaUVG9h5PR4jUT+krG8MLWVlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1ydO8N9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRVsub+t; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1ydO8N9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRVsub+t"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 822AC11400C6;
	Mon,  7 Oct 2024 07:33:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 07:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728300780;
	 x=1728387180; bh=DuVaa95RErXElSiYV3SojQoTOgZGFXIw2RKCIzFlHzM=; b=
	Y1ydO8N92Cxw9xUBl9IesJtZQ4gLJp1EyFXZWRvaJ1bjTf+SgDCWm7DHeSX8QXtz
	LuIHUetoTFWTB4EhZEU9mSF7BMmHMNyj5XdyG9iX47ObNJ+sbxJD1pVyvDxBSOnk
	QsmJ8O2vgdIpy8B05ohwKIrNXCy9QpjXz/1nLRwvpx/o2yMJUxasYD1j/Vnttx1w
	kLMMUq686lfdjiZ13KXtX/h1r7v2phjrsR/HvkKtKueJ8jILVXGiDJtn/RLzTWRw
	IXbR+MdEsi0VDsopLIz5pVSQVjUBd/U4ELUwdfSmowY4Q2FUKb+E6QokwD6iUOAo
	HLOlpMT+GmKW0xeWZWzLDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728300780; x=
	1728387180; bh=DuVaa95RErXElSiYV3SojQoTOgZGFXIw2RKCIzFlHzM=; b=Y
	RVsub+t1hccweSmcc6ddhx/AYh5Gz/WcECMpIHTO0rgVhruW5vHOMXxRqJOJDfAS
	gUI/vLm+H0DZXWx+SJViGejbp3EzOLnXIcntbFOCY3D6KqZBMfCfgANOTUlV+ATy
	zPUZJ5vFGzkPY4kKOF0o1mZed+IA/04ZpUMrJXFF1hgOgBBX0ce4zMHW6gd16qMC
	7oZLfFWe6fRi0Tkd5Ye2DmaRMHd7uvAhcNUY8Ha4/Y18Fivr0B/8oGK0NpqAl1I2
	dr+tMKg41m+Oz7Hr3fsD99FZQttUhdcqw7eDAfVpeMBllLGU8R0zcu4fdY0UuJOF
	ACNrEu8gYSyWga+EXzlGQ==
X-ME-Sender: <xms:7MYDZ9aYPzTd1-gvixTrucXOGyuOhNIxwHNlZHDn0Owwx3ubYIWvAQ>
    <xme:7MYDZ0ZzoiMYkgcIa8DdFLeq6H7E6ArjQG4OFGjNGpfu6KTYSjjUZ3uK7abN55DrL
    IycAg31NbavQaQvUw>
X-ME-Received: <xmr:7MYDZ_9QpA9kZQdR7uOMN_EojjZQfOsxVg3G7B2UYZ1_vLulTlIK1w3OFccoznDr5cKBfcDGq5yFu36V3tDGbKdEB_HsokB86lTupwQsXDxA1qKUwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7MYDZ7oCs1vqhuUDzx_aX-y9zQVc4aTvn6gOJmmuG00YMHQHOfoo6g>
    <xmx:7MYDZ4oJZ-unOXt2h5sxhF43M8YCFpF5T-M5AGHb0UQ5HBzHBoOVyg>
    <xmx:7MYDZxSoj8Xhs4CNQEOgkcn4kf2pu45kNdqI_FSsx4Z2JLBD4hNftw>
    <xmx:7MYDZwoaOuwUsMpThdLBW_52rwjDFnA-QHsT8n-KTWljfkB32lkzdA>
    <xmx:7MYDZzV8dU3qxvaDIDuBcZ-L74tysf7x3UQy9y5GXLatG2NTnRVk3Kkt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 07:32:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ebdd6d6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 11:31:59 +0000 (UTC)
Date: Mon, 7 Oct 2024 13:32:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v6 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
Message-ID: <ZwPG3QHarKerpN3K@pks.im>
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
 <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
 <ZwPCDAjeQVf4VFc_@pks.im>
 <CAPSxiM8FpPyCgvRqrH1gEhZEskGRAeBO_2+_1FamTHaezr9+Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM8FpPyCgvRqrH1gEhZEskGRAeBO_2+_1FamTHaezr9+Cw@mail.gmail.com>

On Mon, Oct 07, 2024 at 11:16:49AM +0000, Usman Akinyemi wrote:
> On Mon, Oct 7, 2024 at 11:12 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Oct 07, 2024 at 11:11:04AM +0000, Usman Akinyemi via GitGitGadget wrote:
> > > Changes since v5:
> > >
> > >  * Remove spaces between redirect to conform with git style.
> >
> > Thanks, this version looks good to me now.
> >
> > Patrick
> 
> Thank you very much and I appreciate all the guidance from all
> reviewers. I Learned a great lot of new things.
> Going forward, what should be my next step? Can I work on other tasks
> now or wait for this to be merged? Are there any other things also
> expected from my side as an outreachy applicant ? Thank you  very
> much.

For now I'd recommend to wait a couple of days until the patch series
you have sent gets picked up by Junio and merged to `next`. You should
watch out for the "What's cooking?" reports that he sends out every
couple days and observe how your topic progresses in it. Note that
things may go a bit slower right now due to the pending Git v2.47
release, so it may take a while before he picks your topic.

When things go smoothly: congrats, you have checked the first box and
have successfully completed your microproject :) I'd recommend to keep
on reading the mailing list to get familiar with how things work over
here and get some familiarity with the code in question.

You are of course free to send additional patches, but this is not a
requirement. If you still want to do so I'd recommend to not pick up a
microproject, but try to find a work item on your own, e.g. by searching
for "#leftoverbits" in our mailing list. The reason for why I don't
recommend to pick up another microproject is so that other applicants
have items to work on, and it decreases the likelihood that your changes
collide with the work of another intern.

Patrick
