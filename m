Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73728B7DB
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082476; cv=none; b=GiO09hteKW3YOmqZhbUQ8nLuhChImxvlx18C8QAIuc9VBwHhNOMyaq5uOJFaaYvYsysw3zofnEwy1UsrIORvY6Ji/afTKZyoKsQ/gckiSwCaq+qnve2t25010o0hzKPYke72PDkATkQbpLcm3enhdi36XLM/DagODPKJCtb5+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082476; c=relaxed/simple;
	bh=ZqouW6IgNYuG/pKuqhTEMOwhqnQpVB2b6RC7S3NYU1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cHVc19sRd7OexU3/D0A0qlMY7SIsdcXFob1PLf2rQm3xUNfeAq1GshRe2Xa9YK9UZ0E7m40rQZGokBKm8hwSi32uPKq+8EjbDkgggl5H1f97ZsgMEYfXBXeDx8sxIcBztU/te0mkdhA+p49xs5fSific9YOdcV6Du/RUr5v5EiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q8ipTs+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNglIY5J; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q8ipTs+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNglIY5J"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B021D1D001AF;
	Tue, 21 Oct 2025 17:34:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 21 Oct 2025 17:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761082473; x=1761168873; bh=vUyvJI1AyK
	WK/EZtjCeC722nU3eIRvCalX44dH3tgQ0=; b=Q8ipTs+twTgz1xXOgvjmDLrOmZ
	OBiy7Ppaq3xt008NmALTK2AiZFvokEPvhjr1HI61Z1XJAvkJ2f5UFC/VDPyH7/fI
	l7RI6ubDLuJUERrI/bKCLnubHdmNcrLTJ8gsm2kBFaz5ZX0yBnpnScTj3How6/W6
	LX5k9YYrrPW5LdThcNBEHND204dhDun2W6yMwQpv8OYkTJshIvXR7y2SIcuAKKJd
	9YHpIToChjWe7+v1Zxb+oWkr0k5nVSjNLlBMl8TI1T0EmGE/fvptePNw/Y9PliMs
	lS5Dv7YSr7sFGNwxiXy1/PZOijgVaCiPlydMvxP1TibKWfra+baaQRFFYbPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761082473; x=1761168873; bh=vUyvJI1AyKWK/EZtjCeC722nU3eIRvCalX4
	4dH3tgQ0=; b=CNglIY5JgikCKDVDGky2I3dsjqk5bUYblzAEdJ/TV8W7iX0uYt+
	+UZgns/x3H1cmKm7lRIz1nPFwJGnpt55OWvQDGFHgnuiRhCtpQ1hzEc51AC2BMVb
	AMHunitJRG3+QgciaYt+ecnoNsLscF5+G3bE2pY0reUrPYrqNZY/M/Vpon5fhwGd
	QQKdUUAR2LmT6O/ndMtZFt6TVIUwVbswYjMtReVC7ql39eMqqBHR2WOgbNRrQj5R
	6DLTMenwzJ2KsTc2U9ryj/HJPstCbkNiH1cnXQFnOnrwWAZlhiz3ynJu3BwSd/Xq
	lwQO6RUSnu6fvBE9m4Usk+gXZOcU/WzSXCQ==
X-ME-Sender: <xms:afz3aGeokBFLLEtotZlRSKjX1P3rprm9leVO7TMMowg4Hbc8n4DkwQ>
    <xme:afz3aMwkpHrRV2mthO4_HUkJQZEaQ4emsqm805OSUGxPVx86F13eG4iaCUJ4Xteqj
    1gGl1qFCwzqcyJ64Kou7j8hb-FmklXuBqVBWGfxI93yIm2VPtNW>
X-ME-Received: <xmr:afz3aL8rqfjojs5WNsWl3dSFdgftQC_1N-3fmo8ElFXlIpyLIpB6Q5gOIlAK_sQXT504TEmfOh7YwusLMqO57_7SPb9V7MlyAlxe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:afz3aKw73gPLWDS7_Ngko7IkZcOKK58t_JRNgrtdKGcn6bvp7tjyBA>
    <xmx:afz3aDrI6dX5FyV1Deeb32CBmwG2XIFnezInEkd7HhZp-7vN7XiVBg>
    <xmx:afz3aDrU6NjuIKhF_GLhN0IZmjMdEDBxftGNtBKmCXQWaw-sSMKxZg>
    <xmx:afz3aLDhBg88HHe2GTEPRZl1P0HF5boDi_ggv42PDBuZyBKTXLoOow>
    <xmx:afz3aNs_tPxoNhYncd9VNAKn5kaoLBI_CYOYmPgGvq-L1Dhe7v1s4Y4C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 17:34:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 06/12] builtin/history: implement "reword" subcommand
In-Reply-To: <20251021-b4-pks-history-builtin-v5-6-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:54 +0200")
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	<20251021-b4-pks-history-builtin-v5-6-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 14:34:31 -0700
Message-ID: <xmqqa51kszvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Implement a new "reword" subcommand for git-history(1). This subcommand
> is essentially the same as if a user performed an interactive rebase
> with a single commit changed to use the "reword" verb.

Oy.  I've always wanted something like this in "rebase -i" myself.

It is a bit sad that I have to learn a new command to do something
obvious and trivial like this, but that's life ;-)

Maybe "git history" becomes powerful enough and can replace my
every-day use of "rebase -i".

> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git history [<options>]
> +git history reword [<options>] <commit>

It is curious that a command-less form is still listed here,
especially since this command "requires" a subcommand.  I would have
expected that there will be a single line here after implementing a
single subcommand.

> +`reword <commit> [--message=<message>]`::

That should be `reword [--message=<message>] <commit>` no?

> +	Rewrite the commit message of the specified commit. All the other
> +	details of this commit remain unchanged. If no commit message is
> +	provided, then this command will spawn an editor with the current
> +	message of that commit.

As long as it takes more than one -m and concatenates them just like
"git commit -m <message1> -m <message2>" does, I would not complain
too much that a command line option to give message encourages sloppy
log messages.

> +		if (!onto) {
> +			onto = commit;
> +			result.clean = 1;
> +			result.tree = repo_get_commit_tree(repo, commit);
> +		} else {
> +			onto = replay_pick_regular_commit(repo, commit, replayed_commits,
> +							  onto, &merge_opts, &result);
> +			if (!onto)
> +				break;
> +		}

Hmph, I would have expected that the overall flow of this command
would be

 * find the commits above and including the <commit> in question,
   making sure there is no merge.

 * read metadata of <commit> like the parent (as we do not allow
   merges), tree, author ident & time.

 * create a new commit object that has the same metadata as <commit>
   on top of the parent of <commit>, but with the updated message
   and new committer ident & time.

 * initialize a variable Current to point at the rewritten <commit>

 * loop for each commit C in <commit>..HEAD range in reverse order
   (we know we have a single strand of pearls):

   - read metadata of C

   - create a new commit object C' that has the same metadata and
     message as C on top of the Current commit, with new committer
     ident & time.

   - make Current point at the resulting C'

 * Point the Current with HEAD.

without having to touch any "pick" machinery.  Why do we need to go
down to the merge machinery for a mere "reword" operation?
