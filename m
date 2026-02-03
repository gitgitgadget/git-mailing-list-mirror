Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103362F1FEA
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140262; cv=none; b=Z1ZS90BiSigjHAw1E8arqt+3myXaZ8QJp/Gehvw33Bc2zFbd1U05EIBe5M1pzJ2BdmxiMpf4q8RaHxIzOlLi2E4WStq54502j3LoKSIwdRsxufHe32p14vpDG0riJbNxlohi0D1ovi0avZzT9iDcvxuUZREsAGBeJcXKjb+5ezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140262; c=relaxed/simple;
	bh=ET/H91DEzQ4haSg/4yxNeQM+eThoGgtQulKYB27pMRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8g4/qyVULxpJkBK/NJ2u6McaL1JpSgeObVm+YSCb/yUoxVi67AqsQfyo0vmV9N2HcluVI3JVgsux3wkFW8jHx6XKoW6uAxsnPlGpOSypVRtAOZD54CceGIDj2BOA/LbFOTESuIaGxtnnjqfCezidwdYSq00iWVkZQJ+C7dcB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ts9WRflz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U8KQa+RB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ts9WRflz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8KQa+RB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B9647A0170;
	Tue,  3 Feb 2026 12:37:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 03 Feb 2026 12:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770140260; x=1770226660; bh=j6/8qRJQG3
	Rn0QEbnSSYfgUEl4d5TfkqYg4SXqhT5UU=; b=ts9WRflzg3fi5aVA5rt1WqxvKk
	e+zjVFdg3JtwEUP57Ep0ErQjMlj+QMC3Di6UL7fXAUO9AUHIsmuBPYKaOMGBCkdf
	2lc8DOooYlm5Bn77Q8uREYugeqzUepyLstXe/HLw0tm7nAMb/JkHJZPT69VrdEZP
	DsBUCkIagckWYApdU5dJcUBF9Ed9i3qvb6CZ8H/h5YtXN34ea3tMorgNQKfi6uLm
	dKLXCsw7DvMRDRmyTShwxur39HRoV/ZeeIA/oM8H6RVR4dnCbLEOqBWkXzO1msoK
	NocIAgbvG39kjbrYz0VqIxFjXJksvW5yAyk/ghex21b8MmDYpPLMmsF3xO3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770140260; x=1770226660; bh=j6/8qRJQG3Rn0QEbnSSYfgUEl4d5TfkqYg4
	SXqhT5UU=; b=U8KQa+RBrRIb2hJ5TS4V7PGe4hEzKknxPGko2sdWCDcA3WlOwR9
	P2UxsBOU9vk8rkC4//CabLjRcOa22oJ6YKuy28cFYEfE9fmfqPfsPnmwrhLhlJJH
	uVSMSIVPxVAJb3QGgyLlNh5NoxmhgEs3uWeehYJepb2AAuqghLaBqGHypPgfczAx
	cBRszxFbOm0pxIRKeAAffjjaHR/EjQ9BLAdTcDnTKmna9HrxTqKhdCrz3PXrxzrt
	LmTAWIBncxLC+FBK1uS6oJMQie7dAcVISTwa7x2IhFD8HCOugSRd4PhrcxUwTTJc
	fMHarr/lRze+2/J3AmnSDA8WagClgdtjVNQ==
X-ME-Sender: <xms:ZDKCabWimG8qc5FWbM-EfOjP_KOfVB4Fkc_sls9YkcMz-u2FuZb2pg>
    <xme:ZDKCabDc2UzisWPl7YkEzwrZy_kAyXsl6ChMPleAevh41lR6BwRttNQZqSV4CL7tB
    qQYAsurwjF2_YyJJ9aA1PSHYmcLiGXY5JApwsekdchsouOULwbVtrw>
