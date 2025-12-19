Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC122E973F
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148770; cv=none; b=eQUuQw8E1C9mV1+c3PUYyDJzeTQmBoPBW37ZHGFaznMKdZVNszs7cDEnSxDICsRlxtBxFd+xHCIL0JBjsizjQvMEutjUvNYiv89QkJPc8RBqYbm0860vxBDLtZramCH8Bd8MQcxNgxUIrtAPoQu+QE5UIhEFvB6dZFzJBz+kkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148770; c=relaxed/simple;
	bh=brakvfIyKGMCXWJTuo1vMmZJ5V8/WBZna8oTv7FEW+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dq/waepmRkl8PZyfdwBKDlGf7VNSxGwLRpSTG6CNKGBT/ciTqnrKFYOKwatzv9KCS7amhUPy3N+lIhTvGECF3XnLIi6gdGQuktBuokEQYpPu8/lMYHUD1V12wfHNcF0vzIbPagT1PbpyQpUJ449ueEupsUxyXiUvH2tJ+6zI+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j+ByLS7N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=leeg3k+X; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j+ByLS7N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="leeg3k+X"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C57227A00DA;
	Fri, 19 Dec 2025 07:52:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 19 Dec 2025 07:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766148765; x=1766235165; bh=brakvfIyKG
	MCXWJTuo1vMmZJ5V8/WBZna8oTv7FEW+I=; b=j+ByLS7NzfmD0j393PdfnXG+/P
	URcAbmbtHEXSNXOYKTRa3KLT6kQlGgjRDJSvZ+XCIhvQHzeLeWhfjeze3Zv6K0oH
	nCN9sTTRzeBNXYjJqeQw0Hm3VSGToJS6IAvO2ZotxPBgyRdTmfNsGT1ZXxn7ID5q
	KJu3LkPSLKAQ8GJnlQMMSn1fzv/70Ig1dgLoICgH/x0Fl6euaqYx67Eb3VElCsyo
	0laOIhreCBR0vtbFT9dF8inzMb0Oux6iSNRajD2XDX1NL+xAC50cZcqcZGojXu1T
	SvH7mwN5HYHxXo0krjLtiIJEce9NzGT3BAAL4+ndYfq7o9qFRDrruJlst0LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766148765; x=1766235165; bh=brakvfIyKGMCXWJTuo1vMmZJ5V8/WBZna8o
	Tv7FEW+I=; b=leeg3k+XLLsr1+ZslM3goc+MjHUCZBo1XKyH9WiX0SV7Lni1ivt
	RCi60gsPTI0BdYW8kKqcctbDlhQEyBHMxLJaScrVJFVf48Jx5UgWjWemgli+ldhs
	/hNiubPetDbx8sV5pZcYO2KXdB76FwOsKzJcczKR0SIxIq3RTzUg67gntizSOUQI
	+SpC7ApCn8T5XRZQoRSGiw2n9X1Uf2AYZTk97BOrtdYFtVORfi1rbJP2cbKGjaBk
	9TqxGtevb0tFaWRNP5z69VeA9Q5dH6HuYbqlIgt1K3n42K734Pl+amiY78O+4j8Q
	t88G9JFeS6MIitmyoBXXwIKX3VAnMsU74NA==
X-ME-Sender: <xms:nUpFaeWkOBidR_TPe-KXofH_WfDPnOuI6sQF84yeRYMGyS5QEzHu1g>
    <xme:nUpFaeQ00cSlg_HQxNqf4ovtFh8WJPuPhVr318fxQ3sLYfqWfl_rER_47ycdXo8Qg
    py9cck9tdh48mQ_T06qUJbn2IumfuczCPfDUemX8ipbxnM7d9OTnA>
X-ME-Received: <xmr:nUpFacO3i4X2PnsRKbwHzSjgrr7060-wcTpT6VWt7GNO8CP4mSFLY4nu25WmEmb_9KngUagC0qi69t_M-ND7pM5GtR6Qk7nHIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:nUpFacTfR8k2Vv1iHyjv_1WRIpEqrE5Vbf3-MQbrUMNXvOGrhZ0PaQ>
    <xmx:nUpFaagtyu0X4Pyhfa-mAbE2RORrJcBXqJ5VkRMW0GJNRVJ86kZz7g>
    <xmx:nUpFaV9_KjpbFjfFzYEVMYAm7F5Zpw-5hulmQWemklYmAFHkI6A5rw>
    <xmx:nUpFaREMJM5X2ZloB1nLzq6bxYpJXxO1MD1V3mA86adQT7qFvSghNw>
    <xmx:nUpFafZ7BYOzfNF-drpk1OqiZsswWtJdhkJpi4KU2p5vfC11fCA5l4U5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 07:52:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Johannes Sixt" <j6t@kdbg.org>,  "Elijah Newren"
 <newren@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] commit: document that $command.signoff will not be
 added
In-Reply-To: <4f0f4d58-3f47-4479-bd7e-80f5d9d651d6@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 19 Dec 2025 08:33:40 +0100")
References: <xmqqldj48pyl.fsf@gitster.g> <xmqqv7i62r6w.fsf@gitster.g>
	<4f0f4d58-3f47-4479-bd7e-80f5d9d651d6@app.fastmail.com>
Date: Fri, 19 Dec 2025 21:52:43 +0900
Message-ID: <xmqqzf7evdk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Dec 16, 2025, at 19:54, Junio C Hamano wrote:
>>[snip]
>> ++
>> +Git does not (and will not) have a configuration variable to enable
>> +the `--signoff` command line option by default; see the
>> +`commit.signoff` entry in the gitfaq for more details.
>
> This is in `next` now but:
>
> s/the gitfaq/in linkgit:gitfaq[7]/

Thanks.
