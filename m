Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3579D1
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728196261; cv=none; b=lSODspL7ypDeP5c3k+i5RQofX+ykyHyZkffQ3K9I6K7jhJgJBbXuJgNqD1PWZEFIza/8PBCw9gGGh2W/t6WYDosmXhS7frv5NGWzx+CYTLMnEj7Ubwkoe9B6Ic96O3wPOAgj1JIgkZNTDxFs2Lm61ZaPQfygW2Xt9tJV5LMD3io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728196261; c=relaxed/simple;
	bh=IkmmIYpGbxxtiiToc0IWv+Xn8tZ3dC8+Ip6V46KfZI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHiHj9m0TC5iW+BgAVSBYijJbwDTsya3l4txQOFWrmjUbzcLBp3Ktee+wcms2CC/64m2UTwFq9EvQLf3gdHnnT3STLBPmmhB7t7E0hjpw5UFvrvJmpmpcCOOJ9UFKQdoAnd/QwIkgkeS1gWmN9Ph+LV/B7JIl2froo+9ZMkFU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZdW+BH/; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZdW+BH/"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a3a34b3a5aso1010227137.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728196259; x=1728801059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANvPNKzNI5uTd80nyCNl4gujbD8635ioQZ3PoPBRv6A=;
        b=kZdW+BH/UfbUt4NPY/Jd80v14pzHVZ0xAqEciLl+SZ38LPCusig9AoDlLhNfL5IBNf
         9MpGvNJEAZJdBZgjrENA80KcaniVSPwOvjOpkGiwEtuKDDwRK8kujZM+NpVgZVYhs9Ws
         wi0kTyAlh+fGwvUF9skrc76f/c/14JVAutlLeDcsQKHnxLMjMcTM4s4i32PQ5pidGuoC
         ESTFy2QEuxU0Y5w9p5V5omMk9+Z3S+8ahBDFIuK7SNKZE9tAjCtKLeuGdgowsURLYc7S
         MY+8TUcZwJVSmPaNN6URy9q+c2CJDvOAAlYxbJDzsNLj88c5DE5lQUOuxbJASkQJUabf
         YR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728196259; x=1728801059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANvPNKzNI5uTd80nyCNl4gujbD8635ioQZ3PoPBRv6A=;
        b=j1iTRNQwg0b2lBsRBn6rm1kvE2wRPE6lK2OHD27Vx1+E2rXYBcNH7djA+HXaebQ0vj
         rRl5E/Gt94+c6I547Rq0tNEhqihRfBAGJF/Hd0Yh/M3kjh4h57+5YBClyYR1/zTQhRnY
         fI6icq+c/dqfo3IKA7Pqy0xH2pvcLlpHA83JGgwa84k8dx33UQG0Xnz9MwyVODK4ZE8r
         +YTGNVgiMEU5+Y+KCaU1+/LkfatzrDTpSsnAR8y7iKNgFcOJt7CccLB6MqKkTVRfM2OK
         Xh//feYDeq9DTNlBkx8dTatXTlWtjjXtfxUvDqwEI6OvbNsG/Pv7zE/98SugLY96Nwdx
         HLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlSyyrRB1uxBUW5cU4ht6gP33uKofpooeuzygWoWFby2LmVyoL+52q9OZvTkCwIhI/1JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2UrjvHVzfEgx7p7gP31mEFPBrkkNiYFbQWAc1J2B5Rl3GpRLa
	SmPS2Xu327GZ57QssBzisNv2hHfQuC9G3ReUHhKDqO6gqHChaPcWjfqcnz+DKPXpU0Em1d1Wsls
	t8RI+vZB9ob0xh18KjQGGsOnRR/M=
X-Google-Smtp-Source: AGHT+IG/4Vs3aPLy3xhzZcK2dAiSG+5cOwyfk6PH8zy7+ITNiTmAbHMBx+keoEnB2VJ2Q9ozs2xvdfSQADCV9epVw9A=
X-Received: by 2002:a05:6102:508b:b0:498:d12b:4774 with SMTP id
 ada2fe7eead31-4a405763f01mr5156340137.7.1728196258740; Sat, 05 Oct 2024
 23:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <4199434bd6ef2142192d1c720ccd877b1a80536b.1728192815.git.gitgitgadget@gmail.com>
 <CAPig+cTb4mgpXnN79UrXvjvCnqGZhaR51oZX_Ds=HwdqQYFN9w@mail.gmail.com>
In-Reply-To: <CAPig+cTb4mgpXnN79UrXvjvCnqGZhaR51oZX_Ds=HwdqQYFN9w@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 06:30:47 +0000
Message-ID: <CAPSxiM_RKpp2_Y7HqhhFJqnavKpToViAjE3s6AiwCwUjGa8H4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] [Outreachy][Patch v2] t3404: avoid losing exit status
 to pipes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 5:48=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Sun, Oct 6, 2024 at 1:33=E2=80=AFAM Usman Akinyemi via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Changes since v1:
> > - Added "tr -d '[:space:]'" to handle whitespace on macOS
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
>
> Thanks for the submission. A few comments...
>
> This second patch fixes problems with the first patch, but since this
> is an entirely new submission, you should instead "squash" these two
> patches together and then force-push them to the same branch that you
> used when submitting them via GitGitGadget, and re-submit them as a
> single patch. When you squash them, keep the commit message from the
> first patch.
>
> Reviewers do appreciate that you explained what changed since the
> previous version, but we'd like to see that information as commentary
> in the patch cover letter, not as the commit message of the patch
> itself. In GitGitGadget, the way you would do so is to write this as
> the "Description" of the pull-request (possibly replacing or amending
> the previous description).
>
> Some more observations below...
>
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> > @@ -401,7 +401,7 @@ test_expect_success 'multi-squash only fires up edi=
tor once' '
> >         git show >output &&
> > -       count=3D$(grep ONCE output | wc -l) &&
> > +       count=3D$(grep ONCE output | wc -l | tr -d '[:space:]') &&
> >         test 1 =3D "$count"
> >  '
>
> The reason this was failing for you was because you quoted $count. Had
> you instead written:
>
>     test 1 =3D $count
>
> when it would have worked as expected. In other words, you don't need `tr=
`.
>
> These days, instead of manually using `wc -l` and `test`, we would
> instead write:
>
>     grep ONCE output >actual &&
>     test_line_count 1 actual
>
> However, that sort of change is independent of the purpose of this
> patch, so you probably should not make such a change in this patch. If
> you're up to it, you could instead turn this into a two-patch series
> in which patch [1/2] fixes the "Git upstream of a pipe" problem, and
> then patch [2/2] converts these cases to use test_line_count().

Hi  Eric Sunshine,
thanks for the review. I really appreciate it. I have a couple of
doubts to clear.

My next patch should be the squash of my three patches which include
my first two patches and the new one on the same branch ?
Two patch series means two different commits on different patches ?
But, since they both depend on each other would not they lead to merge
conflict ?
Also, to be clear, "Description" is the body of the commit message if
I use the gitgitgadget while the "commit message" is the header ?

Thank you.
