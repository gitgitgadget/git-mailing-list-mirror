Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561852F6582
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058826; cv=none; b=foo7lcDQpsyl6RUTLz7tGRUUGjMnEdcTRPefZUtuSSWC9qU+NIw16/KE8z7sp9F0otNEF6SQdK5McrFaSYgMOBf1o7KlIa3zBh1ZC+9coAK7KBKCZ7oD0k8k1sb/S35zFv/i2oXU/H+Y86x8+M6ULZ9GWzz/bVZZPwQxZZ11reU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058826; c=relaxed/simple;
	bh=akMAKRKBh6pla5sKw3o8UEfF3FsKtyJkA5TYlug/eqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f8eHluzETAbq98zV645bc49dbDNhv/YH0mlxhr6CX3PEjV/IAYc3Q2hHrlRJoTv/WStSkMgQ6ISyXvyHb+Z4GUYxLoFUIwnFWgFVMPYAQ0usjgvs6ZcwdwCn6UiXvdp0Et/Hw/Pc1WUI3yXiOr/6DnV/zOalWtxHcpXsATpgIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JxY7Vsh9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KzxoSzvh; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JxY7Vsh9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KzxoSzvh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DB051D0005A;
	Mon,  2 Feb 2026 14:00:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 14:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770058823;
	 x=1770145223; bh=gwkz/BhzPEHMwQB7rW39wwzYmc/A28eOFQ3KkKHh9cE=; b=
	JxY7Vsh9BZiTIWFeHwYUsdQqvOTLf+vNch+BFeoLfrfMXzxQ+CSL+m9TvOZ0s3za
	fEL1IYsQ6R374M4dLqm/iWjw5+chW0wI1viN3x0mjBYX1iz8nt167IPzA4sk5awi
	e5P86pFocuDr48OJ56gE9xWs+2r/VTcPjWGCi22De/7QMj5PGmX9UTuwJgz2cFiL
	8yAZTYPR+J5QqsyqLRbxB7V3qSgYsfDjj3oa32FdtbrJojrMdkp4dKD0NQkoO92D
	S8hzLDK+WqIAVB4K7YvRH/JRQP8+1aD1kwsBBKqX+oPgTYk262OxUIgbNHetwZnX
	m8kOSNIl12WtOrFnNwF6UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770058823; x=
	1770145223; bh=gwkz/BhzPEHMwQB7rW39wwzYmc/A28eOFQ3KkKHh9cE=; b=K
	zxoSzvhZlmQyEl6Px6VfsRvXP67pcVkHQIvnL0F/nnJQb4/rXPQEVdT80WXtMM1J
	MO/YsoKrNP/3sWMZSO6l7I1SDDR+Zj6bmGFcfntck/qU61eUbETcf4qrreLU9ctN
	NsJBpqsgnChpdboFRfu0swbuTyBSNPEbdNPBeL3G2+Aett27uVgZLK+mj1LKD8I9
	EePqW5kXsz4ej8qH7+93eIpblUqInzBhaZsQXlyQy/A6UvH6mDIxMv4nZzTz/r6c
	RpmDl91V6vSQYAy61ekZv01lNgBa4Bua0lFJoEaHg2ru9QUUqymmfVj/Jzpx4nNa
	5Rpzw+qFRmfKqUBuaFsDQ==
X-ME-Sender: <xms:R_SAaWyWBtc84yGIaU3axui8okdxthxtawKXrvQ-z9QVDgkW7DqhFg>
    <xme:R_SAaZsLVX4QF6jLlOl_0x7WR1UfeXkpVLPPhvOEpo7hH1oTWDpQGQ2imkorDUqDf
    qepEqqANgAndypJh3tkeC7QwVqPS73ALBOucYnHHDDzikp0Y4riPBc>
X-ME-Received: <xmr:R_SAaVs7BYQwIoDm08aEiuI7_Y9DIeKHbyS6-q30Lryw8e_hYui4DqF_O0o8UV1KCbuRIpmo_6uRESlMpmZjhcL7wDl0iov3qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhohgurgdrshdrshgrlhhimhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R_SAaWOLPHTWM3g48OiliKUSRqN3lnKYfk4T4BUME8ja5RlbsqoApw>
    <xmx:R_SAab3Gp6bXB6IVuUluZnZYZDONdxUrbBcWSAs-DIj8uDCw8RnX2A>
    <xmx:R_SAaaPtytjTx4i0p5K-etkufb35h0_AfXsihoJCyEYq7YAcUS_RcA>
    <xmx:R_SAaT2q_nk7AXvYRX0pXqm59-y7TKIBIKLJdEHgarjuKNaNVpQNYA>
    <xmx:R_SAaZslcAZeW4oLBvwyg_DFFN8NvygIID6DtFE_mmDctP9CnY-hhQde>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:00:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hoda Salim <hoda.s.salim@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2][GSoC] t9160:modernize test path checking
In-Reply-To: <20260202161759.84355-2-hoda.s.salim@gmail.com> (Hoda Salim's
	message of "Mon, 2 Feb 2026 18:18:00 +0200")
References: <pull.2160.git.git.1767625195071.gitgitgadget@gmail.com>
	<20260202161759.84355-2-hoda.s.salim@gmail.com>
