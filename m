Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E740757E
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538161; cv=none; b=creQG8+YbzAOY0CE9jS/9y6rQ6qYlGmeOpDfoFpqO9vIFRNu6E+f/qAlx/qRFDQRYG8WPEqsp+xazDVOR4UFQ8crcUYtf+6fN+dF4eeIrrLS1uLiRivDVp5sfCglXObcVn+z9D6sOpSLwII8P+zQcfrgcT8tsZWFfmxrSwHM1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538161; c=relaxed/simple;
	bh=7XkJahV7r2a90JZi6Zeul4hBzR4fXIGHtfBeUOZCgK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VaY4mRRZa+S2aPaErVBzuwD+vh05GC010EHK+OaHF51j2pH1XXpR3d46mhnpcG1ruo8bp5Iy40V85H9/4Knzq0ix2N6UmCK1BKodXRZknP6rD0cCGzqauQyQqnuRIQuwriteLan9zdojNDywPouyDUXSXyg/NVOqnMEVHkSUd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F4htcZTo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkITWS+S; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F4htcZTo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkITWS+S"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B17D14000B5;
	Mon, 15 Jun 2026 11:42:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 15 Jun 2026 11:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781538158; x=1781624558; bh=xUvGDcmhIL
	TH36FnsPM8o882ZqqT7KI5eH1mk9w+fwo=; b=F4htcZToUU5nHLYKU0+CcnEAyI
	dt/02RU0llevAoELN0Of57zoNSAdKd8kwA2If2swJIPGO/cmKhSld5qm3AfNN/IP
	MbzWitvUUVtB/zOmoFrmYEJfG9DVcQxqGmBR8PDD9xlUgFgcuG1Nn5dKNbC/WuoL
	R/KfITTWgh5SGoWYLsl/ue90gj63bOIjwx2aaqyN0T3RkzArrSbuFQg8QkOg8Kf5
	INF0k+nJc/1xSFYv0sS5G+hU62uWbAYWZ9KDMiPXriYhzplMuff72ERz4GWdjmk0
	XlIHQo+IEY8fxmzysEmOYpLwAiSYPrYarUa2ExwTVPfyFbMEEibS/XWevhoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781538158; x=1781624558; bh=xUvGDcmhILTH36FnsPM8o882ZqqT7KI5eH1
	mk9w+fwo=; b=KkITWS+SlFcyo6WNUYsOnIyfneIIRHSiPGx16TGMXyqbWTzQZOX
	WRDPNLBbQAgRi4NGoKSipg6jO2NR7pIIgxig9RUbMGU10yOzhHfjStT29q3ekczR
	mXE11SpxBNNjnGHbJU32kWvxTQUDa6LmAwZmTGcvD/PtbU7RKahtmSFgqBdR+NcU
	fgeuwJuPix9+/xN4bFqSG4B6317sdwlallJvB8C3wd6UGrNzuLQpAXucLqnzIa7N
	ZYBeGgqm6mN5WEoV5Jh95uqILGu2/PaxgjFERR2NHoiC5MRyEkG+hJG1j74p3CRs
	q8fZQe4WZ2UZKPeBmkf3xU/b9JDskXizncg==
X-ME-Sender: <xms:bR0wakRvsLa02Z1pPSUtZBnmG_r9t7Pxz_9LzJRZDphbWvRcwRSC0Q>
    <xme:bR0wajW1dAq-lIOFBwzZjL7-7hhUeqtRwvrCNfTblgCC935ns_Ef0sOFt1-g7DFhC
    rRZ7Vb0DU1faC4cVB9EasGvsqnxQCYGPHFoDOJ9KF7F_1NZphtGCQ>
