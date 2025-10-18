Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E341D9A54
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804263; cv=none; b=l3KRsmmv6rh8xuYbQc0eCxA+sLe5upfYVThkKHdJMMyo/6ShYU9RvwMhjEfl+qhLqQiZVhTGiugTT6blPxn7hY8ldeQh+aMSXFc52Ii7ysBzqPuHyeP9QWemA3rDv82X1WwqZtGnbYa1vb9DCoJs3nzfTvqOsyoKnUieK/WvFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804263; c=relaxed/simple;
	bh=vzA9u0qBwrbjDK5qPXTUXy9vhBkmcRsYaYshXkas1VY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfhtnwpzbFETk6hhWqzCpNFFpOu3Eph01HzXkOjVwRfummM3FyfK5Jr6ybHJ7Sl0PuEjYa5wGCtETRtFZrEMwJjkx+SYmZHO0jKQyYOLIcbPqLLElEk4cMa85mwXY9FyYCQ2PbsO//8ZXbJg4/hflyTxnP149l5nOOkUfHFiZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V1dEb56n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFz14vGq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V1dEb56n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFz14vGq"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D55D7A0092;
	Sat, 18 Oct 2025 12:17:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 18 Oct 2025 12:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760804260;
	 x=1760890660; bh=cMpcTf07pQ6EWDmHr8aH1Dcbm7Zi5yozL9Zr0LN0zPk=; b=
	V1dEb56nO+TwPFZpIo6VG8PbhkgOZeLIsvkMmrwVoCwpr6LIAuCnG1G2g3c3jIZ9
	PRxfTV0V7SA9y0XMS3FsbGltrWTATRVqHqWCXIjZvB9ylq4WTztUv56maIPew5WQ
	KJ/+l9ULxu5zu93qisiXHN7Wb28g4CqNRx5dMxoBvVdU1UgsDtj5qYqKu/2uMNJH
	/1G8xa+3IG0HhAsqfZY413T4ImVUY71Fvl+ngM2pkR71PW4GmDNXL/Y+/xk/legf
	yRrt6ZDt36NAlAYJcTX7xY3LCsdje4iIiAQjyZo/XmttNCd+JyIs3BA1l4VasO06
	Hqgtq2Itvl6+YVeSGn3QXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760804260; x=
	1760890660; bh=cMpcTf07pQ6EWDmHr8aH1Dcbm7Zi5yozL9Zr0LN0zPk=; b=a
	Fz14vGqIJ1fbY3qqkklNnPdQXNdLB8AR8YrF0dX5tFvdqONtw7qkSBnaFB8KCVHQ
	9T682P0a3agpqVdQo/2jTuPjKgg+55uS3a+qOPBigKiBufx+5ZbumwHeGbvok9zL
	/NWjzW4hPZqTzx68afJBGqV5CujIYbIBmc3Z81wN5epEZzJjDetKq3+FBesY9hVE
	090/QGWpIH1n+gWvOGKhOu4WwF01lBcCHTDYrpaVQDE+mfRr9VoMcQ3VfBmIkuqx
	x2t0UMocmybKsM6qPpM4R/Km6xx+r1xwX0b0PPoXM/2KRjiE1a1cb4wtAO3VOV0m
	nnb/7OGB1aHNVP1dl8ZOA==
X-ME-Sender: <xms:o73zaEvtQD0PzoZht8bBDW69Aqj0HpfdXwg8CfN0ZJCo8Gxul-zyiw>
    <xme:o73zaIVRJ1CsOIAut5HneODjzMEAUP6xmtMU3BJNL2Fi8TKeoa00InsNHHaOVgxGF
    YO3xT5NJCCvsuTwBtC6By2vPwtJKLpwynQS1wFnFOANl26QiQ4X_KA>
X-ME-Received: <xmr:o73zaIHGqZO99JBM4PNxpuEukRqqpiFt8XgPFdrhLHKzVeyQsf_4vcFvouy4TpPhUgpxeqkfe9TQMj4mmHMFtnqxYIi-fVgU68EF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhulhhirg
    esjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:o73zaC2VLsoZrFilZxFoARzXK5jyrzXEgooQrUluXHCf8IqjfLdU7Q>
    <xmx:o73zaCOvbbDzLgwyIi3Th6BPrHbPgiDiclYlE23odWLHq_5oqJi3LA>
    <xmx:o73zaJ5dTXyCtejDBXs2ruPIbhl5w5W6yyEDq097TIxPJq1YrTe9bg>
    <xmx:o73zaE0Y7hZ2UMaT9kVvTHvqlGGJitTKlbl9CSpCLLRDWkOUvJJLbg>
    <xmx:pL3zaKFRHY5l02QPcvUTEXU382Mw-8SXGncN7LrzIsqrW6gj0yo5-KT9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 12:17:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 4/4] doc: git-reset: clarify `git reset <pathspec>`
In-Reply-To: <9EB375A8-CDD0-4717-B1DF-32DC3078A50A@gmail.com> (Ben Knoble's
	message of "Sat, 18 Oct 2025 10:06:21 -0400")
References: <xmqqa51pxg9p.fsf@gitster.g>
	<9EB375A8-CDD0-4717-B1DF-32DC3078A50A@gmail.com>
Date: Sat, 18 Oct 2025 09:17:38 -0700
Message-ID: <xmqqy0p8uqu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 17 oct. 2025 à 19:25, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> ﻿"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
>>> -    Interactively select hunks in the difference between the index
>>> -    and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
>>> -    in reverse to the index.
>>> +    Interactively select changes from the difference between the index
>>> +    and the specified commit or tree (which defaults to `HEAD`).
>>> +    The chosen changes are unstaged.
>>> +
>>> This means that `git reset -p` is the opposite of `git add -p`, i.e.
>>> -you can use it to selectively reset hunks. See the "Interactive Mode"
>>> -section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
>>> +you can use it to selectively unstage changes. See the "Interactive Mode"
>>> +section of linkgit:git-add[1] to learn how to use the `--patch` option.
>> 
>> I do not see a good reason why we avoid saying the noun "patch",
>> especially when we see it in the option.  If we were allowed to say
>> "patch" here, "changes from the difference between ..." can be
>> rephrased to "parts of the patch that makes the index match the
>> specified commit", which may be simpler.
>
> I think the issue was the word « hunk », not « patch ».

I know.  That is exactly where my question comes from.
