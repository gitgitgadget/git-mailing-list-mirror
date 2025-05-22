Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40DD80B
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929361; cv=none; b=eBAfJqt22aFx96IAkfxva2Fy7WtDVEaMhk51wILKqmZk6aOyFEB0znKWYX8Rd45Ly4aFAxqhcZpD6zDAXGpxgZH0djuCmTY0qVqES03sv8iPiIdxSXbDKBp4EpajoT0yjmKXTTSuyuNiB+RRf4cnqvuOPx8LR9n2HLKjIjV6Y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929361; c=relaxed/simple;
	bh=BE6W7koO2YD/XtNHGRaUkCMWjV5oun7VDyxnbI0+nxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CoOi70c4P3GtbdrIi2yeixhV1225AndxSeUBI8rUuseloijWHfCEOy9lTAY1AQqqvuktgrDYvvokONGQ375VxbX31Qtq+3zuYigspesLGyvJhjt9XW0cwIGa1I5vQhOIC8hMa/JtE4U9gOkzMF+NivJgSco/ENFxHBWVn82eC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jVh+rI3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lx3Svojg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jVh+rI3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lx3Svojg"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8997D13804F7;
	Thu, 22 May 2025 11:55:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 22 May 2025 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747929358; x=1748015758; bh=hwKv+IVIjS
	pff4hDvgXH+me9As/BKjVK/TimirkzIV8=; b=jVh+rI3Ynw9uAPYjvVTXR4NXGn
	aL0a2prPf07ijrRyu7yAkjzLSnbWsviZ+X3zNVmqtCh3Ptc8tjLV5DVGlKmbwFpR
	cRJsmFoIv0C96tTPX3wBgCAHaOFcxrNo/MwUxDS1aloTTCWF9+cQq+dds/O/7pE9
	OfMgKqYGipYQgFXvLFm8v4dRfudLDCoxUdQDS+4CVlxQqi6e1EFIHC6I9hMWdj1Y
	SrvgbERHqJt509pr3VfvBbTXRY6xYl/Uf4JBQxJlWLfTjkk3Bv//TNipKU/X9DeL
	4/Q/505YDWrtXrDZkWYPNI1+gtrcMqE1ely65kMOqGoJj/JOuD3jqwpTpElg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747929358; x=1748015758; bh=hwKv+IVIjSpff4hDvgXH+me9As/BKjVK/Ti
	mirkzIV8=; b=lx3Svojgstkq6TV2hbp1mm5qEs4+DsC35eiyvCvjMY/fJyGeKiN
	WGtoCNqYdu2gcuhoJ+xu4t3Mw/RU00bEQQ2XfE6z73g+vQ1UB55bRDMBuCJry+w3
	L5ATVcFSuBkItVtScqcaR3zkRiYRhlEh9/67BuZFWG87ajSoScxLW2+0ufLCfVQq
	NMLej4xFFM/9klAv6fHypGtS6Yv01/UC9ZJ9uKcPEoJkKjRiouA1iOTfAZzY0JwE
	+xJonEdEosfBS7egf9Wjq6y++x0HnoehuLxDHGbKZs8xunjW8//avX2uAsSXgeBW
	YdtY/r1fAX6JHB+mgDzUzCkrJZo/fe9vGyg==
X-ME-Sender: <xms:DkkvaAxL26khMR0mwRtJLg89Qvbg9TtxNa5Gs4zUObaATipKWDjC4g>
    <xme:DkkvaETY0TYpV0TFrTVmoCVWPKA4gLKUKV7WCfDdl1Hbpy_uRiQUcz4d7WLS3IK_Z
    Ty-s9JfCLgCBsIGnA>
X-ME-Received: <xmr:DkkvaCWFti1C3OXRtiIpfo24fI5-B_b9KOyIlbQK7Jp76t-NGVnerL7lXd5rBzSOc-GfuLbBZ_Ms4YJF5_rroU_1xsIaibTDL_2yQS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeifeejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepohhpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DkkvaOhaVYuq_F9r82PExax5dmsoDQPM93ez1bmV5AZYbFu7Sm2XpA>
    <xmx:DkkvaCDpJz18TyRbbGRKcxAwK7pqFQyN6TTbwlll3btXb5T0jJCrig>
    <xmx:DkkvaPKe1w8e2i8pyPTiYLt0NBZpSEsTjTkupeUgaBcbZpjnF4PIqg>
    <xmx:DkkvaJCqUU1gbRpRRlgEL-luTGe0tLoaayFxhGT9c5-1SWVo3BxetA>
    <xmx:DkkvaCGZ7wTq7s_ukdn2BVAcEgBQVv6mXp7AJgFssX4EC2uea08ExmOJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 11:55:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ondrej Pohorelsky <opohorel@redhat.com>
Cc: =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
	(Ondrej Pohorelsky's message of "Thu, 22 May 2025 09:19:18 +0200")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
	<pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
	<xmqqh61ear4s.fsf@gitster.g> <xmqq1pshc2vs.fsf@gitster.g>
	<CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
Date: Thu, 22 May 2025 08:55:56 -0700
Message-ID: <xmqq7c287i7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ondrej Pohorelsky <opohorel@redhat.com> writes:

>> What made you send a patch for this program?  Do you or anybody you
>> know use git-cvsserver?  Unless I am reading the program
>> incorrectly, despite the claim in front of that escapeRefName sub
>> that we avoid sending a tag whose name is not something CVS would be
>> happy with, we did not sanitize the refs and relied solely on the
>> users' repository to use only safe characters in the refs to keep
>> CVS clients happy, and the fact that this expression used as if()
>> condition is totally broken does not really make any difference,
>> since it is in an unused sub.  I have to wonder if (1) it is a
>> better fix to just remove the unused sub, and/or (2) perhaps nobody
>> uses cvsserver to allow cvs clients to talk to a Git repository?

Below you mention you found it from test failures.  Nice to know
that you weren't actually using it ;-)

Still, I would welcome second and third set of eyeballs to see if
this is a dead code that the "compiler" is complaining about.  If
so, we can remove that unused code instead of fixing it.

> What I meant by 'does not build' is that the warnings that were added
> in the newest Perl release populate the cvs.log when running the test
> suite.
> This causes some tests from t9402-git-cvsserver-refs.sh to fail, which
> then fails the whole build in Fedora.
> Tests that are affected are t9402.30, t9402.31, t9402.32, t9402.34.
>
>
>> >> Added parentheses avoid this issue.
>> >
>> > We phrase such "this is how the patch addresses the issue" statement
>> > in imperative, as if we are telling the codebase to become-like-so,
>> > e.g., "Enclose the pattern matching =~ in parentheses to force the
>> > right order of binding", or something like that.
>
> I'll rephrase the commit message to meet this requirement.

Also please update the earlier part of the log message to clarify
what the end-user observable symptoms are (e.g. "gives warnings
before doing its thing? or errors out and does not run? or something
else?").

Thanks.
