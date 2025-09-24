Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D07328968
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745063; cv=none; b=eGIFpGX3DBsaaNDt+sKPoeslH3/msOsWvhe8laURSRqiauWB5k0f4n9tE8rVen2NHZiVEXGyY9G7L+PeQAq/nRE+PI7IDEKZJe+Z/FlUMnq6ISQi7m+ytoelt3GfIYq/GMKZ/0/yc0Wz1cCKq/2RW/oFMM/L8gztvxJ7KKX52qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745063; c=relaxed/simple;
	bh=dNb2j1fh7A7axGFpTwMgBW4I9BznXEnjX5dB1x79J7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH8EVZg8qHwuIqgSr33mA6XItrAjYmSkHIQrtwZd4h12Oq22AIfU0jSVlpTiwjhyBbzn4Mha+eD+f7J+yZpC88tw9UZhvQVrmdR253mSNw3xhTksokhQ/GrMmi9Gc14/qsi6thR96a99lJiANZjqtImiTn1Ul++aWFh82KyTOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UekeODoO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UekeODoO"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fbd0a9031so309580a12.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758745060; x=1759349860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1JS/YSc7w/l43jcLYfZswfZ6caR1dJULLMUL52NMmQ=;
        b=UekeODoOg723A1R/EkQ7SkaX7CmOutCZ808P+nh6Jj7aG99uJsrf1uXpNSWs/50gj/
         dgcpdlbS4Cm5dcipLowSESKMngj5imZjdAtMZV8lXppcHRJXwrvMkDsBJo9NeuG13pm5
         I/k3S3vugCEwPQtjILzneplB5xTCWJtUdWPskyVe56fjbBCSmLi/mDqNYCgbKE2hmqr+
         T+ypgDAKr/wz57qzizupFtAEHEOrPqfNhk7LtxpAi8gp8c4UCgF/57L/3m8awhbun7rG
         l9GP6rachiWbHFMZ+DJ+zwzVCkO+K8DGXybbOJuSoMc0kBhnX7kSolIdfKXlLLhFXken
         tshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745060; x=1759349860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1JS/YSc7w/l43jcLYfZswfZ6caR1dJULLMUL52NMmQ=;
        b=LOXN1jh9RZqkefWuLkZK53a3SuygVLXbo1vjKhCw6gEwmlNClXgk79X3m9hTAse5ms
         LH84jN+I6zgKphtAIdCbib91ituu13msVuMAH+JLtGWqSuNTCVQP1B4YmAtuEc084agB
         m4dolarwgDYyBUCsyoh9JdgikCjBYtUcGAampHFZ94oYos4Dj8z8oAf/xDaf0SdMbbnp
         665Ntuc9fE6K/gph3fF1aUCr/l7mnPU7IWT5RxbaioRYflMgWodlhQvGTUPf7sc/5v39
         S7bgG/GMWrwoBA3RrEtS4wm2wSe/BJGDFGXqv4VB7z/xdlv3Nc5DIysTqYzk8g77aORH
         jjYw==
X-Gm-Message-State: AOJu0YxsC/PHdx4xOp1GSOY/em2/tXSmXw+MuDpYXumid4rB8k6nbWWr
	qUQKPgvp8PlkoI9Lsm6WQ5vol0C9CLV+GZG9uw/7cSfOdMgAy+XLZEKOzCZYFQa5VUxv7ELuQ4/
	HtwJsrafxZlgREGie6XgnuMbUIpZINoE=
X-Gm-Gg: ASbGncvoDEAc+BVawfAaNKlHNHI4bsYRrsszE2Oo3I2ubqpa6+dtvUfXSk2WQhMp8HP
	D6eXwBAf1mSvJ1JfEtwk/EUo+f6pYB/NyABOc5bTX4T75ygeVn3UPHHMES0rudOd/uSmnjMBpvL
	DVQ5DbytKvGG5IoUKaAlw1YC84ShkGxbLcftEJGibaODUt+cXBzQZ6mhf+4g16cCFJkRRxc/TXn
	UIGapshhCkH35vojhArazweyTd1Izy4ysQd2nqBWw==
X-Google-Smtp-Source: AGHT+IG0s1+G/gYf63yvRVSCZSaPHLd96UDapmHMOn0+rsMU+afpkOszJXHtYpSt0P0PJgdwgOLWUSgfB+it4SHC7Xw=
X-Received: by 2002:a05:6402:52dc:b0:634:505c:fc9b with SMTP id
 4fb4d7f45d1cf-6349fa82c3cmr560657a12.28.1758745059954; Wed, 24 Sep 2025
 13:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com> <f69d2e6fabbace9ae76cb3822b063a3f19622138.1758656702.git.gitgitgadget@gmail.com>
