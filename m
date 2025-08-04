Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFD1C5F09
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754334930; cv=none; b=c9Tj6eQMTaX28DR1TLn80uVrW1FurtBRlLAmoPeGod1Adq0q/nc1BWQRWFud/lp5mCj3tSq1JL9aprqqSd9dtQug7fj2DBMJIC+ywBdjvc9gXpDN1jL61wkb85tWNZQG2JDBAhTe4nEwgD7/H1w+MYDD7CrST54p6RgVWgwjAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754334930; c=relaxed/simple;
	bh=3McdbDLDlV0Uw6+v9xs3HX+KR4+ipH7lt2EivLSYynY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bil+CxEyOrg6TmjHqRTGsFOniCa78Swyu0rZZqnArNdMvb6bejxK3LvPG8Q/gP5nIwemWND9ivM81sUmDMuHDMwDwnU6jxcAbo5Ev81oS7WqtnkLOygvmtAqtHmdrXYGictWPPSYYXcCHH1mIiB7J0FQLHNGKXBQcws7QWSxL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ3YdGLh; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ3YdGLh"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88182bb2336so26169239f.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754334927; x=1754939727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrNGn0PZiJBBNFyWsTnJ+m3m7KDHM5RnWjAkTM5cUJc=;
        b=hJ3YdGLh9OqMMrVUjdFqMEzFgNVTDGk97payKANGGo4KSGegJb/sBpPnpN/IxeeM50
         cXujWOHh6FiCoO8QTRImAwoNCdsPu4/zZdQLWe5pYo9hWHuLpLOc5YLXcapm1uYTOiTM
         N9Tjm2aH/XnoExdoQrgYTSEbU9cQi2hEh2UglDwezCPlKew9cHl0tzuAuxw3SfLPiHH7
         Xe8k7K1fvt9Nt5xbjDnMWaYxd67BLGOChsheF10U++1vX4GZ+kLGw+dpBnNlDJilgXq6
         NHTHiaKLxcb6x9TZ2yM1ATZU5kaVTNH9zbTJUw5+XloTlrVKILlx2LSaxkSFi/GmGTQ/
         Prug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754334927; x=1754939727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrNGn0PZiJBBNFyWsTnJ+m3m7KDHM5RnWjAkTM5cUJc=;
        b=azo/AlHkeoIhbZxmDTwrMQja+VDnP26aJZKt5YFOgDvi5uIEBPxeGLlFSenZEHRqkr
         A+mK+vLskH65fOyp3gyJh4RSZtltSJCrlyYeLou38ZqpACY32/s/kmOP51kJHwzm6DjS
         MmMpW421EF1HgegrfzhTIXibOTdPNALI2wOUPnRyee8SrlW17G8B0WcPKxIn7Won0Xba
         kHyRH33EcgLQ2LXSDgNoHJIHMpnVB3V0msge1DyfCZdlMQPrwbneO6YqbMPem+fD0mhD
         VfF27TlqGhH2tEheK+Hu6ZxHxfWFDQo++77BBM3m+B3wRqXowYLhEL5wb2urTHQLYU8a
         P7jw==
X-Forwarded-Encrypted: i=1; AJvYcCW7q5WE973PebQplfP37G5nCTW72Sgz9DZpwTLWE4sVKIatFjIcgxfnCRQnJkBW6Hdzb3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsZK0H+rUz+2JC7BK1YvQ6EJDSn0mnRfSotPWbfBy0/+BWWzK
	8CYmZfRBqmrOtGW67BWV2Mdbcgs00wF4shJ507UFiqx6E/LM/EFe2Ux+1/FQV3uJ0YJDylp1nCc
	YPKi/lb1x4fBNoNqvJami61ZFTfGikpk=
X-Gm-Gg: ASbGncsV8bvraEatZ34DHHSrT8XHV35fDmHkYhed0Jz626oXgtsPhmApNlE2WYhTW0X
	k0sMtBvE4pxvsNzpg0D1JrWKw1hg/bwdu3Mkk3SbjD7YIop4cOjpI35l8bI6ohv07NG6txaklhf
	ODls30YCVaNTy6bRSfDIGn6OxSph23OxLSLNHG0Ng5gBOlyi8rlyy91NC703kuB6CHxWV/DlrJ9
	fB27qINYNOnYSNMIzjmC/1rAG/atnqgpEAX6OyX7mH1qvvN
