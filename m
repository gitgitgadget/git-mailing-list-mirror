Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76915C0
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745404; cv=none; b=urtOLaR0l+mB2/a4M2Wts6lAO2Pa2xzSIKG4IbMjXqWmYD83uSqK3P0Iq21I8pruK3Bcn/i4M7Z/oZgB1NT/3JvD7F3898uv53SZiud+X2Y9H70+FmQe7IqBZl7E6PgNnXwHsDt4pjijxNQL0g4L+/HF3EVQfq+3bZgavaPo9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745404; c=relaxed/simple;
	bh=ZaPQlwa0Nia1PYVBgyFRCDncWPpDRHqZsKkLOhP/54c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiThFPbOFgFhfYYV+rGol/kZRXMS0r4ShbrW0fyCon9njwKvODdZ5I7gMPze2zv6cLMnC3fQYcWYRA+wlNxqfx7w3SknQjmKcc9wZrUW0xTbQHrFJJiCqrKbqYvyy0ag78mbDzbXlGtlsnNlXSYfPRscjm4snyokvXvUBtOVcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j57Oi55J; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j57Oi55J"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso426039a12.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758745401; x=1759350201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTyATe/LW96AazmFXqMXAXEueT7NGKNjswTAf6HyzEo=;
        b=j57Oi55JA3XMD2kj3g28j7J/NYkvjtKH9x8cwlhbkelMQcOFGahbL7XeyFIdqVzr0T
         LDgghGwPbTM+Y7vgSass0ufN3UWPWV8rQ+ajHLZP0JlocqBAuSSPrkGFiP1gkZaaV7du
         5W7lic2KhLMgxYRZKzJUxhj7vJGe6fOczRosLVR41ONG78Nwx3CJQwfFJn63FS6vZETN
         JatFvy4frzA/nyL/e6eye8WLWNNl7TiIraaO/YiYaC/5RxaOciwqmocqzPztCIDfDHzv
         Stbvj+xbqn/cie8aVpkG6D20/ZIjTejOllx45WllkUnBj0/tL0pTFEpakoUkcxxxnnf5
         oHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745401; x=1759350201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTyATe/LW96AazmFXqMXAXEueT7NGKNjswTAf6HyzEo=;
        b=r5jbTCj8McCuGlw2VReychnlS6OJArrggdRJpEVazvA5qxhzQliBI54AYFIcuRZ+tI
         nvKsNlQ9NY5oCJyFbEi0SnJUbpsmXWFJkNsUG3DbkdVTgQTgJi4I0OAwTmYU4XsCfNg/
         xs8w4B9VKvdXiS2JsliIJOP4Uum6SYoGWj4IH8ZII+OFmfRwMvAVM08kUr8QzY/l2Mnu
         64T17OWuTonwGei/z3MAf8iIt3VZYTMedI5fNKr6GZcepPHy92EDMSG7ejYVKsg+AXdm
         6WgHcAZCGVEF3V68bVe0O3uj0PolAKmu7g4zFnejEwBqz7Ga+9Fz5jKZpqiRQZRKU6St
         BcEA==
X-Gm-Message-State: AOJu0Yy4ixWq2yXk5sAj78j9K3vjWu09BtofS/0aVM+jfMjwcxYeDu96
	DRZesqAIook0WO1TQ/yGqnxhMZSCkRKuXrKgwTEsaVnK8BZn5QH9CKl6oEnrR7YkD25DrKH7yy9
	/xKUn6vZsZQsIlYpqyeP5lgVrDyzf0YU=
X-Gm-Gg: ASbGncuTobernkxXHAqS26Ai6EkrtFYYOmYxycVUa3+BZffse2dnFtXQNS93/ubTGHp
	fWG7ikoo6N35NmVg/YtFzlj9yUVs0eu/vPxwi4sqpwbdZz2N98Nfhht7JVaNPW9q0Ksa3m3bjWb
	li402e2xjRmhjizqmJs3hWcDUuGM6/gV95JcHNzx76OPtL89hOrWJ43zxxlj5jdHSC8hXDT5BtK
	VWlHWYOOMwwFk88uH7NRLybYS9kN3NjE6zJKf9mYg==
