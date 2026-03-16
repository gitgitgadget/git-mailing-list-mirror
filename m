Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21141448E0
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646779; cv=none; b=da/aQrIoiKBl3e2+f7yDDHjKVGvWuI2fkLpQPIUv/GXLErF9gT/tqvlpAHqJAFPGSnjqSxFZj8wW4t3gsl+cGPMa5o3e+r73qPh8FumZdgrQvN68C2IVJ25CRmwvEzJK6UZIWeXQDdhrQvd4PbRehWr6+esmnxSy413EYrQOEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646779; c=relaxed/simple;
	bh=5Mah6jsD/o7rNXPj2FujVnYIyp7fkcgJM3oWxOwqwus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a79eXvmm9jUlhLx1WxuDnw2sLgyjoW5VmkxpOn5meSTQ8vvKLzMCir5HpckcRGVB+5IzRWlJlo/IONJfx6PORnfUD8Tku/QUWLuX16PofRuTVNkGQRVXWjPLiHsQ18Th7EH+7MaMn9OdXl9v7P/4zyS6TtoHsPPmoKgIXC1Sdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oBJ1V5py; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRxsLVxm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oBJ1V5py";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRxsLVxm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22FEF140015A;
	Mon, 16 Mar 2026 03:39:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 03:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773646778; x=1773733178; bh=eDt/JlWBy/
	ENoTAbxjTHYZ5wQ6XweO97PHSO+umdNXM=; b=oBJ1V5pyVgHV61rmph2GWWTlsK
	1Iih8zp9cxd7HCV0kuUCOk3kSZ8vhO2v2jf15I1Ujjl4xC9K6TO6D47BTL4IQYW/
	+nkY5B3Aa1mvUUG4b5oaDQ9PkUfcJeWsCgS4ZaeLuvTxVTxul0oZpAfYbaf4i1MP
	fIezkGl/p8aHEchm2STaAkHS82yO1X9NEwu6mXlN/RmE0n46J8nlqezM4I/e9usV
	MbRSUH8g6SxW35lGbfCdad4vmvKJeDT52uOFdyFz2/JDuLh1Ks6P08nc654kgVaw
	zvnmR/iWlcBHeupkzx5dDA2CMLpo6KDIu72QtT86cyLh9c3DsjOABGNUbx8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773646778; x=1773733178; bh=eDt/JlWBy/ENoTAbxjTHYZ5wQ6XweO97PHS
	O+umdNXM=; b=lRxsLVxmxtPJh1sJKLb57OWmZOB8BukmixDZJPK1H0oRlq5kjnk
	Ne9pbH9HRnV47m0B+WGsr0356a5kpWaGJKm7bgp1NVberAxpF9z1LgC34uuI8akD
	cLFnzyyF9HSxOHVMABCKTDMAJEGluu5+4Lfvkkj6I0edSphdH8lb1f8uWuUN8d5G
	BHCipBXKz9UAyZDYHWTRDc6Lehzi9+1yNoT827hVSry3kJJBdtkWFycirxQphC2h
	uWJu/7jDvxfW1Celk8RVtkMx195SYKJZgAjN9vFjLfbLiF4DR7WPsXOlh6KxRuju
	3ouQXiW7M7NYUjytRfKo5IzT8wKwAxq1wZA==
X-ME-Sender: <xms:urO3aS-17bgfdOoJb85NLkyhXN5tDf7kZmwfd55iY1WZaBLybcuKZg>
    <xme:urO3aafiHAD8h3YancEX0W8kHRf3T2-X4L4N10YOswskb3RE0dq2mnk9CGnddWOnk
    bN7SGQNXILFBemZHl0JW0jVBYtSMo5PqQw9F1ggcUOTeqn4hQpPRQ>
X-ME-Received: <xmr:urO3abEGRC7fPmvMfWUYcZZV2EpbwbI1vwov8Pk9KIckTwHPoHGCaAFOj4XupVPDgShDgH9XCSM1IIV0ZdmJSpv4SpTi2zKQULk0GeS-4Ms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:urO3aYdgt4SbwSjBSj8kQrPFjETEI3ZoD-wa3o9bBRW9nXqXyVnGMA>
    <xmx:urO3aVFtFL96txUwhovYrhqUgj2CBjWGpnkgAn6daO-WOtdAWnEk2g>
    <xmx:urO3aRUSxB02OfXwXJitWUmzhSeJzjd4h26gzvaKGkAfQXHiCoRdbg>
    <xmx:urO3acKeACRyG3zBuMJsqVa9RxupWV83PEjaDeXnsq5YZTkHetTPww>
    <xmx:urO3aZVGq94Fz0IbMxVCHoYHILI75ew6c91VbxtKchUJeWAmV4NRVRN6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 03:39:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4af4b253 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 07:39:36 +0000 (UTC)
Date: Mon, 16 Mar 2026 08:39:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] worktree add: stop reading ".git/HEAD"
Message-ID: <abeztWLCxdWADCJ8@pks.im>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
 <cover.1773591528.git.phillip.wood@dunelm.org.uk>
 <c3c5767725d6d3b31604fbd0dd29486b70bc18a1.1773591528.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3c5767725d6d3b31604fbd0dd29486b70bc18a1.1773591528.git.phillip.wood@dunelm.org.uk>

On Sun, Mar 15, 2026 at 04:18:51PM +0000, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> The function can_use_local_refs() prints a warning if there are no local
> branches and HEAD is invalid or points to an unborn branch. As part of
> the warning it prints the contents of ".git/HEAD". In a repository using
> the reftable backend HEAD is not stored in the filesystem so reading
> that file is pointless. In a repository using the files backend it is
> unclear how useful printing it is - it would be better to diagnose the
> problem for the user. For now, simplify the warning by not printing
> the file contents and adjust the relevant test case accordingly. Also
> fixup the test case to use test_grep so that anyone trying to debug a
> test failure in the future is not met by a wall of silence.

Oh, interesting, and good catch. I fully agree that removing this makes
sense.

Patrick
