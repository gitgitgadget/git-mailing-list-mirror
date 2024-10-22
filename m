Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1BC8FE
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579792; cv=none; b=KrwJtsq6uPVAb2iYdoqk2qsz0JLZK7OKhdXnt4y3wcL9EYOqxZEwfm2iUgfyknlJ81m6uMp5NRpxD/hO+H0d33vWmgDu1pSNnwZNf+jX0wJ5mjXSmyk8QNyWnCsVN2bxFmKCykrsNfwSqivr1/PEHw/fWFRHL1dyVHFQHkcFNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579792; c=relaxed/simple;
	bh=22rRqJjhATvU1M/YIPP2pLmVQ7kmJaLZ1dOu0GkF//A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Gveipya4f8/yYdWjlyoH7a0rzlRtTIcgI+eYTAA5700jLPBUjqu6VkD0hA/yCexNkmn/dfP4MXtWf7MLypr1jcvc2F28v6/3kiOTrFGU6atv5bghkOcE1mt7e5y5WYCwwpQh/GEUbkcVXtz5cr4dcdNExKOurh2hJOz1z+8IGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EntX2Xea; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EntX2Xea"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e59dadebso6557087e87.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729579789; x=1730184589; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mac0Uka7DZ272C24jgqB4lCxGEFdywBrQvDPYH3Btkk=;
        b=EntX2XeaaYPOPYyq1LW6poarFrx27d25PHAO+wa5lKAc29cc884aFYgN9M1okz8Z5M
         IRoarAli6dDLt60f1omCaG5ku6sq6mYW9Ry0M+6I+IauiEzgqT5cRxMiaEL8TgcXCXrB
         u2JwL1DBdjOvhgU9bUCCyzLJsoglv07XujJdqE9s7DKDTzcGoPsLZwU4ZMqfY0hsJq8r
         aJTO85YV2gE7io7p93eMrAqa1vvH/0a5GpaCK/3euJqval781c/z/AozAchT2w2n8mGv
         w0TeGU5KQlZ8ZtoA2efLJvGbhvBpLN7nzkq/nMhWriW+Kn1aBmSnHDrDF6P9J35CQnni
         B2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729579789; x=1730184589;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mac0Uka7DZ272C24jgqB4lCxGEFdywBrQvDPYH3Btkk=;
        b=cFNqiQ36ayomlfd204piGJXjur8fscryxzinRanFqV2pkoLhPT1DA+BFCOVtdXBCaX
         qTKToruBaIzujJxeiPtzsFb4JEP86zNZRuldbItvPilYpEexAtyxzdhu8PWG7isTlVX5
         jnOCeCzWyHVxPca7q89D4P2K5T0VWegonG20HIDgT8NmAPdAyrG/Y8UO2Uzb419aj/qm
         eEypIJQbgGisSOzLFOZcqLL+nAQfBCTCcpV5nE6vmfk/zM9mcIglP7tQWFToZwsL7b4R
         M14+jbz677ApJVeFjxManMs6FZ/P+sfhBwwxCph2YS/9AJMqrAcmE6jnE1dpD1/hzB0i
         F3qA==
X-Forwarded-Encrypted: i=1; AJvYcCXpKajaUUioxDkqZgfCiAfvS1ngL8rN3RLi4eoujaEE2juq7wKXv9SYj5yJ7fIYhdhOMO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRDQtJxTZLZmnSGBifS++o2twJpV144qmwKHnOK5FZ+qP8kK4
	+dKYNFO1FtKr8ctfZQ6ZBFTkBJo6lBfF1hlOowRVffpofMIMD+0tDEudQGlyeSNu7Ectkb2upap
	bJ2JveArmlzpGE+BnvmXNP8BIORk=
X-Google-Smtp-Source: AGHT+IE7Hfmttiy4eBNILtgLFxdJ9h9X6HiyKWLNDkW7bsOVT+0THc90CvCTPZRAo7A488c9UXFceekYrdFOBViQSbw=
X-Received: by 2002:a05:6512:3a88:b0:539:f4a6:ef4b with SMTP id
 2adb3069b0e04-53a1548e321mr7172035e87.55.1729579788184; Mon, 21 Oct 2024
 23:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <0ac9d9a1-cb91-4b1c-bba1-022ecc485684@gmail.com> <CAAirc3hkiQ95kzniP4Ws_op8nWuY4tdNrCjrPXMDShq3KX_h+g@mail.gmail.com>
