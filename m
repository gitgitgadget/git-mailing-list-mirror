Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ADA3BD25E
	for <git@vger.kernel.org>; Mon, 11 May 2026 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487521; cv=none; b=keFEMpy2DsxJfPJXfbh8DgP7h77jQuODM61IdHr0gxHMSd+dZL/FHE3g/p1sHh2ZCkJof9czEKZL0qrHwIEk9ytLM67s1usJ5IM0zzpICCJCezZFVz7uKonPYB33VmSkY9vfe3ABz9VkzRGeg7lrvrc41tcgapLO55H6XVMp1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487521; c=relaxed/simple;
	bh=zhsN8jjCodPGSoqx0Ig80C2JBQ50UvUCNW+N/M5o47w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGnuFBJ3SYD/JvWKxMSMThYDV01SRhTg10/BDnATCFDrbRiqgqlKzCwU6P+Ez38TTgwCNOYjBCGb2A00ItaI4VP/yaZpTX9NiNDRvWlRCGpQ7GTYWHF8CNXIVuGpkHdwj425GlsAZbjnFmlOPVCq+8jo2m+uEtE/MxrJxga+fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WEtMyvjv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fpl1vKOe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WEtMyvjv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fpl1vKOe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 55BC21D000E0;
	Mon, 11 May 2026 04:18:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 04:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778487505; x=1778573905; bh=vLhNM5HJz0
	gVHfpJGxHpBeuN8SI8yd/A+Sz7jU6dIpU=; b=WEtMyvjvnT1F/GscR7U/WLg7Vy
	00R25iKjRRYJgrCN14aR018ZZFKdWiOfIkGIE1sJM4wgAh1g3x/cWV1F5L8z1QU0
	1qbTMgulzj23oLHJW/YZjLRFnmSvNEQ94L/rP0EDSOThMOIxn48c2Hd/v4SvIaA1
	YIiCfwa6YSCHmuPp3bq6+6ezhS0TGyBL+i4jZWD6G2ek5wYXEDju7RlpxchK+Q39
	J034JlZgXE5rhIc1VXVaOiOaOqlcpb1B/TyQspTv5Pe+MpJvCRlpfKtBVsB5cTSA
	rZED6+i3YicPrXjLqKXOnUxzA2cu83MJ3VV/Nlr+fnFn5EnqjzqLeUJ+/+FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778487505; x=1778573905; bh=vLhNM5HJz0gVHfpJGxHpBeuN8SI8yd/A+Sz
	7jU6dIpU=; b=fpl1vKOemG0IfUhZU9C7QdIgEdKALYYeeds5duaDLCQgZw5AFhq
	iUhqbeIddO4LCpEPZcywx6haq73Bs69Bu0nU6n2caXChN1/G7E983DijGknWMnlh
	tYzPoVwnpdUrzPCe4Ixig6fexoAtIccM+iVfnkRrqxCYlUdbLb9w7mpG/tsLRhAB
	ftDsbmCbCq3aC/nUtK3jILsGbsLRBNuGUnyPd1HYHdVOWQ12EXs+E6zWFFo8cGEU
	YMM1aDwLLV0Nx8gV5zPwLeIb2oh4NX4fby7yQbyiJa20C5hBCfmHKMboNnnL59Sp
	5u7kXNtabw2WvxG23KLVwMV7w3AoimghUTg==
X-ME-Sender: <xms:0ZABapDqEcsucdTuBi3y_RmUOcUzWPJt6RO5rN8OlubNHE5_tH-ZbA>
    <xme:0ZABarOAj6NNiOiU-C2Yk_o60mIzcSqQ4fq_mmL3P772nU4K3qDCMw-9LBx4NBNze
    yhg0dyZZWIQROFRbBvpRR5EliDM_v0lp3WB5G0GuLBDadSTgtCchA>
