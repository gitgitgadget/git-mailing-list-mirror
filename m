Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC512C3256
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926656; cv=none; b=IpXBdIV47oVf2ECGMMWY27ksYwoKZ7r3hsCIqL3Q0zJ3eGwvnPzAz2/eHrP726JR9UWqi07HXZrXiyuJkB9wV2IAHtl7emtYNUjVzDux3Adnow9f4IFd4P/EO9W1SOmFylAgPrDURRWSCBSpx9Mrxhb8Ao23/6kmE+yAvcwq0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926656; c=relaxed/simple;
	bh=cSrETSUr0WII3okAim9A2Rm0JYflFTpDXST3tc3HaWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXhHm5SjmEe4p5e0mOF+9GZRDv8PImlIkaweSAf6P2N5xao5Xb026Eq+mJOYXviRqxtfmFjZ+dRM/PxoU94/JG36CjYDNbi5aWpPjz2eAzkSxNFG1roHh6lGNkCPqws8/MoYSJRgjmt+xhdc2b0U7nFvHizbO8sa17o83fcI7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bcntGhOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imvpUE6L; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bcntGhOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imvpUE6L"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 591E2EC0271;
	Tue, 20 Jan 2026 11:30:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 20 Jan 2026 11:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768926653; x=1769013053; bh=cSrETSUr0W
	II3okAim9A2Rm0JYflFTpDXST3tc3HaWc=; b=bcntGhOMpN2rnAqvm3g89I6BP/
	D0netUmxsLEsLXh+vxSzvPUCGKa+GsK/r67Ma45fRueOU1Qku7f7fQZkXtJn+FIy
	388ofh1ajvXdAocGUqd7FaPIai0y+QUu6qRDw/2BbmBCmXn5lAy/1gRRUQADABe2
	Zyy6gBpSpzRZ9gCLy77Ro0b7HKTN2r53yfGu718anjgPYDWtHiIoBfhT2H8w4RiO
	rwc9V6XXJNt5kf6kTdtM6Hgd9aB/yO7Sh8DoS7qVEbUSDH6lnc3S6tMSfKt9lSqw
	dhGFlz7IiyW0hAoULHXYicWJXVXJHj/euHwDh9YSqXN6KJSEeJq6R+rrNFgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768926653; x=1769013053; bh=cSrETSUr0WII3okAim9A2Rm0JYflFTpDXST
	3tc3HaWc=; b=imvpUE6LMKxgSh27+R89YNC29v5uKMn4qcTEd/0YRurewCOHsuo
	Uem1BkGhuOq8fLibniuyRxD+0wBDCNLcxGRe5pbS5Vi5eorVjaCEoXFl1pC3CpSK
	J0BYqYi17UJsKZ1CM9If91BOHTzrlszgPc/cAVSRZLfzpaIh6B3M51VnmyUuA/sF
	qLsmypZQjjHm4N6EQcEIA/D4Z7Q82DXyFW9DH5yKRah+Zz1meAwyqrOfH2/eRkNd
	Ud0NmwPyVxLpgdBgEsukH5y4thtpcKoCVOLsDGp31g9x/UyJ0EtVmFS2raqrnRdP
	NFi+gA054V293jxxcsRF7Goc7utHW5+DuDw==
X-ME-Sender: <xms:vK1vaU3JFMhK4430B6R8TPmQQhCKbYWIdcPxSS74aeAafD_Tgf1Xzg>
    <xme:vK1vaWjbgugPTa4TasyaGbZlxiyVQuz0GbhMwZaPexeUnKlAMavK8BMItwW0w-QQU
    tjNQW_XSncwrSyephXYlPFtmhWqFgLuJFndlVTJeek_PbdS710IXw>
X-ME-Received: <xmr:vK1vaaTjNDmwlr2Gv5lP_1IZI-jshEl2dcN5rsOVXD8cJNn97zBn191cUbQhiNqD_RU2C5OIwG3pNARIyfhEKlE4hdgfkENG-5fnyjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:vK1vaXjIBNx5zrdU-hlzMkPe1wl71KF0Us3jHUY0MJJvy5m-cFSXyw>
    <xmx:vK1vaa6mJkPn2m-_5ZfoJbwzCDqVfKbbXSyE1dzlolyIhB2Mf0uq8A>
    <xmx:vK1vaUDNLujaMPIIiCQMJ3GjzrZ81jJgxMQzoBNaPyF_jqH8TnZGgQ>
    <xmx:vK1vaRbuJw3ACgdxz4hEoXBMBSHZ7Von4988CWNcsHP00LrT_GbLMQ>
    <xmx:va1vaSZSuiM7gQKhnt_oV-wcHpZKBH9-BgCO6WYzZgnMgi8XSeOykhqP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 11:30:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #06)
In-Reply-To: <20260120150241.601132-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 20 Jan 2026 20:31:45 +0530")
References: <xmqqa4y832ok.fsf@gitster.g>
	<20260120150241.601132-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 20 Jan 2026 08:30:49 -0800
Message-ID: <xmqqqzrk1c1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> While going through, I noticed that patch [1] related to
> t5500-fetch-pack.sh doesn't appear in the seen branch yet.
>
> I just wanted to ask whether that got left unintentionally,
> or if it might still be pending any updates or changes.

When I saw it I thought "gee, the implementation and the explanation
have changed so much, this needs a full review", then I got
distracted X-<.


