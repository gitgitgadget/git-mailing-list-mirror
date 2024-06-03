Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149C6A032
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403944; cv=none; b=BEJYMTTCEcuy+nn3ymlVFmghW7Pq1laEnCjYEIwlj+GCb19JI6h5xu/6xCMn3N/mwqi7ox3mimUnhAy9gjnwOIiglcJznURPmHFPTUwWqI96lBbNSSGUOAzBGwLkBpFteNTYYfk4yL/3SXtFZisFvwPUu/P646z3nb/iXazRgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403944; c=relaxed/simple;
	bh=7IbAtDUreRqOpIXdPTWTWWwxzPDAw6zFlmUD07qcfIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8yeJI+AEd9NGGQF0bZfWlAHQkCjH7eFDY9JMiz7zqjW0HV9+dB5j51pA/zhJT9k/Q8GMKvEh1AT6DLYHN3GYQ8dyd3qggHW8q7Zlvcjqz++F73MWMpyrOU5xuWXhUm9h/waO6jFvEXqqNyqY8czWe9piGoXhHSJJYJdqkxd1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk1D4peF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk1D4peF"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so4141969276.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717403942; x=1718008742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txt1Fct0Q/qTABobBoEApBo6Vdn9J4NAj20pj1iOH0I=;
        b=Gk1D4peFDXjiKay1oX9WTYiCtods3AFp1yjdgdD4PKvsf2PJZfEM0LTjzOraBpqkZp
         o02uB9FAcBoeSnZhAgHHQ9XEh+wBLYjoOcAn3f58doNTqRWEQ7hKfAXm0vtMV2sguLHb
         VS6I2uxkEGjEhRoxbMRkJyIa3SSUsQ1rr0hKhJt8M7/hst8bF+u3MusbbCVbBij3IIMZ
         +fha8S3QxamMzKVSZtlfzBOkJBa+0MOkLqGyHscPdRFY0hgDXqnVOUUPtpIoHPsLf5kz
         d6g1BWD8DRAQj1sy5FLHP/eUz5cUcloulQJdLS7ZRl9KAqAVW6vUiJ3n8GcLKNL5zDV3
         uMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403942; x=1718008742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txt1Fct0Q/qTABobBoEApBo6Vdn9J4NAj20pj1iOH0I=;
        b=ZQ4bLwUuil7wXKSOJVCeb9S7j8Ic3uaZ2FYZQkfnik7rg/PZyx6YrlgdiC6x+9rhqA
         vElJ8h75umGEYOhwy5UFpoYJlDg060QqOWt0O+heVsu84wwftrGpCoc/nW/+FJMaNpto
         ALMKXFHuceLjW7HCHzkloEQUu2ZvNllbR6rS/KO5VOxeRMUQVf1gp9VMzU6X7THpP/nx
         0VstrAj31HyoCHDAiIoKwSh5ORoH7pQOiTKM/6ge9KnOX+gPmdYtZGThQ0qB1FD19z7t
         HWuCNr9UPJMGtXsgPj4CMtTtK9YsJEEGugGkZ0x5qbG9fvQEuKzFFzK8yKmiq9Ah+wBU
         YtRw==
X-Gm-Message-State: AOJu0YzMz9pTXe1m9x8y5Fsn1587f0i+69Ixm1Z8C3vENdyGl9TomgXz
	AkjT5twgyNOiEIWhiQLI5z11/CgI/2AIPFBDc4NoOmiKTLfvyZtLFYiowbuMmbKaegse/daHHjT
	RKUOusUjLKKzRBazCO5wbiHzA5vxnH00=
X-Google-Smtp-Source: AGHT+IGorY2aSKI4WyGzetzBao4y1PVdTGTr//m4yJccMm6KR53dvsdLva5KSySPlHDLHmPsQKBYJVQpYeSurVa0cvc=
X-Received: by 2002:a05:6902:2841:b0:dee:5dc4:59cf with SMTP id
 3f1490d57ef6-dfa73c2209amr9026724276.26.1717403942041; Mon, 03 Jun 2024
 01:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADg0FA_9shzJKN=dBfnavu5eTDNhbz=g0WP2sehAjSqHP4WFkA@mail.gmail.com>
 <CAPig+cT1pTkKd1A0o_qjP+Oyx+zyCevV8EAg5Ub9guAyd3UjgA@mail.gmail.com>
In-Reply-To: <CAPig+cT1pTkKd1A0o_qjP+Oyx+zyCevV8EAg5Ub9guAyd3UjgA@mail.gmail.com>
From: Antoine Bolvy <antoine.bolvy@gmail.com>
Date: Mon, 3 Jun 2024 10:38:50 +0200
Message-ID: <CADg0FA_2Z-Hz-ahaHWM-w7qhjf0+06XuhZv1MR3dOtfnAvD09w@mail.gmail.com>
Subject: Re: [bug report] git diff --relative not doing well with worktree in hooks
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If you change your hook from:
>
>    #!/bin/bash
>    cd folder || exit
>    pwd # display the current working directory
>    git diff --cached --relative --name-only
>
>to:
>
>    #!/bin/bash
>    cd folder || exit
>    pwd # display the current working directory
>    unset $(git rev-parse --local-env-vars)
>    git diff --cached --relative --name-only
>
>then it works as expected.

It seems that unsetting GIT_DIR only is enough to make it work:

    #!/bin/bash
    cd folder || exit
    pwd # display the current working directory
    unset GIT_DIR
    git diff --cached --relative --name-only

Thanks for the help and pointing me to the right documentation!

Antoine BOLVY
+33(0)675455349 =E2=80=A2 https://saveman71.com


On Fri, May 31, 2024 at 11:42=E2=80=AFPM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Fri, May 31, 2024 at 7:38=E2=80=AFAM Antoine Bolvy <antoine.bolvy@gmai=
l.com> wrote:
> > I noticed a weird behavior when using git diff --relative with worktree=
s and
> > hooks. When called from a pre-commit hook from a worktree, the relative=
 option
> > has no effect.
> >
> > [main tree] Displays
> > ```
> > /home/arch/git/awfus/hook-repro/test/folder
> > bar
> > ```
> > [in worktree] Displays
> > ```
> > /home/arch/git/awfus/hook-repro/worktree/folder
> > folder/foo
> > ```
> > The path is no longer show relative. This causes issues with more compl=
ex
> > scripts.
>
> I'm not sure there's a satisfactory resolution here. Your hook is
> running afoul of the environment variables Git sets up when the hook
> is run outside of the "main" worktree.
>
> If you change your hook from:
>
>     #!/bin/bash
>     cd folder || exit
>     pwd # display the current working directory
>     git diff --cached --relative --name-only
>
> to:
>
>     #!/bin/bash
>     cd folder || exit
>     pwd # display the current working directory
>     unset $(git rev-parse --local-env-vars)
>     git diff --cached --relative --name-only
>
> then it works as expected.
>
> The relevant portion from the "githooks" manual page is:
>
>     Environment variables, such as GIT_DIR, GIT_WORK_TREE, etc., are
>     exported so that Git commands run by the hook can correctly locate
>     the repository. If your hook needs to invoke Git commands in a
>     foreign repository or in a different working tree of the same
>     repository, then it should clear these environment variables so
>     they do not interfere with Git operations at the foreign
>     location. For example:
>
>         local_desc=3D$(git describe)
>         foreign_desc=3D$(unset $(git rev-parse --local-env-vars); git -C
> ../foreign-repo describe)
