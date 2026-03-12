Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E134404A
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296529; cv=none; b=atd1n6YUlo2SGdeUwEcM6E1yAzIekri8W9p0g+zP/ZB2bkvY40GsOJtID87UhJI5wyA+LQhv7BCqxVWtSmo8OjbwBPSNQNC4aCrAu4nloYOxLh/x6OlNHYq4bO3ET0PlDVX/Th/0DdwHm01w0b465mW8nxGuwRqw+oOJPkzZD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296529; c=relaxed/simple;
	bh=HkcDqN4bzoaH8+ZhNUdLLvCPg2teTTR+zuB8xoZiZ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUKBYf95XcvhqhZcyw8LZdGpi2p40Ly1Ad4ndgPcAdQ0OnzeyKDxb4edoeQ6oR/TuwQm9z7mAZyPxSxecPlPER0Epcd5t08VB1WvlolkeOFNTR8xgHod6tZ4tsdBHuLIRZhHqWqMWzx8Q2qwTUV+Qj/xWyBjh7ANPvYKTGnHpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=laB6tPx1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RQLDO2Kp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="laB6tPx1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RQLDO2Kp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F61F1400025;
	Thu, 12 Mar 2026 02:22:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 02:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773296527; x=1773382927; bh=Z6DdOCJLxq
	3EmhWhGb9zYoBoYKPjLTQZqP36Wa0J70A=; b=laB6tPx1BKEG3viBPsnI16iBo1
	dpyNw8p3QLDrdwiq8wsm2amDmJh1TWz8e+hsirxFE/0YOjilEc7cn/75XZon+OLb
	Q48wcw47U98rnEhkJDSRVx0S/TVZDgVyEP+VFekMWxJ4NN1L38r/JodndxLMVN7R
	jtsBWrRSpmLFOS2hRyzk4XTKdkfndPEFsT62OsWBQtpD17DeN9Eeiz4acQIdJTAM
	k8VJP8JIGMGOj5TZru8cVvNV0jfi8yL6Bp5IUZJr24IVf5c6qW89lb8OnU6DmQmj
	4Aeo9NI55w6c+/d/5P71cYXdhlrWbBCJCs3pFdb0BvZuC4EAc9bxcXvreuCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773296527; x=1773382927; bh=Z6DdOCJLxq3EmhWhGb9zYoBoYKPjLTQZqP3
	6Wa0J70A=; b=RQLDO2Kpxl3zliU46FS4KTqP7Wi02PZ0FuUGgbk0NLz/XkPvfTE
	eApPxnJFay4e8caqhbB1rY9Q75GfkrhRZrvRYtUxcIDJLKmGHh6VA6jINZMQ5aJr
	H2qPzOV1WfDI2+OmNG3ZuSJXJPnOJxgJY0l2CwEsK7qQg28pjTLrPg2OA47brqMC
	imow7i08JH4smwn5j8h+p/lCGsATwTDUlrQAndv+s9p2O4xnq+O8zHrkZetZ8PEw
	8YwElHbNtZk7dtZchHEkN+mBGfiMDgW+AZDdipz7UyAqtVcbsEBUc362mrnoLFjC
	vAm3o+O+y49h4EIFpv0rqUYstXqxXuHh2Tg==
X-ME-Sender: <xms:jluyafF6mBsBDqNBlg6i5bQlo5s6LwBLZm0a2r8_67MJEnw8t3e8qQ>
    <xme:jluyaaQnZzqZGLZhYnGLEXl7WTiRUl-DS2dzFsEEjgPN3jPjoMKdv02gXPx8WE2d2
    9if3DlRhKopRY2OEVsMk-vE8AeCzj1U6YHU45JfrRhjIPc78GA8YA>
X-ME-Received: <xmr:jluyaYu2fzj-H1JKCq887f9CfAbVextlLEuZMEwydIGykTTuUQPN21S2U2xRNDzoGQKTMQ8bG4fOs586YTWSfXukegxNnoT0fNTdje4Qu_gNeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hk
X-ME-Proxy: <xmx:j1uyaZyGHTw3VnXT5TEvoHgItHPO7oRNSCb-V8YSZeujnWyZz8FhEQ>
    <xmx:j1uyaS4r51oZudrnq9gLV_2abKLF4R3qW1ym-T_4mcX-gWMIu564Mw>
    <xmx:j1uyaTWucskk4amfOWUqVKedy4N8rlTIXmGZ6LQOAbzQqLeQzhB-Tg>
    <xmx:j1uyae3SsZELQa4Bpbr8aknCxVnRGM-Q4ddsmsEZXaD6QgxknsU7oQ>
    <xmx:j1uyaTJaJsnrKUNutpM-rAPCZDeT38_b6Qavwv5deiiH2HajHAn_-5X->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 02:22:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c23c3c7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 06:22:05 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:22:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Message-ID: <abJbir7NocxmBuAo@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>

On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
> On 11/03/2026 14:32, Phillip Wood wrote:
> > On 10/03/2026 17:52, Patrick Steinhardt wrote:
> > > In the next commit we're about to introduce a precompiled header for
> > > "git-compat-util.h". The consequence of this change is that we'll
> > > implicitly include that header for every compilation unit that uses the
> > > precompiled headers.
> > 
> > Is that a meson thing? I know it defines precompiled headers on a per-
> > target basis but does it somehow force each source file to include the
> > precompiled header? Looking at the gcc documentation it seems like the
> > precompiled header is only included where the original header is
> > included.
> 
> Answering my own question the precompiled header is included via "-include"
> on the commandline. This is necessary in the general case because a
> precompiled header cannot be used once the first C token is seen.
> 
> As an aside in git we could probably get away without using "-include"
> because if we include "git-compat-util.h" it is always the first thing we
> do, or we inculde another file like "builtin.h" which immediately includes
> "git-compat-util.h" and so it is included before the first C token is seen.
> However meson cannot rely on that.
> 
> I notice the reftable sources don't seem to include "git-compat-util.h", do
> they need special handling here as well?

I don't see a strong reason to do so. The reason why we need to be
careful with "compat/" is that we redefine a bunch of standard symbols
there, and that requires us to play a couple of tricks with preprocessor
macros (see e.g. "compat/fopen.c").

We don't do anything like that in the reftable library, and we already
include "compat/posix.h". So in practice, it shouldn't have much of a
consueqence if we start to include "git-compat-util.h" implicitly over
there.

But if it ever does we can treat it the same as the compat library.

Patrick
