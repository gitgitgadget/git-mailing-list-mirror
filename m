Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E259C85
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396355; cv=none; b=cNiWfBzlLgcmQhInoEBvWtKyv2E+1QR1EqK+7I9spy5LQ4Rd3mj9upffjZElqmD08FyU7C660FodDkzH6gxndfLAI/4o7cCYcxnY5GTvEc8X6Cq0zhWPKTXVEP2ggWABi8dnoBXpAT9Q/j84u7oe4mLOzYqw1MnO0FJNna0ZfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396355; c=relaxed/simple;
	bh=R2fYFSMqHTx5QNn8vwHGlvXK5TtekSedjJ5dQZ8J97k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAco7qS6D2qJ3UM4g09Rz5h+PF9McEehgWWWoei+kacCWnfPjhD9pY57GDW2l3d6P7o8EcydPuCnHBQW0OGfemscTsmDYaSRSx7PCVH9O2XFWSmfdd140vw2JWYll9kOWkesLik1lVtyf0OFhxfKiCwFvdV6UJILXSKRaQZHZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Azxs+ZEI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azxs+ZEI"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so3999458a12.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744396351; x=1745001151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2fYFSMqHTx5QNn8vwHGlvXK5TtekSedjJ5dQZ8J97k=;
        b=Azxs+ZEImavi5zjZO3vG8INF5ATA0uvnuW62tIiK44GsygNiQ4Gfx8/nz9u60XmkXc
         t3E84QXBRnUhTdrDL+fZ4atxySk7c3M7LuP01cNIz3LX8KWqoOit+KyeD67jDJgzEgX/
         xTabpeCTo1ciie14TOERHfX9C+l3HWrVZ4r5fm9pnmQGZM4VFICgJvdcRedpkW5O3Epa
         B2sMdXwh5w6AfbLTUrOagZo2Pk/Qnn0y8dSSNTTXTtYTy4NG2PQcPTcXgTjOvbEG2niD
         kLSlG0rypak0chwNaGSdZyT+GMDWDHXTpYiHILaOKdqHNH1jxZ7eXS1SvCszFAospJZc
         InyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744396351; x=1745001151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2fYFSMqHTx5QNn8vwHGlvXK5TtekSedjJ5dQZ8J97k=;
        b=bHmTRKPj/NhkCYjTUlFwQKh8wZqCqykDhf/jSIr/rMYEnOsjeUJwUFsCzpDUQcqlP1
         tRVcSwbwOy+MnpXZI9tdeJpaaAwVpHiuDLGad9cxnEoI1JrVpnpTykFaRTec976HWHDC
         isrI5FCBMQ3yvTaJf3pshnxIAV182rm0XLc5ivHf6M9RmiKOsims8AXn0biO0WHRw8hS
         gyeK68zjqTXLhvf2Nh4jX+r8cdLpQY7q6NieCUz9cs4kxenrkLi7vg8sdX2oF8QbixiE
         EO7rb7p+Z//r7j+U6AhPg644kqZubqrIFwZcNevTyA7ZWKnTi0FbxlCNZavby2c4m/vJ
         +vzg==
X-Gm-Message-State: AOJu0YwbVu/wHabXG9NBrNWpeUptNXQvLTKdR/3k4gWEOupIFzwP+5o+
	vQLDojYEQlVBcnM5UkqEYUv7oUzumy54fXkk++FCeGZiNILlINxwqrIWOnb2adAAXI0Z4exQk/b
	iT7xEeHq2di8BBWt+Q3CCcHZnac4=
X-Gm-Gg: ASbGnct3mz4wOSF0yNnFMtefWMCi3z7110d7DHPv3Pf5cUArG5Ve0mZoIm9QH/oix0L
	9t0cK26mSLxxyYSB63zMS3B+RaKwAcGI3ijyDSQw+tHa+DTgUmRh30czsqjKhd7jBU1jSm27856
	G784fqPluIxwq8LyUxn5okmTvLteQLQXGUVVHlE2DZi2C8+4PReeFIJvBO
