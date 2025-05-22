Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467472BEC4C
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954745; cv=none; b=gNwVsn/h5MNHn4YC1mzhBV7eFlXpzkjm2SO6apgwKPgyoGOaXb+tltOcDi6QGKavd6RhFtwBAg6uZzn9Qt4j9C2GaM+YC+aZo69dj+voBEM8otQIdlg1p3eIrZ6Po+Inib1ItL33BuCAsYqWT7ozIK2hNuEjIi1XjiY32C5gnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954745; c=relaxed/simple;
	bh=YXwWyek9JtVEtR/uSkf1OGbMy1LK8NWQ0w2zvdiQjUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/+EaMBqH6xhQGtQ+LBviE+wUF6t108q1Ufy5XwKoMwYcrjFq3GIlFOAWM5qNRQl2Z07eKdq5lHa45T9xCI1/luJih5CDb3YG/N6Eikd4eerrEfV3OzuDcGjtWX/8PzqyzBkIpRO3wu9S+LN8W+7a7so0N7WP7QgUi+UBGv/IJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pw3M7fAJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKHREnhw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pw3M7fAJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKHREnhw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45FE225400E5;
	Thu, 22 May 2025 18:59:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 22 May 2025 18:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747954741; x=1748041141; bh=yfMtlCQ7He
	xzHU9WHtOl6p9M6klLyPTGsy7AU+YvXVs=; b=pw3M7fAJn59p+bBl3E0pJ1yNfg
	avL5N+kOn173LlhcuPyiop3qx6A6//p7KmszWQa804P9yWmOzWadmroioTGQvn9i
	cddNjqGSq43MtORydgx3JRtFEb/i4PoDo+Chhd7dnGy2R3CGl6kjN09q+QFpjImZ
	nftAmFuXj6BnR0Fx0HBQ15tT7A8SHX5LU4CVCGoLHTzdffa1H6QSCi5W+xIijEtx
	IbReMqooxZpWKEIF6dBHaLigW2C4C1wjxYr1I1QOEEkMk3lVXYBrB3KekfEJODHx
	yUcRXlqA+1HipzG23NYFcT7bT2MC1qYwdgFGOFaJQ/tHuYcOrZI9iIttt8Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747954741; x=1748041141; bh=yfMtlCQ7HexzHU9WHtOl6p9M6klLyPTGsy7
	AU+YvXVs=; b=kKHREnhwONr86FfZkiQ7c8utYYo8AwvW8gmKbeIiKPV0z9AFEIn
	U3TmScDbhq8VxP0dgQ/pJmyQ9SYbJzjibiVA77k/UhfTX0iMMPe+BWHpkoIBkAoM
	zJ2+irtpq4M/ry5rkTPKktG5iDCgI7IZjOdmTWHumW4g0H9MntT41MU60qKr6vwQ
	5fybiMIUSj02ibRuhQ66ACQB8RkKQ6HfKmziHF8HoyC/C8cymNpt49pHnjbXpXD1
	k2stuSeAY1GKDFNDBcVNpy5Yq8opivjRJWAV/coUycIRo8oXyL4NaP6aPY4Zm3Ft
	nEEiCncNbCOX7uAw0rjVBNyNiKUDvKOJMcA==
X-ME-Sender: <xms:NKwvaDwjj1ObIgBL3al961CZKB5VjsqjX53uHkRreuCk2EuI1dynlA>
    <xme:NKwvaLQE4PhjtUtxW5lfGKVYlzgftJEETHvBLsunhnN1ZVTFcsK4_TTbVktdJy3I_
    axvYYx_ZcFZ-zMhyg>
X-ME-Received: <xmr:NKwvaNUQ7KD46mmVIamnBXQ_QjoA8Qu4Bed4-1rym-c3W9juptU_oGz7VOv5ya9ooPBI6mbl89K1ZJNgV4rugC_NaAXdMunlwQrFr2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejvddvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrrhhksegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrghnughrrghprhgrthgrphefhe
    duleesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:NKwvaNj04RrNsEuiWFtdrRGgX5pSRFcjRy7j8loSjCC1kyuQd8a-yg>
    <xmx:NKwvaFAUk7e6_8q6XhSYs_GZaQ_x2o4qSbA5x39nO1Bv4RsJWrVrxQ>
    <xmx:NKwvaGIihuhACD1LixcN6pnbWpzYSCUsNabjaph104YBQA_rsLxgLA>
    <xmx:NKwvaEBB9qRzQGv88ntBca4OmcsuqaSXQ7nT4Zs7RH-mLRGPkA_CWA>
    <xmx:NawvaOleggt0fF4wtjUSbzxG5iZFsJUPXMmg2TQGhio2VdwpCBUhtm_c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 18:59:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] apply: set file mode when --reverse creates a deleted file
