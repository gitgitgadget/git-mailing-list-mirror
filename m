Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B32942A
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735749948; cv=none; b=YRpk6n2eagteajGlM3P8A5AEhkz+xYA+jJ9BOGqYkTV4pDhK1O803YkPRcP10/FPJ3fpebA6GuGhy9SYy5W5+GlYogFuEeuvlz/rTQOXKcb0zySHUHDPKAdqPaenjfwddwhe7JxdAcu9v3l3dyn6rz0203sf+g20JtpuK75qI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735749948; c=relaxed/simple;
	bh=pWMnpgPqkIq3NRk4PLM3qRzhWViocSwYtfZJJL5ON0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKTD48M+HAo1pldmHnq5CIiUoG6mDP1O1FQG4oxsJnp1uprhwkRS4oFrgSNMTjDc1n1ROPFPmNFarutw8AuYzHjMxlm5Pf/nmQ2JfFhI8K16bUAB+kJ/Gr+qggPehsvWkIA+jY81v26s7qBeoGlestTMDZT+xaG867dbcd+8oFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sOlb/tzi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6BLenHj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sOlb/tzi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6BLenHj"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3350813801C9;
	Wed,  1 Jan 2025 11:45:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 01 Jan 2025 11:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735749945; x=1735836345; bh=mvOxQA86UF
	ab5B2DRqF1+86E9hm/YYUnEkDJdGF0MIk=; b=sOlb/tziFxkPxgMoX69gtfhQWW
	FJGKyi14OglrnpDML6eE6yKC0QIA7Hfe7MM+AbhlOsDN0iG2/C7WQWgAUbWhW8MO
	zLc0l0JeZCJ9TSJAnfs4gikz71HkmLenhm/1CnrUmHd+n7eRBW4YzJIWvzWUU00Q
	eK8wfrJ16EUaYwE00SwROxBXQHr7M8IptS9xBsFMPUGpSaanFjgGoXxJhVck7SWX
	ibrWwqkDMcnEIC2jgzntkaqQJ+ZmtKIXLQ1PqA9GxrTqmJ3MFVUgP5Bal0PlaYfg
	TNXHW2AP3aicia6MaFRlzt/T4B9g3mi5Ys2L/EmL+HtqautHiadyCFFDtTbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735749945; x=1735836345; bh=mvOxQA86UFab5B2DRqF1+86E9hm/YYUnEkD
	JdGF0MIk=; b=p6BLenHjJVwpAd5+fvWt6WX4mwc/JGEqO74OZMIGrC376tVQFaH
	2J7Q/JrjFPsc35yIdz6hWq7gmtDCSlLGNjAIyJ3dQX8R3+HlrqzMa2baIenSC2yb
	BsXST3GoMvbROLDoBMRAWyz/w9xbY73MAqBnpL3BihhVVywwktwxlT/InGoaTUwF
	h9NQ+pDuVfg9WbLA/7IthSaHVUpatLhgBIiGcNiSHxsA5crIfA/X8aZi40KBPVlT
	8mLbki5wXgWFV4GToPBXRHXdPeM2h1IlM26q0fEEWHAv6SVUg6OX5a9BjL04Ux0e
	BIqNcqjyRpUA4jgNGRm2s563eGpv4EidFKw==
X-ME-Sender: <xms:OHF1Z_G6SYUfCsBnysj2YhHj2OzhU51RVVffCmce95cljx2KT4USlg>
    <xme:OHF1Z8U6e5pQf5AOiyYl3P7sdV5MR1Ja_F1jt7k8fTxAsyKiQzMJzO5ca7pnwx01P
    XHWXWaYVu3r5Vn9Ig>
