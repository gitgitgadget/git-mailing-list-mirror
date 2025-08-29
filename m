Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC12066CF
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483127; cv=none; b=aAX9Ahm9TRBXDDruLhKzJ79wxaZUgsjraJfy8kbktjBQhzATOORtcinNCmbfZpyTFlLpUhYGZ53vFZIDFUftuydAY+gukXNKiU25vAXl4aJfC2MZ5vSibdQFpwl2VYWrm+HqGmuMNZSHthaKG5rQFKndS/yEvj0wUxTHooX375c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483127; c=relaxed/simple;
	bh=kot8HiBptuW7kDoR+wmUw5YoEHZeG2FiPAlYfEiAJtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ff2yCNAFmPAG/ViMaQVuk0gBDlm1yzoPHMX728dQ7AUw0rf2SKP1V4GD+KpCOekN32lzcvkdBN2Q+kDckKouD2GEVC1i6rjTNrDzBEIYsCt7K0Vb91Bg+UYSAM3GjpSzUU450/0H0aVlbg6IGXPIeRwbaMHhCjmQoSjvy8LXozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DpeVvyr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IIFpR0Q/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DpeVvyr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IIFpR0Q/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D94381D00171;
	Fri, 29 Aug 2025 11:58:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 29 Aug 2025 11:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756483123; x=1756569523; bh=R9Uua3G1Ti
	V0OIVbWSl4h1tSRt1OMAjd6Dmj9L+Z0PA=; b=DpeVvyr4gLtZlLiyq3DuPYzEZc
	4gEAV0oFFhd1OtZ9xQKJrG1zbAS6vQaArMuYn3WbR8FgVZhPnCjDXXb3iG2qXcJC
	dfQMc+euc0i/pBfiaCRqptaMa90OveOr36AkwgOqS6VcezhKwjnJaY9eeCyDUn/K
	aKVj8VduZxdd1IGJ7Xl+i5GWq+o6y5oAndNKAUfDKGtQ9hj4/7zUazdJrVfrtNC+
	XrrvyxUzRuFUS/grWfz6F3uR59stWbNQSEYdURjBYLTJQj4jAvkOBCAexkvi6D47
	eUJINXciK4bmhvXpj1NrjnY/SzZMD8zQw0oMIWq6KlCPw62MONSoztFh3EOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756483123; x=1756569523; bh=R9Uua3G1TiV0OIVbWSl4h1tSRt1OMAjd6Dm
	j9L+Z0PA=; b=IIFpR0Q/p2ELCw4WLgkUNj64NTrCSD8lFQ8kYi1pAEhI5yUXBEd
	13tp6D0e575dJNUvcFZuXc4GIACM26WQlr/EKfip2rzsR/7Q4wfuUP3Wzus2SwMh
	MrEJ8xBbRWXpKwIWcvXU2+8HdxvSrhQoLHw0bez1N7KTH8OtvzgM+/0adootwjcc
	g12nrfXrI2imFZLTyR5kuQwWw3QboEHJhGUUBPy2Rwm5/xGqvyHOhVwqiZvBgBUT
	lj3sZzv0ZjRGwilir4e9/YdOsH8c7N2NoXsBlAxnTTS9giBMaZOIL6+QnfpCw35G
	4xvbbsnB0wfTZZ+kciLnQesqnV815/7vrwg==
X-ME-Sender: <xms:M86xaPRd471ztRJWjUNjGst8QLHlkNwtu0OJSb3m8A4Iv01qEdvHhw>
    <xme:M86xaMTLOvhgGQX8muX7vKKF_-PfCyvjDunN-7xbemOmZL-IynmYIXOTi2S4k1u_k
    CmnRJ0ZiFQJQLT_IA>
