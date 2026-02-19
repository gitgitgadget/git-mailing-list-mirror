Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B230C35F
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529416; cv=none; b=YGpl1UmDtbwLTdiVYfAC9DKHG/klJpYGOKvvptbouuB95xKLxZEjXpwROTcqR2o+/49lTxgwnffyZLOJXpdesBpY03BeZecwnFbK9ybGPFuvgYm6DzpyD7bbZkI76sAegnVMAaKKqL+2rmsNMxJTDs64RfZT1Q3evfEMUtfUk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529416; c=relaxed/simple;
	bh=2Vvm5Xl+hiU0IQBSC7BgioF0NfNABvbVzHxIpZbRYWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNH3paHj5wEk3gjyBphJmrTPzThreUT41WbrYrHSTYLmA8Amk2/SwdrL8+LUurRbrrVgB1VwiurbTtUhOdXlj73typsaqR5GbG54iNUXTCqZdtEiT9HgbBXy1t6J8GCyq3q7eDlbrQh+EhBJaUPrf1ssnTY5JbNoKj+Z+J/k7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dH+//hFI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ekn2rw5i; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dH+//hFI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekn2rw5i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F8CFEC05A5;
	Thu, 19 Feb 2026 14:30:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 19 Feb 2026 14:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771529412; x=1771615812; bh=6kt8l0VFwu
	mvq7jW8503Ha1ShdFmAK+iemhadRDElvs=; b=dH+//hFI7uNXT5LQa52PP2/2N5
	/JIcQsLVw3ljaAFrNzU4zhrsXNklShG2dWQHk/MsYI+Z6XSeejwtXrZVSGKnTtA+
	hI0eqQAkG42M44J+VDv4H+3Ys4tTHICcxfJjhNwrMU0ksAyHcyRtrmmLJFh2cseG
	203qgaQZPuhhDCtcxLm+ri4sFjpt1WMqAcei9M78O5d7FvZ8PHnhqfoEhT/v8YO6
	bic1wh6GvelJxSFT+OQ5k4jC9Ar3V1bmY/11cT0XsCBlekv5N4wS29gaa3s+vE/+
	AW3k2n+hdodVDY826Jo2ZISMBFbDTG3QzbeyXKZY9x08eZalZzGHiPDBAgCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771529412; x=1771615812; bh=6kt8l0VFwumvq7jW8503Ha1ShdFmAK+iemh
	adRDElvs=; b=ekn2rw5iq4Yhn8inw/fgqdFkWNOCulg8LgODHM0PUwHMitWx0mk
	lnuicGzOgTgZn2TU38P3aapITZNNRmo83ezXdokfikKC3FzvaVMyi22opUI2cMpI
	jDFqVji8OHEk2HBMI/tmJXNhfNxo8usVcDdP89DTiorCn46sZQmA2pgIFfCl8Qlu
	RCPxsw7moOdvid47mboqTNvdpjnAjyaqa02G3AFEfUho3uBX4Z3pNhU5avIWCmLh
	3GoaV0nX0ORdueMKAyNc5NWhXB/6e1zDbnYy4/MSh8/9MEVjfQFlndooknxrKujp
	ZHk2Z9rAF6w4wWO7owmGbp20I3b8GkOIDrg==
X-ME-Sender: <xms:xGSXaWGRH1a2xXIiwvL3n4yuQc9SyC3_kfp6BCSu-5N0PLKpvUN-Vw>
    <xme:xGSXabBN6yJ5oC_g7EgosCYod7Q-i0HzNWOEgUqDou5QvghRoSO76cX6MnT62aCM4
    nJG6-68t_1bmAcToccScbwEDoAxXw3fV2ADDnEr5GBtoy9s4-AtCQ>