In-Reply-To: <20250522220235.8650-1-mark@chromium.org> (Mark Mentovai's
	message of "Thu, 22 May 2025 18:02:35 -0400")
References: <20250522220235.8650-1-mark@chromium.org>
Date: Thu, 22 May 2025 15:58:59 -0700
Message-ID: <xmqqtt5c1ccs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Mentovai <mark@chromium.org> writes:

> Commit 01aff0a (apply: correctly reverse patch's pre- and post-image
> mode bits; 2023-12-26) revised reverse_patches() to maintain the desired
> property that when only one of patch::old_mode and patch::new_mode is
> set, the mode will be carried in old_mode. That property is generally
> correct, with one notable notable exception: when creating a file, only
> new_mode will be set. Since reversing a deletion results in a creation,
> new_mode must be set in that case.

Very well reasoned and clearly explained.

>  		SWAP(p->new_name, p->old_name);
> -		if (p->new_mode)
> +		if (p->new_mode || p->is_delete)
>  			SWAP(p->new_mode, p->old_mode);
>  		SWAP(p->is_new, p->is_delete);
>  		SWAP(p->lines_added, p->lines_deleted);
> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index 2149ad5da44c..036613ad8fed 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -124,9 +124,124 @@ test_expect_success 'git apply respects core.fileMode' '
>  
>  	git apply patch 2>err &&
>  	test_grep ! "has type 100644, expected 100755" err &&
> +	git reset --hard &&

Interesting.

This is taking advantage of the fact that the "apply" above only
mucks with the working tree files without disturbing the index
entries, so the next "apply --cached" can do its thing cleanly.

By adding "reset --hard" here, we lose a bit of test coverage in
that "apply --cached" should not care how dirty the working tree
files are.  Because the main focus of this particular test is, as
its title states, what the filemode setting does, it is tempting to
add this "reset --hard", but unless we know that we test the same in
another test so this loss of test coverage is OK, I'd rather not to
see this change.

>  	git apply --cached patch 2>err &&
> -	test_grep ! "has type 100644, expected 100755" err
> +	test_grep ! "has type 100644, expected 100755" err &&
> +	git reset --hard
> +'

On the other hand, this "reset --hard" is necessary, as you want to
start the next test with a clean slate.

> +test_expect_success 'git apply restores file modes' '
> +	test_config core.fileMode false &&
> +	echo "This is data, do not execute!" >data.txt &&
> +	git add --chmod=+x data.txt &&
> +	git ls-files -s data.txt >ls-files-output &&
> +	test_grep "^100755" ls-files-output &&

OK, the file is executable.

> +	test_tick && git commit -m "Add data" &&
> +	git ls-tree -r HEAD data.txt >ls-tree-output &&
> +	test_grep "^100755" ls-tree-output &&

Again, the file is executable.

> +	git checkout -- data.txt &&

This should be a no-op, right?  What are we testing here?

> +	git add --chmod=-x data.txt &&

Now we drop the executable bit.

> +	git ls-files -s data.txt >ls-files-output &&
> +	test_grep "^100644" ls-files-output &&
> +	test_tick && git commit -m "Make data non-executable" &&
> +	git ls-tree -r HEAD data.txt >ls-tree-output &&
> +	test_grep "^100644" ls-tree-output &&

And do the same.

> +	git checkout -- data.txt &&

Ditto.  This does not seem to be "we make sure checkout would not
barf when asked to checkout data.txt", and it also does not seem to
be "now we have made data.txt dirty, we need to check it out of the
index".

> +	git rm data.txt &&
> +	git ls-files -s data.txt >ls-files-output &&
> +	test_must_be_empty ls-files-output &&

OK.  We removed, so it is gone.

> +	test_tick && git commit -m "Remove data" &&
> +	git ls-tree -r HEAD data.txt >ls-tree-output &&
> +	test_must_be_empty ls-tree-output &&

Same.

At this point, 

	HEAD~0 is "remove data.txt"
	HEAD~1 is "chmod -x data.txt"
	HEAD~2 is "create data.txt that is executable"

Hence

> +	git format-patch HEAD~3..HEAD~2 --stdout >patch &&

Always follow the "command --dashed-options... revisions... other args"
ordering, i.e.

	git format-patch --stdout HEAD~3..HEAD~2 >patch &&

Anyway, we now have a patch to create an executable data.txt.

> +	test_grep "^new file mode 100755$" patch &&
> +	git apply --index patch &&
> +	git ls-files -s data.txt >ls-files-output &&
> +	test_grep "^100755" ls-files-output &&
> +	test_tick && git commit -m "Re-add data" &&
> +	git ls-tree -r HEAD data.txt >ls-tree-output &&
> +	test_grep "^100755" ls-tree-output &&

OK, a patch to create an executable file does create an executable
file.

> +	git format-patch HEAD~3..HEAD~2 --stdout >patch &&

