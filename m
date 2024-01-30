Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D445BE7
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618261; cv=none; b=NrgB93/IW/0dVdUD8ltfOW9U8W6bhIPm4Psou6LVcvAPVG7ZKsd0ZVX/h8pzGVmnd3MOVNMXsJReNI+15ofzBWMa2BqYJmXRzgbk7uXwH5dZF2jptQZUhc503AsJvbC56RE3Eec/3o/UWoOOXSjrcobgA5uwuih/euMSsJ4X8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618261; c=relaxed/simple;
	bh=imjdykfP7i73arSTHHMM5vb7zmI3UPeddCVmxkMf38I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhlzJI7Lu5U63IqEgbue6z0CldyFakkLtnEwz/BA0WwphZ/xsR4kVfZcEcWbW17gev8J46/5XgVxhwnQ8jTVYY8gXk1+HM23dGRYS/y5X5y+X3O8khf+Y8Xz08gqDhAjYyD7jZPmw5itgB3prPVw4xCq/Gf1eZveE+2f7vxAR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibiWuexr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibiWuexr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso3081874b3a.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706618259; x=1707223059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kslP/Y24xRGOv7TfLx9ORN/aeYkIeKgpRf0sK8PLxtA=;
        b=ibiWuexrj2kT/N8K72sMJCqScA5/cBpNqQkNhAh2+xEHalf9IKzdc36j4hDP70s6TR
         GDwWlIs6FinhMYBothOluaO5DFY1BVmMsNJgBJiz/pG+4mMJXiJOHc+QK1sgLupExmUQ
         TQjkLq0P64tmBRI49+lOrytcDuLBl7LI5/VHe/KUOpz1zCnByXDVsmhAv2DugZQEMs5o
         gxEVbUJyzWnSreAVksSeQCNENBvqYSE8nPL0a7PhfpFXtexT3wwc7KM87isdY/a9ry72
         lFdg2ntDNFaVbXBNUe6J1UKnCfat1muktqNOm0XGWEaaE/uc6OycJZxT2+ACtoyXSK1u
         NTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618259; x=1707223059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kslP/Y24xRGOv7TfLx9ORN/aeYkIeKgpRf0sK8PLxtA=;
        b=OH836Fz7+hnE23izqiAQZUoxXSXZBCFcpoGwWrHxAyzaQ+syClL1FyAOZ6FO+zvXaS
         588MH/tjHcOewhxpBTjkkjiowhS9D6zhRFl4bfRxZQQTXfXlgDNCjcjm+oZBkg3ndf1g
         WREtI7UE9+HBc34hHTBiiBG8SPhNGGXixilGNvcG+IDuRlOOMB/Yr5btl0rCv7jF1lt3
         MhYnHklTYpEjO5YZLo5funTTsVVzepYI9xgnhuQaCYVDXPVTvOUcpKW/wAAuc6BleB1o
         aTLsbqL0/RK+ic3CMUHD4XgRAZEbpcBcMAuWmnDiNHdT2rsDQKAzge9gM55dXsdSW0BC
         sMxg==
X-Gm-Message-State: AOJu0Yz6vPoKIuijrV3JHnlqOGo/CRf8FuFrCa9BPwp+kt3BqbXXrCkS
	FxzN20voau8intgn8SEX7NkyjDRIkkHGPUcgYtHxHdtY1sUNHlBgJCF7zU24uxu7PhxP3Prvnt2
	nu2HvgH0XSl0p6kV7d+5EbPaxPcg=
X-Google-Smtp-Source: AGHT+IESQQZibYilPcMCZCYxQcs9RosWuCAn60fzkBL8wMFPkbopwoniEgKN9l5MTW4Z+3F1ff9OcRQ0kItrBdw7EbQ=
X-Received: by 2002:a05:6a21:9183:b0:19c:8505:a232 with SMTP id
 tp3-20020a056a21918300b0019c8505a232mr8445715pzb.40.1706618259365; Tue, 30
 Jan 2024 04:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g> <xmqqpm01au0w.fsf_-_@gitster.g>
 <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com> <xmqqwmu42ccb.fsf@gitster.g>
 <b3532261-3cf4-4666-9cbd-4ce668cd2e49@gmail.com> <CAGX9RpH0RJfBADQwJ=c7PCHU955vOqd0Wdc7Yi7XUuAQQW_FNQ@mail.gmail.com>
 <CAPig+cSGF+vQrnD0f99cbdpQOOC7X6ULa9tFe+FwVrG0SF4PGg@mail.gmail.com> <xmqqsf4c39e9.fsf@gitster.g>
