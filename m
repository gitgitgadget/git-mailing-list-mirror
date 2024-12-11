Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C223FD04
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922428; cv=none; b=IxTSsHmaXVh8kCEA9IklfNAnMiniF8iq9m1B7AzVwlCGkJArxmUIkOpEu3pkC1qzYL3CHVRGziXPOFo5xF9CvGJfQH/Qv+vFgzrUc7PbCDJ7y/NPYBT3GBESnMUQYKUbC75eOv7nrnwEOi+H7kAP2ETsvBL8abpP3t3ZCjg2sFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922428; c=relaxed/simple;
	bh=ZXzEZzsf7vCzLpcYo4UYViomGwit7rB1YBCoU4ZX4H0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PT+3a26RRus8dmrd9K6thu5McOr+rXHhOh+ItlNDZNxWTV6w3f03C41piPhO+SCdDaiyRrb6KkIXgqpRl1Zex9W06C/KpBEZojOJgyZunQ8L/+Ih5lAMlzo6LYHgh/uWJtO/RCfajaU+7rmIFs5NFfz9IrrYofn824VufoWp4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FFJycwDL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=39BlV/jD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FFJycwDL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="39BlV/jD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 939BD1383E21;
	Wed, 11 Dec 2024 08:07:04 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 08:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733922424;
	 x=1734008824; bh=ZXzEZzsf7vCzLpcYo4UYViomGwit7rB1YBCoU4ZX4H0=; b=
	FFJycwDL1/EGkMCd0KcwmWmQgPsq6FL6omh/KD2HeYR7Cy9R3O+TFBxOXZLwBxb6
	gjevI8T3TdxWDn5RmxPf4QUXkZCUOjK6rHwFTcaOu9FdtBBje4BqkneMt9gfDKPw
	3yVMNXGwjrpa/3qA6UnwNBAKw9cZjqLAfS0ybHiXfiv1iE5LU8n7fv3ZHZEEYycL
	UhtldcWK2+pGb7vvXWXO/stM0mwnH+9PJNz8UBHPCF8CipKPQfkqCxpaqmkNxJCA
	rjcj+LHKBuPrWSV2LWsg1XwBXOb+Gje3A4UJDjbLWKd/maw+ZNQ8KlsPB1WgIGFf
	TrhOCokT4ZGdeiX2IQOSvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733922424; x=1734008824; bh=Z
	XzEZzsf7vCzLpcYo4UYViomGwit7rB1YBCoU4ZX4H0=; b=39BlV/jDhKjn3Aa67
	ChhyMUllW6cJiFBXZxkxoTJEbev3zOQYlQg5RLzG2RgzEO4B0nhoA4qbBl0FieL2
	coejFEiccUmhw0aduCbisAjOkhBz4DLTn5tOu+JEtIUgzW2iY6NaRhJe8kKB1kFD
	YN9289ELPHxZwJ6jfYEtc5UnbiyKcwTIRVwTHglWR+uYwUQ7xIbwjKGT3UlCY6QL
	uScBcpH+yCcvjXRk9KqcVz2rgXVNg/zdKe5GNGJaf7cozJnBjbnpd8ttNXlT+mX3
	+U02sizZVGshfcLYkD2zja9X60mhXEkqCGs+hMHIbk2xC88/K1hDUy4YInz1hwlg
	Jo0ug==
X-ME-Sender: <xms:eI5ZZ_G1GPM2NWsMYhN-wRHjj_Zu5M-X8c4FCrHQMbDpEMi9A8ucWYo>
    <xme:eI5ZZ8UZHrWZ3rcYH66zwuJThdcri5NNHl-ph2qNvBxYy-VYRrTBNiwaaesHZKtoE
    gBxaJ53qhkjZ6RwAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecu
    hfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthht
    vghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudekveelveffhf
    ejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eI5ZZxJP9LdZRLlkuf-vL-9RP2z8pFAThKteKgOQKHoJ9dJELMDpfg>
    <xmx:eI5ZZ9FCi5fjOIEzIhsznjOh1DW4_WLJUVCBy4AUrRB61JpIQpgZ_Q>
    <xmx:eI5ZZ1X9QreOoGQjg230dAR65IdnX4SzYkts12GDCUlldr6PQsZlTw>
    <xmx:eI5ZZ4PXYvgDfH8dGikvBoBGbax-qmJKAvI0gNsyszppUdtSfV-Avg>
    <xmx:eI5ZZ0d3_5kzlimvck9Cu5MSHRc_-ObhumU4azZp_1I_JPOuS7fTUuTs>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B647780068; Wed, 11 Dec 2024 08:07:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 14:06:42 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <c421584f-4eed-4aab-b706-214a36fc4e32@app.fastmail.com>
In-Reply-To: 
 <20241211-pks-remote-branches-deprecation-v1-1-1431e2369135@pks.im>
References: 
 <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
 <20241211-pks-remote-branches-deprecation-v1-1-1431e2369135@pks.im>
Subject: Re: [PATCH 1/5] Makefile: wire up build option for deprecated features
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 11, 2024, at 11:56, Patrick Steinhardt wrote:
> logic that allows us to easily enable the breaking change at runtime.

s/at runtime/at compile-time/

> While we already have two breaking changes lined up, neither of them has
> such a switch because they predate those instructions.
>
> Introduce the proposed `WITH_BREAKING_CHANGES` preprocessor macro and
> wire it up with both our Makefiles and Meson.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
