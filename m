Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F933086
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921865; cv=none; b=P18SYOeqj7/Vw/9Fd4UwbeMm5q0cZ2gR2qW8k4RE4qr7gbIbwz4eTMGkMZVcSQT02wZb+XakWSdAJgJdHjxzgjLjQq+oC54II+Vk++BPf8eZ/n0yn82kz4dIhU5hGiKygDdhY2pOzpJHNL2DgCYpqn3O3ZFIOYCOJVcOM+stCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921865; c=relaxed/simple;
	bh=QhNSjB1hW6pVTdDgLH7hgQTn9lBzLM3AJylMJoKWZ0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEq4GetZ11flnVewnJjDNY5XCjsJX/Nk0uQhURuAehyk5b8XhUsXMysePw+syEBb9+BHj1F1At2cgrJCaVEqndbzc3PbGZjo5jdlw+oMkSfd44BvoSWpjlRW2X0ri9v2Iu/Gk3BZvvqkz/w/LynWDRyLrAmp2RtXSlDHUt7r9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IAhLHGv+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=huUWe8ZG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IAhLHGv+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huUWe8ZG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33ECA14000F0;
	Mon,  7 Jul 2025 16:57:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 07 Jul 2025 16:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751921862; x=1752008262; bh=iiW+tX11Ft
	j+dkyk1BoMB2zM7aUuxgRxp8OumDsGVjQ=; b=IAhLHGv+yZnCj+nFSVNAaKpxWx
	JmuTmrva2uUpLPLQG7GEOb3eYcjGDHjAfTIpvTaGFccE/VgtK9NlFxGSk71Ko0pB
	UfsfXnSYpPajl3VSoN/JY+6phnttrzUaR4ZSBjV83iRDDZeBZ+YIzzjinWbDdUXK
	qfEhy1IAZDvgFb+YafKidMjWaCAcCqZwUNj6Jci6Bw84Csacf8209iR3x+EP090N
	JdZYsQoL6crzZq/f73QNB5KcNTlgPgXXHp5YlFPRESEjjvHUonlylXgBn981LDoz
	1VpxVRgArMrp1LQOnKl6SeQ3YO3LSsQzacs+DenhcC+Ld25/Q1MRcybCww3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751921862; x=1752008262; bh=iiW+tX11Ftj+dkyk1BoMB2zM7aUuxgRxp8O
	umDsGVjQ=; b=huUWe8ZGy6WpVmr0di0y7wvcgHsgkm4bkPiQcpp7sEZ1sqfBgFY
	mku2SMBZ4Q0SqGyqW/ktcgcI5uQhvMmWNKgtfRHeh0hkAQnK9oB2sspZ1Xa6iQ/M
	fEziawDliNLGuNDXj56cfgGQNH+p5ML84oVm9Tp05RrAAkQ9N775Xc/B2GbumxL6
	6Hd2sFqQdFPfXRPisO6ksuFtyIukqG6RtVlJkjiD9MeKxyYlwdXSliQdrKwn8QoN
	ohPovbiD1L/4O+kfwRbAydhBuvPrqVkEmKS4tG3ZIcT1/3/JfEIyJszKrwe8PqiX
	UnlHcM/21r15VZvqsLsZou0qLu35dkBEfVQ==
X-ME-Sender: <xms:xDRsaHHN8caQ27lKtD1vz6FVamZQC6QzI7_Y1NNXTTKhIfYp86VEpQ>
    <xme:xDRsaO8uNNcwzsEH9bo3B0bvRKcYD6VNcFu4zbjGGSscQnainxZ2_HR_8df8bui4n
    m0KDnqWVAbXD-5TFA>
X-ME-Received: <xmr:xDRsaPJrWBtBFHjRXUgaPRDrp9Eww7VJ-SVurD8alonAq8OYNk1Rqal6qZPax-6i0skkfcaUHN4NZ01PbYNZrCSd1GGKpV1E8_wiSTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehfshesghhighgrtghouggv
    shdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xDRsaEtewD1kjyL023g9sKAeBvaJn-wOiaYIzEQlTb9ZOuf6D3vv3A>
    <xmx:xDRsaOBuj463ZTTMXMNXvQVX5BkARK9pSwYxvKAZJEFeOKFnAj4vmg>
    <xmx:xDRsaEOu1XqgDCFGkz6z5ATTf2ILlRf980Mu9Hq7yfkQxNUJn8pXzw>
    <xmx:xDRsaOBlxDc4-xlQFEvDmsLJjpIFGq-epb7APgq98W04JhTqhbE7nw>
    <xmx:xjRsaHG3COuK1OxPUjY2I0jV-u708aI39A3N3H2KLyXaW1mul76Vavl4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 16:57:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: redoste <redoste@redoste.xyz>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Elijah Newren <newren@gmail.com>,
  Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v3] ssh signing: don't detach the filename strbuf from
 key_file tempfile
In-Reply-To: <20250707184852.16010-1-redoste@redoste.xyz>
	(redoste@redoste.xyz's message of "Mon, 7 Jul 2025 20:48:51 +0200")
References: <20250704230829.29696-1-redoste@redoste.xyz>
	<20250707184852.16010-1-redoste@redoste.xyz>
Date: Mon, 07 Jul 2025 13:57:39 -0700
Message-ID: <xmqq4ivn4t30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

redoste <redoste@redoste.xyz> writes:

> v2->v3:
>  * merge the test with the previous ssh-agent test
>  * export TMPDIR in a subshell to prevent the environment variable from
>    leaking in the next tests
>  * use test_must_be_empty instead of test_line_count

These sound all good.  Will queue.

Thanks.
