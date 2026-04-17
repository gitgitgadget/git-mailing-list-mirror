Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF23128CA
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776464515; cv=none; b=ncARbep8lfxqdsWDTVS2RKFcPqkWA5OuKZTYT2ToBxpLrJ03sqtkBAIlxzNiGvSgJ5KCPZNkZKlLlyrhPpM18WwD0fFY0uVmr6wVBlU8q6CCYKxBcyq7EpuFGaCFNlcLzPeWtv6qxdIW3O0++KP8tLAbgz/ZCbR72Dn4g7O6EP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776464515; c=relaxed/simple;
	bh=GsG7fW45R8ebCElG3h7M4Dd68LuspMR0uzL0N7WXtKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJaL96IT+/Bd1XK4m4S0oY6NMD9vgSm5218Q8jhnLp+7dmFWtjxi/WV2h1AmX3Z3BmttxgYdYu1x6Ge/UA/VV3jTPkhOBkMd3ePIzW8EPsg3Ez+QcJeM8TjkAedCE5H3tQu/VSe0NOqYr62BHXSWqp7VlzrLjY4MaaSBEr6GOZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NSX3VO31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GB9/i+OB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NSX3VO31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GB9/i+OB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 137B11D00091;
	Fri, 17 Apr 2026 18:21:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 17 Apr 2026 18:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776464512; x=1776550912; bh=hs0CQEb4JM
	mNU7HyujM47DUqCk+5BRZDH8n3TIv7J9s=; b=NSX3VO31GOtEvsEdjpjm1QgqhE
	RhtezYrxrWL8uPrWsX+KXw6yTO7VxowzoxNBS8YStlseYolhcUHF6QP4pev8zjue
	xR3vsgK8Q8mhn563ouTOVj1ftNfaGUB7jl9cBCVMZgz28TRWCz6cYvF/RK1A6ADj
	vo65wm7mxb0h8vaNYYGwkouVduRNAv68zqc+7TyRpMTDoJNp3cNM/shbzcAnRdm/
	a4O+3GhZ+wHHKt891WoI5wDeg0CVpsnjo/GmEoy2Nib7oDdlbs+LvgQD/aE0ltki
	8RgBu1z8rS+eZn9WFBITbdvlkrP3oJb+UoCf7SYwPj5hYjaCikGO4MyASIlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776464512; x=1776550912; bh=hs0CQEb4JMmNU7HyujM47DUqCk+5BRZDH8n
	3TIv7J9s=; b=GB9/i+OBLqzXnnmtNPGBceZWcIvxu9WaM+aYQxOOAnaJYKFvOSf
	+U8lLpft1+oh/J7QBXPpGlTz5nkr520pWcOOLtq+kj6Cz8E068AB/TpTp0fOKNo8
	ZXBKILc2TLjtoEm4zwgFNSOtOSN1YIkcGxoTM0+vtVmeNd3GzmE1gVJ8nt8pjW7/
	Ao8d+TdeUF6EHbaBk1xVN3imgMMlVcwy1WBAWyrG0BGypZZZW8xtloJL25/avsHw
	ucB2RT2kkmbNmY2bxSCjR23rHUfLHh4OU72vOvkqCxPjShwwXZ03Yf1PGOMgMcRX
	5koKBbjiRbbF7XDa4OkTOtez1MCng1HsqDQ==
X-ME-Sender: <xms:gLLiackq_g3iUc4BBloDcTo5l5y0AST-weFpjlkcpqSFb_pd0whBCQ>
    <xme:gLLiaSu0ISq630h0AvXHCiyHhzj-qyzjFLl3_KK-m8Pn1FMDlNOblSV57OYEBYHc2
    DJX4H1Ncjbrmxvs7LD8yfxEPub8d1V63kb8zgxXQ1WU_x_n_KEkDT0>
X-ME-Received: <xmr:gLLiaS_r7jzTYjBPIAFzUZubxZ7KArmxepvQHtmVDlr0JhsL7-NeJXT9VnDfft1sey1UeYkc27NWomXjUiLaAoRr3SbZs38Cxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehuddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhorhgvnhiiohdrphgvgh
    horhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:gLLiaUOH-6-JClsDbgKKUv12f-Gf4B_sStklsOWrp8CXSSYlsSaJqg>
    <xmx:gLLiaYGGeOqrjqT8SZiwATh2o_0jDD_W9fhcH_ejYi4bn31AqxJLYA>
    <xmx:gLLiaaSEEf8JksJ59AfOj8RQ53urKsryeO1LjQW2HqaBYVLZBqtP-g>
    <xmx:gLLiadsZCi0IbPkSZNc0PvVi57i33kO7hbGjUXIxyDD8XZg-8Tz9QQ>
    <xmx:gLLiaTd77y6dzSK80J4bPnQJtDfgpWvkRBL1vjFuL-cjvAv3nfgggRhh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 18:21:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Subject: Re: [PATCH] diff: fix out-of-bounds reads and NULL deref in
 diffstat UTF-8 truncation
In-Reply-To: <CABPp-BHt-O=CCnGHjoXBOHCe5CbD7beyrd_gX51g9Xg7cn_eFg@mail.gmail.com>
	(Elijah Newren's message of "Fri, 17 Apr 2026 15:00:11 -0700")
References: <pull.2093.git.1776443163041.gitgitgadget@gmail.com>
	<xmqqv7dpwfy5.fsf@gitster.g>
	<CABPp-BHt-O=CCnGHjoXBOHCe5CbD7beyrd_gX51g9Xg7cn_eFg@mail.gmail.com>
Date: Fri, 17 Apr 2026 15:21:51 -0700
Message-ID: <xmqq4il9w7ls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Makes sense, though I think my simpler alternative might be easier.
> I'll send in a re-roll.

As long as "an invalid UTF-8" and "a control character" behaves more
or less the same (i.e., "eek, we cannot measure the width of the
UTF-8 character at this byte position, so let's do X as a fallback",
where X is the same regardless of the exact reason why we cannot
measure the width), I'll be happy.  If we see a slash after the
problematic position, advancing to that slash might be the simplest,
as that is in line with how the code works when there is no such
problem, but we also need to be prepared for a filename whose last
component is sufficiently long that we see no such slash after the
problematic byte.
