Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CC1E0DC5
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403991; cv=none; b=EM5CzzTqmX9MHTCOHPEyHtT6mDSNeDBsN0LWuTgcyNFT9LXzvouXZR9hCXZS1NiyA2eZ1LRbvhqkCtiwmmvQuzOWXg3MlaOxQRn/0VFgP34n6Z9fAFzvFKTDmWhfCpdO7vNJqzQZK7YByA6+xoFzzgI9sgodLi9Mc9k6lz+0gsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403991; c=relaxed/simple;
	bh=Gmqa/T0jlgjCjGWQiBTIPjoR+4sexV3ov2txJbbL8Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lo5SNKm9itJcjQTPieKvGHtQngKCA5BHhIJ8Wj2NIh1ZL/VQJ2jhyFfrZFhedBA0DtG5blmXJaXLmUVADPb0C/VxAJBrVRe7pP/8mzTbEHHAOnCDScJ7jS0KppqkvaQAWVl8hlmo0KPW4iIOoEuePuTvolU1o821myGDXD8GHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIFKjsE/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIFKjsE/"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9982f90e92so54034266b.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403987; x=1729008787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohZ0eVn7uKHXr9/1tTWurDOygf9SQC+nEbvInH3nhV0=;
        b=EIFKjsE/+gs4YlnUnbNInoOcE+u1Oi1uT0rRahA1BQd/z2YOLTeRFDrObufzJcUNez
         5eAG3OG1C3kbNNkV/UWI180sV7WIZm4TS/j2H17VkbAYQzfTZdNJFXRI03vWtNdmcNvh
         KmbIdDoCEV59HjmTvCBU90FT6uS1sWt4urPnQa+YBWXAcZ8syTnRywKEbYFAjT8bsv0N
         0Rh8kkBeMWa4EuacSXzk/Q7niiabXwNY2OHfV/NVLTxG9MvrcS52d+JMq8J7CMyOxkJK
         gTeMzKA9WVY57+1XOo+sB7KdtjrrZGp/ya+PfueOSp38AmP9NXwchkb2C9wLOhFcyjKC
         cdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403987; x=1729008787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohZ0eVn7uKHXr9/1tTWurDOygf9SQC+nEbvInH3nhV0=;
        b=Cqco6DDV2ejjzXLk39VE3IoCyVQsfw0lCO+Au6MFiSwUHIV0c0Xq/cSph/ly2Fv5RN
         DeqS+NufMx5ykE8kW9Mbdm7zvSgK7BFUQZuBFCjql3GfRN/e25WiZcFyiIV84UfsWuy+
         9yxEx8GQF2lv4/oGlwdhWkDTANJnT1/YFyhlmY64wEFHPpM62ZFJNEUJueqi8ooMo1rp
         RDgtsXYRLmqJmNRqN5N0Wgw5Qb6vNbeLAgBuPmw2bcr/ppmFYPdZqC4vNn8GipeRRpX1
         /baSkYhboUGnEKbzoAoD2mwo8/wIng35ZYBKx4awQzhC9XtpKl+yZOq44OWzmlgRfXSc
         oabw==
X-Gm-Message-State: AOJu0YxBXJDQWiOX+Z0GCyxSQ1C9cIlb4pyQeuE94pCjxfGTEEMuZCSK
	qth+gNGSN71lhKiBudDrG6a8MkmDF62tOIvTHyzEj8QQpfDhj/xi/Pw739Vx1T0LFLgHma7y0dC
	X0msbpxnth9dI+UpKHZ2Mok/QXz0=