X-ME-Received: <xmr:ZDKCaUwfx7tt-EaGhjZr_O8UUW1TuArtnuvNNPcrQpmqbQwiJrOkhUOMWuL9BUxs9xUaf6zB4CmW8yM52gQduHsuBkJp0hL4UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtd
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZDKCaQAfwYRvbKZSigZpRc_MSjAuQyWYNYAE2EDhWe78gH7QxuuhCg>
    <xmx:ZDKCaZaudQaB_nrKIgLEnzvUhSfuvUKOcyM5Tfazug1OBpG5SsRrIg>
    <xmx:ZDKCaQibz4tPLZAF9zUpxcg_L54sll1L1k0hS31CqxGxw3TRD2mEpg>
    <xmx:ZDKCaT484VVPmXzaXiIzzYQCAlUHqKC4X-wYxCP2TR9FPKjafFI36g>
    <xmx:ZDKCafBCiNSsP_pqKIWnTTLkV6MCZG-Cqxdd2XPjOuT9DD0r3XWb2yP7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 12:37:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] subtree: validate --prefix against commit in split
In-Reply-To: <20260203164815.68258-2-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Tue, 3 Feb 2026 16:48:16 +0000")
References: <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<20260203164815.68258-2-pushkarkumarsingh1970@gmail.com>
Date: Tue, 03 Feb 2026 09:37:38 -0800
Message-ID: <xmqqecn1u3rx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> Changes since v3:
> - Fix regression in existing subtree tests by checking prefix existence
>   with git cat-file instead of git ls-tree -d

OK, the check used to run

    git ls-tree -d "$rev" -- "$dir"

which (if I am reading this correctly) succeeded only when "$dir" is
an existing directory in "$rev".  Now you use

    git cat-file -e "$rev:$dir" 2>/dev/null

and this allows "$dir" to be a non-directory but say a blob.

> - Preserve original error message to keep test 17 passing

Ahh, OK.  I didn't check how the test was failing.  This message is
made to look like the error message we used to get much earlier
before calling cmd_split, and now cmd_split detects the condition to
give the error message, so it is better to match it.  Makes sense.

>  contrib/subtree/git-subtree.sh     |  9 +++++++++
>  contrib/subtree/t/t7900-subtree.sh | 22 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 17106d1a72..d7f9121f2f 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -257,6 +257,9 @@ main () {
>  		test -e "$arg_prefix" &&
>  			die "fatal: prefix '$arg_prefix' already exists."
>  		;;
> +	split)
> +		# checked later against the commit, not the working tree
> +		;;
>  	*)
>  		test -e "$arg_prefix" ||
>  			die "fatal: '$arg_prefix' does not exist; use 'git subtree add'"
> @@ -966,6 +969,12 @@ cmd_split () {
>  	else
>  		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
>  	fi
> +
> +	# Now validate prefix against the commit, not the working tree
> +	if ! git cat-file -e "$rev:$dir" 2>/dev/null
> +	then
> +		die "fatal: '$dir' does not exist; use 'git subtree add'"
> +	fi
>  	repository=""
>  	if test "$#" = 2
>  	then
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 316dc5269e..e4f632f3af 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -368,6 +368,28 @@ test_expect_success 'split requires path given by option --prefix must exist' '
>  	)
>  '
>  
> +test_expect_success 'split works when prefix exists in commit but not in working tree' '
> +	subtree_test_create_repo "$test_count" &&
> +	(
> +		cd "$test_count" &&
> +
> +		# create subtree
> +		mkdir pkg &&
> +		echo ok >pkg/file &&
> +		git add pkg &&
> +		git commit -m "add pkg" &&
> +		good=$(git rev-parse HEAD) &&
> +
> +		# remove it from working tree in later commit
> +		git rm -r pkg &&
> +		git commit -m "remove pkg" &&
> +
> +		# must still be able to split using the old commit
> +		git subtree split --prefix=pkg "$good" >out &&
> +		test -s out
> +	)
> +'
> +
>  test_expect_success 'split rejects flags for add' '
>  	subtree_test_create_repo "$test_count" &&
>  	subtree_test_create_repo "$test_count/sub proj" &&