X-ME-Received: <xmr:OHF1ZxJcQXiF7ObQLnL5ib3lyZ9sS_7UbZiKRX0sXtTvKbugxUzviavs5Be2Q0teZ8kK9wQ908BBgloe75Rveq8-BKrE18RxAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeftddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtqdhfohhrqdifihhnughofihssehgohhoghhlvghgrhhouh
    hpshdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhrohhuphhsrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OXF1Z9HLB66DbkZGkF3qxaFg3I6yI_3C_NxKnISFFSN_acmre45tkQ>
    <xmx:OXF1Z1VSX3mYnD4f1ivmLpXNAn_j-wj3gue_0cYlbnoOsYLNxDqOZQ>
    <xmx:OXF1Z4MI0W7wTUgyTsI0SPWC9OLIehf1HO3ZdGX73Mo4AAexyFU4QA>
    <xmx:OXF1Z03jB-LRa1df9MiOtdKu2zLaQYrU92pEqjLgxPiJwB_lceXGiA>
    <xmx:OXF1ZzdEZ-w0oj7y78jr0fGg2HbANSpoGc9VxMoBsEqkfBWeHlTKxVIJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jan 2025 11:45:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git-for-windows@googlegroups.com,  git@vger.kernel.org,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.48.0-rc1
In-Reply-To: <1MacSe-1u4zn60o7G-00obkK@mail.gmx.net> (Johannes Schindelin's
	message of "Wed, 1 Jan 2025 10:23:29 +0100 (CET)")
References: <1MacSe-1u4zn60o7G-00obkK@mail.gmx.net>
Date: Wed, 01 Jan 2025 08:45:43 -0800
Message-ID: <xmqqfrm2xz2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.48.0-rc1 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.48.0-rc1.windows.1
>
> Changes since Git for Windows v2.47.1 (November 25th 2024)
>
> New Features
>
>   * Comes with Git v2.48.0-rc1.
>   * Comes with cURL v8.11.1.
>   * Comes with MinTTY v3.7.7.
>   * Comes with the MSYS2 runtime (Git for Windows flavor) based on
>     Cygwin v3.5.5.
>
> Bug Fixes
>
>   * The installer now correctly blocks the installation on Windows 7
>     and Windows 8 as these versions of Windows are no longer supported
>     since Git for Windows v2.47.0
>
> Git-2.48.0-rc1-64-bit.exe | 205d78a134419d8c4cae8a8287f3cd43df1577e3548f9aa298023c95bbafec2b
> Git-2.48.0-rc1-32-bit.exe | a0333a4a5f4f91aa91587efc0b2171940059445c39dde54284f320eec0b3975b
> PortableGit-2.48.0-rc1-64-bit.7z.exe | 4547c8db412d7a1b840074701e16354458181a54b7eff838eec3ba3023e079ea
> PortableGit-2.48.0-rc1-32-bit.7z.exe | 6fd50d8726793006d1961fd9d03c1cfc94a4994f78bacfd835c1ab58f1d5b56c
> MinGit-2.48.0-rc1-64-bit.zip | 139255b6f7cdd14c696da58e17bd3284cd7f0975fb7c45f20f8cfca8115acdd2
> MinGit-2.48.0-rc1-32-bit.zip | ea5eb4332d51455dd5850c9a4a265d158b8a7bd8d9d280a0bc7c485d4e77dcc5
> MinGit-2.48.0-rc1-busybox-64-bit.zip | 769206ce840d18ad1d6185ba2fb56c8593aebfbb9a26aae9850dbd35b35a2a6b
> MinGit-2.48.0-rc1-busybox-32-bit.zip | 92a16a3b491ba4c6c6f68d30ba29360bb75db014a834c8947cd543d427be784e
> Git-2.48.0-rc1-64-bit.tar.bz2 | 399e604024fc3c3c476aea8d817c39a31d509c82741379a5c7cd49b50ba75b42
> Git-2.48.0-rc1-32-bit.tar.bz2 | e055a18ac811ac77a6372eefe1833dacc91a0add9c8cd2d971b22a226a30f0b4
> Git-2.48.0-rc1-arm64.tar.bz2 | f37ce1adbd91c195cf333f8713ae7964dbf169b1de5882353e03b727f4ec8e79
> Git-2.48.0-rc1-arm64.exe | dcbf2a6ff870d498ae8aeb53c0d173a393ce6d7218bd6daa7ce2c416b78b743b
> MinGit-2.48.0-rc1-arm64.zip | 8f56c87ceb5c5b41a5690554fe091b8b9aa08748bb20c39e933b0a2c8546ef01
> PortableGit-2.48.0-rc1-arm64.7z.exe | 594ab37e5e378efb30a97796fa38f3a5d833f82da223d4056e596f311270fe21

Thanks, Dscho (and a happy new year ;-).
