Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF83BA23F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621546; cv=none; b=sYXfD4smSPqQzuSlp+a2nx4mpIpCL62m40BAI8pL4SfieqLFrZfiFGxjO/77VnQ9zF0YAde0UaNhxyfJVAUq1y7RcSGxZY8RxRuM9Dczovnf5hhM0ht8Hsl4ubQpTeztDq62nFM4u7g2R7q2VAafXwzQ+h39JuhpvgIRwM7nWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621546; c=relaxed/simple;
	bh=EUQ5u4zJMCjErVrCCh32onDXX/tX0Cxr+0EC/nrV2MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQvqQPpCrSymgkFpgCs9+9nM8iYQnnVW8z5ROZRsO7R4KQvQSJ0KxHghfl6CzVWqliSDP88N8fhwFgpizniYzwVXQVbhpM6WyLZjJSH+qE9HRh/DDXwMlxsqckXz3RE6TAZzRXGapO8YLOkTIk2ejluO7DrixQqR9KoVezD9EpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TDgF5BGX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMOOpH6d; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDgF5BGX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMOOpH6d"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B19151D000CD;
	Mon, 28 Sep 2026 14:52:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 14:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790621530; x=1790707930; bh=OjbO/IFkmZ
	v9FI2LuUAwL+dBkoSL9mQzGp06/teKNEQ=; b=TDgF5BGXhx0ljNz5O2MQrFsS+k
	MWqJcVijV4Z1muY7xFfkf7aHuAhT99M5EKGuCe8gt7qq1v6frKL2TExxQb9EZ7eL
	GXADyejNuHQfONq5JRLoy/MBOBXiHQhOwOMnAC/Wzb2VHLg89U7/FntrKuTWt5/s
	00AOM8QOsjJBhk/G019j9tE+rChGTnfDZXp5TvSEs3+AMllKRtcJd3ID3hLXwASq
	AGUG33D8svVNsjKlC46lFvvzioH6So3LHBBmKMs8drC2apJP36surWoNKe+P1Nql
	ynuQ/poFpw196byTGjYsPY9rNSIYD/23g87WX3BGiU+Ja+ZuH1tz9vzpFPhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790621530; x=1790707930; bh=OjbO/IFkmZv9FI2LuUAwL+dBkoSL9mQzGp0
	6/teKNEQ=; b=IMOOpH6dU7kgVJ4aKUD6IlPl/DflytY3eG0SBatvMcA+f10/Oty
	0i3lZfZV5h2yN81ucr9HUUKhSXjdlhKRX2JG5B9PuRqG7Tclg7tT9SFQPuctKWCZ
	9XhT0QoKqLTBS9Vz7WiiHsCxi5/7cdJ+/mHghsLfqJPYTJV7ib4bKClhMLaWTS9f
	KncwW/YLKZWFV6lh64AxBgzMqA9VjFkwPArhF5BLOYGfIHlu+k2xNZIHgFGbLWob
	ppTo9LG4QGH4rblvypjgWc88x0V4VpC0rZAHZkVsIQwNJrkSaULiyJFTDPmqq+aL
	k6HhD1r81J28dxJgYMt1Y1WqS5rkD/v4KYw==
X-ME-Sender: <xms:Wre6almC7SgA20RaovxRM5xN1CBB4tU7TP3SfoMO6Q4LOpjNM-XJdA>
    <xme:Wre6an02d4tGoIj-dYD9oXUzrlkp52LjqVh5N5F_xgEdrnwX5az4EGVtPEdWjvvdR
    TQKIKwM-9kVoJKw2IGVL9uQ2GPZIzdZ0PeUViqkleJy8ns2Jd6V48A>
