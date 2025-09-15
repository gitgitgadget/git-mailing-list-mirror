Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2E17C21E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917688; cv=none; b=tjhF4xEsOjt85C/ikbcVf0S8N3pXk7m8+4X1zq7Gc2T0vEi4tWl3gZEohm7W+62mDFK8zIHuj2ZDXxlIBmER/FUpSxSeik4fSM7SSKgJKzJ14Mdq4HHYywFeSAOh4GDN2JVPw3Bu6+9EoMzXcZjn2eZjC3rDnvvnLp+2BgPgqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917688; c=relaxed/simple;
	bh=Yik/68zYErHFllAQD8xANIxA8GqxEHs51WhVrdHiZ2I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KOLBfLuSRm5pr06BQH7D5vDK8zbD8or7ZrHlBUozGhqvued2XHr2xlx/3wcbip2obL4bAzVfH5IsE1rHdxoYkGqQnOW0wQLp96kHVvvu++OvzaWHlhcQPqkxqD0qjom/0dWkO4XWrnwor/xfErCoF58nZWC0jiSQ/EQgn+M6ZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PNjwbFvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eAc1W/4Z; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PNjwbFvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eAc1W/4Z"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13F007A007A;
	Mon, 15 Sep 2025 02:28:05 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 15 Sep 2025 02:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757917684;
	 x=1758004084; bh=/6PrJFu1BSfpDbFXJSiqEM3nT94e32rXDvCzM4ZZyo8=; b=
	PNjwbFvyiai1VLwkGCu0iv79Nkn/+1jBRG2VEhqz0Y5YXKG5wHFsSha1uCw4eGqb
	7a4QFHP1jmPkHaKIob0xSYDF7+Is6G5aGJDL+gJcSdAvNIVtdiakhkU6JSErb5Z6
	YROAmmWuvB2PbgRaoWjg9WowrBQrRF4aMbfDT4P3mTq96toTJ1tTzH94J7WqCrYJ
	/QBBqvvxvVwt1QBjT8SzCLZlRh+ibg6MwILyk8wKeelPDA471Lh+9pJ7+jBTokCk
	9agedAHBxsnmn4lRtnUTW1RcfJSPpIWyR2KTT44E8u0PPjWLsaLg063CiPS+5J72
	y3wGhBCzBUsO2eF+Ukxr3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757917684; x=
	1758004084; bh=/6PrJFu1BSfpDbFXJSiqEM3nT94e32rXDvCzM4ZZyo8=; b=e
	Ac1W/4ZIJQLn8mBjfuJbOek8jX3mrN+pbxdORhb2rsC3bKmFFYWM2BAYw9cUM484
	gMAzIRXjPQ9UM/FF+/CATA+C3OXhbYzh9hE5FZL444O5TvsOgHNP7DhMWZ86J9v/
	UQB0h+BeXrHBOZnIbIZnfwsjpHTeeWUGoYUi5mpKplUMmv/bhw/yl1xdG6eBckN2
	7V/Nu0jUPJ22nr+4S7JKDaG2mOTJkmxJ5WSDQu6oVLXjDCOWtpL+cqsZveFcw/49
	cPFhWpsN2jGpULkhoQSWwzdYsSwT6EXOMpYTWwE3cW7W9il832bCOvtr37ZNIw3c
	4Mcu4xHDT+DLHNtaDdgTg==
X-ME-Sender: <xms:9LHHaHJhVOrapJf4wCn3642CpMUKviyk18GfsQ44pEW33LAGv-_VKSU>
    <xme:9LHHaLIFiI47V3kicn13KjQ2bj0Sypi8Q4ma1bz3Fga0U7OC6EaiCR0sk4yr89Y61
    vXWGdR5VdQEYHymxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9LHHaKKs8vSgJ56sQCDrdKqGB2X8BGIEnLTn_Uz0DWt7SQQIQuGZig>
    <xmx:9LHHaPTJ2igEUmN3FRvkrR_lHECZ__bUwBpHFMrAScnQqi2AUMbHhQ>
    <xmx:9LHHaJuOhb8d8NhTygjiEg55uqBR_eR40E5n-CS3jhXs-ffRVxq_vQ>
    <xmx:9LHHaAZCGsGVlzXEo71Dg8pZOJU_1yJ8vSAn3yafyzRX4x_zCUXyxw>
    <xmx:9LHHaDQ7cXKWz0yrZmhZeSx9IUPhtegzRPnCWe1BRyDWukS9GC8Xua7V>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7FA611EA0068; Mon, 15 Sep 2025 02:28:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai977590-_NN
Date: Mon, 15 Sep 2025 08:27:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <7d63af22-3886-4dcf-863e-dec333601b3b@app.fastmail.com>
In-Reply-To: <20250915014451.GA44900@coredump.intra.peff.net>
References: <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
 <20250911203256.GA1894340@coredump.intra.peff.net>
 <20250911204302.GA1907101@coredump.intra.peff.net>
 <98d206ca-3dc1-42cc-9f01-e3241d5a24af@app.fastmail.com>
 <20250913220609.GA435444@coredump.intra.peff.net>
 <eb7e569a-b297-41d2-82b0-956210292b64@app.fastmail.com>
 <20250915014451.GA44900@coredump.intra.peff.net>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025, at 03:44, Jeff King wrote:
> On Sun, Sep 14, 2025 at 07:24:14PM +0200, Kristoffer Haugsbakk wrote:
>
>> > If you want to get rid of that last paragraph, I think it really is=
 as
>> > simple as checking the expanded alias new_argv[0] as soon as we see=
 it,
>> > like:
>>
>> I tried using both of these changes (the patches) but the `alias...`
>> test suite started failing.
>
> Hmm, it still passes for me. If I do just this on top of your v5, it
> likewise passes (except for your new test which expects the redundant
> line).
>
>[snip diff]

That works for me.  Thanks!  I will send the next round this evening
or tomorrow.

It will be good to get rid of those footnotes.

>> I ended up with not changing it for v5.  I missed the first time arou=
nd
>> that this informational message is only =E2=80=9Clogged=E2=80=9D in t=
he specific case of
>> `<git cmd> -h`.  In turn you only get one more line of output when you
>> are (1) chaining deprecated aliases, and (2) making a loop.
>
> I don't think (1) is necessary. With your v5 I get:
>
>   $ ./git -c alias.one=3Dtwo -c alias.two=3Done one -h
>   'one' is aliased to 'two'
>   'two' is aliased to 'one'
>   'one' is aliased to 'two'
>   fatal: alias loop detected: expansion of 'one' does not terminate:
>     one <=3D=3D
>     two =3D=3D>
>
> So the extra line is printed even without deprecated aliases.

That=E2=80=99s right, that part=E2=80=99s in error.
