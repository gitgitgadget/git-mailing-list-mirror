Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4C170A08
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203220; cv=none; b=MtmvOw+R6ULGPCUu4WOaVBfAOld5vyvw7D4B2ka5AtCjjPkqYOEG3yBu3bl8X+PJSx66MjimCI09hRoY/vX5SRKGCX+hgAvOszjT3zftKWPboy+VBt6NTK+SyzaTpfyQExUqqfymo4Ne/TXHKymP5xpvdjNzgxM6wPITdeCBcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203220; c=relaxed/simple;
	bh=ODoBFSKk84iVYrwLfKd3YTnX4r/UAwmAoT1NQcdIXD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F58vN+vNTtXKWSqOx7uhYChCCuai0BitIPQS4sZ2aW9OL8Kvo1fmbjzoBwtS1V0BW+L7pMEqQmYdarNpg9+iCQFlRNjiRxX0adkDMr7A5qa3XcITGenhajZVz4xAyZdauVOVOwNChi7xTHK15cbkEO1uHh5urrSZAZrOAp8V7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7sj2bFP; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7sj2bFP"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4a3a62bfda2so1020726137.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728203216; x=1728808016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE6FXCMRb7ZSEmgDan2FcTU67+PlLVHqN6JDtbQ2+a4=;
        b=S7sj2bFP40bXifKYtUxogAVPvvd6hZd55auALHEe7S0PcP4QdxrJIerr+DQ17ZCk1m
         WaAc386FlCGU9WBtEy3LVcLiXieAx9K/LbRBD6OLCvsW0u8OX6oMZrdaMmnOHtRlalay
         8OGyFuULkf7gp8q/HbqKPAgOaLrLzNS61HuFIT2Sxql6rJB8Fqn7BkxpuS8a0dhFM7bM
         9PFTkA1uGzfQ1pksaiN2EbuX48b8CjCjGOS721Le7P6/yNRy5SH58qAiYVQh0tlwf4t6
         Ml/qrJwlG4O5rGoRduAgas6SuZT7fiPRk49oBulgYbKBTazDD5SB26xwO37t3tPjEcog
         Tchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728203216; x=1728808016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE6FXCMRb7ZSEmgDan2FcTU67+PlLVHqN6JDtbQ2+a4=;
        b=SAcQcTWSYz6lU/HY3b1Si8NDoSxPE4CrToZs6PMkHKfkYI2VW0umT3Hcc5LxFk9qS5
         a1Dbt6cuv8jfekU9Flq4HaOHYyluwPPOd77Z/LClwMCjmh2ijrDuvrbaKAaacvBY/0rl
         lU9g68EwA06kPR92ADmDCl17p5oEE+0tZbTjWXwJqwI00yvtxUwOroxQw3eRRMJr2rtP
         Hg5jdsE7EZVLI1rmLLS0tete/oe3mYTVimf+my12rHlU+lFKMNQz8UC68WNs274vaKd1
         hBg07bAIBNo5vZXj/uxcWh2nGTFNo4rJvVcrAEtEPb3V5LMgBFscmajPFt4ziPLz6fmY
         kYBw==
X-Forwarded-Encrypted: i=1; AJvYcCWGHKa+tYqYXyXi1UcqKVrR+8iR/RsSIqpgVdWxLkvA3JluDDwtmtKnQxfliSSJk5EeVvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BuTVALLZ4ZCIYYmyFf5Bz7BP9nECDFerMCmchS9ESruZDsDk
	hS3T/orsCMijMrBfXQxN4uCstXsU9adEbZT1CGJmb6LiEcDfdGjDOOREbLfyzaY/AKzErOxO0ma
	8mnWmrmAC8WFoYlf+Pux+wCVBMW4=
X-Google-Smtp-Source: AGHT+IHU6EhxJQBh7IlVZhNXXgs4s9Wq7LHwC7nxKeawc0Bor8+dIpf0tajAjuYW/T7ZyuDjhA8KhrYHAf1LnevPX9s=
X-Received: by 2002:a05:6102:290c:b0:4a3:f9e8:2fb9 with SMTP id
 ada2fe7eead31-4a4058f48f3mr4412818137.24.1728203216233; Sun, 06 Oct 2024
 01:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <4199434bd6ef2142192d1c720ccd877b1a80536b.1728192815.git.gitgitgadget@gmail.com>
 <CAPig+cTb4mgpXnN79UrXvjvCnqGZhaR51oZX_Ds=HwdqQYFN9w@mail.gmail.com>
 <CAPSxiM_RKpp2_Y7HqhhFJqnavKpToViAjE3s6AiwCwUjGa8H4g@mail.gmail.com> <CAPig+cTkj-wXqgLNM5hyKa9c3U3AT6L2oUpdbTg7nGUHpa=1Vg@mail.gmail.com>
