Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6B3C5DBE
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757359; cv=none; b=lcrNcGq/esEhz/1+KpWjakb4aQ67YS4cohHyYvJaMfsvWe/xeMUkc7GzUBiqjgrnhJ8GzG8dgBI200+8Cax+gE1JUkbg4IuiDQnV6zre64COUElUhDCLQ2TYDDG2WVCUkdY1AfteDDAIUYgGj5E8LrNBbLX+dn4pHG5AaP/IZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757359; c=relaxed/simple;
	bh=VcafatvtioPQniYu3nKULmBnt7N7jAffxRWT0qhlRKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKzyjDAHVVPvM6Ts+QIJs43UIg6yFYiOmPtoZDsTTrAANDdZA4s3uZ537dT3GnkXpL91Bvf4arnKzPIG99nzQgLzpVj9dRjmn68z8vWLbdKKg+Leg9wDTvGCz+EHoWv9lRQGGIT+r27P6YGQyJf7O9fVQqklaACyUTKqpRIzq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bjp1cNqS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvZjkj9h; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bjp1cNqS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvZjkj9h"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8251414002A9;
	Thu,  9 Apr 2026 13:55:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 13:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775757357; x=1775843757; bh=OrIxzcKwim
	SePj14MwJEjyHVSFf19Z3AyuSmTAhpuLw=; b=Bjp1cNqSUBFCHSmjF2HHXuWwoM
	g+GWQFUi8LtagSFmnDcgXOkpKtYP1E9wcVqt6CIGR2jop8yOcz7kHz1h7OEbnc1/
	tziOh/qylHVdMC2yAAFInktNhBu2uormwVWj3TfkiKgF3wRmIBv0BSmOjgudkRrj
	avcQ3auOqTXccPQYfBtqpMV2dNnPccN70US/BZWrkvxDBPXrDMrJgcWgOb6W7mHh
	VXTjuMbTyO7nvs40Ja7QmhxPoO1JFEBVWFLbS3B8Th9iUlam9r8/aI3l3RvPciIq
	NaYKh/kulsmzgKugoogXNFA9e5z45h0nYc5bD+u6v+7+UA/j9QCzkJ75rR7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775757357; x=1775843757; bh=OrIxzcKwimSePj14MwJEjyHVSFf19Z3AyuS
	mTAhpuLw=; b=ZvZjkj9hEQCIZBgVznq+CH+UWvdEM+6AvjbckiAreqC423kfZK8
	jWJTRQCBD83C8TKId8IYi0LqboukYLE8PNrIXMPVKDpLBgbAT57Q9hpMyWZSZ9wB
	PltDO7sF6r1HPVUeOUsSZ6kQkj3buOy3nGT3YitU5FhMXCqtn7q4BB0Ad+L7F4Yn
	4eeMKO2+Vhln8nxVzPCgDCYuS29tGaj0871KEqEyJUq9GUTANYcx96TrtKfE600z
	7cGU6zianCigIPhUyHjhG4ua5lWbgkim+qkVurTwESCnRMgWVPWhqwa8Fta/VN81
	q+NRsgdmYg6p9knVKcRZde+hPHXB1I0U0dg==
X-ME-Sender: <xms:LejXaZgBcN-iL9T_8AevPvE1KXTJp5Ofle47jtIostIrIzyH6S0RaA>
    <xme:LejXaU4kbCdIrw-4_hCuB1Ym74zANrMxdB7sbYIpi3ReUPcQ4EQGXY-B7YmuGKOHU
    zIBFWQOjCMd-AkJwO3RwN3mW5eV8c1dTgjW-rnDFP0kLgA8LE_i9Q>
