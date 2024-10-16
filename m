Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B6187855
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058862; cv=none; b=fDpqc4/j3SOngO6lZ2SM5+9BNDiKe/QEB/PzR9y2EzCFlS+jF79mzxQrvpbjc48mityvRYYWtiF0nxuNBMOp3BzwTv9KIbpQydTNRo+EYkQn1yOWbtR77WVRd9V5qOrVL5gIUNgNCPcjm8i4ABY8vcOqsEtkOqW3nxnfyAJTO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058862; c=relaxed/simple;
	bh=2XkUJpwbAquRhj1uiCiISmzpFqOlXCBVZyCqo4Zon1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OClE1/lQUDUPsAFNe9TnkPuRAVD0Rj4yaHxNNsCdVU3e7L3vtp/MHkfA6lTAGUhhukacbCFkSVCDDGiA4CccLJAR4qQ24lzi4USvtDo0zPIn5uhmmL9JZ6FAAz3f7VD2nzb3DYx5SRDcVbKf6grD9mXo0xiXNCkT/qylKkm9pzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoe7PTlu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoe7PTlu"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so60920451fa.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729058859; x=1729663659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnm1vkoGT1tgXy6QN4cOlFVErwLGO0JdJ7tKKuImAFE=;
        b=eoe7PTlu9fTbHDwqWc8cVW4AD9hYc8/GnJX1559jppxylC/Uq1mROn4wLnIVtMYOSA
         wDm+CCwsvH1m4aaJXDDWVvqNli+tacp21KE4WiUbMprTHFC65NOSxvJVgSXbGj/7h5tG
         cjMFF1xkGW/qnyJ9CIfn1SEHq4rUXPW3EFqxXB8dwxArHpbq+eKGvJCM3KUfn5hKR22A
         4w55dr02fZd3E1suJfX4CkQXoDKONODe08XDnM1sAcdGfyzNUtg3jiXO8DLLIcLOojoY
         IeFd0NEgC35JqRot0AyE/IX7QKYQq//HTHAaMkjEsMDT4mkshT8VkMXO4YAXC4Eki/oS
         xudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729058859; x=1729663659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnm1vkoGT1tgXy6QN4cOlFVErwLGO0JdJ7tKKuImAFE=;
        b=Vy8FpXbaqEkdfjMEzL3t3cR1Na4mMGpBoxxFgWL1FkNCe1ZKi8ei8s5ceJ3UtB+BHJ
         EtFPHiet9lwX+oLEohcjtzCd4JoybfxbNUcw03IKX2ujTbEb9bT3RA18MQlrf8/FNqDk
         f//YBwhy27nprcNOFwNNjJx8EoGbFz5SLA1VTT/l06SYGyF8nepjZcpQi+ViBVieEeIL
         AMTBZ6j6DN6f7gvg6LLygG5taLwwH1Tn2ihu6qWl5oa7Jrjy6vAt8YUCOzDUwuKYDmLb
         1oJTs2+JbCDUtPv+0IfF4HwjCf96FvSIHnIz8WFkG2GCW4GPV0lPPbxAusmqIKaYQQPg
         BrJw==
X-Forwarded-Encrypted: i=1; AJvYcCWBFNVIJVBkNp1MdvF/3gtqLyvxq7OmPz0dbp9htif213VdYFfJlMksqfBH++vyCyHBHmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSg8SCBHPp5PZiKAqZiEzHyVW6mdjAUdNHhH9LoryjN3p259BF
	qSRwVPrwvF4bvA15WKTPaanAsMagdgkDsxexDbRqQqYzjmdSDCp4rlDa63WSV8AWmLYUVAZLFNK
	Woem5BMKoRZ5pIyAxQOObhcIgl0U=
X-Google-Smtp-Source: AGHT+IEo8OQlPUIFO9HfgLjquIgrstSaTktstIp2OBqMdAd+PBeEEIRwReEQQ+hCpcvblxjo6OyqM5vdwgQf0Z4aEdo=
X-Received: by 2002:a2e:b88d:0:b0:2fa:cc86:f217 with SMTP id
 38308e7fff4ca-2fb61bada51mr17378541fa.35.1729058858865; Tue, 15 Oct 2024
 23:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <0ac9d9a1-cb91-4b1c-bba1-022ecc485684@gmail.com>
