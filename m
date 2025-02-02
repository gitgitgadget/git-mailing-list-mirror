Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4F4C6C
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738457635; cv=none; b=emKZhTmMoQ+hmy82+0XCh+r6o/sULeoNClXmG4nXgWkqACKiTurKTxKX8cmiBARuHBiO6G31B+7UGFnxilUlaO7jB1orI/5dMF5xdSJgjfMbmx7NTD1AxySlyMmCGbXu53UnFn4OpVKAYXipgQl4RXucYe8Fpx/A077o0cH9FtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738457635; c=relaxed/simple;
	bh=iKlWC9OhZCi0XaFcv+QS5LR5q9VcudnsLv5Inp6ZM3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKN2C/q9TZzJ7xOV23hMLK4tFeXB8Hk7MtZlvevEYo+jrzuaZf9gNf5uFWHtCQoMbhY4dFwDhEtKOlyGe+4OTy6U+hluc7SWNqHLtT4NnXx8TvfCtQvt8nNfU7RWGJa01hx0lgYfwlWs529oYl7lGQ9ck9HOAVaNu6M4ZJuOKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYQskG6b; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYQskG6b"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd0d09215aso24077506d6.2
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 16:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738457632; x=1739062432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU0shLJWPgbWBBBiyyUxpmo8DVUX3j20ERoklLSLrck=;
        b=mYQskG6bAL78ppORdcVmO6J75PecJo0e8jMZ0FbztzEs8vhlRHvcarBS77Y08NXthp
         x3ncXI0JcZrbkRCT1MDLbWwW+F6Ud+mAj5gjWt2wIqz1MwglH6+Fnhgz+aJwFX+Xw1d4
         GID8YLxmv9xrmoRULmpUMZ6dGZc1UWVLnbQQWos0cXDYOUy63c9V28epgof9J6/PEqsj
         u6pDdiD4KB1fpusXzyjF45Qt/n1gFR2SCiZ+zYsNhwIh/YrJABeRUch2uR0Fl5I8R1wj
         JYeP681MAT/IXE2U2n4C49Cv2BBD4gSe/TtompE5ECx3DcysBlQxaAX9dfUz5OjJ8YY/
         sWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738457632; x=1739062432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU0shLJWPgbWBBBiyyUxpmo8DVUX3j20ERoklLSLrck=;
        b=I831shuWm7uU+RK8YnDq4KWgfv65xaEcKPjCk9RX0JHGsh0QzRttws/c+qu18RXzRG
         UYXsQI0ssE/qFdjIAhR7uu5Vbw8O812+dkxfQqkieGoYUulyyv2rSfnb1CKmLO47B7sJ
         MvogxtGhmz+8dKU9aMRDtQWMovoVOAn5aROUWyRUK6D+sudFuaCVWDv3qvc4FuUpqoX1
         Hj4pa6NMiXuaVpmJ276xGuqdNytburcY1F3YWmLtYwxUD+dyqmFfqXUOtGxE9wLr3QtT
         YzChJqXQTTOfe8nCuFACzDety6xA6v/WRGKAkBt7d2RQ48hn+Pxxvbw/GK/Q5EHG8oup
         nOgA==
X-Gm-Message-State: AOJu0YwNHmcC/+a8Z1dJyZ48KaZxSBwEGoFrAlTz0/mkMT6R9OcVDlUC
	IL44r+ApFChmKb7wtVW1x4drGCmuHXhs4iSm42mKmP3Ape93nRn2lj4oYW3tnai7WwVFi1gNck2
	UC4SZRtVOESloWQTFTyPgQJfD0u21oBeWFb3mUw==
X-Gm-Gg: ASbGncvilzWAxe3axdaCdQ2HXOvY0KcmlWne4/4Kanhv9Eh5BgHzeCq+7bwJOVgP9R8
	E9qmLRmM4AfZ7mVS+yheYysBxHnACPvG6W2kolk29wLd4qL4vrMUo1m1TgSvmmzEf5bltwgMhrg
	==
X-Google-Smtp-Source: AGHT+IEYmBPAAkwRnG3tLloYvk0qiD/hSUN95NKk8NWB2dQ8vYfRHCsCm1J+cTKTJrcb9GIjjDtZIGkQugwrI9EcjhY=
X-Received: by 2002:a05:6214:e8d:b0:6d8:8f14:2f5b with SMTP id
 6a1803df08f44-6e243bf03demr294489306d6.19.1738457632250; Sat, 01 Feb 2025
 16:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201004556.930220-1-ayu.chandekar@gmail.com> <xmqqjzaa4g6m.fsf@gitster.g>
In-Reply-To: <xmqqjzaa4g6m.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sun, 2 Feb 2025 06:23:41 +0530
X-Gm-Features: AWEUYZmkwqEfROPVg53ISLg04-GkSWVIW9spfLXKXpFIlo5GN38c4uaeKpuXTok
Message-ID: <CAE7as+YC-u84ef=LRP-FB_0ApJbaP6Le6k6QrV58itiGMHsk1Q@mail.gmail.com>
Subject: Re: [GSOC] [Newbie] Test Script t6423 Microproject
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much for your response!
I also deeply apologize for the lack of etiquette. I will submit another pa=
tch
which is the same but follows the guidelines.

> Otherwise, the patch looks good.
Thanks for the feedback

Regards,
Ayush

