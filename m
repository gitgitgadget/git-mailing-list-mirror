Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B95249F9
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311259; cv=none; b=jO/PHak4MJSgfjIZusGglByoL2SdIQzAE2RRxbpneXa3lFPRjhUE1r4zJjRFAVr/ov81m3I/Y3MDCupgLRwsT+A6D1CUi8rGeQTtxayy+Wywk0BKpWmt7RFpr8sEtLUilCZLf1DhqwVMJh0ZwxzcMcAAN8JLEphNwGN+RVOZxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311259; c=relaxed/simple;
	bh=aFKubnoeTqoFSEINhNjePOohgYBwBbxocyfO4FMiOvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aC38V5VA//VZtKG2m8JTot/Vj16Da5a7Zl3DcomJzlcUUAC2adHY1A5eNSn/+R2W/n5tVe6OWtud41tuLkAeDE4FaXoA2xZhAFeqMLND3Pt8DhPOs2anY92ac5alngcwHb0NsDNqVASwE49CF0mW6HhMKOBB7Rn4tP5EYsi+AkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6ROI48D; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6ROI48D"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso6120523a12.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 23:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757311256; x=1757916056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdOCAtrPkza55X6I0LaRqJwxgPdbbRhztsgjrf9dNWc=;
        b=U6ROI48DtunpzutUPK9XdBDGwKzmnq8z0IM3+MWU/G8EOIkNM2AzkuWFb9jt2+J6Jn
         oVskvPcYy/xyF+kJ/PIuQxYRP02Erc5cgBjtCyqNOglNjaJyyrfaegZPkhjgZROmXIHz
         Ou8nmoTY55/JPCRz12vXaJunbEkXbru7tqR0fOoliskX2gDmesUKGDOd/NUzMKMqWjGz
         zOAlF7qN8rZXIpu/AvaKCo5itnwAyAHotJSGVQ3LrwybNzvd7N28rodhIURpgK2xKP/b
         UNDp2fLxZ5HfyTZdG+U0pmS87AW/31vSBkql7/EwmImiootXkItmkFFjwNRYp6s2sl1h
         5clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757311256; x=1757916056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdOCAtrPkza55X6I0LaRqJwxgPdbbRhztsgjrf9dNWc=;
        b=Xpp8BVVBjZSKKghAo7c/baETiPHJJv9ctnS4b/GF3SRB2IJ49klcaLgQZdOVB1TAbm
         Pe1ECPIfvH9xkop2uBqsGrZrNIWrHh2t3hp0CAieXIKuQttbK/ENqoYcizAwh/VRb/dT
         srd/T976nwu4aLrcNkffejYMh4T3K3ZnKktG32AbVwS7okGUAchDXW+uJbOa8El7k4MP
         cVQRa6NrRnk5sNPl13oa7kfIhaULdZrn8kjNRYhWvXJ1tb1JvJxSBY3G+rGAeXz7to4l
         bVg4JlKArGmbOpxyjtBpJF0qo/jwlSJ4UU6EqDF1z+BL0rupKz1/E9fxkqovKURxmex/
         sFyg==
X-Gm-Message-State: AOJu0YzajxhE0AYJcaKxAy4jX0z7ZOc7Qp1z4XaYGHLGSgXlysKexL/+
	cvbOOPsLO4KD2v/lpqvUzBGpmPmI2xlMUM6qnA0AQ+eQkLDpCyoUuaSQ00B4YZ6k/avoqhkoXi4
	Dt2a72SMJSqSVeipkxRIJyNd0y6SaSfw=
X-Gm-Gg: ASbGncsGjhFBDfFw9RynxV2u+RPW0bUEkDyb3zO2Pv9MRvhqEq+f8KQDSuXVMPrx9ZU
	obhtTulAy0j5umYDyarHI6QT0/yZ5M7+vtvFgcZwI3Mw1DknRHdg8wyY4vOF4vadFA0Oe4eILz1
	N8U0QCmKnxGtFhulQQgwSm6L/DieaYDpGwluZGM2q44j2zVU98BPVYGtdqFJPYfKfiy2fq1ArLd
	13G7tqFSOtVeyDKsVRsW8oU7RvP8eQ=
X-Google-Smtp-Source: AGHT+IHAYJfvFDqVfaZJeGvTSLrcF7fnS5mdXwBjCNSYBMqBQAGhUHt5JlWtvzIeO2vpA1bpu39UFBXJYl6jsrMEuPs=
X-Received: by 2002:a05:6402:2707:b0:61c:3379:7915 with SMTP id
 4fb4d7f45d1cf-6237abde445mr6554331a12.3.1757311255965; Sun, 07 Sep 2025
 23:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com> <20250908043620.57848-3-siddharthasthana31@gmail.com>
