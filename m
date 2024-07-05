Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99117623C
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211381; cv=none; b=Q010ZlUH07WcwYpEC+3AOlGfGF/quTZZJqeLbMbozBebBfk68oEIng4ZRGQfuwblGD9pAw1NEbJDcEpM8Vayd9QhQXlIIIAqwF++3AKm+qHKaCSnbvQMoO6c3HmzCfi7fHGfpYmRph3wAIyw0RODzlGvXslD4TKOiuQPcxnBFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211381; c=relaxed/simple;
	bh=igD6IMXaJnDwewjeoupNJnYu4CrAlty/Wm18qub83LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+lUkQ/QTMK56WDga8xCuU7+iksl3XjoaqBeJELu78fTwjO5IXldSl9msgHykYgl7og/PQVcpnll6zmjpTIdfOhE5f2Gw3MlShl79aNALlysl9L60cJWJcnGj1n/x+xzfFq4NqzPyOHq6pgu7laVSTClSfbWuTVNQ0bbPeOxV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEHx+s4z; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEHx+s4z"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f684850b11so17637739f.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720211378; x=1720816178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOF/aAu9+uBZAACOwF/4DzU2XpBaRwNytHnp1wFPSQE=;
        b=WEHx+s4zCJ5QJ5Gu5sE4KRtpH0QKQ5qD++BENpZY1q6PqN0q63jF4HKlpkzwTxtLJV
         ERi473z6MK+O1v6bDvvLO6ngIajUIgFybZlAQqGW+Xa62TxP2PtSBK1USGRxWAaMJZo9
         o1PbZ8iCrJIyK7xGBM+5xXVmcODXu+mXERfSM2fqSmGtOTqx7QvWp1MWVZrI/xsjxQ81
         HUr8m3waEeRBSHn6MMOqFJJqNjSagSoRRfgCcIg0cE8U3/7yPAauyb50pKW3SSBu7h9l
         oSIAipEwbal1tJpGodJF6BeOTh/IUDzQHwh0xIxWDzddu7xXeVEFlpEXsEZOiP5IJFhX
         Qt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720211378; x=1720816178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOF/aAu9+uBZAACOwF/4DzU2XpBaRwNytHnp1wFPSQE=;
        b=A4/7EtZhMwZ5sADrs4eXOQO1bX32nQrPlE04SBq8jy+WXxs4mlMZE6omtyXXU3uaY3
         FRIB0/s+iL3e2SbS1IpfcrHlRMAQeATy9+DU8pGg1Cv0/loM5wWelir9wGjrNc8+mXGI
         to5Bsga7LLo51hW81mX09zynbXgqEFvvFJ3RGMUa5iaMvTadRr1MOOT/k2BXdW+IE3iB
         gBhci5SbECEsMS/j2kyyEUSYgU/oH/r9mVzD3uwDJMK2klszL71RUgil0EpKfoTvx36v
         ereW5Z+AHS9YQu7iEz4bUa8zHgEiTA/Tv5EZtaYqpdFyavCNvMzLdovfCIFr4GcWVn0i
         BDDQ==
X-Gm-Message-State: AOJu0Yx8zCUPtOofy5MoQlLVihyvm3wcRJEVcl5GSeok4bAo0/2kF4+a
	+mvN+civazSxQ5VfNkVY+yET10BF43VTjO3B2XpQVYxktVr61rl4XeDJ/W8bPmoMfPDjZBLaNNB
	MpfBtzc0Lfug/HEZ/+Y2aIKuoniZ6PBHX
X-Google-Smtp-Source: AGHT+IFYo/92lG8DC2euPVFxMpnp/h77R1eiKD7zCgKFrdvogyvlyElUdsJxKsvmQFuKksEYjZOc7WgyTrdnAAA9DWM=
X-Received: by 2002:a05:6602:1231:b0:7e1:8a93:48ef with SMTP id
 ca18e2360f4ac-7f66df1d30amr652083939f.21.1720211378573; Fri, 05 Jul 2024
 13:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 5 Jul 2024 13:29:26 -0700
Message-ID: <CABPp-BG_udtdv1aCfJ7T_WmRExdD29ZVXD+cA6xOZYHofHDtTQ@mail.gmail.com>
Subject: Re: [PATCH] advice: warn when sparse index expands
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, vdye@github.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 3, 2024 at 8:14=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> Typically, forcing a sparse index to expand to a full index means that
> Git could not determine the status of a file outside of the
> sparse-checkout and needed to expand sparse trees into the full list of
> sparse blobs. This operation can be very slow when the sparse-checkout
> is much smaller than the full tree at HEAD.

