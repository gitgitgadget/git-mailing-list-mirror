Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728330276A
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167798; cv=none; b=TCimdCQwvQDKAHh6tVlhYUCvgClXxEYTOnXdAENH1x+csM/P57dBHjCP8A7ziMibfTaileZhRVZ/Q++62sOgOHBxc3vFAtYrxG5DeetlOFAkd5uJbkWBY0guv3HHT6/XTdl2SWySXreA98T3Ni0J2LiEHVmwR4+R1yNgTSROvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167798; c=relaxed/simple;
	bh=34sfx8FEfDu4UHZYkwlbroJSwPPvEUXuP/QSK6UHqIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iNHRszVqVoAD6qiXPMYqrVJMDEo1DOCTbNTRUJ20k+hJK7naIt2mXMmnUw8Re5il5n4iezKyc/Ta7LFeNzG4mvPUcrXyh6wLGcmLU4WQ72lwf7aANbtUklePXm0uLn/dNNFg6lIbW14o6+8BfTMgGb2I/VphbwMX1HCQxQSNHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=US9pkQco; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=whgQM8mQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="US9pkQco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="whgQM8mQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 55D0FEC0128;
	Wed, 26 Nov 2025 09:36:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 26 Nov 2025 09:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764167795; x=1764254195; bh=6a5VhIz62B
	T1cDlE6deIEUeBToXmttwXA36RThZptQI=; b=US9pkQcoauIATQ4/5gECKmL2Qu
	hx4sz3Sh1rcqVgpXLqz3szzvBipnf2b7FKfbti2Bs5yiUeI/K2DdUM55elzLWzDr
	hBLL47jDlPTL/Ga3n2XAEVAWUSvZ2ztRK0LH/aF2A6mb1R88pb9sH5xznObCmqWG
	U5Wo0pfTD4a0JESZSqe728zFdWxOB4R9W0EwMc84g08XY2o3fTR3ayXYdx5gWwk8
	yew1BbOqN94V+82LlJqUA+bTeuPukHwqti6UI8e7O1BoEFUfkM+4D0jAjUROzLZ6
	lpM3p0Jxb60jy1B5p5Bv3Q9GNf4ZYnbwGkqZWU3nzYSn7edTJyCo/jDH9MQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764167795; x=1764254195; bh=6a5VhIz62BT1cDlE6deIEUeBToXmttwXA36
	RThZptQI=; b=whgQM8mQzyI7nRkjRKDUp+v3nbyMhWiVqcippec42uml1UZ35wV
	8T0u8YI/DNjMyTvKh4gHB6f5qp6+gdH4KWQhXAxRORClWv7ntIVMdOfusfKvVVgD
	40bsdZa+80+v+CAegKMCSli0e0V04Dxu+Eisfb/gSCv/+xOefUu3eGT7VK0y//Ir
	bQpdFmT48+kKYxMxHkPq7lbhFbLZXqnhueVY9Eu3CfGvGt3oqm1WA+fmn70KpE3b
	3Ul3icaKCHJimm/SGaIhR+UVg6Q1mmdf8dppk5ack1nc5LbPEhULLsM4tsv7AVek
	87pcOQd/cwXalkKxdMD13wGd50xtnb9/j5g==
X-ME-Sender: <xms:cxAnad_3NYhp58DuAuR1c8qTnlkFtlKH4sjyJeAuh1SE7Uft2ZMxXQ>
    <xme:cxAnaZLbEhGXa9edEgYmbRMSnt1y05XSKbW-Up35899ZzLMEbQ18XCJAJChuraQhD
    8r5aNtkkcH-6KR8-G75FCsaltYMgAYUWqDN6bu2IwIMOSa0u4kasA>
X-ME-Received: <xmr:cxAnaYaxYnF6bJ5Qs3MfISiQ0LJ4kgTUGbqN-6_0CWM8eBkCtr1anGE5R_sR5Yau1QJ-Mm-eHpxVf34MKdoGWYJoDUWNAj7ihGpT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cxAnabJ91rYMPWgdzKkxQ8vp32Gsx2R0JMaNpNdsplkOitUVkXY-eQ>
    <xmx:cxAnaWDsujQHc88F4Sesmc24fzVV3i-FRvGk95yJ4gxoXIRMHDq5NQ>
    <xmx:cxAnaQpmBpeUel001XmMmqNrgUmBWdNNWAhfvHhcpq8043UXauRnqQ>
    <xmx:cxAnaRh4cTjDN8uOrfaraLIbKCbycQRpzynM3MWmSUx8mWVBlUr8fw>
    <xmx:cxAnaVLwPepnmtnsA4XFHjnGbp1CZ0JsdUK3kVv4chm_ByDjXMpQdExf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 09:36:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #08; Tue, 25)
In-Reply-To: <CAP8UFD3BfcvRYA85Pp5L66Mqjx7A4AoxKZNkw2OFXqyWwBoViA@mail.gmail.com>
	(Christian Couder's message of "Wed, 26 Nov 2025 10:15:31 +0100")
References: <xmqqo6oppqyt.fsf@gitster.g>
	<CAP8UFD3BfcvRYA85Pp5L66Mqjx7A4AoxKZNkw2OFXqyWwBoViA@mail.gmail.com>
Date: Wed, 26 Nov 2025 06:36:33 -0800
Message-ID: <xmqqjyzcq2ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Not sure why but you seem to be the author of the "fast-import: add
> 'strip-if-invalid' mode to --signed-commits=<mode>" commit now:

Most likely "commit --fixup amend:$THAT" followed by
"rebase --autosquash $THAT~1", which is the only major thing I
started using recently, that went bad.  

Thanks for noticing.