In-Reply-To: <CAAirc3hkiQ95kzniP4Ws_op8nWuY4tdNrCjrPXMDShq3KX_h+g@mail.gmail.com>
From: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>
Date: Tue, 22 Oct 2024 12:19:35 +0530
Message-ID: <CAAirc3gAFqa5Ox=Hp26zBXuKwE5OmHDE+j-4MnKysrgfD8u2pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
To: phillip.wood@dunelm.org.uk, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Eric Sunshine <sunshine@sunshineco.com>, "me@ttaylorr.com" <me@ttaylorr.com>, 
	Abhijeetsingh Meena <abhijeet040403@gmail.com>, git@vger.kernel.org, 
	Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric, Kristoffer, and Phillip,

Thank you for reviewing the v2 of my patch. I appreciate your
thoughtful feedback.

A few days ago, I sent a detailed email addressing each of your
questions and suggestions individually. Before proceeding with v3,
I=E2=80=99d like to consolidate my thoughts on the next possible approach
to respect '.git-blame-ignore-revs' based on Kristoffer's conceptual
explanation.

> Hi Abhijeetsingh
>
> For what it=E2=80=99s worth here=E2=80=99s how I imagine this feature cou=
ld work
> conceptually:
>
> Before this feature/change, the effective config for Git use looks like t=
his:
>
> ```
> [blame]
> ```
>
> No `blame.ignoreRevsFile`.
>
> But with/after it:
>
> ```
> [blame]
>         ignoreRevsFile=3D.git-blame-ignore-revs
> ```
>
> This is the effective config.  Not what the user has typed out.
>
> If the user types out this:
>
> ```
> [blame]
>         ignoreRevsFile=3D.git-blame-more-revs
> ```
>
> Then this becomes their effective config:
>
> ```
> [blame]
>         ignoreRevsFile=3D.git-blame-ignore-revs
>         ignoreRevsFile=3D.git-blame-more-revs
> ```
>
> Now there are two files: the default one and the user-supplied one (this
> config variable is documented as being multi-valued: =E2=80=9CThis option=
 may be
> repeated multiple times.=E2=80=9D).
>
> =C2=A7 How to ignore this new default =C2=A7=C2=A7=C2=A7
>
> Considering users who do not want this new default:
>
> ```
> [blame]
>         ignoreRevsFile=3D
> ```
>
> This is the change they would have to make.  Because a blank/empty
> resets/empties the list of files.

Thanks, Kristoffer. Your conceptual explanation gave me a new
perspective on how this feature can be implemented using the
existing configuration flow without disrupting other settings.

Based on Phillip's clue of exploring how this feature would interact
with existing configuration settings and your conceptual workflow,
I explored git_config_set and used it to set the
blame.ignoreRevsFile configuration. This approach aligns well with
the existing configuration logic and provides greater flexibility.

With git_config_set to set blame.ignoreRevsFile:

git blame hello.txt
would consult the default .git-blame-ignore-revs file.

git blame --no-ignore-revs-file hello.txt
would disable the default ignore file.

git blame --no-ignore-revs-file --ignore-revs-file=3Dignore-list hello.txt
would allow the user to specify a custom ignore list while bypassing
the global list, offering the flexibility you suggested.

This would maintain consistency with Git=E2=80=99s existing behavior, allow=
ing
users to modify configurations with a =E2=80=9Clast-wins=E2=80=9D approach =
and enabling
both global and custom ignore lists as needed.

I hope this approach is better than my previous one. I look forward to
your thoughts!

Best Regards,
Abhijeetsingh

On Wed, Oct 16, 2024 at 11:37=E2=80=AFAM Abhijeetsingh Meena
<abhijeetsingh.github@gmail.com> wrote:
>
> Hi Phillip,
> Thank you for reviewing the patch and providing valuable feedback.
> I=E2=80=99d like to address some of your points below:
>
>
> > Supporting a default file in addition to the files listed in
> > blame.ignoreRevsFile config setting leaves us in an odd position
> > compared to other settings which use a fixed name like .gitignore
> > or have a default that can be overridden by a config setting like
> > core.excludesFile or require a config setting to enable the feature
> > like diff.orderFile.
>
> Yes, I now understand that we can solve this by using the existing method=
 for