In-Reply-To: <f69d2e6fabbace9ae76cb3822b063a3f19622138.1758656702.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 24 Sep 2025 16:17:28 -0400
X-Gm-Features: AS18NWDv5C8qMn-8PGhYVz8A33Hyih5hLnD7f-fcmjZKYd_U_txGGAcXl2d75Os
Message-ID: <CALnO6CCQhTR77nvjPM-fhTm9o6imjw9Erk0NMWhLMYrSAWW8hw@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: git-pull: move <repository> and <refspec> params
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:45=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> From user feedback:
>
> - it's confusing that we use both <branch> and <refspec> to refer to the
>   second argument

Yep.

> - one user is not clear about what `refs/heads/*:refs/remotes/origin/*`
>   is meant to be an example of ("is it like a path?")

Also yep, since the deleted text doesn't contain any pointers to learn
what a refspec is.

> The DESCRIPTION section is also doing a lot right now: it's trying to
> describe both how the <repository> and <refspec> arguments work (which
> is pretty complex, as seen in the DEFAULT BEHAVIOUR section)
> as well as how `git pull` calls `git fetch` and merge/rebase/etc
> depending on the arguments.
>
> Handle this by moving the description of the <repository> and <refspec>
> arguments to the OPTIONS section, so that we can focus on the
> merge/rebase/etc behaviour in the DESCRIPTION section, and refer folks
> to the later sections for details.

I generally like this: it makes things a bit more consistent, even
though "options" isn't quite how I think of these (optional!)
positional parameters. Still, I generally jump down to the <arg>
sections (like in git-push(1)) to learn what I can do with those.

> Use the term "upstream" instead of 'the "remote" and "merge"
> configuration for the current branch' since users are more likely to
> know what an "upstream" is.

With the upstream section, great.

> diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
> index 48e924a10a..50af7fde81 100644
> --- a/Documentation/git-pull.adoc
> +++ b/Documentation/git-pull.adoc
> @@ -27,17 +27,6 @@ and then depending on configuration options or command=
 line flags,
>  will call either `git rebase` or `git merge` to reconcile diverging
>  branches.
>
> -<repository> should be the name of a remote repository as
> -passed to linkgit:git-fetch[1].  <refspec> can name an
> -arbitrary remote ref (for example, the name of a tag) or even
> -a collection of refs with corresponding remote-tracking branches
> -(e.g., refs/heads/{asterisk}:refs/remotes/origin/{asterisk}),
> -but usually it is the name of a branch in the remote repository.
> -
> -Default values for <repository> and <branch> are read from the
> -"remote" and "merge" configuration for the current branch
> -as set by linkgit:git-branch[1] `--track`.

And we don't even mind losing "--track" here because we cover it in
Upstream Branches (e.g.,
https://lore.kernel.org/git/3ecfb5c3a67723f160e8161e212d77f95964539c.175864=
9472.git.gitgitgadget@gmail.com/).

> -
>  Assume the following history exists and the current branch is
>  "`master`":
>
> @@ -77,6 +66,24 @@ pulling or stash them away with linkgit:git-stash[1].
>  OPTIONS
>  -------
>
> +<repository>::
> +       The "remote" repository to pull from.  This can be either
> +       a URL (see the section <<URLS,GIT URLS>> below) or the name
> +       of a remote (see the section <<REMOTES,REMOTES>> below).
> ++
> +Defaults to the configured upstream for the current branch, or `origin`.
> +See UPSTREAM BRANCHES below for more on how to configure upstreams.
> +
> +<refspec>::
> +       Which branch or other reference(s) to fetch and integrate into th=
e
> +       current branch, for example `main` in `git pull origin main`.
> +       Defaults to the configured upstream for the current branch.
> ++
> +This can be a branch, tag, or other collection of reference(s).
> +See <refspec> below under "Options related to fetching" for the full syn=
tax,
> +and DEFAULT BEHAVIOUR below for how `git pull` uses this argument to
> +determine which remote branch to integrate.
> +

I think these are covered in Documentation/pull-fetch-param.adoc,
which I only found by looking at "git help pull" and searching for the
URLs references, hah.

Anyway, the existing explanations are far too late in the manual (Vim
says ~46%, 960 lines down, when rendered with MANWIDTH=3D80). Moving
them up is a good idea, but maybe we need to do that in a way that
jives with the later "fetching" section. Hm.

--=20
D. Ben Knoble
