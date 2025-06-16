Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF92BEFE1
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096858; cv=none; b=XfT8o5UZaoqdTMRSwYONIfa4WUmnnKjNmxD2kcT8ZGRDtwi5GUueSEvtuhu/ARyHiZi+cn+FtHvU4bx2EcUpJ5ykqiLwV2uD1lB0L5QWiE9KcwxEcrbWfOPaVb5iw0fgv+Go8Atww1mvm8jncb0kKxzjk7mZZaZgbwTCAXGJ5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096858; c=relaxed/simple;
	bh=qfjQ5U77ADfTv0GsEihkJ71qJ8bQKQPyjWtz3yXPTDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vBZ6fbMRkLjOAyewDJ0l/XvvKr4jk6V+ZPu+PYMaEAynOq6BVPjbWIgKmcFXuqxi38c4On1dLxDG6IjVyAJuNKzejfVu20lG0KiF5OBJpNivvDp7fdMBP8LuDozMDessgPaEy/FuqeclgfFOg56lvAyyRLIRlrzl1ExruPHY5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hs8Z874u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jqKmSbXD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hs8Z874u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jqKmSbXD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A2EF41140134;
	Mon, 16 Jun 2025 14:00:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 16 Jun 2025 14:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750096854; x=1750183254; bh=V0ORgwkIHt
	p/jxaRkT827tn594KvMeDtQk/8+Bu4l6E=; b=Hs8Z874uXt1Va3ORC9fwF5bamK
	1/yArxTo/mMkve40W6YtKwI8ci+u7XAmz+msOVawLq/k0NXzcD48gE5H6/oDa/in
	7omOgWvwA4f1f34AIf+5StjephDweEFkPQwvt+69TgrRUEmHGJO/dZDqfFIs449E
	DEmQlGg8OUZuN84QqkG7/2jZw7n5HE4W8PJx/TMVroYje3bvJNaxHt4IteAKYlsG
	+zae5+k6Pp74sYJfBTzC36UYXVIQd+3Ao5elZqP/N9mBqih7n3T6rIlPJh7ct1cN
	vu1eW/E5wWbdIpovSRdHyy6PrKIhMs/uyNeYCUjM9BqF6YJbGu2oQUgQ537Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750096854; x=1750183254; bh=V0ORgwkIHtp/jxaRkT827tn594KvMeDtQk/
	8+Bu4l6E=; b=jqKmSbXDixRq5kxqbAgcAPP88TX9rYC8aIgHkgeLJHDzsfDnEks
	f/sx55UePpKhhf2u0M1dO3xJhgH1y897Kb66b6Hn5XFXg7E+9MixTUC39KNYAZMD
	MA/y5dOPY7WZMVut1tA3mAatDJAdoKc2Qdf+Ev3VvZcWFS1Hs7ibruFzXcFwanx3
	tjloS0MP6+fc+R+ZaFCccPU0wOagDkCh5jyXllCM6wPMQ03MJkM1hk+ZYhwpS3NP
	MGoTDfsG3qJxwSYkPWeVZlyb0DJmdNXqFd2xMxIQkNzxP0fU9MxswiT6LjdY2crf
	hprvCp/g6dP7GmKMQuTWcdeoBIVJIqrNf7Q==
X-ME-Sender: <xms:1ltQaPlDr8y-BdtqUeKGCZ8aI6aCmXiLvoOYZJb_TA2hItIzz6Q-hg>
    <xme:1ltQaC3DM31QnSeaUJJDUOk0Y7GB_s235oR3N2Ag0hVy2sAAbDVeX6qp16zVAvXOe
    BOjF3vyDtgQnqrqoQ>
