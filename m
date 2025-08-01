Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26D13A3ED
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074824; cv=none; b=QsgVwrxvriLiQPx5zVfMq+UDI4QEUgeXFsEdNo1Zj45aBZJnE/dQrjuTcWj1kgRTxU+JMl+vYB95Jah/mpi+C0luqTChHlubarJ7PjEnyQdhxlsC2HYHH3eX19AGVWiWuU53VM3Q/wtPHTCFPacCyATqb00wGrZeGWfauEdkmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074824; c=relaxed/simple;
	bh=zjs1X+SrZh7vsflBHKge8T2pG1hUbbM5XCdBzoXGeqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tR5Zyrc18+D60qlbwqclGfE/j3JHoHCu3S6NirtsX1491RM+jkFGrKV2hKGeFuLb7pn0O31+M7jMo5EEdshzdcz5qc3/eDC68sXW2i9y+RIgS1kme3LFtaRXZITM/x2M9auppnwMEWAEI2x2s+ssNpIdBJuehVTBpqUJpPumaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3rvC6a0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3rvC6a0"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3322e4ac195so22329761fa.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754074820; x=1754679620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfNPjj7XvbuqAr6nRuVfXPSRzpJs25SibPL44J8ECl8=;
        b=T3rvC6a0w9ziARBRabjcr/JYr4BG4qZtPPYbX7tXdtG+rRjDKb6Jco2QZhK+sXtnO4
         rhi7BI64qytT6UQqCiDGYOblzghz88Y1TEVcUILtbHlm6DH4WzJ9kyJckb17tTbbOnaY
         ZXrCIw6FVsoVUXPKLNacDhYNB33psID/rIx/GSnNfLzNQGBCFF3MDj9kTKJg+a27KZzv
         TiHw9ZZORDO5VG638xbd2xNyshXIxTzCDuXqVDBhpkKYKC2Mn8+fWiPhbjwxcYH77FrT
         AJDY910+LLkLq/giZjCft9gSL84HH7ETrby0GGEZPYSZIWVlEnHeBek6khoCHPoJwItD
         qN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074820; x=1754679620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfNPjj7XvbuqAr6nRuVfXPSRzpJs25SibPL44J8ECl8=;
        b=G+VHsL4vRSV6qqxGhXH/3ibP5YK2iZlYBQYHLA53f2MzyCuXQW3rcU/8RiiuaOhNM2
         Njxk/oDHPmqbvqGtHzSwAv4MJjHOT4pWWD31bcZjGdd8OcS3x4H4wyEAHsvqyLQFjrXm
         mrbaxPFGtKxdDiyNzC9aUaixPWvSWz7iybiJ0o8e3oCdEGqEHAEV5zyo2hmN7s32CCd7
         hj1NDuYuBtw17wwq9n9vgr+pNVI0gP8mMuESJhICqLjtco42PZ/RDPzL52MZT3ZUmLRg
         5G8rD7R5+BsEKD+PuufEuoJ27Tm7uIWVBbKmkJZ4ry0t8OTQT/TcYFVGSz0jsCOeFTXE
         yk/g==
X-Gm-Message-State: AOJu0YwHFX5mrof52L6W9HblqjvrfjLJ4+33FikyohhCkanudl5k3oGH
	HGYgO5OVHX65NKtiUFv+P8UHWZWkbWyXAKo8yY5mhjE69LP5aQBvSTBAg8as7HiOBvvlTd8QUX3
	e6s7JRggq/rhvrkYRQORtymKdeRhlgkghJVr4NjCHww==
X-Gm-Gg: ASbGnctzHymGytLSy3iYBpdUOaN60O/UP932bJIYSLcbha08aEkiQ6uqFLnZoOBlhwI
	YOCufZ6uidc31xQ2xT31JVAAy7icd2omSBTPIqiqd5dYEKPnvHcdmSkQyXL8G2AmgNZ1fShpjnp
	4XjyZJXA+i52gJm4tUtw98Hc4uHBIqFsiVioMRh+/dnO48teL6JEvrmLJ+WFb1RLZhfIVxzY9d8
	LOc5U5HZE4ARztYcwhX2qv4MJYUTH6bXwLwPIjd6qMhc6UMTd4=
