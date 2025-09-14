Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8FE1A83F7
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878418; cv=none; b=NNFWvPUof69eUDv0ZVBQ24ujwvLcAAYKaeV2EIzQcLfsldCQKj7SiXWNqP8vlW4Os3rmJKFbHEa07rGsUCuXXsCEfw3Uw59KpMmUFriZi0K3Yu1MpB7IbrUpqElq9oZrOk65zon6DJziD3jJF+rXwfLQ9cqd52so6D3XKgEoKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878418; c=relaxed/simple;
	bh=h58nH36sCRLA0m6u/sEiba/d49rF+FM2WaGxVmJJ6qQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PZPOo+v17i/hNIVtGXKsKLhWFiKsU50CNzXyb6t7eyleVXDtnvXTXlNEQBy7PbalFWQmFBbE21ya7Y1c6SzTSrAv/AStRluZGOzxb32BnIxRQyiAfpA3aiM2h7p16Gh2w1vKgjZlUAF8RapblK7Xg2YyHgiGs72+1kcb/YMxlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZECMvGgx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dccUXrKD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZECMvGgx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dccUXrKD"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B7EC81D000F4;
	Sun, 14 Sep 2025 15:33:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 15:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757878414;
	 x=1757964814; bh=GojkhRbgUZz4xzqEzTb4SnLKr4lOcoxRI5Bj5rvydhs=; b=
	ZECMvGgxuCBR8rZAhRKWX+R3ioF3paZo9+CeWTyn56Tou/Fm9ofXHxrXl5K5aXcx
	M95vi5VWR5yIfh4kCa4FT5MfwDFHLVIRVH2Y/rTST6cNCpUAGZQtnRrwZCe2rT/x
	0m+8dkzBkEpx8nsqzQMesnlfa1ba6JnBVhHfEVsyqip8zkyAiJrEpdnQbfEYRKsh
	cgLGIdhpAdiSb0ttLpiGix5yO8Sz8ZMi3C2Lb/+P/g2eeO6VYFgHbu/QNsQdnMGf
	+VnLwHIPp5AMu/WQf4wypLhHFXeTmUOK5z9GwdQixIr59OnAQyhoYILpDkwxKcOj
	u/HrpetSHpO4dtdeEfpDMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757878414; x=
	1757964814; bh=GojkhRbgUZz4xzqEzTb4SnLKr4lOcoxRI5Bj5rvydhs=; b=d
	ccUXrKDJuzvl2e9+/516erv2Eewo7JlZWdaROW85iEBJ2rH8jkXUFdSw3rwFE/rD
	nCBJNt1fgOTp/BWb+qrZ/XbiDpA5sEHZHiSUJc8xPnI3Tyj8awGITB7z8hxDv6R8
	QDcnvfnkuvX3VEh3F0xUnq+2HLZccz/dWWRUgxJk2Us83Ad/ceYaM5TpWCOvilez
	iUurP23sN3AWJ469Z296BalMkPRQ+FjcL8vmKjbT50lKxYCgf9h2sthQHmyBedTY
	VeLYx2GowOyUeG5L0LDYOE1+5aaRx1F82oYk83rgULZ3HhVnxkH2Jp50KBf7qSbu
	/HkmkePmHRjbV4+nyRwzA==
X-ME-Sender: <xms:jRjHaF2YJR7B6AVLPv61lVZWZTof2bdJjqTQxieQOuTR4USTSm_toSU>
    <xme:jRjHaMGJlwD3zCWtbSc29kL_Cj8JTo3Q4R9vNB0Rjwlldtt9GZ1egwb7nDd4yxfD0
    MhMtx0ZGH-S2Ccrvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghgrsghrihgvlhdrshgthhgvrhgvrhesihhnrhhirgdrfhhrpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jRjHaLbSr0pWi-ZNx6xYLfSC9bosq6A4kTXAL4ZOtPlfB7ioo6LzJQ>
    <xmx:jRjHaIWDLS6E7G34CAhhlJxjuHeZK0Q7hnKZ4cjQY9zXxfiEIJl9kg>
    <xmx:jRjHaAS_lxkmaguT7m3QlFn5JEaL3RkbOQJBZMGAVDgiww4CWftruw>
    <xmx:jRjHaGNHrRPgypwkg1Qis5OWgNAw4EDMAZf3KgNn1hChIbLg1oxZIQ>
    <xmx:jhjHaB0DHd41KbV1hqkJg0vcPFAkIxUJqalC7XGB7SMdIQxDxdKsIwOB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B51D11EA0068; Sun, 14 Sep 2025 15:33:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGvZemVQfBlV
Date: Sun, 14 Sep 2025 21:32:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Gabriel Scherer" <gabriel.scherer@inria.fr>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <26e828ef-b1df-4618-95dc-f6f58fb8c369@app.fastmail.com>
In-Reply-To: <6B2DF1C9-8745-4733-8082-9C37BEF12150@gmail.com>
References: <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
 <6B2DF1C9-8745-4733-8082-9C37BEF12150@gmail.com>
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another worktree
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025, at 21:03, Ben Knoble wrote:
>>[snip]
>> It was part of the process.  I didn=E2=80=99t *decide* to get hung up=
 on it. ;)
>
> Using bin-wrappers/git should set things up correctly, I think?

That does work for me.  Thanks.
