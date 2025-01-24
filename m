Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BB22087
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733640; cv=none; b=VZAPrB2IvaoXyxCzF+RypDdRSc545mygHW479fSGtpOgp6y/oG0S7Y5Rl6/0xQ55ptohQQ8Np1peppVYZ4Ir+ctXLBRrejP9dLoEOdNojRreMteIFo54pKh8iKYUNjY3BvZvzA1ul4oANO6w77lGToJHomUcVgf6XDrt36cFKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733640; c=relaxed/simple;
	bh=wbxceSkb+w9EzxXB2iOkmERG2raJ4TPwXwjxDAUo3gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3BdnJQEEP/YPuzErrRPMICw/UytCaeega2T+gZlSXL9tKDJUqxky2WpouYg0M9lGqHzcylUC1pSporcn0p01TsEb3cxMHhkOsvNOgx07dImxR75mgaldL6lraAZwzbdpfcO1gX/taoBySaZEhIpT2VlIguOZKRNIqy434jC3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vOpde+Qh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHfCkP41; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vOpde+Qh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHfCkP41"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E793B1140176;
	Fri, 24 Jan 2025 10:47:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 24 Jan 2025 10:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737733636; x=1737820036; bh=Si4ruh0jMa
	ZPQbvdT0he9ouHprrz8rOPyoOtU03uitg=; b=vOpde+QhnDwwzn7JQJjsevl4ZX
	yjeYErBv1ChDpfNzbJC57jDZp0KtCw+ZyQrIlNJG236zi1BjN55KZgq3S2+5zbPG
	6r0L/R7X/ZyGm5hLVkIXV9sTS7T6CSzLzOu5OsmbVnqYyw/X8eAwidw5AudEHIbs
	FiSw6ndZGUmXkK5c0VqfYaKx2KmnBlTeO7SpjXxhUXOkF5Rk6g/QXeUwRnNqEV1I
	WgNY/qa/h1Go8ALbsKFn864DQ3xGzGuSKaMWPMZBlepczAemeZM+gvMH6rOgjLQv
	aN7a6Sm1gez/gfQBHgA0vt0f/04VL1Edjhzwfrj3wiryHwn1T3Fa4SAZKLig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737733636; x=1737820036; bh=Si4ruh0jMaZPQbvdT0he9ouHprrz8rOPyoO
	tU03uitg=; b=oHfCkP415YWTOiy/bdjI/eeG9EnAlGawsedpdGa91nlREY2TC13
	9a+spBTXLczEEKtuQCVizxoZ+VLfD7MXGCv5jISkPy7Zj6+Lij21yxXR/56yKjMd
	UJHJ4de0/QU0puziEKrzX5budZ1JYVckKJiVTH2IbCnvV7v7F2g7ysKxwjuDrWDI
	gZgQGWQYO820G8b2TiraLxyZvewiZd+m8jphvV7AqxSngLgJEz1pCgttUrhgw3sI
	aX/qN2VG1hlj3SWLOOyHibFet+bC9V+VQ8fsA5lkQoV1uhWOLjzejkoEHMVEw5Aw
	AjvP6U/gjMh3dXfgx9WJtBFAHfy95oXLC7g==
X-ME-Sender: <xms:BLaTZ6OmEaSuGVKmA_mURMCwj4mNgr98qyY6PStFZSTJ8xDYIQ1SHg>
    <xme:BLaTZ4-BdPdRUQpTxSHAHSmLnqHGo5NtBO1cAdvhgS6pEnsWCBJggOpBuJ3k8NZWt
    xomSSbqgq7SUsqLRQ>
X-ME-Received: <xmr:BLaTZxT8NXKUR2W742h9rhS1NKpnSxj7Qyvy-KV-3ACi31Z25V_MFJzJo754RmaBxf2DyCAaKRg1iC9Jv50NWopV5613pzOdoTYa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BLaTZ6u4ySB_qTYn7q_4NYP2hS-9m09KQIo9d7RBM_FsipEylryvWA>
    <xmx:BLaTZycHtfUMBQoKp2LuUMfa7Mr_p-TGUwnmVl_Hh5uCKA3kshnGSw>
    <xmx:BLaTZ-2xWy0Fa0iPEFBxHg3NsWJJR78jPKvBYlg09qp0NJ0rdtts2A>
    <xmx:BLaTZ29B_7BJ1vCKxDzzQ0DgPKT8A76e4YjS3QKdQcPOynnUuvvI9w>
    <xmx:BLaTZ_G5pvOu23eBVz8UwffOpUqFSegsy9ETpwqdZBy11spvcYaG2MrN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 10:47:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com
Subject: Re: [PATCH v3 0/5] pack-write: cleanup usage of global variables
In-Reply-To: <Z5MpOelecT-4ym7B@pks.im> (Patrick Steinhardt's message of "Fri,
	24 Jan 2025 06:46:33 +0100")
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
	<20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
	<Z5MpOelecT-4ym7B@pks.im>
Date: Fri, 24 Jan 2025 07:47:14 -0800
Message-ID: <xmqq1pwsqkn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Jan 19, 2025 at 12:19:25PM +0100, Karthik Nayak wrote:
>> This is a small series to remove global variable usage from
>> `pack-write.c`. Mostly it bubble's up the usage of global variables to
>> upper layers. The only exception is in `write-midx.c`, which was cleaned
>> of global variable usage, so there, we use the repo that is in available
>> in the context.
>> 
>> This series is based on fbe8d3079d (Git 2.48, 2025-01-10) with
>> 'ps/more-sign-compare' and 'ps/the-repository' merged in.
>> 
>> There are no conflicts with topics in 'next', however there is a
>> conflict with 'tb/incremental-midx-part-2' in 'seen', the fix is simple
>> but happy to merge that in too if necessary.
>
> Thanks, this version looks good to me.

Thanks, both of you.  Let me mark it for 'next' then.
