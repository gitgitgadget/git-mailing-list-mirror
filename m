Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4B134CB
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300982; cv=none; b=g2498G4/21ykGsFfzPTXzA7ccMY3nRgXln+A8WKqZMaq1C+H6jmspNHY8amvJiaC9YBjM1GcvowJln1gxoBF2/ALnBfCSG5uuKTpDNblrm0EExw0kimhvtyCO12LVm25D3bm2s6xYKKacmz8Alhyf+fJhbmgGD4+0E4gVxgnqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300982; c=relaxed/simple;
	bh=MvuVgUJ7dzKIzWOf2pWriwxY2zS4aNDkLWIrQg6Z45I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=po92hn/4qyR0iVBcjRQdFjW80zVbrfnWtHNLBm58QWJ0VbSHX4S+iaJojHilEvsCeP02m7SVWyi0/+9mhXJDi+mMjiisX2icdI98XJZuxzzr5rwLmU792b/GZcf+DPDlBxTSCXAKumBbAaX79o7J6YTTmu+g4sd/lP4B3bvvXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=cuYo/6Wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdWHnXRK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="cuYo/6Wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdWHnXRK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 573B4EC0517;
	Tue,  4 Nov 2025 19:02:59 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 04 Nov 2025 19:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762300979;
	 x=1762387379; bh=I/QmYnqjOJoHU3TCy4EyJneLKwwOmUs/x+7ZCiWli0Y=; b=
	cuYo/6WlXDJen+ChPyPJmiO4WWEmOSGv5WCHUMh27VN3czWKUix6XpdEbbHruycM
	1vKCMTHDZT/93fUEdBiSlDBW5qIddwpPzBkTxSoYhDU54+RpMwmBvgQ+xEkVhR8O
	txcbbwSIFrm/ZpKgoWwVXEbq9e8TFL0VnYcI0ll0odlG7rbSwcw4Go7VhzO/WPby
	cnSwFLUrHBKzmdtFP5A6ZQR8UTkjjZK1Z2bV35aNk/JGX57kZ4ipw7JCLDtoksps
	/54NVRTlZSJElScoXmnPzOISHrWYSPIp5nf++aq5iGGAOmCQDkye9tNLRLeAJ3zD
	6SDzx9y8sdNdAfMf7FlSLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762300979; x=
	1762387379; bh=I/QmYnqjOJoHU3TCy4EyJneLKwwOmUs/x+7ZCiWli0Y=; b=Z
	dWHnXRKEV03kg2nti2A5fDs2SJ8KYC0b/SQFf3QXhEV4gG7jkvsz2Pq9oc4MT+sO
	I3JmRonzpMILj+VpOTtAm1kEImU2NKZINgb6cuoyKqiyAGOhvk40p/9UULb52dLI
	6eAaUfZiXDz4a88jri3dyG1lyly70XWuVSAQM51OrV2EPt/n1CBRDbHE5sct9I+2
	JhpuZbtOEbyK4op1D4aAm5T3hxsKQgkRC30x99644SWvqfiK1zwt+iUYGopzCJTg
	wqjPCjnK6SBWTifF1sPdleX37tPvMDwo1C+EWv4gzs1x5qYXa4Ssn67B7zohaiAz
	U4hn9gCq2bMz8nYWJQ/qQ==
X-ME-Sender: <xms:M5QKaUA8-2G9Z5KvkmbGMNzl2Kn1acD4wRzRppLIRcgw4VcHK2gJ0Q>
    <xme:M5QKaRX7qFbuXHDVtzAFDWxwxXpIUPTdWLWc2zEcVEXj2gKphsbGo8OfKMjoH2J8z
    4K7R3-Vyz1li9OoWkEyySKAz3UpqWNAWkn0z3bQbMv-9-S3gZjf-zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M5QKaftIAepQRRjJ_Vk3IH3VQwby_5qNVpeQ0QPElqWKsZz7IR7cew>
    <xmx:M5QKaZwEb58RyczQyWdCQsYZaLBMSLiH6rKXWCkg8q18iWkYGMCnHA>
    <xmx:M5QKaaDtro5uJIYtbXdy9LNJ9PwJZP6NwbOHrOkpYi9IN0oOhBZBzg>
    <xmx:M5QKafcLqUiL-EPG9vaJkkpLha_ljmZ9BdLUvlWlxTdQKASz2kXbzQ>
    <xmx:M5QKacbZrShQvTsxDujfLkMPG7QwD1AAD_-IBcn7LuoezNqHLNMrBAc8>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F22C2780076; Tue,  4 Nov 2025 19:02:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Tue, 04 Nov 2025 19:02:38 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <c268c98d-0a8d-48fe-99dd-b4a2fdcd0fb9@app.fastmail.com>
In-Reply-To: <xmqq8qglnyzj.fsf@gitster.g>
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
 <xmqqtszf2kro.fsf@gitster.g>
 <8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com>
 <xmqqpl9yshrr.fsf@gitster.g>
 <9ff9d97e-2fae-488c-990b-cb574fbe8c71@app.fastmail.com>
 <xmqq346tpliw.fsf@gitster.g>
 <5ac4f09e-927c-4125-adea-f7d5ed3d1caf@app.fastmail.com>
 <xmqq8qglnyzj.fsf@gitster.g>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 4, 2025, at 6:45 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> I do not see the point of implying that the commit ID is not "special", or that
>> it's only one of many ways to find a commit because to me it seems very special,
>> since there is no way I know of to retrieve a commit that doesn't ultimately
>> end up using the commit ID at some point. (though that ID might not be encoded
>> in hexadecimal)
>
> That is not what I am trying to say.  The hexadecimal name is the
> most neutral way to refer to a commit object, and in that sense it
> is special.  It is the way ref subsystem uses to record the name of
> objects, and that makes it special enough.
>
> But that does not mean that the name _is_ the object.  The
> hexadecimal name is a way you use to name the object, but is not the
> object itself, and the special-ness of that name does not change it.

Okay. I still do not understand at all why this is so important to you
(for the reasons I mentioned before) but I'll see if there's anything I can do.
