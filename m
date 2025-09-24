Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB0329F3D
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745796; cv=none; b=C9aW5DbFAuG99JcwhTcxHZPx2PUmn0dMjxeV67b2rQ9leqlNM92IQwV25igbDYahWkHnID+ZvA2u3sjp72NqoFQE05uaSkw2aMR155OyuNF8mgj8Yl1r5ZrcKpinIj2MuNgpFpNCms4Az8ISRSGzPfAVu4P+sz9C//+UHXNXqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745796; c=relaxed/simple;
	bh=rsOCPdx6K+3exSRUF35bU3kV1120kd+hQly/9kjWv2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh7Mlgk+C6ZfTiKR8oLmdsSK5YaqcyMXjUGFYvoi1oIhgQ4p2Tj9t5DQmKIvNQZVd9WyB2VBRo8M1kzngh6p7uuMaSS/KKjgXRjvZBlXl0cF28AY/wHLSad8OycNvgp3X4/4vFPR+nXkuJQd7rQiIu4Jrh73JhMBHuswLzxu+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V49l9Q9C; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V49l9Q9C"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso329467a12.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758745792; x=1759350592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G2bBKYQ2lNBZC1XsURqiGm5kSdAbuy6WCVo0u1Z0ls=;
        b=V49l9Q9CLtdY9qwcGxQ/lgqWXiYnYUxSy1UDf9/jVGBldap1Qg2BEza64bv2zbZ7h7
         1iTGKIgMroms3DUULThRlTViKOOi8zhR2Tf85Kq+ITvwDkWE+eZA1OdMsyXj9/T2hjpc
         jy1vOs9L+ABfq4BZiQApk5TI+RyHcXqq+B9CDz94ZVLg/Kjf0IsYIGS58/17rlH+Qa3u
         6jSV7xTA0HkMfmDU5Ull3FMUkr/37AfLJaQKnJAnzsshBac+/NTB1MF1juTojOES32/3
         IRGf0VwjZRcAUmAGePLPSzRRYCAsbmW46556EUocVWCtBWRGCuudvebfTFb5dJQ7HHS0
         raAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745792; x=1759350592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G2bBKYQ2lNBZC1XsURqiGm5kSdAbuy6WCVo0u1Z0ls=;
        b=V8kefGgfDW2uBBVVf6PR/WNJ3UwL2p1WmWysuK00gr35g/1hZVQ2ydI17Srh75nsSf
         UmP56mVS1iWcBFHWl0wexBzwODK5vQx80c4wy0zZG69ahbEjLOWzki/HUCk7RoZsEHPk
         LJA4BDvXcf416F3vrswbmHm/AJPzodD1BwyoOEgRurDNAGpFcrkECc8Pt30x07HlpuAL
         7AUQ26CLGWmoGcCNwhREe8L7uhh1GfreE4n7vsSAA7LIKzzXz5RXz5Au8k4TAiIEfZjq
         +LN1KpwLyPbXmknwYo7zJU+qsT0vzjU8zFiNzznl/fzu7zMnR5qnw6yGK0AV1EhsrNOZ
         mw/w==
X-Gm-Message-State: AOJu0YztcGOlkgqltQzCUykxnXAnhvY4hkfmIqUs6BxTrZkk7cGqRnDa
	AGadolPS4+nf5yFTgltNdSoYnqtMSfx1hS5qsjCtYu2oE6Xy9n6wuEIZtUoloy6ItfTsYf8dJ+u
	ns/KOjEOsUtm4P9CBOJ327drkucDDyvo=
X-Gm-Gg: ASbGncucQ4vh5IQbEKQSwb25MJtMD4I9WQ6Q1ZdxTda//vgDxxNncXE8wmCvr7kSvIA
	N2bRcaDJSEkLs/iaVJ7unOf9uCnR553KE95wqrSuXGFZ6Eu50yLaS63SIYEbrWh38BpXJsa8jrI
	NcRCFDEZbV40m/kt8tmic+7MM0kEqtJUihQjPb+LuSw30cu1hkPp1HYJdYOWUiWKWazb7O4vDRV
	E1kY+pKcYX6hKX+AcojySCFduy3ylizzHO4M9BpAf3Y2r7UZxiV
X-Google-Smtp-Source: AGHT+IHNn/sgMXit8AC3OHYiK9eIAMxa2q2tw3lnSRij993ewN2yV95lBxgRo1inwVqn/csOqcvQLUzn2/S/sw0HB2w=
X-Received: by 2002:a05:6402:6c8:b0:62f:b6bd:efed with SMTP id
 4fb4d7f45d1cf-6349fa18f55mr605299a12.13.1758745792330; Wed, 24 Sep 2025
 13:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com> <c7f09c2bd32baf9e1dda355656bba811484e90a0.1758656702.git.gitgitgadget@gmail.com>
In-Reply-To: <c7f09c2bd32baf9e1dda355656bba811484e90a0.1758656702.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 24 Sep 2025 16:29:41 -0400
X-Gm-Features: AS18NWBk680kdzgIDYcOC-jwLPevmEjAjOIWmPCzIKXhJqDZ5VrlxZ1sYs7G8Zs
Message-ID: <CALnO6CDpduG3UNMAPCBx8+du1k8Af6A-=kxhRuzooyQn8mZhzg@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: git-pull: clarify how to exit a conflicted merge
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
> - One user is confused about why `git reset --merge`
>   (why not just `git reset`?). Handle this by mentioning
>   `git merge --abort` and `git reset --abort` instead, which have a
>   more obvious meaning.

"git reset --merge" _can_ be helpful when merging, but won't fully
abort a rebase. Great.

> --- a/Documentation/git-pull.adoc
> +++ b/Documentation/git-pull.adoc
> @@ -30,15 +30,9 @@ branch. There are 4 main options for integrating the r=
emote branch:
>  You can also set the configuration options `pull.rebase`, `pull.squash`,
>  or `pull.ff` with your preferred behaviour.
>
> -In Git 1.7.0 or later, to cancel a conflicting merge, use
> -`git reset --merge`.  *Warning*: In older versions of Git, running 'git =
pull'
> -with uncommitted changes is discouraged: while possible, it leaves you
> -in a state that may be hard to back out of in the case of a conflict.
> -
> -If any of the remote changes overlap with local uncommitted changes,
> -the merge will be automatically canceled and the work tree untouched.
> -It is generally best to get any local changes in working order before
> -pulling or stash them away with linkgit:git-stash[1].
> +If there's a merge conflict during the merge or rebase that you don't
> +want to handle, you can safely abort it with `git merge --abort` or `git
> +--rebase abort`.

This information is also mentioned in the advice given by conflicts
(and git status), so while I originally wondered if we need to say "to
know which to use, run=E2=80=A6", I now think we can trust users to know
whether they asked for a merge or rebase and read the advice/git
status output when they don't.

Hah, just kidding. Nobody* reads that output. But I still don't think
it's worth muddying here, because the same folks are unlikely to see
the help here, right? Or maybe we say "Information in `git status`
will summarize these options for you." ?

[*] Obviously untrue, but you all know what I mean

--=20
D. Ben Knoble
