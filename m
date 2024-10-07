Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F818BBB7
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291965; cv=none; b=Y0HRm01zUIQPS42xVXYBbAuiaK+/06zWLk5dwyIV8r5W1yMxKjxcwXaldjxB/5OOcmJNGJ6feO4z0HclyO+yte99lSbIXPT8Jnuru8a9Aavm98Pta9oQjMy7gZKF0WNv3AZYut17VD5UkcsJ9h0+xuE468IxsnXpdXPywncNQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291965; c=relaxed/simple;
	bh=Zk/X/PkyWLlmPJds0Xz/B85E3DLbZMh48KPZl8ehQxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwfDwjmx35PjcpnBylteIMwrY+Tu1M8Lr1+ElVNJn5hQHla+CjZIMtJfpFCWuYFeXAhYtJVffm+zui1jkFJt3B1mqH5gyzwLl5uNtjHYYLi7g4KUQdXJRTp+HjBfMi1ghrcWtCrNZbiJ3EJNtQE3p3PJXFdyR7xYtRWtYEGOPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZDa9273; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZDa9273"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84e884e9a43so1056651241.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291963; x=1728896763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYrurIxPyTRw/21T8jDMwCzksliRfvKUS17CagK5GPg=;
        b=kZDa9273oUdH+4fhzkT+PVf254UO4CmbULBqjJRfj0LHLGKJeZU/35Ok1T1Bg9+Icm
         2eHjtPUerAGo4zk52QH9Nv2FeLeiy0iHVY1yUkEoVxINc9az+FWVyiZACWMBqInn+mav
         qAVtA9Nw0lpwO2X5E92AgnbNzsSTcflHrVd6ac7vxKmY1NR0L0c2yKqF4nsgIoutsejo
         3SJWDuk/sfxymLf47eVmAqaXliUUBpecT+0F/XBCZLCOEd74IBSUp/ayqIEnBpE0GR+V
         xL8lPcu81lmxDY9zKLsUJhj1z9blCaSX5I5Isn6CQfhSgWb66OjFpupEDmTtIo8D6Wq4
         mlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291963; x=1728896763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYrurIxPyTRw/21T8jDMwCzksliRfvKUS17CagK5GPg=;
        b=Vjn64v8CBhHiD1f3/J1hDgtotkZ+qB89E/mYxRxfQqH66OpjKnA+rpa5WNkIIrvoqk
         LtRIaUuNFYYASKS380kc0lrtpNPZU5NftqKmDTdD20ePC7iXeZUQ+cE6m5TSWVzqOKOn
         0vywGKkr9IzGU37iNTZFUxhBr3vaNR1M0GeP0dTKCsKSW5pFtKa+DNacNq2xa9gI/vM3
         nxGOcVZvUgFNIfEK7BA6Q1UYvuOlcnwxfgiu6zPDo+JFpgJvf1ZN/zy/y8jMbWXIrEA6
         t2Tc8veyQ4GoAvenKGiHHT5wy6m2cSjnHwzP24G/CtlMSyaze+jlmP7ObN9guz+kUYPI
         emPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJEY7lkwpRjHrq8hKgV29M+QBD4Vyla1X9XI4DXJVIhizqgathP4DLQwVKWHqR2kBrOEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLOEaLSyxEd0DN0uVobh5R1Ko2CjPd2uxgqOpz2ZVSjJ5tuFP
	XhU8lwsF2c9Sumj90jyLnHnocjlieUdwK/v4/6odmVx2xKbdnJbFlsjdBHUKiPKvmDeu/x6hCoM
	7pjAEhWaJOoNUa2DAfO1bwinrAiQ=
X-Google-Smtp-Source: AGHT+IEwIl35xAAfYeGHj8mgVe4g103gYzmr+cl/5ZLNQfjJnuymcALlB1YPx8On+18SnUEyYzxgyKoJBm/99yCdIqo=
X-Received: by 2002:a05:6102:943:b0:49c:5f:e816 with SMTP id
 ada2fe7eead31-4a4058e029cmr8017410137.18.1728291962795; Mon, 07 Oct 2024
 02:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <c9a0cca179bfad129017c7f1085ff87201afb417.1728230769.git.gitgitgadget@gmail.com>
 <b4a725aa-eb90-4640-8e45-b24b9f89eab6@gmail.com>
In-Reply-To: <b4a725aa-eb90-4640-8e45-b24b9f89eab6@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 09:05:50 +0000
Message-ID: <CAPSxiM-b3aNRWM7+aYX83NUnYdVvJ3O1Hm30KhkXCMccmTF0Xw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t3404: avoid losing exit status with focus on `git
 show` and `git cat-files`
