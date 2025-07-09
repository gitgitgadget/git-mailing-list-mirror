Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD931C861E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076402; cv=none; b=UCNaIasA0Rv58ZxiL8S2+IOgm0EqHQmvJPORDU+nG21YIBXZFRHJMslJMTVLS9FulW8k+pLc6h8Kz9KcFTOxTNrEQGlEOD5w4wFtG/RvBrmqTdrxKbcCU8pjb13I1r9zfHoTFjf9GfAIUIYPRQosUtAEkFKu+a4qp8sng/wTAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076402; c=relaxed/simple;
	bh=d5gAmO5vJk6oJjNrgF+bxtxbJqN2UrQj64sSFoHT1uY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bb6sFhJRC+VqmEpwhgaQ3iKp0/mkO7YP0Afpc/9XOaqAZrwm/3TYvrG0n1hBRNj4uIXpk5ahg4NL/6RbrWjnFxx8j61lOQ4ENYIYnihQcex+p2m9Dbb6Itkx7rn4Ge7q0JPieeMjcJDGXCmnGZmNvzCI0xcFadgP82/AoUOooZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=L0myiOvk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="L0myiOvk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752076398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rF2hxSNHsy2bBgd3FQnSXqQs5DC7bIVQrUd+Y0bFtuo=;
	b=L0myiOvk8/DWaXXpddq2JfGUidQIJQZ/LXfFkuCRFqLI0LAkuh4F4kC/ABzuRliKUDo7Kg
	fD9k7GEK8jGxRqD088CeWvCu2CpMFgbVEO4v6eEENiMBrFbO3qTH3MJjEsNKOhOvRO3nF5
	NldJqquUj1CIHrUSqq12TYNDyQiGKWA=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 0/5] Introduce git-last-modified(1) command
In-Reply-To: <8734berbmj.fsf@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
 <xmqq5xgbk4d2.fsf@gitster.g>
 <d93c9199-80b1-4834-bfbb-8263a80d90d5@app.fastmail.com>
 <8734berbmj.fsf@iotcl.com>
Date: Wed, 09 Jul 2025 17:53:07 +0200
Message-ID: <87y0sxpdi4.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

> You raise a good point here. Let's compare:
>
> $ git ls-tree HEAD -- refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
> 100644 blob 936e0c5130fe7d67f645501fbb9e70b94b437f54	Documentation/git-config.adoc
> 100644 blob 1af38f402ed6437353fb5765f62251966d828df9	Documentation/git-last-modified.adoc
> 100644 blob dce5c49ca2ba65fd6a2974e38f67134215bee369	refs.c
> 100644 blob 46a6008e07f2624239139cd8b2ff712545f07d3f	refs.h
>
> $ git last-modified HEAD -- refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
> 56073a0af90be947cfefbfc3cf762b268e5e20a9	Documentation
> 062b914c841329a003f74e1340ea5178391274a6	refs.c
> 47478802daddf3f9916111307f153c6298ffc0bc	refs.h
>
> I have to agree with Kristoffer here, and the latter is not what I
> would expect. Thanks for the testing! I will try to address in next
> version.

After some more testing and tinkering with the code, I've decided to
keep the behavior for several reasons:

1. While behavior differs from git-ls-tree(1) (see above), current
   behavior is identical to git-diff-tree(1):

   $ git diff-tree HEAD~1000 HEAD -- refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
   :040000 040000 810861a07e1360d3e3fa00db3c0d01e0604ff27a 1b01b770c15e7ae586452bb3587c3ce7c01abd91 M	Documentation
   :100644 100644 55d2e0b2cb9e959443e98eb329fdf97eff9073a9 dce5c49ca2ba65fd6a2974e38f67134215bee369 M	refs.c
   :100644 100644 d278775e086bfa7990999c226ad1db2f488e890d 46a6008e07f2624239139cd8b2ff712545f07d3f M	refs.h

   Both git-diff-tree(1) and git-last-modified(1) are marked as plumbing
   commands, git-ls-tree(1) isn't. So I think that okay.

2. This command uses the diff machinery to walk the trees, so it's not
   straightforward to change behavior.

3. We can later introduce `--max-depth` as Peff has been trying to do in
   the past, but that can happen outside this patch series. These has
   been taken out in an previous attempt[1] to upsteam the
   git-blame-tree(1) subcommand.
   Having option `--max-depth` would allow users to get all tree entries
   in for example the documentation directory, while not getting any
   from it's subtrees.

With these considerations I've submitted[2] a new version of my patches.

[1]: https://lore.kernel.org/git/patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com/
[2]: https://lore.kernel.org/git/20250709152628.1644521-1-toon@iotcl.com/

-- 
Cheers,
Toon
