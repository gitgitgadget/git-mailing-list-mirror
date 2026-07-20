Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B91C695
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784523307; cv=none; b=UHVMOl56lztceMnhCcZK+vSDeiif3AhQ0m1TjW9f0Y1pmS620DZQuYo+/seCEnZNtoNVJve7PLi+6QOHIw6l1U8Z6DsjCPMWlOs9GWyppAnXTyn3APZrUmLJVVWwJIedyGI5iICiizOXsyF5i/YnvIEL9mfhgTbG1VvAmvLIlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784523307; c=relaxed/simple;
	bh=7e0HOpwO4XTG76O5M5uLA+EQtrJoKwWHkj3jVFjm2/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEWAb/iN9kb6eojCjxJFMxBb9Cjdv2YTC1eXR9kuoARjrLxpHNr85KQf1cZ7DAq50hKthJk7KhIM19zOxAAM0dA95Wollhh3mAri9ylOqqaV3rnHEnoPnIB80gsbrBduMzmnHNcjjtnmSo2k0xty0uT+M+hcB9jLGa1rtAxC+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mS9s3dTQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B96dalH2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mS9s3dTQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B96dalH2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BC7C71D0005F;
	Mon, 20 Jul 2026 00:55:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 20 Jul 2026 00:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784523304; x=1784609704; bh=QnPqgrbUr9
	DNbmfbH6sSVv5zDlOl7tOfu3Hll3ycJQo=; b=mS9s3dTQgWrtrnswEGlVzoC26J
	Bbq6QOgo/Iuz/DYM7nHegrdcBCtcBhe5JKPYBhEiBJMx7aPPZtwUZlAggpn9lcTk
	A7ytURYiVd6r//uI2luMhMAiEqm7SrckcuTXH3QzdyxAHUztACNM4tm1YFgb6gcg
	vVVY/0XH+ExxVpKmM36+Krfy7j/xVQJo2ZkweYLZmPje6FZOpMqMlplA4WudmNSR
	jvZtNGeQwUu42Zo/jl0I3Nj4xzBQMPyqqrtNcgbPoCDKEmsX2zjgf6s8ML9W8ILi
	xyfD7U7QFqfBcEli6/EqxSNW1X5MsMg9PvpfHVAcRNZmxuB6CPunCCZnYpNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784523304; x=1784609704; bh=QnPqgrbUr9DNbmfbH6sSVv5zDlOl7tOfu3H
	ll3ycJQo=; b=B96dalH2RY+Zl4cZ2LCoyk8FaKsM59d50z2xXgqPItalG0SEfyX
	+IOuRATtYwapnT+aPyi2gbSek9lF/YjL066vSfZVfCt7zWmHDTdcpyZZqkl4/eRZ
	T6qXRRhcASFMMIU0FogG6yJjT/z8l6E596q6xfSxBdUjC6dPbatafgPZwoU1S8ko
	i+QpqQEgsepuzINlPD1hV5wGbIpVfd4CTXePAV23ZHGuGtZBlKnL/MctLUwKmwSl
	2/HF+QEzFbhytmkTQsBv1CrPeRFmacY7DJKzHE6F6SPehHCo/1A97BV2mXGK0SHp
	X1pZnjEJ7TZ71b1pxzziZIiK23IW3tKNNnQ==
X-ME-Sender: <xms:KKpdah1pldyk95el3ePdx7s3bu3v8kstAZAO97I-mFJmlH90TIyrVA>
    <xme:KKpdanLKMsNEZW_o0R0qdC2uh5ZqmMAl4Epx3SYYRZMLKVi88YCwkq0GSL4-KsYkK
    kBhBapOPPQBF6WDgL4wQbecCvJ6L2qWTpKAn-82DlhjrFT8MjWS>
