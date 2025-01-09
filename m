Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB521CA1E
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437618; cv=none; b=S3ALU/1BF/DuJ80NwKtMGqTOrNFiuBJRh3YmQMoG1gTp8W+TeFojhh/UJQrmkNuGQi7nJtp06C79vtowXbF1Gk+7cb4gAfgW60Yaf4WS2vPzrJsMvcjROq20b/hHQu4E7lg3OUfQ1o6phljgK4nD+SaQGaEplTtS1l1FCimmNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437618; c=relaxed/simple;
	bh=AZHGwj/0bBm0xGj+/nud4D0b+J016ysDBpcW2NQSfw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqlnVAzYDUTUKs6S91Kx4ctzX+ON0x3wuMtXWnDh7xRxo8AzHATTkejalOqvotL/+gexz8wUXEOBwOKUgFmy4QCgijGBbc2z02Teis97IzBnY4epGWfCPH73VqoTdjS5y1yjbBZw3HHnjOFlVo++yowpulbNuVE9ix7BhU9i0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qEbXyRDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wh0fTBsa; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qEbXyRDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wh0fTBsa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DBAD01380187;
	Thu,  9 Jan 2025 10:46:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jan 2025 10:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736437614; x=1736524014; bh=6lRPMtIxB6
	TQhw5wahq+eK/7z/1+B6HD2BIo9T6XAz4=; b=qEbXyRDuNOZ09fWaGGYE0TGu0r
	g65Mb3egImEeVbPHapU04fh8oWz4m8q4M5oRl+fGCDs56YxKyZ1tfAApebyJcgA3
	abMlekAbkKzXsDsnMfZfELFnGw2VH9RkxR/B+utHpM0rqMB9L+58UDweJlQ9040c
	mGhcUilxY5e82gmAMJ++XweRMfwHE3+rEVSBDHGLYgVJjQ2xpspRwAfron88ACj6
	vC+nOzb8FANOqwpQt+ZF+T96uyUlhhl/TAAz14mnoM+VL/AqJvM7R3LyntM+e139
	b374uWIBrKsj13tnhMUWv4Ba91o3FbsRe86IL7JMaDexjBPobVQuBecjEkxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736437614; x=1736524014; bh=6lRPMtIxB6TQhw5wahq+eK/7z/1+B6HD2BI
	o9T6XAz4=; b=wh0fTBsaSX4XBR1e8AgFmRoN4/jhPCY/HVteaMpyUdupyRhwJru
	VNZpa8NXSyvFvaISIzlVx8a+TBZWN8FXGuAu2NnHM5+s0XzfeN+Ke3iUC+SUkNFH
	gCCD8b/5wjysWm4EGnh/QiOYlJvvieDb+U1Y2d4Gas37p93lpCnv7F5uxNYyW/vx
	MqnVctBGhLrbddxY2hch5TdT0r7SGO5JsbVeBiB5+0PG3+VJ0AHZzW2XIj6yetcL
	0Kildl6c4uc1MONpBnyAg7mXnCfbiJxDyCPqOf8XzFKNmlTufTyxAQhaIrSUcyf6
	6UR/hOo0kwDWirAzdt82ompPHre2TU1iG4g==
X-ME-Sender: <xms:bu9_Z2dhyHJHO5l62QYVD0N5khk2Ijs_mjrNrRMy6RIBySCJeGGTiw>
    <xme:bu9_ZwMfvkuchIMRVXrMBRoyFwap2R0TP00W2ftMyiahauLf9cScgbq062_04OSpv
    4cHBLuWP3dmuOuOvQ>
X-ME-Received: <xmr:bu9_Z3g-9Deed9zcrFtSNm3XNwmj0JWwwMtMrGKq0t9eUiLcJJMdZQNHIkClw6_8gZpJcCygggoOlah_OO8R6T7R4bwOCJWUpucs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:bu9_Zz_VoS5oUHWaeeK3PUmzDiCQOcqtu46CpLYMNZ2lZUpsYMuC0Q>
    <xmx:bu9_Zysq1rSE_AosZvtPB-6l1qt_KBwQ4WUJMpc6pE50ZzgQnFGqDg>
    <xmx:bu9_Z6EynRO9RVA-Fu5VA6itk0IzP7hp4UEJ4PiFaocA5kGRPdrKEg>
    <xmx:bu9_ZxPGdFKIa3As9KOSgkogf4UkJ_9_ITaQnIp6-VacxP-qI_2pZw>
    <xmx:bu9_Z6Ev2cQgfm3VGu9ZxLJnUpmmoVYAHQEW-PHTrDL-XEaXv4xgaLuh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 10:46:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] connect: advertise OS version
In-Reply-To: <CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
	(Usman Akinyemi's message of "Thu, 9 Jan 2025 19:55:32 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250106103713.1452035-4-usmanakinyemi202@gmail.com>
	<xmqqfrlvzzcd.fsf@gitster.g>
	<CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
	<xmqq1pxdnuxo.fsf@gitster.g>
	<CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
Date: Thu, 09 Jan 2025 07:46:52 -0800
Message-ID: <xmqq5xmokn0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Instead of having .format that will allow user to have multiple
> variation or different placeholder,
> we can allow it to take only specific values for examples:
> - "full" which would mean the same thing as  the result of `uname -srvm`,
> - "default" or "short" which would mean the same thing as  the result
> of `uname -s`,
> - "medium"  which would mean the same thing as  the result of `uname -sr`.
>
> What is your thought about this ?

I think two-level is good enough.  One level is "yes, please give
the minimum that would not offend even the privacy-conscious folks
(like 'Linux', 'macOS', 'Windows' etc.)" or "no, please do not show
os-version at all".  The other is "Please use this exact string."
We do not need anything more elaborate.

The reasoning behind this conclusion goes like this.

First of all, I mentioned "registry of canonical os-version strings"
to help the users of the "Please use this string" so their server do
not have to suffer from different names and spellings to identify
the same class of clients.

But the server operators that *want* such tighter control *and* are
capable of enforcing their choice to their users are probably $CORP
in-house operators.  They can tell their employees what string to
use, or they may even do that in /etc/gitconfig on the machines they
give to their users.  In other words, they do not need our help at
all.

At least that is my thought.  Others may have different opinions.

Thanks.
