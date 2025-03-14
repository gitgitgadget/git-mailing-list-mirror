Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA01FFC5B
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964441; cv=none; b=lUFhCNd7OC27tCBLVLmYhhgDeSizQ/loTJg9r9Zi9KEkgQgFq3MH6f3Q1Bh3GW8TvSfbU4GsHTwJQZZUEeLIANn0xHIGihY3Dd2VJ8wu2mJ6821ThKQXP5V8rYMKM10GRIJ5lFO3iEvvG5O2kUj1FUBe84FenmDUgq0SCSX0TA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964441; c=relaxed/simple;
	bh=vnewZKT/HIK8M7ytWMFSjp3EIGI8gkqkyDOJXOlWdss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAtKz08FULNvyQ/pacgAoXqI6RBa32eucvVWXBdXQY1S8tzfLJrJDi2BwaRB06p48lw/fAvi0I9Citbd5SALFr8p+cZkRXdAwEodB7dpWzDQOT4jmN/mLeGbqLN4afLbXNXgvdvSgORhpvQPHFjI3fgL1YVgHUSrGnodgkCafZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mo+2tOwN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vehGgvva; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mo+2tOwN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vehGgvva"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 517ED1383184;
	Fri, 14 Mar 2025 11:00:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 14 Mar 2025 11:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741964437; x=1742050837; bh=cw0aNnZoXK
	7FOJDx4+MyufjTMqdIeny8e8IeWcimlRI=; b=mo+2tOwNW5MR5Hn8LRZ9wY4flw
	5ksaEA/VBbbW3IaPRm+IM5zkALtdH7k8DigcwlNPh6lHZg28eDe4Z7Maw0WE2bUQ
	WCK9x57Jyk0mDPlZsZ5Afb7hsBC50o+IlkYnFwQstgWjnYDBFFSMuAwjelqNaZNZ
	A4im55eZ4YuCLylCLkRciek+Z+5NLOwI5Yw4BWCbJPhEVBOX2zr94F6e2gL0Lo0e
	PwvmNivJq2e18QyDR/TjWrl/14/ZLsXTsr24T/0+4Ut6cZJ8mtNzUQSNoru5k+MY
	BfezdxgifbTBaLw+dRZX0MHgvlm4zT/mZVgIxcqd8W1t7f4Wdrplo8dEdXeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741964437; x=1742050837; bh=cw0aNnZoXK7FOJDx4+MyufjTMqdIeny8e8I
	eWcimlRI=; b=vehGgvvaiB88SQvmQLpsApLkMsC8m57CATEbE+nkMhXESwjX7/Z
	sLs2+VMeKcDeLLZNMf3bbCp5QUKIzu83521S6h7Y2zdx6PiPTQvfD8qQUoF0z85a
	BPYlMAvR+jpnTYVRv+IvN+NhIHFh/LcZzGkn47pw4oDZNju6/mX0oyWbA3x8FcNS
	jVFreKhsihDqtg63zJYvPN5iiQf5A42USI+7plmU9GacqCkJL7rLpIfqk8dmmfLH
	fRb2S135j6BOuJW6q9WWmd94/lAYu7g5AV3Bvh0iyns4fMp+iaY3YBFvrK3hCsC3
	uXKi3locup35lBltUOZp243GG75aNc2DyAg==
X-ME-Sender: <xms:lETUZyvBrxfm3lpdZ79uNeXQUBfS0-ItWYK_Pi-P4kCXsLJ-wuCL6A>
    <xme:lETUZ3f9-6KRaiTLqwl_EUaxM6buQIHk4DNawHkUKTvhDZhw-p6-qwKFQ5VSOkfks
    gEesuxkoi5Jd5kXkA>
X-ME-Received: <xmr:lETUZ9wtGJ5p7Z8vSwNwtgc0LESt4-5JHve1PlKoH4Qn9b0jjH3vVa46gWiHKvJB9hOZacA4AHHCYA8-eJdhyhFbeAzION3EoKAW_0Cg3x8T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopeii
    ohhtthgvlhgsrghrthesthdqohhnlhhinhgvrdguvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:lETUZ9OaMl1uAmMItIMocN4AowUh6iaQfN5lgkjUy-rF-MbqkhRf-w>
    <xmx:lETUZy9CbRZ2UDmNvdqiDginl23ojwT2ryTrrOHwFkWZQwrsAESA6w>
    <xmx:lETUZ1UENvzMhdq6N-0QNVQwsI5kYX0cjintfdh0jyjB514uYx4eeQ>
    <xmx:lETUZ7fH3RFS7iIDiaWoU4aERbmAQqOeObieWtah5aiI4v6pQ5hB0Q>
    <xmx:lUTUZ2b2Bej5NlGWsQJ1T-NvQ5P8wPrA9fF2Gmh9eWOESOT-x0LFPILs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 11:00:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4175c8e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Mar 2025 15:00:33 +0000 (UTC)
Date: Fri, 14 Mar 2025 16:00:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Reich <Zottelbart@t-online.de>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
Message-ID: <Z9REjHgrhzUzWoqJ@pks.im>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <20250206-b4-pks-reftable-win32-in-use-errors-v2-1-56985a4f6186@pks.im>
 <de954c02-8711-43e9-8f4c-259718034497@t-online.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de954c02-8711-43e9-8f4c-259718034497@t-online.de>

On Fri, Mar 14, 2025 at 03:18:55PM +0100, Christian Reich wrote:
> Greetings,
> 
> the patch didn't find the way in next git version.
> 
> But there is a change in git for windows, which prevents multiple asks the
> same questions:
> 
> https://github.com/git-for-windows/git/commit/dba1473162b4319a0a2c7f74ab48ed4a826f7ac7
> 
> The other option to prevent the asks, is to set GIT_ASK_YESNO but the sleeps
> slow down the process.

The patch is still blocked because [1] hasn't landed yet. Once it does I
expect the patch to be merged. But yes, this will not be part of Git
v2.49, but of the next release.

Patrick

[1]: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
