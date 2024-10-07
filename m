Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5161DA612
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315172; cv=none; b=YqITBX8vue9gv0OZextqJPLHSqRYcdG0qyvTRRbZ4+9w2Q8j8WK4tHJfZeNI2SP0neq0/fJcuGugF7Sf22vyU43C4zchsG7yacjOvQWZdUIyMt0MdO1KY9vV1Am5w7BOeUSwq3V0wbNVjugOJLKsKsCF4Sa6ihYEfoBiZ7wHC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315172; c=relaxed/simple;
	bh=Ibfw8ms/tASqECT5W+s8MNxIYlV/3isE8IXhx5nGrNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNmljrBVM8xXrWZ8nhfOhtAMXJ9Wbbs9hQlAvugnrPHfsFYqVol5joUK+VUP1hllpkaRUkRRTW2NRjFtT+9xKNtQW3F6Jt4Hz1SthL/L9L6NKCu19OEoRYC4dQHgp7qFJfGof8kejsziG0brwdG4/oxGyZmRVecSNfWHVuFEw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDf5IumR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDf5IumR"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-287759c0fbdso2544664fac.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728315170; x=1728919970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z41d1DMuFirn1STGwL3rfYabTxQ/kHBP56iCllOUs+s=;
        b=aDf5IumRzwtdhuQSMOznMjVf9vOt5gaCWeMINutUNG2/51vEvlf251wN7YKDv8frt9
         0iFFSoeqdDOcaFY9JoqoGOhDDks244/wTuh18+fOctEreBUcTkBIbFE1VnZmtO3O8buk
         kOkLAx7+YuwIIJCL6WztnKB7+g2uXakODgPlM2GdW07deroJXUdVJcaNDVnGrKT0GlV0
         w7+PWKVRDGoo+v42zgbyJo7TVVKBC7M/6TFQK/KSJuUurql7zDu3OBYiLJxdWpcGwibt
         LKJo/uhD9TgdX6B+kOri6uNdukfb5YIPIrv+nJzoT76tlmFbGSnA0OXVLJ3tBZ91E7GT
         K8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315170; x=1728919970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z41d1DMuFirn1STGwL3rfYabTxQ/kHBP56iCllOUs+s=;
        b=IzNKEcQm//k+77aLpkpG5Q7jgyAWhvIfZvsnqK2Pjuzg21VHTWoJnejNon7vLzlPyx
         PQeaySv2o705xL9WqRFKPdgFfoY0PzK5knxQSaEG3xuDvznxH6lpDFP7TezZx5X1egCl
         AruwwRr27goTMrup9IxXKlKDfPp6ArMrMSOl4Ksqtmn9izZIO+x4HwMyxjM7nStpcLFq
         Hd+lLyPjDn7p4tfQ6m/0VQvrLFeutX9/Sma1pAk2Z/vRFkxbYqn5QDckqLMLOtJa1ykS
         Dk+b32PYUwz/Ryge6agUM47xF9/hJUoUGRAkjY/OZz+Y6Lgu69Dqw8zQ2QFCdu8q1GwI
         PFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5dt8mRMkaVrl+nfEDyEZPX5yqd+F3sQQwx3y5XKSPWQ8u3UjwKJTmNqQBMmYZt4FUBI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRfQOF9+nOwvhN2lIEWnlnd3tDSV88B8KF61sd8E92/Hd5+pq
	SqShpxKnm8yxl86x+GkUTqB5Fc/f9biS35bNQnITHnsdR87moBNEeXqXGCGtnbrMI96+nGpfDR+
	L0MzFox8ru+6QXTGuw4WmA+cnIH0=
X-Google-Smtp-Source: AGHT+IHKS4jyS5WJImSIZiO0RWdBqrFY8yBJsHDQ8GI16bGLCo0P4qnYHew/tHiQmizyWsKTOZV79jTpIZGqNC7wguA=
X-Received: by 2002:a05:6870:c192:b0:27b:d83:f18e with SMTP id
 586e51a60fabf-287c1db22bemr7501944fac.18.1728315169783; Mon, 07 Oct 2024
 08:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
 <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com> <b3d3deced25f038defe6afe7d474350464328299.1728299466.git.gitgitgadget@gmail.com>
 <4f79f144-9f48-4fbe-b646-2d146e57606a@gmail.com>
