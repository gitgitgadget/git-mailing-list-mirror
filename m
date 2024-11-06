Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FC36D
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873137; cv=none; b=HSA4Oj2FKoKkJcyRqF/oIQqt6PelSLe1hb5IhOJNQQqtV050xpT524RGHZ5lvH2xKA+CveRAygXxTjiM46ZgfbKpdMWQBG+zuG8mLW9htSQKv/BOQQzim0nUCmKlFSvVydQPG9OE2zKepNdDJm0kohM611UDpUbn4OmzbuZQBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873137; c=relaxed/simple;
	bh=O0+iH08goY97IWmp5Dyz7ipZlJENxQGn5JhQFJaQ3z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSz1XchGQ+9mw2epv1LXBvu+A3zVJxBKNf3lMx80pfq8IGLsbdHJKh6OSS4FXrz/fi/JTwJlhPIA/PGBJwwKusx29lmcGQLH4jHSHZU0wz9wrfTrnBbvxFI0IAlZrxa1Uf3cg39WFES1HWoFAByk6rBu+U594j3GEo1lW2MW/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOwWmc6Z; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOwWmc6Z"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fd616acf0so2460665241.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 22:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730873135; x=1731477935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMOJxIQb/LjiX/RaEPlZAPtD6uDhvOl/9UJJy14vC0w=;
        b=fOwWmc6ZtvLmdYuXk2hBIdAXQPaVDPfIIGL/ZGiV7Sn46x3w8cqaXNMbfvsMrOaDMo
         C7X6kEm/cyyZwpmt0/Nqkg+gGDygNgQoPFCefBn+iTha6e02+rnBiw3k9ESpA5GRCdZo
         nAsV2xOSBjU8Fyq/7Sv7b1wbKAmfelD5+t7OFDBacvfViZSKustMBhwxUQLjx4pjkJlf
         KFSUDw6Q/9TLUH3zs0LgM8Rhxy3HawAk2z3A1NriSBMtitNed4o7su6R0s+TSbK4f/Np
         2QIRn8UHVN3wRjgM3+f7JZyQuVcFgf6M7UVrkGFKyr6R7u7QDUBFgHqlJX+j8LPEHQIy
         tqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730873135; x=1731477935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMOJxIQb/LjiX/RaEPlZAPtD6uDhvOl/9UJJy14vC0w=;
        b=a5IRY+82MyJOKr4ffCw2Zb/zCOqGZ0bGMNEgu8DCoMWzu1UAGyzNzQ3gVSkJneEYcJ
         Yc5f+O0TJ3F8fLOX9HF0mEx0ign8WpautfuksR93zuL6pBKk6No3ffD6ch6zb4bkUkkk
         3u7tG2Wa2Gudb/AxYqIEE0F+8oZPL0+DitGKdnNhdffaI32+MDbAotgBjRGEplk9OQCv
         ZDwWTkEE2iehTJyfjLzzsV/bzsVRnNm1+G3CjAsJpi1frktqO1ayCgkmKIp87JcZ62zA
         ehlqBRyYiuz5yw1iTJqXafwSBK5DKKTO8NyIU6pFvEBA/U76EoKUgk7jFABBxqaU8vKu
         bAZw==
X-Forwarded-Encrypted: i=1; AJvYcCUGnN/y+KzNO17Xa8lkc+HJE82IvI1HWDNNmUo8XO+FAEz85cTvOorygPbuEcK1OzmhouM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6qH9IPmvAJXzh1cynF2KIRBf3nEC3zVZSyvuo8LN8MwLGqi/
	69tVNk+9mrvzRYsQ3GzR6BSK+qFVSdCsjgMCaIN6JwN/srpT6/LK0H5ziFOp9kXJbPdm/flqb96
	6deRWXYNU/Iy6exeJm08/1Q6V+1g=
X-Google-Smtp-Source: AGHT+IGUMdkUqA5NMr6CuNNWnq7KD1KYJr7TW5KyDOerSflyfTfKQtU3Jv+iGCG2Z8Xs+jvjJoua+AvpQogChL+0p1o=
X-Received: by 2002:a05:6102:38d1:b0:4a5:b159:8557 with SMTP id
 ada2fe7eead31-4a900e10f6emr24269400137.4.1730873135017; Tue, 05 Nov 2024
 22:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im> <e4a70501-af2d-450a-a232-4c7952196a74@gmail.com>
 <CAPSxiM-X3gk4tsVSJ_dFP2EGWX_dvFnqRp0rTYvhPxqYsUeijg@mail.gmail.com>
 <3c081d3c-3f6f-45ff-b254-09f1cd6b7de5@gmail.com> <CAPSxiM8u8CdeipatHRJ8Fq_8hKHDqyTm8OCh7sR49_Bh6Ps8uQ@mail.gmail.com>
