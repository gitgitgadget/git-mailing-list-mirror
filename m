Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105AC2F2
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732239; cv=none; b=rYWFAYLIwdkU7beH5b16z1imGf8l52ZNBSEABXfCnxEaWl9UC8bvd4B9JxmzP6EkqcNbMF3aAHUasSbur1vo68ayOpTyeczWZJpZbJBPA+WOKgnnXQlsiPYxznDWQcdvtujDacrwVpHUt90l2sHcoIJlQeoVF/0VZSxxC6Y7n4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732239; c=relaxed/simple;
	bh=e8ETbdb4xjXjnR5LhQ6AWN3UhK0wvqYXKgdrF50e6RA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DLlFGkP5yYG71G4MhfYSw7Xxw9RGYrXEWpjGO4PLTdIMC2JCIP38LJjZ3sJsJ8a441YXEKCgqmyM1c/idGKcs8eTWzMurFjJubU5WV4n403I4q7EUjMxguy9UaliHZTI49IGiNywDOXKdSJjiMEQscisvJBBR9a9QNDnH5OCBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bbO2gneG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pWSo5cHv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bbO2gneG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWSo5cHv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 927A0254016F;
	Tue, 15 Apr 2025 11:50:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 15 Apr 2025 11:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744732236; x=1744818636; bh=KHumjqQ4oa
	4HpA7+E1TDNFocrJOFbG4PtnmWRp+f8mI=; b=bbO2gneG7vA7JFSTVGa5MN8gOy
	CT43TNQoSFCk5JXyQ9MPaKxs0H8Wk8vX0SMNvDI0i284/PVuQmetsFf2znWa/E5l
	EAJZhu8H0RLc0FiydwUEGQGa09EMZF9VgGvPqgYdyZChTzke+HqjxFXJNb3OL9bE
	uUwEZxh0ydtiXp3B8C6c27ngHdWg90bHYNPw7dMneSDGp4l0b8sA9pUtLb+Upfp9
	VcRQCLq3fPQg5Rg16tbZ6kvcua5g9O9lg4YX/7SzU5Qh1zMYSGhSek3nJCK0Fdr0
	r1aMbaQ41lthUWqzljmRjcSVVy8obl2vXm1o2dnmu9mHSVl4mKSqR2T0HZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744732236; x=1744818636; bh=KHumjqQ4oa4HpA7+E1TDNFocrJOFbG4Ptnm
	WRp+f8mI=; b=pWSo5cHvkiAhSQcjR0t3rkPidexHHMHYHH2DoQ3GY9r0AvjxMzx
	p0TcltpBWio6ZP0EHqyfY52FU9fOa+CLiBsJhw9s9AhnOhpH9ck1U1ob1rwrAVJ3
	uU09Gp64FVlRKYrB7JpShD/sF4UNfwHH7wsGDu55VOYiS/wzVF7IgmBExzivwfi9
	CT2USjI2s0UNKnPXCXt9RfzLn9ijUlJnuPn7iQVEmwyVMZfLfg7XzPdnFzWEUP/O
	6MhH3XyrB5DJRC6CAlDDoLKxStU9AWG99Wvu3CkwOomADnWX3RezlCOL7FQ4ozSd
	UnDWYHggxtqUbInQQQLsmnUwLmr1GJlRbqg==
X-ME-Sender: <xms:TID-Z4D1Y3mG1iLEYNUI7IXCI6eUFO2XZc6-qXyHn9IgH-sTdZ4UJg>
    <xme:TID-Z6ijFhhUft6ajA7xvHEYdUMO4NYLJ2HMyNHWfHU3POIDriDqBPIonocsoS5UX
    1CC7pXaFjkx-gYu2A>
X-ME-Received: <xmr:TID-Z7n27B6VWSB9abOzu-fhgvtYKdou3UCURC_onQjLWMIAg3dRkE5ynVkoI-emBIDWrcSWwZVscXJbRFm5c4U7-_7aaAbRF8WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TID-Z-yu_jXgKkACYq-Lt-wBzawEfpZbLwr6yKewrOxBv0Tn6qRB1g>
    <xmx:TID-Z9RGbPTSSTIAeF1tKdpJhYn5MG1SZkHxQV9YEtAFsIkRhq5Mcw>
    <xmx:TID-Z5Y8E_5AWbv339MdstyqXn6hWXsnXbgmUMDNo-NxF7W41uxOrg>
    <xmx:TID-Z2QhhdeebNAcrcTEaLPeGelbzrzBOxJaOJSQeoCRxj4_OrfPOw>
    <xmx:TID-Z4m5jE-7QCqN1LpdEsT0jDtAD1QsMGY79gKf_OWTJlv8hq0V_4uR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 11:50:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] filter-branch: stop depending on Perl