X-Google-Smtp-Source: AGHT+IHEzX0czKUvHVVBBrnVJnc8iyQ59Me+5/By75UiXsIX6yVZQ6+ozPhGPEKkzUaiig2eJfL5phm4F/wGd5LHiEE=
X-Received: by 2002:a17:907:7faa:b0:afe:8761:e77a with SMTP id
 a640c23a62f3a-b34b79c4a58mr119962066b.19.1758745400695; Wed, 24 Sep 2025
 13:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com> <ffbb9d7c6aff77f9a1caed86a20bcc6b9afe66e7.1758656702.git.gitgitgadget@gmail.com>
In-Reply-To: <ffbb9d7c6aff77f9a1caed86a20bcc6b9afe66e7.1758656702.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 24 Sep 2025 16:23:09 -0400
X-Gm-Features: AS18NWC4QCDMygbf6LxG7j-s3YFhzfBBDgajmwLATIvHW487owimDOQzwJkwmEk
Message-ID: <CALnO6CCkWaxZKGseHR7dk20erFPAvGMqO+OYr3Np+y+=1Y34HA@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: git-pull: clarify options for integrating remote branch
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:48=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> From user feedback:
>
> - One user is confused about the current default ("I was convinced that
>   the git default was still to merge on pull")
> - One user is confused about why "git fetch" isn't mentioned earlier
> - One user says they always forget what the arguments to `git pull` are
>   and that it's not immediately obvious that `--no-rebase` means "merge"
> - One user wants `--ff-only` to be mentioned
>
> Resolve this by listing the options for integrating the the remote
> branch. This should help users figure out at a glance which one they
> want to do, and make it clearer that --ff-only is the default.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-pull.adoc | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
> index 50af7fde81..61d18fef36 100644
> --- a/Documentation/git-pull.adoc
> +++ b/Documentation/git-pull.adoc
> @@ -15,17 +15,20 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>
> -Incorporates changes from a remote repository into the current branch.
> -If the current branch is behind the remote, then by default it will
> -fast-forward the current branch to match the remote.  If the current
> -branch and the remote have diverged, the user needs to specify how to
> -reconcile the divergent branches with `--rebase` or `--no-rebase` (or
> -the corresponding configuration option in `pull.rebase`).
> -
> -More precisely, `git pull` runs `git fetch` with the given parameters
> -and then depending on configuration options or command line flags,
> -will call either `git rebase` or `git merge` to reconcile diverging
> -branches.
> +Integrate changes from a remote repository into the current branch.
> +
> +First, `git pull` runs `git fetch` with the same arguments to fetch

Hm. Is it worth saying "similar" rather than "same" since we don't
pass e.g. `--rebase` to `git fetch`? Or is that detail unimportant in
this context?

> +remote branch(es). Then it integrates the remote branch into the current
> +branch.

Plural-singular here leaves me wondering how Git decides which of
multiple fetched branches to integrate. A quick test of the form

    git pull origin refs/heads/\*:refs/remotes/origin/\*

just gives an error in every mode I tried, so I'm now confused about this u=
se :)

I _do_ like that when I "git pull", Git will fetch all branches if I
have fetch.all set. That seems related but different. Welp, more
corners to explore!

> There are 4 main options for integrating the remote branch:
> +
> +1. `git pull --ff-only` will only do "fast-forward" updates: it
> +   fails if the remote branch has diverged. This is the default.
> +2. `git pull --rebase` runs `git rebase`
> +3. `git pull --no-rebase` runs `git merge`.
> +4. `git pull --squash` runs `git merge --squash`
> +
> +You can also set the configuration options `pull.rebase`, `pull.squash`,
> +or `pull.ff` with your preferred behaviour.

Lovely.

--=20
D. Ben Knoble
