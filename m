From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] worktree: allow "-" short-hand for @{-1} in add command
Date: Thu, 26 May 2016 11:54:40 -0700
Message-ID: <xmqqshx4vedr.fsf@gitster.mtv.corp.google.com>
References: <vpqshx5cb51.fsf@anie.imag.fr>
	<1464263662-1290-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	Matthieu.Moy@grenoble-inp.fr,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu May 26 20:54:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b60Qi-0004dU-L0
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 20:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbcEZSyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 14:54:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754758AbcEZSyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 14:54:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BF241F353;
	Thu, 26 May 2016 14:54:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q6Qi+frbtXQ+6rEZp098Dw7+5Ww=; b=sXAT+C
	IlcZHasehBNQd4t0ykcXFx+nfuWNlKD4jQpZH5MpaBJ3C/edefpvHlSWdSI10syP
	mnZ5Bgh7OT9JoA6FZoMnF/GmsmBARkc7KnrOiXTmN0Zkji/9NUqK9/DLm2K5Cg/5
	QYNDyhiGlMw3VsI8KCt+Fhy+Dxsc9C7A3T9So=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nsokWqHgWTXzjUFtD/UQzRqJbXDWXET3
	CPs1/jexMc4BR9365WrCNTsTZ/JU92duBtozZBF7508UVnDZNJgD0RtjkApC8Xyy
	kM9BaQ62z8msfZl2P2TI6lsYPcKI0q1fwIAjaca86yaUwcMBmJUXBbGYpMtlaiCp
	dfJ1IsbZ49g=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 825201F350;
	Thu, 26 May 2016 14:54:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E42111F34F;
	Thu, 26 May 2016 14:54:41 -0400 (EDT)
In-Reply-To: <1464263662-1290-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	(Jordan DE's message of "Thu, 26 May 2016 13:54:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E1CEF36-2373-11E6-8F50-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295685>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> From: Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
>
> Since `git worktree add` uses `git checkout` when `[<branch>]` is used,
> and `git checkout -` is already supported, it makes sense to allow the
> same shortcut in `git worktree add`.

OK.

>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
> ---
>  Documentation/git-worktree.txt |  3 ++-
>  builtin/worktree.c             |  3 +++
>  t/t2025-worktree-add.sh        | 18 ++++++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index c622345..48e5fdf 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -48,7 +48,8 @@ add <path> [<branch>]::
>  
>  Create `<path>` and checkout `<branch>` into it. The new working directory
>  is linked to the current repository, sharing everything except working
> -directory specific files such as HEAD, index, etc.
> +directory specific files such as HEAD, index, etc. The last branch you 
> +were on can be specify with `-` as `<branch>` which is synonymous with `"@{-1}"`.

You meant "can be specified", I think.  Fixing it would make the
line a bit too long, so fold it around the word "synonymous".

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 3acb992..b713efb 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -18,6 +18,24 @@ test_expect_success '"add" an existing empty worktree' '
>  	git worktree add --detach existing_empty master
>  '
>  
> +test_expect_success '"add" using shorthand - fails when no previous branch' '
> +	test_must_fail git worktree add existing -
> +'

Just an observation, but the error message we would see here might
be interesting.

> +test_expect_success '"add" using - shorthand' '
> +	git checkout -b newbranch &&
> +	echo hello >myworld &&
> +	git add myworld &&
> +	git commit -m myworld &&
> +	git checkout master &&
> +	git worktree add short-hand - &&


> +	cd short-hand &&
> +	test $(git rev-parse --symbolic-full-name HEAD) = "refs/heads/newbranch"

Broken &&-chain.

> +	branch=$(cd short-hand && git rev-parse --symbolic-full-name HEAD) &&
> +	test "$branch" = refs/heads/newbranch &&
> +	cd ..

If any of the command between "cd short-hand" and "cd .." failed,
after correcting the broken &&-chain, the next test will end up
running in short-hand directory, which it is not expecting.  A
canonical way to avoid this problem is to replace the above with:

	...
        git worktree add short-hand - &&
        (
		cd short-hand &&
                ...
                test "$branch" = refs/heads/newbranch
	)

In this particular case, alternatively, you could also do something
like this:

        git worktree add short-hand - &&
	echo refs/heads/newbranch >expect &&
	git -C short-hand rev-parse --symbolic-full-name HEAD >actual &&
	test_cmp expect actual

and it would be sufficient.

It is not immediately obvious to me why you have two copies of the
same test in your patch to see where HEAD points at.  If the reason
is because you suspect that "git -C $there" form may give subtly
different behaviour and wanted to test both, then you could do
something like this:

        git worktree add short-hand - &&
	echo refs/heads/newbranch >expect &&
	git -C short-hand rev-parse --symbolic-full-name HEAD >actual &&
	test_cmp expect actual &&
	(cd short-hand && git rev-parse --symbolic-full-name HEAD) >actual &&
	test_cmp expect actual

but I do not think that is necessary.  This test is not about "does
rev-parse --symbolic-full-name work correctly with 'git -C $there'?"

Thanks.
