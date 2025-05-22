Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDB148FE6
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939890; cv=none; b=LQxTO6y1bKZovFtt+TWSU5j6dFAtwUXO70vxf2LaMqNpZEo0NMaULosvALSl1WQC3W/j2VqzU/O31xxRdNIRFzQ5erc1WmDEQQBjBo4hBsb69UzwZ/paZjw5gi1fZgAkIWN7tmi4sXI9H3JhaVM0EsGJBdKE2QfC398DRB17rgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939890; c=relaxed/simple;
	bh=IoH4yRXc9ooHOA2dmEfTBLA8qkNXBRFuZhd/eWADBP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMiV8KlzOrxjsIuazfE2P0jcuISEAa2tqvRz2T87gjOo8+QBk4TOb+U7Nskg7sOzQTZ4CAkO+cgmwpzi3R/RBuOy65lfHOkjn9rzvkmU+s+mJeMcuD8Gc3kvol0PoySldX/Goja1uXJnX7VD/eja6xN7NDnAM0l23krsF73HvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bcLvqnBv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beVt5mpf; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bcLvqnBv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beVt5mpf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C67F25400A0;
	Thu, 22 May 2025 14:51:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 22 May 2025 14:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747939887; x=1748026287; bh=Y9cs3KCePI
	gzrVuu0ENXzHv2OtuOCZ7VRlr6EbNPHg0=; b=bcLvqnBvty9iru5qAv/TbFqvb5
	9Rc2D2lRK5q0sxeenT/4J7HJU6Podt90/0wbT/57UK8u7tPEzIMDZc/RGvTr+E/l
	WIpx54GId70Z+Qvrvb8qG3aFrUFN+1vYA7aM0vkELgq9QuTKJ4ZwkWA0dU8aLgIv
	JrlfQMB08izEvScMscaF0FfSqyGOaMiZ6/HhVgHgOL1AOiwBlLRc7yJ0WRPbr6Yd
	y1DUAU7962eqCNmHkX8BHu9WRK5FCzNvLpxzhegVGrNwSAy0EWxe10FhIjmcAFeH
	fNoIl9rqGf1Y1qN3tsTOM3BHcJJzxwkiomUGOb3X6frZ4c7f8C4rclqgxtwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747939887; x=1748026287; bh=Y9cs3KCePIgzrVuu0ENXzHv2OtuOCZ7VRlr
	6EbNPHg0=; b=beVt5mpfb2hxD3HUk6Cevrq4UWpGEfIVoJvWPxtPlXsdYG3yDhz
	oDC8c3PG7rcSQ8IpLQINFVgYjtRucgZxSVINB/GJC6HopgQ3HiWzB/rmFyJZ9Dej
	6+ehPIkVh3z3Sotdq3y6/gPic9jvjWILqNIWf2+IDK+Xxf26i+H9CvWivwPVwh41
	36sCrZnk1Vs06hyrRUZwhZ3RQdAOB92gST2X95YwXsp3ksR6uLk2VWzJBJZMPVxB
	WokiFcpFBsGsjJp4e3468HuOnGZP0ksRyA305fjO35BI3ShEc8MaGK+VVZvDTTcq
	BLCGqI+pv86m8a86JnyigTDJsA/+q8nwzVA==
X-ME-Sender: <xms:L3IvaBmv1gRpm0VTmCh5Q2dI3W9BAyZfMNCgdCA-uBO7Gz5H7NwEyA>
    <xme:L3IvaM0fu1G8GMcY0YiEZEP7-C_o0Ye0AnWtdSBwGjivg11SfkgP_8RHMXXiSCflZ
    FsFewgOpXdfjB3UXA>
X-ME-Received: <xmr:L3IvaHoQm_m9sBs4JRqpIhaQWmAzROvB214NnRs7CZTGGNZjdErYk3oLf4vybUeocvfnLI-52qb87H8TcKlTaXg8qEKJQZ7FGzfX5PM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeijeefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepohhpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:L3IvaBkML9mxaTCDyTkq5rCWu7peKbHcPWbkKJCwCVaj3HVDcSRWOQ>
    <xmx:L3IvaP1gNs8RrRdlDvAi0coMcjIJX5cpH89vVhfbbuo93oCPuZh1gg>
    <xmx:L3IvaAs2bWVBLi9MJNVJs6zpLNq1Pk918uA4PjtLrx4I-YN508vDCg>
    <xmx:L3IvaDV2zxwmyBTZWF1qrAdJKczVlfWklGMAOFbigllR2CJDXppT6A>
    <xmx:L3IvaBM-Aa8O4vAOqbrNhsupD5NJTxjZqpw0Li1pP3OHl6peT28wpn5G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 14:51:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Jeff King <peff@peff.net>,  Ondrej Pohorelsky <opohorel@redhat.com>,
  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <aC9lM12GyntAp2tR@teonanacatl.net> (Todd Zullinger's message of
	"Thu, 22 May 2025 13:56:03 -0400")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
	<pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
	<xmqqh61ear4s.fsf@gitster.g> <xmqq1pshc2vs.fsf@gitster.g>
	<CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
	<xmqq7c287i7n.fsf@gitster.g>
	<20250522170536.GB1613@coredump.intra.peff.net>
	<aC9lM12GyntAp2tR@teonanacatl.net>
Date: Thu, 22 May 2025 11:51:25 -0700
Message-ID: <xmqqtt5c5viq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Just for curiosity, the only commit found with escapeRefName
> is when it was added:
>
>     $ git log -G '\bescapeRefName\b' -- git-cvsserver.perl
>     commit 51a7e6dbc9
>     Author: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
>     Date:   Sat Oct 13 23:42:26 2012 -0600
>
> 	cvsserver: define a tag name character escape mechanism
> 	
> 	CVS tags are officially only allowed to use [-_0-9A-Za-f].  Git
> 	refs commonly uses other characters, especially [./].  Such characters
> 	need to be escaped from CVS in order to be referenced.
> 	
> 	This just defines functions to escape/unescape names.  The functions
> 	are not used yet.
> 	
> 	Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> 	Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> A subsequent commit, 658b57ad52 (cvsserver: add misc commit
> lookup, file meta data, and file listing functions,
> 2012-10-13), made use of unescapeRefName; escapeRefName
> seems to have _never_ been used.

OK, so we can safely remove it, it seems ;-)  I wonder what, if any,
the unescaping side is unescaping, if we are not doing the escaping.

Thanks for digging.