X-Google-Smtp-Source: AGHT+IGKbZRqthBvMO6vEycyMXllybjUAYQ5FnlSSzR9TETH2d5NVPVX5A5ikcSXx+vpw0HBSr3SvsirLRb8B/MXQHo=
X-Received: by 2002:a05:6e02:1d9d:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3e41618be7dmr163530645ab.13.1754334926800; Mon, 04 Aug 2025
 12:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <bda42aa85cf4f332ef60aca1a8937ed4b868fa87.1753197791.git.gitgitgadget@gmail.com>
 <aIx7OEX6AEqNsIHb@pks.im>
In-Reply-To: <aIx7OEX6AEqNsIHb@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 4 Aug 2025 12:15:15 -0700
X-Gm-Features: Ac12FXxVQnMgnfD7-p1ISfBJLWb0VkpvzGijz27Bv3-b9QA4HLOZL3YinHJ96lU
Message-ID: <CABPp-BEUFaePoJx-dn9hOE6r7mQV_W_6QF2K1sJJ2uXeL81rdg@mail.gmail.com>
Subject: Re: [PATCH 3/6] t6423: document two bugs with rename-to-self testcases
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Jul 22, 2025 at 03:23:08PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename=
-directories.sh
> > index f48ed6d03534..69de7a3b84af 100755
> > --- a/t/t6423-merge-rename-directories.sh
> > +++ b/t/t6423-merge-rename-directories.sh
> > @@ -5092,7 +5111,85 @@ test_expect_success '12n: Directory rename trans=
itively makes rename back to sel
> >               git checkout -q B^0 &&
> >
> >               test_must_fail git cherry-pick A^0 >out &&
> > -             grep "CONFLICT (file location).*should perhaps be moved" =
out
> > +             grep "CONFLICT (file location).*should perhaps be moved" =
out &&
>
> Let's use `test_grep` while at it.

Oh, right, it was test_i18ngrep that we weren't supposed to use.
Yeah, I can switch over to test_grep.

> [snip]
> > +test_expect_failure '12n2: Directory rename transitively makes rename =
back to self' '
> > +     test_setup_12n2 &&
> > +     (
> > +             cd 12n2 &&
> > +
> > +             git checkout -q B^0 &&
> > +
> > +             # NOTE: Since merge.directoryRenames=3Dtrue, there is no =
path
> > +             # conflict for world vs. tools/world; it should end up at
> > +             # world.  The fact that world was unmodified on side A, m=
eans
> > +             # there was no content conflict; we should just take the
> > +             # content from side B -- i.e. delete the file.  So mergin=
g
> > +             # could just delete world.
> > +             #
> > +             # However, rename-to-self-via-directory-rename is a bit m=
ore
> > +             # challenging.  Relax this test to allow world to be trea=
ted
> > +             # as a modify/delete conflict as well.
> > +
> > +             test_might_fail git -c merge.directoryRenames=3Dtrue merg=
e A^0 >out &&
> > +
> > +             # Should have 1 entry for hello, and either 0 or 2 for wo=
rld
> > +             test_stdout_line_count =3D 1 git ls-files -s hello &&
> > +             test_stdout_line_count !=3D 1 git ls-files -s world &&
> > +             if test_stdout_line_count !=3D 0 git ls-files -s world
> > +             then
> > +                     grep "CONFLICT (modify/delete).*world deleted in =
HEAD" out
>
> Here, as well.

Will do.

> > +             fi
> >       )
> >  '
>
> I found it to be a bit weird that we have this conditional here.
> Shouldn't we expect one particular outcome? Even if multiple outcomes
> would be techincally correct I think we should expect one particular
> result, but we may add a comment to explain that different output would
> be fine, too.

Isn't that exactly what I did, with the note I'll copy below?

> > +             # NOTE: Since merge.directoryRenames=3Dtrue, there is no =
path
> > +             # conflict for world vs. tools/world; it should end up at
> > +             # world.  The fact that world was unmodified on side A, m=
eans
> > +             # there was no content conflict; we should just take the
> > +             # content from side B -- i.e. delete the file.  So mergin=
g
> > +             # could just delete world.
> > +             #
> > +             # However, rename-to-self-via-directory-rename is a bit m=
ore
> > +             # challenging.  Relax this test to allow world to be trea=
ted
> > +             # as a modify/delete conflict as well.
