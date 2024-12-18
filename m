Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202A1E9B09
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536772; cv=none; b=sGRyqciyiP5eRPp72KNK1Iy0K6au5IsGAaQa4EPPnYGy3DmHYG9JUFOOWZic8oaXXHbYse7ZSAOEj0gxNdweY/KFXYLAgr1H4kbO0bXxSa983CX6uKrahGUoFpXubvwmJVARrwh6Xd9kjb3TIeIjaOEFHpbg7hpzztFnH3AOn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536772; c=relaxed/simple;
	bh=7S4ytnHP0WbUkoMorN42LE4lQscEVMmkGW+xw8+V47k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSErrS7HMZMqb53H76wIZJkTXqqpE98pVU9zzOZdEx6GLhnsnL05920BbdKszq/15y3Z2QAhmPWF3ou+BIQR9CIZ+n/6bmaowXsytIpKPvRfiwmO56aTte2hT0tPcQDc03myvFLeyTwHaNtYIeZfqVKU456RizNg4zvkZr57EjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EBDxX3+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPKAQ6PR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EBDxX3+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPKAQ6PR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F3F32540194;
	Wed, 18 Dec 2024 10:46:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 18 Dec 2024 10:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734536769; x=1734623169; bh=en1GI+sa5h
	ezP7226z9QNWI2KgyGY44phWW8LKLF0+Q=; b=EBDxX3+APagRoLPHWhqlvKti3c
	kRAFfLq/TAkVRPjwjTCUiFa/iPb9SRepEbcUymoXLZddm/MtDEZFVFDIffnvtVyW
	UXLa1iZl9shPqFAZ/ZQ40+JvVg2n2W4yDyEdht4fH1LYzPgQiymcQGJApyWM8/lI
	uw/ndZNV2NeoIE+okx/2m5pdklDsTm3sXJJHI64gcnz5Zgp5HUsDTT8hz+MISmJS
	NZoNrtOMdFR6NRPcKzWbsj/2D+MxiVAo4YiuKAQrFdVW2yiwIsCM4PJ9/pfkt9bs
	0NWajZyZFckPJzjN/7g0hFaGOv8jtsnKSR+A8CBFhMjLmkh6APG+JJY0mljQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734536769; x=1734623169; bh=en1GI+sa5hezP7226z9QNWI2KgyGY44phWW
	8LKLF0+Q=; b=TPKAQ6PR+LC2WK3zjbTTBnkaPFKA3pVMKOATAUWuJRD/722GNXu
	wJ+nv/tqGmJiQ+dPZodShdPZNTmg1SOJmTGg+ermFaPgRMY3qdxtRWEgQLlhopyf
	4Bc34+7Vmwz3Qnr5kWYB9ptnYKdsm3ebSbvxeJboyvrKZmvSekN9Gb+vzhoohn29
	UJEZR0v9QNNtB4UV7xl1xie8umSmrHb2zv1tJmDcO1HHkxa/0Bl463mV5m0HE8MI
	rHcKNJm5lyZsfFiuznu5SoDJa3JKmzDMJVzVXWt5Ys/lN4kK2wpJj2OpJqTxIVOD
	fdLpyYBdEcyhfizP8F9LiohnLDjM2h3OUpg==
X-ME-Sender: <xms:Qe5iZ_RV3JX6Z5C70f_SXZb2Hxkf7TdV3Euu1MB5NhxGNbzSZYFKLg>
    <xme:Qe5iZwzt7-Ao6CkZXKSWCUiHxWpz6hjOxq7ytR8Anr21Uqb53XTlvCpUW6TuIy4Ho
    ycXk0ECwPQl7oDH-Q>
X-ME-Received: <xmr:Qe5iZ00OkTu6_40hjZOpM3kvuTwIkMncvjjhnbCH-sQVORzvGKB5G5NQMrYqDotDueXaZj1aHLq_rCnO5rMdPwkJBocWJYE6PRSGl4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepughsihhmihgtsehmrghnjhgrrhhordhorhhgpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehlrdhsrdhrseifvggsrdgu
    vgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhfuhhnnhhivdefgeesghhmrghilhdrtghomhdprhgtphhtthhopegu
    ohhrvghmhihlohhvvghruddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Qe5iZ_Cwe-mn3csWCrlnpxYp11r5p5WYeSwuYU3D2YinWU3MbECRfg>
    <xmx:Qe5iZ4i6JQTayqKQzPpUVRCR_QYOFoPlKeK2UQ4mQOgA84bCy3n9Yg>
    <xmx:Qe5iZzo47Q-yLnz1Ca5nQtHbQYmvMXBl6-upVdf1YA7-8ymoM-lXxA>
    <xmx:Qe5iZziemnz2GmcCVFN7VrrU1e5ffIkJfeAh9EG-kflEQTd63b9orQ>
    <xmx:Qe5iZ7Ptnokoq44dknEmtlUumiKrD9VBlE-vkqYAQypaUTLk5c8MZ2kG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 10:46:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>,  Jeff King
 <peff@peff.net>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Phillip
 Wood
 <phillip.wood123@gmail.com>,  AreaZR <gfunni234@gmail.com>,  Seija Kijin
 <doremylover123@gmail.com>
Subject: Re: [PATCH v3] git: use ^=1 to toggle between 0 and 1
In-Reply-To: <pull.1620.v3.git.git.1734482536998.gitgitgadget@gmail.com>
	(AreaZR via GitGitGadget's message of "Wed, 18 Dec 2024 00:42:16
	+0000")
References: <pull.1620.v2.git.git.1734481009264.gitgitgadget@gmail.com>
	<pull.1620.v3.git.git.1734482536998.gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 07:46:07 -0800
Message-ID: <xmqq4j31t2o0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AreaZR via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> If it is known that an int is either 1 or 0,
> doing an exclusive or to switch instead of a
> modulus makes more sense and is more efficient.

FWIW, it is much more idiomatic in this codebase to say

	foo = !foo;

to flip the polarity of foo when foo is used as a Boolean.  It is
both more readable than toggling only the bottom bit, and it is much
more robust.  Here 'used as a Boolean' means 'is it zero, or is it
non-zero?', the norm used in the C language.

If the reference to "foo", other than the place where the value of
foo is consulted for the sole purpose of fliping between true-false,
were to check if it is true or not, i.e.

	if (foo)
		do something;
	else
		do something else;

then at this "real" use site, only the zero-ness of the value
matters.  foo==0 does something different from foo==1, but the code
behaves the same way as the case where foo==1, if foo==2 or foo==3.

But the code that flips by

	foo = 1 - foo;
	foo ^= 1;

makes an assumption different from and stricter than the real use
site.  It only allows foo==0 and foo==1 without a good reason.

But

	foo = !foo;

keeps the same assumption as the real use site, which is why we
prefer that form.

And like it or not, it is natural to assume that 0 is false and
everything else is true when writing in C, and especially in the
codebase of this project.  So let's not flip

	foo = !foo;

into

	foo ^= 1;

just to make it look different.  Going the other way, or rewriting
rewriting modulo 2 arithmetic into !foo form, would be more
preferrable.

The "flipped_block" is used like so:

	if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
		set MOVED_LINE_ALT bit in flags word;

so it is very much Boolean whose zero-ness matters.