X-ME-Received: <xmr:1ltQaFrgQLuaUaUEnbuuv5mi3bSOabXocZWjb3AF97rGTXjuHrLm0vBNmPr5SZgPJ6CAwHLDhaar_vEG6foJ6XoJ7N6ybaFctZnH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprhhoughmihgthhgvlhgrshhsihesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepih
    hsrggtrghsvghllhhisehushhprdgsrhdprhgtphhtthhopehitggrshgvlhhlihesuhhs
    phdrsghrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1ltQaHnOCyigaN5U8iCwcNaIyHVSpQtGOJ8XgZExTulrH3iTY_GW5A>
    <xmx:1ltQaN1jVyr3HgMqGnoJSB7zQjMqBmrOjy6YPYZL3Bf-rRFm7a54Yw>
    <xmx:1ltQaGuvkMHcrH50xF6WWzIWyp_GLNus0PPy6GNoFxJD5Nqzz6-TDQ>
    <xmx:1ltQaBVkdluN-Yl2Ar1tllr06Nh1VTZy3nCHC_l715cGmruhd2SUbA>
    <xmx:1ltQaB_2hn4V7A05PNffrFQVuvwMPcoc0tKSRXGGSitLj93yCfeOQ1Mr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 14:00:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Rodrigo Michelassi <rodmichelassi@gmail.com>
Cc: git@vger.kernel.org,  isacaselli@usp.br,  Isabella Caselli
 <icaselli@usp.br>