> interacting with configurations, as suggested by you and Kristoffer. We c=
an work
> with the existing configuration method like git_config_set to set ignore
> revisions file. This (I hope) will also keep it consistent with how
> other settings like .gitignore
> and core.excludesFile work, making the interaction more predictable for u=
sers.
>
>
> > I've left a couple of code comments below but really
> > the most important things are to come up with a convincing
> > reason for changing the behavior and figuring out how
> > the default file should interact with the config setting.
>
> I agree. After revisiting the use case and the flow, I see now that
> the solution can be
> more straightforward with git_config_set than my previous approach. This
> behavior allows for interaction through the configuration system
> without the need to
> introduce new options. Kristoffer=E2=80=99s suggestion clarified that han=
dling
> .git-blame-ignore-revs
>  a default file and allowing it to be overridden or disabled via
> --no-ignore-revs-file is sufficient.
>
>
> > As Kristoffer has pointed out --no-ignore-revs-file should
> > be sufficient to disable the default file. If it isn't we
> > should fix it so that it is, not add a new option.
>
> Absolutely, you're right. After revisiting my earlier testing issues,
> I realized that the
> --no-ignore-revs-file and --no-ignore-rev flag works as intended. My
> previous confusion was due to a mistake in my test setup. I agree with yo=
ur
> suggestion that we should not add a new option and instead focus on ensur=
ing
>  that the current flag behavior is clear and functions correctly.
>
>
> Thanks again for your review. I hope this approach is better than my
> previous approach.
> I=E2=80=99ll make sure the changes are implemented correctly in v3
> and test the interaction between the default file and config settings
> more thoroughly.
> Looking forward to your further thoughts!
>
> Best regards,
> Abhijeetsingh
>
> On Sun, Oct 13, 2024 at 8:48=E2=80=AFPM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
> >
> > Hi Abhijeetsingh
> >
> > On 12/10/2024 05:37, Abhijeetsingh Meena via GitGitGadget wrote:
> > > From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> > >
> > > git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
> > > This is useful for marking uninteresting commits like formatting
> > > changes, refactors and whatever else should not be =E2=80=9Cblamed=E2=
=80=9D.  Some
> > > projects even version control this file so that all contributors can
> > > use it; the conventional name is `.git-blame-ignore-revs`.
> > >
> > > But each user still has to opt-in to the standard ignore list,
> > > either with this option or with the config `blame.ignoreRevsFile`.
> > > Let=E2=80=99s teach git-blame(1) to respect this conventional file in=
 order
> > > to streamline the process.
> >
> > It's good that the commit message now mentions the config setting. It
> > would be helpful to explain why the original implementation deliberatel=
y
> > decided not to implement a default file and explain why it is now a goo=
d
> > idea to do so. Supporting a default file in addition to the files liste=
d
> > in blame.ignoreRevsFile config setting leaves us in an odd position
> > compared to other settings which use a fixed name like .gitignore or
> > have a default that can be overridden by a config setting like
> > core.excludesFile or require a config setting to enable the feature lik=
e
> > diff.orderFile.
> >
> > I've left a couple of code comments below but really the most important
> > things are to come up with a convincing reason for changing the behavio=
r
> > and figuring out how the default file should interact with the config
> > setting.
> >
> > > +     /*
> > > +     * By default, add .git-blame-ignore-revs to the list of files
> > > +     * containing revisions to ignore if it exists.
> > > +     */
> > > +     if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
> >
> > There are some uses of "access(.., F_OK)" in our code base but it is
> > more usual to call file_exists() these days.
> >
> > > +             string_list_append(&ignore_revs_file_list, ".git-blame-=
ignore-revs");
> >
> > If the user already has this path in their config we'll waste time
> > parsing it twice. We could avoid that by using a "struct strset" rather
> > than a "struct string_list". I don't think we have OPT_STRSET but it
> > should be easy to add one by copying OPT_STRING_LIST.
> >
> > > +    echo world >>hello.txt &&
> > > +    test_commit second-commit hello.txt &&
> >
> > test_commit overwrites the file it is committing so you need to use the
> > --printf option
> >
> >         test_commit --printf second-commit hello.txt "hello\nworld\n"
> >
> > > +    git rev-parse HEAD >ignored-file &&
> > > +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
> > > +    git rev-parse HEAD >.git-blame-ignore-revs &&
> > > +    git blame hello.txt >actual &&
> > > +    test_cmp expect actual
> >
> > I have mixed feelings about this sort of differential testing, comparin=
g
> > the actual output of git blame to what we expect makes it unambiguous
> > that the test is checking what we want it to.
> >
> > Best Wishes
> >
> > Phillip
> >