X-Google-Smtp-Source: AGHT+IEVgLxwcE3KzeKNJbrI1l64ZoFIEwUXWWb0Mjz8hgqbtatNmYd/xrJ74GKkAEosa8MTtCK9aEf4nxnirWhirnM=
X-Received: by 2002:a17:907:9801:b0:a99:63fa:2686 with SMTP id
 a640c23a62f3a-a9967a7b4d2mr393990966b.20.1728403987214; Tue, 08 Oct 2024
 09:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728397437637.gitgitgadget@gmail.com> <CAAirc3j2MfLyiNVnseRmTsDDu6R4gkcms1GXk=9_jAVLvEYaUg@mail.gmail.com>
 <CAAirc3gX=PBixcyR0NRyRDnrydkeeu8A9or90c8MSUdHQ6uo=w@mail.gmail.com> <CAAirc3jxEV9ZrLcZRMNahZTXWV-1H3KwGXT2iEU+nsZWX2bUnA@mail.gmail.com>
In-Reply-To: <CAAirc3jxEV9ZrLcZRMNahZTXWV-1H3KwGXT2iEU+nsZWX2bUnA@mail.gmail.com>
From: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>
Date: Tue, 8 Oct 2024 21:42:55 +0530
Message-ID: <CAAirc3iMSo9euq+UPoxi+zXU-a6n_VJOfHog5SQKHzxUVrt4rw@mail.gmail.com>
Subject: Re: [PREVIEW v2] blame: respect .git-blame-ignore-revs automatically
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Phillip Wood <phillip.wood123@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

Thank you for your feedback on my patch. I appreciate your insights
regarding the decision not to support a default file for the
--ignore-revs-file feature and the concerns related to ignoring
"cleanup" commits that could potentially introduce bugs.

I understand that addressing these concerns is crucial. Specifically,
I will focus on:

1. Ensuring there=E2=80=99s a clear and easy way for users to opt out or
override the default behavior of ignoring certain commits, especially
if they suspect those commits might contain bugs.
2. Investigating how this new feature could interact with existing
configuration options that allow users to specify what should be
ignored manually.

I will take these points into consideration as I work on my changes
and come up with a solution to address these concerns.

Thank you again for your guidance, and I look forward to your
continued feedback!

Best wishes,
Abhijeet (Ethan0456)

On Tue, Oct 8, 2024 at 9:42=E2=80=AFPM Abhijeetsingh Meena
<abhijeetsingh.github@gmail.com> wrote:
>
> Hi Kristoffer,
>
> Thank you so much for your feedback and for taking the time to review
> my patch. I appreciate your suggestions, particularly regarding the
> project convention of using the present tense to describe the current
> behavior, as well as your mention of the --no-ignore-revs-file option
> and the importance of documenting it.
>
> Regarding your first point:
>
> > My assumption then is that, with this change, I could use --no-ignore-r=
evs-file to turn off the default file.
>
> I=E2=80=99ll check how this works in the current setup and get back to yo=
u to confirm.
>
> As for your second observation:
>
> > git blame --ignore-revs-file=3DREADME.md
> > --no-ignore-revs-file README.md
> > And that works without giving errors. So it=E2=80=99s there. Just appar=
ently undocumented?
>
> I=E2=80=99ll look into opening an issue and submitting a PR to add
> documentation for this, as it seems important to address.
>
> I=E2=80=99m excited to refine the patch with these improvements in mind a=
nd
> will continue working on the commit message and necessary
> documentation in line with your feedback.
>
> Thanks again for your guidance and support!
>
> Best regards,
> Abhijeet (Ethan0456)
>
> On Tue, Oct 8, 2024 at 8:53=E2=80=AFPM Abhijeetsingh Meena
> <abhijeetsingh.github@gmail.com> wrote:
> >
> > Hi Phillip,
> >
> > Thank you for your feedback on my patch. I appreciate your insights reg=
arding the decision not to support a default file for the --ignore-revs-fil=
e feature and the concerns related to ignoring "cleanup" commits that could=
 potentially introduce bugs.
> >
> > I understand that addressing these concerns is crucial. Specifically, I=
 will focus on:
> >
> > 1. Ensuring there=E2=80=99s a clear and easy way for users to opt out o=
r override the default behavior of ignoring certain commits, especially if =
they suspect those commits might contain bugs.
> > 2. Investigating how this new feature could interact with existing conf=
iguration options that allow users to specify what should be ignored manual=
ly.
> >
> > I will take these points into consideration as I work on my changes and=
 come up with a solution to address these concerns.
> >
> > Thank you again for your guidance, and I look forward to your continued=
 feedback!
> >
> > Best wishes,
> > Abhijeet (Ethan0456)
> >
> > On Tue, Oct 8, 2024 at 8:53=E2=80=AFPM Abhijeetsingh Meena <abhijeetsin=
gh.github@gmail.com> wrote:
> >>
> >> Hi Kristoffer,
> >>
> >> Thank you so much for your feedback and for taking the time to review =
my patch. I appreciate your suggestions, particularly regarding the project=
 convention of using the present tense to describe the current behavior, as=
 well as your mention of the --no-ignore-revs-file option and the importanc=
e of documenting it.
> >>
> >> Regarding your first point:
> >>
> >> > My assumption then is that, with this change, I could use --no-ignor=
e-revs-file to turn off the default file.
> >>
> >> I=E2=80=99ll check how this works in the current setup and get back to=
 you to confirm.
> >>
> >> As for your second observation:
> >>
> >> > git blame --ignore-revs-file=3DREADME.md
> >> > --no-ignore-revs-file README.md
> >> > And that works without giving errors. So it=E2=80=99s there. Just ap=
parently undocumented?
> >>
> >> I=E2=80=99ll look into opening an issue and submitting a PR to add doc=
umentation for this, as it seems important to address.
> >>
> >> I=E2=80=99m excited to refine the patch with these improvements in min=
d and will continue working on the commit message and necessary documentati=
on in line with your feedback.
> >>
> >> Thanks again for your guidance and support!
> >>
> >> Best regards,
> >> Abhijeet (Ethan0456)
> >>
> >> On Tue, Oct 8, 2024 at 7:54=E2=80=AFPM Abhijeetsingh Meena via GitGitG=
adget <gitgitgadget@gmail.com> wrote:
> >>>
> >>> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> >>>
> >>> Modify `git blame` to automatically respect a `.git-blame-ignore-revs=
`
> >>> file if it exists in the repository. This file is used by many projec=
ts
> >>> to ignore non-functional changes, such as reformatting or large-scale
> >>> refactoring, when generating blame information.
> >>>
> >>> Before this change, users had to manually specify the file with the
> >>> `--ignore-revs-file` option. This update streamlines the process by
> >>> automatically detecting the `.git-blame-ignore-revs` file, reducing
> >>> manual effort.
> >>>
> >>> This change aligns with the standardized practice in many repositorie=
s
> >>> and simplifies the workflow for users.
> >>>
> >>> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> >>> ---
> >>>     blame: respect .git-blame-ignore-revs automatically
> >>>
> >>>
> >>>     Introduction
> >>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>>     Hi, I'm Abhijeet (Ethan0456), and this is my first contribution t=
o the
> >>>     Git project. I currently work as an ML Engineer at an early-stage
> >>>     startup, and I=E2=80=99m excited to contribute to this open-sourc=
e project.
> >>>
> >>>
> >>>     Why the Change?
> >>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>>     I came across this enhancement request on the bug tracker and fou=
nd it
> >>>     beginner-friendly, making it a great opportunity for me to get fa=
miliar
> >>>     with the Git codebase. The ability for git blame to automatically
> >>>     respect the .git-blame-ignore-revs file is something that can str=
eamline
> >>>     workflows for many users, and I felt it would be a valuable addit=
ion.
> >>>
> >>>
> >>>     Feedback
> >>>     =3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>>     While I=E2=80=99m confident in the changes made to builtin/blame.=
c and the new
> >>>     test case in t/t8015-blame-ignore-revs.sh, I welcome any feedback=
 or