X-ME-Received: <xmr:KKpdaoFcJ893kzy0lDMR6t2wPrOBes0TTbWSij6TKwQ05eWTx-cMrzehUl4K897aWuJu6dzeLdbMxU5NlGex0w3gTzhAHO-TJA>
X-ME-Proxy-Cause: dmFkZTEyR4gMwLy8q0PoUcAoMkMOFNUy0zF/yeMYqlzZM0RlEA4CeUGV7thgxiF16Cqa0T
    HV8Y/ILAKKY3kLSfchNZRGxZbjyObsl5gb9VphIrgHnpHP9sPntNuKy9T/3CMJ8NO0UU3k
    1G/T8IbDI1AhSTDcldO8MPSlx8oLGXM0xT5FDwnW5Bzw+l26JMi4mNKc+tt59HzP9fYKf6
    BfaUBi2PRQp9EZyNr4P6wP1y6SvedB2EQPi09oExKPFbs/lxHAvU/XOo4Nj9nVdcn/BKhl
    BfS3L33qhfeC1FWapo8lNqeL884g7q/bnOlbpHvnrwfS8uzBtvGovsuf0xhe1Fwe9rjWFk
    nju4umw+LyO7k7+ScDpNT212/Mgq8M6EzP0uejXFNvvHPkrW6T/0ImRKhx7u8mhEH0sSoR
    3LK10pkRry7GClmKTBcuW7KVj9z2JGRj8YLqw6c36VnIrGdPfEAgljUTEtkW+q0eH+FH58
    5yXBTimFNwayJ6gJxsRU69g6tJgbhSF7kqo/fCenCl7wOzh9uLGqkgZ9RHxYPuVI9yt9QI
    Saysx4ra7tCPLm0jO83LT+Vcy/CyBsXk3G7+W1NFA3cMFIWlx5kddKCppmeWJYPmwMuQMf
    Cj9hD+V0CY7EANAzggQwWkHspCcaKZBRaVqEsz8++tPwXpS3CMlw3C5mKY0g
X-ME-Proxy: <xmx:KKpdarVmsyoyxYlnhJ5CVTn6QFG_miWbWJxIYuzIZynyIakAaev4Ww>
    <xmx:KKpdaoznwylvt2mYo4rFhnhCJx-mWuAulhMnXwjSw2IO9bjEzF3GJA>
    <xmx:KKpdaoRcOYh1vi2FIGfVUMO5R6nrZr1NzY-OaHOKY3kVZ81niJjdKA>
    <xmx:KKpdashM_s0EKRw1P7kdZ2pi_mJo0x8ez-QWO1o2lxvD86Og8SGZgQ>
    <xmx:KKpdahsIv8AyYXL7IMJOxOSA9brq7psL7iIdj9EO9Jt1-hgmiGKAAIIr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 00:55:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Shlok Kulshreshtha <diy2903@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Eric Sunshine
 <sunshine@sunshineco.com>,  "Scott L. Burson" <Scott@sympoiesis.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add support for Swift
In-Reply-To: <2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org> (Johannes Sixt's
	message of "Sat, 18 Jul 2026 20:11:30 +0200")
References: <20260717140232.6722-1-diy2903@gmail.com>
	<2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>
Date: Sun, 19 Jul 2026 21:55:02 -0700
Message-ID: <xmqqldb6i7kp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 17.07.26 um 16:02 schrieb Shlok Kulshreshtha:
>> Add a built-in userdiff driver for the Swift programming language so that
>> diff hunk headers and word diffs work out of the box for ".swift" files.
>> 
>> The funcname pattern is built for Swift's own declaration grammar: an
>> optional run of attributes ("@objc", "@available(iOS 13, *)", ...),
>> followed by an optional run of lowercase modifiers ("public", "static",
>> "final", ...), followed by a declaration keyword (func, class, struct,
>> enum, protocol, extension, actor, init, deinit, subscript). The keyword
>> is followed by a boundary that allows whitespace, "(" (init/subscript),
>> "?" or "!" (failable init), or "<" (generics), while still acting as a
>> word boundary so e.g. "initialize(" does not match.
>> 
>> The word regex recognizes Swift identifiers, hexadecimal, octal, binary,
>> integer and floating-point literals, and the language's operators.
>> 
>> Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
>> ---
>> This addresses the "add a userdiff driver for a language" microproject.
>
> I am mildly surprised that userdiff drivers can count as microproject.
> At a minimum, they are on the challenging side of the spectrum.

I am, too ;-)  It is hard to get them right, even though thanks to
your earlier work long time ago, writing a test that demonstrates
what is expected of the patterns is fairly easy to write.
