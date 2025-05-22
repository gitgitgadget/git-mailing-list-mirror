Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE481DE2C2
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940105; cv=none; b=ZD5/lQVvztYCYJTHdmoKsfoK1MPGtq3gSLOQY0S6kSpMWicbLke5V3pExIcd+hE23JGZvFrTql614acf5YliBtWDZ3YEtbpGBBUjKCz5pBRY786zyzedO0okR78j45jmix3nftrFsSj7SrdY68G1ZmzPTy/3JPlly22lfDtDPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940105; c=relaxed/simple;
	bh=VEgw/wc4OFgpwSviGnr97jCTwovN8j+2OBxAZJE8CDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hYMfDicwTfsPhWDC/EZSVSqJMQNkZWMh5xI9F/0h/tdFTjouM9Lw8acWFdkqPdEtPc+Th8nojM0GoRwxswaKliQ0fueby512/nBABgsjnbDnZqsGi1cnbIIcJDiAKpSKVydhwCLGSLWiRd1HElDhafCxrEmvqlIfGLh6LxImNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TngYZxKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=osEulL7K; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TngYZxKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="osEulL7K"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2118D1140051;
	Thu, 22 May 2025 14:55:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 May 2025 14:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747940102; x=1748026502; bh=VEgw/wc4OF
	gpwSviGnr97jCTwovN8j+2OBxAZJE8CDU=; b=TngYZxKbyv2zUZrDIfcRHArQfM
	Dzfvq32FNdiPU1jvSqJg0SCp5f3CFoqtAXm7gUHwz9/xUkYVnc/8FDE/PppaytSC
	ov8K5aqujJTgjxad07Rb8I0bpwN5j/hxnQ34sUgmU8X0jCQRjH+ESrw7sIdQ+GCa
	LK9e9+qPOk7p62cL0aFZuOlc4Fi+LCDMb9xZ75p/Jh25Tp9HEzJj5ZGQ7lBWtskS
	qaDAvvANEWECOrZKuH0KUF1gnDOYpsUByFiQhKuuw8gWCRNZ5ukQ+Uz3GF62lFA5
	aazEQStkYJu3m2vp31Zs1IAPAP4L4TRcQRsdaNCushjehpLBk0pW3xuvciWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747940102; x=1748026502; bh=VEgw/wc4OFgpwSviGnr97jCTwovN8j+2OBx
	AZJE8CDU=; b=osEulL7KcFrYs37WecJaoauB88KGF7A3zEVmyk3e97Lp0hAy4rN
	CRONSFrZ6yb0jTGqffn6LAGQi4NsrXf/QlL5cK3mFysMsifaZLGGxPR/FjdHBzCq
	cM6e5qclfs18friLYoOAgD1sajL9ry/os2Gl7/dGRg3Gd1sdR2MABQNjmFzUx9xh
	omYrx+IIZM1KWn140TEeOhbyM080lEP0w7HcrpsBECX/+UMB0b2e7oq5XpDJuVZk
	smkB1K+SJ55R5LKIkgDnidyMrhJoEPzcUsfQ0vUDUFg3ZjQ30baqMwCRHRd1Q6bL
	ZFwxJ/mPM/MSlCW6nGm49KwXnja+dWRpE9w==
X-ME-Sender: <xms:BnMvaOl5PFiwW93IKVbVGfWX-jyUMYEHs0n9c9hpDABrgsk4psau1Q>
    <xme:BnMvaF1aCaBJPWtXq-XavsO7F5XyZy-3weyXKS3IQ5CXNFC7bZLcwTeP5jCPR0119
    pxKyq2Tn95F1Efwwg>
X-ME-Received: <xmr:BnMvaMpfR3aCw4r_SdTOJUiX6SW3jb2ak38Qxf0xKt3URbEKnxGHRF7daBqRxs8VdT9OktT7cugryrDwOF52ctUD_IuYYOYxFYHvFps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeijeefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrghr
    ghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BnMvaCmxjjvOvJXb0c_w_kerKW8DLnmtMY8vQnMeo0sWJyN4NIc-5w>
    <xmx:BnMvaM0I_KoXEa5hOCFOl3nf1dprAbH4Q2cLUF--mb3XCw2i5wEgdQ>
    <xmx:BnMvaJuJGqH9yt8tKFtob-mi0rrl2auKWsbgfihxNw4J7DQrKXXChA>
    <xmx:BnMvaIVqbyea-hMe9OnGuqeG3riT-msDe0xv4OdHgmp4cf2CxkOfSw>
    <xmx:BnMvaFqFnttG12IcTOaeNcsuVPzBVgL6BolB9yZzUMDQKCaAdHKctPWH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 14:55:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Aditya Garg <gargaditya08@live.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: Add git imap-get-recipients command
In-Reply-To: <CAJoAoZm_fsfhq2gD4JVCihf5do-+CurFRBfw8PX8-0QbSKk-VA@mail.gmail.com>
	(Emily Shaffer's message of "Thu, 22 May 2025 10:54:22 -0700")
References: <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqikltaghp.fsf@gitster.g>
	<PN3PR01MB9597F61508C56A33136B3844B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<CAJoAoZm_fsfhq2gD4JVCihf5do-+CurFRBfw8PX8-0QbSKk-VA@mail.gmail.com>
Date: Thu, 22 May 2025 11:55:00 -0700
Message-ID: <xmqqplg05vcr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <nasamuffin@google.com> writes:

> Definitely I don't believe Junio's point was "don't send us this
> patch, I don't care" - but rather "how do we know we care until we see
> how you've implemented it".

Thanks for clarification.

Even without an implementation, a clear description of design (no, a
design document on large swath of paper is often not what you want
to come up with, as there clearly is a chicken-and-egg problem to
convince others that the design is worth taking a look) would help.