X-ME-Received: <xmr:bR0wahFc5ZdPf3kbE8uS-_9_WUrtEiqL7lvh0I9DcMWS7wi2ASpzyxWTULdaXeTr1gF11PGusaZt_4mNKJbwX9UqmYZuUoEIMKgI>
X-ME-Proxy-Cause: dmFkZTG3bNvFM6g7SaNJCXDdenZ65RrIz5lz4ATd/O4+kAhY/5b3ky0+OlKvu3lJzH5qmM
    WO1LL9ijzC2nznNmYNjQQW9Ekl4TKEyl+80nqMwaFmNBWMqxPJCKjUrZFob6B8aA34e1Vl
    ElNEFdjRnBefx1rayoLhOBP1TDjlYMx+OVlCAEgRrx0cy8DTHA+BU9T5Yrbgj4mI0yPWTJ
    y7t2sj0e4/6gLBJLfZTjGqfGq6uWc48SQym12GIj7iitMRb5InnH9cG1Dbm8dc+zh1l0Bm
    gUzp64VAP3FmJvQo40Z3xXVIEw0KHMqPXKst4t2Mmvgs5iMjb+9mSNGHiJIXw4Piy2UcUK
    S6+ypj83qCK71EGt8f+ooVRGv9SFMvKx5FAua/x2tzUG7TeVJl1YkeNsc/xE2PKwhUdA3D
    ESzn9ZrMJGwGjJaQX7dKm4xe9RiUwL139CpRomKihtBl9vb9cz4PJSKsjXJT8pf6Afy3If
    C/IYZVxcTdyRnK2UmmjMVHB/SDBIulj/Bgn5ZUvuw70/7+qtulLFibNlBLRDqCTAl2/q21
    7kl3h4AJMRNkWm07lYYP8vY86xz5+9x3i64wvvid8FNJLySfLQ/ZuVk1j2dGzyjyl2sGhE
    KkSE+h3HOzbJAEtI9BqWABZ4o48tGqYwhGmbgb0oOAQslpwNOtlRjkJLwQUg
X-ME-Proxy: <xmx:bR0waudKCoZlNijKrDAY17xTPZ8qUqIW7EE0yqnmdk8ScFICW5lOAA>
    <xmx:bR0waip8Onr6hozPYSGKAN7tMEqXycj4SgP-uPFF0soi20Hv3XCNmQ>
    <xmx:bR0wanAYl8vN_2As6060DEc7AsxabIkxX4hX6jqsfUwQcQ0_sOr8TQ>
    <xmx:bR0wajcpepNeQdXhhpJq7bA3-JvZzbSY8DhtMTS4KUHImEihz0b7Ow>
    <xmx:bh0waoZAHsKD0bDwfNt5QR1N4-K26rziBIdgdiVF_T_7zwyS7aVvGaG5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 11:42:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,
  ayu.chandekar@gmail.com,  chandrapratap3519@gmail.com,
  christian.couder@gmail.com,  jltobler@gmail.com,  karthik.188@gmail.com,
  peff@peff.net,  phillip.wood@dunelm.org.uk,  siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
In-Reply-To: <CAN5EUNQ193QyOeTLdu9aXzDeBhFpg38YYBbOLhZLgcg3qfd=uA@mail.gmail.com>
	(Pablo Sabater's message of "Sun, 14 Jun 2026 07:28:24 +0200")
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
	<20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
	<xmqqo6hdepgy.fsf@gitster.g>
	<CAN5EUNQ193QyOeTLdu9aXzDeBhFpg38YYBbOLhZLgcg3qfd=uA@mail.gmail.com>
Date: Mon, 15 Jun 2026 08:42:35 -0700
Message-ID: <xmqqzf0vbyj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> It does not make it unpredictable but it makes it not output what I
> wanted to test, what I wanted to test is having an active column at
> the same time that visual roots in different cases were being rendered
> on another column.

Oh, use of commit-graph changes the traversal order, which would
affect how the graph is drawn, and there is no way to ensure that we
traverse in the same way with or without commit-graph?  That's
inconvenient.  But even without commit-graph, do we guarantee the
same traversal order forever?  I doubt it.  So I suspect that it is
a brittle workaround to disable commit-graph in the longer term.

As long as the graph engine shows correct graph no matter what order
the commits come out of the revision traversal engine, we won't hurt
end-users, but we need our tests to be reproducible, so that is a
bit unfortunate.

Anyway, stepping back a bit, 

> However having GIT_TEST_COMMIT_GRAPH in the last
> text for example changes from:
>
> * 41_octopus
> | * 43_B
> |  \
> |   * 43_A
> | * 42_B
> | * 42_A
> * 41_B
> * 41_A

Does the "vertically aligned * on 2nd and later columns do not mean
any parent-child relationship" rule no longer apply in this version?
IOW, does the above graph show that

 - 41_A is a parent of 41_B, which is a parent of 41_octopus
 - 42_A is a parent of 42_B, and 
 - 43_A is a parent of 43_B but is not related to 42_B

?  Who are the parents of 41_octopus?  It has no relationship with
42_B and 43_B, and unlike what its name suggests, it has only 41_b
as its parent (probably with history simplification that makes only
these commits shown)?

> to:
>
> * 41_octopus
> * 41_B
>  \
>   * 41_A
> * 43_B
>  \
>   * 43_A
> * 42_B
> * 42_A

And this graph shows the same inter-commit relationship.  So both
are correctly showing what we want to express, but they show the
same information differently, making test_cmp unhappy?

Thanks.