In-Reply-To: <xmqqsf4c39e9.fsf@gitster.g>
From: Willem Verstraeten <willem.verstraeten@gmail.com>
Date: Tue, 30 Jan 2024 13:37:26 +0100
Message-ID: <CAGX9RpF=tvPwiLO6UYA+uR5f2oqOLUSNaDL-jfn=T=BQ9FNtkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a branch
 used elsewhere
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Sorry for dropping out of the conversation, but I see that the changes
landed on the master, ready for the 2.44.0 release.

Thank you very much!

On Fri, 8 Dec 2023 at 18:13, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> >    Needs review and documentation updates.
> >
> > I'm not sure if the "Needs review" comment is still applicable since
> > the patch did get some review comments, however, the mentioned
> > documentation update is probably still needed for this series to
> > graduate.
>
> Thanks.  I think "-B" being defined as "branch -f <branch>" followed
> by "checkout <branch>" makes it technically unnecessary to add any
> new documentation (because "checkout <branch>" will refuse, so it
> naturally follows that "checkout -B <branch>" should), but giving
> the failure mode a bit more explicit mention would be more helpful
> to readers.
>
> Here is to illustrate what I have in mind.  The mention of the
> "transactional" was already in the documentation for the "checkout"
> back when switch was described at d787d311 (checkout: split part of
> it to new command 'switch', 2019-03-29), but somehow was left out in
> the documentation of the "switch".  While it is not incorrect to say
> that it is a convenient short-cut, it is more important to say what
> happens when one of them fails, so I am tempted to port that
> description over to the "switch" command, and give the "used elsewhere"
> as a sample failure mode.
>
> The test has been also enhanced to check the "transactional" nature.
>
>  Documentation/git-checkout.txt |  4 +++-
>  Documentation/git-switch.txt   |  9 +++++++--
>  t/t2400-worktree-add.sh        | 18 ++++++++++++++++--
>  3 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git c/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
> index 240c54639e..55a50b5b23 100644
> --- c/Documentation/git-checkout.txt
> +++ w/Documentation/git-checkout.txt
> @@ -63,7 +63,9 @@ $ git checkout <branch>
>  ------------
>  +
>  that is to say, the branch is not reset/created unless "git checkout" is
> -successful.
> +successful (e.g., when the branch is in use in another worktree, not
> +just the current branch stays the same, but the branch is not reset to
> +the start-point, either).
>
>  'git checkout' --detach [<branch>]::
>  'git checkout' [--detach] <commit>::
> diff --git c/Documentation/git-switch.txt w/Documentation/git-switch.txt
> index c60fc9c138..6137421ede 100644
> --- c/Documentation/git-switch.txt
> +++ w/Documentation/git-switch.txt
> @@ -59,13 +59,18 @@ out at most one of `A` and `B`, in which case it defaults to `HEAD`.
>  -c <new-branch>::
>  --create <new-branch>::
>         Create a new branch named `<new-branch>` starting at
> -       `<start-point>` before switching to the branch. This is a
> -       convenient shortcut for:
> +       `<start-point>` before switching to the branch. This is the
> +       transactional equivalent of
>  +
>  ------------
>  $ git branch <new-branch>
>  $ git switch <new-branch>
>  ------------
> ++
> +that is to say, the branch is not reset/created unless "git switch" is
> +successful (e.g., when the branch is in use in another worktree, not
> +just the current branch stays the same, but the branch is not reset to
> +the start-point, either).
>
>  -C <new-branch>::
>  --force-create <new-branch>::
> diff --git c/t/t2400-worktree-add.sh w/t/t2400-worktree-add.sh
> index bbcb2d3419..5d5064e63d 100755
> --- c/t/t2400-worktree-add.sh
> +++ w/t/t2400-worktree-add.sh
> @@ -129,8 +129,22 @@ test_expect_success 'die the same branch is already checked out' '
>  test_expect_success 'refuse to reset a branch in use elsewhere' '
>         (
>                 cd here &&
> -               test_must_fail git checkout -B newmain 2>actual &&
> -               grep "already used by worktree at" actual
> +
> +               # we know we are on detached HEAD but just in case ...
> +               git checkout --detach HEAD &&
> +               git rev-parse --verify HEAD >old.head &&
> +
> +               git rev-parse --verify refs/heads/newmain >old.branch &&
> +               test_must_fail git checkout -B newmain 2>error &&
> +               git rev-parse --verify refs/heads/newmain >new.branch &&
> +               git rev-parse --verify HEAD >new.head &&
> +
> +               grep "already used by worktree at" error &&
> +               test_cmp old.branch new.branch &&
> +               test_cmp old.head new.head &&
> +
> +               # and we must be still on the same detached HEAD state
> +               test_must_fail git symbolic-ref HEAD
>         )
>  '
>