In-Reply-To: <20250415-b4-pks-drop-perl-v1-1-c6addf175858@pks.im> (Patrick
	Steinhardt's message of "Tue, 15 Apr 2025 11:57:08 +0200")
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
	<20250415-b4-pks-drop-perl-v1-1-c6addf175858@pks.im>
Date: Tue, 15 Apr 2025 08:50:34 -0700
Message-ID: <xmqq1ptto245.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While git-filter-branch(1) is written as a shell script, the
> `--state-branch` feature depends on Perl to save and extract the object
> ID mappings. This can lead to subtle breakage though:
>
>   - We execute `perl` directly without respecting the `PERL_PATH`
>     configured by the distribution. As such, it may happen that we use
>     the wrong version of Perl.
>
>   - We install the script unchanged even if Perl isn't available at all
>     on the system, so using `--state-branch` would lead to failure
>     altogether in that case.
>
> Fix this by dropping Perl and instead implementing the feature with
> shell scripting exclusively.

Excellent.

I just realized that the first bullet point above is a good argument
against "#!/usr/bin/env perl" as well.  If we were to go the
"#!/usr/bin/env perl" direction, we should stop pretending with
$PERL_PATH that we'd consistently use the same version of Perl
chosen at build-install time, and we just trust users' $PATH, for
consistency.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git-filter-branch.sh | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 3a51d4507c7..24fa317aaaa 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -295,15 +295,18 @@ then
>  	if test -n "$state_commit"
>  	then
>  		echo "Populating map from $state_branch ($state_commit)" 1>&2
> -		perl -e'open(MAP, "-|", "git show $ARGV[0]:filter.map") or die;
> -			while (<MAP>) {
> -				m/(.*):(.*)/ or die;
> -				open F, ">../map/$1" or die;
> -				print F "$2" or die;
> -				close(F) or die;
> -			}
> -			close(MAP) or die;' "$state_commit" \
> -				|| die "Unable to load state from $state_branch:filter.map"
> +
> +		git show "$state_commit:filter.map" >"$tempdir"/filter-map ||
> +			die "Unable to load state from $state_branch:filter.map"
> +		while read line
> +		do
> +			case "$line" in
> +			*:*)
> +				echo "${line%:*}" >../map/"${line#*:}";;
> +			*)
> +				die "Unable to load state from $state_branch:filter.map";;
> +			esac
> +		done <"$tempdir"/filter-map

Quite straight-forward.  Do problematic bytes like backslashes
appear in the blob that Perl m/(.*):(.*)/ would have passed intact
without problems but may cause problems to the reimplementation?  I
doubt it.

Not in a scope of this change, but use of "git show" in place of
"git cat-file blob" makes my skin somewhat tingle.

>  	else
>  		echo "Branch $state_branch does not exist. Will create" 1>&2
>  	fi
> @@ -633,15 +636,13 @@ if test -n "$state_branch"
>  then
>  	echo "Saving rewrite state to $state_branch" 1>&2
>  	state_blob=$(
> -		perl -e'opendir D, "../map" or die;
> -			open H, "|-", "git hash-object -w --stdin" or die;
> -			foreach (sort readdir(D)) {
> -				next if m/^\.\.?$/;
> -				open F, "<../map/$_" or die;
> -				chomp($f = <F>);
> -				print H "$_:$f\n" or die;
> -			}
> -			close(H) or die;' || die "Unable to save state")
> +		for file in ../map/*

OK.  * won't match . or .. so we no longer need to filter.  Like the
original, if we had any random cruft file, we may copy such garbage
to the output, but that is not a new problem at all.

Nicely done.

> +		do
> +			from_commit=$(basename "$file")
> +			to_commit=$(cat "$file")
> +			echo "$from_commit:$to_commit"
> +		done | git hash-object -w --stdin || die "Unable to save state"
> +	)
>  	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
>  	if test -n "$state_commit"
>  	then
