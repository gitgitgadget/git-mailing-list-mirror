Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DE313286
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364099; cv=none; b=f7/64dJWNIc+OxujxreSTOp1/YpZgIGGkBIi4f0rXJ7tLEdgljm+yqmeNrYhbnvAEFBboPLv3Oh6spxrsZAz74NgC+Qv/WstrlQYk5dTHdhdOYkDnUwZt9x5m0vRl2hY3jQlMPSshE0fuRl43AX356HoTovFbmiGMLLHQ2quwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364099; c=relaxed/simple;
	bh=NVc5g2lUsswo75X8FkZmpCLq+G122rBSo6bxE1smrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDNzY+8eqCznQz8vHEZ0YqkW1vG9AhfM1EV8JR06fJN9VMsL+UhYGq++6Povkz9MeVLpRfPqvw59NmV4vnk/SLdiQAgd50I6Zd4CfBz1RRWOIzbUtFVvQNdD0k+Nairh9P/YCXe57XEpRL5q43C1K/E5g1DWNfWIed9XJN2tb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=n/eGp6E1; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="n/eGp6E1"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:4bd1:2f22:1bf8:44cb])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 9BE272003D6;
	Fri,  2 Jan 2026 15:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1767364094;
	bh=NVc5g2lUsswo75X8FkZmpCLq+G122rBSo6bxE1smrvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/eGp6E1KVBf6jfr8deeuM31RLH40+XhNSvGZXAM1YLPiX7VTTeoWT2IpNfKGna+Y
	 i1Hw3Jfv/dc419kxJZj4l2kswTS9BEWFr9x1+N6jqWr950lqtSeHwRN97rQdomQia/
	 zvoLxInr5yeHyDrpJ2hoCirBJbNWQirTiIIV5wd1XE/ExXLdkCBek7IrwY02qYGgeC
	 vNQmtK7v6PrNNkjq5X3AND/aaTgaeE0tXihhzKk2AZko56s9uLJyvCBAjgdhA7QBKm
	 asBQO/zn7L1SMcCdVLrddmKi+ysJeDYPIU4JUOWsShi2rqpXEI+cRJfMMhDy2yW/OQ
	 On0dx8qz6JtdA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Julia Evans <julia@jvns.ca>, Junio C Hamano <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/4] doc: git-reset: clarify `git reset [mode]`
Date: Fri, 02 Jan 2026 15:28:09 +0100
Message-ID: <1943073.tdWV9SEqCh@piment-oiseau>
In-Reply-To:
 <89c87c14aabfe91489af4a7afa5246ec20776e0b.1767307382.git.ben.knoble+github@gmail.com>
References:
 <cover.1766103827.git.ben.knoble+github@gmail.com>
 <cover.1767307382.git.ben.knoble+github@gmail.com>
 <89c87c14aabfe91489af4a7afa5246ec20776e0b.1767307382.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 1 January 2026 23:43:58 CET D. Ben Knoble wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> From user feedback, there was some confusion about the differences
