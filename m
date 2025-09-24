Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AB281358
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737606; cv=none; b=VS0x1kALb2Lr+XwimmJMlAOpzOfhlVD8cRIuZ5h1Wr84aGJqp7/OMBd9BtUfFr9/2lnhxRq321JRUgjHOwg2QtxIusWzoUiCTJenvVOb827crhe2PxY53THKLuGXwSaMzUz24hYOwroQaeMahYDNFMkYajUMS+pDGUGA/MWX7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737606; c=relaxed/simple;
	bh=+Lt3SM5+6afskGTZhOSGWBBwvMc9YgF2xJJ53Q2NYao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbhSUP0M7vwpVJv43S+lNr/sLtiOwQGqZILVR33Neg52u909/q5vvUlYGlr+UylAInHThwL6cmB3E0EC9lAV7QOct22cFpVO2MvIEvrtPHZV7J/v+d0EL2mJXG8NXnZfFmUN6r32J3KKyWTJTQvhmrWbYMKJPILBUfG75ZkByxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZQwizXi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZQwizXi"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso112959a12.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758737603; x=1759342403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eotBgdU0OeBg9lyL8pbGSxDAEsw+MYeV/zXccKdTXd0=;
        b=XZQwizXilZERxMDYilkRtG4JbY/DoYjviLxyq/eEC3r+F4E8dfZKZmuCygcZZPEIpg
         3szRut/kxRWHaCJkiNiXweKd5LoikgQPQJiiDmKZQvLYzsK+lyVHcIjoVnCjP/inttUK
         3L1ADCNvwnKrOpcSl8tvfrdtA5mqhN2idr5FubThiFdXu09spKYlchgTTiO7rMFfSMGe
         SdRY4At81FIcwic/VL9uYfJ84KwmQeKJAOHj8mLaO7mCwQEFpmOt7iTbvTfwti/DhvxH
         lwli0h7OnGM6wsPYAwKPxIoSDM5l1VnoHB9ZkW3jIOWEmdpA9u+R7T+7hLRgTs6/t/lG
         WeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737603; x=1759342403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eotBgdU0OeBg9lyL8pbGSxDAEsw+MYeV/zXccKdTXd0=;
        b=WYQ3Fj40PwKmg+3mc0E2nZlZO1YiM1J27lG1DRHf9Xa0CcmnO1mDFiU1MrqlhlCJMs
         p+PYKvh/gYixqHgBFSsjixXBUlAqUtUfShRoWLDQ7UzsKW9Ij1K7OE/NAbz33B4yW45E
         OS0Ebnb0mHTcrzIGSM2tIBtgK+FwizgCXU83mQ8C5aDjCXhh0FFBfHoS7Yc/L+Xyd1cx
         u7frLbFMY/JwmzszzHgxiG/4ZI3QyHgIuJM4vkyrGGfAbITshBGRPpcLmwJJJySsIhb+
         LQMf4JDMtrQrLB9KMeA5MeMpIdvB+cskhdb3QD//uqPqLHcRvYjUfzmfdqrzA518Sapl
         a1rA==
X-Gm-Message-State: AOJu0YzPdBoCryDgaWyJs97WXu6xRa4Op68cHhcZ/fCU9p8o27OyBNL+
	JzrvjS+CIl9uQZRtRjQdAhkTu70lRWw5eXcx07dQQED4HBGULUYDFjiYc4fyDzy4CJPhoxL5Noq
	tXkibCmdgfNEere1P2+rNGnQDs2ZHyYNEKAQgzz8=
X-Gm-Gg: ASbGncuZGS9okkbA2nLgV3X2/DVHLZCcx9fWVtqMVuLt4rRhWke6YVuHDpCgwyRapgC
	lkULJeQm+poWZmLHVkHFa9f4MCL48r63Tk1lFjXRsvqSEXODu79JZAoDl4iMWNxGspJ7Nfz302D
	5cZHD9QUqWuGad8VIiK5Ufk+ACOEVS1OZOu9IZYBO+jZ7ZmMSG+RUPjNmXh5oSMcYWwn8A3mZCI
	cDeCLKLfdriDbTFjifdkJfZ5vgvuAmlWg8GefLnC5pzTOVHOvI2
