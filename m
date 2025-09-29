Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD3944F
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169279; cv=none; b=OumhauA6yTvnkT8Rs3BYAaKGPEuq8UXqZfqn9ksb94WwUP1XiUOJDATwGiOwcWYWSMx8hOF073j78LziZ985tiS5fYoDrDKBfzO2HOVuzXUl9RC8XXbw2XS/UXWJrbYkjsbvMWvZ8Y4sNKsgRhGgB5EMqrIckKJ6mXjd/XsQKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169279; c=relaxed/simple;
	bh=Kn8gaGybbphpf3mpjK1m0yJjJ8xS0cJdiilpxpqyplE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F4NcLQfKQkiO77dbMQgUOWIxlviecdcUNaOgbo07wscozD+uFvmrs230YYyvmy9Nnb+uLL42j0tidTqrh8rpTeH81ijLeIwpPUw1f3YgLegSsfYK0tQDRdCqv0eED7FteO3yV5v0PaXRa1U6hTMtCJsRysuiejWs+aNRBXxmE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=W9kGQEHM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qE7P6+Hc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="W9kGQEHM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qE7P6+Hc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65355140016A;
	Mon, 29 Sep 2025 14:07:56 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 29 Sep 2025 14:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759169276;
	 x=1759255676; bh=sB/WtMmYJFvvPr+un4KU9FC/ymXP32SQOibsnzmqRWw=; b=
	W9kGQEHMmRxa3VAlD58lMfAtI35npmIwKZH850Y538MquW1OS7oeLLtV1YlvzYXd
	eDTgCxwtiQJISlLPQGMRWw3yYm/oVswC0aKDGkixRQMzsmCTczXN6lSwHOPJICz0
	2MjRFnqQAmw1TmX4aMrgGqepSxwKmpjBhRtda8PJAf3C0PD/ss4k2AOIT0K1udk+
	5xMP/jecsmvE4yyDIN9ntsl9t5c1LSfx3aLiQ1W5QuPh2A6qLz0Nz1kPJgIQXzFQ
	xgg+1uLwSYKBpRYo7fy0gBLKxpMOlhKqrBE8SOhaJ1ihEUL+UMuCEi8Zj7SLHTYK
	Qk+imQJOyXVVfEYIDORLcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759169276; x=
	1759255676; bh=sB/WtMmYJFvvPr+un4KU9FC/ymXP32SQOibsnzmqRWw=; b=q
	E7P6+Hc+L6rfZPPYSW6D32gYf1YUyrjDiIcfbaZVh81QYFpr/dKjMRJEnNkAN/IT
	QqnnEmNfFtpvOvGUVq5+z/Mzjeuagz6xs0+KzQw+k+Lq2Zv5Hn4sxv5JNO6TBZxK
	q0//qhZnUvKSqsla++TCwlsVh6QbwpGcUrgU9aTE9D6iI9kfI45A/eubIXiDL/dX
	3ueFvG9ke6jBKWNSTwLRwO6wln4ay1l/d6D1ndQV2lnSrKqUSlfivm737Yb2vOa6
	cFrmZwsezSNpYlZfXv9V6b8N+K9pxIpv7QeDROn7LVFdVGV+0d/w7K9+hrO7+TOa
	rr5ZRDliu5Oae881wYyLA==
X-ME-Sender: <xms:_MraaJv1EYo4wtsq1fff0Ryr7wtIvOSe86B9yhpECkHNtxjJ8l_CuZU>
    <xme:_MraaNSowZynBgrm9HI6uwF86rMMcBcwp35saP8IKMaD5BJPw_kF_2mxqeF9Tr4Nt
    ouPtSiYgxwcKAeQSggeUE0hXZWWzbRXIBbnnpkFpXOKsqwd5tGzYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_MraaBXJxzZEdrWSNnrsO0k23nCcMYrTizQK9BZDgnBfRFSPp3iwtw>
    <xmx:_MraaPaJNUAZFbXG2tKf7fLfxt32_Yqfq5xftmx_oErZa8eMzWiHhg>
    <xmx:_MraaH33x6D_1qqaJjPySM58Zz1mDreOZJla5u-94h9h_UUVu6nUhA>
    <xmx:_MraaBj8UPk8Fu1dqiVUetmFlfJSISsEGFebZyuirt62SBOOTgyfzw>
    <xmx:_MraaDpN0gm5xhax2jTCkBl3RSG3VSf-a3Rp7SX427akTfC83Op1Kgdk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F06011EA006B; Mon, 29 Sep 2025 14:07:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Am2Ak7_7DqdZ