X-ME-Received: <xmr:LejXaRYcpLBqTHdjadmFwgL28cI4dW1MsygV79sP_t2vLWJlJq3of_nLNafq0-Z-WxMvRkwFws0IAPQ1cKehI1pieDlwchGviA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehhrg
    hrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LejXaZ7jBCVOBycrSq4vl0nS17JKUNwRP6voEWa47p5CwwFFhU4qRw>
    <xmx:LejXaUCbUjYMAFFttHaFVVj3Wg-brcolweS9VpncMvPMTpqY2DL_Yw>
    <xmx:LejXaffzo_vkPEgsDoZMM3u7Q7RnWHymee1DvIoohSqYPL3ilBMFIA>
    <xmx:LejXaTIS7OE6jg0gNc6zxL-n_SPTfSBe1qBflJXEC0-P9AFGnbK0mQ>
    <xmx:LejXabZseyn2ZteMysI4KsVT2ItREPUKIgCim2k2DcGTNZBkJ-G_CUlE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 13:55:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 4/4] checkout: -m (--merge) uses autostash when
 switching branches
In-Reply-To: <1c29e1997132273d58831c470f581fc9ae53198a.1775741265.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 09 Apr 2026
	13:27:45 +0000")
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
	<pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<1c29e1997132273d58831c470f581fc9ae53198a.1775741265.git.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 10:55:55 -0700
Message-ID: <xmqqjyugt3v8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  === 3. Merge conflict
>  
> -When a merge conflict happens during switching branches with
> -the `-m` option, you would see something like this:
> +When the `--merge` (`-m`) option is in effect and the locally
> +modified files overlap with files that need to be updated by the
> +branch switch, the changes are stashed and reapplied after the
> +switch.  If the stash application results in conflicts, they are not
> +resolved and the stash is saved to the stash list:

"results in conflicts, they are not resolved" felt a bit funny thing
to say.  The definition of resulting in conflicits is to be left
with unresolvable conflicts ;-), so ...

    ... and reapplied after the switch.  If this process results in
    conflicts, a stash entry is saved and made available in "git
    stash list".  This is so that you can revisit it in case if you
    fail to resolve conflicts correctly.

or something.  But reading what you have further down, I think the
last sentence "This is so that ..." is probably unnecessary.

> ...
> +Your local changes are stashed, however, applying it to carry
> +forward your local changes resulted in conflicts:
>  
> + - You can try resolving them now.  If you resolved them
> +   successfully, discard the stash entry with "git stash drop".
>  
> + - Alternatively you can "git reset --hard" if you do not want
> +   to deal with them right now, and later "git stash pop" to
> +   recover your local changes.
>  ------------
> +
> +You can try resolving the conflicts now.  Edit the conflicting files
> +and mark them resolved with `git add` as usual, then run `git stash
> +drop` to discard the stash entry.  Alternatively, you can clear the
> +working tree with `git reset --hard` and recover your local changes
> +later with `git stash pop`.

Very well written.  I am very happy to see this text.

> diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
> index 87707e9265..3147023dc3 100644
> --- a/Documentation/git-switch.adoc
> +++ b/Documentation/git-switch.adoc
> @@ -126,15 +126,16 @@ variable.
>  	If you have local modifications to one or more files that are
>  	different between the current branch and the branch to which
>  	you are switching, the command refuses to switch branches in
> +	order to preserve your modifications in context.  With this
> +	option, the conflicting local changes are automatically
> +	stashed before the switch and reapplied afterwards.  If the
> +	local changes do not overlap with the differences between
> +	branches, the switch proceeds without stashing.  If
> +	reapplying the stash results in conflicts, the entry is
> +	saved to the stash list.  Resolve the conflicts and run
> +	`git stash drop` when done, or clear the working tree
> +	(e.g. with `git reset --hard`) before running `git stash pop`
> +	later to re-apply your changes.

We lost "however" but it is OK.

We would want to hint that "The command refuses to" refers to the
default behaviour when option being described ("--merge") is not
given by some other means, which was what the "however" we lost from
the updated text was trying to do.

