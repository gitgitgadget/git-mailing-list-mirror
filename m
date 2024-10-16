Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B818C928
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058789; cv=none; b=NJSgcJI5ZCnZY99tgz0H7gUkXcRRQleRTSQRN6eMW3zUMf75H97+A7Pn5D0YNCdLyGz886AeUSNxSilicGROqmX6NXNiqjSfSoEnZXIfq2HRppLgqoJFK4609Svyg3SM7aW3goSeSGqpnkjLnPKIqTat217tDOx4gGEjWCePmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058789; c=relaxed/simple;
	bh=mVSYKMydUx3anSZu8kbLgPw0D7KybNjKrRramYGa0MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9en47PmwjfTx0DSR1v4XIQ9TOU+txVHL9Bx9vLj85+2u4xZM1PNdCIcsWqIW3kUno9OBi9ink01SNrvVJU47Us6YbswPdQukHYMG2BlU9i56TFf0MNIZV2Pxbmu2aLCqFuUmhBCS2rzqofCeV6MR0wUaPQsqUWjEZcvyLzcY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN02QcO5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN02QcO5"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso17545681fa.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 23:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729058784; x=1729663584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghTtu4xqOwdEQBz2NJ1JyRMA8DKM/NcXVpeg+yqUlnA=;
        b=bN02QcO5CoVD5yOgledTFUedZxrt7WDU9KF4fNoH7Qv8GuDH+OScli1bp6QQdoEmw9
         mKa1/X623Y4V39qRJKgigXhRs9/GueksoLDS+UgZnFyW6rDXqMhSXsdheMSYhwxJf5Q9
         cws620Y29ZNpfG4VDxvZa+qBq02t1I8zE3NVjDskm2E4IioZ8lyaFKGGSLrSQcHLU8C9
         XJDJyEJ2uGPp1DqxTTQDBM5ez9Tm+AinvEwsL0SIti++QDH5jeSVGVvIHzkSScokHRBb
         sdTGLLW0ru0CaBKRtjC4xR61LfqJVTY3UW7s0nrJHS+FDNjWy3+SogwJVlVfuqe4ZBtF
         NOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729058784; x=1729663584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghTtu4xqOwdEQBz2NJ1JyRMA8DKM/NcXVpeg+yqUlnA=;
        b=fDZrYHpnhqOEdmInMk+CCfNFJn4vckdGrbhELSia+Dyim38cLWypAiRIuZ0/KknsYj
         RxgkS6Q+g4BhGPPPxWi8LCPDjolMm7ym+V+XbB0yxxGCuhs1CvN9siMuZIPPiF9MqTus
         fQodQOnfFtuNMeQ1x16gm06rrt8eGx0YVcHnAGdhvd/SJVpk2wpl49TMxjbkhzd27g2U
         KjZMi7jJYtos7lpP6bWOjvfuXua/Fh27sgfskLjqXDO8CvnbHdJrkHhWGtlzfc1aL0Qf
         bJ5CFY67fOC0vX+g+423+r0pIrMHlaUhHNHun5s0g7LP8jgdm2a1t0+x8hb/ZfT38Faw
         PAJg==
X-Forwarded-Encrypted: i=1; AJvYcCVDMlRwi7cwvmiZ00L+N5cpNVCWdhu1rVMbHvChq+HJIDIFbcUijnuOcxGRHvtt1+0QRF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2aMuBkqsJ0QN0EGb2EL8okVq4oHyXuHrNPuavaQVutZHyEgBo
	r+3zjI/TVWetUz6SKry2qH06I5pDU++UzzzwWYn48mqfoQGD2936ti3BShjUufuE9yCS17QPxeR
	JcLi/8+gI4AME2yFi/pZpNCb45fs=
X-Google-Smtp-Source: AGHT+IEBxdKGY0X4Y7qnodY2PLPpbn90R02hH93bfGsJuJWTH8l9kLR783ha0h5du+A1haZg2Fvayi4vuwoRApmnQqY=
X-Received: by 2002:a05:651c:1989:b0:2fb:6181:8ca1 with SMTP id
 38308e7fff4ca-2fb61b37a76mr20380981fa.6.1729058783521; Tue, 15 Oct 2024
 23:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <4f835282-d921-4cd3-9680-d8522bef7b39@app.fastmail.com>
In-Reply-To: <4f835282-d921-4cd3-9680-d8522bef7b39@app.fastmail.com>
From: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>
Date: Wed, 16 Oct 2024 11:36:12 +0530
Message-ID: <CAAirc3jqDf_jHudiJZaD4+pMYYj01xhG1398+i4B=J22Dqm7GQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

Thank you for reviewing the v2 of my patch. I appreciate your
thoughtful feedback.
Before proceeding with v3, I=E2=80=99d like to address some of your questio=
ns
and suggestions.

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
perspective on how this
feature can be implemented using the existing configuration flow
without disrupting
other settings. It has helped shape the solution, as I described in my
response to Eric earlier.

