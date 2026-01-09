Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8363385BC
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976440; cv=none; b=WFFQ1HZCh6yHzksh+WoDRM6uSfJEopFsSo97xl4zKhwuK6neWrh2PMGqLxaqY5KXDy47wLkPuGc5meJF/Xhy03R3GjzgRyeVor1UQmmjzKBJ6DotPQkfjukVBSlk/jB5ql19xYLLUzA2rtczhpb6SfnIio4pV+Adu639hTA8fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976440; c=relaxed/simple;
	bh=0K57LYEGLfmIYkKWYTIedhUdPhT5F8po1nbdmDSJYJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6sIPCW8E2kRDEkdy5UiuIKWJ/iTpFfiO+qVOHgBq1RSdG/o3jJzMz/mIk5167IkYWWhjGFtaY9Jy76QP7ttjxYCc981nN+7BEjcPbZsZZHuf9a1txSd/nubYwnYbfjPFMKbI5e1J/JArF8BIMrmlR5kLa2pUehOwyqwYCWos+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fS06rI+4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zXKjoC26; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fS06rI+4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zXKjoC26"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 08A291D00149;
	Fri,  9 Jan 2026 11:33:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 11:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767976437;
	 x=1768062837; bh=193QOEGoCuoOiQPevcU0LxifX9MVvbE1OmQL4fBVyKg=; b=
	fS06rI+4k7W7zSFOF4tM/k860SZGnhnX6rySeMtYHSatTlV7CGfbTo/VAmxiypB0
	6WUJJupAqhv8pwfH/eWy6rGpZi9A6kHHH9/gbhEnJdMlVR7Kn29IZuXZlFtwjVuC
	mwWIJB77MUFVWD6ja37N7W2fyNBD1mv38RYl1IKsZo65LOti8dlmZOBeGkK892WE
	zYYEGN7oiKpv4tb2rtbbyuaGBBBR3HHVXJ6lloh1rEoo8reCgp2jelTW64OnTEOO
	TILlyGA00PSCpRallDqp/gOf3isdhEGh07GeSX8PgjBkX9lbB0Spzm4aFZtkSRrt
	7AIQHsJsX9Y0AiU3ePX5ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767976437; x=
	1768062837; bh=193QOEGoCuoOiQPevcU0LxifX9MVvbE1OmQL4fBVyKg=; b=z
	XKjoC26KP43vFxYz7fPZxvR84IBPCoTu7K+g3obwnhZRoLnLb1pD6q+FiNxPIJSk
	Di9P2P/kSYGIwDSbs+c3mnV5OjW3VbQL8KHHi6FOaH2wiOISlXoHWB3xpPB9L/C2
	tKrlrrng+ahMr3xHZULvvniO4rroBGRWlmZ1gfWiW1uTEAF9NrJTQO2E+h4WrS3b
	2YigBRsCSolSf6NdcBxSMAf6TT9SImbqWDIEhqvjiP6/URzz88QNb/lrAzqVcRv1
	H/IRIh2rUHVlZUjS8hnOAnJI3I4L12nXrzyAyR1bK49QuN1lxfhvFMWBveRcW05Y
	2uEmApPeIRD56TN0WGN2w==
X-ME-Sender: <xms:9S1haX80OaKahmQ28_F1n-2r2EqV03E8yZE3GwmaIgsdJV8xfEmnkw>
    <xme:9S1habJra7CReLuwdAsSPjMx7laklzMZqXChclff9OnFrA3KcArGcI7JEDQOKhkqa
    SJMRcyhoBCeGgZYWSZrhm4fXTDp1xcpqVmofGRTP27ezrhcP0azgQ>
X-ME-Received: <xmr:9S1haSbPFHnrXpFpdU6ydiZo9h_Iw5VOy6vXgv2E1Ea90dM90o9ZuFhF3izM-QA4jWxJnSXrmZ94ubYpPG6iNWmthYWWaFGXC7Q9Q1u2UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsrg
    hmohgpphhoghgrtghnihhksehtqddvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9S1hadLayhNZyN4Yty5xz0BnF_x3GisTNB4ydSHXUaF-VqrO37D2Ew>
    <xmx:9S1haQBT8e0XEcWvLrY-8cethJ57v3JRVMmv_CpE78YfnCGr4BLN6g>
    <xmx:9S1haSrY4657xOfImsUxR7gyaJQiQnrMBdAVnOjuoCpaCfj5ui5Ujg>
    <xmx:9S1habjPw0u7GrcXOWS6Bgos9lGAzzAILlj242M0oljwBckwbqxH3Q>
    <xmx:9S1haXLovxNYf53O6FCEzaE9mAVj5aeyZx650nSGiDiL7MTtOTh2ttzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 11:33:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8d9ce33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 16:33:56 +0000 (UTC)
Date: Fri, 9 Jan 2026 17:33:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Cc: Samo =?utf-8?B?UG9nYcSNbmlr?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] shallow: free local object_array allocations
Message-ID: <aWEt8UXucXMY0QCg@pks.im>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
 <277c8616a9fc365b76b2f4ab458cd927834f9e0e.1765303880.git.gitgitgadget@gmail.com>
 <aVy9ZveUOg3yum2X@pks.im>
 <eefa06bc46f8029b68efe993da67d14e268e1bf2.camel@t-2.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eefa06bc46f8029b68efe993da67d14e268e1bf2.camel@t-2.net>

On Fri, Jan 09, 2026 at 05:21:45PM +0100, Samo Pogačnik wrote:
> Hi Patrick,
> thanks a lot for the reply.
> 
> On Tue, 2026-01-06 at 08:44 +0100, Patrick Steinhardt wrote:
> > On Tue, Dec 09, 2025 at 06:11:19PM +0000, Samo Pogačnik via GitGitGadget
> > wrote:
> > > From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
> > > 
> > > The local object_array 'stack' in get_shallow_commits() function
> > > does not free its dynamic elements before the function returns.
> > > As a result elements remain allocated and their reference forgotten.
> > 
> > I think the elements themselves are actually fine. We have the following
> > loop:
> > 
> > 	while (commit || i < heads->nr || stack.nr) {
> > 
> > So while the stack still has entries, we'll keep on iteration.
> > Furthermore, there is no `break` or early return in the loop, so we can
> > sure that we actually pop every single element from the array.
> > 
> > That being said, what we _don't_ do is to free the array itself. So I'm
> > mostly splitting hairs with how the commit message is phrased, the
> > change looks correct to me.
> > 
> > What I'm wondering though is why we never hit this memory leak in our
> > test suite. I guess the reason is simply that we ain't got enough test
> > coverage around shallow clones. Have you seen this leak in the wild? And
> > if so, can we add a test case that surfaces it?
> > 
> 
> Actually, the test I've added with the patch 2/2 does not pass without this
> memory fix in linux-leaks and linux-reftable-leaks test runs.

In that case it would make sense to point out this detail in the commit
message to make it a bit easier for the reviewer. Thanks!

Patrick
