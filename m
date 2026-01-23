Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F80249EB
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190367; cv=none; b=kMm/5dYiG4R/7iTExzhQhL+Pt/wJz4wAr+CO/Y2eMWrL7MFjLYzff8nUUCWXjnPZok9nRCV5sluuc4FvHO3qC+qzg4glEdBeCgwJeO3fKZnzOoT5bNxEseGcTsmdYjvPe12QVr7Ue30Q8uSlhU0a9hL/V3mKEjWmQGhsYUf+d7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190367; c=relaxed/simple;
	bh=wEpOrz0kE6Dn9UZz36QktiDQZL+Tif+kwPkKUs4u6u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mIY0u6yp5Qtap0kSGGrJpDL8qDTv7fx/0rN509iqyi5fmZEF5fqNuPDorDupbG0sA3Y9Mgn4pbW9EmdqHVtqkJEKeEpj8vj8DYNYqjz9XW3xNqs7IWFLaFtonW88lsIFowLafx1vuur8x0AFJ8f/n7LVh3Zapgs4Fu63daIy9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NM6sWvSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uu9VRpg/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NM6sWvSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uu9VRpg/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E11D41D00151;
	Fri, 23 Jan 2026 12:46:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 12:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769190364; x=1769276764; bh=YT5vAI0OpM
	q4lE8Ld6RBlf9j7BG5c7mPagiAmxP+bko=; b=NM6sWvSpLp8XNyyz7fd/QVqK5J
	TRkphCEezeuQDPbtU8jNM4F+1x/HClln1JqHXgvolBPzRPACeRhvnnYc7gSB7gxx
	yGESHJjPpZTwqlKg+r1A7M6BM88YtCDZY35X8eXAcYxAb0R8HW+MXfuYhnRfcQul
	8UcUGgxSlvzTyhKiNTsK1W2ahdnaGnqdbgOY2D7CawQokiMoINJa5pPyiOacxxsm
	Gp7Q/FIcJQju1UXucCMiELUOToy8P5TZzpHiCQZL5WIh3OOObD36uhQK6XmzhNto
	nP07g+DRkYC4RKRJEEPuly4cQeDRGsMBbMp1Dnj/EmN8/mIHMM+ltw6Cfn4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769190364; x=1769276764; bh=YT5vAI0OpMq4lE8Ld6RBlf9j7BG5c7mPagi
	AmxP+bko=; b=Uu9VRpg/YuRVFAQjNpDgMntcs6rwOzuQD3VlzgV7ZRjAOBYERMD
	zBM+ManxSaEgtU2mj0s1udqzQWlr/e7i/FFM8hLZe4Y1YprxfblVvIu9qET7qwW2
	0FoM30rXM9/mbO+lrf3+Ggb9jdP8PHj4ElFeS1ZfqoEg1JJJi3PBvLxzPB8Meedq
	Pgj0uzgS5tipmL6Va6FKURwhY76JXT/vVE06DVGeAoAJzxs8RzvfwKfCpVYzWTcK
	ASKDvcT5cZMPUmtrrnc9JSQyvIQcv4Bj/Uxv4RIwoPIrCQVkOV6HdcsETfneyBGC
	h7z8B4bEwcGdcO8tsTqwhi5MIAoXG4BDDLw==
X-ME-Sender: <xms:3LNzaeRCkNJ47kcJFIG766ZMaNrXa5cF4MB8BXUaZh6WCbLeAYiclQ>
    <xme:3LNzaao54sDQsSOKRPwYNFu7vqo-helRmGZ5ht5wwzPQBA0NYO3HNtH_HRiAykfL2
    _s6I-57HWVI2mRMxH_IMzR05oQWZwp13_MWEwc6MJgEzGChYS6T-Q>
X-ME-Received: <xmr:3LNzaULc65cto-0BkPmScFk5mrtQ4Zi5HyGXa5UzdFLWPgm4gRoX155_fNeo7gfDvFZPKw5xPcphFJsqob0gSOsn9v3wYnyZa-nxbyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3LNzaVo-yWW5MI2uDp-hqHeX4ZazjPoBf09T0y5e4t1wixAq-uny1w>
    <xmx:3LNzaUwlwuCZRQLCiq3RfQ263yj5YUrXfZiNbAirMjjozkCWJ2GcrQ>
    <xmx:3LNzaRODOG7S1G3ztQ6K4LDYXDzb_I7dX_8g5MpPLzp9-R8oWu-8XQ>
    <xmx:3LNzaR4pkFmXRZVLBolXpsK5G2pwZ7R2NrvC9q3Uh8FyH-L5G9dbog>
    <xmx:3LNzacBHNRPo5qNyWu_QoZPCr-IFG3PVzAimrHT2ag0GcmvUFuH7D4Nz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:46:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
In-Reply-To: <a29ce07a-9585-475e-bb3d-4742f2ec400a@gmail.com> (Phillip Wood's
	message of "Fri, 23 Jan 2026 14:47:11 +0000")
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
	<b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com>
	<xmqqa4yc5brq.fsf@gitster.g>
	<79c29032-dc32-4030-95ad-dfbd50d9b6ab@gmail.com>
	<xmqq1pjk2sv2.fsf@gitster.g>
	<a29ce07a-9585-475e-bb3d-4742f2ec400a@gmail.com>
Date: Fri, 23 Jan 2026 09:46:02 -0800
Message-ID: <xmqqqzrggr39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... If "git svn" was 
> implemented in C then we probably would want to check it for leaks even 
> though it called a foreign program. That's a long winded way of saying I 
> don't have any better suggestions!

I am not sure if I agree.  If Perl interpreter used to run the Perl
version of "git svn" were found leaky, are we willing to go in and
plug leaks there?  Not likely, particularly since it is not what we
ship and we do not have control over which version of Perl the users
have on their systems.  So we say "Perl is foreign and we are not
equipped to plug leaks in various versions of it on users' systems,
so it is not worth spending cycles to test for leaks in it".

If "git svn" were in C, linked with libsvn without using the perl
binding, and libsvn were found leaky, the story is the same.  We do
not control the version of libsvn the users have on their systems,
we are not equipped to plug leaks in there, so it is not our job to
spend cycles to test for leaks in it.


