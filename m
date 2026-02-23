Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220130AD0A
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863137; cv=none; b=dQpJzjN9DjFwixU5sau88/yBUfMfILL33P7PO/BoX/26R025HK4CkVgSr+K/5fhE1dce7PzQIuJ0/0+f0dZGx+utkRCOtxwWeegRrMZ7CwUsZIvU1SofH438HSt1AUF86YjDUf0ZRgC6yJbDPATY2D2uKenQhyBXf+WkemAFRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863137; c=relaxed/simple;
	bh=wju/+SNaX1ePj61P4GCtDMHJkMY1e52WDrOKv0Y6Gfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4qZhoetlcK7p+uXUX5/i4MumlW9eXoO3vzfk8iJjRNNHM83huJEJpD50qGdT2hBd1Ip6e5sUA3B1JX3duuMuVEnDqxsvBaJ9jNmWfKHt4ifLxWLC7RBiBw0fOSR7KW5DLZeMmU1jHHfSjF/PaT6rhHyCdj8Q9CODvdvJk4HVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V1nweXGa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/n4He5P; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V1nweXGa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/n4He5P"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22BC414001B9;
	Mon, 23 Feb 2026 11:12:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 23 Feb 2026 11:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771863135; x=1771949535; bh=MBjyOsbaDl
	7iQiQJpyu04W8ebkRG+GiTT5/T9G0UGaY=; b=V1nweXGabipSCQ+EtCPyd5J3tL
	CO8d1ZMdrsqUecaOVuzVO9rlXfh2+xzvzXf5rT8jnYP0EeXtOYa2YA+zHkkgQ7fd
	MJ9XoKYhypb2nKvjQmz5QqR9e8PXSqxNKO3BRuXcGrD0ibfn51xoMBPeJE4oNAgr
	C6oMg+0aRdzq5dAt/WuGRjZFmF2xU8dqtqv0PlKJe5ZYpxylZ3mdObFFJjzUog0E
	q8QSLeTqd1BOJ5EXj1a7C0dY/D83QY+oi20KPu+6sdTRvILRmvBlfDDgRZlI/KVK
	SB/QDPduRW+57LmJiVMsY2phdxm2d0AhWJW3PaRjfNjc/hoHBCZ+PvqiIgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771863135; x=1771949535; bh=MBjyOsbaDl7iQiQJpyu04W8ebkRG+GiTT5/
	T9G0UGaY=; b=S/n4He5P17ppfZyr+0ctTTiMXigRZlc4GqXoM46obsEg1DtOQv6
	a01or2MDnMVU9jZPekQHGyZmlyc53agLOwInH1v0HuNX9tJY3QnnY+C3EXDgmwkK
	JGQOqTiuVvfiEfNmFgCKKQpxmSMl2xuMbnIKv6NRZp1WBkEsgsgbrXDEFmqkoCSm
	pEfwLHzy7HbBOKc6rFhR2kpxs0ynAMPRbcwt9l1v4Gj074ktzgO3TC9ADw1bnmha
	UR0Gw5r5k+iEKKiwP3y9FmDbDsi9+bBi9ynwpgfG+kDuMsF/XeDB/3hAv9zKnI+i
	/ZDeVRhH/E4lmeh0KYy/jxdhqmUwORjBqLA==
X-ME-Sender: <xms:X3ycad4G6hPfOEG1bf9hGP_n-Uh815qZCqCs23-AmOXEh_FuyP7svQ>
    <xme:X3ycaemh6Yxnqeo4K1bi04Z5PAAyt4K3mq0bvozYfL46xEdMrENOj1RBPKBqEZOdM
    JqxOlIbeu5FZNbkNCYQ6huesFkT2DNjoP8Pti_V4MRbk67u-1MipA>
