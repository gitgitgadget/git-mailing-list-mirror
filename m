Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495018A956
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763679731; cv=none; b=l+wPA8CBeb3XgyiHYm3d1szBPgVZkoe7qO+yABsT1B2vZ6e+jNeScBmwbhE59GrUW5P0lFjR3bYFVCIDIS5ypeRBUspCU8xQzhip2Ve/ATwbbJZbagoC8uwPgboLQU9a2A8Yiqp6/T2ae3bR1X7+xtF8drmWm1COkeJAX47ERpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763679731; c=relaxed/simple;
	bh=s3TrPqcP/J8FW+XjtHr78ZwaZT6/FUDSHYiz5cxW29o=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K+s1aJhCznN4JJM6x6yksG+qX4vFXdBSLpPz+qiILrkS9UU4r5DGuBNPdZ20y7pN+ZZ98Qmy9dTrQHcM/nhH1E5yrByrbdQrWCKe3wCk8NZR0lPuR8fqAT3BgZNI82DK3yEzjqa7cXN8OvLSCujGkSItPHFn5EoUcQcjX09QUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lVpTX1Pv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igwYLhAx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lVpTX1Pv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igwYLhAx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FB95140021D;
	Thu, 20 Nov 2025 18:02:04 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 20 Nov 2025 18:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763679724;
	 x=1763766124; bh=kxjzqURSm3Q04u7JxvsYojE22Cw3I8b4DwScEEKU+kU=; b=
	lVpTX1PvbIIRE0IDngWM5V3y9u9jccpGSCwS8HNStImqBcah08tyIGcaqBjLLsRy
	+V/R29NjYnR5+3oAGfiRuvUSZW0ug5nKnXwqYkToOTnQ4jGGu08vnFsAigwRJ/99
	epSY/Tcp+k8VtvF6V76hZh+ti894Nw1MU9zhhcoxw0pWedfPMG+kfKD4DJiqr9rx
	niCYDm2S2bHn+IEdRdJd1QYTA53Fwjk8e1GuJnjxoQJsyi8OCoQSWs5r0wKMSamD
	6O6Ky3rtLATe+eQLLsQM+M7efdEu9xaODr5Ej4Qn3GEoSzEcE/B2jNJn8tUUpwCn
	f96xqQuw7L4PaONEwUiJVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763679724; x=1763766124; bh=k
	xjzqURSm3Q04u7JxvsYojE22Cw3I8b4DwScEEKU+kU=; b=igwYLhAxtxXP17QSt
	Zq9gjCGcbhxaumFPZJ3R+JjXdEiJeLtGr66ktHUt3OECILKmE1FJU2lj/8Ttqgpi
	d9TRqGxjvwBLOoPBl//fDaiC06GVv1h+baQv2V5CixE/Roly8JNIyN/t6X1jmgwr
	khZ/Qi8xgwe2VMTASktOQMjGdnic5cviixpyQYyARMpZzGTwgeVDe5Kd5Zxus43F
	Ubz1ovU2mbW6TpfrDEt9/7n7qqI0SFW/J9DF17Q8aqQLC5IixVE+9DI3W32pK7kV
	UuA8V3COpyQB1cAsv5WT2eUuha9fTf71m1KbbLA670NOU7v4C6fsVFT57fYfSMhR
	pPEZQ==
X-ME-Sender: <xms:7J0faVe-oRiPfq36RuXdw0Jtcssr3ork6O8KNlzBsiSTfSx_kqn8u94>
    <xme:7J0faeAIo5MH3LMagKDIek9wAC_L4B4DkSqs59nLD3YUsbEc5qcuqxvJtV9thXnQA
    d18AMfYCRsUpTXDSQZzognZDqjxnTA_nAoTMXgVk1iR__xOsMtmGC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekfeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7J0faUJpRF_0xE82DUAOr60LFQcFjPWn7nV-WxJOw-iQJArWVYPnWQ>
    <xmx:7J0faSFmZHOtHDH7Olgc3WTG1FCZZoMj7dQsrX1f6PMLEYTKbH-Hmw>
    <xmx:7J0facSfswMdq3kUfl3p9RHhRh4FkBqOSMw2VI5-eFdVhSQBSKe6jw>
    <xmx:7J0faeEJTdPwCikd-T6fY6AijI1IsROt4FMOL7imt-WFZ1i1KScxJQ>
    <xmx:7J0faTyln7DzWD1k4mE3aMlYDuyqze2SlMjuQbl7I8gyPYz7nLOmURrP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E9D431EA0068; Thu, 20 Nov 2025 18:02:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKeNkJE0zsuV
Date: Fri, 21 Nov 2025 00:01:43 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <df6a2498-a03c-4392-8091-50220db5f108@app.fastmail.com>
In-Reply-To: <xmqqtsyo7b4y.fsf@gitster.g>
References: <xmqqtsyo7b4y.fsf@gitster.g>
Subject: Re: [PATCH] config: mark otherise unused function as file-scope static
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> config: mark otherise unused function as file-scope static

s/otherise/otherwise/

-- 
Kristoffer Haugsbakk