X-ME-Received: <xmr:Wre6agqP3IuTIeUJaG6GgrEv7G50Go9NnpUUCN1a1l8kLWVYXnNdm80rlWZqAHNlaMSjjesaeJQPUvGJVj6G1KVjqdbY2jkRRKQL>
X-ME-Proxy-Cause: dmFkZTGLnCRZKWFC16tJAtqvIe/zAux2ZsUaXRM3vdqdeOD9iYneGcmLxMy6qevTsOqCxO
    IK57//M/1a1UR8zdatCL2OfF+08Cpcp2PxQOiyrhr40pClH4qe8ZOc3uN9fwedfC4QjNgG
    KmJb29UwitnRbl0B0Rn5L7dG/lnFjY5u08TYtOYezt2iHwvCTFRaUWX8TVQoMR/tTHgwfX
    poRgCKkwjtarK1f8LSljPUsfsq4Uv11iEbas4DZJmC0ZqFq8YxNJoQgl8/UjYP7bS8hMI4
    aecShnBDCEXxnuDSCVkKalt0k71T9PEVhmIG2g+Xw5MqUyaHDOGDKV0/Jo8OBin+Cd+EBk
    rhivT0pghue8E3Poe26Lem4NWMkL9aBjYD4ebj32Gyjbt04xZOy37biu3QCYdYuQSMTuja
    iRO3vH/Gb5fO3aKBdJac5S0bA9fJrD78Wng4cr3BG5gzEbTinbm3SCt1ROSqIEq/8Q4lZx
    ksX5gxmvKBntQUMzb0RBC5GaVH/a1ao5czHO9OsAg58PqwTmfO3ZLsFQcBoUD0Fxp9NH/r
    HFcqVPtKMeU9AQXYmignFX4XqZF9uMqEq4Adb1UknWQPQeQDQTgGRT2j56txxo9Rf/6Fer
    6x6dEQ80d1a7mXM96E/GMlfxgfajp80u5S8q8nntpJnPlH2FL7u9DzmZ96GQ
X-ME-Proxy: <xmx:Wre6akfxwxcsTx9Hf2We3DwQzH3D4vK0w2m_vUamedjQIZYHiDo8kA>
    <xmx:Wre6avq66NXMslr9iY3EnmwEk2bwjNC2vYWzOkVG5Zhjz9SKBxN2Bw>
    <xmx:Wre6alGGIqXlquY5ru-39riUn54-Y0MuhJl4cQOGC9ZwLuJOL8BHJw>
    <xmx:Wre6avsJ9-xZ6XcSnUfpgAcx1Bs-bSKfSkATWt2wUNyPdePWbr-AXA>
    <xmx:Wre6anRQcKOQLT3Q93wFRbHO9b3Uyb0zDgOG4VcajFVUMQjpTOcbcwEd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 14:52:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Souma <git@5ouma.me>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] history: sign rewritten commits
In-Reply-To: <xmqqtsn9o1yj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	28 Sep 2026 08:00:36 -0700")
References: <20260703145037.69832-1-git@5ouma.me>
	<20260912160045.36064-3-git@5ouma.me> <aroX94CD_kOyLnuW@pks.im>
	<xmqqtsn9o1yj.fsf@gitster.g>
Date: Mon, 28 Sep 2026 11:52:08 -0700
Message-ID: <xmqq8q4lmco7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Sun, Sep 13, 2026 at 01:00:45AM +0900, Souma wrote:
> 
>> One such subtlety for example is that you reorder the calls to
>> `repo_config()`. It's obvious to me, but it may not be obvious to every
>> reviewer why you do that. Pointing out and explaining details like this
>> in a sentence or two is useful context.
>
> Thanks for pointing this out.  It encouraged me to take a peek into
> the area in the patch ;-).
>
>> Other than these nits about the commit message I'm happy with this
>> series as-is. I won't insist on a reroll, but wouldn't mind if you did.
>> Thanks!
>
> Thanks for writing, and thanks for reviewing.

While we are on the topic of the proposed commit log message, is Souma
a real name or a handle?  Documentation/SubmittingPatches:[[dco]]
describes a procedure with legal ramifications, and that is where
Documentation/SubmittingPatches:[[real-name]] comes into the picture,
so I have to ask.

Thanks.