In-Reply-To: <CAPSxiM8u8CdeipatHRJ8Fq_8hKHDqyTm8OCh7sR49_Bh6Ps8uQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 6 Nov 2024 06:05:23 +0000
Message-ID: <CAPSxiM8q0pA-ZZ5LdUsKoz6kqWQgvEikX_fKK+icFdH1kREs6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 12:21=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Thu, Oct 31, 2024 at 9:58=E2=80=AFAM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
> >
> > Hi Usman
> >
> > On 30/10/2024 16:19, Usman Akinyemi wrote:
> > > On Wed, Oct 30, 2024 at 3:20=E2=80=AFPM Phillip Wood <phillip.wood123=
@gmail.com> wrote:
> > >> On 21/10/2024 13:20, Patrick Steinhardt wrote:
> > >>> On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGit=
Gadget wrote:
> > >>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > >>> These are a bit curious. As your test demonstrates, we retrieve the
> > >>> values from the "gitattributes" file. And given that the file tends=
 to be
> > >>> checked into the repository, you can now basically break somebody e=
lses
> > >>> commands by having an invalid value in there.
> > >>>
> > >>> That makes me think that we likely shouldn't die here. We may print=
 a
> > >>> warning, but other than that we should likely continue and use the
> > >>> DEFAULT_CONFLICT_MARKER_SIZE.
> > >>
> > >> I think using a warning here is a good idea, we should probably fix =
the
> > >> whitespace attributes to do the same. If you have
> > >>
> > >>       * whitespace=3Dindent-with-non-tab,tab-in-indent
> > >>
> > >> in .gitattributes then "git diff" dies with
> > >>
> > >>       fatal: cannot enforce both tab-in-indent and indent-with-non-t=
ab
> > >>
> > >> Anyway that's not really related to this series but I thought I'd ad=
d it
> > >> as #leftoverbits for future reference.
> > >>
> > >> Thanks for working on this Usman, what is queued in next looks good =
to me.
> > >
> > > I just checked it. I will be glad to work on it.
> >
> > If you want to work on this that's great, but please don't feel any
> > obligation to do so.
> >
> > > I also noticed that the test used for testing used a different
> > > approach(test_must_fail) compared to the one I wrote which used
> > > test_grep. Should I change the test also ?
> >
> > I'm not sure which test you are looking at but I assume it is using
> > test_must_fail because the command being tested is expected to die. If
> > we change the code to print a warning instead then we'd need to capture
> > stderr and use test_grep or test_cmp. Note that we only want to print a
> > warning when parsing .gitattributes, the other callers of
> > parse_whitespace_rule() still want to die. Also we should decide what
> > value to use when the user provides both - neither indent-with-non-tab
> > or tab-in-indent are on by default so it's not clear exactly what we
> > should do.
> Hi Philip,
>
> I understand, we will have to pick one if we are to use a warning in this=
 case,
> indent-with-non-tab seems to be a good candidate as it is not excluded
> by default.
>
> We can have something like this
>
>     if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB) {
>         warning(_("cannot enforce both tab-in-indent and
> indent-with-non-tab, removing tab-in-indent"));
>         rule &=3D ~WS_TAB_IN_INDENT;
>     }
> and this for default
> #define WS_DEFAULT_RULE (WS_TRAILING_SPACE | WS_SPACE_BEFORE_TAB |
> WS_INDENT_WITH_NON_TAB | 8)
>
> or just leave the WS_DEFAULT_RULE as it is and remove WS_TAB_IN_INDENT
> in case both are set.
>
> what do you think ?
>
> Thank you.
> Usman
Hello,

Bringing attention to this.
>
>
> >
> > > Also, when should someone redirect a warning/failure into a file then
> > > use test_grep or just used test_must_fail ?
> >
> > You must use test_must_fail if you expect a git command to fail, if you
> > expect the command to print a warning but exit successfully you should
> > not use test_must_fail. So if you expect a command to fail and print an
> > error or warning then you'd do
> >
> >      test_must_fail git my failing command 2>err &&
> >      test_grep "error message" err
> >
> > test_must_fail checks that the command fails, but reports an error if
> > the command is killed by a signal such as SIGSEV.
> Thanks for the explanation. I understand it well now.
> >
> > Best Wishes
> >
> > Phillip
> >
> > > Thank you
> > > Usman Akinyemi
> > >>
> > >> Best Wishes
> > >>
> > >> Phillip
> > >>
> > >>
> > >>> Patrick
> > >>>
> > >>
> > >
> >