On Sat, Feb 1, 2025 at 6:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> ayu-ch <ayu.chandekar@gmail.com> writes:
>
> > Hello everyone,
> > I am Ayush Chandekar, a second-year undergraduate student at IIT Roorke=
e.
> > I've been using Git ever since I started learning about development. Wh=
en I
> > started out, I used to solve some problems/exercises related to git. It=
 was
> > very crucial for getting better and now as I'm looking forward to start=
 my
> > contribution to open source, I find Git! I read almost all the docs on =
the website, blogs
> > and tried to understand as much code as I can. I just want to take a mo=
ment
> > to appreciate how great all the documentation is. It's honestly the bes=
t
> > I've ever seen out of any org. It developed an urge of giving back to g=
it
> > after I'd spent so much time developing things. I even started a small
> > project of making my own git (obviously mini version).
> >
> > Coming to the topic, I saw that we need to submit a microproject, and I
> > started to find my microproject. I stumbled upon the thread which menti=
oned
> > skip bitmap traversal for --left-right in git rev-list. I tried to
> > understand the issue, which I pretty much understood why it's happening=
,
> > but I figured I still need to discuss it with someone. This is also my
> > first post/patch on the mailing list, so I would love if someone can di=
scuss
> > about that issue with me :)
> >
> > The docs also said that only one microproject should be done, and for n=
ow
> > I've selected the one mentioned in them, which is Avoid suppressing git=
's
> > exit code in test scripts. But I feel that the ones mentioned are prett=
y
> > small. Can I still contribute more by not calling them as microprojects=
? I
> > can do it for more files, but first I would like to have some feedback =
about
> > my initial patch. I know there might be a lot of mistakes as this is my
> > first patch. Thanks for taking out your time for going through this :)
> >
> > Best regards,
> > Ayush
>
> Welcome.
>
> The why our "microprojects" are designed to be technically too
> trivial is because we want to get the formality and the process
> behind as early as possible.  If you look at the output of "git log
> --no-merges -200" (and the equivalent "git shortlog") from our
> recent past, you may notice that a contributor must adopt certain
> discipline in writing commits for this project, including but not
> limited to:
>
>  - to be familiar with and adhere to the coding guidelines;
>
>  - to choose the right granularity to make commits;
>
>  - to write the proposed commit log message clearly and in the same
>    style as existing commits;
>
>  - other formalities like signing off your patches.
>
> It is expected that a microproject submission would never be perfect
> in the first attempt.  Do not let it discourage you if you received
> review comments that point out the differences between what you did
> in your microproject submission and what we expect to see in our
> patches.  During the "send patches -> get review comments -> send
> updated patches -> ..." cycle, you'll learn the proper interaction
> with the reviewers to get your patches accepted.  For that, as an
> exercise material, microprojects are designed to be technically not
> too challenging.
>
> The idea behind "only one microproject per student" is that you do
> not have to do (and we do not want you to deplete our stash of)
> microprojects in order to call yourself prepared for one of our
> mentorship programs, like GSoC or Outreachy.
>
> Now, a patch critique.
>
>  * Everything you wrote in the body of the message so far are *not*
>    suitable for a proposed commit log message.  Making introduction
>    and stuff is a very good thing to do but that is not something
>    you want the "git am", which gets run on the receiving end, to
>    make it a part of our history (and by the way, you should try
>    sending your patch message to yourself and then try to apply it
>    with "git am" as a practice).  Studying "git log --no-merges" and
>    "git shortlog --no-merges" of our history would have taught that
>    already.
>
>  * The Subject: line which is the patch title needs to be carefully
>    written, too.  Again, "git shortlog --no-merges" would be a good
>    guide.  We want to make it possible to remind ourselves what each
>    commit was about only by looking at the single-line entry in
>    "shortlog".  Your title tells us the commit touches t6423, was
>    done by a Newbie, for a GSoC application, as a microproject.
>    Among these, the _ONLY_ relevant information in the longer span
>    for the project is that it touched t6423.  What kind of thing the
>    commit did to t6423 is a lot more important than who did that or
>    it was done in preparation for GSoC, but the title does not tell
>    us that.
>
>  * Be familiar with Documentation/SubmittingPatches, as it should
>    tell everything I said above, and more, I think.  Pay attention
>    to the [[real-name]] section, too.
>
> > Signed-off-by: ayu-ch <ayu.chandekar@gmail.com>
> > ---
>
> Here, between "---" line and the diffstat, is a space you can use to
> give your "greetings", and other things you do not want "git am" to
> make a part of the resulting commit log message.  We often use the
> space to describe what changed since the initial revision when
> sending an updated patch.
>
> >  t/t6423-merge-rename-directories.sh | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename=
-directories.sh
> > index 88d1cf2cde..bdd19de3aa 100755
> > --- a/t/t6423-merge-rename-directories.sh
> > +++ b/t/t6423-merge-rename-directories.sh
> > @@ -5071,7 +5071,7 @@ test_expect_success '12i: Directory rename causes=
 rename-to-self' '
> >               test_path_is_file source/bar &&
> >               test_path_is_file source/baz &&
> >
> > -             git ls-files | uniq >tracked &&
> > +             git ls-files >actual && uniq <actual >tracked &&
> >               test_line_count =3D 3 tracked &&
>
> We tend to write one command invocation per line in our shell
> scripts (cf. Documentation/CodingGuidelines), so this should be
> written more like:
>
>                 git ls-files >actual &&
>                 uniq <actual >tracked &&
>
> The same comment applies to all other hunks.
>
> Otherwise, the patch looks good.
