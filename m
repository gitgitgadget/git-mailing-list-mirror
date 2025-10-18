Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7A19DF9A
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760763232; cv=none; b=LGLaOj65W+H9pPCUtWV1MeYZ3oj0ZGmwnPHBCyHjEzVMTZfAzSnNYKp2F844d03vBSmYjHiMnqnCh5n05F24cKrSiEI8zeTCrP3fntWSKszWoPFuJOuCzEFIsx5CAtUy0FxqhpjxK9mgm/c8q2T/DYbjRr3ol++Dhy8PNJC+u/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760763232; c=relaxed/simple;
	bh=N+NbJZC/iODbhXvGDfSNEwSGr2roFoATaQFZ0BDsdG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UNDR3Ueimum6gTFLlzVagk6I4BLM9lDPxTrieJnQZiYSqzcEr3crUVMmPeBl3RzHJNkFXko3iilegRzfc0l8L66oJAJT5DUPb15zhV3P2C55o7RWsjTBhXRnCwrnKdIaEhmb2jn+j2TqG1VE83EbQ6iQSAQMxfikhyyqlwlbgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XO3EeTwR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jed4pUz6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XO3EeTwR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jed4pUz6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6970A140002E;
	Sat, 18 Oct 2025 00:53:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 18 Oct 2025 00:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760763229; x=1760849629; bh=IowDcerLjF
	/0mky9NOr10jd03FexHqbhCeT0C1OHb+I=; b=XO3EeTwRBm/23B61/6bHneRoWz
	M+KLHkiBak+J+UmjS1t6w2Gu1elruzLTy77bm2MwoQ32cI/h5uFBp3CcFUn681NZ
	Tc7loOEErAWrBuYQr4OvG3ooh4ceTw2y72EEaPFKP8rHYtbiDx+6XKYkCTJoyfWY
	n+RmMDJuQNEi6brDAZP5KaXMcI2BekpraQ1Qz8FkDM3HD3NVpkorGqs+m8QB3c5d
	A9leoP76S0x5td/7dE7KMdWq37Me5r+MeavILOO30TMihUfs1sIIIhSBxDcOv6Wr
	r2FvPU712dxxRfPg5ffXeM2f9nYGdD73zmS6Ycd2TL09NUJUBbGl0q567iZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760763229; x=1760849629; bh=IowDcerLjF/0mky9NOr10jd03FexHqbhCeT
	0C1OHb+I=; b=jed4pUz6B4+ccccN8qx7e10wt2Vlnd5AnqA/xwaeZlST9/ER9+b
	UfRnSq3A/NVKga1fhKEyDsFBdAdhVH1SROGQLfaap5sOtjy+pwrm4Q4v8AgGtxUK
	PDpU/jDF/x3PbH3Wv9taiHGGL7SKyU5C86b71XqMQ8dz3UByiUjRegM9BSm7Um4C
	7MmPczOGoxc1zwfhUYhN8OD5dseLFUFcUyITCEG9KbNtcbSSuw6bpJQ320coBDMi
	qSfOJuYgzCmZtKZOFDxx49Sp5cyYNCVMSnAecliKOrxnPGqn3wl+W9ts2CaNKKl+
	wMIL2YhKs1j374JADGm0eJx9E9K3jamfYhQ==
X-ME-Sender: <xms:XR3zaNliLekKt8XAijDD3euPI5mGMX19MXOZHdy984xljvCZpaeD8g>
    <xme:XR3zaP3MXMA8YXdzBYq6LPD85Z4EsEOWjEfIuhXalmWLdf2pcb-e3Ri5QQXsU6Z4i
    mMWWiXCtOxDy_rjjOwBv5SVjCC8W888nBdQ-hwOSvTcQx6qFsicLw>
X-ME-Received: <xmr:XR3zaIqj1BTZUGMMq8s8Xp1QoQKgVR9FFv2gxshwkBVS_H4lS_M0NehZmWttrLfcuHBgAhKR_v85ZgNmaSCo_FLcSh1F7fm3r8hJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:XR3zaMerzzFRGh6cTpAilKUQ11gdJRJrY7u-J6TIgnJFyhxZhEWSnA>
    <xmx:XR3zaHojdmTkohJPUrKGMr6M7aO6lrKhvtkiLDL83_v45Nd1E89Hfw>
    <xmx:XR3zaNEEO7m8xZ1u_aoMbd5pvPpDbPYGGggUambGGkHyzvylUH5cdA>
    <xmx:XR3zaHvmCxvrzDPDw8eCOngAhSqx7BABUWtaDdpgLOFRJ3SmRsJrdQ>
    <xmx:XR3zaELaiVyCrwxQLFVRcn8tc6lHaLSHnSrnh_CqxdSG5wmubt5tNDkN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 00:53:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 3/4] doc: git-reset: clarify `git reset [mode]`
In-Reply-To: <597ea0f5ce24967974358e18603265b14322ba54.1760731558.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 17 Oct 2025 20:05:57
	+0000")
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
	<597ea0f5ce24967974358e18603265b14322ba54.1760731558.git.gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 21:53:47 -0700
Message-ID: <xmqqy0p8x12c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +`--soft`::
> +	Leaves your working directory unchanged. The index is left unchanged,

Why not "leave your working tree files and the index unchanged"?

> +	so everything in your current commit will be staged.

Hmph, if a reader still has the "stage the changes" mental model,
then this would be true only when you are resetting to HEAD~1 (this
is one of the reasons why I am hesitant to overuse the verb
"stage").  If you are going to HEAD~5, such a reader would say that
the changes made by the past 5 commits are staged, not just the
commit you are on before resetting.

> +	For example, if you have no staged changes, you can use
> +	`git reset --soft HEAD~5; git commit`
> +	to combine the last 5 commits into 1 commit.

Another thing that may be worth mentioning is that you can do this
even with local changes in the working tree, because you do not give
"-a" to the final "git commit".

>  `--hard`::
> -	Resets the index and working tree. Any changes to tracked files in the
> -	working tree since _<commit>_ are discarded.  Any untracked files or
> -	directories in the way of writing any tracked files are simply deleted.
> +	Overwrites all files and directories with the version from _<commit>_,
> +	and may overwrite untracked files.
> +	Updates the index to match the new HEAD, so nothing will be staged.

One thing that may be worth saying is that the paths in the working
tree that are tracked in the index that are not in <commit> will
disappear.

>  `--merge`::
> +	Mainly exists for backwards compatibility: `git merge --abort` is the
> +	usual way to abort a merge. See linkgit:git-merge[1] for the differences.

There are operations that are not "git merge" that can leave the
index in an unmerged state, and you do not want to use "git merge
--abort" to get out of such a state, I would imagine.  So I have a
feeling that we are better off without these two lines.

>  	Resets the index and updates the files in the working tree that are
>  	different between _<commit>_ and `HEAD`, but keeps those which are
>  	different between the index and working tree (i.e. which have changes
>  	which have not been added).
>  	If a file that is different between _<commit>_ and the index has
>  	unstaged changes, reset is aborted.
> -+
> -In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
> -but carries forward unmerged index entries.

I do not mind losing this.  Unlike the time back when these two
lines were written, nobody knows (and more importantly, nobody has
to know) what "read-tree -u -m" does, these days.

>  `--keep`::
>  	Resets index entries and updates files in the working tree that are

Thanks.