Date: Mon, 29 Sep 2025 20:07:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, "Julia Evans" <julia@jvns.ca>
Message-Id: <df251b0c-c593-41ed-903e-8fb1c323b874@app.fastmail.com>
In-Reply-To: 
 <e636475cba2246ea98e461579a25b41b0ef4e99d.1757531669.git.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
 <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
 <e636475cba2246ea98e461579a25b41b0ef4e99d.1757531669.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 4/7] doc: git-checkout: clarify `-b` and `-B`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 10, 2025, at 21:14, Julia Evans via GitGitGadget wrote:
>[snip]
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 0db32b098e..7ae2ae9483 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -47,27 +47,21 @@ $ git checkout -b <branch> --track <remote>/<branch>
>  Running `git checkout` without specifying a branch has no effect except
>  to print out the tracking information for the current branch.
>
> -`git checkout (-b|-B) <new-branch> [<start-point>]`::
> -
> -	Specifying `-b` causes a new branch to be created as if
> -	linkgit:git-branch[1] were called and then checked out.  In
> -	this case you can use the `--track` or `--no-track` options,
> -	which will be passed to `git branch`.  As a convenience,
> -	`--track` without `-b` implies branch creation; see the
> -	description of `--track` below.
> -+
> -If `-B` is given, _<new-branch>_ is created if it doesn't exist; otherwise, it
> -is reset. This is the transactional equivalent of
> -+
> -------------
> -$ git branch -f <branch> [<start-point>]
> -$ git checkout <branch>
> -------------
> +`git checkout -b <new-branch> [<start-point>]`::
> +
> +	Create a new branch named _<new-branch>_, start it at _<start-point>_
> +	(defaults to the current commit), and check out the new branch.
> +	You can use the `--track` or `--no-track` options to set the branch's
> +	upstream tracking information.
>  +
> -that is to say, the branch is not reset/created unless "git checkout" is
> -successful (e.g., when the branch is in use in another worktree, not
> -just the current branch stays the same, but the branch is not reset to
> -the start-point, either).
> +This will fail if there's an error checking out _<new-branch>_, for
> +example if checking out the `<start-point>` commit would overwrite your
> +uncommitted changes.
> +
> +`git checkout -B <branch> [<start-point>]`::
> +
> +	The same as `-b`, except that if the branch already exists it
> +	resets `_<branch>_` to the start point instead of failing.

s/`_<branch>_`/_<branch>_/

The backticks causes it to be rendered with the underlines.

>
>  `git checkout --detach [<branch>]`::
>  `git checkout [--detach] <commit>`::
> @@ -157,16 +151,14 @@ of it").
>  	see linkgit:git-branch[1] for details.
>
>  `-B <new-branch>`::
> -	Creates the branch _<new-branch>_, start it at _<start-point>_;
> -	if it already exists, then reset it to _<start-point>_. And then
> -	check the resulting branch out.  This is equivalent to running
> -	`git branch` with `-f` followed by `git checkout` of that branch;
> -	see linkgit:git-branch[1] for details.
> +	The same as `-b`, except that if the branch already exists it
> +	resets `_<branch>_` to the start point instead of failing.

s/`_<branch>_`/_<branch>_/

>
>  `-t`::
>  `--track[=(direct|inherit)]`::
>  	When creating a new branch, set up "upstream" configuration. See
> -	`--track` in linkgit:git-branch[1] for details.
> +	`--track` in linkgit:git-branch[1] for details. As a convenience,
> +	--track without -b implies branch creation.
>  +
>  If no `-b` option is given, the name of the new branch will be
>  derived from the remote-tracking branch, by looking at the local part of
> --
> gitgitgadget