Now the HEAD~<n> has shifted, this gives us "chmod -x" patch.
One suggestion.  Perhaps you'd want to grab the necessary set of
patches all much earlier, around the point where I said "At ths
point" above?  With something like

	git format-patch -o patches -3 HEAD &&
	mv patches/0001-* 0001-create-executable.patch &&
	mv patches/0002-* 0002-chmod-x.patch &&
	mv patches/0003-* 0003-remove.patch &&

and then consume them using the name we explicitly gave, e.g.

	git apply --index 0001-create-executable.patch &&

> +	test_grep "^old mode 100755$" patch &&
> +	test_grep "^new mode 100644$" patch &&
> +	git apply --index patch 2>err &&
> +	test_grep ! "has type 100644, expected 100755" err &&
> +	git ls-files -s data.txt >ls-files-output &&
> +	test_grep "^100644" ls-files-output &&
> +	test_tick && git commit -m "Redo data mode change" &&
> +	git ls-tree -r HEAD data.txt >ls-tree-output &&
> +	test_grep "^100644" ls-tree-output &&

OK.

> +	git format-patch HEAD~3..HEAD~2 --stdout >patch &&

This one to remove.

> +	test_grep "^deleted file mode 100644$" patch &&
> +	git apply --index patch 2>err &&
> +	test_grep ! "has type 100755, expected 100644" err &&
> +	git ls-files -s data.txt >ls-files-output &&
> +	test_must_be_empty ls-files-output &&
> +	test_tick && git commit -m "Redo data removal" &&
> +	git ls-tree -r HEAD tool.sh >ls-tree-output &&
> +	test_must_be_empty ls-tree-output

All expected.

> +'
> +
> +test_expect_success 'git apply --reverse restores file modes' '
> +	test_config core.fileMode false &&
> +	echo true >tool.sh &&

I we took the above approach to prepare patches in separate files,
we do not have to set up a different scenario completely anew.
Instead, we can start from a state where data.txt is missing, and
then reverse-apply the remove patch we used in the previous test
first (and make sure the mode is without executable bit), then
reverse-apply the chmod-x patch (and make sure the file is now
executable), and then reverse-apply the creatoin patch (to ensure it
is gone).

Thanks.

> +	git add --chmod=-x tool.sh &&
> +	git ls-files -s tool.sh >ls-files-output &&
> +	test_grep "^100644" ls-files-output &&
> +	test_tick && git commit -m "Add tool" &&
> +	git ls-tree -r HEAD tool.sh >ls-tree-output &&
> +	test_grep "^100644" ls-tree-output &&
> +
> +	git add --chmod=+x tool.sh &&
> +	git ls-files -s tool.sh >ls-files-output &&
> +	test_grep "^100755" ls-files-output &&
> +	test_tick && git commit -m "Make tool executable" &&
> +	git ls-tree -r HEAD tool.sh >ls-tree-output &&
> +	test_grep "^100755" ls-tree-output &&
> +	git checkout -- tool.sh &&
> +
> +	git rm tool.sh &&
> +	git ls-files -s tool.sh >ls-files-output &&
> +	test_must_be_empty ls-files-output &&
> +	test_tick && git commit -m "Remove tool" &&
> +	git ls-tree -r HEAD tool.sh >ls-tree-output &&
> +	test_must_be_empty ls-tree-output &&
> +
> +	git format-patch -1 --stdout >patch &&
> +	test_grep "^deleted file mode 100755$" patch &&
> +	git apply --index --reverse patch &&
> +	git ls-files -s tool.sh >ls-files-output &&
> +	test_grep "^100755" ls-files-output &&
> +	test_tick && git commit -m "Undo tool removal" &&
> +	git ls-tree -r HEAD tool.sh >ls-tree-output &&
> +	test_grep "^100755" ls-tree-output &&
> +
> +	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
> +	test_grep "^old mode 100644$" patch &&
> +	test_grep "^new mode 100755$" patch &&
> +	git apply --index --reverse patch 2>err &&
> +	test_grep ! "has type 100644, expected 100755" err &&
> +	git ls-files -s tool.sh >ls-files-output &&
> +	test_grep "^100644" ls-files-output &&
> +	test_tick && git commit -m "Undo tool mode change" &&
> +	git ls-tree -r HEAD tool.sh >ls-tree-output &&
> +	test_grep "^100644" ls-tree-output &&
> +
> +	git format-patch HEAD~5..HEAD~4 --stdout >patch &&
> +	test_grep "^new file mode 100644$" patch &&
> +	git apply --index --reverse patch 2>err &&
> +	test_grep ! "has type 100755, expected 100644" err &&
> +	git ls-files -s tool.sh >ls-files-output &&
> +	test_must_be_empty ls-files-output &&
> +	test_tick && git commit -m "Undo tool addition" &&
> +	git ls-tree -r HEAD tool.sh >ls-tree-output &&
> +	test_must_be_empty ls-tree-output
>  '
>  
>  test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
