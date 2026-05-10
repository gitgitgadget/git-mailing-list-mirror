Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739D33EC
	for <git@vger.kernel.org>; Sun, 10 May 2026 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778380879; cv=none; b=F+pFrXBhGuWM1dQPuqULlRTWgj83Iso+gIvN4mpq8IAymVJ2t9f+OD4R2+BUYSXOFNCsClM4PGkjhnjEwb2lHbjsXE+vRwOYCB3i7UwnNaQZGzVT10e4ais3uCnUN8j6TSKg0/FFuxZRq+RzHqZqQAzoOeSUM8C/coJF4PaFpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778380879; c=relaxed/simple;
	bh=Q/SoH2RNfazQpw7rR9rp7UhS3eHssSLI/fxyFFgLUWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NgzAWYlvZ+hef1IyMJDrpqN4KREx2CEy6a/Ma0SkL6F/jcBvhTosE9Cmv4U831JF7FRPLFOTmwiScj2hLWAxMQi0Xuh4Gn4jbc4YtJDff0dJKKCBlmlcZ4ex4uU7M3p83M4Zw0ripfjD6KVjYZ0fBibhY1yj8/sZ8YVnbzOOxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jpFBbNmC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWu/SCU5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jpFBbNmC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWu/SCU5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CEAD4EC00FD;
	Sat,  9 May 2026 22:41:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 09 May 2026 22:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778380876;
	 x=1778467276; bh=N59BI7wHS7yuZnV7H1cTS3LEVPmRSN3r5r02IpvKKkE=; b=
	jpFBbNmCiuWG4JSrf7r0YMVvel4XGsWGnCeHhGmbh7frRGS5V/ESXsGg0dVXwKIr
	+jCxtY8zd+xA6icjnhlNBqCvvNtAGR1CK5uHFu24GQAczkNXXn1nwySGYNuGh9MJ
	Wc8RitQatuvv4D63wy1mWmirBJuX6K8zjd7REsjjGKwBzVGCi/G/ZkCIu1TurpXX
	0RVH6Jxvee8+uU/DI2dIVyv7xRtdmv5gOKjOOZURCZkv7SKxMCG2GV3CnEHbG/7T
	lt8OpNy12S3//c3SOFxGoXPhoksGb5PsrSHv3J1SD78wx9QCpavcpmIoE9ZFVmL5
	Chsox0SA/IUQmf24kTK3Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778380876; x=
	1778467276; bh=N59BI7wHS7yuZnV7H1cTS3LEVPmRSN3r5r02IpvKKkE=; b=Q
	Wu/SCU5ELMAz0/j/c1g1iDhdt5b2eMaeqr2Jl//s3KKUdZWY/RyWQthCpPwYRqt8
	GWcHjxcGL57YSRyZlakUWHg7U+POfKFh6stvnGvof1eFbjf49GDOaGoPHGX4WWQ7
	vEnuN1B0Q87G9xwJTFtu3pWkKYr/Ch9MSVTjhf4xA58o9IRnpxEIlupQzOeDGbn1
	tD2bSZKzXklHC9ZYN/c//bSJFrIlAR6D8tPnKvv1W2LXQ/5oli4nB6kNfgJ/0Inr
	cJ7kwM1v8mo3BAAR10e0Oc0PN/OeSN/m8kZEASOe3QmHPpBGXdNgP/0rV39WYWhE
	uV1elCc7csepriH3PFr7w==
X-ME-Sender: <xms:TPD_aZje8ljCZlVQ0LV7p92Dvt9tW7mQ0vcuzamjoVsVfRFYwa_lXA>
    <xme:TPD_aQRbUxZ4LAyPFGt5k4xDPi8skPt5UYFivXn1BnYGYzKPnp4Ek3D7q6gEVpz9L
    n_LaDMGt1eT82BKsd0bCvJ5-u6yyX9JtU-sBU1-Vy0JX3NmzX49JQ>