In-Reply-To: <CAPig+cTkj-wXqgLNM5hyKa9c3U3AT6L2oUpdbTg7nGUHpa=1Vg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 08:26:44 +0000
Message-ID: <CAPSxiM99CoYzC04-OKRdmddHv2_=9GBgTCJeSEACZ=jQm5gLsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [Outreachy][Patch v2] t3404: avoid losing exit status
 to pipes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 7:28=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Sun, Oct 6, 2024 at 2:31=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> > On Sun, Oct 6, 2024 at 5:48=E2=80=AFAM Eric Sunshine <sunshine@sunshine=
co.com> wrote:
> > > This second patch fixes problems with the first patch, but since this
> > > is an entirely new submission, you should instead "squash" these two
> > > patches together and then force-push them to the same branch that you
> > > used when submitting them via GitGitGadget, and re-submit them as a
> > > single patch. When you squash them, keep the commit message from the
> > > first patch.
> > >
> > > Reviewers do appreciate that you explained what changed since the
> > > previous version, but we'd like to see that information as commentary
> > > in the patch cover letter, not as the commit message of the patch
> > > itself. In GitGitGadget, the way you would do so is to write this as
> > > the "Description" of the pull-request (possibly replacing or amending
> > > the previous description).
> > >
> > > These days, instead of manually using `wc -l` and `test`, we would
> > > instead write:
> > >
> > >     grep ONCE output >actual &&
> > >     test_line_count 1 actual
> > >
> > > However, that sort of change is independent of the purpose of this
> > > patch, so you probably should not make such a change in this patch. I=
f
> > > you're up to it, you could instead turn this into a two-patch series
> > > in which patch [1/2] fixes the "Git upstream of a pipe" problem, and
> > > then patch [2/2] converts these cases to use test_line_count().
> >
> > thanks for the review. I really appreciate it. I have a couple of
> > doubts to clear.
> >
> > My next patch should be the squash of my three patches which include
> > my first two patches and the new one on the same branch ?
>
> I'm not sure which three patches you mean. Does the third patch, the
> "new one on the same branch", fix problems from the earlier two
> patches? Or does your third patch implement the suggestion regarding
> test_line_count()?
>
Thanks, I really appreciate your explanation. Thank you very much. By
the third patch, I meant the new one which I will be adding.

> > Two patch series means two different commits on different patches ?
> > But, since they both depend on each other would not they lead to merge
> > conflict ?
>
> A patch series consists of one or more patches in sequence. Patches
> within a series don't conflict with one another; later patches build
> upon earlier patches. You create a series of commits on a single Git
> branch. When you submit that branch as a pull-request via
> GitGitGadget, it turns the commits on that branch into a series of
> patch emails to the Git mailing list, one per commit.
>
> Before submitting the patches via GitGitGadget, you polish them
> locally to repair any problems before submitting them for review.
> Rather than making subsequent commits fix problems with earlier
> commits, you instead should fix the bad commits by using "git rebase
> --interactive ..." to either "fixup", "squash", or otherwise edit the
> bad commits. Once you are happy with the commits, submit them. This
> way, reviewers only see your polished result, not the series of steps
> you made to arrive at the polished results.
>
> You do the same thing after reviewers point out problems or ask for
> changes. Edit and re-polish the existing commits to address reviewer
> comments rather than merely making new commits on top of the existing
> commits, and then resubmit once all the fixes have been applied and
> polished.
>
> When I suggested squashing your two original commits it was for the
> above reason. In your original submission, patch [1/2] had some
> problems which you fixed in patch [2/2], but reviewers don't need or
> want to see that; they just want to see the polished end-result, which
> you can obtain by squashing the two patches together. (However, in
> this case, as I pointed out in my review, you don't even need to use
> `tr`; just use `test 1 =3D $count` instead of `test 1 =3D "$count"`.)
>
> If you wanted to do the extra step of also updating the tests to use
> test_line_count(), then that would be a separate patch, still on the
> same branch, built on top of your "fix Git upstream of pipe" patch.
> Thus, it would become a two-patch series: patch [1/2] fixing Git
> upstream of a pipe, and [2/2] employing test_line_count().
>
Thanks for this. I will submit the first patch, get feedback then
approach the second one.
> > Also, to be clear, "Description" is the body of the commit message if
> > I use the gitgitgadget while the "commit message" is the header ?
>
> The commit message is separate from the patch-series commentary. The
> commit message of each patch explains what that patch changes or does.
>
> Once you have polished your commit(s), force-push them to the
> GitGitGadget pull-request you already created. Then edit the very
> first (topmost) comment in the pull-request to explain what the patch
> series is about and what you changed since the previous version. That
> comment becomes the "commentary" portion of the patch series.
