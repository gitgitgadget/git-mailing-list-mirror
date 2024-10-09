Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895840849
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507024; cv=none; b=JpI1D5E2HBzXNlU2qlUBaMH5YgmO/wG0gcxIt3KCYgWTnBoOn7VGuX80ojZNAvmbohqk1x0eewHAy7yjGVjy+445yDhaLakRjmKKSE3F+pJE7mpkuTtnZ+Y2eeM3nIXUAWw1LW5MCgElCKcD54NCXu7W/sulV17W4xJh0xSuJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507024; c=relaxed/simple;
	bh=IQ5QApy910PRgjasz2u5uneSdP1B/67fpyZPvbaN4qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWC9QmFCwXJjNlnsNrJF6KaieIhZKWK2y1aeYWLwHhraYkBjY/VqIRPxAcQwF5B/ddVy/u7Kj/fHaObJi70B5ZCBoDgxBh0ZR+VijCSz2xtg7Hb5jnFTDta9HDZjB6ZnMeslWGtWTbhYSK6W78zqdfvUI9/+m7VOWYOMRPRnZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNlqXaTf; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNlqXaTf"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8353fd2cb2dso8879539f.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728507022; x=1729111822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZnginHKUHbTZtCypf4ZGKM22ZF0+OD7Q9fLzt4Rk4Q=;
        b=dNlqXaTfwBMGQh1LuZEenpK9ZoGBuzHCueFkQeWMU1fJuUz8QDrwxX/EOSHSGAAxT1
         3VVIiT+p+0HWBtidL2oH9Byn/aau41MPzW1m35Sh4Nes/qy4jhicEXg6U7mbO9RhW+rb
         wjAa09g41/wBabQR5/w18ScEzLrjXcgiFy+HKy4FVsFtrJyZ43boohFVNilzNOEyNjyK
         RmtZOQGbOIO40R1MhlClzTAyCzyjtFgu8SC3QfDDYu1qDWEB+YJ2jLlOWO4YDZsib10q
         1IlArzsXiQfeGQw9GBV2JYBkelhxjR6XgpgmjnbLWA9y6VRUMBCQw9Ju8vTqvYgmjFDI
         bVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507022; x=1729111822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZnginHKUHbTZtCypf4ZGKM22ZF0+OD7Q9fLzt4Rk4Q=;
        b=cbbPixJBfxb3KyCjl9YwVBrn677MdbmY01gZFJk2bYV/dDVPWO1JbzrmJ+U8spKVhN
         yieKV24bfP4e3FYF55jLWsKMNC2qr10MbgseYHBW96YDegGvShln/uqyMbd4n8s2H00o
         dzlfnKQnI8T76cQKqUoKS8IN05hhjcAu596D2W7OaZgvoE9KL4Y5qdIXwEt/JxHfmMpm
         YX0PU4r5ny7M5X+5Vg0hWuYouS9X2zOPKi+sxSIEvs8Y/Ns0PXdTiHsrgTNas1FcsZxL
         rkJZ5gorIX0kuQgxBAmRbgVMoIW5SYzY5np0w8N/GWB7c1w4yBFg3KPfcYLclD7FgAwu
         gbrg==
X-Gm-Message-State: AOJu0YylrAbSDnHI8suJJl1kb9WXMtle9uidg6OvYtFlvR6E5bgTVMYr
	AJMnrzyrtUkhiTUh4udt8OZdbnwSRIiCYxByuwppAGqK7yh09ezZOdPYjpJk8XjoAIBOHEbWV8S
	1nE62qkKqeICi4L7EXgoFWlpB8+4=
X-Google-Smtp-Source: AGHT+IFanDSEWpXmzIlKK+UHkivLDcLCkZwxGhUTRz8o8ehDD1Z1NUNRpCYm6I87jmno2UvW/KrQ+8vys0+PvLbDovc=
X-Received: by 2002:a05:6602:6010:b0:832:13ce:1fa3 with SMTP id
 ca18e2360f4ac-8353d4ad333mr486834739f.8.1728507022255; Wed, 09 Oct 2024
 13:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728413450.git.code@khaugsbakk.name> <cover.1728492617.git.code@khaugsbakk.name>
