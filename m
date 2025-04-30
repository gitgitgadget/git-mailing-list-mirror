Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38ED224FA
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049150; cv=none; b=bmG2NcSBMmK+n4yOjsjt4T04kVR0xrfacK54Flt/PiXj0CiLNVzC+pLJt5XcEPDqhLNWx5lLUtEvzGzx6AuNQI8SilrHBC3GBgFPvoLwwtnL8eXVaBwnWxFqwx3tRROVVCtjoiRCtCNCpmepyx225yLBGeEBVHYdsAzeAJW6Cyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049150; c=relaxed/simple;
	bh=qE976FPFbtmszoN5s8fzVWpJp4yW//4q1LJhePnbzL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GxtwPh+AOdPQKHW0ANzwg6j4ItpYps2zgqHFMG//qnp3KDWNpBOKyThmbMdrDWE5YPZ2KHauBgb+lTOvwubVNJMgTNSfHpFF+ZPVfTj7bb0MEXPy9z4nI8067mwFFSxCxU2PNQSAx6z6C0zSLc848WimDlzf06mUm8zWuRsJBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DeHDDbQ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mnGhCECl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DeHDDbQ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mnGhCECl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9902325401D5;
	Wed, 30 Apr 2025 17:39:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 30 Apr 2025 17:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746049146; x=1746135546; bh=KzBEy7rt4p
	8MgHfCH4/rx47Z11DA9qx4f/Z6KCY9IO0=; b=DeHDDbQ6kriQi7YU5B2NMMEr+Q
	b/feK6yrlFwP1S1F1TQ0i5/rYdiqiHvHb3c/yVwRVrUUtBAwRK5Bf72XaB6WOaVr
	/w4lDcLTrHnu0Ri7Sb03ewZrA/wLgWPGVvHupv9xnPGNwPcJZROJy4g4yik8YAPe
	ZSnbx7gpnHcwHqJO4GCjMOjmQePZQOruK3TluSvX2Ew0CVm8efXvQxQFcyPq6SYq
	S4xQofgEmofUsUoVEnxdy4Yeq4lA5TczEE5HEE3lAmVw/Unp8fIAcF2cSYrSxmfW
	UofsYIH1+tNfMfFztPT5GKE0ZrjTZ6d9Bcg9di1tB/fQ2iXI4OR9q07E3ZGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746049146; x=1746135546; bh=KzBEy7rt4p8MgHfCH4/rx47Z11DA9qx4f/Z
	6KCY9IO0=; b=mnGhCECll3k5f/YoxVznrVg3ElGpI/8FjtFqDXgcYBY8He5bSJS
	EtoeWA0bLg/KuQJJJWXU+PO4qDnONMk9o0539HpmglEZYC0OWVJB6DW7l94dZYon
	VZ7KhhPXSKFit5snZVb4VXf8fyOtcjxwXLPJx8mJxVjIjUFSeR8MK/62v5gCsGT7
	tFRRIHXb+X2LdwUltEN7oY/ROTrLpmLgBXMKx6SrfntI4Kn+xUruxBQ7I1CGifbM
	YqaDxIGUsdqRUEuiTeeXpOxiXWdvk+ZFWIUPmMo4YNlDpOl8opH63bLvKg8jQLn/
	IZMHoRKilHe99ITqHDtyLFkojdF1xom+Hgg==
X-ME-Sender: <xms:epgSaKPdvjQIUu5WKGcs4Ou-Mw0gbyxvc-BfjaruUH71AW45v2bUvg>
    <xme:epgSaI_snuSD5jcSkcIPlWrqZKnvj0dVTUcG7TgUQNF_GqYXzjxo0RMBrDT0CcmM4
    EbKporwl9VlW1-mrA>
X-ME-Received: <xmr:epgSaBSLZy1EZJ2fs9BdDuqOyQaiz_6DRIxrRKi2xFoWkjFYh-M1QIz7Iygb29H6Zr9ly7uhLiWSGAVo8kWAzBvkpAiX9Zpf0UFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgvrhhrhihthh
    gvsggvrghrjeegieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:epgSaKubXS8I-wlYKq4mE4QpyBruuA5isxWeUHid_Xy-ujaZUWC4-w>
    <xmx:epgSaCeunkxUwR4gOG9zkwDc8MGbPthEN7eJNfn1_o_nJwvwnteKSA>
    <xmx:epgSaO3M4Q4VIzmygScqJJsHFDoPvZ5c9nzMXaBzFbTw95Ew2qACTA>
    <xmx:epgSaG_AWhc3ZJfKlRVKUwq-2EfyTpO7yh0Gsg1pLscIuh4Iy3H7Og>
    <xmx:epgSaAoBq0GR5xjlsnDnuTWwLNlASTtuWjAGw70mniQH7ZK42sE-k6oV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 17:39:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Terry Bear <terrythebear746@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug Report or Unexpected Feature when "git restore -m ."
 restores merge conflicted state of a file after a commit
In-Reply-To: <CAJt5hUyLoNfEbQe4wpES8AZP5yimos+xjqU9B4PszGxMrg50jg@mail.gmail.com>
	(Terry Bear's message of "Thu, 1 May 2025 01:03:12 +0400")
References: <CAJt5hUyLoNfEbQe4wpES8AZP5yimos+xjqU9B4PszGxMrg50jg@mail.gmail.com>
Date: Wed, 30 Apr 2025 14:39:04 -0700
Message-ID: <xmqqzffxz5vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Terry Bear <terrythebear746@gmail.com> writes:

> 9. Make a merge switch
>     git switch --merge main-copy
>    The file on the "main-copy" branch should look like:
>      "update 1"
>      "<<<<<<< main-copy"
>      "======="
>      "update 2"
>      "update 3"
>      ">>>>>>> local"
> 10. Stage and commit file
>     git commit -a -m "merge conflict on main-copy"
> 11. Restore merge-conflicted state
>     git restore -m .
>
> What did you expect to happen? (Expected behavior)
> The "git restore -m ." is not supposed to restore the merge-conflicted
> state of the file after it was staged and committed

Just a quick question.  If you did "git reset --hard" between steps
10 and 11, does the outcome change?

I think the behaviour you observed dates back to the very original
implementation of the feature, made in cfc5789a (resolve-undo:
record resolved conflicts in a new index extension section,
2009-12-25).

    resolve-undo: record resolved conflicts in a new index extension section
    
    When resolving a conflict using "git add" to create a stage #0 entry, or
    "git rm" to remove entries at higher stages, remove_index_entry_at()
    function is eventually called to remove unmerged (i.e. higher stage)
    entries from the index.  Introduce a "resolve_undo_info" structure and
    keep track of the removed cache entries, and save it in a new index
    extension section in the index_state.
    
    Operations like "read-tree -m", "merge", "checkout [-m] <branch>" and
    "reset" are signs that recorded information in the index is no longer
    necessary.  The data is removed from the index extension when operations
    start; they may leave conflicted entries in the index, and later user
    actions like "git add" will record their conflicted states afresh.

Notice that "git add" or "git commit -a" are not included in the
operations that are signs that the previous conflicted state no
longer needs to be recreatable?  In other words, it is part of the
design that you can take back the conflicted state across "git add"
or "git commit", because you will thank Git later when you realize
that your resolution was broken and you want to redo it after you
finished your step #10.

If you do not want to restore the conflicted state, don't do "git
restore -m ." at that point ;-).


