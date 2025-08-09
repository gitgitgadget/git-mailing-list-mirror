Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9BD1B0439
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754751355; cv=none; b=t6WazcAE0cHPidZ4ruFN8BqZr0DPeQ/oEiIaS9ZgRc0UqAeSqR4s4EvJkXjgqAaaGgMZjDJG34B0R2sScAYY/2tr7QQeB7XZXtd/ZQePjFzTCMwv7XnCalVIqyMeiPL7+qPcTLYo+rWppZhVNQSSulOxPcpIuGG7uu7bOyEpvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754751355; c=relaxed/simple;
	bh=LDXW1E4Slx4VfQBvOscQf6x8Yc0slbBEP2RAG8jYh7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3TKsm4Rd8vWu52QqIcP/xSUt/HGQaU13NBlMN1ZnfI4j6q7Md5W6oYUOSwSXpBNugIuJ9j2fbuZvEoS67TtQTCdRGGX0dYES8027mt1KF0p5felU5S360QisUYxNz5THj2OoMqCoMBk+wyiBFXb8L087aT/l+RkujzWmte+wtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF37AuB2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF37AuB2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af958127df5so463748966b.2
        for <git@vger.kernel.org>; Sat, 09 Aug 2025 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754751351; x=1755356151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgtoTE/ZDxm4eKtE3zRr5fk9+gEaLP3iFvN1WBF8fXo=;
        b=CF37AuB27CZMF1St8EMrHj+eggcydZORKiCVP8i57kOuN8gvpluwTk9/F3J4JI/Zr7
         BShp6n9eTA1qAu9bRjt9CPU/Iy9gdQzF+yWakO/3xYz5RbFTnVnJfUP7n5sgxCWNXMzV
         JJMrYQjrQhxoES6c+r8+kx9d4hA1yL7cgsVCxBck/Ns5CDZZeH4Tb0XObnFn7IBdKm60
         +PCP/GKzK3NLdQxY1E60t9gfmypndevV8UyZI4biAU8lsH8hRrQLnmz0WR7ZaMMO0dbW
         Ag9OoGRI4pB+k11HdMLqQ1xp+kF8v8kQYGscmLiK3gRvWr6N+azNynJTpubh/pUa0xP3
         dSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754751351; x=1755356151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgtoTE/ZDxm4eKtE3zRr5fk9+gEaLP3iFvN1WBF8fXo=;
        b=dqFMPkauNqunUY1R0Kqn50qb1emjA4ZaTe+G/2le/3+k+WV6QNH14EMYvcynSclkOl
         eeX7uM8CzRPPMg89GTBiwW3wSAk6vHbaFBwhiS5lYpMeyejvBy7qw9IFvDIeoY6BXOyw
         Nd9BHIzNbRrvd0U0DsrWD4hkYqflm/YJLGb4810E3SkOFCBV0SII6FWNrfXslEF+iTys
         UR7t4As8ry+eN4J6E/5U3/m+3Gdtvxtd64H/XVojMbnuclavLs4GF5HmAHXindqNiJGg
         XjJL/6HRygB7u2DXTd3fyc3lGFHzkYx/cegOvZW4NsNqC3nZAuCJlF1scQendLbc3bda
         563g==
X-Gm-Message-State: AOJu0YwiHELPqPPQaHo8qwN8rsZjaOvhfriOISOILMLFrRFzMRdEzWx3
	2guj+Yp0KEWJMQpp3vzvW26z6YCOORXst/XgfDrs6ghJrOOAcJ4gvhPnE+5Q+HX2Jv4EKFUt+0Q
	/mHSeR4ihSz4X/r6di0XS7lHiT57ttMU=
X-Gm-Gg: ASbGncvd9RC6g8KsOTgRqPfDdU1U2aX8Aelwl1zaK+wJHI40j/hdwZ5ObDd8V6+xrJ/
	aH97PAFJMwAc7FqXymqJKwlUV+p/wHctNVC30M2Dq0aLqIalHlJw8aaD4zymmxnxX1Wl5T3gQSu
	iDnqwIyVnHEE6XmOMUlbqkcEQJ44XaLg1NIHNBalEChcbyV2fl1XMMJz1+zLMstHruKO5u/Higm
	ErQKYy6MQbHwM8ukajq2K7SErRyRB77S54C6ESQPw==
X-Google-Smtp-Source: AGHT+IH3zeRh9rYSAP2MHNvgee6d85fv4t295fVgIC23rCeG4gAfl4kuLh7hz8bMbhMkALFyUbmNjs94OhB29EFuuNg=
X-Received: by 2002:a17:907:c25:b0:ade:316e:bfc with SMTP id
 a640c23a62f3a-af9c6457eb7mr575574166b.21.1754751351274; Sat, 09 Aug 2025
 07:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com> <b37ebc8389d1c1df0f0114d9105e774d745e4361.1754702057.git.gitgitgadget@gmail.com>
In-Reply-To: <b37ebc8389d1c1df0f0114d9105e774d745e4361.1754702057.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 9 Aug 2025 10:55:40 -0400
X-Gm-Features: Ac12FXxDU0OtRiBCzSXNS7J6qmVXBqvAUZ9eiaFW3oekOVso94x40XcqgOMC4Oo
Message-ID: <CALnO6CBxrNKM4oNNQHbyq7K9unA6=uu3JSxWPV1gwnUZ0=LNfg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] doc: git-rebase: move --onto explanation down
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:14=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> There's a very clear explanation with examples of using --onto which is
> currently buried in the very long DESCRIPTION section. This moves it to
> its own section, so that we can reference the explanation from the
> `--onto` option by name.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-rebase.adoc | 168 ++++++++++++++++++----------------
>  1 file changed, 87 insertions(+), 81 deletions(-)
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.ado=
c
> index 914f743ae00f..50c84f138212 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -111,87 +111,6 @@ will result in:
>      D---E---A'---F master
>  ------------
>
> -Here is how you would transplant a topic branch based on one
> -branch to another, to pretend that you forked the topic branch
> -from the latter branch, using `rebase --onto`.

