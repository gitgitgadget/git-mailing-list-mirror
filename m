Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5229ACCD
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777113455; cv=none; b=qsSU4fKZii7bIFLkQbb2J5t8KCg629cIw/nBkHLt63xDSGBNaDjGlP74UxWjEJs+7IfuJ4hoJdA1N3NhNCsaeEYe0/UCpxd3ZAuR9RXiTXs6SOdtwnwvIKjcQNa0nmyzb/+W5f3xeap8qCbMAslnPhh2LI+6qcWSWvz+PA61qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777113455; c=relaxed/simple;
	bh=emslPj+8pJMCl//wa+9PisjTgJCk+uyoNqsUjjuR6RY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FtrcY/fN3ILMMxvDvLvhR64Rw78JbcZLhdBzte6Ykd7z0/o/dSBRhcrHkpGNkRg4dNkXkjvrcyV1O1z3njjiaDikNsGXPEjumnvSBrGCNnHEWprjV6Q6mtxRgViwfWwn3+oA/aBsQzzy5hN3AG8VzVpuGLb7uLEF3aqLNI2Pi1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JQvCP21w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnQZx2AK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JQvCP21w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnQZx2AK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1510BEC05C4;
	Sat, 25 Apr 2026 06:37:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 25 Apr 2026 06:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777113453;
	 x=1777199853; bh=9EEEfMM5Y+IHN3avSqSlKf4NHeuxdwwGZ4ugn8BI+lk=; b=
	JQvCP21wTVMVSXs6eb8FTxheccCl/mPv+1+wdJXXlEZKFUlB0raH7NZEVp74s/nh
	vYEojObjHrmQMPWpSuLjILk+dgj6NJ005SRHminTedQk5Buv2UrQ+EeacilhHPSx
	Yi6Hk5j6Wu6lWGOJIweLWnSkQv9mOWtvTJbcVUrByDDzZt6+CSC/ZmgVOj6FraKS
	rL2MoB/+jlZ6jW6L91GjLV4Y/GUQY48zLI0MLKcxjh7VjRiHXhFX2lT8ztHuI3NA
	5wPE9v89aWR4YRMr4rbEPwE7WBIqObB7tgv2SE/9/uVqVrJ8VnzAu2GLqUmzEoCg
	xZ/5+tfB+q+KuIKcXpAvSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777113453; x=
	1777199853; bh=9EEEfMM5Y+IHN3avSqSlKf4NHeuxdwwGZ4ugn8BI+lk=; b=J
	nQZx2AK8stJkoO2/9XS4JnUskl8mf6f4AcLAODY6XqIyGCL034MX3pp4QDc2v/Al
	0GmoIe9SL2Ot0Mn2LOQXvZIOeO0pxGmW/S6rb2sH906qL26OrdHgiRc/78t3Dgds
	8g5Bsce8P0srDSglOUr636jk9EnoMRzDIxrhmRKsaZg6WZHI7nI9388Vz5JSWvTU
	rO4wc6dqCHPXTRgoGIiVgO7Mg6T7VhsZJ1X684wQcVX6IRtxcwukU1xftKVesqrX
	//Pc2WLiQAoWIR4fwsorEzwkRY2XiStqm+uUQ4Jj6mwOX5+tYlxf6IZCr9UM+cI6
	k2uxcAiqltpDGyges4jXA==
X-ME-Sender: <xms:bJnsaQjiKXnLodeDo6p1hkVxtbPSygM2QzHNLQ7rPsNO2mmgnoFPHg>
    <xme:bJnsaQAud-pXZnK2PcHHUdN-O8vFmTTO9vm1JgE1SmiTqblfnpPiNd2auwYT3FwwF
    8wzCDadSsXXJL6nDw9PduYhUpArIklGMY4c7POZY3x977jEIu-IEw>
X-ME-Received: <xmr:bJnsadGj_L2v8b-yu6BKCyx9p_Y-NpLLCnO9i76NvpjkI42ShniDPRKwLJZJsIp47Rd8xfwtb53Y8bCtQrtAYFh5JtnFCt8gJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejvdeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeifefgiedviedugfeiudejtdejgf
    dvueetveefueffffeiffeltdfgfffggedukeenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfohhsshesghhruhgvnh
    hinhhgvghrrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bJnsaQKUi_s8LYz0CxGuXi20E8Lh5IZnCLpyFCsibneh5cs7ACiU1w>
    <xmx:bJnsaZkGgVxl7J7b0dbE_-1cCrXi3BMDyVHJMtS35KWCzmvHJM4Ojw>
    <xmx:bJnsaQSTf2DmjgRiJwGJwWjQMhM0FM3Qik9prXleQwnswEA-WdcmTw>
    <xmx:bJnsaTJEAjxqcOW_18IwEU5Jene7L_uhnaMk8lIEWdzSp1hKW3d5qg>
    <xmx:bZnsaQMTYBs_unV_WHFxYcRm3gOKZHJQ_mg3Z-Jx04LpWMKiypJvfdgc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Apr 2026 06:37:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christoph =?utf-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de
Subject: Re: [PATCH] [ci] Update GitHub Actions to latest major release /
 GitHub #2278
In-Reply-To: <b3238847-91c1-42fa-b87a-b9d10daa6066@grueninger.de>
 ("Christoph
	=?utf-8?Q?Gr=C3=BCninger=22's?= message of "Thu, 23 Apr 2026 16:20:26
 +0200")
References: <b3238847-91c1-42fa-b87a-b9d10daa6066@grueninger.de>
Date: Sat, 25 Apr 2026 19:37:31 +0900
Message-ID: <xmqq8qab9vh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christoph Grüninger <foss@grueninger.de> writes:

> Dear Git developer!
>
> I repost my suggested contribution from:
>
> https://github.com/git/git/pull/2278


Glad to see new people show interest in joining the Git development
community.  Documentation/SubmittingPatches would help.

> I updated all GitHub Actions to their latest major release. In contrast 
> to "ci: GitHub Actions updates" (brought to you by Dependabot 
> (https://lore.kernel.org/git/pull.2097.git.1776775319.gitgitgadget@gmail.com/T/#t), 
> I update some more standard actions and mshick/add-pr-comment.
> They fix deprecation warnings that GitHub Action deprecated Node20.js.
>
> Kind regards,
> Christoph

Thanks.