X-Google-Smtp-Source: AGHT+IGZFSKLX/qcm/9XD6dI9YuErC7Z06P7qJvkpHaVbtTVWXVZJOWDkgunjgFOjut8i5jOVBoQ9IOOsoeg1xSKZWM=
X-Received: by 2002:a05:6402:454c:b0:615:6a10:f048 with SMTP id
 4fb4d7f45d1cf-6349fa923dfmr276884a12.33.1758737602481; Wed, 24 Sep 2025
 11:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJA-u1rnzef53+eW_mbwd_40q+-vt747Q_dP3PG_HKt1yXcmXQ@mail.gmail.com>
In-Reply-To: <CAJA-u1rnzef53+eW_mbwd_40q+-vt747Q_dP3PG_HKt1yXcmXQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 24 Sep 2025 14:13:11 -0400
X-Gm-Features: AS18NWC6yMV4F7ACbr5fDxHBd5I-LjY0ZbzPWt5lZ2HsjLR8QMhTzxHQxpuhGbE
Message-ID: <CALnO6CCfwdKcqxFSvX68WDvzceYeo0ougz4337ejChbPB9aGEg@mail.gmail.com>
Subject: Re: Bug report: Untracked file lost from git stash
To: Hosam Aly <hosamaly6@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:33=E2=80=AFAM Hosam Aly <hosamaly6@gmail.com> wr=
ote:
>
> Hello,
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> I have a file in one directory. I made many changes _and_ moved it to
> a different directory, but that caused git to lose track of the
> renaming due to a low similarity index. As such, I decided to do it in
> two steps and used `git stash -u` to shelve my changes. Following
> that, I moved the file and then tried to unstash it, assuming that the
> worst that could happen would be a conflict that I would easily solve.

I touch on a few helpful pieces below, but one thing I can't puzzle
out: what is the "echo code3 >d2/f" representing below in the story
above? (I don't think it ends up mattering for the case of the stash
conflict though.)

> git init .
> mkdir d1 d2
> echo code1 > d1/f
> git add d1/f
> git commit -m 'Add file in d1'
> mv d1/f d2/
> echo code2 > d2/f
> git stash -u
> git stash show --stat

At this stage, "git stash show" is not very helpful:

show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
           Show the changes recorded in the stash entry as a diff between t=
he
           stashed contents and the commit back when the stash entry was fi=
rst
           created.

(At least, not without "-u"):

    # git stash show -u
     d1/f | 1 -
     d2/f | 1 +
     2 files changed, 1 insertion(+), 1 deletion(-)

On the other hand, we can do "git log --oneline --graph stash" to see
that stash^3 contains a new root commit with the untracked files.

So

> git mv d1/f d2/
> git commit -m 'Move file to d2'
> echo code3 > d2/f
> git stash pop

here, "git restore -SW -s stash^3 d2/f" might be what you want?

For the record, the error message I get is

CONFLICT (rename/delete): d1/f renamed to d2/f in Updated upstream,
but deleted in Stashed changes.
d2/f already exists, no checkout
error: could not restore untracked files from stash
On branch main
Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add/rm <file>..." as appropriate to mark resolution)
deleted by them: d2/f

no changes added to commit (use "git add" and/or "git commit -a")
Your stash currently has 1 entry
The stash entry is kept in case you need it again.

And then

    # g ls-files --stage
    100644 47f43aef120505c79eafd2b1bd55e4cb78977f98 1 d2/f
    100644 47f43aef120505c79eafd2b1bd55e4cb78977f98 2 d2/f

That is the code1 blob. The working tree still has code3. It _would_
be nice to perhaps see a conflict with the code2 blob?

>
> What did you expect to happen? (Expected behavior)
> * `git stash show` should show a file that was deleted and another
> that is untracked and has different contents.
> * `git stash pop` should apply the changes, potentially with the
> conflict markers.
>
> What happened instead? (Actual behavior)
> * The stash shows the deleted file but not the untracked one!
>   ```
>    d1/f | 1 -
>    1 file changed, 1 deletion(-)
>   ```
> * `git stash pop` says it's unable to restore the untracked file.
>
> What's different between what you expected and what actually happened?
> * The stash entry doesn't show the untracked file. It should show it
> (or refuse to create the stash).
> * Trying `git checkout 'stash@{0}' -- d2/f` says it doesn't know about th=
e file.

The merge result in stash^{tree} doesn't have the untracked file, but
it does exist in stash^3 as explained above.

Yet another way to recover is "git stash branch <branch>", which
should never fail from a clean working tree.

--=20
D. Ben Knoble