X-ME-Received: <xmr:TPD_abU0N7DV9OISoZgq62lCgXLN62BuV8BSgfhPyuuTfK2EiSkpVgCbFau6bXGdeNa_OyqTZCuKqm5FgNbIEFNuVy7W11SqQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TPD_aUR9Z7xK4rtjQubRHLnjm1DjstseDI_YFfjFitmvJPw4HPADmg>
    <xmx:TPD_aVlCAO2bWGDG8_aFro9gfnVEgy-c9RF8oMBPUKoXkwE4SGa_dQ>
    <xmx:TPD_aa6VEc81M0qLmITtdwq19lqpjzwnkAVaBwWqGa3IrC5GJXgHlw>
    <xmx:TPD_abhqOUvI87VoO6mO_EFR92VqArJaxw12kaKDS9IzIjkQ5gcjEQ>
    <xmx:TPD_adddwqdpFGJ-dLyqU9fJECVftsvTy416CprgEns0p_IFvpNRbwGY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 22:41:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Johannes Schindelin
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Derrick
 Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/11] index-pack, unpack-objects: use size_t for
 object size
In-Reply-To: <20260508190947.GA25792@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Fri, 8 May 2026 21:09:48 +0200")
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777914508.git.gitgitgadget@gmail.com>
	<20260505191100.GA12275@tb-raspi4>
	<fa39d84b-ddbc-3943-5cca-078fb18db80d@gmx.de>
	<20260508190947.GA25792@tb-raspi4>
Date: Sun, 10 May 2026 11:41:15 +0900
Message-ID: <xmqqik8w9eb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> On Fri, May 08, 2026 at 09:36:53AM +0200, Johannes Schindelin wrote:
>> Hi Torsten,
>> 
>> On Tue, 5 May 2026, Torsten Bögershausen wrote:
>> 
>> > On Mon, May 04, 2026 at 05:08:18PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > > 
>> > > [...]
>> > > @@ -524,7 +524,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
>> > >  			      struct object_id *oid)
>> > >  {
>> > >  	unsigned char *p;
>> > > -	unsigned long size, c;
>> > > +	size_t size;
>> > > +	unsigned long c;
>> >
>> > Does this look a little bit strange ?
>> 
>> Good point.
>> 
>> > p points to an unsigned char (better would be *uint8_t)
>> > then it is dereferenced into an "unsigned long".
>> > Then it is masked with 0x7f
>> > In short: should "c" be declared as uint8_t ?
>> 
>> Almost. It should be a `size_t`, so that we don't have to cast it when
>> shifting it. I'll include a fix in the next iteration.
>
> I think I was not very clear here.
> De-referencing a long (or size_t) from any address is something
> I would try to avoid:
> Some processors do not like to read a 32 or 64 bit value from
> an uneven address (and throw an exeption).
> x86 processors just handle it, using more than one bus cycle.
>
> In short: Please keep the up-cast and simply read an uint8_t.

Hmph, I do not think there is "up-cast" to keep.  And we do not
dereference a random pointer that would be suitable for unsigned
char * as if it were "unsigned long *" or "size_t *" in this code.

This came from commit 48fb7deb5bbd87933e7d314b73d7c1b52667f80f

Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jun 17 17:22:27 2009 -0700

    Fix big left-shifts of unsigned char
    
    Shifting 'unsigned char' or 'unsigned short' left can result in sign
    extension errors, since the C integer promotion rules means that the
    unsigned char/short will get implicitly promoted to a signed 'int' due to
    the shift (or due to other operations).
    
    This normally doesn't matter, but if you shift things up sufficiently, it
    will now set the sign bit in 'int', and a subsequent cast to a bigger type
    (eg 'long' or 'unsigned long') will now sign-extend the value despite the
    original expression being unsigned.
    
    One example of this would be something like
    
            unsigned long size;
            unsigned char c;
    
            size += c << 24;
    
    where despite all the variables being unsigned, 'c << 24' ends up being a
    signed entity, and will get sign-extended when then doing the addition in
    an 'unsigned long' type.


You could rewrite Linus's example to

	unsigned char *cp;
	unsigned long size;
	unsigned char c;

	c = *cp;
	size += ((unsigned long)c) << 24;

While I am sympathetic to that position, I also would not mind

	unsigned char *cp;
	unsigned long size;
	unsigned long c;

	c = *cp;
	size += c << 24;

all that much.  In any case, such a "clean-up" has little to do with
the topic under discussion, and itshould be discussed separately on
its own merit, most likely when the dust settles after this topic
lands.  Let's not contaminate the patches that is "a trivial rewrite
that is so obviously correct to fix the assumption that ulong and
size_t are of the same size everywhere" with unrelated clean-up.

Thanks.

