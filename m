Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B09221FBE
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746898198; cv=none; b=Tty43utmU1CF2f9SPCov1DeOPeR9Yk/FzV2kBayRWGabzz5mPjobPa9/P9VQgElb90EbGRZDzd+soBmSIsypN0tfA18OxQ/AfrLG7RHho3vDUR2PFPGZS47qJGBcCofElD0bImUijY9uE+0Jp1xmkcsjVjYxggMUWKZLetJ4dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746898198; c=relaxed/simple;
	bh=va+vTP7DBdmVEJIcdbyDYMAnRRPjYbxY8BvE7ymgTMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE14MXIMq8aMmg0oJLF7bXvhR0B/ccFwKFVjoOqrekgl7KDaPz4pmlxosCMSvlUEZQKyztkeAO55Y7MpjSGiLr/euaVfpqX/OO1jO59LXbIzCwCZ0v1Y3otG9Cifr8zD0V6k/Xfw7PwUCk2ZXoj7AxqgZ0huccwJWhfWBzMpRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlA1ljAu; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlA1ljAu"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85dac9729c3so294481639f.2
        for <git@vger.kernel.org>; Sat, 10 May 2025 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746898196; x=1747502996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xihZ+aI0eaMIiq9EXW0WzR4nhZ78Ju0r6vFe9dzU56M=;
        b=YlA1ljAuBXi0UoK88Z7RWVWmsY5yaNUyVIy0x+gozTOFFA9zWLmWQj1QpFP0XTN3+3
         Tp369YjAhAP///gL1CvGyE5lRIU8vZxkl8LycNNvjzvcrQy8BcdZ0ITkkV8gL+N2poUN
         Lma0b8PDlSAOPKqJ4yx/yxz6hK1JN5cB0Yt/Woi9nD+ZAK+T7GoK2DnNesf28XgfKdnQ
         XEunFLJNtvMOoY/AitMvJ9O6JwkVe5+qNGG/cg9/B5u3kH/n+D2H+2ulZGPIkqY5yqoQ
         C7DNVKIQIDLWM4zyYGfbL85qyz7eiSyDUvy4txYQ6Y/L/thLukXdMAaj7XY2CAEdlDVt
         dXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746898196; x=1747502996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xihZ+aI0eaMIiq9EXW0WzR4nhZ78Ju0r6vFe9dzU56M=;
        b=dZpUrPr3PmnO2YAnR2QQ2IQO+vdT0axZRIeN3/NHjzL+TPj+PB89UvJtRBjQRRKWHW
         Szzj3jeD/5q0nsojL/aSseDgwc7FlA5rb85cWoMib5tCsHb9lyUTLf+xAUC7EQs6HOMe
         /ivA0lL7GouVCQgP91HxBdpCzLIui/Qs1D/pyG6W+rRAWP3QJAhCSoQAbZ2vMw0eU7V+
         hg+UvNaA2GxGCdgzJ62SBo+EtrDGKMisP/B+Tr7ceJtcYu9oDrMza/Osd2++pg/GwNH9
         SVbiuiSgHpmnd/e69EIunUkwDUt5auSXqWf55pbAk8QIYGm+NXz+e/+Z1VdHA1oHhzub
         WXmw==
X-Gm-Message-State: AOJu0YyzsA+FolfcxiSXqUwvusmVFg9+hDzClQeYwI17v+ReJe+ij4gc
	pmosm4zSW7TGLLVIae6+3ISiC16x8+h9iKQW4H/L1PJHEOgcQiWvMRW7qSXKclsSa2e7SAyo53o
	abeXQJRrzfcD6w/XjurrRrkn/mVYof+SOScw=
X-Gm-Gg: ASbGncuo/wHpueTh4JUQXdynzhVNOTcFTI7MzFUf1KFsWHi9O9K6Vko1pByTFwNnIR4
	yRdtJcVQLNn74Ek5G3SbMpGa2NM5U6Xl5y2HN3SNEmGQH53fJiJel12q51lx7Qrs4aTKqu1NGL0
	o/7xWkbChI9mxoDAwwMMLQiZmRRHuz3S2u802uKvYDGVJchRCZ/Gn+D6fHE52owfsGHeld/ayGz
	D/v
X-Google-Smtp-Source: AGHT+IFcS8MSLEwImtZ3MeXuI2bcqEr9c0KHvX4R0PzqIllypQ7iZo8tDvBjFF8OAy/iKS0dR5EDsdIunHJRoPexBio=
X-Received: by 2002:a05:6e02:3185:b0:3da:7356:cca2 with SMTP id
 e9e14a558f8ab-3da7e213d19mr102739515ab.20.1746898196141; Sat, 10 May 2025
 10:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2281c960-7750-4319-8042-dade0ddfff67@irif.fr>
