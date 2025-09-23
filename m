Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E92226D1D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638625; cv=none; b=i0CTQS6nUcLTERlyTkbeMwcWG6JGqaJBtSb7w0aPuJsg8YJC8TATlx8FX/kwM6R8Bpgotf9sdAiLlhVjqsPhMOyx4C8RNM8MpBCjZ99W13IBhXUctcYs82w/IGwJqqL3Sb2da9aGXhShKPIKg82DzdrSzODgu7+2YGNIhsQHc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638625; c=relaxed/simple;
	bh=6QOSrbI0Sp+L/Pa9G1vFP7ujIN3Qcos3Wq7MlRRdZfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=piPOejdLSsKTkWzoH0Bmlf0jugucrtqcuAAjuNqnhLQKXX+pLI9foDnbFt5ISIMRKQAh1y2QrxwzevwVmYmhbJaw7Na4TkkYKmLMnqGy6jdIS/eeRypWgArg/CxFUowroof3mFW4Y87MiRYMoy7tE2pLirF+DgKYqHb/ycvHZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jOsO6BQn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RnjIRKoO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jOsO6BQn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RnjIRKoO"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 93C5C1D000F4;
	Tue, 23 Sep 2025 10:43:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 23 Sep 2025 10:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758638622; x=1758725022; bh=jSiXBQfimZ
	9R4hk0qJZYMGqk42X548DzEMgmO/p5yLE=; b=jOsO6BQnQx9ekNHcpF1lkUNlFR
	RUmsXj7zXAv67bXcIFbttZwfG8o4/nRo1mhIYTUvMZVoBA8tPOmqckiixeL9LWyq
	7isIwKzV2P5mxNo3MrELVq1o2MlFsMXVpCKnja/m96Xj6sgqqWcWpJhDC7KZatm6
	B12P7xGcFo6AIECIsfCUAM+LVP6nA5UdQd3shRm+7wqOYj+Z1BixK1j+r0nRYZ99
	zQfIgciXWm3DZqhJj8mI0e8HyEJtZsGTt7thhiJVSKYN31AUF0snDgZYipgPZxV1
	CclNHTPjGLON7KnvyNenzdoxqZLfKIoqrHrGbeXxavRRVPB/VsfPIa74LgCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758638622; x=1758725022; bh=jSiXBQfimZ9R4hk0qJZYMGqk42X548DzEMg
	mO/p5yLE=; b=RnjIRKoOFFlYD4vMiN8mMc9Ce1hJPDQZ45h5+bUxLPT79MoJ81b
	S98hUVyaZedx+zqjulx+icevDG4ZxNTjYE2vVBAiI7bjQBsS3CuzjeeWgZvaMScm
	MbJUSC348m9oZFZd3r8Iwpsh1iA16CZvN1rTIB2APXGL4OZUtkPOsXNXpwb/EYk+
	7krslb/0A7drN+Gd896gPOD6OZdedPQx6aY8IjCGFGIOmXZvaHJCWAS2y6Y4xgVp
	WGSkaoDwlqN+NB4vvMM+ihqtfwgmypYX73o1kkK4xwETDLvBiqhx0hzjK0Lm/Ov3
	S2XY6GccUkebwoXeUAh70WzXUir9VEVGBig==
X-ME-Sender: <xms:HrLSaD0UGQOuQrtiXldmDRGL86tFh255wwAfO4yR0qbRpqOQczGLWQ>
    <xme:HrLSaJhj6hna2QSa5YaqChvCHyLjKXFkfvc_XfTKHWu-utfK02KUyfhS37Kr7bTHd
    k1kZSwfGZQtT5mpEdYzzWN-F9fqsZ8HD17JJO8LeAm5pAHlysw3KQ>
X-ME-Received: <xmr:HrLSaBQA5XJLIe8XXAK1KhDr6LOrLCMDuwsGZWu9c8R9BxsQaPKMwqNSYE6LoYehlnbsolrUuH4qdE3JQNjgty1oOUMe4hE9WQYz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:HrLSaCiEzfy_DrZAT60jZ05dm03AQVi2WpnmG30JHukUDL1zHaKB4A>
    <xmx:HrLSaJ6wfjePdrf0i_EUMmwowfr16NCvi3-6xgAcZkyhmrz0N6kDNg>
    <xmx:HrLSaHCo2FNk938eIo96jJ58gR_3uE1j7x27maGY4kU5xv0ptK4E2Q>
    <xmx:HrLSaIZhpy-e3C_Pmp0XFKKmfe7xhV7uwMfLzf8h4HmQsdCMCLM3Qg>
    <xmx:HrLSaJp91yYJEpR-llv9UbpXxBtFleiDzW1UT0yLP3LO15IEcuXqeM3F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 10:43:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC] doc: check-docs and WITH_BREAKING_CHANGES
In-Reply-To: <aNJUUxfhM7QYDQGj@pks.im> (Patrick Steinhardt's message of "Tue,
	23 Sep 2025 10:03:31 +0200")
References: <xmqqjz1u161e.fsf@gitster.g> <aNJUUxfhM7QYDQGj@pks.im>
Date: Tue, 23 Sep 2025 07:43:40 -0700
Message-ID: <xmqqikh9p6ub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git i/Makefile w/Makefile
>> index 893070be76..711cade8fd 100644
>> --- i/Makefile
>> +++ w/Makefile
>
> Curious, but what's up with the "i" and "w" prefixes here? :)

They indicate that you are looking at uncommitted "here is what I
typed in the working tree for illustration" changes ;-).

> I think this change makes sense indeed. It means that we stop linting
> the docs, which is a bit of a weird side effect that may or may not be
> sensible. But in any case, we should probably stop installing these man
> pages.
>
> I say "probably" because this got me thinking: we could keep the man
> page for a while, but completely replace their its with a notice saying
> that the command got removed. Even better, we could even tell users what
> the replacement is.

That is true but requires a much larger change.

There is an assumption that programs whose binaries we are not
installing should not get manual pages, which is what allows us to
throw git-http-fetch and git-whatchanged to EXCLUDED_PROGRAMS and
cause (1) them from getting built and installed, and (2) cause their
manual pages not built and not installed, and (3) tell doc-lint that
it is OK to have .adoc for these programs' documentation, even
though they are not listed in the command-list.txt file.  You'd need
to start from disentangling that.

Thanks.

