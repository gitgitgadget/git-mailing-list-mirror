Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF9190052
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275378; cv=none; b=rps3rbg4b2LNL7mHio7h5azPsY+IMgb7yLHVvgDV9B+kjHm4ev17ALaAz6WfNsY0YG+iTUMM9vbCij49MF7KcRrqapG81KYbFdYGxppX4C6R5A2xabmDt+LDqvnf21+6Be2YkptybnG6P/kR5rQ8sN9aEhzV/zz/gfIqmTHrHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275378; c=relaxed/simple;
	bh=LwRBB4VyAx+Ck3qsdJ9LlHG/DH7y5eB4YKz/hP/4oT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSGjB0x7498zdH0vlIJ5K4LxrqCSYrzMlhWh33Zk8rR8beIfrfjVqR+QtakpZ6WUxDJuk49zGypmKfnVWjiW8KCeMNhWj3WysfH8vjcZ0PyOE5Hga0m7lPUBVnJizgu+46CIwg45zfXGxTkSowMEMQlAtkbhG27H/YLP2eO+5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SR/wkBI0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E394ZYXP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SR/wkBI0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E394ZYXP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A683114018C;
	Tue,  7 Jan 2025 13:42:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jan 2025 13:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736275374;
	 x=1736361774; bh=wUmloLMN93ZteXP9nFfopEThQY8dhB5IiqpRUYEf4IU=; b=
	SR/wkBI0vu2u7/mmMBzNjhDt1eSj3+4Ao2PlM0pq7PgKrfjw6UWPAtcbqN4tty+C
	17C5KtbKSwrGt58+/nvT4pXwstT4ZM7H2Mj+U+2oj7pskB8R1cmv0IhDvRR/EjaG
	vAqjXmakjctwxvlefLr/tEoTVVQ3sEsOPqsgzFAUscXPetUWiPNl9Y6OWGjQLV9R
	uf4CTUQMUIbURfjhc6OxvrnkVohAl/HOAq91hZUv5WNFoToNo91sLtYlJLSYUF3y
	PEf+cJoYPfjKM7RJ4efSecHgjypgsdS6YZpBR9qPGoezs30/u2t7RP/OwqYAU0Vd
	+ZkI0hSonlgUfwG62y4tsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736275374; x=
	1736361774; bh=wUmloLMN93ZteXP9nFfopEThQY8dhB5IiqpRUYEf4IU=; b=E
	394ZYXPPENmjIPqPgA450+4Hukf4jw/pu/4yf5U7+R9Y5jrlhQc9ySD4oi9ArQF8
	PTJal0eE4GN8RCmwkayWg4TJjObq6g+vdfrfcAs8tFRlJ/Qdxqj801vRT562xSMZ
	Ez66s35Ju8vZb+PH1V+ax8FxnhI/wpdvQZXOuv8L8ZR49dnppR8XrwzfsieEhpL1
	ZZYP9JWj+aRjXZqi/3S1fTGTyAjipAbTGqLGp0l/+E2Fm/1LPTIJBPpJJ9mKUuad
	Xee9WJvVTiPR42lDj5fBuPa1dlCXvmuud9w/TqrivURpT2LuDti/Q8ZgvM7TC0bM
	nQzusldDBozGJrunTgNPQ==
X-ME-Sender: <xms:rnV9ZwVsonY9DmLly1lmXu8nqvJCG9ohpkBBRkBzeIGvUs3HDcMz6w>
    <xme:rnV9Z0mYxqKjwCR0MoQ4DiR-phLzcJfFJu45ioFvTkMkNT6Cy_MAbGniqZeO4EHxS
    UeGaUgWBjzzcnWyDw>
X-ME-Received: <xmr:rnV9Z0bFDGT92AfUGvdZnTnEVFO4DmGuS4e_6kdpl0m0Hjytk6qmHbHwfRRTWIrFKuqTeNrJk0365FpNWWVLvKnf3oju0LTI4doy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rnV9Z_VOGOi1a2w3JX1r88rjgNgekz8aFs5ITF56KyKsKNZkxc7NKg>
    <xmx:rnV9Z6mAaSXsDtziCUjNYFa6GwVDJxrkIK5OhiveHxO7aw7UicVQXA>
    <xmx:rnV9Z0c6NmL248JivKUXp6BTmOOhPVU7qG81tVhfiGQa3MRAmcNorQ>
    <xmx:rnV9Z8ErhEfqzLLoLm8uasi0O8TgP5DlaXJ1W0fA6LTlK26Tiqu0og>
    <xmx:rnV9Z7ARDdZ-lHFI-8IQyiSvLKEqnKOkAfw1yILO6kTZdR4n_yzcYFKM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:42:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] RelNotes/2.48.0: fix typos etc.
In-Reply-To: <04fee3b38052ffb731e2935cd5e8ee06f3d1c69a.1736271065.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 7 Jan 2025
	18:37:06 +0100")
