Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF73375CF
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545513; cv=none; b=qKPXeac2OTBVWPEi8qtkTpM3XglYoP2eo9LstpRixYfUsPDP6MfS6zw/h4YLosqQSf9JMEKHl+YlbcSfbIkbxIRdd8V07rTFpmc56gkcI14I8+4d9vE+K+hnZNS91Knew+9ZaUZdqdXeGJTzLxVT/wteio48t4uNgC9Zwx8qrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545513; c=relaxed/simple;
	bh=opm1TPqJceyemxJL5CGYa5lrVzDZLFpMl1PpG1YgzgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWqZL9Y7WJkxUYkaq79Xw5x3bZzBCVXjime1Jy1KOYPBRoNXT8jAKriXl0kk41uZNkyTccmwQwPllgwnlQYRjWt4s0sEeZ+DimkSnPFFmTb0HdjAUL7pkLE4CvKqL4kmJLtJl+vmGWSAmAo1ytQUE7Ao73WfjZoMUUh3DMx6ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XawqmP7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJBY2iqE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XawqmP7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJBY2iqE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93E5C1400053;
	Wed, 15 Oct 2025 12:25:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 15 Oct 2025 12:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760545510;
	 x=1760631910; bh=opm1TPqJceyemxJL5CGYa5lrVzDZLFpMl1PpG1YgzgY=; b=
	XawqmP7WXU1XP33HfWFND0gSEvAs1Z8uqmQGpJHkkZx7yXYSYwk/e3L2/BG/tBkQ
	Zo19kJE28CVqnaAz1WvV6fkI7SYzN6yR/gjEDMlKZsh3Bod38Bof/d2n0R4esKfI
	AgWFWBZR6EIg29RXeFxaLSG9jwJenRHLmCyAnKeL6bD1ZQnpVfkkED90mNqEzzyE
	F2cn/RXlDdqpsfaQc3MDGnDg2CixTDG23AkP5tC70Jbgeu/Ggt9trRgU5BSw6301
	Dcwl4siRi8gILBbT1YShpDbb9NuAOJj+9fJD0WVdjnbtuBaqQSMvFhncRGMkTiZl
	df2InYdqy4idmD+MMpPb6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760545510; x=
	1760631910; bh=opm1TPqJceyemxJL5CGYa5lrVzDZLFpMl1PpG1YgzgY=; b=n
	JBY2iqEfmy/RZobKLkeZ1BMOXC6tAMD7CO6j8mIRUgAUFUjsOsmbCNPx6/2KI3wf
	JZwWkjDgDeN+BKvKdcdMVPPXfgOy8gkBXaI2dGoy0wQ2Af0XuuvTl+x+efEZ5tRb
	gb84C8oTGTXVIHYIQ6fqGKLw3RyTtvke9AnkaaLexbUei8yCiZStF2aCbee8eljH
	S6vXmVbBq0E4jR4+AXfTUYv7vAxfgFiWays1OrQm1ZOuQ/5dV84n9A5O/H8VUBFP
	4yfDhEy9kGqhLE8Sn66QyTGs3HntPNsiRSUGFvqXrkkOML8AI5XZTEApZ5oWjOM0
	RpVGfEQqk99r7D8BzawIg==
X-ME-Sender: <xms:5srvaOhgIX3aB_IAEFVja5HduDEkIdZS-Jxf23sEGupZc5PqFEsytA>
    <xme:5srvaGBzVS2H37yBLDs9RWzFkcm3-B8S_EgEQtArJxT4RbriW66vFDYN4BU2lFO7M
    QPn3CNPoKvDdbsjYxGQ52QD5FTweaP-GRYNLjkdmVPGgi5ibkEY5Ek>
X-ME-Received: <xmr:5srvaLFtdB0QhJATqJ-rMgrxjZHQzbcuwzRtarUB10wE-pXJcqpJTPoykRng72-bTzimyf04fsK6vbp3ltBFfecBJODxUO9OIzG5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:5srvaGLIa5uFRpUMlqGgxPwJS3bprS728b8xVg1gd4Ssm5iX63gQ9g>
    <xmx:5srvaHmThWbIyXjZfJOMRZJ4Wjt1JlWYSNBEmMCjXk8M2ffUjtcTrw>
    <xmx:5srvaGTOgNlt0XqvmfocnDUs8MKW5_NA4jGKcw7rCRC3CxqsCFqEoA>
    <xmx:5srvaBLMYNkxuooLG6rM-OK9_pwdm2MnhlUlrIBMFTYACURyOjVUvA>
    <xmx:5srvaJuO98TTfLLBGrYoR76CB_rNeH9HzhXP3sQtbpGbgMgEo7jeD_Cq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 12:25:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] RelNotes: minor fixups before 2.51.1
In-Reply-To: <3d36523a1abf82dcb0414fbcdc477db01c399c9d.1760521594.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 15 Oct 2025
	11:48:57 +0200")
References: <3d36523a1abf82dcb0414fbcdc477db01c399c9d.1760521594.git.code@khaugsbakk.name>
Date: Wed, 15 Oct 2025 09:25:08 -0700
Message-ID: <xmqqjz0wuo7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Grammar and typo fixes. Also change “work it around” to “work around”.

Thanks.
