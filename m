Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C321B192
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831800; cv=none; b=JJmve/Z9OXuw5VBoqOWPew5NbUW+dYYa8vfTv+IocQS8/qbptc6ZsCEu+ue3BNwy40CemTkNsC+cRx2jy7866ve3lTyoSQyTIdYibrYIbgdsdQYRApkhHrysEziVt5CS1DDA6Ji+19xIx+n25KC4ZUZ97MEfEAMKoPAsDhPIuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831800; c=relaxed/simple;
	bh=qZgW6C+vsZWfcQVRtNGna+7vIyO6ATk2rrZGj3IjNWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXR/uHMI2B4e+TcsCO30tpN2G6x0HCbijFEv1NJOtRhVY+4cX7Mr5/Brw7SDhudTBpO2+tnEok1zN1Yw6R5w27rlrZ0A13i3TRiKrzkxJRy+Nq5zA9k4IZWjo6+UO3OMEBBYZMQJoodaVGtjpipYfJsj0PfJ0H5O1kt09YErcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFfypJQO; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFfypJQO"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60110772so12771717b3.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758831797; x=1759436597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT3yOC62yyfm1DoTt2Bx7wfeiiYxai9h/zvNGNBzQtE=;
        b=IFfypJQODb22oJrGFRqFkxBRKpZFYNpepIqomxqHgzaKU6XrFFVbx6u7R/kZPKLr96
         nNDIopwSvamHk9XJ2HUOTCq2z+btXksoDq4e6dTVR+Xb0MEqU3eQcXxUIWIElcl80iRK
         6fZr6+Q4/1xGwJx6gIn30PHk2+BcXEj/KOHQ7qJTDNS5wkrFLxeurfp+XtD3nYZqejrf
         guON2oKxuAzKG4LbBC1T8UPyxv7kNn6NUPWHM0MZ3Qdl8smb1KuJmDZq7QXwbV1BuQLv
         MJK7nDi7hEkZXO9WwCnacmDSZKMLJjnFSwB9t9p0GNxRiYn1V9XIEB8NdfQzgU98AygY
         JCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758831797; x=1759436597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zT3yOC62yyfm1DoTt2Bx7wfeiiYxai9h/zvNGNBzQtE=;
        b=s9oWSQuZB+U8M4aJ6p/RwV6dibRaePXuHoP4gqst24IAzO2c0/WWU5AYJAS7kCzFHZ
         RkPMAgipl9VRS0Ev7eRCw1zps/BUahC3lqDYiMNBHLE0lDyYRak7eBcFYdrTTS+/4MJD
         xn69YPPJ2NDVXaAEvtaOi2eDfSojKbuUspwcFFhV7Rr2DMwkO5Hzt/yxod47KU2y6oiv
         YCKCjo5wKXAiIdtkOR5pSMUqwzvGjpw0EE7YuC4m552xtgkUlOEcxwTfiaTO2XpMvn7z
         hpUkKeCkUGXyTNHj9ECWKrNi+nQyMIsb2GBz1MBQr0ItYWIW9w1rJ1RxXGWxhI3xLFCt
         mS9Q==
X-Gm-Message-State: AOJu0YwmhT48WZzNcEduN9We7CZzpgrwV8jpezydr2YzzhBu0I9S4Nf6
	wPN4IVXTaO6qXD4V62mIei3Is/uSg7VHOn+pzKRbVh0RJQORt+ZoG0K4z1XLVneCJjFwA8AeIRA
	mdQktIOJlXANdgagBx51rr0hV4a/bRZU=
X-Gm-Gg: ASbGncvw2/ohCRofDK4qr6kbUYOQrvE/USKzxg1IBjFNMQxHLJrQOGfmc2MlRMm+r5W
	00+r4pxVr9B6GOYnbJuCYhQvrdayWYSq0q1R4ZUm96hluFjRgv18/aMbVzQLu0c0p9RaZxxoP+U
	OLqapVf3Ecsj5DpLZ2qp+Kd/K8fM9n3hQ2XNdeG/9NP+4cRJp7J4QK4GkatdRv1f1XFey/8YyBe
	FUxADzx
X-Google-Smtp-Source: AGHT+IGlODQBgYyXIRFkm5N7ONJFipsj6XHhcxT64R3r0ZnMKNfPwR+t6FS6KyWc4+BTdAY9L1v+QI8KAG/aptAhR0U=
X-Received: by 2002:a05:690e:2547:b0:635:4ed0:5764 with SMTP id
 956f58d0204a3-6361a88f844mr2953502d50.50.1758831797100; Thu, 25 Sep 2025
 13:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJA-u1rnzef53+eW_mbwd_40q+-vt747Q_dP3PG_HKt1yXcmXQ@mail.gmail.com>
 <CALnO6CCfwdKcqxFSvX68WDvzceYeo0ougz4337ejChbPB9aGEg@mail.gmail.com>