Subject: Re: [PATCH v3] t2400: replace 'test -[efd]' with 'test_path_is_*'
In-Reply-To: <20250616144540.21075-1-rodmichelassi@gmail.com> (Rodrigo
	Michelassi's message of "Mon, 16 Jun 2025 11:45:40 -0300")
References: <20250616144540.21075-1-rodmichelassi@gmail.com>
Date: Mon, 16 Jun 2025 11:00:52 -0700
Message-ID: <xmqqo6unzhuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rodrigo Michelassi <rodmichelassi@gmail.com> writes:

> From: rodrigocmichelassi <rodmichelassi@gmail.com>

As pointed out earlier, we want to see this line look like

    From: Rodrigo Michelassi <rodmichelassi@gmail.com>

This often comes from your commit object; you'd have to fix it there
to match "Rodrigo Michelassi <rodmichelassi@gmail.com>" used to sign
off this patch, something like:

 $ git commit --no-edit --amend \
   --author="Rodrigo Michelassi <rodmichelassi@gmail.com>"

while you have that commit checked out, and then

 $ git format-patch >patch.txt --stdout -v4 -1 HEAD

to prepare the patch, proofread it and then optionally after fixing
anything you found problematic in your proofreading, run git-send-email
on it.

Because your MUA already gives the name you use on your
signed-off-by line on the From: line, optionally you can just edit
the line out before sending, i.e. after the format-patch produces
the text file, before send-email sends the file out.

> Sorry for the wrong commit message on V2.

Anything you write in the body of the message, before the three-dash
line, goes to the resulting commit log message.  You do not want to
etch the above message into stone.  You can write such an ephemeral
message after the three-dash lines.  See these for examples.

    https://lore.kernel.org/git/20250512185233.GC1276214@coredump.intra.peff.net/
    https://lore.kernel.org/git/20250225063421.GJ1293961@coredump.intra.peff.net/

> 'test_path_is_file', 'test_path_is_dir' and 'test_file_is_missing'
> are modern path checking methods in Git's development, that emit
> useful diagnostic information when detect a failing condition, while

"modern path checking methods" -> "test helpers used"

Also, "when detect" -> "when they detect", probably.

> test -[efd] does not.
> Replace the basic shell commands 'test -f', 'test -d' and 'test -e',
> with this modern path checking approach.

Ditto.

> Co-authored-by: Isabella Caselli <icaselli@usp.br>
> Signed-off-by: Isabella Caselli <icaselli@usp.br>
> Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>
> ---
>  t/t2400-worktree-add.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

The changes to the test look good to me.

Thanks.


> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 90638fa886..023e1301c8 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -42,8 +42,8 @@ test_expect_success '"add" using - shorthand' '
>  
>  test_expect_success '"add" refuses to checkout locked branch' '
>  	test_must_fail git worktree add zere main &&
> -	! test -d zere &&
> -	! test -d .git/worktrees/zere
> +	test_path_is_missing zere &&
> +	test_path_is_missing .git/worktrees/zere
>  '
>  
>  test_expect_success 'checking out paths not complaining about linked checkouts' '
> @@ -70,14 +70,14 @@ test_expect_success '"add" worktree' '
>  test_expect_success '"add" worktree with lock' '
>  	git worktree add --detach --lock here-with-lock main &&
>  	test_when_finished "git worktree unlock here-with-lock || :" &&
> -	test -f .git/worktrees/here-with-lock/locked
> +	test_path_is_file .git/worktrees/here-with-lock/locked
>  '
>  
>  test_expect_success '"add" worktree with lock and reason' '
>  	lock_reason="why not" &&
>  	git worktree add --detach --lock --reason "$lock_reason" here-with-lock-reason main &&
>  	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
> -	test -f .git/worktrees/here-with-lock-reason/locked &&
> +	test_path_is_file .git/worktrees/here-with-lock-reason/locked &&
>  	echo "$lock_reason" >expect &&
>  	test_cmp expect .git/worktrees/here-with-lock-reason/locked
>  '
> @@ -412,14 +412,14 @@ test_expect_success '"add --orphan" with empty repository' '
>  test_expect_success '"add" worktree with orphan branch and lock' '
>  	git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
>  	test_when_finished "git worktree unlock orphan-with-lock || :" &&
> -	test -f .git/worktrees/orphan-with-lock/locked
> +	test_path_is_file .git/worktrees/orphan-with-lock/locked
>  '
>  
>  test_expect_success '"add" worktree with orphan branch, lock, and reason' '
>  	lock_reason="why not" &&
>  	git worktree add --detach --lock --reason "$lock_reason" orphan-with-lock-reason main &&
>  	test_when_finished "git worktree unlock orphan-with-lock-reason || :" &&
> -	test -f .git/worktrees/orphan-with-lock-reason/locked &&
> +	test_path_is_file .git/worktrees/orphan-with-lock-reason/locked &&
>  	echo "$lock_reason" >expect &&
>  	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
>  '
> @@ -474,7 +474,7 @@ test_expect_success 'local clone --shared from linked checkout' '
>  
>  test_expect_success '"add" worktree with --no-checkout' '
>  	git worktree add --no-checkout -b swamp swamp &&
> -	! test -e swamp/init.t &&
> +	test_path_is_missing swamp/init.t &&
>  	git -C swamp reset --hard &&
>  	test_cmp init.t swamp/init.t
>  '
> @@ -497,7 +497,7 @@ test_expect_success 'put a worktree under rebase' '
>  
>  test_expect_success 'add a worktree, checking out a rebased branch' '
>  	test_must_fail git worktree add new-rebase under-rebase &&
> -	! test -d new-rebase
> +	test_path_is_missing new-rebase
>  '
>  
>  test_expect_success 'checking out a rebased branch from another worktree' '
> @@ -535,7 +535,7 @@ test_expect_success 'checkout a branch under bisect' '
>  		git worktree list >actual &&
>  		grep "under-bisect.*detached HEAD" actual &&
>  		test_must_fail git worktree add new-bisect under-bisect &&
> -		! test -d new-bisect
> +		test_path_is_missing new-bisect
>  	)
>  '
>  
> @@ -1165,7 +1165,7 @@ test_expect_success '"add" not tripped up by magic worktree matching"' '
>  
>  test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
>  	git worktree add --detach ".  weird*..?.lock.lock" &&
> -	test -d .git/worktrees/---weird-.-
> +	test_path_is_dir .git/worktrees/---weird-.-
>  '
>  
>  test_expect_success '"add" should not fail because of another bad worktree' '
