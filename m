Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39B21ADAE
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391133; cv=none; b=FUKuF/xwmbTHvG9ySz+q+P8RU5affIWQQv8xIKoS/YtiJLCrG4GlQmPZx0d4ggqhKPJojY15O65bJkJ1iBshURCSy5atlyssq1SCmDgQB834Wn6y538zQVmWFfecE0jNd2wlGvnHoa3IYImoVNEMw0qFNuKJUNSELNKAzokPezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391133; c=relaxed/simple;
	bh=dhRf1mFfcv51B/2zFoJpu/4b5MOPYZEYzWsShDAAEfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avhjVO0rrBQEo1CWZoNFC1gXxZZs3Em6d5BnTD9nvpId3UPLIo7GE79e7nq5Hz+rsaPUgivQqmtrBrYPyp+q3xl9Rd7Vm/9gUljw9/skYaWh9cH5QTZKaHhJq5SSuLMfjs8Y0Dv9HYqrc8/MwBRF5ZVJXNf5PGC9o+UGVJWU6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfSN9678; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfSN9678"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb72d51dcso142661366b.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756391130; x=1756995930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT8bIG11VlgDAHqDgky7CwEDSwpPx3XeKU6g+aDolrQ=;
        b=UfSN9678enj/WIEQleWIbqJydwIN/LcA7fcHk1Iu/0fr38pZIXlbnTLQNMlWc0VuJy
         iJpNcVTRIyqoaS/eo6TnvFyLBY7ZWEatPBPXxGQQmv0nvvxwqh6VdebbGTScrRhHBpWh
         urmMIXEsqQyl4sGLh1a2rr7RBFQ+I6ZHyQehDh0JJZxLaIc8gM70qyQ5S4KOlH5hi/Od
         /QC64KDbMxhnaIINyY0icFefBdCAW9eCN9Hiianbvm9DJy0rhuv/qC/yczBcebOtY5aB
         5BGCsPcUbZK6yGnELAjw38Jed1qqyPsMAgmC9DO/+YvLxdX+MwWEB4ivDfQBlNthHd61
         A+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391130; x=1756995930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hT8bIG11VlgDAHqDgky7CwEDSwpPx3XeKU6g+aDolrQ=;
        b=vhNnWqcmuwX7ZAxkgjQkJZ28j/+4DR4cVHdCx9Y/nFayYucFo0a9qTaP0sZail359S
         s9bBSwglQfO9LMglcMSJPV6L6jWlMR7ZH6UXzmrQFw7bcLH4mzUSPqd4/pQ0+nOiPs+S
         RXLkfRrsJIAIsaNHkhSFjMlt87iq8oosPVWGIunxvcZ9cGhE01pljKBmbVUurx27MiNL
         AAtT5Fff7r5tTSxDbx3cxqRWHMzfVF0LK6IO34FVfCuhR5yXl6bjOj2/KHhlcEnxJbtv
         h8AXg1VOMRIpTXOqswq+2lBUT8w4WKiBXMpQUURITbdMEJZ/D3WmA/xdXwD39jCVHdQZ
         6jbw==
X-Gm-Message-State: AOJu0Yw0PbQqj9NPg5JVLjKg1E5r1E7O4HUeern5kQ2dD6G/ePbgJT54
	txZYcvhYISQmj08mtS2aEO5DUCzQkrD7jKzMUh8sYPIuqsiYlYrjB56s9UlonfBd06ksj40NNnU
	Ic6l2xwLxOeJ0vJdj6lFWcuQl6XKVTUNB407IZA4=
X-Gm-Gg: ASbGncsF38j3aHZMcgz4nYbtlOOZNkkiVFYNFXucPI7AVHcv/LH3XI07Xe8wTjBmy4r
	ZnI0adFQa7FGjURPhNIuOb0IAXOpuFwURWTzqLMZk1XUh0z09EwTbuQOIi4OJ058TB9e1D08zhF
	4ZNHxeH3DEEaMz7CDSdqPd+HVqirfCdEhJ+ZWL3FC7ZxTwItWRoYVWAAnegk7/cPxEqnFoTLbhG
	oP72XxGc+PWf01iaT4c3CqX71GiwiHa+pNCpXwDreZgcLe3piVZ
X-Google-Smtp-Source: AGHT+IEATD7sFh5zx7/1+489vLuUsMmB6oO36HGyHaslCnpFMbodJd4s0lPJ+UELvamgpjCce5L8sXZVU1X62WKD06M=
X-Received: by 2002:a17:906:6a0c:b0:afe:d218:3d28 with SMTP id
 a640c23a62f3a-afed218e4f8mr466114366b.55.1756391129617; Thu, 28 Aug 2025
 07:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com> <ac554cbe75444880bbb2791c4d85dcf083d833d7.1756240823.git.gitgitgadget@gmail.com>