Based on Phillip's clue of exploring how this feature would interact
with existing configuration
settings and your conceptual workflow, I explored git_config_set and
used it to set the
blame.ignoreRevsFile configuration. This approach fits well with the
existing configuration
logic and provides greater flexibility.

With git_config_set to set blame.ignoreRevsFile:

git blame hello.txt
would consult the default .git-blame-ignore-revs file.

git blame --no-ignore-revs-file hello.txt
would disable the default ignore file.

git blame --no-ignore-revs-file --ignore-revs-file=3Dignore-list hello.txt
would allow the user to specify a custom ignore list while bypassing
the global list,
offering the flexibility you suggested.

This would maintain consistency with Git=E2=80=99s existing behavior, allow=
ing
users to modify
configurations with a =E2=80=9Clast-wins=E2=80=9D approach and enabling bot=
h global
and custom ignore
lists as needed.


> I have not tested these patches.  But I see why you check for file access=
/existence.  Because with this config:
>
> ```
> [blame]
>         ignoreRevsFile=3D.git-blame-ignore-revs
> ```
>
> I get this warning in repositories that don=E2=80=99t have the file:
>
> ```
> fatal: could not open object name list: .git-blame-ignore-revs
> ```
>
> Which is just noise.
>
> I get the same thing with Git Notes namespace configurations.  I need to
> configure them for certain repositories (like `amlog` in this project),
> but then I get warnings about them when using the relevant commands in a
> project that does not have them.
>
> Maybe this is totally off-topic but I think it would make more sense if
> `blame.ignoreRevsFile` just didn=E2=80=99t say anything if it didn=E2=80=
=99t find the
> file.  Because the point of the config might be to opt-in to this file
> for those projects that does have it.

Yes, I agree. For a default ignore file, we shouldn't raise a fatal
error if the file is missing, especially if it=E2=80=99s not present in eve=
ry
repository.
Suppressing the warning for the default file would improve user experience
and prevent unnecessary noise.


> > However, users may encounter cases where they need to
> > temporarily override these configurations to inspect all commits,
> > even those excluded by the ignore list. Currently, there is no
> > simple way to bypass all ignore revisions settings in one go.
>
> =E2=80=9CNo simple way=E2=80=9D gives me pause.  But there are those opti=
ons/methods
> that we discussed before:
>
> =E2=80=A2 `--no-ignore-rev`
> =E2=80=A2 `--no-ignore-revs-file`
>
> These are not documented but I can provide these options and get a
> different output from git-blame(1).
>
> `builtin/blame.c` uses `parse-options.h` which provides automatic
> negated options.  I just looked at the code today (so it=E2=80=99s new to=
 me)
> but it seems like it will empty the lists that are associated with these
> options.  See `parse-options-cb.c:parse_opt_string_list`.
>
> So I think this should be sufficient to reset all =E2=80=9Cignore=E2=80=
=9D options:
>
> ```
> git blame --no-ignore-rev --no-ignore-revs-file
> ```
>
> However I tested with this:
>
> ```
> git blame --ignore-revs-file=3D.git-blame-ignore-revs --no-ignore-revs
> ```
>
> And the output suggests to me that `--no-ignore-revs` affect the result
> of the before-mentioned list of files.  Even though these are two
> different lists.  I can=E2=80=99t make sense of that from the code.  But =
I=E2=80=99m not
> a C programmer so this might just be a me-problem.

Yes, --no-ignore-revs-file and --no-ignore-rev flags work as intended
to bypass the configuration that ignores revisions. They are separate lists=
, so
--no-ignore-revs shouldn=E2=80=99t affect the --ignore-revs-file list. My p=
revious
 testing post v1 had some issues in test setup, which led me to believe tha=
t
the --no-ignore flags don=E2=80=99t work and I worked on --override-ignore-=
revs.


> > which allows users to easily bypass the --ignore-revs-file
> > option, --ignore-rev option and the blame.ignoreRevsFile
>
> I can see no precedence for the name =E2=80=9Coverride=E2=80=9D for an op=
tion in this
> project.  The convention is `--[no-]option`.
>
> Like Eric Sunshine discussed: a common convention is to let the user
> activate and negate options according to the last-wins rule.  This is
> pretty useful in my opinion.  Because I can then make an alias which
> displays some Git Note:
>
> ```
> timber =3D log [options] --notes=3Dresults
> ```
>
> But then what if I don=E2=80=99t want any notes for a specific invocation=
?  I
> don=E2=80=99t have to copy the whole alias and modify it.  I can just:
>
> ```
> git timber --no-notes
> ```
>
> And the same goes for an alias which disables notes:
>
> ```
> timber =3D log [options] --no-notes
> ```
>
> Because then I can use `git timber --notes=3Dresults`.

I agree that the override option is unnecessary, as both
--no-ignore-rev and --no-ignore-revs-file
already allow users to bypass the ignore configurations. Also, the
=E2=80=9Clast-wins=E2=80=9D approach is more
useful and aligns with how Git typically handles configurations. It=E2=80=
=99s
flexible and user-friendly,
allowing for easy toggling within aliases or individual commands.
Implementing this using the
existing configuration method, such as git_config_set, would be a
clean and effective solution
to ensure that users can quickly modify or negate options as needed.