In-Reply-To: <cover.1728492617.git.code@khaugsbakk.name>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 9 Oct 2024 13:50:10 -0700
Message-ID: <CABPp-BE=JfoZp19Va-1oF60ADBUibGDwDkFX-Zytx7A3uJ__gg@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] doc: merge-tree: improve the script example
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, phillip.wood123@gmail.com, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:54=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> =C2=A7 Changes since v2
>
> =E2=80=A2 Squash into one patch
> =E2=80=A2 Use `vi message.txt` before `git commit-tree`
> =E2=80=A2 Also declare the branches
>   =E2=80=A2 Fully qualified for `BRANCH1` since it is passed to
>     git-update-ref(1)
>
> Kristoffer Haugsbakk (1):
>   doc: merge-tree: improve example script
>
>  Documentation/git-merge-tree.txt | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> Interdiff against v2:
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index 41dfb16476d..0b6a8a19b1f 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -211,11 +211,14 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[=
1],
>  linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
>  used as a part of a series of steps such as:
>
> +       vi message.txt
> +       BRANCH1=3Drefs/heads/test
> +       BRANCH2=3Dmain
>         NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
>             echo "There were conflicts..." 1>&2
>             exit 1
>         }
> -       NEWCOMMIT=3D$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSA=
GE \
> +       NEWCOMMIT=3D$(git commit-tree $NEWTREE -F message.txt \
>             -p $BRANCH1 -p $BRANCH2)
>         git update-ref $BRANCH1 $NEWCOMMIT
>
> Range-diff against v2:
> 1:  b1ca5cae768 < -:  ----------- doc: merge-tree: provide a commit messa=
ge
> 2:  13e0f3bed5d ! 1:  c7e0d76e71e doc: merge-tree: use || directly
>     @@ Metadata
>      Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
>       ## Commit message ##
>     -    doc: merge-tree: use || directly
>     +    doc: merge-tree: improve example script
>
>     -    Use `||` directly since that is more straightforward than checki=
ng the
>     -    last exit status.
>     +    =E2=80=A2 Provide a commit message in the example command.
>
>     -    Also use `echo` and `exit` since `die` is not defined.
>     +      The command will hang since it is waiting for a commit message=
 on
>     +      stdin.  Which is usable but not straightforward enough since t=
his is
>     +      example code.
>     +    =E2=80=A2 Use `||` directly since that is more straightforward t=
han checking the
>     +      last exit status.
>     +
>     +      Also use `echo` and `exit` since `die` is not defined.
>     +    =E2=80=A2 Expose variable declarations.
>
>          Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
>     @@ Documentation/git-merge-tree.txt: linkgit:git-commit-tree[1], link=
git:git-write-
>
>      -       NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
>      -       test $? -eq 0 || die "There were conflicts..."
>     +-       NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANC=
H2)
>     ++       vi message.txt
>     ++       BRANCH1=3Drefs/heads/test
>     ++       BRANCH2=3Dmain
>      +       NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2) |=
| {
>      +           echo "There were conflicts..." 1>&2
>      +           exit 1
>      +       }
>     -        NEWCOMMIT=3D$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_=
MESSAGE \
>     -            -p $BRANCH1 -p $BRANCH2)
>     ++       NEWCOMMIT=3D$(git commit-tree $NEWTREE -F message.txt \
>     ++           -p $BRANCH1 -p $BRANCH2)
>              git update-ref $BRANCH1 $NEWCOMMIT
>     +
>     + Note that when the exit status is non-zero, `NEWTREE` in this seque=
nce
> --
> 2.46.1.641.g54e7913fcb6

This round looks good to me; thanks.