In-Reply-To: <4f79f144-9f48-4fbe-b646-2d146e57606a@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 15:32:38 +0000
Message-ID: <CAPSxiM_eyWJAfFV7jZzerBZaG1RY3h78rd+hVcRBUjdgGtCkrg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] t3404: employing test_line_count() to replace test
To: phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:07=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Usman
>
> I missed this when I read the earlier version of this series but our
> commit subjects use the imperative so we would say
>
>      t3403: employ test_line_count() to replace test
>
> or
>
>      t3404: replace test with test_line_count()
>
Thanks for the review. I just improved the commit subject now.
> I agree with Patrick that we should let this series settle for a couple
> of days to allow others to comment before sending any new version.
>
> This series is looking good, congratulations
Thanks Philip.
>
> Phillip
>
> On 07/10/2024 12:11, Usman Akinyemi via GitGitGadget wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Refactor t3404 to replace instances of `test` with `test_line_count()`
> > for checking line counts. This improves readability and aligns with Git=
's
> > current test practices.
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >   t/t3404-rebase-interactive.sh | 28 ++++++++++++++--------------
> >   1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> > index 96a65783c47..2ab660ef30f 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -281,8 +281,9 @@ test_expect_success 'stop on conflicting pick' '
> >       test_cmp expect2 file1 &&
> >       test "$(git diff --name-status |
> >               sed -n -e "/^U/s/^U[^a-z]*//p")" =3D file1 &&
> > -     test 4 =3D $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
> > -     test 0 =3D $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
> > +     grep -v "^#" <.git/rebase-merge/done >actual &&
> > +     test_line_count =3D 4 actual &&
> > +     test 0 =3D $(grep -c "^[^#]" <.git/rebase-merge/git-rebase-todo)
> >   '
> >
> >   test_expect_success 'show conflicted patch' '
> > @@ -401,8 +402,8 @@ test_expect_success 'multi-squash only fires up edi=
tor once' '
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> >       git show >output &&
> > -     count=3D$(grep ONCE output | wc -l) &&
> > -     test 1 =3D $count
> > +     grep ONCE output >actual &&
> > +     test_line_count =3D 1 actual
> >   '
> >
> >   test_expect_success 'multi-fixup does not fire up editor' '
> > @@ -416,8 +417,7 @@ test_expect_success 'multi-fixup does not fire up e=
ditor' '
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> >       git show >output &&
> > -     count=3D$(grep NEVER output | wc -l) &&
> > -     test 0 =3D $count &&
> > +     ! grep NEVER output &&
> >       git checkout @{-1} &&
> >       git branch -D multi-fixup
> >   '
> > @@ -436,8 +436,8 @@ test_expect_success 'commit message used after conf=
lict' '
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> >       git show >output &&
> > -     count=3D$(grep ONCE output | wc -l) &&
> > -     test 1 =3D $count &&
> > +     grep ONCE output >actual &&
> > +     test_line_count =3D 1 actual &&
> >       git checkout @{-1} &&
> >       git branch -D conflict-fixup
> >   '
> > @@ -456,8 +456,8 @@ test_expect_success 'commit message retained after =
conflict' '
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> >       git show >output &&
> > -     count=3D$(grep TWICE output | wc -l) &&
> > -     test 2 =3D $count &&
> > +     grep TWICE output >actual &&
> > +     test_line_count =3D 2 actual &&
> >       git checkout @{-1} &&
> >       git branch -D conflict-squash
> >   '
> > @@ -501,8 +501,8 @@ test_expect_success 'squash ignores comments' '
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> >       git show >output &&
> > -     count=3D$(grep ONCE output | wc -l) &&
> > -     test 1 =3D $count &&
> > +     grep ONCE output >actual &&
> > +     test_line_count =3D 1 actual &&
> >       git checkout @{-1} &&
> >       git branch -D skip-comments
> >   '
> > @@ -519,8 +519,8 @@ test_expect_success 'squash ignores blank lines' '
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> >       git show >output &&
> > -     count=3D$(grep ONCE output | wc -l) &&
> > -     test 1 =3D $count &&
> > +     grep ONCE output >actual &&
> > +     test_line_count =3D 1 actual &&
> >       git checkout @{-1} &&
> >       git branch -D skip-blank-lines
> >   '
>
