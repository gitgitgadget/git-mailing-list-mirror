Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EE223710
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739661; cv=none; b=FUdaw168WAL8rl3oPEv2kdiKWlOS1Ny6XUWrUmqryJwStC5vMgXYQ5JcVdCDuxF51ql8dh5PqAQDx0p6FaWhT/iDKLpu7fRV0gmxFUxmA2LoNh+gte5ymAtRUi1tR4o237tuYaQNN9YcJSWCVzoDXzGgFzXisHusI2Cdi0VFqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739661; c=relaxed/simple;
	bh=Yr9veHZ3O5l48Bc2w81ZKEvPpM4ALvhqJyNEjb4TKeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQ/UyDHGC3WbvikRKJ6MJGdj021jBJ1o9Qclz6eVGTVt4KFCRddsp6rC91EEBON63Fvkrbi2waitKRft324eWnv3b5qK5QDp4aTI6Ya1AGCDerKcH1KiQNwHdOlSmqropucaHcGV0AI100vnmTH0xl/7MKvxXeCf+QIYgYHgoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EnanrJpz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+TaclCu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EnanrJpz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+TaclCu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A46397A0157;
	Fri, 17 Oct 2025 18:20:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 17 Oct 2025 18:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760739658; x=1760826058; bh=zzMZvAbd+n
	jOWRpokCaqYMeZJqUY3HggYNjJFw5Mr1c=; b=EnanrJpzpmJqvxIcKaVqoqt6Yi
	k4zNtIKYVfmams0MM+oK7qX3G821tsRT3saKrzLlmiJWz6Y+kCeYkolT+4PNjb0h
	W++9TcTrn9fYjnOvracPJ0mMePCUE1M24emS33WCHg4dk04qYjHQVURXK9pxODWf
	hI0hj10pbGY+/qLzNXLmAG7joOPB0SclIB/hr8xSDcFYSZvf4L71JhcTfcwgX7Q2
	Fnhlr2WM2o25UesOE3T++Veo3+GoNk3RPfw08h10CJj+XdEKtli89TWMbHd8wR83
	CLJQgcJyOORUGGGmeWq8NbrKs8j71U7hyqGfUq0HwGNqplsLzMfihQRD9vcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760739658; x=1760826058; bh=zzMZvAbd+njOWRpokCaqYMeZJqUY3HggYNj
	JFw5Mr1c=; b=p+TaclCuUo4W3fFdQSKap4thvKbLy6emkJENLXJvGKh4FjI3s+M
	67Bw7uwyj6Onj20/YhoaZCy0DUwRG0qNBBhPv5XU736VCgHbAdjf4yXHN1QpJXkZ
	yVXeQS1Raphg8LH+kOWT4mkPL5uGeiPizh7KqJhkueJe8/V2+y4jxLMQb2pEbnXG
	OkdgKA4W5TIMr9MKZavAdXY/1kcRSMAQtgpoxfvT4pn1EXLELptV5cI6HDfmfzzT
	nbz26PtWzVQVE4agz0DkdE+HHP7hK3u5CdS7+4oW1ij1KOFUcwSIJo6ivodBHner
	g/HdL/fLlccKTm5znRmBy+zMaWPHNNbqlAA==
X-ME-Sender: <xms:SsHyaP-xLIPsTprq71C1anfWt0h9EaEdpgUwPrPRajLn0JgZwRdc8w>
    <xme:SsHyaCukNZ64mLITUB7hWBHv_bAYVzicJfgZOiQA6UdT7EniWUjJb5mjQy1hGlBfE
    7TH8CMp3_WY7hMU5DhjucIxOH3giNZUXr1ZHPsY1CRLjDDUrw1fSA>
X-ME-Received: <xmr:SsHyaCCW453EziXqQrBAAX5SGCJTcsPeAohP1qfAepIdvgf2UslX8c4M7jpCNeRMhPO1G8j-acnOjse1AMhBz_aL6rQRXQERHqhv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtfeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SsHyaKW5Z7HayRLWjbMll4AtvDyPr3etsnJlNtPnrToUvEOAavCHuQ>
    <xmx:SsHyaAB_UaG7L2g5GLF4G2PH7eii3oVUk7Fek2ZhouXf7wWLKREEfw>
    <xmx:SsHyaN9gY0rb6c3_Z85kgBrm_HdLkc33Ogyx0rxosLnHlMeSxI2yaA>
    <xmx:SsHyaHGs1yyvAN9zynE2gBbbRfeL2nxDOyiOXX53i73ZVaDuuhkLRQ>
    <xmx:SsHyaFikczYGV5ezQY-QFHQ_l2xAw-olv_Xa-Ku6xxnsLNGbymI9Ta7U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 18:20:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/4] doc: git-reset: reorder the forms
In-Reply-To: <c7e1c090475f76d94363018681c34f3955abe87e.1760731558.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 17 Oct 2025 20:05:55
	+0000")
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
	<c7e1c090475f76d94363018681c34f3955abe87e.1760731558.git.gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 15:20:56 -0700
Message-ID: <xmqqikgdxj93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
> index 3b9ba9aee9..9843682e81 100644
> --- a/Documentation/git-reset.adoc
> +++ b/Documentation/git-reset.adoc
> @@ -8,43 +8,17 @@ git-reset - Reset current HEAD to the specified state
>  SYNOPSIS
>  --------
>  [synopsis]
> +git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
>  git reset [-q] [<tree-ish>] [--] <pathspec>...
>  git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
>  git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
> -git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
>  
>  DESCRIPTION
>  -----------
> -In the first three forms, copy entries from _<tree-ish>_ to the index.
> -In the last form, set the current branch head (`HEAD`) to _<commit>_,
> +In the first form, set the current branch head (`HEAD`) to _<commit>_,
>  optionally modifying index and working tree to match.
>  The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.

In the original, the "defaults to HEAD in all forms" did make sense,
but as the new text does not mention there are three other forms
like the original did, that sentence was made harder to fathom.
I can accept that you do not want to get ahead of yourself to
explain "copy from <treeish>" before you are ready to talk more
about these other forms, but we'd at least need to acknowledge that
what we want to refer to when we say "all forms" here.  Perhaps

    Among the four forms, the first form sets the current branch
    head to ....  In all forms, the tree-ish/commit defaults to
    HEAD.

is easier to read?

> +In the last three forms, copy entries from _<tree-ish>_ to the index.

Or "The other three forms copy entries ..."?

Other than that, looks good to me.
