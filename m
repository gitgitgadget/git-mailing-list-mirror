Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98C4502A
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773016735; cv=none; b=VUPoeGp4mCKyOxmUuXNnI5AHavgTz8jzW10/MPAMUxa57Rf0WZXyyPgHuFsVsTEtAzUYRgmx1Q/uA9ymqMRBmZ8rh/9w9pgKw+2RzwE0frqwsVcoHNDiYMG70LmWIaD8sm8NRS9xJNjrOp0vPICxW81IQq+GhuruAYgOa3CHeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773016735; c=relaxed/simple;
	bh=8UTKC5TcC4zqISXN7E6Le3MsLY9F5z1qq7npvCuF+w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MrHs/UWTi9MqjZ3oI85WD8ZuJN6NXrUBaWIS2mJMXatcHK7CgJhlk7tm3q600pThI+1VUzvM48uG3tRaFQ7gUk/lnvkBINFtsqAn9Qqe5rZOsuJM0kEh+Y2I7zGfHRcCEW7WVzW+yIZ5O9ToTPZCKnHZeaDjm4+Ns/exSGCrJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F9zQBm+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vDVYJphb; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F9zQBm+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDVYJphb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC8EE7A00FC;
	Sun,  8 Mar 2026 20:38:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 08 Mar 2026 20:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773016733; x=1773103133; bh=M9U/dltlbR
	l/geRk2sUtUqRFRMorXo7TVx7j9gwIfeE=; b=F9zQBm+OgGmipn4ALh83C6RWtX
	lc8HucKOV4AanU+8KFYKF0DymzFEbydZm3T3jMoqynHvSbNOLRnbEEzAZedgwRK9
	mqhAjMk/W+vRkwkLmOUJeQQcU74Y2L9sn9ueyxRBVYkgGUa3737msBZOkiom0rP5
	8BokqwEXgWjX0ed3O8+T9Ke3X0e0P1PHa0Q7WOQg15xPl3xUWpvHJtkssXzM6wva
	OPIw/fvvQolIGdzqeo3dtMynuJxOFQZyYhCXGz6HiMCbPdzOm4pR+Ha45ErhLB/B
	hl2O5ufz37Om93E7KXUwd2wLQB/N3g+njwA8pW4J9pldpBkqj5QJCZ9BpyKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773016733; x=1773103133; bh=M9U/dltlbRl/geRk2sUtUqRFRMorXo7TVx7
	j9gwIfeE=; b=vDVYJphb0Hgeuk/GHVK2usFMahP/UTZqhfIq2FyVG8xSz45S5iB
	1f7L5y2I1r1lEYrDwXdoDg8gSrPB0cGiwBVEa7rxJs6Q56N/wbM6rwE0L9mJesX0
	cnenBnfh/mY5Af24kd8t9dr4WwyVbO8AIajvSjGIZQBa+JlguF6AtIENXAgDhJZ0
	vALHkMgWrUU+y46+vrUi/jmf9iZsV2/fEYWQFescP1Yizs+V8Cd+MHUIXpRa160v
	GIsl0IEoc9K1QM7rYV+ssg5rNaFeHCzvitVhkvt61tMChvQvPhKtzthteKegEZ6q
	M8MEcIfox7pXsg+Ax8ddXFl2L5CeEfDDmRw==
X-ME-Sender: <xms:nRauadA6mh35y11X-WG5QVsMAQTdP1bcyDwl-8rc92Fg4pPrBcKM1w>
    <xme:nRauaS_iE3V0FTX4BbCCNJn_2RZh5h8L-aFTWbeJiq1Lmvir0_I6zb4B8e6tnmd8o
    NGazMMjVJuxC_W8LyubQm-k_175MH6MnooGowap96IFWQBg-BW_Mg>
X-ME-Received: <xmr:nRauaV-QfzDIgzOK6dmL6pdvJEFpMWUEW9ntGII8ejIuyG2ckjpt3WYI5XwXS7ZPsI5PG735EtBSKHtSBm1viXKp7rUBRdGIvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nRauaRdWZKSaYQZCZuxsAo6Tqxkf6JlL6pmh1PZ3CimQec4dQ-VbyQ>
    <xmx:nRauaWHNpt2mSBE6BpUAGeea9KHTtm9P92Rk-TvdIE_azlj1PzOmKg>
    <xmx:nRauaXcZiLpSUU01k5acdTxCcQ4w4SeEU_S2fQPrcXLcZlWHSRjg7g>
    <xmx:nRauaYHLWswKLuZ8yYVUfGldbASoywQJlMZaWnhSFKs_THlVnT8WIQ>
    <xmx:nRauacuJAj-jWF7-xu_RkawoOJTGVJQ8d_giTkUfOgQi4Y0v302bR-hC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 20:38:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sasha Levin <sashal@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] quiltimport: fix backslash expansion in patch subjects
In-Reply-To: <20260308165531.40655-1-sashal@kernel.org> (Sasha Levin's message
	of "Sun, 8 Mar 2026 12:55:31 -0400")
References: <20260308165531.40655-1-sashal@kernel.org>
Date: Sun, 08 Mar 2026 17:38:52 -0700
Message-ID: <xmqqa4wh96qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> echo interprets backslash sequences, so a patch with "\0" in its

"Some implementations of echo"; I think it is in XSI but the
plain vanilla POSIX makes it "implementation-defined".

> subject has that expanded into a NUL byte, which git commit-tree
> rejects.
>
> Use printf '%s\n' instead, which doesn't interpret the string.
>
> Also quote $tmp_dir to handle paths with spaces.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  git-quiltimport.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index eb34cda409..38302d28c9 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -79,7 +79,7 @@ tmp_info="$tmp_dir/info"
>  # Find the initial commit
>  commit=$(git rev-parse HEAD)
>  
> -mkdir $tmp_dir || exit 2
> +mkdir "$tmp_dir" || exit 2
>  while read patch_name level garbage <&3
>  do
>  	case "$patch_name" in ''|'#'*) continue;; esac
> @@ -101,7 +101,7 @@ do
>  		echo "$patch_name doesn't exist. Skipping."
>  		continue
>  	fi
> -	echo $patch_name
> +	printf '%s\n' "$patch_name"

Unquoted "$patch_name" in the original fed to "echo" is doing more
than just backslash 0.

    patch_name="My   casual patch"

would be split into three tokens, runs of multiple spaces in the
original will be squashed into one, and "My casual patch" would have
been the result, which people may have appreciated as cleaning up a
sloppy original patch title.

The updated version will give completely different result, losing
the "cleaning up" feature and parrotting the garbage input to
garbage output.

So I am not 100% convinced that this change would not result in
robbing Peter to pay Paul.

Likewise for the next hunk.

Thanks.

> @@ -142,14 +142,14 @@ do
>  	SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
>  	export GIT_AUTHOR_DATE SUBJECT
>  	if [ -z "$SUBJECT" ] ; then
> -		SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')
> +		SUBJECT=$(printf '%s' "$patch_name" | sed -e 's/.patch$//')
>  	fi
>  
>  	if [ -z "$dry_run" ] ; then
>  		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
>  		tree=$(git write-tree) &&
> -		commit=$( { echo "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
> +		commit=$( { printf '%s\n' "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
>  		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
>  	fi
>  done 3<"$QUILT_SERIES"
> -rm -rf $tmp_dir || exit 5
> +rm -rf "$tmp_dir" || exit 5
>
> base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
