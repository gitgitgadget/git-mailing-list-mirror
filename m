Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F319BDC
	for <git@vger.kernel.org>; Tue, 14 May 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668198; cv=none; b=ge0oXE5RXnaokPYqWP9d0pC3qTekm8PjELM75LI3ATQ+QTe62xtxReu2TQIFcgzg8lLXSLRk2Y5hQ6s+ByHsA4M+a1d02B1duoyn24hBJlvwCVaVhHV+5xa/9e6VBzQQ9ksCVtk4rQ0M9xVyoUDR40FTFhbEXw6kgIudur51FEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668198; c=relaxed/simple;
	bh=2dJFOGB2gFo7OcM+O4mECwo6TMsx2F5J1V1LLDLnFZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKBECrVe3BXeYaS6hdkqIJpEW+4nEOIY7duKpQekufZ/SkrD+htlhz6Sp7YcsW3K2czD8k8E09FYc3NeEhFwCvSvJLot/Kq8ZhLvFDTwtH2LD0K+otpAzzEUQ2hpLwMgmqnGZaXIZ/cz+c0pMYexmTGJhldfoxsHm6hwl9AJpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyR8Mj+Z; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyR8Mj+Z"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e1fcd2e6a4so7247639f.0
        for <git@vger.kernel.org>; Mon, 13 May 2024 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715668196; x=1716272996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wCm0QdLzu7His4U5+Yu0OlVKutGPWgZ6tGwE/39QpJQ=;
        b=DyR8Mj+ZhM6pPAaUIPualddkJtfISiyk06Sk1roF/DWKCRrBy0wKsUl8uqOXkyR3cv
         vcCirN5zBS8MuNLbBpFimtVhL1viRkiUYugpS+Xj5pL7sX0RZ5jJjsdLdGm5pHPaoWjQ
         WYSWEc9KjjuSk9/TjruB0eIWUgdd0wRcVaNg7T+7K77AProqiZP7SBQT7f4EnP+228Zk
         3fuupelXW8usQRK6R1NLxFIe8gECXGsOxrHVuY243+kOBm2jJyEOxvRdlno9/JiwFyJB
         3rPfC9LL3AUkq4UxADJk25IbzgWkRLu4Yxr+BXQQx80G+YMhRacDHC7QBUI93COZMh0j
         qm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715668196; x=1716272996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCm0QdLzu7His4U5+Yu0OlVKutGPWgZ6tGwE/39QpJQ=;
        b=aBXirinQOzbq+ZxWKsAf+GtyKdkkb3OK94FDFaKuwzoE7IcoZP2Qxi2huhoDdHoWmA
         MS/ptS/5sUgx2OB55L6SK1P+1OU4AkWtyp2oVxOrM2IU3+5FCjMbrthK22oVII48MruY
         meVfjdnNZgjjjfJRwB9LXhswdke/yt+/6fZ2Fqux2RsFb9zjI+aljIqyVc0RRw0WVAwn
         lAIv8A3U996z6H5XQJ4x1aWHmJE1tttZBeneVG5bG7rF9WH0zwMrRe8cKDRbHN+72H6W
         aSUhVPAWAYs0svNhU6y9DV1VhR7xMZoAzGh4vaccZFtqszNP7GGxY7vWYLTzasdG3L4f
         gwsw==
X-Gm-Message-State: AOJu0YyLS9scRuDwyELwFR84QlKm7gtROXjq8jr+MOYB1FXZ6fgbDy7F
	946njz/ny/KB62u8HXiPKBYCQNndqeC3USFwu8tSvxzpVn53N9jVC5MwpalHUGWD33958cNQLeP
	PMPN/rdyDCMXiuRRHeZndu41guXkbdwvW
X-Google-Smtp-Source: AGHT+IE9y4SF++183Ssf3r0vh8z1DWIg/VsFHnPMDFrb1YvTKUWwN0tfvBsBB0bdL4RxwG1iM2hKl1mdG1maG1iGXKY=
X-Received: by 2002:a05:6e02:17ca:b0:36b:85e:7d69 with SMTP id
 e9e14a558f8ab-36cc144b718mr210491385ab.10.1715668196316; Mon, 13 May 2024
 23:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
 <13fa579b-8987-4430-967c-42b9de8acb6d@gmail.com> <CAJsoDaFhTcm0fEw3+Ba4PvTjPYxscALeLN2kBgs4YYz8Bg-R7g@mail.gmail.com>
