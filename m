Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967EA1A683D
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487703; cv=none; b=RFa85fGhCHgTqpd1nI3fmpK/I/pTRXlVdGOK0jvc2TMJQJAKqE34Pb0BXRKOsU9UP6mAA3PcjnGPbXxx3hKuHB3wSPdTmGLv668aUFN5Tx2xQQpOiXHc9A2k88g5FCACKS9d4kNw3b7BST86iJlhmXgQJx1HhWW59w435RDPtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487703; c=relaxed/simple;
	bh=bmKdRcviEc8Eb5oEx46n68XIqvrnTS8v/FoXuzjAsNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9QXXVYfGWcVUdtJkhU02KLhCfq6wdAhKFBJlPoxmiwVFNB4NSeFQkO4xmyuq2OD6kjSSnUj7UcLLpn82B/e/vlHqCe/LhOBa8R4h+Ht37XhQMRuqH1QsqPUyiI4/CxIXYhDndfvooyBQRuXdPONjD+X+bfRdrksN2YT334pvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FoItV/qr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rSE1IyUF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FoItV/qr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rSE1IyUF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DFDD7EC00AF;
	Mon,  2 Mar 2026 16:41:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 16:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772487701; x=1772574101; bh=6gm7E34BoF
	A8yR6EwY2Rti8VZ4c0XuGynWjWkDUXFME=; b=FoItV/qr8m6fokn5xFbnNX/W7K
	0Fa7kw4IcNTQPjxHz6yWVSxKSUdWIkSlSuYyqffq++URNr/0RDcMN2PQlDEEgnZk
	9fnOvvsgLUOWjpaEsdUJqKFMKTwcGv6Ztpk9voRERMWGrFOymeoIxivPeQP4QlXm
	Sz5bFKg7eA9Zd7U1Kw04fQMFm5dyVj8V5inyUMm8+eRCQRcVO8+b7X851Uuf3Ioe
	UyQehS2ugJReO3UUJjxc5KJMwRSRB+/aKGUE5gAcIXMBr5nh+TQaEKexYppav0MI
	SePU5Erz+KMuzWB+7/q0FFfJM/BecvwTIjSzx0bfqAWvrDoDCgG+fK9YbhKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772487701; x=1772574101; bh=6gm7E34BoFA8yR6EwY2Rti8VZ4c0XuGynWj
	WkDUXFME=; b=rSE1IyUFvRh4lLINCoxYe9tZVaqMRJmghJeN+DC5gOZfXY/lxNp
	uCWQMCNZjIDrGFO6En/6tCEzVNWVjeOBq9//Axd80Tl0AnEsOG9vZBd392H0tu1L
	tMmbeeUExUOSgYuv08L3Njq0aAdYaEwIjVCbQDXtOhKP7xbowl+FqENQPqWn4Oj3
	xX3jhbWI2SmMCYyiJPXgorQbSd6QG8qcyGj9iFGaLSCkynDsnu9qTwsztJezrprk
	AMUPaM6pZeI2co+CtlTit/OhKaNluQyK6h3YZ3z5+bBFw3PTrOYn++X6OInP/zOR
	jye5RPGxjao8fuMe+t9Og1fjpm9rJqvnP0w==
X-ME-Sender: <xms:FQSmaelQXZC7zHaXtW4qcaBUbZvs-dQ4Z4HNVYFYZdwnWG2IOxyBBQ>
    <xme:FQSmac2JZ1aDkmytrQYt5iJmqvHLRaUW23U5kmfyRekHFDAcuhImODUiPMOAfWYqr
    1tL7KXzADyOmj9VtK1tcBQgkj5_E_X_HEoGlCMWJZU6QSw7HPii_w>
X-ME-Received: <xmr:FQSmaRroyQylXjEOZq6RSSBair89dr-BBtMW-VheMEwtZaMmj6viPoZiOsFaWkaFE3GMzip8vsB7GGiv4vxUI1DTRFrzKrSFKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrug
    hrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FQSmaRc9lzV2PRIX3Fqswg7P14ttxr8_gWCF1gZ6zlkOMcW9w9QXIA>
    <xmx:FQSmaYrivKIhtWLMGZKGjfjVlA4GEqmCbbGp6I4qXH4ZSTmeWp3QOg>
    <xmx:FQSmaaG-ws8B8BOvd_9Ocq0Qwquhwi2UYYwXb6_0ioNoSnypNaf5sQ>
    <xmx:FQSmaQvkhk--gHj8GyLTzIah9ND8D9EMcOx9vGpAPLKMjY0w2-uDxg>
    <xmx:FQSmac4nHlxgKfoizXPyRl3doiv-Br1QWjBCrUOao1UxnwI60IeeVu99>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:41:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #11)
In-Reply-To: <87cy1mox6w.fsf@gentoo.mail-host-address-is-not-set> (Adrian
	Ratiu's message of "Mon, 02 Mar 2026 21:20:23 +0200")
References: <xmqq8qcdof3f.fsf@gitster.g> <aaVPY9b37zY8SLup@pks.im>
	<xmqqtsuyyrrc.fsf@gitster.g>
	<87cy1mox6w.fsf@gentoo.mail-host-address-is-not-set>
Date: Mon, 02 Mar 2026 13:41:40 -0800
Message-ID: <xmqqzf4pykmj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

>>> It would be great if you could hold off merging this patch series for
>>> now. There's a rather steep performance regression in the "update" hook
>>> caused by this series, see also [1].
>>
>> Thanks.  I'll be expecting an incremental update for this.
>
> Fix posted:
>
> https://lore.kernel.org/git/20260302191704.1814567-1-adrian.ratiu@collabora.com/T/#t

Thanks.