> between the modes, including:
> 
> 1. Sometimes it says "index" and sometimes "index file".
>    Fix by replacing "index file" with "index".
> 2. Many comments about not being able to understand what `--merge` does.
>    Fix by mentioning obscure situations, since that seems to be what
>    it's for. Most folks will use `git <cmd> --abort`.
> 3. Issues telling the difference between --soft and --mixed, as well as
>    --keep. Leave --keep alone because I couldn't understand its use case,
>    but change `--soft` / `--mixed` / `--hard` as follows:
> 
> --mixed is the default, so put it first.
> 
> Describe --soft/--mixed/--hard with the following structure:
> 
> * Start by saying what happens to the files in the working directory,
>   because the thing users want to avoid most is irretrievably losing
>   changes to their working directory files.
> * Then describe what happens to the staging area. Right now it seems to
>   frame leaving the index alone as being a sort of neutral action.
>   I think this is part of what's confusing users, because in Git when
>   you update HEAD, Git almost always updates the index to match HEAD.
>   So leaving the index unchanged while updating HEAD is actually quite
>   unusual, and it deserves to be flagged.
> * Finally, give an example for --soft to explain a common use case.
> 
> Signed-off-by: Julia Evans <julia@jvns.ca>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>  Documentation/git-reset.adoc | 44 ++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
> index 71e8f52430..6de0d524c3 100644
> --- a/Documentation/git-reset.adoc
> +++ b/Documentation/git-reset.adoc
> @@ -24,42 +24,46 @@ DESCRIPTION
>     the staged version of the specified files.
> 
>  `git reset [<mode>] [<commit>]`::
> -	This form resets the current branch head to _<commit>_ and
> -	possibly updates the index (resetting it to the tree of _<commit>_) 
and
> -	the working tree depending on _<mode>_. Before the operation, 
`ORIG_HEAD`
> -	is set to the tip of the current branch. If _<mode>_ is omitted,
> -	defaults to `--mixed`. The _<mode>_ must be one of the following:
> +	Set the current branch head (`HEAD`) to point at _<commit>_.
> +	Depending on _<mode>_, also update the working directory and/or 
index
> +	to match the contents of _<commit>_.
> +	_<commit>_ defaults to `HEAD`.
> +	Before the operation, `ORIG_HEAD` is set to the tip of the current 
branch.
> ++
> +The _<mode>_ must be one of the following (default `--mixed`):
>  +
> ---
> -`--soft`::
> -	Does not touch the index file or the working tree at all (but
> -	resets the head to _<commit>_, just like all modes do). This leaves
> -	all your changed files "Changes to be committed", as `git status`
> -	would put it.
> 
> +--
>  `--mixed`::
> -	Resets the index but not the working tree (i.e., the changed files
> -	are preserved but not marked for commit) and reports what has not
> -	been updated. This is the default action.
> +	Leaves your working directory unchanged.
> +	Updates the index to match the new HEAD, so nothing will be staged.

Please use imperative mood here, and use `HEAD`.

>  +
>  If `-N` is specified, removed paths are marked as intent-to-add (see
>  linkgit:git-add[1]).
> 
> +`--soft`::
> +	Leave your working tree files and the index unchanged.
> +	For example, if you have no staged changes, you can use
> +	`git reset --soft HEAD~5; git commit`
> +	to combine the last 5 commits into 1 commit. This works even with
> +	changes in the working tree, which are left untouched, but such 
usage
> +	can lead to confusion.
> +
>  `--hard`::
> -	Resets the index and working tree. Any changes to tracked files in 
the
> -	working tree since _<commit>_ are discarded.  Any untracked files or
> -	directories in the way of writing any tracked files are simply 
deleted.
> +	Overwrites all files and directories with the version from 
_<commit>_,
> +	and may overwrite untracked files. Tracked files not in _<commit>_ 
are
> +	removed so that the working tree matches _<commit>_.
> +	Updates the index to match the new HEAD, so nothing will be staged.

Here too.

> 
>  `--merge`::
> +	Mainly exists to reset unmerged index entries, like those left 
behind by
> +	`git am -3` or `git switch -m` in certain situations.

Personal preference, please insert this context sentence after the main 
description of the action. Could you also change the mood of the description 
to imperative?


>  	Resets the index and updates the files in the working tree that are
>  	different between _<commit>_ and `HEAD`, but keeps those which are
>  	different between the index and working tree (i.e. which have 
changes
>  	which have not been added).
>  	If a file that is different between _<commit>_ and the index has
>  	unstaged changes, reset is aborted.
> -+
> -In other words, `--merge` does something like a `git read-tree -u -m 
<commit>`,
> -but carries forward unmerged index entries.
> 
>  `--keep`::
>  	Resets index entries and updates files in the working tree that are

Thanks