X-ME-Received: <xmr:0ZABaub4gbnCbP7xhiS8Dj_Cn62QbLkmL3KytMLwuqY0xUFv9anrLmEx_f6ywWdxIJisp7jduK0twpm1Y4wKkmmmp6sYPapFLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehhrghrrghlughnohhr
    ughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:0ZABaqsN643uEYrN2ztS4YLZV8Dr_tPtg56tU11xrXGZdkECkI5Fgw>
    <xmx:0ZABagNDduXYma5FsLtk3hd95AO_NPdECa0WzKbpT8oPCNHSc5yi8w>
    <xmx:0ZABah5Zg-P50eUjau8dmNWiVQR5ChM8OuS6_uHgvSaZ92CSyq36Zw>
    <xmx:0ZABamRcrhqKSHbXzSS5fvhEyzJ3AP3YQ_ysSs3bmIxoni3wYx4Feg>
    <xmx:0ZABamPdKLIGWnHDyRDAAieqkI5YpQl-wFwLXciBMUx_BB5zZQvNXiW2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:18:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 2/5] branch: let delete_branches warn instead of
 error on bulk refusal
In-Reply-To: <807c9f981fa05bd6e06228e54ddacb0a397a0f98.1778482708.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 11 May 2026
	06:58:25 +0000")
References: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
	<pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
	<807c9f981fa05bd6e06228e54ddacb0a397a0f98.1778482708.git.gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 17:18:23 +0900
Message-ID: <xmqq7bpas6k0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add two new parameters to delete_branches() and the helper
> check_branch_commit():
>
> * warn_only switches the per-branch refusal from a hard error
>   ("error: the branch 'X' is not fully merged" plus a four-line
>   hint about 'git branch -D X') to a one-line warning, and
>   causes the function to skip those branches without setting its
>   exit code. Each refused branch is still skipped from deletion.
> * n_not_merged, when non-NULL, is incremented for each branch
>   refused on the not-merged path, so a bulk caller can summarize
>   rather than print per-branch advice.
>
> All existing call sites pass 0 / NULL and so are unaffected. Both
> parameters are wired up so a bulk-deletion caller can suppress
> the noise normally appropriate for a one-shot 'git branch -d'.

Existing call sites are about "branch -d <other>" that allows the
other branch to be deleted if it is part of HEAD or if it is part of
its tracking branch, but should "branch --prune-merged" pay
attention to what branch happens to be checked out the same way (not
a rherotical question to hint that I do not think it should---I do
not have a strong opinion on this either way)?

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/branch.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index b3289a8875..1941f8a9ad 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -192,7 +192,8 @@ static int branch_merged(int kind, const char *name,
>  
>  static int check_branch_commit(const char *branchname, const char *refname,
>  			       const struct object_id *oid, struct commit *head_rev,
> -			       int kinds, int force)
> +			       int kinds, int force, int warn_only,
> +			       int *n_not_merged)
>  {
>  	struct commit *rev = lookup_commit_reference(the_repository, oid);
>  	if (!force && !rev) {
> @@ -200,10 +201,18 @@ static int check_branch_commit(const char *branchname, const char *refname,
>  		return -1;
>  	}
>  	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
> -		error(_("the branch '%s' is not fully merged"), branchname);
> -		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
> -				  _("If you are sure you want to delete it, "
> -				  "run 'git branch -D %s'"), branchname);
> +		if (warn_only) {
> +			warning(_("the branch '%s' is not fully merged"),
> +				branchname);
> +		} else {
> +			error(_("the branch '%s' is not fully merged"),
> +			      branchname);
> +			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
> +					  _("If you are sure you want to delete it, "
> +					  "run 'git branch -D %s'"), branchname);
> +		}
> +		if (n_not_merged)
> +			(*n_not_merged)++;
>  		return -1;
>  	}
>  	return 0;
> @@ -219,7 +228,7 @@ static void delete_branch_config(const char *branchname)
>  }
>  
>  static int delete_branches(int argc, const char **argv, int force, int kinds,
> -			   int quiet)
> +			   int quiet, int warn_only, int *n_not_merged)
>  {
>  	struct commit *head_rev = NULL;
>  	struct object_id oid;
> @@ -309,8 +318,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  
>  		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
>  		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
> -					force)) {
> -			ret = 1;
> +					force, warn_only, n_not_merged)) {
> +			if (!warn_only)
> +				ret = 1;
>  			goto next;
>  		}
>  
> @@ -961,7 +971,8 @@ int cmd_branch(int argc,
>  	if (delete) {
>  		if (!argc)
>  			die(_("branch name required"));
> -		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
> +		ret = delete_branches(argc, argv, delete > 1, filter.kind,
> +				      quiet, 0, NULL);
>  		goto out;
>  	} else if (forked) {
>  		ret = list_forked_branches(argc, argv);
