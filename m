Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650A1862
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700224; cv=none; b=AoqEyEp+6bnw8iqFwb6lzvvtDOrjjBSz4fUABTyILZw952TkoXsayUX2wH1GlvujZ03wmYkZqcYjImNTOC96UwAA0XsC46cfbqyy9+g28lJfF4hOQF5GbPoQ8urhRptHFQRqJNgc7YEIignj752nDUF8sF42sG/R8qYvJKP7dZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700224; c=relaxed/simple;
	bh=rR6kLjBb83s6uIGqKHWBIvydhFwM3wjaaeKuGvPAWWY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TggNLJc2P3AX1wi9u9eexdJOG0dzp8u6C8gx4YQsKhZQW84JtifUdZcx2e276bZ20ky+iNGgXdpLfMY5Xm4zJMKWKxeHAgJIH05ASQNuLB5njefW7SsJ+FMjrg7aIWYo/uXxUhV6Ay2zIxPKpkqt4m/E+DSH9tf2znJrYe7gE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RKc//gPf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UyoPdGOF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RKc//gPf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UyoPdGOF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 33B5D1D001A1;
	Thu,  5 Mar 2026 03:43:41 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 03:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772700221;
	 x=1772786621; bh=6d0E3YghWbrSuBYWbU2/N/pF/FCxnJIQVhwplcaY7JI=; b=
	RKc//gPfWytmfW3LVFbkzzLUw/xSkBsJsa/S598IvsKdPpmg1ag6Aj2OzbPlJF8y
	Z39bdfs1CDXroR24QPJma98uUxpneHvSJvi3unSDyDsdm1gO+BXFcu/Cufabx20k
	OZWDmAgZjIFLLqgQDb3gS1l0rrPiYgjFgaKNig5vjZTtzBUeQPlYx1yzWxId1Gnb
	V8/1IogQXhqjanyYCQAPAHBM3IfkCiEvc8tGBYppRaHkCHyo7WDv2XfQYPRQurv/
	h0A1ZOIQ8TffPm4PMvirgX+MNq2ywEnbnF76myuWYX23fv3jaZMlax52B+XRkTgu
	EMifGI7C9OdtPwlOS3ndcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772700221; x=1772786621; bh=6
	d0E3YghWbrSuBYWbU2/N/pF/FCxnJIQVhwplcaY7JI=; b=UyoPdGOFcNqJdzgcD
	Kes4o4inIJfIKjdCL3oMc+YAAwck9mIaPYNd+wIDQ8HD6wXx1whHsWFh4ak6k5hL
	xrrj82uyIg/h5JuXEiiUYf2M9r6vMGrKGEx5rnMeyp4GwIsteaoS4wKYOawFr7Fg
	woi8LFee8aU0Rp1z9ytpLtC7jKMkg1EF8HC6sR+8ZdJ9A+W4HMzgSLVGVIFsNHif
	4bDdE30TbuM6OdsxHlC+XBS+4UpEAytU5ItExFAkFGB7q+nZpPVl4Rb99LFXypQY
	2QD5MdJCZDB19IJ2mj2qjELAhDwHvrRlSMJAeYKxmDWt1Tux48KW3AJTbjVscLmi
	DuDmg==
X-ME-Sender: <xms:PUKpacdmM2H5UeoHIpemUGRZ0QRcDYoLhN6axnXXlgz4Tbbv7zvnyaA>
    <xme:PUKpaZBgPL6R0y2b3kNv995QlIqqEvCzl6Ttutd9BKXLEJV7L752TLbm7_Zbb3k_X
    BfKdc3jTlE0qVmx5sn8dNTpFZehley7z0b0TMtqTMXEEPzTR5UZEYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudek
    veelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:PUKpabINUUKcUSdJ82h7UTPY0FCzx4k4qd5erJ0iP8EH8Z0VRnQqIQ>
    <xmx:PUKpadEJwzJVLE62Ahd0CqNl-brjMzJEoyjwBNSGph6royuiUJMYNA>
    <xmx:PUKpabRxTwybFwCoM7q-edD2ZN4jXBqV02qyEqSbiQw0yok0wmiqTg>
    <xmx:PUKpaRENgyU4Ug_og2tmTUqSYirhbyOTNGROQMC-4YMYYANph_CwDA>
    <xmx:PUKpaeyFukTmR9CHGMGKl86y5moomo_ub5Xa_-MiqjFNpB3a8vjtlv3F>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9AFF51EA006B; Thu,  5 Mar 2026 03:43:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 09:43:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <aa5c1999-24b5-4ddb-84e2-f5ccab4fa6ee@app.fastmail.com>
In-Reply-To: <xmqqzf4n3zun.fsf@gitster.g>
References: <xmqqzf4n3zun.fsf@gitster.g>
Subject: en/merge-ort-almost-wo-the-repository
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 5, 2026, at 01:05, Junio C Hamano wrote:
> * en/merge-ort-almost-wo-the-repository (2026-02-19) 6 commits
>   (merged to 'next' on 2026-02-26 at 4c07a66173)
>  + replay: prevent the_repository from coming back
>  + merge-ort: prevent the_repository from coming back
>  + merge-ort: replace the_hash_algo with opt->repo->hash_algo
>  + merge-ort: replace the_repository with opt->repo
>  + merge-ort: pass repository to write_tree()
>  + merge,diff: remove the_repository check before prefetching blobs
>
>  Mark the marge-ort codebase to prevent more uses of the_repository
>  from getting added.
>   cf. <143ab1c8-9f07-4df7-8200-69b5a78a0351@gmail.com>
>  cf. <aZ12rYYwbh1fvrnE@pks.im>
>  source: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>

s/marge/merge/

For RelNotes.