References: <04fee3b38052ffb731e2935cd5e8ee06f3d1c69a.1736271065.git.code@khaugsbakk.name>
Date: Tue, 07 Jan 2025 10:42:52 -0800
Message-ID: <xmqqr05esbwz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Correct verb tense, add missing words, avoid double blank lines,
> and rephrase things that don’t read well to me like “Turn this linkage
> to relative paths”.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/RelNotes/2.48.0.txt | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Thanks.  Will apply.

>
> diff --git a/Documentation/RelNotes/2.48.0.txt b/Documentation/RelNotes/2.48.0.txt
> index d62c62dc17a..eff93be37a2 100644
> --- a/Documentation/RelNotes/2.48.0.txt
> +++ b/Documentation/RelNotes/2.48.0.txt
> @@ -47,15 +47,15 @@ Performance, Internal Implementation, Development Support etc.
>  
>   * The way AsciiDoc is used for SYNOPSIS part of the manual pages has
>     been revamped.  The sources, at least for the simple cases, got
> -   vastly pleasant to work with.
> +   vastly more pleasant to work with.
>  
>   * The reftable library is now prepared to expect that the memory
>     allocation function given to it may fail to allocate and to deal
>     with such an error.
>  
>   * An extra worktree attached to a repository points at each other to
> -   allow finding the repository from the worktree and vice versa
> -   possible.  Turn this linkage to relative paths.
> +   allow finding the repository from the worktree (and vice versa)
> +   possible.  Use relative paths for this linkage.
>  
>   * Enable Windows-based CI in GitLab.
>  
> @@ -94,7 +94,7 @@ Performance, Internal Implementation, Development Support etc.
>   * Update the project's CodingGuidelines to discourage naming functions
>     with a "_1()" suffix.
>  
> - * Updates the '.clang-format' to match project conventions.
> + * Update '.clang-format' to match project conventions.
>  
>   * Centralize documentation for repository extensions into a single place.
>  
> @@ -116,7 +116,7 @@ Performance, Internal Implementation, Development Support etc.
>   * The migration procedure between two ref backends has been optimized.
>  
>   * "git fsck" learned to issue warnings on "curiously formatted" ref
> -   contents that have always been taken valid but something Git
> +   contents that have always been treated as valid but that Git
>     wouldn't have written itself (e.g., missing terminating end-of-line
>     after the full object name).
>  
> @@ -127,13 +127,13 @@ Performance, Internal Implementation, Development Support etc.
>  
>   * Drop support for ancient environments in various CI jobs.
>  
> - * Isolates the reftable subsystem from the rest of Git's codebase by
> + * Isolate the reftable subsystem from the rest of Git's codebase by
>     using fewer pieces of Git's infrastructure.
>  
>   * Optimize reading random references out of the reftable backend by
>     allowing reuse of iterator objects.
>  
> - * Backport oss-fuzz tests for us to our codebase.
> + * Backport oss-fuzz tests to our codebase.
>  
>   * Introduce a new repository extension to prevent older Git versions
>     from mis-interpreting worktrees created with relative paths.
> @@ -173,13 +173,13 @@ Fixes since v2.47
>  -----------------
>  
>   * Doc update to clarify how periodical maintenance are scheduled,
> -   spread across time to avoid thundering hurds.
> +   spread across time to avoid thundering herds.
>  
>   * Use after free and double freeing at the end in "git log -L... -p"
>     had been identified and fixed.
>  
>   * On macOS, fsmonitor can fall into a race condition that results in
> -   a client waiting forever to be notified for an event that have
> +   a client waiting forever to be notified about an event that has
>     already happened.  This problem has been corrected.
>  
>   * "git maintenance start" crashed due to an uninitialized variable
> @@ -203,7 +203,7 @@ Fixes since v2.47
>   * The dumb-http code regressed when the result of re-indexing a pack
>     yielded an *.idx file that differs in content from the *.idx file
>     it downloaded from the remote. This has been corrected by no longer
> -   relying on: the *.idx file we got from the remote.
> +   relying on the *.idx file we got from the remote.
>  
>   * When called with '--left-right' and '--use-bitmap-index', 'rev-list'
>     will produce output without any left/right markers, which has been
> @@ -227,7 +227,7 @@ Fixes since v2.47
>   * "git gc" discards any objects that are outside promisor packs that
>     are referred to by an object in a promisor pack, and we do not
>     refetch them from the promisor at runtime, resulting an unusable
> -   repository.  Work it around by including these objects in the
> +   repository.  Work around it by including these objects in the
>     referring promisor pack at the receiving end of the fetch.
>  
>   * Avoid build/test breakage on a system without working malloc debug
> @@ -282,9 +282,8 @@ Fixes since v2.47
>     on the path, which was not documented, which has been corrected.
>     (merge bc1a980759 kk/doc-ancestry-path later to maint).
>  
> -
>   * "git tag" has been taught to refuse to create refs/tags/HEAD
> -   as such a tag will be confusing in the context of UI provided by
> +   since such a tag will be confusing in the context of the UI provided by
>     the Git Porcelain commands.
>     (merge bbd445d5ef jc/forbid-head-as-tagname later to maint).
>  
>
> base-commit: b74ff38af58464688b211140b90ec90598d340c6