To: phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Eric Sunshine <sunshine@sunshineco.com>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:52=E2=80=AFAM <phillip.wood123@gmail.com> wrote:
>
> Hi Usman
>
> On 06/10/2024 17:06, Usman Akinyemi via GitGitGadget wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > The exit code of the preceding command in a pipe is disregarded. So
> > if that preceding command is a Git command that fails, the test would
> > not fail. Instead, by saving the output of that Git command to a file,
> > and removing the pipe, we make sure the test will fail if that Git
> > command fails.
>
> This is a good description of the reason for making this change.
>
> > This particular patch focuses on some of the instances
> > which include `git show` and `git cat-files`.
>
> This patch seems to fix all of the instances of "git show" rather than
> some. It also fixes a few instances of "git cat-file" (note there is no
> trailing "s" in the command name). It is not immediately clear to me why
> those instances of "git cat-file" were selected for conversion but not
> others. However they are a worthwhile improvement and converting them
> all in this patch would make it bit too big to comfortably review so I'm
> happy with the changes as they are.
>
> The patch itself looks good.
>
> Thanks
>
> Phillip
Since, I am updating a patch. I will update this commit message also.
Thank you for the review.
>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >   t/t3404-rebase-interactive.sh | 71 +++++++++++++++++++++++-----------=
-
> >   1 file changed, 48 insertions(+), 23 deletions(-)
> >
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> > index f171af3061d..96a65783c47 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -319,7 +319,8 @@ test_expect_success 'retain authorship' '
> >       GIT_AUTHOR_NAME=3D"Twerp Snog" git commit -m "different author" &=
&
> >       git tag twerp &&
> >       git rebase -i --onto primary HEAD^ &&
> > -     git show HEAD | grep "^Author: Twerp Snog"
> > +     git show HEAD >actual &&
> > +     grep "^Author: Twerp Snog" actual
> >   '
> >
> >   test_expect_success 'retain authorship w/ conflicts' '
> > @@ -360,7 +361,8 @@ test_expect_success 'squash' '
> >   '
> >
> >   test_expect_success 'retain authorship when squashing' '
> > -     git show HEAD | grep "^Author: Twerp Snog"
> > +     git show HEAD >actual &&
> > +     grep "^Author: Twerp Snog" actual
> >   '
> >
> >   test_expect_success '--continue tries to commit' '
> > @@ -374,7 +376,8 @@ test_expect_success '--continue tries to commit' '
> >               FAKE_COMMIT_MESSAGE=3D"chouette!" git rebase --continue
> >       ) &&
> >       test_cmp_rev HEAD^ new-branch1 &&
> > -     git show HEAD | grep chouette
> > +     git show HEAD >actual &&
> > +     grep chouette actual
> >   '
> >
> >   test_expect_success 'verbose flag is heeded, even after --continue' '
> > @@ -397,7 +400,9 @@ test_expect_success 'multi-squash only fires up edi=
tor once' '
> >                       git rebase -i $base
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> > -     test 1 =3D $(git show | grep ONCE | wc -l)
> > +     git show >output &&
> > +     count=3D$(grep ONCE output | wc -l) &&
> > +     test 1 =3D $count
> >   '
> >
> >   test_expect_success 'multi-fixup does not fire up editor' '
> > @@ -410,7 +415,9 @@ test_expect_success 'multi-fixup does not fire up e=
ditor' '
> >                       git rebase -i $base
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> > -     test 0 =3D $(git show | grep NEVER | wc -l) &&
> > +     git show >output &&
> > +     count=3D$(grep NEVER output | wc -l) &&
> > +     test 0 =3D $count &&
> >       git checkout @{-1} &&
> >       git branch -D multi-fixup
> >   '
> > @@ -428,7 +435,9 @@ test_expect_success 'commit message used after conf=
lict' '
> >                       git rebase --continue
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> > -     test 1 =3D $(git show | grep ONCE | wc -l) &&
> > +     git show >output &&
> > +     count=3D$(grep ONCE output | wc -l) &&
> > +     test 1 =3D $count &&
> >       git checkout @{-1} &&
> >       git branch -D conflict-fixup
> >   '
> > @@ -446,7 +455,9 @@ test_expect_success 'commit message retained after =
conflict' '
> >                       git rebase --continue
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> > -     test 2 =3D $(git show | grep TWICE | wc -l) &&
> > +     git show >output &&
> > +     count=3D$(grep TWICE output | wc -l) &&
> > +     test 2 =3D $count &&
> >       git checkout @{-1} &&
> >       git branch -D conflict-squash
> >   '
> > @@ -470,10 +481,10 @@ test_expect_success 'squash and fixup generate co=
rrect log messages' '
> >       ) &&
> >       git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup =
&&
> >       test_cmp expect-squash-fixup actual-squash-fixup &&
> > -     git cat-file commit HEAD@{2} |
> > -             grep "^# This is a combination of 3 commits\."  &&
> > -     git cat-file commit HEAD@{3} |
> > -             grep "^# This is a combination of 2 commits\."  &&
> > +     git cat-file commit HEAD@{2} >actual &&
> > +     grep "^# This is a combination of 3 commits\." actual &&
> > +     git cat-file commit HEAD@{3} >actual &&
> > +     grep "^# This is a combination of 2 commits\." actual  &&
> >       git checkout @{-1} &&
> >       git branch -D squash-fixup
> >   '
> > @@ -489,7 +500,9 @@ test_expect_success 'squash ignores comments' '
> >                       git rebase -i $base
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> > -     test 1 =3D $(git show | grep ONCE | wc -l) &&
> > +     git show >output &&
> > +     count=3D$(grep ONCE output | wc -l) &&
> > +     test 1 =3D $count &&
> >       git checkout @{-1} &&
> >       git branch -D skip-comments
> >   '
> > @@ -505,7 +518,9 @@ test_expect_success 'squash ignores blank lines' '
> >                       git rebase -i $base
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> > -     test 1 =3D $(git show | grep ONCE | wc -l) &&
> > +     git show >output &&
> > +     count=3D$(grep ONCE output | wc -l) &&
> > +     test 1 =3D $count &&
> >       git checkout @{-1} &&
> >       git branch -D skip-blank-lines
> >   '
> > @@ -572,7 +587,8 @@ test_expect_success '--continue tries to commit, ev=
en for "edit"' '
> >               FAKE_COMMIT_MESSAGE=3D"chouette!" git rebase --continue
> >       ) &&
> >       test edited =3D $(git show HEAD:file7) &&
> > -     git show HEAD | grep chouette &&
> > +     git show HEAD >actual &&
> > +     grep chouette actual &&
> >       test $parent =3D $(git rev-parse HEAD^)
> >   '
> >
> > @@ -757,19 +773,23 @@ test_expect_success 'reword' '
> >               set_fake_editor &&
> >               FAKE_LINES=3D"1 2 3 reword 4" FAKE_COMMIT_MESSAGE=3D"E ch=
anged" \
> >                       git rebase -i A &&
> > -             git show HEAD | grep "E changed" &&
> > +             git show HEAD >actual &&
> > +             grep "E changed" actual &&
> >               test $(git rev-parse primary) !=3D $(git rev-parse HEAD) =
&&
> >               test_cmp_rev primary^ HEAD^ &&
> >               FAKE_LINES=3D"1 2 reword 3 4" FAKE_COMMIT_MESSAGE=3D"D ch=
anged" \
> >                       git rebase -i A &&
> > -             git show HEAD^ | grep "D changed" &&
> > +             git show HEAD^ >actual &&
> > +             grep "D changed" actual &&
> >               FAKE_LINES=3D"reword 1 2 3 4" FAKE_COMMIT_MESSAGE=3D"B ch=
anged" \
> >                       git rebase -i A &&
> > -             git show HEAD~3 | grep "B changed" &&
> > +             git show HEAD~3 >actual &&
> > +             grep "B changed" actual &&
> >               FAKE_LINES=3D"1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE=3D"C =
changed" \
> >                       git rebase -i A
> >       ) &&
> > -     git show HEAD~2 | grep "C changed"
> > +     git show HEAD~2 >actual &&
> > +     grep "C changed" actual
> >   '
> >
> >   test_expect_success 'no uncommitted changes when rewording and the to=
do list is reloaded' '
> > @@ -1003,8 +1023,10 @@ test_expect_success 'rebase -i --root retain roo=
t commit author and message' '
> >               set_fake_editor &&
> >               FAKE_LINES=3D"2" git rebase -i --root
> >       ) &&
> > -     git cat-file commit HEAD | grep -q "^author Twerp Snog" &&
> > -     git cat-file commit HEAD | grep -q "^different author$"
> > +     git cat-file commit HEAD >output &&
> > +     grep -q "^author Twerp Snog" output &&
> > +     git cat-file commit HEAD >actual &&
> > +     grep -q "^different author$" actual
> >   '
> >
> >   test_expect_success 'rebase -i --root temporary sentinel commit' '
> > @@ -1013,7 +1035,8 @@ test_expect_success 'rebase -i --root temporary s=
entinel commit' '
> >               set_fake_editor &&
> >               test_must_fail env FAKE_LINES=3D"2" git rebase -i --root
> >       ) &&
> > -     git cat-file commit HEAD | grep "^tree $EMPTY_TREE" &&
> > +     git cat-file commit HEAD >actual &&
> > +     grep "^tree $EMPTY_TREE" actual &&
> >       git rebase --abort
> >   '
> >
> > @@ -1036,7 +1059,8 @@ test_expect_success 'rebase -i --root reword orig=
inal root commit' '
> >               FAKE_LINES=3D"reword 1 2" FAKE_COMMIT_MESSAGE=3D"A change=
d" \
> >                       git rebase -i --root
> >       ) &&
> > -     git show HEAD^ | grep "A changed" &&
> > +     git show HEAD^ >actual &&
> > +     grep "A changed" actual &&
> >       test -z "$(git show -s --format=3D%p HEAD^)"
> >   '
> >
> > @@ -1048,7 +1072,8 @@ test_expect_success 'rebase -i --root reword new =
root commit' '
> >               FAKE_LINES=3D"reword 3 1" FAKE_COMMIT_MESSAGE=3D"C change=
d" \
> >               git rebase -i --root
> >       ) &&
> > -     git show HEAD^ | grep "C changed" &&
> > +     git show HEAD^ >actual &&
> > +     grep "C changed" actual &&
> >       test -z "$(git show -s --format=3D%p HEAD^)"
> >   '
> >
>