Date: Mon, 02 Feb 2026 11:00:21 -0800
Message-ID: <xmqq5x8fynqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hoda Salim <hoda.s.salim@gmail.com> writes:

> From: HodaSalim <hoda.s.salim@gmail.com>
>
> Replace old-style path checks with Git's dedicated test helpers:
> - test -f → test_path_is_file
> - test -d → test_path_is_dir
> - test -s → test_file_not_empty
>
> Fix typos with the word "subsequent"
>
> Found using: git grep "test -[efd]" t/
>
> This improves test readability and provides better error messages
> when path checks fail.

For a small change like this, the above is sufficient as all the
necessary things are described, but for future reference, we prefer
to explain things in this order:

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

You are going backwards ;-).

Will queue.  Thanks (and thanks for all the reviewers who helped
polish the draft to get to this v2).


>
> Signed-off-by: HodaSalim <hoda.s.salim@gmail.com>
> ---
>  t/t9160-git-svn-preserve-empty-dirs.sh | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
> index 36c6b1a12f..de32cf2542 100755
> --- a/t/t9160-git-svn-preserve-empty-dirs.sh
> +++ b/t/t9160-git-svn-preserve-empty-dirs.sh
> @@ -61,15 +61,15 @@ test_expect_success 'clone svn repo with --preserve-empty-dirs' '
>  
>  # "$GIT_REPO"/1 should only contain the placeholder file.
>  test_expect_success 'directory empty from inception' '
> -	test -f "$GIT_REPO"/1/.gitignore &&
> +	test_path_is_file "$GIT_REPO"/1/.gitignore &&
>  	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1"
>  '
>  
>  # "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder file.
>  test_expect_success 'directory empty from subsequent svn commit' '
> -	test -f "$GIT_REPO"/2/.gitignore &&
> +	test_path_is_file "$GIT_REPO"/2/.gitignore &&
>  	test $(find "$GIT_REPO"/2 -type f | wc -l) = "1" &&
> -	test -f "$GIT_REPO"/3/.gitignore &&
> +	test_path_is_file "$GIT_REPO"/3/.gitignore &&
>  	test $(find "$GIT_REPO"/3 -type f | wc -l) = "1"
>  '
>  
> @@ -77,7 +77,7 @@ test_expect_success 'directory empty from subsequent svn commit' '
>  # generated for every sub-directory at some point in the repo's history.
>  test_expect_success 'add entry to previously empty directory' '
>  	test $(find "$GIT_REPO"/4 -type f | wc -l) = "1" &&
> -	test -f "$GIT_REPO"/4/a/b/c/foo
> +	test_path_is_file "$GIT_REPO"/4/a/b/c/foo
>  '
>  
>  # The HEAD~2 commit should not have introduced .gitignore placeholder files.
> @@ -102,14 +102,14 @@ test_expect_success 'clone svn repo with --placeholder-file specified' '
>  
>  # "$GIT_REPO"/5/.placeholder should be a file, and non-empty.
>  test_expect_success 'placeholder namespace conflict with file' '
> -	test -s "$GIT_REPO"/5/.placeholder
> +	test_file_not_empty "$GIT_REPO"/5/.placeholder
>  '
>  
>  # "$GIT_REPO"/6/.placeholder should be a directory, and the "$GIT_REPO"/6 tree
>  # should only contain one file: the placeholder.
>  test_expect_success 'placeholder namespace conflict with directory' '
> -	test -d "$GIT_REPO"/6/.placeholder &&
> -	test -f "$GIT_REPO"/6/.placeholder/.placeholder &&
> +	test_path_is_dir "$GIT_REPO"/6/.placeholder &&
> +	test_path_is_file "$GIT_REPO"/6/.placeholder/.placeholder &&
>  	test $(find "$GIT_REPO"/6 -type f | wc -l) = "1"
>  '
>  
> @@ -133,19 +133,19 @@ test_expect_success 'second set of svn commits and rebase' '
>  
>  # Check that --preserve-empty-dirs and --placeholder-file flag state
>  # stays persistent over multiple invocations.
> -test_expect_success 'flag persistence during subsqeuent rebase' '
> -	test -f "$GIT_REPO"/7/.placeholder &&
> +test_expect_success 'flag persistence during subsequent rebase' '
> +	test_path_is_file "$GIT_REPO"/7/.placeholder &&
>  	test $(find "$GIT_REPO"/7 -type f | wc -l) = "1"
>  '
>  
>  # Check that placeholder files are properly removed when unnecessary,
>  # even across multiple invocations.
> -test_expect_success 'placeholder list persistence during subsqeuent rebase' '
> -	test -f "$GIT_REPO"/1/file1.txt &&
> +test_expect_success 'placeholder list persistence during subsequent rebase' '
> +	test_path_is_file "$GIT_REPO"/1/file1.txt &&
>  	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1" &&
>  
> -	test -f "$GIT_REPO"/5/file1.txt &&
> -	test -f "$GIT_REPO"/5/.placeholder &&
> +	test_path_is_file "$GIT_REPO"/5/file1.txt &&
> +	test_path_is_file "$GIT_REPO"/5/.placeholder &&
>  	test $(find "$GIT_REPO"/5 -type f | wc -l) = "2"
>  '
