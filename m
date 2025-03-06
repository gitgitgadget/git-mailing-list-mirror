Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04B1C8602
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293997; cv=none; b=c8Ucrr1456bo8QlrHwprZFz6gFVBRHEI8ez6b7z/FhKT2XsOdhomRxmEhO7PJFhxMe8zv6gVyR3GFYfvzQa3ymVXzJxkW3iBv47UvoScHxz4oXCnE4R6NEJxcRJ5bVGn5kchnq3lNM0XBqtpkoadAt7f6O1ejBd0jthkph6hoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293997; c=relaxed/simple;
	bh=uJAwM84T9zGYm7kjajrFu9gKgxQQu1Xu4NBqWAzkidU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eU+zkQHW7SAjx42ZRO3DHQghZjGNws4fu9MlrSlXrEjFiMOhnIYwT87TNoyUehjoy2H3qgSxnbF0cDeKi6fOIQ632yY+khaUjmIsMCiCFOp29b76k6JyJQgNQqyRQNxd/Z/ucyoFAf4H8KJEy+IvJ7+KWaf6iotN4vPy7aImU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nzEQD4iE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0VnBZfwk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nzEQD4iE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0VnBZfwk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C0E9138273B;
	Thu,  6 Mar 2025 15:46:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 06 Mar 2025 15:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741293994; x=1741380394; bh=bhfcY0mHt5
	1YQReGyUxJZAdOnM/jpwK6q4F4GoGGjE8=; b=nzEQD4iEFrWObEZ5KtwITF8UEO
	Px32j/EF5ePZZTPVqGT06Q4zUbpZlus+6pvn+C6/Boc5A1ksdNabgq/rS2Jd4DjI
	NB+VcqtlzVgylpANFX/cCqnL3s6mSYecFbd2hhnWPCWWL0MNiBAb2JRz/IUWUvOm
	vHm9ahgrdwnKbqcjT1YbZP+FU/TuRPzbHMykAbOXytvNoFiNaaXPyMvhHH0RVxgR
	t3kxQ+VabonEnui8+y5CYq/5BBCDKWD0Y6kVHz9Q1bQtnol2a/zk/YpBWqmaRJto
	UWKxvQq4WhD71bzW0H9vB45HrjfBV3FJWpy6gQCvaYngoz/0EPCjaQYgSMQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741293994; x=1741380394; bh=bhfcY0mHt51YQReGyUxJZAdOnM/jpwK6q4F
	4GoGGjE8=; b=0VnBZfwkRoCe+vrNZsYHxW52/8dSa7JhjQk3lTum5PaQQP/bqdt
	w/T5sxUPjmVfkH9zFAIOuM5s/6LJWYNpmmRvVAAO+ERcnVeDfeQsI52Afevs+n44
	4y5jW+4Iv5Ly6hJ+WowQXo/U7nTeMg8vLU04cdyYtL9S5iSBacFO3wiLKAGKI/w7
	YXzqwcPScj+6pXiL3FsVtJ0M4b9Wv7v95YSlyTxPdkTmUkteDyhEY/gl4XnreXpo
	7iw/fPRzUjiVUKxgItdWZgDx9kfgjOcIluiGA/rd2T8FitsuYVQwqsuCHQdv2mtV
	NSy01ZWArcY/9ZJzc5TCv1eiy6DL76rA2Rw==
X-ME-Sender: <xms:qgnKZwV5us2bajxDDhUBJ6AqpsrNwSm-mFXVMrQCJTpQxS6w_-E8UA>
    <xme:qgnKZ0khsk-fuuDVZD9Yon3Sj6euYCo_NzY7Um3X9YN0YJsD9S-GhS_3NUID4NZye
    wPa195vLlbULsorPg>
X-ME-Received: <xmr:qgnKZ0YabO3PldeuW77l5Z8rv-1KOlRDDo99JnhX7IsP65NKbxP96efPJNUomFGchH-dXGwHyB1MvISZHcrKqYeuYtZURAIosR9r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopegurghvihgusehmrghnuggvlhgsvghrghdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qgnKZ_V_DWiMhn0Jbw_G-TqufJr5CI66ya3tgQQkXjugK0zXo8zcmQ>
    <xmx:qgnKZ6ld1RY3Z1Z3poSK5g-KqbWb43zZtqW2TWW3MI0qPTJiIidgag>
    <xmx:qgnKZ0dTsdGpBehjt9fs2gY6OD1xRaoPIIxYWQ91GAsaFcitPuK7Jg>
    <xmx:qgnKZ8HQY2OmzfTylCuaWuP9wJ0BaeiFHGeS8N6q1Tlc7puMLjVB4Q>
    <xmx:qgnKZxv_u3EPgtOs2aLwIUVYAZiBeY3b6e4lFheZZzRvcv8TylXoXuJK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 15:46:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "David Mandelberg via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  David
 Mandelberg <david@mandelberg.org>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
In-Reply-To: <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
	(David Mandelberg via GitGitGadget's message of "Sun, 02 Mar 2025
	07:45:25 +0000")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 12:46:32 -0800
Message-ID: <xmqqh645hopj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"David Mandelberg via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This made completions like:
>
> git push github/dseomn :com<Tab>
>
> Result in:
>
> git push github/dseomn :dseomn/completion-remote-slash

Apparently I am late to the party, but I have to wonder how
prevalent it is to use such a name for remotes.

Back in 2005 when I designed the remote namespaces and
remote-tracking branches, the code may have been loose not to
complain, but it certainly was not an intended way the remote names
and remote-tracking hiearchies were to be used.  Being able to say
"refs/remote/*/master" and learn where everybody's 'master' branch
points at with a single globbing was a powerful thing, but with
refs/remotes/github/dseomn/master thrown into the mix, that would
break down miserably.  As a remote name, we still do use "is that a
file on the filesystem?" to see if it is a local file:// URL
(i.e. "git fetch github/dseomn" may be fetching from a subdirectory
two levels down); in retrospect, we might have been better off if we
said "well with a slash it must be a local directory and not remote
nickname" to prevent such usage pattern.

Anyway, this is not something we'd do lightly, but we may want to
see if we should tighten the naming rules for remote nicknames and
the mapping from nicknames to remote-tracking hiearchy, at Git 3.0
version boundary.

