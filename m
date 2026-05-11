Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA9B672
	for <git@vger.kernel.org>; Mon, 11 May 2026 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778462221; cv=none; b=lSHAkDV0Gh/2456Dh38zg9q4neXIxMt/2PWS1xRnWiBjIEwXPj0lZbhOcLD3dzX88lypsi4euIG6GXOmPZmRnbYgR2pycnu9LB6Z6cDdZobq2i/EMbsCauXrPb61KgUxNA/b/DOhEDgyJbaK+PK7ODW06GkVZpJedEPn665bPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778462221; c=relaxed/simple;
	bh=6/bDaZSB+k/W8IW1W5x0c2DVDGqXW7+3pQYOzXL8Q8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+5at3SqngBx1p/Xy/OTVFKDpN2zn4a7LCrQp3qEdRR1xyyC778BZCf4nGuPeACRXITagJaMydY2p4UPhm9QhmRxluocBmSPwlUNxt1EKhoxTq0dajFtRtgI5yGvjwdom7MCsgkpceyHxANyjZltyuD7cpLspNuh1yEVq75wLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bcWOnL+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0jrEdy7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bcWOnL+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0jrEdy7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8CC77A00AC;
	Sun, 10 May 2026 21:16:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 10 May 2026 21:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778462218;
	 x=1778548618; bh=2y6s9xeXDJBlBlBmB3/kzYWPAMumpfy9NZiCJDrvixU=; b=
	bcWOnL+xPGqeqrD7D3rD+fZACd6x2xOD0GucI/y0FRtDJmYh0BxWEDbyqp++3X5/
	pXPMSK0r667D+ak/ylxhlMBu9MFEn+jgfqlhLf3BWDnZtgIks/ytOKZKd+b3MfQz
	gSLKKOtDfp5nWtLCyLOWXPv2pFXAUHZSJhEOfF1zquLnfrepqnX9aQQqAKC34ASA
	2yH6gjqyxZYTeX1TGrYaDeewteP+tGdv9vTon0fCUUF7g2guL78B6MV35/7FRtFB
	Ep42VPQIffrmTSga/2gB4fdf7BLRo+8J/qWhR9JDFbtvkha/0Sk3WqgAgXcNek/z
	4kIUk7H94OoO2gEe7LND/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778462218; x=
	1778548618; bh=2y6s9xeXDJBlBlBmB3/kzYWPAMumpfy9NZiCJDrvixU=; b=t
	0jrEdy7GuyuwP17xGV6XXIDv0aCqJYSk1GasBFhu4twjvTvd1Mu0bQKH6Ku5pMTa
	Tqvib1VQX6L2viXp8mYsWkC6Qluv+shK58R39U196uVYdF0qrJXSpCfmOyC0f35c
	kpcmntEVpzi/JDWZvfkrDqYjNG0Q8OUJCvy6157MuX4VAily8JQyNzrXZ+u4cTGL
	mgPleJTUyFAplsdYtjFsotwzSzJw5j7hRzHFOgaJJ3Ihsf6lD6YFYhJVAG+NL0SP
	zrpmKLCHG5dv4anedpOBxV0kfXRmBGQsCC4nP87API/CsgkTSqv01ygwkvKYYxaj
	J8Rrqn/a3KpuzDGAGeHoA==
X-ME-Sender: <xms:Ci4Bar67eozdCX1ZfbFU1eAoad2Xjjg9gTLIRk3vnJmATBBFXnWkRQ>
    <xme:Ci4Ban5kRU_16V_Ca--WKt1tEdGd6PjXckhtDYVyvhDzBnGIJp4IHykZP72bz0O7_
    JcCTrtInBlLKqjf2WxLli9Q8dEuTUvMzaZ8nE7QFlUQbxLTgIJoaG8>
X-ME-Received: <xmr:Ci4BancL527FkikoaaBuk8mBWlq-SN7rVHm4P8FQJj85UNTGR9h8YIOInaHpxGSr2-8sVm4dz_ihcdrXVY2r5sULank-vZfCeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ci4BarDZgGkyOesjvMXhiQ0GAyxcIeE2MdfgrztljeKvoLvjASZUVw>
    <xmx:Ci4Baq8F8qr_QlLJTTcBW1LMf36J3EoP2colyCnsZvpmvuq8e9eyjw>
    <xmx:Ci4BamLzEYhwd3qpceeskQKxh4OAzqBJSkULkWuAmWpnnBCFyR8iMQ>
    <xmx:Ci4BajjAkfJJAffvZc7SmOoEOkIki1JhB8yYVI8XGZkBf_TfDME-Ag>
    <xmx:Ci4Bam-Mpwi2dcSV7gMz1Rz2j9F3jC1UXfx0CDJs2BMMRX19aMlZsXej>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 21:16:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Derrick Stolee" <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] doc: add caveat about turning off commit-graph
In-Reply-To: <7eae7ad5-5b09-4069-aafe-571f3e345b83@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 07 May 2026 23:14:27 +0200")
References: <V2_caveat_commit-graph.68b@msgid.xyz>
	<V3_caveat_commit-graph.6b6@msgid.xyz>
	<39f029d7-0c12-4a79-a701-04abf82cfde8@gmail.com>
	<7eae7ad5-5b09-4069-aafe-571f3e345b83@app.fastmail.com>
Date: Mon, 11 May 2026 10:16:56 +0900
Message-ID: <xmqq8q9qwxrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Thu, May 7, 2026, at 21:56, Derrick Stolee wrote:
>> On 5/7/2026 3:42 PM, kristofferhaugsbakk@fastmail.com wrote:
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>>> Range-diff against v2:
>>> 1:  82faa72f7bf ! 1:  fb5ba74ea3e doc: add caveat about turning off commit-graph
>>>     @@ Commit message
>>>          But this isn’t mentioned in the user-facing doc. Let’s mention it on
>>>          git-replace(1) and git-commit-graph(1).
>>>
>>>     +    Acked-by: Derrick Stolee <stolee@gmail.com>
>>>          Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>>       ## Documentation/git-commit-graph.adoc ##
>> In general, you don't need to do this. Junio will add these
>> during his application of the series, if necessary.
>
> It’s certainly not necessary, yeah. :)
>
> I am basing this on a recollection of someone quoting this from
> SubmittingPatches:
>
>     Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
>     `Tested-by:` lines as necessary to credit people who helped your
>     patch, and "cc:" them when sending such a final version for inclusion.
>
> They said that this was outdated since Junio does it himself. But then
> Junio replied and said that it’s good/better if the contributor does it.

I used to say "let me do this to skip one extra roundtrip" but I
stopped saying so.  Perhaps I should be a bit more explicit and stop
being silently nice to contributors who do not follow the guidelines
to the letter in order to unconfuse you and your friends.  It
actually is a tempting thought.

>     Well, this is another instance that I may be trying to be too
>     helpful and over extending myself, which does not make the process
>     scale well (the other one being the "one final resend after the
>     list reached a consensus").
>
>     If the authors collect Acks and Reviewed-by's and resend after the
>     list reached the concensus, it may take one extra iteration, but I
>     no longer have to keep track of these trailers myself, which could
>     be a big win.
>
>     So, I dunno.
>
> In conclusion for now: I dunno. :)

I do not know either, but if we agree that everybody should do so
themselves and I should refrain from applying the ones that lack
Acks, I can adjust.  There will be lot of unapplied patches left on
the mailing list initially until the contributors adjust their
behaviour, but in the long run it may be beneficial?  