X-Google-Smtp-Source: AGHT+IEDGqFgCDI4CeQcr8G/ULVdFeAEvXI0Y51pCDzCWdIks8UM5YaGgLz43veJf5f7DAbl+dPrnfk7hwhvIuTa1ds=
X-Received: by 2002:a05:6402:1d4f:b0:5f0:d852:dedd with SMTP id
 4fb4d7f45d1cf-5f36fb8a139mr3014338a12.20.1744396351427; Fri, 11 Apr 2025
 11:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76edd34d-3fd1-437e-b8d3-7e64e99644a2@gmail.com> <CALnO6CCbzqez9-BvbuV3NRRMvFLHSv57Tfwj3ibadUAMKznWrw@mail.gmail.com>
In-Reply-To: <CALnO6CCbzqez9-BvbuV3NRRMvFLHSv57Tfwj3ibadUAMKznWrw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 11 Apr 2025 14:32:19 -0400
X-Gm-Features: ATxdqUHoQRYTRR03KivJ5arvXmQKsQXKsdlxA1zqRiwHj2Ipgunve66xEd1uKwE
Message-ID: <CALnO6CCYqF1QHQzS6DH200cqi6VRmhWjvts87S99a+jqqgHHfw@mail.gmail.com>
Subject: Re: Bug: being stuck in rebase mode when accidently typing `git am`
To: Ludo Pulles <ludo.pulles@gmail.com>
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com, 
	Lucien.Kong@ensimag.imag.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 2:23=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Thu, Apr 10, 2025 at 10:35=E2=80=AFAM Ludo Pulles <ludo.pulles@gmail.c=
om> wrote:
> > 3. Run `git status`. It will say: 'You are currently rebasing. (all
> > conflicts fixed: run "git rebase --continue")'.
>
> Yes, this is odd: my shell prompt (using the contrib script) says
> "AM/REBASE", so I know better: git am --abort does the trick.
>
> This seems like a failure of git-status more than anything; I wonder
> if there's some difference in how the prompt script checks for
> in-progress am vs. how git-status does it?

Ok, looks like the prompt script checks for rebase, apply, and then
gives up (its ambiguous):

if [ -d "$g/rebase-apply" ]; then
__git_eread "$g/rebase-apply/next" step
__git_eread "$g/rebase-apply/last" total
if [ -f "$g/rebase-apply/rebasing" ]; then
__git_eread "$g/rebase-apply/head-name" b
r=3D"|REBASE"
elif [ -f "$g/rebase-apply/applying" ]; then
r=3D"|AM"
else
r=3D"|AM/REBASE"
fi

(with apologies for GMail stripping leading tabs :eyeroll:=E2=80=94source c=
ode link [1])

Meantime, wt-status just assumes it must be a rebase if it isn't an apply:

if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
if (!stat(worktree_git_path(the_repository, wt,
"rebase-apply/applying"), &st)) {
state->am_in_progress =3D 1;
if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"),
&st) && !st.st_size)
state->am_empty_patch =3D 1;
} else {
state->rebase_in_progress =3D 1;
state->branch =3D get_branch(wt, "rebase-apply/head-name");
state->onto =3D get_branch(wt, "rebase-apply/onto");
}

(source: [2])

The shell distinction was contributed in e75201963f (Improve bash
prompt to detect various states like an unfinished merge, 2007-09-30),
author CC'd.
I think the logic in wt-status.c is largely unchanged from 83c750acde
(wt-status.*: better advices for git status added, 2012-06-05), author
CC'd as well.

Maybe we can omit a "You might be rebasing or applying; we're not sure
which?" type of message?

[1]: https://github.com/git/git/blob/08bdfd453584e489d5a551aecbdcb77584e1b9=
58/contrib/completion/git-prompt.sh#L517-L527
[2]: https://github.com/git/git/blob/08bdfd453584e489d5a551aecbdcb77584e1b9=
58/wt-status.c#L1725-L1734

--=20
D. Ben Knoble
