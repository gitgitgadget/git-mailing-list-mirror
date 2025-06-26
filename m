Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396D1DD877
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953501; cv=none; b=YUBVDBy/Js/iFksHG6K2STkG6bPrk1wqRDg7Ejk6xCs8YDegi/LYduxQsLtkGc3KbuXFmmzw+pIrDEX76zYlvJ3slZHE8ybHZlL6PORRuHCmKvrJKPpLRjDB/0OR5L8lLmmnS6j2hK+mndKiJ56xN9taTm5R0xEruERC6rLI5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953501; c=relaxed/simple;
	bh=B4FyYIvAAvjeRmIj5kemgMz4f5d9Mx1+FeSbL68Bk4U=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n5ISJ5AKM36qvjs1MWNGZCiVcc0xOZpKupnZGzLm5e1T0zrT0sXkOQSzUNtpyUwsPjUiIMJ6P+HHABDTydi7upGCKB6RfYtoCrw9ceBeYXVGJqF54GtHKUFIQQAKyzK37EcMnL4R4+akO3904xyiVrsB9h5AIaD2oCSgj5ws91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pd1/QRJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgEOyDyB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pd1/QRJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgEOyDyB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A8D21D002BD;
	Thu, 26 Jun 2025 11:58:19 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 26 Jun 2025 11:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750953499;
	 x=1751039899; bh=B4FyYIvAAvjeRmIj5kemgMz4f5d9Mx1+FeSbL68Bk4U=; b=
	pd1/QRJz2EPuTy9T00uyCtjpykl0vDC7ERj4hvGiIpjkLOY5Se6Aam8e2y7eNabb
	7dEHQ17Or0aMiYKB1FPrFNKoy+ip+nWG+eEMQcV+zkSXW6FeCalcXWSaoElgWSme
	eOeJdbuAL1jcOEaRLchbEQDDX5pNubJmiHpzPf4qLNHGtIWs5tpvNt4T+vk10yP/
	n1j/Xd/mVuqhmUtoV1GPzE8Jenu5izhIQuWOcrAODlNgpwiknyF3jUlFn705K3JQ
	enyeXIfWVQ0Qi/px4xtNGRFB3f5Tni5cGC7G2yrpAZ4NqdCyVUv33/npayOq1Pxq
	TQcMdDnNjkdZ/wByyFyhNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1750953499; x=1751039899; bh=B
	4FyYIvAAvjeRmIj5kemgMz4f5d9Mx1+FeSbL68Bk4U=; b=GgEOyDyBp/7yeVhIB
	c7671tQOrX3POJOf2gcmtX2zkEWRRC8KGqMiRqaaRK5M7JwAqcL17UF+8IeUD0tI
	GLkrzYL6pjmSHdWCyjViLjmvbJjodKjjKyV3yautUYMiziSLW11jq6Tq9XJo5Jh4
	5Je3WDPkN1059hQeTJ0PN5HBmEwgeu5vsQz/eaLivPHKXzM6sGsrmGMq+dFD6c4+
	IrZOe4Mru1w8zvYbfRwzr7126pZiL8O/8KkRrEv6bhux5KZsXu55mgVABEYnOFE9
	SRjbgB24+5zUUxzklGGHOFuCXPwepMwu2utsXr8SYoFrP4IRrIk6KTTikQ6U03d4
	eDTaw==
X-ME-Sender: <xms:Gm5daMSGcPy_4Ttqvs_AijwpUwIstYm0ouLFk2SsCsgsTMflGPPWDtg>
    <xme:Gm5daJyVoxFG5TPP7nh-pf0SHOEUXsujea6nQBsB9JqNrnzgs4Gqfp499WTL1gwNR
    BP9x58-dW5jdkH9TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhf
    vghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefhfeek
    heetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopeguvghnihhlshhonhhsrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Gm5daJ0zQaat85FFz85RLYozlpn6te6RnJjID7oiWUYHo5S_G1ktVg>
    <xmx:Gm5daAB0wV1F_Dt4lLGD4nUvcfz6LmUpyXw8-L_ee_EZFIpnDobVjw>
    <xmx:Gm5daFgo2uUGbwWbiQ4TIDWfpXHI2oNJEsPHnJkjGNiDz8b9Y5EQCg>
    <xmx:Gm5daMrZKOC1WpOVgWZMZeL32EWdfYnRRNjYPT3PfIMqdz1ygBb1HQ>
    <xmx:G25daDQy7CGac2G0_74pOy3c_PSSUziKZBlDOP1Aby5SAUiV03lUJRwU>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C42D11EA0066; Thu, 26 Jun 2025 11:58:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T27d0315d3b0dc5a5
Date: Thu, 26 Jun 2025 17:57:47 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Denilson_S=C3=A1_Maia?= <denilsonsa@gmail.com>,
 git@vger.kernel.org
Message-Id: <bec18631-c0c5-4e8d-99ca-7f2bbdd5e88f@app.fastmail.com>
In-Reply-To: 
 <CACGt9y=WktE5Tqkxf6_tb_YnaeDyJTGYZoU7vErnSGnZMpuC-Q@mail.gmail.com>
References: 
 <CACGt9y=WktE5Tqkxf6_tb_YnaeDyJTGYZoU7vErnSGnZMpuC-Q@mail.gmail.com>
Subject: Re: git rebase interactive breaks when working on a secondary worktree
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025, at 12:49, Denilson S=C3=A1 Maia wrote:
> [System Info]
> git version:
> git version 2.49.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.7.1
> zlib: 1.2.12
> uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:29
> PDT 2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T6030 arm64
> compiler info: clang: 17.0.0 (clang-1700.0.13.3)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> applypatch-msg
> commit-msg
> post-applypatch
> post-checkout
> post-commit
> post-merge
> post-rewrite
> pre-applypatch
> pre-auto-gc
> pre-commit
> pre-merge-commit
> pre-push
> pre-rebase
> prepare-commit-msg

A lot of hooks. Do you use git-branchless?
