Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A732ED141
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010022; cv=none; b=B+nCU6Y1eXabnnBmd/PpQ4PtsVh4TOj+NKUtWKqlUJpbSISQ8EZiz0pbUIzakIdNIQd1BWoqJtO5kN4MNe2EQKr13pQtpRcuFpfAR40WJI8cHEMg3yRF12UthCxN9g849uPdEmwBL7qHWPWWueCLn+yMTLM8AaYknz21NpxO3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010022; c=relaxed/simple;
	bh=ZBRf3NJcesrj0B+kpVheOH7WVGjcYAVsBQE5oWdnbJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjhRj7EodzZDfd4qPf5DygUmrN2m7MZAH7Px5q1qHz3I2vqkSA5OzhGlRE94lC8QSonw6rAeUE3JQbwXS+cfTn5fx+0bAp9JyAJzZcGcEJ2BzPVClfQXc/ojcblVSzWJ+1KKCJiZ3DCbfV46/8+gYvxNIUaOJwLVyCE11rmxYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A/i83No4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qpxxoeak; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A/i83No4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qpxxoeak"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 380FC14000A2;
	Tue, 12 Aug 2025 10:47:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 12 Aug 2025 10:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755010020; x=1755096420; bh=cTvzlyKf4/
	t5DOErNgJgY92Ch1PFpWUoUGgJfmewHAE=; b=A/i83No4LxsmAu5JWfl8daeQ5w
	e2cB9ibjxwrMwezityzFegMPOLhx4A5+2cYZc2FgQMRDsb9ORMng5flhY18Km+Ta
	E70jWlqAHsrq2v/nsrvIQPEi2nEJKDZgdNq50NbfuJoTQ0clTXAOzkpGqFd71Q7+
	N/3+jnG6ak+1rTgwnq+JjAiXvG83fhsKFqp1uVdnUBS9jLijndGKHRSVp2FH258J
	YKBJwAj6kpfG8TUF9gHwZi+yWr0U3aZPzoHkMH8CaLnI2dsJSOzvV1FXl196/O9T
	keHDj98zkBHoB5ahiINjFNSUZf0MZKnlaOIQNw8Dbkd9ks3VlCcUhZZiJdSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755010020; x=1755096420; bh=cTvzlyKf4/t5DOErNgJgY92Ch1PFpWUoUGg
	JfmewHAE=; b=QpxxoeakVx0KdsKQ5tyGRizhFyDnjjFGIAwzCUxZtB0y+rBUVkR
	K4FgH7jKEdQkBhy0P19d1fL2kNAwI7ynl9+r/FVxrLNwfWp81W1OUSL0dkZtYu6Q
	lvHPC9xHqjVIghw2TKa7D8EC/MS7750qNiXqH0y/bv/nnUF/PbpIxoLhp0pWaWlT
	CxkMDZcit543oQVUXuwHFhRepxnf5b3lDrYrn6L/VixiJJfEbr1Ix5IYMi30pXGC
	AiFp+Byu03DXPP6+dPKD/NF1d4tXg5iY+9iaY6leXw7wxKNGRy7TsJ6npKq1Ylsa
	wHaZudII+2SodCtxQJwsH0JNglqdToNMnOA==
X-ME-Sender: <xms:5FObaFf_LMSPl1hfu6vvzUW6Lhrjxmkwr3xr3OeBx-6tvMm3-xvznQ>
    <xme:5FObaGfqQv_d2FvPcqje6zKjo2BUQu_k-B_jqraA3efYLRx22FQvLFpdrb8jG8yp-
    qh2Oe6MY_qwqNeRsw>
X-ME-Received: <xmr:5FObaH_b1B_KtXgZoNikm1ijuVG-128k6nbMfpAGgOfI3RUN4k-1UuZMhCwnuge_bOsw98c1AOrao5ydUqmeVyBXTu0_6cNVDxveDbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieegvddvieehiedvkeeltdehkeegiedvfeeifeevfeduvdefheeiheeutdel
    ieefnecuffhomhgrihhnpehthhhouhhghhdrthgtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5FObaKkKS7CsVHse7qPo_omvhVN6JaXAlp3MO-NjZOzdJJAXG-FN6g>
    <xmx:5FObaB_h5Od_V5se3ioX5KqL0PgD0OlBoKtXNTTEy817XsXuPnGwEQ>
    <xmx:5FObaAm-HDc0k4eAd2A2sXTM1SMZQb2n_tWHU3BiJI-bTY7kIXzHKA>
    <xmx:5FObaG3Ac6uLWX4Cf1udJfUnNdm7P-gbE1uza9Q2AfxMT78zNDxfig>
    <xmx:5FObaOD0RyEGlj9KNQl_ML-WARhVddlgdASrMixyltTts2AOh0Sw8nbi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 10:46:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
