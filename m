Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122B260A20
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712396; cv=none; b=UX6GT5rK6uDZ2CU3LsDqoflQIJVq++GIW162WosDLTpztqCDBHXYG5BUbM43J2u2vWY0tFw8pJD1umvNiZAhOS2glQbSQRVAF2qVWka62C9jBxtNl95lWnTif4gArISikaoMTE+7DiWv7MKf+0Pa+s8+XM1Xqg16Nj1rG2RNPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712396; c=relaxed/simple;
	bh=CZI3/ITeE7zgxVtXYAeM/sCKsqoqge7CNViXg6hKgyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qrOnTLLQ8RvlT3w3gPA9GGriW4dMg+yr/FRelrkvFMJ10fzbx9UDtUbJVnptbkP8AjTFFmjWfITHSy1aCSZmt6v8YYG2VtkFq87c4aPTkwMsaz5g7Ib2NMOWWjlugmGuzLlYBFgSwMFZBL5jYTPoO5VR0LArH8xmB795RZfBq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mnkqVTr7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQiltb/j; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mnkqVTr7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQiltb/j"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A935F2540150;
	Tue, 11 Mar 2025 12:59:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 11 Mar 2025 12:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741712393; x=1741798793; bh=qvFRjXrZ9j
	24AGOSC3jqKl4XDwdQI9C4QYeCWt5hFzk=; b=mnkqVTr72hbx23zeCFHSZlBDxt
	dWCik0sKXcMyIxah84+olV4gEZvQmr0eigSr4GFr2hVSL+yMB7Py58zwnP9supEp
	IW/bM3hFZe1rzpe2hrpaXV9NPEDLPlXl2a/ms37Lgxi/7f9/1Fs3HniJYafElwQn
	4ZAEB8IDGvDPtYL7Y4ORS01jKwQ+71/BtFekKU2F2GWgRIx8tdEEx3JQBPrNZixV
	TZUbupfZXKzGkBjScljnh7Bx96HzUOT7yLFTwn9vmPrX6Y7H1Tcn5FZZgtLPduQT
	tA1/i/KZkmGUvzWRmV7bp77Zsx03h6D4jbo/B0seFcjnGxOWwMqsucBm0Q8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741712393; x=1741798793; bh=qvFRjXrZ9j24AGOSC3jqKl4XDwdQI9C4QYe
	CWt5hFzk=; b=gQiltb/jOqtRozABq4cExG3V361x9ejtOXzIdquqdXI/yC9hQQt
	LdLKApoMm7PpwO0q+chf7L48KU3ErJcWBFrbVub8PjgchMwe9yEjVC4az//QQUaD
	oP537fEwieWByw2KBGwBPKq3HGHtWWDi4ihP38thb05KF0Qx/A3YbHoD2Togfv4p
	TDMasX6OM0g5ulNancvm68nZmIcjyh7VFOlehLWwLt+MZUXvFb+yIip5Dek5VxVd
	TfUa1E4d+mM3zFGwlb1iI6QZs9cuKtxkVVDFCTsQd8HeLlg/+xJFf9kgsqTK6y6n
	q4o7/jttuPn2oJzzA89gOJlVBoMD7yirgjA==
X-ME-Sender: <xms:CWzQZ1ZPkziaU2wOL2alpa4EteiErWCHDA_5s1jLlvqcIWmaBWAc5Q>
    <xme:CWzQZ8YnPm_OxZ4h42Myrp5_XV4g3XGCTLR-bqX3qxpdELG_Kd7EsHFXNiLK4M5f0
    tddnpUxEaPK6gvFlQ>
X-ME-Received: <xmr:CWzQZ38rG4tfQ6zM2v0wkXR1KQM7Fw9IU6LLRcSrMe0dpHLhtTqFPMhrlyGQLQwkntfnbn8aS649nCx4G1l1F7dPloYjpmJdJYCu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghr
    ihgughgvrdgtohhm
X-ME-Proxy: <xmx:CWzQZzoLnSP2a-ovMfVNI1KrEcIqZFvbMvFaVPUZidoiWpy_832dfw>
    <xmx:CWzQZwqoryNXIZcILsavB5Lo92CoyUHen1_yIhmnDZCw5-TRHHq3Og>
    <xmx:CWzQZ5Qk4hhnZ2YbfZRfFzHKbQW1AOpZ9DXA23LVl5VPM991pxNGCw>
    <xmx:CWzQZ4ocNEi2saV2W4wTQAo_EzcsemuajT1qNN0_Jp9iUbkfRW6FGQ>
    <xmx:CWzQZ1SEWmcGoVGut8G7k6D5GnGs3CRsQmtIlswzPU3v0nOs0Aykapj6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 12:59:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <20250311152413.1059343-1-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 11 Mar 2025 16:24:13 +0100")
References: <20250310074053.1886097-1-christian.couder@gmail.com>
	<20250311152413.1059343-1-christian.couder@gmail.com>
Date: Tue, 11 Mar 2025 09:59:51 -0700
Message-ID: <xmqqikof4i60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Using strvec_push() to push `NULL` into a 'strvec' results in a
> segfault, because `xstrdup(NULL)` crashes.
>
> So when an URL is missing from the config, let's push an empty string
> instead of `NULL` into the 'strvec' that stores URLs.
>

> We could have modified strvec_push() to behave like
> strvec_push_nodup() and accept `NULL`, but it's not clear that it's
> the right thing to do for the strvec API. 'strvec' is a kind of NULL
> terminated array that is designed to be compatible with 'argv'
> variables used on the command line. So we might want to disallow
> pushing any `NULL` in it instead.
>
> It's also not clear if `xstrdup(NULL)` should crash or BUG or just
> return NULL.

Yup, the above two paragraphs are irrelevant, I would think.

What we could have done may be to ignore (or error out) a
configuration entry that lacks URL as an error.  After all, isn't
this caused by a misconfiguration?  How such a misconfiguration is
swept under the rug, whether with an empty string or NULL, is
secondary, I would think.

> For all these reasons, let's just focus on fixing the issue in
> "promisor-remote.c" and let's leave improving the strvec API and/or
> xstrdup() for a future effort.

Absolutely.

> While at it let's warn and reject the remote, in the 'KnownUrl'
> case, when no URL is advertised by the server or no URL is
> configured on the client for a remote name advertised by the server
> and configured on the client. This is on par with a warning already
> emitted when URLs are different in the same case.

Yup.