In-Reply-To: <2281c960-7750-4319-8042-dade0ddfff67@irif.fr>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 10 May 2025 10:29:45 -0700
X-Gm-Features: AX0GCFvKHGoS36ol6V2vgpj5lRSFoI-2F1B_uY7LUAOLsdyfJXbRiNdarP1antY
Message-ID: <CABPp-BEM4Ex6AF1PNs4V2MA5x0sWM0vs1e_G7EL-CGpihXnTJA@mail.gmail.com>
Subject: Re: sparse-checkout and symlinks?
To: Gabriel Scherer <Gabriel.Scherer@irif.fr>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 9:05=E2=80=AFAM Gabriel Scherer <Gabriel.Scherer@ir=
if.fr> wrote:
>
> Dear git list,
>
> sparse-checkout interacts badly with symlinks within a git repository:
> if b/file is a symlink to a/file, and the user asks for a
> sparse-checkout with only b/, they get a dead link (b/file points to
> nothing).

That's what I'd expect.

> I initially assumed that replacing a file by a symlink to another file
> with the same content would not be observable by other users of the
> repository. This assumption is incorrect in presence of sparse checkouts.
>
> I would find it natural to have sparse-checkout "follow symlinks". When
> checking b/file as the user requests, git would notice that it is a
> symlink and do one of the following:
>
> 1. if the link target a/file is not in the specified sparse checkout
> set, copy its content instead of creating a dead symlink
>     (Downside: this could lead to duplication if several in-checkout
> files point to a/file.)

And the file would immediately show as modified in status, which seems
like a rather negative surprise.  If someone does a `git add -u` or
similar, they'd convert the symlink to a regular file, which could be
another form of gotcha.

> 2. or add a/file to the sparse checkout set
>     (Note: simply checking it out silently is not enough as 'reapply'
> would then drop it)

This is a solution that does not work with the default cone mode.  It
may also surprise users who expected the sparse checkout rules to be
something entirely under their control.


Both solutions would also interact rather poorly with sparse indexes;
either looks to me like a bit of a foot-gun for them.

> Does this sound reasonable to you? Would you have recommendations on
> what the interface for such a feature should look like?
> - which of the alternatives above would you recommend?

Honestly, neither.  The problem isn't limited to symlinks; some examples:
  * you could have a script in one part of the checkout that tries to
invoke a script in the other part
  * you could have a source code file in the non-sparse part that has
a directive to include/import/require source code in the
non-sparse-checkout
...and there are many other ways files could depend on others.

Symlinks are only special in that they require no programming or other
knowledge to determine that there is a dependency between files.

I'd rather continue to follow the expectation that users of sparse
checkouts need to determine the relevant set of dependencies and
determine which sparsity rules make sense in their repo.  I suspect
that each repo might be somewhat special here, and thus each might
have their own tool for creating sparse-checkouts using repo-specific
knowledge (e.g. "I want moduleA plus whatever it depends upon") which
their repo-specific tool then translates into the appropriate set of
paths or patterns to use.  symlinks would be just one of many kinds of
dependencies that such a tool would consider.  I understand that some
repos might be big enough that users want to use sparse-checkouts, but
not big enough that one of the developers wants to write such a tool.
Still, I'd rather not attempt dependency analysis in git[*], and
instead require the users to do the dependency analysis.

> - should this be enabled only by a new configuration or command-line
> option (to which subcommand?), how would you name it?
>
> Thanks in advance
>
>
> ## More details on the use-case
>
> I'm trying to reduce the working directory size of a gigabyte-large git
> repository ( https://github.com/typst/packages
> <https://github.com/typst/packages> ) which contains a substantial
> amount of duplicated files, by replacing duplicates by symlinks. The
> repository uses a continuous integration script to run automated tests
> on each proposed change, which uses sparse-checkout on only the
> directories listed as containing modified files.(The directories
> correspond to independent "packages" so it makes sense to check them
> separately.) This breaks when the modified directories contain symlinks
> to other, non-modified directories.

I know it's not quite what you want to hear, but I believe a better
solution here is to have your script check for the dependencies it
needs (via symlinks, in this case) and include those dependencies in
the sparse-checkout it creates.

Hope that helps,
Elijah


[*] I'll add a slight carve-out to this statement if there was a
git-specific way to declare dependencies that we can then parse.  Such
a thing has been proposed before; see
https://lore.kernel.org/git/pull.627.git.1588857462.gitgitgadget@gmail.com/
.  However, multiple gotchas were identified that derailed that
proposal, so those would need some solutions.  Even if we were to do
that, though, you'd still have to specify the dependency explicitly in
some additional file rather than just depending upon the symlink.
Further, that particular proposal would have only worked with cone
mode which goes against your specific request here.