In-Reply-To: <20250908043620.57848-3-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 8 Sep 2025 08:00:44 +0200
X-Gm-Features: AS18NWCgf3JX3QnRGFvmGQvb8IWT2VlxijnK3ZVX31v-VuGzKut_PlcLDiPd9fc
Message-ID: <CAP8UFD3Db-n3CY=KBpn-2Nt=SYY=5ckF3J_4ho6C19SVcrfdsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:36=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> Add documentation for the new --update-refs option which performs
> ref updates directly using Git's ref transaction API, eliminating
> the need for users to pipe output to git update-ref --stdin.

Most of the time, the documentation should be part of the patch that
introduces the documented behavior, not in a separate patch.

> Also document the --batch option which can be used with --update-refs
> to allow partial failures in ref updates.

It looks like a --update option was also added by the previous patch.
Is it documented here too?

Why was this [--update | --update-refs [--batch]] set of options
selected over other possibilities like for example
[--update-iteratively | --update-atomically | --update-batch]?

Also how does this --update-refs option compare to the --update-refs
option in git rebase? Is it working in the same way?

> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  Documentation/git-replay.adoc | 62 +++++++++++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.ado=
c
> index 0b12bf8aa4..cc9f868c2f 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -9,16 +9,17 @@ git-replay - EXPERIMENTAL: Replay commits on a new base=
, works with bare repos t
>  SYNOPSIS
>  --------
>  [verse]
> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance=
 <branch>) <revision-range>...
> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance=
 <branch>) [--update | --update-refs [--batch]] <revision-range>...

Here --update, --update-refs and --batch are all documented, nice.

>  DESCRIPTION
>  -----------
>
>  Takes ranges of commits and replays them onto a new location. Leaves
> -the working tree and the index untouched, and updates no references.
> -The output of this command is meant to be used as input to
> +the working tree and the index untouched, and by default updates no
> +references. The output of this command is meant to be used as input to
>  `git update-ref --stdin`, which would update the relevant branches
> -(see the OUTPUT section below).
> +(see the OUTPUT section below). Alternatively, with `--update`, the
> +refs can be updated directly.

Here only --update is documented.

>  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>
> @@ -42,6 +43,24 @@ When `--advance` is specified, the update-ref command(=
s) in the output
>  will update the branch passed as an argument to `--advance` to point at
>  the new commits (in other words, this mimics a cherry-pick operation).
>
> +--update::
> +       Update the relevant refs directly instead of outputting
> +       update-ref commands. When this option is used, no output is
> +       produced on successful completion,

It seems a bit redundant to say both "instead of outputting update-ref
commands" and then "no output is produced on successful completion".
Maybe there is a way to reword this to be a bit more concise.

> and the refs are updated
> +       immediately. If any ref update fails, the command will exit
> +       with a non-zero status.

This doesn't say if the command immediately stops when it fails to
update a ref, and if the ref updates are atomic or not.

> +--update-refs::
> +       Update the relevant refs using ref transactions instead of output=
ting
> +       update-ref commands. By default, uses atomic mode where all ref u=
pdates
> +       succeed or all fail.

This seems to imply that --update doesn't update the refs atomically.

> Use with `--batch` to allow partial updates.

What about --update, when should it be used?

> +       When this option is used, no output is produced on successful com=
pletion.

Here also it seems a bit redundant to say both "instead of outputting
update-ref commands" and then "no output is produced on successful
completion". And maybe there is a way to reword this to be a bit more
concise.

> +--batch::
> +       Can only be used with `--update-refs`. Enables batch mode for ref
> +       updates, allowing some refs to be updated successfully even if ot=
hers
> +       fail. Failed updates are reported as warnings rather than errors.

What's the difference with --update? Is it that --update immediately
stops when a ref update fails?

>  <revision-range>::
>         Range of commits to replay. More than one <revision-range> can
>         be passed, but in `--advance <branch>` mode, they should have
> @@ -54,8 +73,9 @@ include::rev-list-options.adoc[]
>  OUTPUT
>  ------
>
> -When there are no conflicts, the output of this command is usable as
> -input to `git update-ref --stdin`.  It is of the form:
> +When there are no conflicts and neither `--update` nor `--update-refs`
> +is used, the output of this command is usable as input to `git update-re=
f --stdin`.
> +It is of the form:
>
>         update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
>         update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> @@ -66,6 +86,15 @@ the shape of the history being replayed.  When using `=
--advance`, the
>  number of refs updated is always one, but for `--onto`, it can be one
>  or more (rebasing multiple branches simultaneously is supported).
>
> +When `--update` is used, no output is produced and the refs are updated
> +directly using individual ref updates. This is equivalent to piping the =
normal output to
> +`git update-ref --stdin`.

Is it equivalent to `git update-ref --stdin` because both exit as soon
as a ref update fails?

> +When `--update-refs` is used, no output is produced and the refs are upd=
ated
> +using ref transactions. In atomic mode (default), all ref updates succee=
d
> +or all fail. In batch mode (with `--batch`), some updates may succeed wh=
ile
> +others fail, with failed updates reported as warnings.
