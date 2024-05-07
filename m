Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C671739
	for <git@vger.kernel.org>; Tue,  7 May 2024 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121362; cv=none; b=MGOmAT1Tt5NADryvBZCThwYZWjxaoblIyRFAqTM9ZlfPNcFytnH5FnT3DowMmgtcAz2ZNnFKNclVhMYm4kQwk9wpjwkk8YJ+VpFGwaIdUpnXFWAl2WJruXUDRyuWffISLQmEbvTomeJ3WzwNNl5xaAvqdxwkgqHOvoh1CTqrjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121362; c=relaxed/simple;
	bh=lKiNZ3A+PmW+SDDluy2VsLgs/gdU9HW8v3rYsPZqNEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jEWnkoMMKn16PyLdp2xlAHzSTK6p760tCAAEDpm+Nh+0QE4lC1b0ipFa5mugV7CReIxYIayoIJumnHPh5TGENTnZFRvgOC/lBfgvdLoUzRV/EeNw+3TcfovQLk+0ZgijK2h+YErJbL0DloZujwVserkzfp1iAoAUAiG3qpj85tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KExiVWlE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KExiVWlE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D81E437CEB;
	Tue,  7 May 2024 18:36:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lKiNZ3A+PmW+SDDluy2VsLgs/gdU9HW8v3rYsP
	ZqNEQ=; b=KExiVWlEJo9Fi829HP1CNRlXMPIzDFTvisRvZgJyYldC7svzBAiB7i
	ct3MgW8Ht5olT0jSUZKMd0xH5ACSQ4dPN5x+49YfgLsjsPIPlnyHPeDYvv+/O6Ua
	jTnsRizD6Rot0+tSTOBhERaK9kPUPCsuaWMtq4sL6SZqRX3wopMq0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D02DB37CEA;
	Tue,  7 May 2024 18:36:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F92437CE9;
	Tue,  7 May 2024 18:35:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Documentation/git-merge-tree.txt: document -X
In-Reply-To: <pull.1728.git.1715117789985.gitgitgadget@gmail.com> (Victoria
	Dye via GitGitGadget's message of "Tue, 07 May 2024 21:36:29 +0000")
References: <pull.1728.git.1715117789985.gitgitgadget@gmail.com>
Date: Tue, 07 May 2024 15:35:55 -0700
Message-ID: <xmqqh6f9ntbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C0DF3A4-0CC2-11EF-8B20-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add an entry in the 'merge-tree' builtin documentation for
> -X/--strategy-option (added in 6a4c9e7b32 (merge-tree: add -X strategy
> option, 2023-09-24)). The same option is documented for 'merge', 'rebase',
> 'revert', etc. in their respective Documentation/ files, so let's do the
> same for 'merge-tree'.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>     Documentation/git-merge-tree.txt: document -X
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1728%2Fvdye%2Fvdye%2Fmerge-tree-strategy-option-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1728/vdye/vdye/merge-tree-strategy-option-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1728
>
>  Documentation/git-merge-tree.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Makes sense.

I briefly wondered if it is a good occasion to consolidate the four
copies of the document pieces into one before you add the fifth one,
but the one for "git rebase -X" is significantly different from
others, so perhaps we need to live with these duplications for now.
The ones in git-cherry-pick.txt, git-revert.txt, merge-options.txt
and this new one can be consolidated into a single include::, but
then it becomes dubious if we want a new file only to hold just five
lines, so ...

Will queue.  Thanks.

> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index dd388fa21d5..84cb2edf6d0 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -72,6 +72,11 @@ OPTIONS
>  As the merge-base is provided directly, <branch1> and <branch2> do not need
>  to specify commits; trees are enough.
>  
> +-X<option>::
> +--strategy-option=<option>::
> +	Pass the merge strategy-specific option through to the merge strategy.
> +	See linkgit:git-merge[1] for details.
> +
>  [[OUTPUT]]
>  OUTPUT
>  ------
>
> base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