In-Reply-To: <0ac9d9a1-cb91-4b1c-bba1-022ecc485684@gmail.com>
From: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>
Date: Wed, 16 Oct 2024 11:37:27 +0530
Message-ID: <CAAirc3hkiQ95kzniP4Ws_op8nWuY4tdNrCjrPXMDShq3KX_h+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
To: phillip.wood@dunelm.org.uk
Cc: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Abhijeetsingh Meena <abhijeet040403@gmail.com>, 
	"me@ttaylorr.com" <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,
Thank you for reviewing the patch and providing valuable feedback.
I=E2=80=99d like to address some of your points below:


> Supporting a default file in addition to the files listed in
> blame.ignoreRevsFile config setting leaves us in an odd position
> compared to other settings which use a fixed name like .gitignore
> or have a default that can be overridden by a config setting like
> core.excludesFile or require a config setting to enable the feature
> like diff.orderFile.

Yes, I now understand that we can solve this by using the existing method f=
or
interacting with configurations, as suggested by you and Kristoffer. We can=
 work
with the existing configuration method like git_config_set to set ignore
revisions file. This (I hope) will also keep it consistent with how
other settings like .gitignore
and core.excludesFile work, making the interaction more predictable for use=
rs.


> I've left a couple of code comments below but really
> the most important things are to come up with a convincing
> reason for changing the behavior and figuring out how
> the default file should interact with the config setting.

I agree. After revisiting the use case and the flow, I see now that
the solution can be
more straightforward with git_config_set than my previous approach. This
behavior allows for interaction through the configuration system
without the need to
introduce new options. Kristoffer=E2=80=99s suggestion clarified that handl=
ing
.git-blame-ignore-revs
 a default file and allowing it to be overridden or disabled via
--no-ignore-revs-file is sufficient.


> As Kristoffer has pointed out --no-ignore-revs-file should
> be sufficient to disable the default file. If it isn't we
> should fix it so that it is, not add a new option.

Absolutely, you're right. After revisiting my earlier testing issues,
I realized that the
--no-ignore-revs-file and --no-ignore-rev flag works as intended. My
previous confusion was due to a mistake in my test setup. I agree with your
suggestion that we should not add a new option and instead focus on ensurin=
g
 that the current flag behavior is clear and functions correctly.


Thanks again for your review. I hope this approach is better than my
previous approach.
I=E2=80=99ll make sure the changes are implemented correctly in v3
and test the interaction between the default file and config settings
more thoroughly.
Looking forward to your further thoughts!

Best regards,
Abhijeetsingh

On Sun, Oct 13, 2024 at 8:48=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Abhijeetsingh
>
> On 12/10/2024 05:37, Abhijeetsingh Meena via GitGitGadget wrote:
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
>
> It's good that the commit message now mentions the config setting. It
> would be helpful to explain why the original implementation deliberately
> decided not to implement a default file and explain why it is now a good
> idea to do so. Supporting a default file in addition to the files listed
> in blame.ignoreRevsFile config setting leaves us in an odd position
> compared to other settings which use a fixed name like .gitignore or
> have a default that can be overridden by a config setting like
> core.excludesFile or require a config setting to enable the feature like
> diff.orderFile.
>
> I've left a couple of code comments below but really the most important
> things are to come up with a convincing reason for changing the behavior
> and figuring out how the default file should interact with the config
> setting.
>
> > +     /*
> > +     * By default, add .git-blame-ignore-revs to the list of files
> > +     * containing revisions to ignore if it exists.
> > +     */
> > +     if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
>
> There are some uses of "access(.., F_OK)" in our code base but it is
> more usual to call file_exists() these days.
>
> > +             string_list_append(&ignore_revs_file_list, ".git-blame-ig=
nore-revs");
>
> If the user already has this path in their config we'll waste time
> parsing it twice. We could avoid that by using a "struct strset" rather
> than a "struct string_list". I don't think we have OPT_STRSET but it
> should be easy to add one by copying OPT_STRING_LIST.
>
> > +    echo world >>hello.txt &&
> > +    test_commit second-commit hello.txt &&
>
> test_commit overwrites the file it is committing so you need to use the
> --printf option
>
>         test_commit --printf second-commit hello.txt "hello\nworld\n"
>
> > +    git rev-parse HEAD >ignored-file &&
> > +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
> > +    git rev-parse HEAD >.git-blame-ignore-revs &&
> > +    git blame hello.txt >actual &&
> > +    test_cmp expect actual
>
> I have mixed feelings about this sort of differential testing, comparing
> the actual output of git blame to what we expect makes it unambiguous
> that the test is checking what we want it to.
>
> Best Wishes
>
> Phillip
>