In-Reply-To: <CALnO6CCfwdKcqxFSvX68WDvzceYeo0ougz4337ejChbPB9aGEg@mail.gmail.com>
From: Hosam Aly <hosamaly6@gmail.com>
Date: Thu, 25 Sep 2025 23:22:40 +0300
X-Gm-Features: AS18NWDJM9kb1r_y0AZedVkjyor43uUqu-TR87zo5BnTmP6o5ZoN6491GsUOnRg
Message-ID: <CAJA-u1oORK9b2=mg-s_n6-Jn3VBhe6sqrWg8VN0-MdEOjZGcwg@mail.gmail.com>
Subject: Re: Bug report: Untracked file lost from git stash
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One learns everyday, and today is definitely a good one. Thanks a lot!
It was a red herring but I do have a feature suggestion at the end of
this message.

I had found `git stash show` easy to use that I never thought about
reading its docs. I apologise for the false alarm.

I was surprised to learn that `git stash` has an option to show
untracked files. I find this unintuitive because it's the opposite of
the default behaviour of `git status`! I'll configure
`stash.showIncludeUntracked` to get them to behave similarly. Thanks
very much for pointing it out.

I learned today how `git stash branch` can be a lifesaver. Much appreciated=
!

As for "echo code3 >d2/f", I had written it in an incorrect order. It
should've been after the move and before the commit. The actual
scenario was that I was working with a Java file that I moved to a
different package, which involved changing the package declaration at
the top of the file.

Feature request: I wish that the maintainers would consider changing
the default value of `stash.showIncludeUntracked` to true. If
something is stashed and the user asks about it, they should be told
about it without hiding anything. Consider the case where all the
stashed files are untracked; `git stash show` currently shows nothing,
which is very confusing.


Thank you very much,
Hosam Aly

On Wed, 24 Sept 2025 at 21:13, D. Ben Knoble <ben.knoble@gmail.com> wrote:
>
> On Wed, Sep 24, 2025 at 11:33=E2=80=AFAM Hosam Aly <hosamaly6@gmail.com> =
wrote:
> >
> > Hello,
> >
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > I have a file in one directory. I made many changes _and_ moved it to
> > a different directory, but that caused git to lose track of the
> > renaming due to a low similarity index. As such, I decided to do it in
> > two steps and used `git stash -u` to shelve my changes. Following
> > that, I moved the file and then tried to unstash it, assuming that the
> > worst that could happen would be a conflict that I would easily solve.
>
> I touch on a few helpful pieces below, but one thing I can't puzzle
> out: what is the "echo code3 >d2/f" representing below in the story
> above? (I don't think it ends up mattering for the case of the stash
> conflict though.)
>
> > git init .
> > mkdir d1 d2
> > echo code1 > d1/f
> > git add d1/f
> > git commit -m 'Add file in d1'
> > mv d1/f d2/
> > echo code2 > d2/f
> > git stash -u
> > git stash show --stat
>
> At this stage, "git stash show" is not very helpful:
>
> show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
>            Show the changes recorded in the stash entry as a diff between=
 the
>            stashed contents and the commit back when the stash entry was =
first
>            created.
>
> (At least, not without "-u"):
>
>     # git stash show -u
>      d1/f | 1 -
>      d2/f | 1 +
>      2 files changed, 1 insertion(+), 1 deletion(-)
>
> On the other hand, we can do "git log --oneline --graph stash" to see
> that stash^3 contains a new root commit with the untracked files.
>
> So
>
> > git mv d1/f d2/
> > git commit -m 'Move file to d2'
> > echo code3 > d2/f
> > git stash pop
>
> here, "git restore -SW -s stash^3 d2/f" might be what you want?
>
> For the record, the error message I get is
>
> CONFLICT (rename/delete): d1/f renamed to d2/f in Updated upstream,
> but deleted in Stashed changes.
> d2/f already exists, no checkout
> error: could not restore untracked files from stash
> On branch main
> Unmerged paths:
>   (use "git restore --staged <file>..." to unstage)
>   (use "git add/rm <file>..." as appropriate to mark resolution)
> deleted by them: d2/f
>
> no changes added to commit (use "git add" and/or "git commit -a")
> Your stash currently has 1 entry
> The stash entry is kept in case you need it again.
>
> And then
>
>     # g ls-files --stage
>     100644 47f43aef120505c79eafd2b1bd55e4cb78977f98 1 d2/f
>     100644 47f43aef120505c79eafd2b1bd55e4cb78977f98 2 d2/f
>
> That is the code1 blob. The working tree still has code3. It _would_
> be nice to perhaps see a conflict with the code2 blob?
>
> >
> > What did you expect to happen? (Expected behavior)
> > * `git stash show` should show a file that was deleted and another
> > that is untracked and has different contents.
> > * `git stash pop` should apply the changes, potentially with the
> > conflict markers.
> >
> > What happened instead? (Actual behavior)
> > * The stash shows the deleted file but not the untracked one!
> >   ```
> >    d1/f | 1 -
> >    1 file changed, 1 deletion(-)
> >   ```
> > * `git stash pop` says it's unable to restore the untracked file.
> >
> > What's different between what you expected and what actually happened?
> > * The stash entry doesn't show the untracked file. It should show it
> > (or refuse to create the stash).
> > * Trying `git checkout 'stash@{0}' -- d2/f` says it doesn't know about =
the file.
>
> The merge result in stash^{tree} doesn't have the untracked file, but
> it does exist in stash^3 as explained above.
>
> Yet another way to recover is "git stash branch <branch>", which
> should never fail from a clean working tree.
>
> --
> D. Ben Knoble