X-ME-Received: <xmr:xGSXaZ-O_8yPFG9HYbCoICHyQGFc_P_-_gdvRLyAguv6qgomHlMyO1wao9dfSBISxsA6XGN4WXdOXtVA9cTIPqjP-KL-FmsyoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xGSXaXADdCOJwMhXSjukAzNFOduz6hvwJ8Ym3cpRWyVbrI15-KYNKA>
    <xmx:xGSXaeTlMQUdMiZHBN7rEXgnc4Rj9Cf_NAkFVQuX3DiTjANRKD7EsA>
    <xmx:xGSXaevYKUCNVMn3NncS17fh0NMHzciUFpQmjD9VsS5r1UW30K8q0g>
    <xmx:xGSXaa30YLtHILiTRltGt95_zrB-5Fe3lbyZ-eVAeLsxiHgoWnGh_A>
    <xmx:xGSXaXz6MHV-FuBr_f8zwkSNr7S5rmUev4MAT2Q03otyZOBK2qJ3jjnl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 14:30:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Shreyansh Paliwal
 <shreyanshpaliwalcmsmn@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/2] wt-status: avoid passing NULL worktree
In-Reply-To: <902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 19 Feb 2026 14:26:32 +0000")
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
	<cover.1771511192.git.phillip.wood@dunelm.org.uk>
	<902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
Date: Thu, 19 Feb 2026 11:30:10 -0800
Message-ID: <xmqqv7fs4jlp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> In general the "struct worktree" returned may not correspond to
> the "current" worktree defined by is_current_worktree() as that
> function uses "the_repository" rather than "wt->repo" when
> deciding which worktree is "current".  In practice the "struct
> repository" we pass corresponds to "the_repository" as we only
> ever operate on a single repository at the moment.

This may technically be a correct description, but feels very
unsatisfactory, as it fails to answer this very simple question:

    what does it mean when is_current_worktree() says "no" to the
    worktree instance returned by this function?  In other words,
    what are the sample sequences that can lead to such a worktree?

We start a Git process in a directory which is part of a set of
worktrees governed by a single repository.  That repository becomes
the_repository and the worktree instance that represents our
directory would satisfy is_current_worktree().  Then we visit
another directory that is one of a set of worktrees goverend by a
separate and different repository.  We now have a repository
instance that is different from our the_repository.  Perhaps our
in-core submodule code may do that, and that different repository is
the submodule in question.  Running this function will yield the
worktree instance, whose path is a subdirectory of our current
directory where the submodule is checked out?  It may be the current
worktree if we asked is_current_worktree() about that worktree in
the context of the submodule, but it is not in the context of our
superproject repository.  In fact, none of the worktrees governed by
the submodule repository can be "current", as they are not our
checkout, from the viewpoint of our superproject repository.

Is that what is going on here?  

A related question that is much more relevant is this:

    What is the significance of the worktree, relative to our
    process, returned by this function for a given repo?  What is so
    special about this worktree, among others that are also linked
    to the same repository?

    What does it mean for a worktree to "corresponds to"
    repo->{gitdir,worktree}?  Why does the currently running Git
    process want to grab such a worktree?

If the answer were "it is the current worktree", then we would have
a nice and very understandable name "get-current-worktree-for-repo"
for the function, but because I do not think of a good answer to the
question (and you already explained why it is not the "current"
worktree), I cannot improve on "get _A_ worktree from repository",
the name given by the patch, which leaves the "which one of the
worktrees are we talking about?  Why did we pick that particular one
instead of other ones" unanswered.

Or perhaps "the current worktree" is not a per-Git-process concept,
but is a per-process-per-repo concept?

In other words, the function is_current_worktree(wt) may not take a
repository and always compute things relative to the_repository, but
once we wean ourselves off of the_repository, we would/should have
repo_is_current_worktree(repo, wt), making is_current_worktree(wt) a
thin wrapper for repo_is_current_worktree(the_repository, wt)?

> diff --git a/worktree.h b/worktree.h
> index e4bcccdc0ae..06efe26b835 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -38,6 +38,12 @@ struct worktree **get_worktrees(void);
>   */
>  struct worktree **get_worktrees_without_reading_head(void);
>  
> +/*
> + * Construct a struct worktree corresponding to repo->gitdir and
> + * repo->worktree.
> + */
> +struct worktree *get_worktree_from_repository(struct repository *repo);
> +
