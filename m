Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4C1C69A
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177398; cv=none; b=bUow7uINKNgZuQLTpQw4oc3InXQKnB4Bk75JHFiUxM9MYtp3chZstS6JLEf7ofYNJFuUpTzUQoexWzT6eGAU9HUz0xik77Lwb/J8Rw/M3wM28Wa0ODfNf4Vrnr5aS1PvAtB00i6dhdJp/+b0Rq/VSrRm9SmXweaa3OwCSFRf5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177398; c=relaxed/simple;
	bh=MxZ7zK5J4gVcSqyGbOeUbc16nYSDiuWiyws87kJpgww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THyg/cfaR/+Y7sipBYc111R5pX+931CQuxh4cXnpgTLkGgOTCs83G6buq/kJCx/jCrRLZhBg0IXe/HdKsSChY0tz+X+FIaeFu+BpRZeXf+LCBUxDIFWQjRUXz3HEvDkK460Fi92i3tPLGSzRX7Jqsn/heNvXSmvdSUSRn5+gQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch+aDjgc; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch+aDjgc"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100cb238bcso3703178e87.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 02:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706177394; x=1706782194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PQAO+c7i6hn8beYDZ8IAgA0bcZQF1mQ4F1SHsI1Wuc=;
        b=ch+aDjgcVCxfJUbZkmBj+0swFvAI4If6WMZ/M6j1iMqAB2K5Rmfq2xWJE7vfv88A/c
         VFD8UgLqxtBhTo94QnmxKAQa4XYseqVMeVSLDzwpDGxB5auszZp5vbuV0GI5lkiD9VTa
         q1v2tQu2tAgDLoDrr0AseUGToIwIA/C+IpBLLlzMRYYcD5iItKOQFadjaV8sxZiZgUVI
         VSnR3I7yA2ucw9twwquzpA+r8v0Mecgl38ZUJGXNv5Dfhm2MnW9NTLY3psqUvIsgzrME
         D+Y/2IeTMzTjPYkEDMBLihEC4hHScPV3QzUlfanDJB8LddhPVuYAfriNipl0fSI6Hhu4
         f68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177394; x=1706782194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PQAO+c7i6hn8beYDZ8IAgA0bcZQF1mQ4F1SHsI1Wuc=;
        b=Q53V6seu7ihNL4IRcSKMhcOQeEn/7DuSi9BBxPaiAfxkJSyoiyb0qYSCW0wkir6yIw
         GoFA28i7OdLuAot7bDOgrO7MEsctI/nl0LUMe8I2eLahy7rm/bCi652D0g0+eyY1OOrx
         ZilBVuXiL35jv5JtVzmOA9MTz+B8VyLJlKL1RdIt3pmm7KHxc84e9ozAC4v2RUo/a1Zm
         ZrMV/du3R7lI3154qfWweNBcr2kZB0xxXpmcDwJur/hTWnWDQv+ao0uPzNxHaKkSglOr
         ZyvmiRHTjvNzY+lBZ1YJZejke/HcPaum940hbaR7d7Sjzh3CDtRyPOgs/aOe6tJHikcU
         o8aw==
X-Gm-Message-State: AOJu0YxpEoaCflBdjjI1RGQ/Y/mYCLvyokvOPgJmLLZ+gLgw+86ZufXq
	+Rpl9GL2lWZ65njTPucMwBrznIo13PYGwDxIOY3xVCrIpcKfB2lVBmQUi0rYVv0n1J/cCYw4mly
	F/Cf5n2R1OC0Rj14NN+ynBS/zYno=
X-Google-Smtp-Source: AGHT+IEHEi15HV0o+HlAKKRORr8tSN8A8SGtQDXh30gWeinq/8WtHaOCJqfT6tyLYvq5yZ0XuSS/4c78fEcGX4h4ea0=
X-Received: by 2002:a05:6512:158d:b0:50e:2c05:5773 with SMTP id
 bp13-20020a056512158d00b0050e2c055773mr454978lfb.27.1706177394042; Thu, 25
 Jan 2024 02:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com> <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
 <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
 <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com> <CAP8UFD3b2y+55j3NMDm89hpVRNxX2TA-AdQS=zsboD30pZ1c4Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3b2y+55j3NMDm89hpVRNxX2TA-AdQS=zsboD30pZ1c4Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 25 Jan 2024 11:09:41 +0100
Message-ID: <CAP8UFD0M_KeUTHthQ6n_a1KbEvuA1gAsE2jKkAqd-4twjbpNWw@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Zach FettersMoore <zach.fetters@apollographql.com>, Junio C Hamano <gitster@pobox.com>
Cc: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems that this topic has fallen into the cracks or something,
while the associated pch looks good to me.

On Wed, Dec 20, 2023 at 4:25=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Dec 12, 2023 at 5:06=E2=80=AFPM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 4:39=E2=80=AFPM Zach FettersMoore
> > <zach.fetters@apollographql.com> wrote:
> > >
> > > >>
> > > >> From: Zach FettersMoore <zach.fetters@apollographql.com>
> >
> > > >> To see this in practice you can use the open source GitHub repo
> > > >> 'apollo-ios-dev' and do the following in order:
> > > >>
> > > >> -Make a changes to a file in 'apollo-ios' and 'apollo-ios-codegen'
> > > >> directories
> > > >> -Create a commit containing these changes
> > > >> -Do a split on apollo-ios-codegen
> > > >> - Do a fetch on the subtree repo
> > > >> - git fetch git@github.com:apollographql/apollo-ios-codegen.git
> > > >> - git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoi=
n
> > >
> > > > Now I get the following without your patch at this step:
> > > >
> > > > $ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> > > > [...]/libexec/git-core/git-subtree: 318: Maximum function recursion
> > > > depth (1000) reached
> > > >
> > > > Line 318 in git-subtree.sh contains the following:
> > > >
> > > > missed=3D$(cache_miss "$@") || exit $?
> > > >
> > > > With your patch it seems to work:
> > > >
> > > > $ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> > > > Merge made by the 'ort' strategy.
> > > > e274aed3ba6d0659fb4cc014587cf31c1e8df7f4
> > >
> > > Looking into this some it looks like it could be a bash config
> > > difference? My machine always runs it all the way through vs
> > > failing for recursion depth. Although that would also be an issue
> > > which is solved by this fix.
> >
> > I use Ubuntu where /bin/sh is dash so my current guess is that dash
> > might have a smaller recursion limit than bash.
> >
> > I just found https://stackoverflow.com/questions/69493528/git-subtree-m=
aximum-function-recursion-depth
> > which seems to agree.
> >
> > I will try to test using bash soon.
>
> Sorry, to not have tried earlier before with bash.
>
> Now I have tried it and yeah it works fine with you patch, while
> without it the last step of the reproduction recipe takes a lot of
> time and results in a core dump:
>
> /home/christian/libexec/git-core/git-subtree: line 924: 857920 Done
>                 eval "$grl"
>     857921 Segmentation fault      (core dumped) | while read rev parents=
; do
>    process_split_commit "$rev" "$parents";
> done
>
> So overall I think your patch is great! Thanks!
