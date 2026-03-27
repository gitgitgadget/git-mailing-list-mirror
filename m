Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A22836EAB9
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774650346; cv=none; b=bnaoFv4uX5yyCAIpmM15+QK22IeknRZVoLSUAA+9WLfpwxQ+UJnpH4Gfdt9Az2HcRqocr4A0NoUoE1tClhKHzbCktFauvUoAduxGKvzZYaoo8YXr4Pz6fnTB3nK84gnkL+cwFtjzXlY7K5MtRHBT695sI1aUi9dIX/J91gixXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774650346; c=relaxed/simple;
	bh=yZquf8EQ0B2nbe7cCWz2yqui2xZ1U3W6fyTj4ltA2sU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bapG/O6rWP5BYRfXW7qq6KlwNrIadP3Q3k8aeMK/bCQzA8v9J67VGTq25tO3td3BwCcPKdogEmMQpAlzYQymqAq3ZsgeaIwEPBavb56Q2R7RsPyIwigwxB3A4aHkxeceJvO5Ms4HF6bPl56rNsRzAUXjw92xix80rLyvzjsZ7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ih4WGWlN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6I9sTk+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ih4WGWlN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6I9sTk+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D83C7A0129;
	Fri, 27 Mar 2026 18:25:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Mar 2026 18:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774650344; x=1774736744; bh=yitq6zLCN1
	SD2qgGlwXmqjogkKPqHWasMIPeDXCYRWU=; b=Ih4WGWlNNVntVniip3tZbCQR39
	x94AyPx7UNZOo/Qyz94bUD7/NgAedxEOUWmo/oKuf0UvbI96I3l6yO5cQuwhn+PK
	wRUZ4UbYWmcvqHmwGJGFiMZ4/GIYT7JUju0OlmmBK30+mag/aY3ljlRZWxVhXLgi
	kpmBWsG9cMkR2FfZopWAmlfkMkIv7+Fkgpa+RGqfqq6Lc1C6U8yhHbGzbV7aQ5Tf
	Q9pBkExbAk57UGlbhjsi9VQ7lD1QZm47M1A0qeqg5ikSJ1y5YNphzABB/sIKgBdF
	3RGqyoPm3na+lNb1be2KCexpGo9kG4LFgsYmGyAOQ7+9lQHz6bMLdisvatZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774650344; x=1774736744; bh=yitq6zLCN1SD2qgGlwXmqjogkKPqHWasMIP
	eDXCYRWU=; b=k6I9sTk+pV8HT/JU1OIs1b+i4mkQVfCmI9OcozW6GZjD3ZeRwfR
	JlWjgSnOhzVJ8dY9r7+3bRQrpPBpoE/0ielucTEjxXI9R6cFqGjghGbwkMM6hw8X
	1+lxkibThaKiRN001bNWXQ7OLINXXi2fy0Pl8kfMZD29/+G+AsDJetqZRr2RYuLX
	vpd48QfZj9i4bs2Z5foIq03zd+G56eYFRJYCwTY6K6Zo9TfPm/OTW1deNoDwCiOA
	5Oh0eAO+pGTbCQFySSgU/dG33A2fiqiqxfbY79GiKxri6iBZ/WihSo5vIxGdgC4Y
	0zoKmhWF3HP0WiX15AGbSwuQtKSHJsItJ/g==
X-ME-Sender: <xms:5wPHaQqe-Nt4Je5wt5PhJqnIT4khFodR6-r5LfOn21v0KHjXSvx5ag>
    <xme:5wPHadgsPX_NW-t078ibmQ30LGpZHD3ewbGrHb7596WnLpJVUcjNWR5Z2DQyF0-8g
    rjaUr6QuS1Auykau-2QgbCkoDpNz3KIxmyKMVSEvT_-ZyJP5zUxDw>
X-ME-Received: <xmr:5wPHadi6iG1_2mGcm15xn4iE3sR36XFYIT8xW0Go3bpa7VKvrSmDnQNsA8D8ID_rCnj90mL9D3xrBWZ4t9halNICQLIn_u9Aqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeffiedugeetvdehffevffeuteelhefhieevffeuiedvvdekkeffffdvieeh
    ffdunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtohepfigvshhlvgihshesohhpphgvrhhstg
    hhrggrphdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5wPHaTjI1o-dkOXIAuN-7aSKDd5OpW6ixsDtv-Dkf4jklFhbB1R2dA>
    <xmx:5wPHadJMC49Mee5acLphCwZrdU1FvvHbFzw1HqZAZMZqIDiu5x6vLA>
    <xmx:5wPHaSG7aAA_CX2BCToEySwcxVw3oCTZVV4-1am6bQkpsSZiFn_vJg>
    <xmx:5wPHaRSbXLsGPGeBTD3C3j2G4dnVHrTi2sLsohzQiJcCiQ0VYcoZrw>
    <xmx:6APHaTnX69XHzgSgCtqO102AapbE3S3X8BVvYArc-ekb3GL5qNuUIPWO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 18:25:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes Sixt <j6t@kdbg.org>,  Wesley Schwengle
 <wesleys@opperschaap.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
In-Reply-To: <acb7zRGLkQUSIZkU@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 27 Mar 2026 21:51:09 +0000")
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
	<7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org>
	<xmqqbjg9mex2.fsf@gitster.g>
	<acb7zRGLkQUSIZkU@fruit.crustytoothpaste.net>
Date: Fri, 27 Mar 2026 15:25:41 -0700
Message-ID: <xmqqo6k8j4ey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-03-27 at 16:10:33, Junio C Hamano wrote:
>> I somehow thought that this practice is so widespread that it was
>> one of the few first things any new people learn to do, but perhaps
>> we do not have a good documentation coverage?
>
> I actually added this to the Git FAQ:
> https://git-scm.com/docs/gitfaq#multiple-accounts-ssh.  It was added
> because I saw the question a lot online but we never documented how to
> do this.
>
> Certainly we might want to improve the documentation (patches welcome),
> but I would not honestly say we have bad documentation coverage here.

OK, so that is not lack of documentation but insufficient searching
;-).

