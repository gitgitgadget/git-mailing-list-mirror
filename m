Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2E154457
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338216; cv=none; b=DVA6y79aK5jnLNqj2gBJ/rLm1LMgOhmEEVHYg6VW+HGOSYWr5XzOz39NVu+IBId0PHSSslfuZuX3MCNaKs24L+av8PkSugrq3/XXzrgdJM7r3wPWbQgoVWBwqfZy+S0Eo4Ncm/ZLhOoaz3IUHL9knjFsxe9P8PQUyBQymSR0154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338216; c=relaxed/simple;
	bh=9p5ggLyBKfWVLOKFGo6gS9jEefMhpvWLHRTNeLPCrmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC6HLK6kswuqZoSz7u434K2Cq/Nxhv9ohDHkDUQ+E8l1nXfp3NV6TETuNz38FEdwbZny4BTjG6ZTIf02uEhYT3rs3fwyP7I5xtOyCUJRsOh/XeUU5GhjZSV7X5C2bysF2n8NOzXURHC8/WTdeOinq2iXk2tumwCEIx6nJWs3qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OdbPTfon; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BxKcUzXY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OdbPTfon";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BxKcUzXY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5FB5F1140245;
	Wed, 12 Feb 2025 00:30:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 12 Feb 2025 00:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739338212; x=1739424612; bh=0c5F1YIOYh
	n2KJl1Ag/H1hjR729ylDvtjLlWO23At0o=; b=OdbPTfonVUG6I4uZnZuT07iOR3
	rl91w8oNYdun/xuAKqt08xkeN6n8B9V6v1h9rUkm22aQZCRTjnrXevw2g+y01G1V
	2s+W6gDqh2Bd5VYq9fWM5AsJxqFgTLhbRHYVP8kkKJxCWENs5ul2tm5XWPeTKCsu
	iN2l68k95lbsUG2K4ayKGz6WYeEoRuW9uqjGTCnHVlL2sLGZIDvD2TJ1ymQpW2d9
	sZdMw4Jj0Ldluxi1HsqcZ6xtnfbcacghS2AURuFXp2YYHWh7UeW1miLKa2nlUNSp
	3Dx92SpSlhflY9szoXMHrVFf9c3vGnU8d2Xegv6/bSb83gmwt/RzYzbWWhaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739338212; x=1739424612; bh=0c5F1YIOYhn2KJl1Ag/H1hjR729ylDvtjLl
	WO23At0o=; b=BxKcUzXYWOO4HZR9CTvs6cYGdX606ArPzPjlLjA+/ORxryFi01y
	BPldw9R6/ufWhae1x9QoDrzM/2YbDtqhuLSxXOMj+5h7PBp8Uwzu+ssCYuVUqGWM
	OKfkgoPNJ2MR/WyNLwFkIdokvVKiAiQJ/yXw46ceB7mbhIl/3wAMwVB8AFrsJsCr
	p64/+wu/WWxq47eir+YSagPabVoep6qT4kG2+HIvzRcfthyWMZxcJDUkeCQxVeLg
	LZGUmuT1E1V7zZN2ViABFB2NTwiE4q47y7LWmfj+q/lsCmCAaR8EsdCf8Vzzt6Cx
	lj0EPifZ/fmwq7JIFbABhjkww5I6kTwrRLw==
X-ME-Sender: <xms:5DGsZ8An8hcWmdSkESO4M2mf005ysKHYo4uy7PCsRGr4jOUoBlq6eQ>
    <xme:5DGsZ-iIxy6v58sbJDFxPlH2Fy69t2g8fkq_89lZG0FT5HE-pmeyLU_VsdO-L142d
    roWfn1Gdx9hYXThVg>
X-ME-Received: <xmr:5DGsZ_kSNo2Vx9_aBfUsTHh1SlJ1nAl4yBkuFye7PuhwQ9WODL-O6xfvI8lKjPHBVmD-yoSuuE2kibUUmicCzG20lG5SnZj5o7p8RJjx_9mVKOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehfohhrihhvrghllhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:5DGsZyw2gWXqIxgqzYEwkuZUMc8f8Ah4MuZdH3WU73JmcuYvYnU5_g>
    <xmx:5DGsZxRdg6PfyxGtu4isJiE3C8f3SLyzgngOqE1JyHWwG63ZNuRnhg>
    <xmx:5DGsZ9Y15Utnp5w2EonZ3vFihDZho9Sc1vvrqDV-Go2w8SKjAN5eJg>
    <xmx:5DGsZ6TB2-aobe8UAwJg_2_bNmqEJltWWdzlsRnQvwoPKGAsvIpv2Q>
    <xmx:5DGsZ_NgPm08jW6WoGnegGgj6iPAuHLH-IbewaBKLdhk4mo3PpC42mgS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 00:30:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e7fd140 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 05:30:07 +0000 (UTC)
Date: Wed, 12 Feb 2025 06:30:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Emily M Klassen <forivall@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: fix missing null for freed memory
Message-ID: <Z6wx2a4LUcOjU79p@pks.im>
References: <20250208061702.88469-1-forivall@gmail.com>
 <Z6sCeYmljrqWRFnS@pks.im>
 <CALnO6CDHZerHKaWwGc-9CmwEMiFVY+Ds5-GNWYKUi1yO7=U_Rg@mail.gmail.com>
 <CALnO6CDdJ4abqxZKMaevPO+aCzSqriM98JuVOX068gQrxWZt5Q@mail.gmail.com>
 <20250211212909.GA3113114@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211212909.GA3113114@coredump.intra.peff.net>

On Tue, Feb 11, 2025 at 04:29:09PM -0500, Jeff King wrote:
> On Tue, Feb 11, 2025 at 03:22:28PM -0500, D. Ben Knoble wrote:
> 
> > 2.{30,35}.0 fails to recognize --no-graph, so I checked "git log --grep no-graph
> > origin/master" with "git describe --contains" and decided that 2.36.0 was first
> > release recognizing --no-graph, but it didn't build for me (possibly an issue on
> > my end). I got 2.37.0 built, and it was "good," so that's where I started.
> > 
> > Here's my "bisect run" script.
> > 
> >     #! /bin/sh -x
> >     make || exit 125
> >     # segfault has exit >128
> >     ./bin-wrappers/git --no-pager log -2 --graph --no-graph --patch
> > --cc || exit 1
> 
> I don't think this is quite enough. The problem is a use-after-free, so
> the behavior is undefined. Depending on whether that heap block is
> reused, it might work just fine, or output garbage data, or segfault.
> 
> I'd have _thought_ it would usually just segfault, but it almost always
> just output garbage for me. Building with:
> 
>   make SANITIZE=address,undefined
> 
> is a good way to get reliable results for this kind of memory error.
> Doing that shows that v2.37.0 is actually bad. And bisecting shows that
> it has been broken since 087c745833 (log: add a --no-graph option,
> 2022-02-11), which is not too surprising.

Thanks all for bisecting :)

Patrick
