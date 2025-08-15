Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FB1B960
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218330; cv=none; b=ruYrWcdOucNti6uHWwnYCNx6R4tGoZcoQKWXhTHuGKNq7+H7hUndAtOj53If6cWizlAMiJR/ILZg/JF1hvl/VbMVl13r2u/Jwzc1M1EXsWYtDlWo9cjpdJzcppmgO09jKiBeEogVV842AaRavAScB8ssppVBjOkIVvkA4Yw+yFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218330; c=relaxed/simple;
	bh=baJeRK3MwI4QXBbPK5CrP8VPp/lfe7u4W1r3u1UW7p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O96DGFfDB2ivEB+kEhVt99NANzxtifWVq27u/C+T9gtiiJXtkd3eycdTsm2VUMGiBOpycpguj7/v2wsIAnCKz0PNI9mrGkWIlN+2+vKHWiktD+nPuCXdGFqLDvSxafSoiVp3oZFbq2kKapjE+EQ8K4ozVCp1Gm4hWXiLIhBY4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PLUDMK/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GOP3QnVU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PLUDMK/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOP3QnVU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 408F8EC01C3;
	Thu, 14 Aug 2025 20:38:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 14 Aug 2025 20:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755218327; x=1755304727; bh=pGHQe+oSg6
	upvDiFwpcpwzu/KwmIjomLfjT/4us4iIE=; b=PLUDMK/laRZS4935GHX5mkmSzs
	cN2I8kjhq3jK03xMswPdmkFufcQEA4xrS7BEtQZ++OprWnGWkfVjHGGJijJVPFrg
	qRGUkhAE3b0eVQcTa2DN/KGXWUTYTV5zPk+Nugl6Kiob8aESG/VaalHtelWep17c
	0CLA/w3Uvmy3dTCcQ9RJ+goP8wZt4V6GmzewhgXdOibAcADJi5hX9doPV6LsT4V6
	sR14+9qKOLqtKA94+Lr5j52ZiRK3nwq3hiXiPlVXC57RxG4pz/drQhw+edreHA4E
	JqPOSJD5Z9ld/WVi6++tGK5GvqTiGiTmvtvGwhXi5b6OxEloil8A60W8oIbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755218327; x=1755304727; bh=pGHQe+oSg6upvDiFwpcpwzu/KwmIjomLfjT
	/4us4iIE=; b=GOP3QnVUM1GoVUZ14HTQp5NMOfq3hbpytvGYIKT9y10OwgmxnSD
	uPJIZ8qD+0/rfZIBf08selM5LLsmK0IAU31LR1s7u3MgRCDopmpiICpn4oj90C8M
	qZy1POh6ihlq3KFWpOH/rg7ni4LAh30U1MdBeeILguaksDN5ryfO0U0gQF8fKaO9
	K5SQ32Aw1XqBpKxnpNvFgviFnrc+0mnG0WIengjdVlefxySiDD4jdkkn/51eST0w
	ezBljI6pIuqL5VegMREBnzA9it+ulNbOvj2YjtdyNLEJ7k0IwmC+WDANvdBcXWU/
	DSplh/Wkm0z1fB+RVL1o4qv0zmGBhZ8+ICQ==
X-ME-Sender: <xms:l4GeaCBEA-onqWyVh0qrgXd0U4tqFfxWxR6-91ay17n-r86OiOz0QA>
    <xme:l4GeaKGdXAt4KX7SIdcLCo1QpUClx8q5B__i4wa5qP8cjfbvzJbI2c82quXCwdMeZ
    R0cimzCv1VDa2Mtlw>
X-ME-Received: <xmr:l4GeaMAxKYkKfM6967FvchC_W1LYe7yszdCdIxHSc5LrHUv5aHa4b9bk-EXz3kypgzthaipv07OgPALVvOhDqizJLSgYzxzB5AeOL6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l4GeaCWD8Q2LJaB2cF_oFGkWZCbslyDVzupQuLow_-i9Zh9ylSv_Mw>
    <xmx:l4GeaIp0ETqBc7PSP9biAInTLAl3uA5VaLIle2Sx2ELeger0psRFzQ>
    <xmx:l4GeaGT2NPeW64-eQIYqem45Hkn9Ka7TRfF1V1m8Ea8jZFuOvwvGvA>
    <xmx:l4GeaK27g0FiGadsPnTLKfdeu59VJIYPqCOfuzQFJpYUoj8mzN5aJg>
    <xmx:l4GeaP-PoSKb3_d8dGCzwy4KOWaliH1NDN3-pKWbbJ7VrWHC_gAju9pO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 20:38:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/4] doc: git-add: start man page with an example
In-Reply-To: <d041d09589b51734a8cc257f80cdaf210c6676e7.1755127218.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 13 Aug 2025 23:20:15
	+0000")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<d041d09589b51734a8cc257f80cdaf210c6676e7.1755127218.git.gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 17:38:45 -0700
Message-ID: <xmqqikipv2p6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -git-add - Add file contents to the index
> +git-add - Add new or changed files to the index

Does it add much value to say "new or changed" here?  The command can
also be used to "stage" a removal of a path, e.g.

    $ rm tracked-file
    $ git add -u

so if the updated text is an attempt to give more details on what
kind of modifications are captured, it would be better to say "add
new, removed, or modified files".

> +Add new or changed files to the index to prepare for a commit. The
> +"index" (also known as "staging area") is where Git stores the changes
> +that will be in the next commit.

I won't repeat myself about change-snapshot duality, but I do not
think the new text is the best we can do.

    Update contents recorded in the index to prepare for the next
    commit.  The index (also known as "staging area") is where Git
    stores the contents that will be in the next commit.

> +By default, `git commit` only commits changes that you've added to the
> +index.
> For example, if you've edited `file.c` and want to commit your
> +changes, you can run:

Likewise.  "and want to record the resulting contents".

> ...
> -Please see linkgit:git-commit[1] for alternative ways to add content to a
> -commit.

In the original, this comment does look a bit out of place (as the
text around there does not talk about `git commit`), but as you said
that by default 'git commit' makes an as-is commit above, it may be
a good idea to move this sentence there.  `git commit <pathspec>` is
a handy thing to know even for beginners, and making your next commit
is what the user is working towards by using "git add".
