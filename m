Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA140ADA6
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032675; cv=none; b=MMxGHwzPiCoGfKxY3B1ipCErUU+7nIJH7uCVVSDTp+dnVVAKivlzuiNeDcJXie2q8jcvSn+WxQuBFkU64240CzFE0W67AE8r1bj/EKGsiHVifKnLqvQRX1jtIGlgBayyZzoZPKMVGNgjAqHbNLhkrExcjZnA6ZI2vbJDeYJUKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032675; c=relaxed/simple;
	bh=MBSzjmsoRszqmwmO9OnYVRpPtzr90+ZJc/qjiNE1mRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W5y1XDnKORkEI04z4T+kYSlxy43HOMlwcjSqrmt9ta4OcpvXW3wPG8XXyCFHGnTkQodgnJsXhwqYODcyBny50fKQRfF5LHqAGarVo8ijK5yYQmptrH19QX1CJWbGkg6wnnTyLMYgH5YNnkP2K1iVPn5nZ9soKPJATHsVB1AQ02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gMpB68++; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CE5pjad7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gMpB68++";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CE5pjad7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2809D7A00C5;
	Tue,  9 Jun 2026 15:17:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 15:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781032673; x=1781119073; bh=3l9BVYQEEm
	g98xcmZYKaFsGB8iDjQWkA/8A6ObkS6+4=; b=gMpB68++E2vYOqihLuPvGwq/9K
	huuNqrUIDheBernqXO1c+tvHSB8xsCxXEQe+g1lA8t8rMpz1/5jis+Mce2xsV8eS
	5jaXuvnQVvum0k8s7DjDJduGfOcq5nnWk727uLn9cRMT9cFU9uXS2eyDO6b4nXKL
	RayNZWf1AY8D8CAY0XK4+xPdzfhNbQ70eIUO7sdRQ6wjsWjolEKk4jgoG47MVmY0
	kPYVuufalL2tpar5ngYC6/kwqKqheXtCz5uoA3FBI349Nt6Yls7EnhUy3Jt6K6ph
	u5jCmysJrdkWeyNgNzZGS4hZXA0B8/jVxh+x4+wKiCmgQ2VVEMAfT4rgKRwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781032673; x=1781119073; bh=3l9BVYQEEmg98xcmZYKaFsGB8iDjQWkA/8A
	6ObkS6+4=; b=CE5pjad7LmhdyLN6JewpKuV1dN8kN20+Vjx7J8bQFvKmOz6jCY2
	6fp0wi03gVKY1EerNMQh6uCmUl6hPBGuC87cbe1g9i5Gt452MJitO+Tjk9XwZNpH
	4iDReFXmOStGACtC0J9Y3XNDAoxjs8q8ys0lSDTm8kL2NLidWO5h9fMGlKA8AxUZ
	/lhsf4BVxxCTEPJmwGU8yhccQTq5oWL3uIZXAi4+h4UQJrSvaIbI78kIf1aQj3+m
	K9FaatgagVfyKlEXZ2WgqEjoblfRv2FsObhPFqce1Dt68IITdKBJooMqYkdlPaOA
	IMbBue0f0O+LzmsydA2wqiBolVV4CzWQjrA==
X-ME-Sender: <xms:4GYoajWj6JqQ5Y140Mgy2nZF58jYWI_3ijaTcFhJqsgNOQYZEHLUkg>
    <xme:4GYoaqoW9PBYpMIxEg8b2ZPHjyB0bZTsFweflSHzdXMqgr1OsK3vwYfd3Zatgpufp
    b4Ld6fQpy5PeCVnAHR3xLUmcOvJGnu9CbRyUs3Bg9QUhZiw9_JLMXI>