I wonder if we should leave a pointer to the reader to the new section
here, also? The onto mode is not quite as common in my workflow as the
other modes, but when helping less experienced users out I often end
up using it, so keeping some reference to it early might be nice. IDK
where a natural point is, though.

> -
> -First let's assume your 'topic' is based on branch 'next'.
> -For example, a feature developed in 'topic' depends on some
> -functionality which is found in 'next'.
> -
> -------------
> -    o---o---o---o---o  master
> -         \
> -          o---o---o---o---o  next
> -                           \
> -                            o---o---o  topic
> -------------
> -
> -We want to make 'topic' forked from branch 'master'; for example,
> -because the functionality on which 'topic' depends was merged into the
> -more stable 'master' branch. We want our tree to look like this:
> -
> -------------
> -    o---o---o---o---o  master
> -        |            \
> -        |             o'--o'--o'  topic
> -         \
> -          o---o---o---o---o  next
> -------------
> -
> -We can get this using the following command:
> -
> -    git rebase --onto master next topic
> -
> -
> -Another example of --onto option is to rebase part of a
> -branch.  If we have the following situation:
> -
> -------------
> -                            H---I---J topicB
> -                           /
> -                  E---F---G  topicA
> -                 /
> -    A---B---C---D  master
> -------------
> -
> -then the command
> -
> -    git rebase --onto master topicA topicB
> -
> -would result in:
> -
> -------------
> -                 H'--I'--J'  topicB
> -                /
> -                | E---F---G  topicA
> -                |/
> -    A---B---C---D  master
> -------------
> -
> -This is useful when topicB does not depend on topicA.
> -
> -A range of commits could also be removed with rebase.  If we have
> -the following situation:
> -
> -------------
> -    E---F---G---H---I---J  topicA
> -------------
> -
> -then the command
> -
> -    git rebase --onto topicA~5 topicA~3 topicA
> -
> -would result in the removal of commits F and G:
> -
> -------------
> -    E---H'---I'---J'  topicA
> -------------
> -
> -This is useful if F and G were flawed in some way, or should not be
> -part of topicA.  Note that the argument to `--onto` and the `<upstream>`
> -parameter can be any valid commit-ish.
> -
>  MODE OPTIONS
>  ------------
>
> @@ -237,6 +156,8 @@ As a special case, you may use "A\...B" as a shortcut=
 for the
>  merge base of A and B if there is exactly one merge base. You can
>  leave out at most one of A and B, in which case it defaults to HEAD.
>
> +See TRANSPLANTING A TOPIC BRANCH WITH --ONTO below for examples.
> +
>  --keep-base::
>         Set the starting point at which to create the new commits to the
>         merge base of `<upstream>` and `<branch>`. Running
> @@ -1015,6 +936,91 @@ consistent (they compile, pass the testsuite, etc.)=
 you should use
>  after each commit, test, and amend the commit if fixes are necessary.
>
>
> +TRANSPLANTING A TOPIC BRANCH WITH --ONTO
> +----------------------------------------
> +
> +Here is how you would transplant a topic branch based on one
> +branch to another, to pretend that you forked the topic branch
> +from the latter branch, using `rebase --onto`.
> +
> +First let's assume your 'topic' is based on branch 'next'.
> +For example, a feature developed in 'topic' depends on some
> +functionality which is found in 'next'.
> +
> +------------
> +    o---o---o---o---o  master
> +         \
> +          o---o---o---o---o  next
> +                           \
> +                            o---o---o  topic
> +------------
> +
> +We want to make 'topic' forked from branch 'master'; for example,
> +because the functionality on which 'topic' depends was merged into the
> +more stable 'master' branch. We want our tree to look like this:
> +
> +------------
> +    o---o---o---o---o  master
> +        |            \
> +        |             o'--o'--o'  topic
> +         \
> +          o---o---o---o---o  next
> +------------
> +
> +We can get this using the following command:
> +
> +    git rebase --onto master next topic
> +
> +
> +Another example of --onto option is to rebase part of a
> +branch.  If we have the following situation:
> +
> +------------
> +                            H---I---J topicB
> +                           /
> +                  E---F---G  topicA
> +                 /
> +    A---B---C---D  master
> +------------
> +
> +then the command
> +
> +    git rebase --onto master topicA topicB
> +
> +would result in:
> +
> +------------
> +                 H'--I'--J'  topicB
> +                /
> +                | E---F---G  topicA
> +                |/
> +    A---B---C---D  master
> +------------
> +
> +This is useful when topicB does not depend on topicA.
> +
> +A range of commits could also be removed with rebase.  If we have
> +the following situation:
> +
> +------------
> +    E---F---G---H---I---J  topicA
> +------------
> +
> +then the command
> +
> +    git rebase --onto topicA~5 topicA~3 topicA
> +
> +would result in the removal of commits F and G:
> +
> +------------
> +    E---H'---I'---J'  topicA
> +------------
> +
> +This is useful if F and G were flawed in some way, or should not be
> +part of topicA.  Note that the argument to `--onto` and the `<upstream>`
> +parameter can be any valid commit-ish.
> +
> +
>  RECOVERING FROM UPSTREAM REBASE
>  -------------------------------
>
> --
> gitgitgadget
>
>


--=20
D. Ben Knoble