Yep, I'm with you here.

> When users are in this state, it is common that 'git status' will report
> the problem.

I struggled to understand this sentence in combination with your later
statements, though that may only be because I had some difficulty with
later parts of the commit message.  Perhaps addressing the later parts
will make this sentence fine as-is, but it's possible this sentence
could do with a bit more detail.

> Usually there is a modified or untracked file outside of
> the sparse-checkout mentioned by the 'git status' output. There are a
> number of reasons why this is insufficient:

Fair enough; let's focus on why the output of git status is insufficient...

>  1. Users may not have a full understanding of which files are inside or
>     outside of their sparse-checkout. This is more common in monorepos
>     that manage the sparse-checkout using custom tools that map build
>     dependencies into sparse-checkout definitions.

Having sparse-checkout patterns managed by custom tools is a really
good point, but doesn't this statement of yours about needing to know
particular files or directories suggest that...

> diff --git a/sparse-index.c b/sparse-index.c
> index e48e40cae71..1e517f696dd 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -12,6 +12,21 @@
>  #include "config.h"
>  #include "dir.h"
>  #include "fsmonitor-ll.h"
> +#include "advice.h"
> +
> +/**
> + * This global is used by expand_index() to determine if we should give =
the
> + * advice for advice.sparseIndexExpanded when expanding a sparse index t=
o a full
> + * one. However, this is sometimes done on purpose, such as in the spars=
e-checkout
> + * builtin, even when index.sparse=3Dfalse. This may be disabled in
> + * convert_to_sparse().
> + */
> +static int give_advice_on_expansion =3D 1;
> +#define ADVICE_MSG \
> +       "The sparse index is expanding to a full index, a slow operation.=
\n" \
> +       "This likely means that you have files in your working directory\=
n"  \
> +       "that are outside of your sparse-checkout patterns. Remove them\n=
"   \
> +       "to recover performance expectations, such as with 'git clean'."

...this is an insufficient solution?

I was a bit surprised you'd list your first reason for git status
being insufficient, that users need to know which files/directories
are the problem and then provide a solution that doesn't attempt to
identify any files or directories.

>  2. In some cases, an empty directory could exist outside the
>     sparse-checkout and these empty directories are not reported by 'git
>     status' and friends.

This is a really good point too...but given this point, shouldn't your
added advice message also mention "directories" instead of just
mentioning "files" so that users are aware they need to look for those
too?

>  3. If the user has '.gitignore' or 'exclude' files, then 'git status'
>     will squelch the warnings and not demonstrate any problems.

Your solution does help the user to know that there is a problem (even
if they don't know which files -- or directories -- are the problem),
so this patch is making things better.

Two other small comments...

> diff --git a/advice.c b/advice.c
> index 558a46fc0b3..7845e427c89 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -77,6 +77,7 @@ static struct {
>         [ADVICE_RM_HINTS]                               =3D { "rmHints" }=
,
>         [ADVICE_SEQUENCER_IN_USE]                       =3D { "sequencerI=
nUse" },
>         [ADVICE_SET_UPSTREAM_FAILURE]                   =3D { "setUpstrea=
mFailure" },
> +       [ADVICE_SPARSE_INDEX_EXPANDED]                  =3D { "sparseInde=
xExpanded" },
>         [ADVICE_SKIPPED_CHERRY_PICKS]                   =3D { "skippedChe=
rryPicks" },

The rest of the list is in alphabetical order, so the new entry
probably should be too.

>         [ADVICE_STATUS_AHEAD_BEHIND_WARNING]            =3D { "statusAhea=
dBehindWarning" },
>         [ADVICE_STATUS_HINTS]                           =3D { "statusHint=
s" },
> diff --git a/advice.h b/advice.h
> index 5105d90129d..572272fa0da 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -44,6 +44,7 @@ enum advice_type {
>         ADVICE_RM_HINTS,
>         ADVICE_SEQUENCER_IN_USE,
>         ADVICE_SET_UPSTREAM_FAILURE,
> +       ADVICE_SPARSE_INDEX_EXPANDED,
>         ADVICE_SKIPPED_CHERRY_PICKS,

Again, the rest of the entries are in alphabetical order.


Anyway, I've nit-picked on the little things I saw, but overall this
is a good patch that moves things in a good direction; with a few
small touch-ups it'll probably be good to go.