X-ME-Received: <xmr:X3ycaeSggICEvWoS7aFvzsBUgwUa8K6VUNSzQICjN2SISKYElvtZsOrkETZtKsNcx6k0Gy0PenKrnGUScSHhpfDg3hWaZo1lTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgufhgvrhguohhushgrlhgrmhdule
    ekleeshigrhhhoohdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X3ycadHIbjWZF0iRs_INBOgDP74epHZ73LLWKVMwl6H56t0mWrbwew>
    <xmx:X3ycaTEWuQ1Hj1eTJ6jWvGcWq1iGYUB7k2Oze2L6TiGZTb7D1ga83Q>
    <xmx:X3ycabSXGqQ2Ab4OYbwZUMK8RRazAo8sgSbLboikx431Rln_tXBl7A>
    <xmx:X3ycaULGlsOnkvWJwcGpH01KcQxC4AyHe4TRlK_Zsjfst3adrMiUwA>
    <xmx:X3ycaS3wKmUbf9PusjmHlnIDB2OfFrAE-11MEAmyxVyXGRvxKgGp_5hU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:12:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Md Ferdous Alam <mdferdousalam1989@yahoo.com>,
    Elijah Newren <newren@gmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t2018: move checkout case-insensitive test from t0050
In-Reply-To: <pull.2054.git.1771837399472.gitgitgadget@gmail.com> (Md Ferdous
	Alam via GitGitGadget's message of "Mon, 23 Feb 2026 09:03:19 +0000")
References: <pull.2054.git.1771837399472.gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 08:12:13 -0800
Message-ID: <xmqqjyw3o2w2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com> writes:

Adding CC the authors of 69f272b9 (dir: special case check for the
possibility that pathspec is NULL, 2019-10-01) and 06d53148 (t[01]*:
adjust the references to the default branch name "main", 2020-11-18)
the block of lines removed by this patch are blamed for.

One thing that I noticed that needs checking but I didn't do so
myself is that the original is prepared not to break after Git 3.0
by using 'main' in t0050 (which forces the initial branch name to be
'main').  Whereever the corresponding new code goes, there needs a
similar provision to prevent the test from getting broken with the
default change.

I think specifying the initial branch name explicitly when the test
creates "repo-case" test repository and use that to go back to that
branch would be better for the purpose of this single test, rather
than using the blanket "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" for
the entire script.


> From: mdferdousalam <mdferdousalam1989@yahoo.com>
>
> The test 'checkout with no pathspec and a case insensitive fs' in
> t0050 does not really belong there as it tests branch checkout
> behavior, not filesystem properties.  It also had an unnecessary
> CASE_INSENSITIVE_FS prereq since the sequence of commands should
> succeed on any filesystem, and it did not verify the resulting
> worktree contents.
>
> Move it to t2018-checkout-branch.sh where it belongs, drop the
> prereq, and add a check that the expected file is present after
> the checkout.
>
> Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>
> ---
>     t2018: move checkout case-insensitive test from t0050
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2054%2Fmdferdousalam%2Fmove-checkout-test-from-t0050-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2054/mdferdousalam/move-checkout-test-from-t0050-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2054
>
>  t/t0050-filesystem.sh      | 20 --------------------
>  t/t2018-checkout-branch.sh | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index ca8568067d..003329c082 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -117,24 +117,4 @@ $test_unicode 'merge (silent unicode normalization)' '
>  	git merge topic
>  '
>  
> -test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
> -	git init repo &&
> -	(
> -		cd repo &&
> -
> -		>Gitweb &&
> -		git add Gitweb &&
> -		git commit -m "add Gitweb" &&
> -
> -		git checkout --orphan todo &&
> -		git reset --hard &&
> -		mkdir -p gitweb/subdir &&
> -		>gitweb/subdir/file &&
> -		git add gitweb &&
> -		git commit -m "add gitweb/subdir/file" &&
> -
> -		git checkout main
> -	)
> -'
> -
>  test_done
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index a48ebdbf4d..5f37e40591 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -285,4 +285,25 @@ test_expect_success 'checkout -b rejects an extra path argument' '
>  	test_grep "Cannot update paths and switch to branch" err
>  '
>  
> +test_expect_success 'checkout a branch when file and directory share case-insensitive name' '
> +	git init repo-case &&
> +	(
> +		cd repo-case &&
> +
> +		>Gitweb &&
> +		git add Gitweb &&
> +		git commit -m "add Gitweb" &&
> +
> +		git checkout --orphan other &&
> +		git reset --hard &&
> +		mkdir -p gitweb/subdir &&
> +		>gitweb/subdir/file &&
> +		git add gitweb &&
> +		git commit -m "add gitweb/subdir/file" &&
> +
> +		git checkout master &&
> +		test_path_is_file Gitweb
> +	)
> +'
> +
>  test_done
>
> base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
