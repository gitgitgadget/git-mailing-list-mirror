Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487D2F0693
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031269; cv=none; b=TxpQdlFRIhqYYSKp16FavFMuFO8hYw1/K7nEPULLqMU9fekktpKeu1c1tRQD0L4NEYdX44skLm01/atNX3x6zYslm8h1i9tXGM49wXVXTFYeTIYb90/a26jFGZ/uewJly51jkLiOaDtVn0wxpfCI4P7O0bPkdx2kir45mRflZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031269; c=relaxed/simple;
	bh=TNfIv0cJRzdSi9T/hfeLUmEkosnuAuqqcdGcZKzJJ38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d7JYUaCuG2HVarNzo8Pszpp4ERYd6jZq3wanumm6fvyzpScMPb8GoHKB/a1I897y2l9ZEG59IML0+fccftOQF0rjlVLJD46yTpuwE5GRnUrJpoPrJq57xOpB5QeSYYElQ715Ss+e0gb5M+nVAXmN0AVNRbrwSKQ+J+Dl7mKx8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ToA3yf6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHbYHNQp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ToA3yf6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHbYHNQp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFBBE7A0112;
	Tue, 12 Aug 2025 16:41:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 16:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755031263; x=1755117663; bh=cKxwbaqDon
	llW3d8bquBC80tas3fUOHZYCPAWR73GM4=; b=ToA3yf6+OpZfIgjyirSGHoubgs
	y68foEF0K48kyD3kH0fkHubzf1wRnuCxvnH5qNnVGpYUH1ns6sWvv0JdNmSmwPgi
	vWiR9tfzdM7SPCbWUtIPlSKgof3DAxTpGhbs6WbzOb1/JdF5mrQ85KUGfVXMaDMq
	doVVTH8M+l/yRn8Ug4OhKTHxTplDcd4zwepKIKkhUff/8Rq7+89+1LFgNaPrEjDN
	i6qdWcT8lC+i2+tZEmfcl7BS1o1p/8q5N6RZ9Hx+i0UE8hKDUnryzd0mchcYGA4K
	s3TThsa0DCLHorAGp9+D7zLLRETP7O5xWMGRAZbv35yndPWYbbme7bwS0ztQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755031263; x=1755117663; bh=cKxwbaqDonllW3d8bquBC80tas3fUOHZYCP
	AWR73GM4=; b=lHbYHNQp4d19iYSwQZDx8FvPJdK3YZPbwHHHoOfxM7j46cp7oW6
	1eWPep/C2CtU8QE2ah9jrnDpDU61MrmA34f3UOyvKueMV3z5T96rsAMaxVuEI8X3
	ubqbsTZDWU/SEBD4c2trD/ToWm7fuKBcnqTMzImmdgblBpQAD6HU9v2TLovadMET
	ugp5Ea7RRz9opgF6klfYycf9ny1VpYrVaZkgd4nvScvG2+N8wdJcNK/s2dSXhNX1
	uV25dfmKuTC/gskEvI9UMrj+bHRF4ucfD1Xbv9Ba6HB9RkN/pLMBGtoQDIhpfmlX
	jDF7FL7j/eQqBY+ywztQceDH7/WxoiG0NcQ==
X-ME-Sender: <xms:36abaPvlhMqgYS7JqguXMvalg4XgxzUSppzeP9oZzVbH7mnEWEI2yQ>
    <xme:36abaLB7g7y-3MNouuJIHOLjECKU6TQ8TZOlOOpRual9RPFC8rcUc9yqt7uzFrZKR
    EAuK-Sr3WrDzPXM3Q>
X-ME-Received: <xmr:36abaPXXe-RQEQt8h9QXuWP7RKrriLt6Gek5-3Qieo83tTcV_74cFzyCgRahPP6UgCRRJ5a4H1xVHTKh3wcBdATy8DUMmzWt2W6lCCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeifedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:36abaBBH3sWsKSHrvNqyMFybeiq3vu02blVopWOR0oBGJAOXsDi4Jw>
    <xmx:36abaK_v0qSIKOHekynWmCwia3VzVaagqGFRHqMe_iMhsU9YSkt1OQ>
    <xmx:36abaAFbZvAnOXWMIXXA82gj6kci6LG1IGANnLBx6SJ9cBMToIy_Lg>
    <xmx:36abaAOMcC_KAyq8dLu8q871iTnpIxkf9hQ84X5UuAZSXx08BKd6fQ>
    <xmx:36abaP-p97vpgylhT9_3wTXXB2Rug7g2oaBCeu-7TGD-zV1UNJ3vss8S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 16:41:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: git-add: remove options from SYNOPSIS
In-Reply-To: <3a2cc38b72fb0f6ccc0ec9cbefadb7576cd8b934.1755029249.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 12 Aug 2025 20:07:25
	+0000")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<3a2cc38b72fb0f6ccc0ec9cbefadb7576cd8b934.1755029249.git.gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 13:41:01 -0700
Message-ID: <xmqqms84s276.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Motivations for this change:
>
> 1. Listing a huge number of options is visually overwhelming when
>    opening a man page for an unfamiliar command. It makes it harder
>    to understand the command's core syntax, like `git add <filename>`

For "git add", which has only one mode of operation, this may be
good.

Note that in general this is not necessarily a good idea, when a
command works in different modes (like "git branch" that can
list/enumerate or create/delete/manipulate), as not all the options
can be used in all the modes the command supports.  The "usage" part
of the output from "git branch -h" hits a good balance, and may want
to use as a model.

There is t0450 that aspires to ensure the short usage "git <cmd> -h"
matches the synopsis section of "git help <cmd>" for all <cmd>; right
now we have too many exceptions, and we should move towards making
these exceptions smaller.

> 2. For options which can be passed independently of any other options,
>    including them in the SYNOPSIS does not add any information which you
>    can't already get from reading the OPTIONS section.

Except that you have to scan a lot of text, which is quite
inefficient when you *know* the general idea behind the option you
want to use, and are only looking for the exact spelling of it (e.g.
"was it spelled --ignore-removed?")

> `git add` has
>    some mutually exclusive options, namely:
>    [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]]
>    but personally I already find that line so hard to parse that
>    removing it doesn't remove a lot of information

It is a very good point why we may want to have these cues to
express "these go together" (my earlier example of "branch") and
"only one of these is used".  I tend to agree with you that these
are not necessarily very easy to read.

While it is important to make it easier for new readers to learn, we
should also keep in mind that nobody remains to be a newbie forever.

>  [synopsis]
> -git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
> -	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
> -	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
> -	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> -	[--] [<pathspec>...]

This being a long single line and with redundant "--long|-s" may be
making it unnecessarily ugly.  Have you considered folding lines and
simplifying "[--long | -s]" into "[-s]" and see if it makes easier
to follow?  Documentation/git-commit.adoc may serve as a better
model.

> +git add [<options>] [--] [<pathspec>...]
>  
>  DESCRIPTION
>  -----------