> @@ -217,15 +218,15 @@ $ git switch mytopic
>  error: You have local changes to 'frotz'; not switching branches.
>  ------------
>  
> -You can give the `-m` flag to the command, which would try a three-way
> -merge:
> +You can give the `-m` flag to the command, which would carry your local
> +changes to the new branch:

Yes, saying "carry your local changes to" is much clearer than "try
a three-way merge".  I very much like this new text.

>  ------------
>  $ git switch -m mytopic
> -Auto-merging frotz
> +Switched to branch 'mytopic'
>  ------------
>  
> -After this three-way merge, the local modifications are _not_
> +After the switch, the local modifications are reapplied and are _not_
>  registered in your index file, so `git diff` would show you what
>  changes you made since the tip of the new branch.


So now to the more exciting part.  But there isn't much to comment
on, as it stayed the same since a previous iteration where Phillip's
excellent "we do not have to waste cycles to dry-run at all" idea.

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..857a5a6bd1 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -210,6 +210,194 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>  	test_cmp expect two
>  '
>  
> +test_expect_success 'checkout --merge --conflict=zdiff3 <branch>' '
> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	fill a b X d e >two &&
> +	git checkout --merge --conflict=zdiff3 simple &&
> +
> +	cat <<-EOF >expect &&
> +	a
> +	<<<<<<< simple
> +	c
> +	||||||| main
> +	b
> +	c
> +	d
> +	=======
> +	b
> +	X
> +	d
> +	>>>>>>> local
> +	e
> +	EOF
> +	test_cmp expect two
> +'

OK.  Do we want to verify with "git stash show -p" or something what
we stashed away?  I see we later have an explicit test to see that
the stash entry can actually be used in "stash pop" after clearing
the stage with "checkout -f", so perhaps it is OK to leave it to
that test, instead of checking in every step.

> +test_expect_success 'checkout -m skips stash when no conflict' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same
> +'

This one may not just check "test_grep !" but also check the output
of "git stash list", perhaps take one before and after "checkout -m"
and compare them?

> +test_expect_success 'checkout -m stashes and applies on conflicting changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 6 7 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "Applied autostash" actual &&
> +	fill 1 2 3 4 5 6 7 >expect &&
> +	test_cmp expect one
> +'

Nice.

> +test_expect_success 'checkout -m stashes on truly conflicting changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	test_must_fail git checkout side 2>stderr &&
> +	test_grep "Your local changes" stderr &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "resulted in conflicts" actual &&
> +	test_grep "git stash drop" actual &&
> +	git stash drop &&
> +	git reset --hard
> +'

OK.  This is an emulation of a user who gives up resolving and punts.

> +test_expect_success 'checkout -m produces usable stash on conflict' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep "recover your local changes" actual &&
> +	git checkout -f main &&
> +	git stash pop &&
> +	fill 1 2 3 4 5 >expect &&
> +	test_cmp expect one
> +'

Nice.

> +test_expect_success 'checkout -m applies stash cleanly with non-overlapping changes in same file' '
> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	git checkout -b nonoverlap_base &&
> +	fill a b c d >file &&
> +	git add file &&
> +	git commit -m "add file" &&
> +
> +	git checkout -b nonoverlap_child &&
> +	fill a b c INSERTED d >file &&
> +	git commit -a -m "insert line near end of file" &&
> +
> +	fill DIRTY a b c INSERTED d >file &&
> +
> +	git checkout -m nonoverlap_base 2>stderr &&
> +	test_grep "Applied autostash" stderr &&
> +	test_grep ! "resulted in conflicts" stderr &&
> +
> +	fill DIRTY a b c d >expect &&
> +	test_cmp expect file &&

Should we or should we not see an extra stack entry saved at this point?
Don't we want to test it?

> +
> +	git checkout -f main &&
> +	git branch -D nonoverlap_base &&
> +	git branch -D nonoverlap_child
> +'

Overall very nicely done.
