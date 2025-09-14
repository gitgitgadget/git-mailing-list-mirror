Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341F200127
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870679; cv=none; b=omaLOAM8rJLItEbZVXmEpqoWaQ+pbLvzLSb/faON0r2+UnJNaR+R1KHsliNU8cJYNFhju5GcoimQm2aREyfMNO34mJkJKi2ITQxiMf81yRo1AGLujh7NFQVwPOmwSKg0jVsqrHnIHUnuQi9GPrxxc27htJYAVD1PdeXfjIxePjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870679; c=relaxed/simple;
	bh=s/mFl8mRKuPc5EMYc/ewCbEPxC547WDVd2k/lsgdwow=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UTHrR+2G805adHjoxL4glJnTD/Rky3vUHCUZG9QGPrgNrLzRJRDwLSH1uK3w/NLRJDje3P900a/ScWf8/Bi9ITu/9Xd/UGAh5d+/Y9W6mIHqdvtRPCvMNHCg+qoRj19pmpPl70U2S5fSfJe1Np4MY8emlfzpUnDNwd5SsWJ1zSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fd5PJfiy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CYRzLD8T; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fd5PJfiy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CYRzLD8T"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB8A81400FEF;
	Sun, 14 Sep 2025 13:24:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 13:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757870675;
	 x=1757957075; bh=La00Ww0faavZAGHVqA5TZqhE5n3SCVLgdC/GdheOV/4=; b=
	fd5PJfiypGmJxTY1cIPnNWK7E3PKAM8NWupmerqee4H3QErOaifCvufVFb+H+Z6d
	PWmjg5iS41k9yxZdNO/O5WRH4B4vJeyRboeDHeLeEoVz9qPe5gxjokSzSFUjO84m
	zCdIDdt4hcESOGKs5eXYxFsWvvNA8KV1keQOnLMTa4SOPrQsIkGv7ipsrGxxATnJ
	aAyTYvs9gAA5yCRvacWsSF78rXgXFj67zF2fpelEG/99uQG1m8GQrit4mwNr3YiI
	oYbMZMDzmHJWdbgBLerMZwaNkfz5PZIyoaBq2dRJFEBH8yeB/o1AOXO10smpt6Ja
	KKYLVlCIjHLo6kpmJJ30RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757870675; x=
	1757957075; bh=La00Ww0faavZAGHVqA5TZqhE5n3SCVLgdC/GdheOV/4=; b=C
	YRzLD8TzmfJk+6cm25NP3U9wYYEdx+VY9E+tbrQQPzM0kRcRahuiAvobCnhgpjA+
	ECR0+myCERYHQHUa324jvnX1G37DPkl3bgwJfAqYCExm/y5lZUU1rHU2oFV/flfn
	upj6rPw/9/9uZm1y8ig8cd0SFDCcF1O3LV9UUwP1te0mFyDu8OPU7T2nSHx67WhZ
	MZ1ObW65imA0zZlNyzeYDeOejovBw0pd/vrMw8DnzujNgrhTO90Pc0J+ICL+y7XW
	CnvaK0D4PCacpDxMuCLoc6XioKZUVMWmAGSKhctvv6PY++TjQMRNZ9YiizUBJV1K
	ecsRCW9Ch71/HS0aRsqlQ==
X-ME-Sender: <xms:U_rGaEI1R0nUzrtcrZszWXdtt8UmEVScieTaAON8u7uPOmK67h5pWNY>
    <xme:U_rGaEIV-ckvJAwYar9jm2JVdClxZdCif2KgcpWqmBy-dLMqOBoC8d7f7HcE8ROjT
    RGEYRsemxd61VTVzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheegtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:U_rGaPIUaNZwK4NWMD2BBBPtPe8iA2z3T7E60FWHDQsemJ9pgnv6Gg>
    <xmx:U_rGaAQUUC1plEt-QhJ6zjVj7pGM40C-sdZ51y7s4n2AQvs9Qy6XzA>
    <xmx:U_rGaGt3wCyQ0BkcloGVKLUifgQ1BjQrGBWWuL_fytX0LftJDKFA4w>
    <xmx:U_rGaJZCGjC-iGaWl7FyNQb4HecwiL75co8ejcdU1d6EvXrIeKUozw>
    <xmx:U_rGaIS0x3bnKKd8wR6IxIUZ2rOX5K-MqV0V70h2Dj8RRs1SlLQHotLa>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 265631EA006B; Sun, 14 Sep 2025 13:24:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai977590-_NN
Date: Sun, 14 Sep 2025 19:24:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <eb7e569a-b297-41d2-82b0-956210292b64@app.fastmail.com>
In-Reply-To: <20250913220609.GA435444@coredump.intra.peff.net>
References: <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
 <20250911203256.GA1894340@coredump.intra.peff.net>
 <20250911204302.GA1907101@coredump.intra.peff.net>
 <98d206ca-3dc1-42cc-9f01-e3241d5a24af@app.fastmail.com>
 <20250913220609.GA435444@coredump.intra.peff.net>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025, at 00:06, Jeff King wrote:
> On Sat, Sep 13, 2025 at 04:10:57PM +0200, Kristoffer Haugsbakk wrote:
>
>> The code in the `while(1)` speculatively adds commands to the list
>> before finding out if it=E2=80=99s an alias.  Let=E2=80=99s instead m=
ove it inside
>> `handle_alias(...)` and in turn only run this logic when we have found
>> an alias.
>>
>> This is not a refactor since the error output is changed; we will
>> now print
>>
>>     '<cmd1>' is aliased to '<cmd2>'
>>
>> while iterating in addition to the final `fatal` message.
>
> If you want to get rid of that last paragraph, I think it really is as
> simple as checking the expanded alias new_argv[0] as soon as we see it,
> like:

I tried using both of these changes (the patches) but the `alias...`
test suite started failing.

>[snip]
> You could _also_ ditch the "recursive alias" check above at that point,
> though I think it produces a slightly nicer message:
>
>   $ ./git -c alias.foo=3Dfoo foo
>   fatal: recursive alias: foo
>
> vs:
>
>   $ ./git -c alias.foo=3Dfoo foo
>   fatal: alias loop detected: expansion of 'foo' does not terminate:
>     foo <=3D=3D

I didn=E2=80=99t try these.

>[snip]
> I dunno. Maybe it is not worth tinkering with too much. But the "this
> changes the output" justification from your proposed message seems to =
me
> an indication that the refactor is a little iffy.

I ended up with not changing it for v5.  I missed the first time around
that this informational message is only =E2=80=9Clogged=E2=80=9D in the =
specific case of
`<git cmd> -h`.  In turn you only get one more line of output when you
are (1) chaining deprecated aliases, and (2) making a loop.

v5 still mentions this but I try to put it off to the side, in other
words a footnote.

Thanks