In-Reply-To: <ac554cbe75444880bbb2791c4d85dcf083d833d7.1756240823.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 28 Aug 2025 10:25:17 -0400
X-Gm-Features: Ac12FXxuPiqmyQgympDYtfWExbPJv0I8mJquhshLDbxvH4X9oWLQcagqwaZy6pQ
Message-ID: <CALnO6CBTx=5Eo4WGW7HVMO1TQLmJ_kVdHDOsHf4ok_nPEER5WA@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: git-push: clarify "what to push"
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:40=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> - Be more explicit about what we're describing ("which branches" instead
>   of "what to push")

Reading this, I thought we would lose precision ("refspec" ->
"branches"), but: the patch (correctly) includes more than branches.
Perhaps

    - Be more explicit about what we're describing ("which branches,
[etc.]" instead of "what to push")

?

> - Split out the ways to specify which branches into a numbered list,
>   since there are 5 different ways to specify it and it's a lot to parse
>   in paragraph form
> - The explanation of "push.default=3Dsimple" is confusing to some users,
>   use an explanation more similar to the one in `man git-config`
> - Mention the most common case where push.default=3Dsimple is likely to
>   fail, and how to handle it
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-push.adoc | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index 5c934486c33d..0232195515c9 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -27,18 +27,21 @@ argument (for example `git push dev`), then if that's=
 not specified the
>  `branch.*.remote` configuration for the current branch, and then default=
s
>  to `origin`.
>
> -When the command line does not specify what to push with `<refspec>...`
> -arguments or `--all`, `--mirror`, `--tags` options, the command finds
> -the default `<refspec>` by consulting `remote.*.push` configuration,
> -and if it is not found, honors `push.default` configuration to decide
> -what to push (See linkgit:git-config[1] for the meaning of `push.default=
`).
> +To decide which branches, tags, or other refs to push, Git uses
> +(in order of precedence):
> +
> +1. The <refspec> argument(s) (for example `main` in `git push origin mai=
n`)
> +   or the `--all`, `--mirror`, or `--tags` options
> +2. The `remote.*.push` configuration for the current branch
> +3. The `push.default` configuration (See linkgit:git-config[1] for
> +   the meaning of `push.default`).
>
>  When neither the command-line nor the configuration specifies what to
> -push, the default behavior is used, which corresponds to the `simple`
> -value for `push.default`: the current branch is pushed to the
> -corresponding upstream branch, but as a safety measure, the push is
> -aborted if the upstream branch does not have the same name as the
> -local one.
> +push, the current branch is pushed to the branch with the same name
> +on the remote. The current branch must have a configured upstream with
> +the same name, so this will fail when pushing a new branch.
> +You can run `git push -u <repository> <current-branch>`
> +to configure the upstream.

I think we've lost the mention of `push.default` here, which we'd
probably like to keep?

Also, I (personally) dislike teach "git push -u <repo> <branch>"
because it leads to some confusion. Let me try to explain myself:
- The way Git treats the configured upstream is the place to pull
from, merge from, rebase onto, etc., configured by branch.X.merge and
branch.X.remote. There is a (possibly!) separate "push to" place
configured (somewhat confusingly) with push.default and
remote.pushDefault.
- The way GitHub and others encourage setting upstream to the place
you push means you have to work a bit harder to pull, merge, rebase
from the semantic upstream (the thing you forked from, not the place
you push to): "git pull <remote> <branch>", "git rebase origin/main",
etc.
- There is, of course, another way that upstream is used: for
"ahead-behind" information in Git's status output. It is convenient to
know where you stand, and Git unfortunately does not provide an easy
way to see the same information against @{push} instead of
@{upstream}. I use some version of "git show-branch HEAD HEAD@{push}"
and a custom "git-div" script [1] for this=E2=80=A6

Anyway, point is, I think defaulting to @{upstream} as the place you
push has a nice benefit ("git status" shows me when I haven't pushed
recently), but also is specific to a workflow where you push and pull
from the same places. I find that _most_ of the time I'm actually
doing something triangular (even when I push to and pull from the same
repository, I rarely push to and pull from the same _branch_), and
configuring things a different way affords me many other conveniences.
For example, "git push" and "git pull" without extra flags are
arguments just DWIM.

The confusion I alluded to earlier is that folks rarely learn this is
an option and (in my estimation) lose out on an essential aspect of
what makes Git distributed as opposed to centralized. It also leads to
some confusion over what the term upstream means. And the extra
"push.default explanation is sometimes inaccurate" doesn't help :)

I don't think this is a blocker for this patch, but I do have a bit of
a knee-jerk reaction to this particular piece of
(common-on-the-internet) advice :) Hope that makes sense.

[1]: https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-div

PS I seek a better way to explain this whole idea, so my apologies for
the confused rant.

--=20
D. Ben Knoble
