Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07085288DB
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340178; cv=none; b=oKIQeBIumwiNJ8740j2gWres+xDy9nkDDvDLgwAEYwyBZFV098FcZckB5+wJUo649faAbYt8dHo+T6E6hpG+qcKv2oH/N8KfCsbymScn3/qA3Rb7/8SYMVJfqkPU1QKu3A4i/Pakw58eYPDJXD62UggokVIxgID6geH5gtmhrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340178; c=relaxed/simple;
	bh=282pDPnsPSTPkwSDFeC2JVPtOUCZTTbbklX5PvfEymE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roh6+BJKf7X58WZjtIoilfj7ongi8jwWJiwp/NHefzcEVKCSjBFWjRj//VT55VDUkJ2llG+Nsu0RUHVQcmQaDq2ka6N4J7C6R0acRsoaeBF516cN54jlmTlQkY++LhPJWKsOzHUXqNewTeuaOVyFI8fcOem4S3XzUht3uFgBPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=dUR/tEO8; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="dUR/tEO8"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:f5ae:5744:1198:6c76])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 4E09113F89A;
	Wed,  1 Oct 2025 19:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1759340174;
	bh=282pDPnsPSTPkwSDFeC2JVPtOUCZTTbbklX5PvfEymE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUR/tEO8XetTTt8x/E0k9AYbY/5RM6Wor25YSlVEXeIrx95B/7JoL4Az/IxxH+eXF
	 IriEVln+6ulCWoeBXvqm6uALb1ccAWQSiLTkw4xt4HtFv3h8l4tlT7Yvf/uDd8gL/a
	 eik0UMoGS0Av1sas80SUnhs+1n4WyaKxn87Cc5ar5DLZUDwxGPLRtTm2iyLhyf2CZA
	 Gn5l3K65CtVM3TH3zI1n2FQYoi3BlQjTAfCbUZzBXLOv4K7m5Zamu9nBchulbwaNC/
	 ZaBzLezom4fWcmVqsPzH7qC/KEPeg0yN2IeWMFnUiHFBvW63dpnvIeZo2PDYf61ual
	 OSngMtwtT9zaA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Julia Evans <julia@jvns.ca>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 4/5] doc: git-push: clarify "what to push"
Date: Wed, 01 Oct 2025 19:36:09 +0200
Message-ID: <5015949.GXAFRqVoOG@cayenne>
In-Reply-To:
 <c1d4ea8d27ff037fcc40c2c6dc1c4f0bd9000b1b.1759262314.git.gitgitgadget@gmail.com>
References:
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <c1d4ea8d27ff037fcc40c2c6dc1c4f0bd9000b1b.1759262314.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 30 September 2025 21:58:33 CEST Julia Evans via GitGitGadget 
wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> From user feedback: 6 users says they found the "what to push"
> paragraphs confusing, for many different reasons, including:
> 
> * what does "..." in <refspec>... mean?
> * "consult XXX configuration" is hard to parse
> * it refers to the `git-config` man page even though the config
>   information for `git push` is included in this man page under
>   CONFIGURATION
> * the default ("push to a branch with the same name") is what they use
>   99% of the time, they would have expected it to appear earlier instead
>   of at the very end
> * not understanding what the term "upstream" means in Git
>   ("are branches tracked by some system besides their names?"")
> 
> Also, the current explanation of `push.default=simple` ("the
> current branch is pushed to the corresponding upstream branch, but
> as a safety measure, the push is aborted if the upstream branch
> does not have the same  name as the local one.") is not accurate:
> `push.default=simple` does not always require you to set a corresponding
> upstream branch.
> 
> Address all of these by
> 
> * using a numbered "in order of precedence" list
> * giving a more accurate explanation of how `push.default=simple` works
> * giving a little bit of context around "upstream branch": it's
>   something that you may have to set explicitly
> * referring to the new UPSTREAM BRANCHES section
> 
> The default behaviour is still discussed pretty late but it should be
> easier to skim now to get to the relevant information.
> 
> In "`git push` may fail if...",  I'm intentionally being vague about
> what exactly `git push` does, because (as discussed on the mailing list)
> the behaviour of `push.default=simple` is very confusing, perhaps broken,
> and certainly not worth trying to explain in an introductory context.
> `push.default.simple` sometimes requires you to set an upstream and
> sometimes doesn't and the exact conditions under which it does/doesn't
> are hard to describe.
> 
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-push.adoc | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index acdf25e5cd..2848cf2e1f 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -26,18 +26,20 @@ that isn't already on the remote.
>  The `<repository>` argument defaults to the upstream for the current 
branch,
>  or `origin` if there's no configured upstream.
> 
> -When the command line does not specify what to push with `<refspec>...`
> -arguments or `--all`, `--mirror`, `--tags` options, the command finds
> -the default `<refspec>` by consulting `remote.*.push` configuration,
> -and if it is not found, honors `push.default` configuration to decide
> -what to push (See linkgit:git-config[1] for the meaning of `push.default`).
> -
> -When neither the command-line nor the configuration specifies what to
> -push, the default behavior is used, which corresponds to the `simple`
> -value for `push.default`: the current branch is pushed to the
> -corresponding upstream branch, but as a safety measure, the push is
> -aborted if the upstream branch does not have the same name as the
> -local one.
> +To decide which branches, tags, or other refs to push, Git uses
> +(in order of precedence):
> +
> +1. The `<refspec>` argument(s) (for example `main` in `git push origin 
main`)
> +   or the `--all`, `--mirror`, or `--tags` options
> +2. The `remote.*.push` configuration for the repository being pushed to
> +3. The `push.default` configuration. The default is `push.default=simple`,
> +   which will push to a branch with the same name as the current branch.
> +   See the <<CONFIGURATION,CONFIGURATION>> section below for more on

Good: using the cross-reference with custom label is translator's friendly.  
Thank you.


> `push.default`. +
> +`git push` may fail if you haven't set an upstream for the current branch,
> +depending on what `push.default` is set to.
> +See the <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> section below for more
> +on how to set and use upstreams.
> 
>  You can make interesting things happen to a repository
>  every time you push into it, by setting up 'hooks' there.  See
> @@ -696,7 +698,7 @@ a `git gc` command on the origin repository.
> 
>  include::transfer-data-leaks.adoc[]
> 
> -CONFIGURATION
> +CONFIGURATION[[CONFIGURATION]]
>  -------------

Same remark concerning anchors.

Otherwise, LGTM