X-ME-Received: <xmr:M86xaLQEbNoHlgFmvLmTxTRCLFLsntWQBBA4gVLS5Q59QMpPNySYUgi7qSmkBqNNFChLqlb9075g5By31pBXYbW0bL44SnLnVbIgBb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M86xaJ51Pa-TxeTAxqiJH8SNUZdNo9zkxwt84WSyoC8OABQy2DJ2gA>
    <xmx:M86xaP1he0rS8BNcJ9dtZfmaj8DT3KXktEWYtdvhxsWoMsgRIFTDSw>
    <xmx:M86xaMBOB6L6AM6Ht7FwjgeA6CurqayvfN-hiLX8RZcTMiNvAkeVbQ>
    <xmx:M86xaCNJTp7BOx7LS-LJXv5B1G9uC_MjuHu38C5xNiJMzqf-q_VrCQ>
    <xmx:M86xaJSofZEO7J2E2UAckXFmO6Zy6CP3TB-CI3LZpqJpYJtrXl6a0XYa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:58:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/5] doc: git-checkout: clarify intro
In-Reply-To: <48e7f230294e131007032ef8850456a5c0493ef9.1756467934.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 29 Aug 2025 11:45:30
	+0000")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<48e7f230294e131007032ef8850456a5c0493ef9.1756467934.git.gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 08:58:41 -0700
Message-ID: <xmqq1poup1am.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> - Many users do not understand the terms "index" or "pathspec". Clarify
>   in the intro by using an example, so that users can understand the
>   basic idea without learning the full definition of "pathspec".
> - Use the terminology "Switch" and "Restore" to mirror `git switch`
>   and `git restore`
> - Reference (and clarify) the ARGUMENT DISAMBIGUATION section
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---

You seem to have forgotten to update the proposed log message ...

https://lore.kernel.org/git/de40e0ed-ca12-41b0-acd0-3c594078cc14@app.fastmail.com/

... to avoid making it just an enumeration of "these random things
were done in this patch" (and instead tell a coherent story).

The same comment applies to many of your patches in this and other
topics (I won't repeat for brevity, though, on my review on them).

>  Documentation/git-checkout.adoc | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 40e02cfd65..c86941ad53 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -20,10 +20,12 @@ git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
>  
>  DESCRIPTION
>  -----------
> -Updates files in the working tree to match the version in the index
> -or the specified tree.  If no pathspec was given, `git checkout` will
> -also update `HEAD` to set the specified branch as the current
> -branch.
> +`git checkout` has two main modes: it can
> +**switch branches**, for example with `git checkout <branch>`, and
> +**restore files from a different version**, for example with
> +`git checkout <commit> <filename>` or `git checkout <filename>`
> +
> +See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
>  
>  `git checkout [<branch>]`::
>  	To prepare for working on _<branch>_, switch to it by updating
> @@ -511,14 +513,17 @@ $ git log -g -2 HEAD
>  ARGUMENT DISAMBIGUATION
>  -----------------------
>  
> -When there is only one argument given and it is not `--` (e.g. `git
> -checkout abc`), and when the argument is both a valid _<tree-ish>_
> -(e.g. a branch `abc` exists) and a valid _<pathspec>_ (e.g. a file
> -or a directory whose name is "abc" exists), Git would usually ask
> -you to disambiguate.  Because checking out a branch is so common an
> -operation, however, `git checkout abc` takes "abc" as a _<tree-ish>_
> -in such a situation.  Use `git checkout -- <pathspec>` if you want
> -to checkout these paths out of the index.
> +When you run `git checkout <something>`, Git tries to guess whether
> +`<something>` is intended to be a branch, a commit, or a set of file(s),
> +and then switches branches, switches commits, or restores the files.

"Switches branches" I can understand.  You were on your old branch
(your HEAD usually is pointing at some branch), and you move to your
new branch by making it your "current" branch.

I do not understand "switches commits".  When you move to a commit
(i.e. your HEAD can point directly at a commit without referring to
any branch), are you switching one commit with another?  I do not
think users would view it that way.

Phrasing it with "switch to" may make it easier to handle.  Then
your previous state would not matter as much.

    ... and then switch to the named branch or the named commit, or
    restores the files in the working tree (i.e. overwrites them
    from different versions).

perhaps.

> +If there's any ambiguity, Git will treat `<something>` as a branch or
> +commit, but you can use the double dash `--` to force Git to treat the
> +parameter as a list of files and/or directories, like this:
> +
> +----------
> +git checkout -- file.txt
> +----------

Good.

>  
>  EXAMPLES
>  --------
