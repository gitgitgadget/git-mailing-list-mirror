Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF35A31
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744071049; cv=none; b=bgPRch/hWJvr4Q1PKNFV0RKPU0+7TBcbRe+pU5B+kGf84rVw8VOCQ4HxxSUDiTLM0rS5qp5jMT5GsTvRvym1pqLLlJKrw2uULiX+PwydOPfTI4HmPBzo8Ki/+O9xwackru2AbgwbEyQycMLKUxuvSs03XlIZVr88mEM1ZRTFltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744071049; c=relaxed/simple;
	bh=qxgXIf51D7dXHATW2pDKXOebm5F8mVzrZRntf0O14vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fS1449OzElgD2u7bVxQ7Nge0a5UGMddtRV7dPqtA5gjxU1yiHK9SCuSH96NG4A07bVneG2hA352BJsHEimRtEH7yJXMs82GORBNTcl8bBBAw444fpPoqhyoFPWomCxoxVuANqomLZbpg3w5XbnU0kaL7m9xcELHNed90yDIg3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XeoshcQ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L1jZjsDz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XeoshcQ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1jZjsDz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F27AE11401BA;
	Mon,  7 Apr 2025 20:10:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 07 Apr 2025 20:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744071045; x=1744157445; bh=p4SVIZ3hQd
	vY4Xv2NbAVq5cCf/QGaDbnwZD16Kyb+Yk=; b=XeoshcQ0Tsg5U47YpavdQqJ4El
	bBYe5qb9xedPi6Tb3H2uCltjw7WcpWJkpa1M1Qn5jKWMWjNsav6XxpxlR1koisfO
	RyW+Bxs2xBbPpBOeWSXzaTeEyAB0PRYm9CeTI4ZfU2F6cgvajEjknpCU0XT/1ui/
	NMv1wNPc8Ae1bJkwmi6NVSpRj8YWiQfQo4aQdXpKtcTUMYZo3o5n1cnMJnGtcQ3v
	G2bRWtLfTf/YBfDLlo5JOotITg8bB/QoF3V3hd9DJqGZVYKGpx5KnFkxCrRvALIN
	MaNLpiH5LzdnwLHLUQCr4vUNAtAESgwmKz4Vu6gP4hrOOP/MlHqGJRZkrTNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744071045; x=1744157445; bh=p4SVIZ3hQdvY4Xv2NbAVq5cCf/QGaDbnwZD
	16Kyb+Yk=; b=L1jZjsDz+XBKDWbCqt6ssdWW/0s6qjPk3COwczwC+hKU3Juhm6g
	32DecLmZejFpea3socG/v76lQzA473RSCjA0rDsoRUpsM4DA5axdCKDL2knS4AqF
	1Qrqdl4BXeBMLyYXChBJ1Fdx+/JHaD+qk3DCcMjjAh9/O2HfqnaJzdTASQENWGr2
	fBRaK1JV1ll5N59qzk408wAfAUMWU6MBcJtMgf4qrFMKy+/eupiFV0AS+c74nOhR
	rjjtF7KaJ2dqjGNo4QpLSkL8Q2UnRL2EJP7J2o8zSnO6Req0TADvKLsfz5RPXqIX
	PNGxjySjiEocFvdJBWZOspXgINQA7HdrRjQ==
X-ME-Sender: <xms:hWn0ZyjdoyS0DWHF-j7kwvHxgasFkNL8rszyoCu46HWjtCCTKElhQw>
    <xme:hWn0ZzA2Tas5vPE2QH_ThF3OCaHBDvxTGElgsmyAhoKWKOABR6XtGN_mxLg2aFT6F
    515CqZYpvZ7QMByFQ>
X-ME-Received: <xmr:hWn0Z6GKL9rAi2LkbaQt6F-AyQx69rcM5PHLB2i6JjnS6OtFVb9M4AME9GIVJ5Dx22Hdudmh0eppFu3osGwjLY9VPdGx_tbKSYQv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepvghkvghmphhinhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomhdprhgtphhtthhopehrvghm
    ohessghuvghniihlihdruggvvhdprhgtphhtthhopehphhhilhhiphhmvghtiihgvghrse
    gslhhuvgifihhnrdgthhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hWn0Z7QYGkz9CY_OlrpYnm-RgxmykDT3EtFRcfzgW3xa24lNpk8Z9A>
    <xmx:hWn0Z_wAgvPUTz-saLMdFSIh3c3sv6QtP6wW5EF1N7eNhepCMUfYnA>
    <xmx:hWn0Z55vc2yXm_4jbutDWmrnxrb8CToy98s_xFh9Ut5_ys3wxdpDDw>
    <xmx:hWn0Z8wLtD8_V6pEA0OC_PAMJ-efdqTDz2FatIUUcNkCYXx9VvCZIw>
    <xmx:hWn0ZyCQ2ZtQKUKNgy13zmhj1e3U5dBN1dbufVk2bZmlToPF9ScuceMK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 20:10:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Edwin Kempin
 <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
In-Reply-To: <xmqq4iyzn0vn.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	07 Apr 2025 20:59:56 +0000")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g>
Date: Tue, 08 Apr 2025 00:10:43 +0000
Message-ID: <xmqqzfgrjyws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I have more problems with the remaining 20% use case, where you need
> to deal with multiple commits.
>
> Perhaps your initial changeset is a single commit C0 that is so
> large and does too many things at once, and reviewers would
> naturally advise you to split things up.  You'll come up with a
> series of commits, C1_0 and C1_1.  The net effect of applying these
> two patches may be the same as applying the original C0, but each of
> them is more cleanly separated to address one issue at a time, and
> the explanation given in the proposed log message more clearly
> describes the issue each of them addresses.  Now you gave a change ID
> to C0, and want to somehow relate C1_0 and C1_1 to the original C0.
> Which one gets the same change ID?  Earlier one?  The last one?
> Both gets the same change ID?
>
> Or your initial changeset is a two-commit series, C0_0 and C0_1, but
> reviewers find that each one of them alone is not complete, and
> because the issue addressed by these two is small and isolated
> enough, you are advised to make them into a single commit C1.  Did
> you start with two change IDs for these two original commits?  If
> so, whose change ID the updated commit C1 inherit?  Or does C1 have
> two change IDs now?  Or did you start with a single change ID
> assigned to both of these two original commits?

Another thing I forgot to mention.

A well-kept reflog on a topic branch can keep track of how the set
of patches that makes the topic evolved.  E.g. with something like
this:

    $ git switch topic
    $ git range-diff @{1}...
    $ git range-diff @{2}...@{1}
    $ git range-diff @{3}...@{2}

you can view how the topic as a whole has evolved.  A downside of
using reflog entries this way is that it is not well-suited for
distributed workflow.

A set of individual commits that share the same "change ID" is,
unlike reflog entries which is an ordered set of tip of topics, not
inherently ordered.  This is inevitable in the distributed world
where many people can simultaneously work on improving a single
"change" in many different ways, but making it difficult if not
impossible to see how things evolved, simply because you first need
to figure out the order of these commits that share the same "change
ID".  Some may be independently evolved from the same ancestor
iteration.  Some may be repeatedly worked on on a single strand of
pearls (much like how development recorded in reflog entries of a
single branch in a single user set-up goes).  I guess you would need
a way to record the predecessor vs successor relationship of various
commits that share the same "change ID", much like commits form DAG
to represent ancestor vs descendant relationship.