In-Reply-To: <CAJsoDaFhTcm0fEw3+Ba4PvTjPYxscALeLN2kBgs4YYz8Bg-R7g@mail.gmail.com>
From: Ondra Medek <xmedeko@gmail.com>
Date: Tue, 14 May 2024 08:29:45 +0200
Message-ID: <CAJsoDaHu1xgfwXHqOGgctQoi5Qb5D1aESeMvaVHaQV0zjyzRRg@mail.gmail.com>
Subject: Re: Checkout to different directory at certain commit without
 changing index
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

your trick with different index file works with git checkout, too, e.g.

GIT_INDEX_FILE="$destdir"/.git git --work-tree="$destdir" checkout -f
-q "$commit" -- ./
rm -f "$destdir"/.git

Sincerely
Ondra

On Mon, 13 May 2024 at 19:23, Ondra Medek <xmedeko@gmail.com> wrote:
>
> Hi Phillip,
>
> besides dependency on tar, I do not want to use git-archive because
> it's influenced by export-ignore and export-subst attributes, too (as
> I have mentioned).
>
> Thanks for git read-tree, seems it's exactly what I need. Just git
> read-tree has complained that -u switch needs -m or --reset switches.
> And I have simplified it to
>
> git --work-tree="$destdir" read-tree --index-output="$destdir".git -u
> --reset "$commit"
> rm -f "$destdir"/.git
>
> May I post this solution to the SO thread I have mentioned?
>
> Thanks very much
>
> Ondra
>
> On Mon, 13 May 2024 at 17:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > Hi Ondra
> >
> > On 13/05/2024 08:26, Ondra Medek wrote:
> > > Hello,
> > > I need a simple script for unskilled users to do a fast checkout (LFS
> > > friendly) of the current local Git clone at a certain commit to a
> > > different directory I.e. something like "copy at a point in history".
> >
> > I think using
> >
> >      git archive "$commit" --format=tar |
> >         { cd "$output_directory" && tar -xf -; }
> >
> > is probably the simplest solution. If you don't want to rely on tar then
> > something like
> >
> >      GIT_DIR="$(git rev-parse --path-format=absolute --git-dir)" &&
> >      GIT_COMMON_DIR="$(git rev-parse --path-format=absolute
> > --git-common-dir)" || exit
> >      GIT_INDEX_FILE="$GIT_DIR/tmp-index-$$"
> >      export GIT_DIR GIT_COMMON_DIR GIT_INDEX_FILE
> >      unset GIT_WORK_TREE
> >      mkdir "$output_directory" && cd "$output_directory" &&
> >      git read-tree -u "$commit"
> >      status=$?
> >      rm "$GIT_INDEX_FILE"
> >      exit $status
> >
> > Which uses a temporary index file should work (note I haven't tested
> > it). You may want to add "--recurse-submodules" and/or
> > "--no-sparse-checkout" to the "git read-tree" commandline.
> >
> > Best Wishes
> >
> > Phillip
> >
> > > IMO all possible solutions are summarized in this thread
> > > https://stackoverflow.com/questions/160608/do-a-git-export-like-svn-export
> > > I describe some of them with my remarks:
> > >
> > > - git checkout-index : works with HEAD only.
> > > - git archive: influenced by export-ignore and export-subst
> > > attributes, so may not produce exact copy of sources. (And needs tar).
> > > - git worktree add -d : needs cleanup: git prune or git remove.
> > > - git clone: Unfortunately, -b param cannot work with commit hash and
> > > does not respect local worktree settings (e.g. autocrlf). So, a
> > > solution may be a bit complicated: git clone -s -n . dest/path ; cp
> > > .git/config dest/path/.git ; cd dest/path ; git co -q <commit-ish> ;
> > > rm -rf .git
> > > - git checkout: Unfortunately, modifies Git index, so some action to
> > > revert index is necessary after: git --work-tree=/path/to/checkout/
> > > checkout -f -q <tree-ish> -- ./
> > >
> > > For me, the best solution is with git clone, because it does not
> > > modify Git index nor any source working tree settings, so no cleanup
> > > is necessary. But it's a bit complicated, though. It seems to me that
> > > "git checkout" could do this better and simpler if it would have some
> > > param to not modify the Git index. Is it possible to enhance git
> > > checkout? Or is there any other simple solution not mentioned in the
> > > SO thread?
> > >
> > > Thank you
> > > Ondra Medek
> > >
