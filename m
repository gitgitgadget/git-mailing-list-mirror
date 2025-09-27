Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA01F12F8
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758991981; cv=none; b=oqz7Cw694S/aT09GnL9dsRP7zWztky91dt99fZOhRGK2VFTxmdnn5lc7zKK52MZXky5/XuYz/UXiYguQwo6se44UzHaLDdl9aA7/QDHwSViZKAVa9ydbiNrqJ+bNVBXj5wJ8hf9aC+POA2o8XqJokH6mxcRkL5nTNoumaAUjeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758991981; c=relaxed/simple;
	bh=JBzSgq82b2UjrXZSxM2E7YeGIlMc0zZsHq/LagLll1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=leiP28gtwrdmDRZ4Fghu60qkSSMNpQzna+GqKW7I2wGD7Zef+47P7o+mKJzludps/0nzJRXtUIumjWOC+hvCRerwRbb4vsl1hSU3L9XQm/jeSjAwFnUH02uKimPThbugEnONg6irt8g6Aa892nHmp+jbXnfjtR5uyn3sAeVy2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EC4qceCk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTkzJ841; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EC4qceCk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTkzJ841"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0225F7A006D;
	Sat, 27 Sep 2025 12:52:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 27 Sep 2025 12:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758991977; x=1759078377; bh=0JhNGlwsh0
	8CYRQw4wGxNegNSUsEoZnARn8+oP3OAfA=; b=EC4qceCkt8eEEydwAkVF0KpcsP
	jccvk+bpHvc+kN694Gz6rD0PP5Vd170yVpB4Y781yhVtWRH6r/hAY82CfTmvIb0G
	YJReSaWUaSlASuii4RidQgSGRzrhdSJJCnJ6sT+GQv9tHJ+TVGgclm4AweAN8FYQ
	vkuC8GNXCF1DW+oQCex1VQcS+iYEidqZVzT8L+wTCa34XQUGb/kb9XfyelB5K5tR
	RImMsRv5v21r3ic/IU5jAIykLjVxoJy+1wCfHRi8FKFkvg5JXmvs43usezkoi4ie
	VcU3fCWUbvmJoFZvr7FfdlgyPW3q/UVU2Kd9G9BqO/qnhE2+y5pE9PzWO9pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758991977; x=1759078377; bh=0JhNGlwsh08CYRQw4wGxNegNSUsEoZnARn8
	+oP3OAfA=; b=vTkzJ841E9lQAfA3UzeDLW3G0Eo91H3hVpjndgkx1SCfbTPehBk
	rXwk4SGYXc3g2urGb2Uw3r71fvY+wt9TCrOlN/4fnAUWRnsXlFBjVhWcf/eyRT9o
	1yLDAMFIMKJ4r1MRsMrwu1qNQCU7OOPWFqKW9FQLy49XPRP1N5mVp0n1lpfE9Naf
	UCUuSEpGzcfNjSSrd1Z6oVh5f0HSQFAuTBwKn3dH9FpfQ3uErgLdcbCM6xTlrjVS
	5c4ONnCkSRcWr0aVZENV4Fzz9df77cak1C1VZjIKrETi2++5ffGO7Z1gEuUSQvdM
	qSjaJKD1kPhCnlzwtVg6z3+kglSVw4yVuFg==
X-ME-Sender: <xms:aRbYaFgxIptZU6P8Wf9CHMddd88fX7aqHX_f6lBnPwQkA9lTZvBoFA>
    <xme:aRbYaBcK1kTj6SRtsCA_zxJYU8ifGKelwaw-qjNX22MVSCdVngJVkOjbM3gaR--s4
    vZ1vY1Xr40Iir69UbTA_wIX5t1GdqQvOpPBYGCwNEJtIVOaeUKO>
X-ME-Received: <xmr:aRbYaCf-5A8H_CMwQvGOE9-jNzr2nESf9WmZNtVsdVQaA8XajvVvblpyk2otuxCRYZsRSIXD4nNGaowVFB57Nhurt1xuMV_B7IV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgtuhgsihgt
    sehjtghusghitgdrphhlpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aRbYaD_ElYf1m84vdaHCgoVZhrAbSfRPV7r7wCVP464Sto7C3nE0eA>
    <xmx:aRbYaGmkij8W7VUbqfgzxGqGgFYOFRBvVcVlb7V4n8pfA82kYJR_-Q>
    <xmx:aRbYaN_XG0c0ws1duxiKWo2OOosF-WD44iC-1hbOmkVNWvYZX5G60Q>
    <xmx:aRbYaMlNNBywdA_PjYUwbCK_UiPV0gYIQFZXHvIEcoHezOsIj1_0lg>
    <xmx:aRbYaJo8P2ep-mNd8Xr7is7U9fyy3Dn383anKROqGpsdzd4qkgMT0FiA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 12:52:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Cc: git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <20250927152824.3132af88@jcubic> (Jakub T. Jankiewicz's message
	of "Sat, 27 Sep 2025 15:28:24 +0200")
References: <20250927152824.3132af88@jcubic>
Date: Sat, 27 Sep 2025 09:52:56 -0700
Message-ID: <xmqq4isn96s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jakub T. Jankiewicz" <jcubic@jcubic.pl> writes:

> Why git work trees are are not automatically ignored by git?

Because there is no reason to ignore them, and ignoring them would
be annoyingly inconvenient.  Worktrees are not special and treated
the same way as an ordinary Git working tree with embedded .git
directory.

That is, if you "git clone" somebody else's project into your
current directory, when you are in the working tree of you git
repository, that working tree of the cloned repository would appear
as an untracked content from the point of view of the containing
repository of yours.  It is up to you to add it as a subproject, or
leave it as an untracked directory.

If you do not want to see a new worktree as an untracked directory
in another repository, do not do

    $ git worktree add base

in the first place.  You are creating the new worktree _inside_ an
existing repository's working tree, and it is no surprise that the
new directory appears as an untracked directory.

In other words, if it hurts, don't do it.

Instead, you can create your additional worktree outside the working
tree you are using.  For example, I keep a handful of worktrees just
next to my primary working tree, by doing something like

    $ git worktree add --detach ../git.maint maint
    $ git worktree add --detach ../git.next next
    $ git worktree add --detach ../git.seen seen

when I am in my primary working tree.  Then I can leave some work in
progress in my primary working tree and then context switch out to

    $ cd ../git.next && git reset --hard next
    $ do stuff on next

any one of these additional worktrees.

Hope this helps.



