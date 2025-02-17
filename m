Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1D236A9F
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822512; cv=none; b=kAmSSW4TW7nl7lb2LAdPFt4stZy7TQaLc/cYKxqhtw4Mj5KN3bHOmBwTyD0JS87L6sfDzre51nNTSvhq2MZgMX/0bSvDVyvGYuw7gHuIiyOHShzEF1j9AZ39nHo3D7eJ2VzfAARrNjeKnTY4REnOsbzIh/bp8lgEyiSWypp+Tbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822512; c=relaxed/simple;
	bh=HZDaMxQVXKgWumOV86QdRK1ztny/U/PwkZEuzL5YvPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXD03kn/dBrqITodWwBkVahaMKM9/cSxdKjqMiQPIsW+mgNyDJrhtxv2kRTRIyBB9dGKWRInI6j/NFxz2nFEzl9YfTwgZp/uK+ZS6nm0Lfzv+a1rEG4mIi3sConxq+RDbxhr9hc+ULBsWjvjjrJqafd4VB8OvZAyTtzNSL0b2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naARsuOJ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naARsuOJ"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce85545983so12474665ab.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 12:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739822509; x=1740427309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wziGFuWEjxz3vx1A6xS+US1QZiS+7berNthigNGQS18=;
        b=naARsuOJW1uTuXqgpydB+ug0qR4knRLpzQYKlkw87O7XGclfHFXNFedLZdrpHkrdc9
         vqe6dIGW4jrJHQqKqWMk6TRGT9aEsssDV84QVeEkwXQiz5IiCx/Ho0YgsAmhvWjX9PBG
         cfKfBJ16ezE/c97pUpVTzrTajTEhjEIBBxsJjW3maAgJJZK/gTSl+1iPmhOeZK6WOE/s
         7GO/juocUm6WZqQ7DGVaDyeBEp0SDj02/udIamoG3kdtsEW5flBAjzaInCVDTBT3fqpj
         x/GUEEa8P36iWc+dkiLgVJ4L6Lt8ordsWyHRP2PX++5sKaoUVWhob78g0k3mBh6hVGNl
         yd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822509; x=1740427309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wziGFuWEjxz3vx1A6xS+US1QZiS+7berNthigNGQS18=;
        b=Byx20B2Lfp6QqiyHxeJzXzyAEYQVPZCtTRK0/9vBoEpHJMPtLjbxh2ELfZ2Q9SV0Mh
         NOOyV8c56lSP5shJPpha7sFbBJY+E3A6pYloIUr2Pzj+PjuIdL2yG21ufyFJ6RAsOrNR
         PFaJg4SP+xOaihQJ6rr12vdJeetNOsoSekxhUySZPWpRyFUR1Kua0LD/A+ZGeqK6cXJV
         pmNZSOihdtoFp6H2tmOKcLT8JuP6B5U3SYUuHcfvmCZuUX23d4vkR/NTwGm7Sk682XGq
         qk2VmAb1mxQuqJUcCDqfPzTzosomGrNpuv4Kq9VoYpbTnP07p0finNsCLrp/DnRuG1qQ
         XCWA==
X-Gm-Message-State: AOJu0YxNwwqWwU6rY54bGZLn9kAxtinVU2l6I6j13FoiE5qz4+iITX4n
	vmgyOw8rixpAhur44JCLyrE1xexMfkX+wBcGz0dNwOAMYebAXpjmiPelHqDq0mE1PYdmjB72g32
	Sdz5ox1qYr3ZJyefQYuHUIQ5BhP+TrA==
X-Gm-Gg: ASbGncspRSZHJnmOfJXeoiusJiT54SYuilH5rRfEtKoBix4gHTt2q2CLi+XmaiylwKY
	nGLKq2jXtfFDjHS8hi7n3hH9zz9FuDNcCK9UMuF2AlnSEp+wYG1bH4l9JO4xDL+1byMC+esOfnf
	puDuBZz8/ADexdWSPVXmI3a9KRTP0mFA==
X-Google-Smtp-Source: AGHT+IFpNUflhzm3/4aWqx/x1hZ5kXxzP2/tQsTuiJOOmzZI2AzpSfqNWl52jOTDuGNvkwG1V8YY302MXL0YGEM/ETE=
X-Received: by 2002:a05:6e02:4c1:b0:3d1:5037:c97a with SMTP id
 e9e14a558f8ab-3d18cc66fddmr151081585ab.3.1739822509366; Mon, 17 Feb 2025
 12:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com> <3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739723830.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Feb 2025 12:01:38 -0800
X-Gm-Features: AWEUYZm3E9XCIvYrAtxPl0Xy-rFiYkyM1mxPXq0igzgAIcIHvc2FC_WzvwVTyas
Message-ID: <CABPp-BEPk+hozriBY687ELi7r-Y2JFy4rsxUCVejMt5wetHiqA@mail.gmail.com>
Subject: Re: [PATCH 1/5] merge-tree --stdin: flush stdout to avoid deadlock
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 8:37=E2=80=AFAM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a process tries to read the output from "git merge-tree --stdin"
> before it closes merge-tree's stdin then it deadlocks. This happens
> because merge-tree does not flush its output before trying to read
> another line of input and means that it is not possible to cherry-pick a
> sequence of commits using "git merge-tree --stdin". Fix this by calling
> maybe_flush_or_die() before trying to read the next line of
> input.

Makes sense.

> Flushing the output after each merge does not seem to affect the
> performance, any difference is lost in the noise even after increasing
> the number of runs.
>
> $ git rev-list --merges --parents -n100 origin/master |
>         sed 's/^[^ ]* //' >/tmp/merges
> $ hyperfine -L flush 0,1 --warmup 1 --runs 30 \
>         'GIT_FLUSH=3D{flush} ./git merge-tree --stdin </tmp/merges'
> Benchmark 1: GIT_FLUSH=3D0 ./git merge-tree --stdin </tmp/merges
>   Time (mean =C2=B1 =CF=83):     546.6 ms =C2=B1  11.7 ms    [User: 503.2=
 ms, System: 40.9 ms]
>   Range (min =E2=80=A6 max):   535.9 ms =E2=80=A6 567.7 ms    30 runs
>
> Benchmark 2: GIT_FLUSH=3D1 ./git merge-tree --stdin </tmp/merges
>   Time (mean =C2=B1 =CF=83):     546.9 ms =C2=B1  12.0 ms    [User: 505.9=
 ms, System: 38.9 ms]
>   Range (min =E2=80=A6 max):   529.8 ms =E2=80=A6 570.0 ms    30 runs
>
> Summary
>   'GIT_FLUSH=3D0 ./git merge-tree --stdin </tmp/merges' ran
>     1.00 =C2=B1 0.03 times faster than 'GIT_FLUSH=3D1 ./git merge-tree --=
stdin </tmp/merges'

Nice; thanks for checking and providing these stats.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/merge-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 9a6c8b4e4cf..57f4340faba 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -18,6 +18,7 @@
>  #include "tree.h"
>  #include "config.h"
>  #include "strvec.h"
> +#include "write-or-die.h"
>
>  static int line_termination =3D '\n';
>
> @@ -623,6 +624,7 @@ int cmd_merge_tree(int argc,
>                         } else {
>                                 die(_("malformed input line: '%s'."), buf=
.buf);
>                         }
> +                       maybe_flush_or_die(stdout, "stdout");
>
>                         if (result < 0)
>                                 die(_("merging cannot continue; got uncle=
an result of %d"), result);
> --
> gitgitgadget

Looks good to me.