In-Reply-To: <aJs5Gee3ZVCJX8dk@pks.im> (Patrick Steinhardt's message of "Tue,
	12 Aug 2025 14:52:41 +0200")
References: <xmqqwm79x7ra.fsf@gitster.g> <aJs5Gee3ZVCJX8dk@pks.im>
Date: Tue, 12 Aug 2025 07:46:58 -0700
Message-ID: <xmqqo6skwqal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 12, 2025 at 01:29:45AM -0700, Junio C Hamano wrote:
>> * ms/refs-list (2025-08-05) 6 commits
>>  - t: add test for git refs list subcommand
>>  - t6300: refactor tests to be shareable
>>  - builtin/refs: add list subcommand
>>  - builtin/for-each-ref: factor out core logic into a helper
>>  - builtin/for-each-ref: align usage string with the man page
>>  - doc: factor out common option
>> 
>>  The "list" subcommand of "git refs" acts as a front-end for
>>  "git for-each-ref".
>> 
>>  Comments?
>>  source: <20250805092758.5321-1-meetsoni3017@gmail.com>
>
> I've reviewed this version and am happy with the result. From my point
> of view it's ready to cook in 'next'.

I've looked at it, too.  Thanks for a review.

>> * ps/commit-graph-wo-globals (2025-08-07) 10 commits
>>  - commit-graph: stop passing in redundant repository
>>  - commit-graph: stop using `the_repository`
>>  - commit-graph: stop using `the_hash_algo`
>>  - commit-graph: refactor `parse_commit_graph()` to take a repository
>>  - commit-graph: store the hash algorithm instead of its length
>>  - commit-graph: stop using `the_hash_algo` via macros
>>  - commit-graph: fix sign comparison warnings
>>  - commit-graph: fix type for some write options
>>  - commit-graph: stop using signed integers to count Bloom filters
>>  - trace2: introduce function to trace unsigned integers
>> 
>>  Remove dependency on the_repository and other globals from the
>>  commit-graph code, and other changes unrelated to de-globaling.
>> 
>>  Will merge to 'next'?
>>  source: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
>
> I don't intend to reroll this series for now. As long as you are happy
> with the signedness-related patches I think this should be ready.

Heh, I am not obviously happy.  I don't have time to go in myself
and fix them, though.

>> * tc/t0450-harden (2025-08-08) 2 commits
>>  . t0450: add allowlist for builtins with missing .adoc
>>  . t0450: fix test for out-of-tree builds
>> 
>>  Test updates.
>> 
>>  Expecting a reroll?
>>  cf. <xmqq7bzdfoxe.fsf@gitster.g>
>>  source: <20250808095943.3312265-1-toon@iotcl.com>
>
> Toon is currently out of office, so this'll take a while to be rerolled.
> I'll have a look at whether I can reconstruct the seemingly-missing
> file.

I saw your patch.  I'll queue it separately on top.  As we won't be
moving new things beyond 'seen' for at least another week anyway, we
are not in a hurry ;-)

>> * en/ort-rename-fixes (2025-08-06) 7 commits
>>  - merge-ort: fix directory rename on top of source of other rename/delete
>>  - merge-ort: fix incorrect file handling
>>  - merge-ort: clarify the interning of strings in opt->priv->path
>>  - t6423: fix missed staging of file in testcases 12i,12j,12k
>>  - t6423: document two bugs with rename-to-self testcases
>>  - merge-ort: drop unnecessary temporary in check_for_directory_rename()
>>  - merge-ort: update comments to modern testfile location
>> 
>>  Various bugs about rename handling in "ort" merge strategy have
>>  been fixed.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
>
> The patch series looks reasonable to me, but that's basically just going
> by the commit messages. I wouldn't claim to really understand our merge
> machinery, so my opinion is only of limited use.

Thanks.  These looked OK to me, too.
