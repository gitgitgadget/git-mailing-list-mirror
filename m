Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92FF1BDE2
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360621; cv=none; b=uyqdHNy2d6AjKeJs518oVA3mV3EGeSm4jGVGdUEViP00sFUvaYoufPdaKuVa+7YgYrHb+8F0skJUvEBbOyuAPXZBIKMAa1dTpiIaPerQ6z7hpj363rDzSrgdBM4cbrOD9jG4o3BRyP0O4dh/Q9aEi7tA+O6capPkrn6e3wzteFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360621; c=relaxed/simple;
	bh=2X+qvQQebqVFpz9OCd2V/rbSneTIgT10qkaUj5WUoRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VohnFSgWZpmCW72XqRjibC8B7BmctcBfDIokW8PNuObnC3V7jQg3HWbHp1tL+yFPDSJfoL/b7gcjTKYdX+dKCTrJhf0D9YQQqbOxH6m2qshDFQf0fsVNbwzmDAMbkK5Ska/1j8xskaYTXEqnayDIzRHARuuC+WSBLy83olecgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYcg5Ozn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYcg5Ozn"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5610b9855a8so134017a12.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 18:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707360618; x=1707965418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaSe+eOe5Ch2peicOaEY8ILUbICNxFSLcZ4M8Mfz4+Q=;
        b=SYcg5OznUjRTXUuk5FXsLhyYz6iLhUb49fS8KiRJjHkftGd+9vfnVzd5FqqRTZlgbY
         tV1JsjwSJZr0QsNey7e14GR8W9DSbr6d0SWbuniMQOp7gt043BeQGarhRHMyA9LgZwzO
         lDSqdwDjeWsmvOrqJkNQ/VBm7Q3+a41d1Q3kuBnRvexlQQoZD+JzECHO7S77ORtvKIeU
         BCzFEeZA+Uvdnd7ILz3h4vBEwrj7AYRPIsvQG9O39wY7JEeLGYD1OqOblDfSBaJ1rVBR
         mII30wWATwnlVkAR7s8IKFzHJJDXtEGjqHZMzHhmkneSL99nz/RYzrGcqE+DqP+0WfGh
         4djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707360618; x=1707965418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaSe+eOe5Ch2peicOaEY8ILUbICNxFSLcZ4M8Mfz4+Q=;
        b=mh/XMaEVTVc0qshNnvcRajAr719sG1luOXLTird8BzuwgENt247fUnsVVJQxtNT0GF
         cUEw5kMc0Drcga98Lof3nMyCrFWZ3K4m/YqsisZd2KeS0qW5i2oARL6axPhl++Bz0T2C
         SpfoBUU3CrMUqNNULlgS6r5XWYNNEtRrBoRZuWw1tuiL6w6m75VQQ3fuQMBRZkJ1jNee
         0Us6ReNxg9hA+CXrN/0xOen9u7msMoYUfoAmMkiTzYKqIkOyU6GOWeiF+L3Hx67Hnhzm
         k99RSOflEOpHCOedWJZsgfXyUsWbFTQXNYZmop9BDxhFy9JMBb/3PcGg/2tUjVJeMX73
         Y9Ew==
X-Gm-Message-State: AOJu0YzDAiu6dIJPkQq/oZf3JH0wm8TGxnApJ4KMZzvZm210yceqsM3A
	n6eA37K5c/RKA4AByMisXr0VjeYUGy70HteSqzXgGc6UtEyGaAQgZnaIhzMpggUQdw9ExlteWaK
	AFYbChoPUbG8+rh2ULOu0XgTi8ryjcQwiwPXv/AlGRTRV3qtodw==
X-Google-Smtp-Source: AGHT+IHls0CIkcodcJ/5SoN6TOZvHGeUS9mJgzRK1xiShlebsmJx6t69sPE2j3Wht4SKwojIDzVAWrRwX4NXT8S8sdM=
X-Received: by 2002:a17:906:abcb:b0:a35:e5bf:b585 with SMTP id
 kq11-20020a170906abcb00b00a35e5bfb585mr1100050ejb.35.1707360618081; Wed, 07
 Feb 2024 18:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyt89l7z.fsf@gitster.g>
In-Reply-To: <xmqqcyt89l7z.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 7 Feb 2024 18:50:02 -0800
Message-ID: <CAO_smVjnknv1ePTHhDNKK=C_iEg6+T0nNwaXqA67QuPd6tBkxw@mail.gmail.com>
Subject: Re: [RFH] "git -C there add foo" completes, s/add/diff/ does not
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> As some of you may already know, I keep an untracked directory
> called "Meta" at the top-level of the working tree of the Git
> source tree.  This "Meta" directory is actually a single-branch
> clone of the git.kernel.org/pub/scm/git/git.git that checks out
> its "todo" branch, where files like whats-cooking.txt lives.
>
> So, what I often would do is
>
>     $ git -C Meta add whats-cooking.txt
>
> after updating the draft of the next issue of the "What's cooking"
> report.  The command line completion support for "git add" knows how
> to complete this when I stopped typing the above after whats-" and
> hit <TAB>.  It seems that __git_find_repo_path helper function that
> notices "-C there" and discovers the $GIT_DIR, and _git_add helper
> uses __git_complete_index_file that honors the discovered $GIT_DIR
> to find paths in the correct index, which is wonderful.
>
> But the same does not work for the step before I can decide to
> actually "add" the contents, which is to "diff", i.e.
>
>     $ git -C Meta diff whats-<TAB>
>
> does not complete.

I'm not a completions expert, but I think what's happening is that the
completions for `git diff` aren't producing anything, so it (where
"it" here might be the shell?) falls back to just doing normal path
completion. For `git add`, it's checking the `git status` output to
filter the list to things that need to be added, so it respects the
`-C` option when calling into git to get that list, but there's no
such logic for `git diff` (the git-specific logic treats the
[optional] positional argument as a ref, not a file).

>
> Anybody wants to take a crack at it?
>
> Thanks.
>
>