X-ME-Received: <xmr:4GYoalkgj8jYiiM3a2TDpsZ-TyjqHElfxwF9VXBKcfJnHgwFk9QlB80XG1eh9-Eeds1LNUh8v8S9TWra0OkTGiehn9_b09Ub_fSX>
X-ME-Proxy-Cause: dmFkZTGZn5byMUCzAHxjHpsKRcgaGA9XrAPYk3kAFuiugFp2bILmjR2CTG65vIC18P50sI
    CUKPbYTDLCbWcvP8gg/EG8Ycmu+SkapqOVTE/uPqtR8icdHcR1pS1WSxP8MntE/8pqavTq
    gD683QVaqo12l4Ff/u/Qhwe2HKagOW6aYmDzr14tprjdy72rWrC27qtcSJDGUc5JpsrMo8
    238hu3T2wJm2IOlO78Zzgg8hv0mRmlKbK34Bh4Djgd+4B1darCW6g9Y87+Kx89oPal4xK5
    Pmb0ScsLNKJYNd+Sp097v3ZILdHVkgugjp8z3k2WHMprP9uCnEQEszAt1EE6ezyqT5g4fU
    dFNw4PQUucffX+WfbU08JJniVbWLlA0+J8NA82UE0gNEbuaPupA7aXE1nFsI/5jLOvuxKx
    nO8nSlYNJBR/26v9BaN4lf/dJyXq1Lvd1JjwNF+bGgDufvscOdXtcQ2AUZV0DzYQCqBv3P
    /cf/cwP4d7haX/QMw/sqV8R/Nv0vVlCBvp95dgLFPTOoXxJXqHzjLB0vnbSwRWmQ99I4h5
    ASwbUU68yO12h5ia3Szuke8zz7Q2XlHbNtZGJAyFURweOJP3Xh8CP07lCN78UbcIxT9TBL
    QN4zylSnYWoG9VYJqykHW20pvWT41px2mcTr5iE27vHDPORp/nXkMJjoO6dA
X-ME-Proxy: <xmx:4GYoaq3Z9XCB3vwUttfNJoC8C97ffgGT42-67X_B9LVt9KzyYgpENQ>
    <xmx:4GYoaiSr-dOAs0h5ovKlxlquzFrfKF3egB-RDrJ666CWm4ePd7lJeA>
    <xmx:4GYoajw0-G5JnNvHATEiruSS171TMxHJ6zGMNpZHJVEEQh7QEOjK8w>
    <xmx:4GYoaiB2r_AwZ537-LiNQuYZAbbA61iKPWfdHFz4mhICrDLTztTWfg>
    <xmx:4WYoakAfS6BRe1SEid-z8ySu4Ssy0u3RvJwVRia7Ya1RXoZqQG9Sik5u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 15:17:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  cat@malon.dev,  ps@pks.im,  kaartic.sivaraam@gmail.com,
  ben.knoble@gmail.com
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
In-Reply-To: <CAN5EUNRz9F+njb_O=Q4DzVMec-q+rDf83Ow+MPJE4yLCBq9qww@mail.gmail.com>
	(Pablo Sabater's message of "Tue, 9 Jun 2026 19:12:17 +0200")
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
	<20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
	<20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
	<54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
	<xmqq4ijbsn2m.fsf@gitster.g>
	<CAN5EUNRz9F+njb_O=Q4DzVMec-q+rDf83Ow+MPJE4yLCBq9qww@mail.gmail.com>
Date: Tue, 09 Jun 2026 12:17:51 -0700
Message-ID: <xmqqbjdj1q1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

>> > I wonder if we should check that the committer identity is unchanged as
>> > well in case anyone is using this to fix commits after committing with
>> > the wrong identity.
>
> I think that if you reword a commit committed by someone else but end
> up with no changes I want it to be kept as it was.

That depends on the reason why the feature to "reword" the commit is
being used, and the use case Phillip is talking about is a bit
different.

A very common mistake a new user makes when starting a repository is
to make commits before they realize that they used a wrong identity
to create them.  They are happy with what they committed, except
that they want these commits to be attributed to user.{name,email}
they corrected.

Also, people often use multiple identities (e.g., corp vs personal),
and when making commits to the project for their employer they do
not want to use their personal identity (and vice versa).  After
making a mistake to create commits under wrong identity, they want
to fix these commits.

In such situations, there is no room for leaving the committer name
as "someone else".  The user wants to get rid of the "someone else"s
identity out of these commits.


