Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40832080D2
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680432; cv=none; b=j3s5LbgywzLPsKs4LP2eqPtq8tHswtfHydRqa7mX4UHmOxGIyrGHcsnYaDUTvI0knLClrt7qAixrPR8WI8COmUJSER99paKZcicQmk8w4XDn0ZitlM9DsE5kg/hJpvtAW4cEcxF1/kX5O+xvlxY44cG1mo/iJ2TNrZcBp2HFRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680432; c=relaxed/simple;
	bh=OiMYi0RPt/d9AySng6V4J5qWiM8+2bCFGnBBoJsCNv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hth11vJi312kPgaM9Z5OKVj7Z8CPqElVqI4YedZXihWGYylQoelS70/yS0jd0L3vV+L2ze0zKKisWj1QVN2hcs57+ASfRJf6CCekgXRlLz8VPna/cBsoaPKDI0e5mmXFu31jtAsAefEbqiBrnZQ1HUNlZ4oIFj5rWRSQMudibCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GOjFTprA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LTXmylX8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GOjFTprA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LTXmylX8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FAB7138028A;
	Tue,  4 Feb 2025 09:47:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 04 Feb 2025 09:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738680428;
	 x=1738766828; bh=OiMYi0RPt/d9AySng6V4J5qWiM8+2bCFGnBBoJsCNv4=; b=
	GOjFTprALEDcKSAlICSzNq1TEYuHdk78DbIoi+XuwVqDOegjB5S80bwwNuzdSuHO
	fRHGv7tWi5c9eT+IYD5gOMShPnFzs+3Sk9MJhBiV0eeSzesRsnoKaTj9sIOl7lXd
	nFMjTvp74EVKl3vWW4CukordJ41Unp5VcP4FR51sTnqfD4KuEI8h4hVLVSZiUrvh
	KpDbGRfebTPuaI3ncwl6ltsishdUKd0Haa8lqoi9hBKDNmj7Tz6ATHxvMsjmcr1U
	Dlu2ljSgAvaeyg5UzBOghWN0HiCF61MeioP110PY2tX6DwL2mXhNbvMAA+Ep5rYb
	2ya9tWdkgIFu8whreFbdZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738680428; x=
	1738766828; bh=OiMYi0RPt/d9AySng6V4J5qWiM8+2bCFGnBBoJsCNv4=; b=L
	TXmylX8CrxAAbATAchvXDS/GqcDi3Tv5bwxF87q9nNeQwkDzQ3gNxHGZ0U0yguUc
	JXThDF2lmYZVqhPsEAPDfshUPs5EQZCkP+F4KQY3Y6ZLLiPfriS13PM/42rFq97y
	be4akBhr3mlBZJjy52IeaKdjeGZOmp48viWGC7ysBu4SYXyxQ1eGKDIBkqf59KsT
	J+VrNZs7otn/p2gyQFuJW0HtKPYU1RkHWfR4c62dEM+I2vEB28GOJrsr+okMGS2x
	AEwNNM9dR/+beQB3n4ZpatW+ubPEvOi7rqXX3w9HVGPnHLtEKvwIK7363TZ+7cR9
	GER2UgZn3gahQwSAoWkQg==
X-ME-Sender: <xms:bCiiZ7vWeMpsC1blKUjQaM2HIrafZHKprTaV5KXB9Vzzju7Na50ERA>
    <xme:bCiiZ8eLuSxGOAR9oZ__4E0rvXl1NMwLZqoxLMLIlC4uCbSw87ygb6EC3qfrjCojL
    icb8Xavoe1VQ5EQFA>
X-ME-Received: <xmr:bCiiZ-ylaSOc46pgs4NzTFafaoXPIal97Kn0FQDc2qMVAcIf1pQjL7E1fuGb5-xqQeO6jddxRCVFZQ8w-GSjAx3BN2zL_5vFE7T1dGU0wZpErg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgv
    vghtshhonhhifedtudejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bCiiZ6MZgeEECsNKL-LVZqFxillFmqtNwABU5-Yd1JfkNKM0x2YM7A>
    <xmx:bCiiZ78giDkoqKJZazhiHfziGKiz6ccQDHHjj1JM45BZVGEVEdHbFA>
    <xmx:bCiiZ6UnXB9N7fnahD0_8lQkDreRajKG-qc6-xXf6QQaHMq4EHcRKA>
    <xmx:bCiiZ8ewlDrF5Ndmn1mHCpwNaEnLSEscCpxQo1jhG4oZrd6OweoB9w>
    <xmx:bCiiZ-b8AWMZL8ieY-Lp2KOF1a5xHBRyEvuNIpvAhgHKGS8pz4xAHTLS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 09:47:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf7333a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Feb 2025 14:47:04 +0000 (UTC)
Date: Tue, 4 Feb 2025 15:47:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC][PATCH] remote: relocate valid_remote_name
Message-ID: <Z6IoZ1_1wGiOo4Bi@pks.im>
References: <20250204041430.36035-1-meetsoni3017@gmail.com>
 <Z6HH8mWDpJUSHDd7@pks.im>
 <CAPhwyn094ySxG8=p3_jF+Z+0g6h4hL5ELBYhOLv+Th8zX04Urg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhwyn094ySxG8=p3_jF+Z+0g6h4hL5ELBYhOLv+Th8zX04Urg@mail.gmail.com>

On Tue, Feb 04, 2025 at 07:36:24PM +0530, Meet Soni wrote:
> On Tue, 4 Feb 2025 at 13:25, Patrick Steinhardt <ps@pks.im> wrote:
> > The change itself looks straight-forward to me. Did you happen to check
> > whether this allows you to drop any includes for "refspec.h"?
>
> I think you mean refspec.c, as refspec.h doesn’t have includes.
> Yeah, I did check -- no include drop found in refspec.c.

Not quite -- I meant whether any other file that previously included
"refspec.h" now doesn't have to anymore because the function declaration
was moved.

Patrick
