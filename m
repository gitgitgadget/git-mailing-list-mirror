Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273E15E97
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725265; cv=none; b=PZoRWp40nFUWM9BVUlLBFh3dP+UHux/y1jI8YXiZg/PffUirrNcmnazN1SW804m6YSObF10ru+mIYKs0gbooBjbOcr3tutuWh6fGV8oVI3WcFVUdVp+WfuRQs3OsMebhxn/rXevj+doXFSqe2J7EZVC+lXvI6ht3YbgBN6hppPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725265; c=relaxed/simple;
	bh=pujvdbEg4zLtnjVrs8JiGinxhaD6v4OqLgON54oYtEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tFE9dsQkjXVh4NuO/HNdqgKcn6eCz0+UJDe4t11T66JdTkNDlsWiF2gxOsN/ZJkpgqt+wxVUsiViwYdJWDgnnZh9O39KWnD1I0mn5rsaDLzV7NqGEmRxR+6wqUKmDNDpIsCZXoVhhKnoRLYrwCQQ+VbvPXYCP5lmo8oUdrjm+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lN/rvkOS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WOZEAUuE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lN/rvkOS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WOZEAUuE"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D793213808B0;
	Mon, 30 Sep 2024 15:40:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 30 Sep 2024 15:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727725259; x=1727811659; bh=SFF6O3Tbyv
	3kAQ02gOlCozVEmt8N9HGVxcI96lvDxn0=; b=lN/rvkOSvtRpgdVduYy7BH7bMm
	qgE/3KzJHNgfa06ILJs/13cHkJ1c1N+MVeStPcECE6a6BlZRZt3C5ZQRu//pFHfk
	UYqGDlZ5npgGW/1GqbgFzHSGcR539JJSY2NDFOwUr/WAO0zcR+xPRNxUR3DH5ldT
	u/Id/Q2wdKX2sPmuWj6zv2UiHo3LCbCGHBGZo6lzvhXvxknszBYnrBx/v3rBxDy1
	FTuGocFPTCYufcZW+drsFE6KdSh3AQ0wW+/XcoFAAPRm7eUOqCRa6etAIrxhduwc
	VJEKUFEEjGuXw3TmBIjy25AYO5z11WgrZwiHjsHoYypmeti/h8iVRGhXBpaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727725259; x=1727811659; bh=SFF6O3Tbyv3kAQ02gOlCozVEmt8N
	9HGVxcI96lvDxn0=; b=WOZEAUuEIkrAgV+k2HNep/vdSOgcGfWDvMzVIOQ9+a0K
	+sNOM414GK+dVx0uGu1C7QRq/f+EavqhdNMj6JEsDckTIsyctBkXW3kMeDG1OZoU
	Qb3HW3+EWIaYEMqOTwLKJyGtpd0xLSNK9cYwVKR/uBRkaNDauoYugVB3CQ7EOyH3
	Zk9mqQTlzW4nNWROIlJOVcP4Jf1f8dQgcsGfX5wAGJ59BOb3/X6yb5uEPhKzjzSa
	811deVzrFCGtTx2X+k6uibu7ZIi9tl3h7/1suKShnvRBHdAJs3788kdw5AGrTbGW
	vkVfcgSF8iG9nqfxRcjfX2jtCbt0Nt/y0c2HnQC0vQ==
X-ME-Sender: <xms:y_76ZpfUCJ5nSJGoKPS2gQPVyEiIi9l1nJAfWqe29iWAUhd_3Q8GFQ>
    <xme:y_76ZnNK7G1qVE62SPVrKQGzYjXb_2B2daW7UgifvHQYL2re59r0ADklD_MsjE9SV
    Oni6HdcC-Di-aIDVw>
X-ME-Received: <xmr:y_76Zihd42uhgTkCNi5AOJ_FxIui2UPOOVP3ukLKJduP6TwYFk4KBA5jHmFsja0dvP1JOqCzmb2DBJuC9Xf2bMGzW0z5WmYWFY7_A9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhhntggrihekieesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:y_76Zi8GRAs500FaVLTtQPLYLrsuslN58R4lxUmyeQjW8P_WEv8cTQ>
    <xmx:y_76ZlugHJteOMWrnfFkqUUn2NpUm8A7ja-4PWji5uqlDk9h_qZybg>
    <xmx:y_76ZhGlDAJy0DIsss2Dm_yTE3nAkMyRNDhhuecSBxnQNnNlvWZLTA>
    <xmx:y_76ZsMf-ZfHS6ZCZ1OPDiCQEdomGjszHQY3XEgvbtD6YV2mFhablA>
    <xmx:y_76ZpiNwNFi3LU-Cl4NCzNDrymXER5qsgG--N6JQrL0B5Jw50Un8V51>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 15:40:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/4] git: pass in repo for RUN_SETUP_GENTLY
In-Reply-To: <5d72c31c6f3b97b7f5f7d3b4fa9a8b1587597670.1727718030.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Mon, 30 Sep 2024 17:40:27
	+0000")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<5d72c31c6f3b97b7f5f7d3b4fa9a8b1587597670.1727718030.git.gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 12:40:58 -0700
Message-ID: <xmqqldz953qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> commands that have RUN_SETUP_GENTLY potentially need a repository.
> Modify the logic in run_builtin() to pass the repository to the builtin
> if a builtin has the RUN_SETUP_GENTLY property.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  git.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index 2fbea24ec92..f58f169f3c7 100644
> --- a/git.c
> +++ b/git.c
> @@ -443,7 +443,7 @@ static int handle_alias(int *argcp, const char ***argv)
>  
>  static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
>  {
> -	int status, help;
> +	int status, help, repo_exists;
>  	struct stat st;
>  	const char *prefix;
>  	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
> @@ -455,9 +455,13 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  
>  	if (run_setup & RUN_SETUP) {
>  		prefix = setup_git_directory();
> +		repo_exists = 1;
>  	} else if (run_setup & RUN_SETUP_GENTLY) {
>  		int nongit_ok;
>  		prefix = setup_git_directory_gently(&nongit_ok);
> +
> +		if (!nongit_ok)
> +			repo_exists = 1;

Why not use the new variable and pass it directly to nongit_ok?  The
polarity of the new variable needs to be swapped, of course, but I
think it makes reading the code to call p->fn() easier to grok

i.e., 

 - rename repo_exists to "no_repo", and initialize it to non-zero.
 - remove "int nongit_ok"; pass &no_repo instead.
 - update the calling of p->fn() to

	p->fn(argc, argv, prefix, no_repo ? NULL : repo);

>  	} else {
>  		prefix = NULL;
>  	}
> @@ -480,7 +484,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  	trace2_cmd_name(p->cmd);
>  
>  	validate_cache_entries(repo->index);
> -	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
> +	status = p->fn(argc,
> +		       argv,
> +		       prefix,
> +		       repo_exists ? repo : NULL);

Keeping the call to a single line would be much better than spreding
it across four lines.

Thanks

>  	validate_cache_entries(repo->index);
>  
>  	if (status)