> > configuration. When this option is used, git blame will completely
> > disregard all configured ignore revisions lists.
> >> The motivation behind this feature is to provide users with more
> > flexibility when dealing with large codebases that rely on
> > .git-blame-ignore-revs files for shared configurations, while
> > still allowing them to disable the ignore list when necessary
> > for troubleshooting or deeper inspections.
>
> You might be able to achieve the same thing with the existing negated
> options.
>
> If you *cannot* disable all =E2=80=9Cignore=E2=80=9D config and options i=
n one negated
> one then you might want an option like `--no-ignores` which acts like:
>
> ```
> git blame --no-ignore-rev --no-ignore-revs-file
> ```

Yes, the override option isn=E2=80=99t necessary since the existing flags w=
ork
as intended.
If needed in the future, we can add a single flag to reset both lists, or a=
s you
mentioned it can be an alias too.


> > + if (!override_ignore_revs) {
> > + build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
> > + }
> > +
>
> This demonstrates the more limited behavior: you either override
> (discard) the ignores or you don=E2=80=99t.  With the negated options you=
 build
> up and reset/empty those lists before you get to this point.  That ends
> up being more flexible for the user.

Yes, this approach was more limited, we can follow the approach
described earlier that uses git_config_set to handle ignoring
revisions and revision lists more flexibly.


Thanks again for your detailed feedback. I hope this approach is
better than my previous approach.
I=E2=80=99ll incorporate these changes and move forward with v3. Looking
forward to your further thoughts!

Best regards,
Abhijeetsingh

On Sat, Oct 12, 2024 at 7:28=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
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
>
> On Sat, Oct 12, 2024, at 06:37, Abhijeetsingh Meena via GitGitGadget wrot=
e:
> > From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> >
> > git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
> > This is useful for marking uninteresting commits like formatting
> > changes, refactors and whatever else should not be =E2=80=9Cblamed=E2=
=80=9D.  Some
> > projects even version control this file so that all contributors can
> > use it; the conventional name is `.git-blame-ignore-revs`.
> >
> > But each user still has to opt-in to the standard ignore list,
> > either with this option or with the config `blame.ignoreRevsFile`.
> > Let=E2=80=99s teach git-blame(1) to respect this conventional file in o=
rder
> > to streamline the process.
> >
> > Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> > ---
> >  builtin/blame.c                      |  8 ++++++++
> >  t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100755 t/t8015-blame-default-ignore-revs.sh
> >
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index e407a22da3b..1eddabaf60f 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -1105,6 +1105,14 @@ parse_done:
> >               add_pending_object(&revs, &head_commit->object, "HEAD");
> >       }
> >
> > +     /*
> > +     * By default, add .git-blame-ignore-revs to the list of files
> > +     * containing revisions to ignore if it exists.
> > +     */
> > +     if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
> > +             string_list_append(&ignore_revs_file_list, ".git-blame-ig=
nore-revs");
> > +     }
> > +
>
> I have not tested these patches.  But I see why you check for file access=
/existence.  Because with this config:
>
> ```
> [blame]
>         ignoreRevsFile=3D.git-blame-ignore-revs
> ```
>
> I get this warning in repositories that don=E2=80=99t have the file:
>
> ```
> fatal: could not open object name list: .git-blame-ignore-revs
> ```
>
> Which is just noise.
>
> I get the same thing with Git Notes namespace configurations.  I need to
> configure them for certain repositories (like `amlog` in this project),
> but then I get warnings about them when using the relevant commands in a
> project that does not have them.
>
> Maybe this is totally off-topic but I think it would make more sense if
> `blame.ignoreRevsFile` just didn=E2=80=99t say anything if it didn=E2=80=
=99t find the
> file.  Because the point of the config might be to opt-in to this file
> for those projects that does have it.
>
> >       init_scoreboard(&sb);
> >       sb.revs =3D &revs;
> >       sb.contents_from =3D contents_from;
> > diff --git a/t/t8015-blame-default-ignore-revs.sh
> > b/t/t8015-blame-default-ignore-revs.sh
> > new file mode 100755
> > index 00000000000..d4ab686f14d
> > --- /dev/null
> > +++ b/t/t8015-blame-default-ignore-revs.sh
> > @@ -0,0 +1,26 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'default revisions to ignore when blaming'
> > +
> > +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'blame: default-ignore-revs-file' '
> > +    test_commit first-commit hello.txt hello &&
> > +
> > +    echo world >>hello.txt &&
> > +    test_commit second-commit hello.txt &&
> > +
> > +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
> > +    mv hello.txt.tmp hello.txt &&
> > +    test_commit third-commit hello.txt &&
> > +
> > +    git rev-parse HEAD >ignored-file &&
> > +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
> > +    git rev-parse HEAD >.git-blame-ignore-revs &&
> > +    git blame hello.txt >actual &&
> > +
> > +    test_cmp expect actual
> > +'
> > +
> > +test_done
> > --
> > gitgitgadget
>
> --
> Kristoffer