X-Google-Smtp-Source: AGHT+IH75F7Eh6cslzFT2tM+VAouzHDad+79IcrDOmbMcGoLsQaGGlDmgP007Um1d4l6UVDDLmRwSR4ygrA/xKC5+iY=
X-Received: by 2002:a2e:870d:0:b0:32a:7d76:2642 with SMTP id
 38308e7fff4ca-332566cb0b9mr1110841fa.2.1754074820089; Fri, 01 Aug 2025
 12:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOazyz08vf65ezNMuUyOCYYHBGmDSeCtzXn=WdZAWGO9ZjCkAQ@mail.gmail.com>
In-Reply-To: <CAOazyz08vf65ezNMuUyOCYYHBGmDSeCtzXn=WdZAWGO9ZjCkAQ@mail.gmail.com>
From: Alon Bar-Lev <alon.barlev@gmail.com>
Date: Fri, 1 Aug 2025 22:00:02 +0300
X-Gm-Features: Ac12FXwjk0ewupSlYYeddy5dlYkTCGpBEJFwXHaUHGdPGnHKnc2CNVTnDH_QL4I
Message-ID: <CAOazyz32EAhqXmSTG7BVW2gLkgJort5ghR4+e2PjSn_b5pcBYg@mail.gmail.com>
Subject: Re: [feature] git clean ignored files in nested repositories support
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I tried to trace the code and it seems like there is a bug or
different behavior than the documented behavior, the recursive
implementation in `dir.h` is quite complex, this is not a trivial fix.

"""
man git-clean
       -f, --force
           If the Git configuration variable clean.requireForce is not
set to false, git clean will refuse to delete files or directories
unless given -f or -i. Git will refuse to
           modify untracked nested git repositories (directories with
a .git subdirectory) unless a second -f is given.
"""

I expect untracked files to be removed from the nested git directory
when `git clean -dxff` is executed, previously I thought that the
ignored files were the issue.

Reproduction:

```
mkdir test
cd test
git init .
git commit -a -m "root" --allow-empty
git submodule add https://github.com/git/htmldocs module1
git commit -a -m "init"
touch module1/junk.txt
git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
  (commit or discard the untracked or modified content in submodules)
modified:   module1 (untracked content)

no changes added to commit (use "git add" and/or "git commit -a")
```

Now, clean recursive and allow nested (double `-f`):

```
git clean -dxff
git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
  (commit or discard the untracked or modified content in submodules)
modified:   module1 (untracked content)

no changes added to commit (use "git add" and/or "git commit -a")
```

Expected behavior: the `module1/junk.txt` removed.
Actual behavior: the `module1/junk.txt` remains.

For some reason I remember that a few years ago this worked as
expected, at least in removing untracked files recursively and in
nested repositories.

Thanks,
Alon


On Sat, 26 Jul 2025 at 15:00, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>
> Hi,
>
> I am sure this was discussed in the past, I could not find any
> explicit discussion.
>
> The `git clean` is a handy command, it can clean directories,
> including ignore files and also handle nested git repositories if a
> second -f is given.
>
>     git clean -dxff
>
> However, as far as I understand, it is not possible to clean ignored
> files in nested repositories, the `x` is applied only to the local
> repository.
>
> As workaround following command may be used:
>
>     git clean -dxff && git submodule foreach git clean -dxff
>
> However, I expect the double `f` to take into account the `x` and also
> clean ignored files from the nested repository.
>
> I am unsure if this is a bug or intentional.
>
> If this is intentional, maybe a patch to have a second -x would be
> acceptable? so that we could have something like:
>
>    git clean -dxxff
>
> Any other suggestions? It would be nice to be able to clean the entire
> tree with a simple git clean command consistently in all scenarios.
>
> Regards,
> Alon
