Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FA2F0696
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032482; cv=none; b=AUKRHolJ8vOH/JKiXVWXRKpoAqVQn7QfCnpGKC4d/GsDqakL7MfSH4izRrZm+DnI7yC6tAPVG5hMOlGJHDyjiCeUh4dX8uWNvbdSonvQ3nnCrEmG8jgAvygjHRmFJ6cKa0k7qyINCiyr//XTo7SoTWz9jOQeNPHgmYMKOnE/+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032482; c=relaxed/simple;
	bh=eMgAYEnIVwT9GuGUJ2pCXFg9sukUjbAzgxTB+/GVP4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H0X2Pvy7cu3fCUTYLuVJLmED+x7SdQpuScYu6i/a99VAGpN4I19WUSbWfax+aUghH6snuySOwWef9Qi47SJ9hJ/1i0OhPdipKGQ/oYorI7n3aROQW7aCSYDscoKn9aTpZOcukhJTGkRtNEmLBtTnfdmz5B2G205oTSgq48qHAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BGe6XlJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GhvO+uET; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BGe6XlJH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GhvO+uET"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21D167A00E6;
	Tue, 12 Aug 2025 17:01:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 12 Aug 2025 17:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755032477; x=1755118877; bh=ByX6+LE0K3
	ntnkYVeewBpmounbnFLTqID+D8KuZaYds=; b=BGe6XlJHoDQnVkNcWF2HU9mRDJ
	8VUZMeEdtji7Pm3BQ9omTPB91/vCxxGmXuh9pilbgkiGnOD0+o69lN5e4LCpfGxe
	Jg28cNssqsg2kbTXCbxsFL99Ip1IbQQVu6pT0Ip86LCEVugMZp9WWiYuQKZfqyeq
	f3hgnCiiJbPamVZED20aYREJw9YgHK22WgaXECAjjHb47w0SZ/9zNwg9z5SA5cdE
	iDTZ8SlyJYI48ntceHNHd/qsJcD1yjqKaoJbs86+8IvrkGgvKZpWQDBzkexpAeQm
	wUu3isHpy8++YI6W2JVL/fgxGgtQHb2gDjo97NHVtwF+Z0paM+vOg+hR+uFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755032477; x=1755118877; bh=ByX6+LE0K3ntnkYVeewBpmounbnFLTqID+D
	8KuZaYds=; b=GhvO+uETNqXJBEK8sNQGN/wkm62rghk6oybEHOvjIPj/jpQa/hW
	3rARSYhg466l3wLSCWvGf+UgbQGvauycCKXi1+75ZQ+mRjs7W9l/6t+/6FPtE+VC
	glN3jctXbQ1+PuE+bznaELCpqbJ6UhE1+4FWGT3HfZYW4TF2GLqj+ER8Lw+lvh1K
	JUBit5yh+WHFoDkpU8z+TrBV7tZNJ6E1Xcm8XCQb14mEG455Ii+ckMdB+Mt4y12G
	ReNwJKasuvujCTlrX9t/A4pl++cMPASJR7szPK4aoE7CDc9sUA2pgMyEnftfrYya
	+AZhy19EusRx8njSu1UcDYCz5GsXRnOzYeA==
X-ME-Sender: <xms:naubaGIHxvXvn3mo4y2IsLh6wa1RHQysLkjyTAdguS_nckdsMQJ__w>
    <xme:naubaIs-NcgOqcGISqqibzRQSCbVMVB5BlTeLf5cdrKx-ICOdq8RwKrYR1IknXRA6
    vNe-0anvQMOOCp3Eg>
X-ME-Received: <xmr:naubaDSRICByZ6DVipiikW81O5WJFYbxaKbF_oIo1PFCXa-rRaaeFuTG8q_b2LqMvt1uCozS7H6SMyAss-tQ6yFwYrNOk5cfi9StQQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeifeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:naubaOPAg5EWxHq8ie1DMZz5wO0Kulo6oYC3Akp-oI4fGWkWUMGMTg>
    <xmx:naubaIZgP05CWZpgXShC5q8xzxVNKVB_Mnhg-SOWGBU1dCC3FtXByg>
    <xmx:naubaIyQJ_nJgs5diDlPT6-7AcHZVJMMSvWUS233fqLordSfxwU72Q>
    <xmx:naubaDI682Wpuso8AUoZVSSOZhybIUZY6aEcetqJ5CSO_B46B7mJew>
    <xmx:naubaP7HqZC7owNqGRC8JryV61MLHrhXHoSP2EJPGyqUYmaIybNSeBmw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 17:01:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
In-Reply-To: <310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 12 Aug 2025 20:07:26
	+0000")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 14:01:16 -0700
Message-ID: <xmqqbjoks19f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> - Remove the snapshot-based explanation of the index and replace it with
>   a diff-based explanation because I don't feel that it's useful in this
>   context to emphasize that git uses a snapshot-based model: the main
>   way most git users interact with the index is through `git diff` or
>   `git status`, which is a completely diff-based view of the index.

But isn't it the source of the most end-user confusion that they
cannot wean themselves off of the diff/patch worldview?

How would you explain what the users would see in their "git diff",
"git diff --cached", and "git commit" after doing "edit && add &&
edit", if you explain "add" to be storing the "diff" made by the
first edit?  Does their "git diff" after the second "edit" take that
previously stored "diff" and another "diff" made by the second
"edit" and magically combine them together to present a single
"diff"?

> -git-add - Add file contents to the index
> +git-add - Add new or changed files to the index

In other words, I do think "new or changed" is a good thing to say,
but the word "contents" is fundamental here.  "Add contents of new
or changed files to the index" would be good.

> +Add new or changed files to the index (also known as "staging area") to
> +prepare for a commit.

OK, but saying "files" here adds another kind of confusion.  What is
"added" is not the fact that these paths are kept track of by Git.
Instead we add the snapshot of the contents at the time of 'git add'.

Wouldn't "add file X" confuse folks who still remember how other
SCMs before Git operated (i.e. "file X is now known, so if I make
further changes to X next 'commit' command will record it") into
thinking that Git would do the same?

> +By default, `git commit` only commits changes that you've added to the
> +index. For example, if you've edited `file.c` and want to commit your
> +changes, you can run:
> +
> +   git add file.c
> +   git commit

What happens when you did "edit && add && edit && add"?  It commits
the two changes you added to the index?  I do not think it is
productive to hide the fact that you are preparing a snapshot of the
"next commit" in the index (or "staging the contents for the next
commit in the staging area") with various forms "git add", including
"git add -p".

And to help form that mental model, it would help to avoid phrasing
"commit your changes" (as if you are somehow dealing with "diff/patch")
and instead saying "commit the result of your changes" (stressing
that the "state" matters), I would think.

De-stressing the fact that we are taking a snapshot should probably
be considered a documentation regression here.  Thanks to "git add"
taking a snapshot, users can further make experimental changes in
the working tree files freely and then come back to the exact
contents back by checking the path out of the index with "git
checkout -- <path>".  Thanks to "git commit" taking a snapshot,
users can even go back to the last commit by taking the exact
contents back by checking the path out of the HEAD with "git
checkout HEAD -- <path>".

I'll stop here and let others express their opinions without further
commenting for now.

Thanks for working on these updates.