> >>>     suggestions to improve both my code and approach. I=E2=80=99m eag=
er to learn
> >>>     from the community and improve where needed.
> >>>
> >>>
> >>>     Community Need
> >>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>>     There is precedent for this functionality in other projects:
> >>>
> >>>      * Chromium
> >>>        [https://chromium.googlesource.com/chromium/src.git/+/f0596779=
e57f46fccb115a0fd65f0305894e3031/.git-blame-ignore-revs],
> >>>        which powers many popular browsers, uses .git-blame-ignore-rev=
s to
> >>>        simplify the blame process by ignoring non-functional changes.
> >>>      * Rob Allen's blog post
> >>>        [https://akrabat.com/ignoring-revisions-with-git-blame/] discu=
sses
> >>>        the need for ignoring revisions with git blame, and a commente=
r
> >>>        specifically suggests that it would be helpful if Git automati=
cally
> >>>        respected .git-blame-ignore-revs.
> >>>
> >>>     I hope this change aligns with community needs and improves the g=
it
> >>>     blame experience for users.
> >>>
> >>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-180=
9%2FEthan0456%2Fblame-auto-ignore-revs-v2
> >>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1809/E=
than0456/blame-auto-ignore-revs-v2
> >>> Pull-Request: https://github.com/gitgitgadget/git/pull/1809
> >>>
> >>> Range-diff vs v1:
> >>>
> >>>  1:  666404681d9 =3D 1:  666404681d9 blame: respect .git-blame-ignore=
-revs automatically
> >>>
> >>>
> >>>  builtin/blame.c                      |  8 ++++++++
> >>>  t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
> >>>  2 files changed, 34 insertions(+)
> >>>  create mode 100755 t/t8015-blame-default-ignore-revs.sh
> >>>
> >>> diff --git a/builtin/blame.c b/builtin/blame.c
> >>> index e407a22da3b..1eddabaf60f 100644
> >>> --- a/builtin/blame.c
> >>> +++ b/builtin/blame.c
> >>> @@ -1105,6 +1105,14 @@ parse_done:
> >>>                 add_pending_object(&revs, &head_commit->object, "HEAD=
");
> >>>         }
> >>>
> >>> +       /*
> >>> +       * By default, add .git-blame-ignore-revs to the list of files
> >>> +       * containing revisions to ignore if it exists.
> >>> +       */
> >>> +       if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
> >>> +               string_list_append(&ignore_revs_file_list, ".git-blam=
e-ignore-revs");
> >>> +       }
> >>> +
> >>>         init_scoreboard(&sb);
> >>>         sb.revs =3D &revs;
> >>>         sb.contents_from =3D contents_from;
> >>> diff --git a/t/t8015-blame-default-ignore-revs.sh b/t/t8015-blame-def=
ault-ignore-revs.sh
> >>> new file mode 100755
> >>> index 00000000000..84e1a9e87e6
> >>> --- /dev/null
> >>> +++ b/t/t8015-blame-default-ignore-revs.sh
> >>> @@ -0,0 +1,26 @@
> >>> +#!/bin/sh
> >>> +
> >>> +test_description=3D'default revisions to ignore when blaming'
> >>> +
> >>> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> >>> +. ./test-lib.sh
> >>> +
> >>> +test_expect_success 'blame: default-ignore-revs-file' '
> >>> +    test_commit first-commit hello.txt hello &&
> >>> +
> >>> +    echo world >>hello.txt &&
> >>> +    test_commit second-commit hello.txt &&
> >>> +
> >>> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
> >>> +    mv hello.txt.tmp hello.txt &&
> >>> +    test_commit third-commit hello.txt &&
> >>> +
> >>> +    git rev-parse HEAD >ignored-file &&
> >>> +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
> >>> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> >>> +    git blame hello.txt >actual &&
> >>> +
> >>> +    test_cmp expect actual
> >>> +'
> >>> +
> >>> +test_done
> >>> \ No newline at end of file
> >>>
> >>> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> >>> --
> >>> gitgitgadget
