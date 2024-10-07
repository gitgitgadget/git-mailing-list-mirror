Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738361BC5C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285957; cv=none; b=VDNhB/l939p9LSjUfUdlgyyOKH8We8lACaqnuArEQDq3xT9dr3Un6hvfmuYHOE7HEWfhNYSDC47bUslOM8Daa7+dkHRpgyvnPG8V58y8D+DGX0LCCeeo5rJd3ogWM6qwV6jgg8ORTYH7dTrp8FMhfeBIeuXQbelsjtFDCSRkXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285957; c=relaxed/simple;
	bh=XuZzVwN2ps00AKVLoMG7SaqDqp0k12Ls4NziToicmeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2ix+fiORt/j/19TVNxSC0NIhiXXjpdz4EhgfT3BWxbt0J1Xad2RPlHrDuk/fmc+ZVN6LQ/PjYJkru3Oqo0p/CSkvt6nwz5a331pFiTKtdW2mmi/G0uNJzO/scAg5QsQ1D6uahF+iFoUB0uOcduvrTOMuZlAtYQ8dYunaZuPHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSkFf1qA; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSkFf1qA"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84e9dda8266so875600241.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728285955; x=1728890755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz6XUC4WlwM7pS+hXhDgoSOQ3QwmzNPkIyGeVehV5ck=;
        b=eSkFf1qAunz1niOx2jx1m0jgBQD4Bk80Gt2k9eCdeanknC/NNZBiE9/7XMhLsY6yxp
         2LE4PKzGEAMx7OYRsOHyeTrdzMggkmZ8z3z4i7Llj52qtldjDg9HwJfVNvTnkTuM050T
         s4ghc0xKHLJvP/SOx7zjuEatzg/s4VuiRG1XEwNYsU079Q6Ja99ShKHVZJCuVH1qgOIx
         YboiKD1mc7UrsbvhuZMwezzikDipk56PsFjGHqSQp+lneSCmImUOQ7R3Wf4JNKXZvjpL
         uwKMY2B3KFK4RwFisG1Xota2YW0kU3Kb8TWrVUaSBIwhcMlQGO3cB/mLUdSkOId6kRsm
         oBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728285955; x=1728890755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz6XUC4WlwM7pS+hXhDgoSOQ3QwmzNPkIyGeVehV5ck=;
        b=poaxrl7nURXs/+NYzhptm/xLqolWIY1JR5CFw79jRzmDmk5nRrEfIKSDNBG3jJ1mHL
         c1ExbMOrGRieteIW69nkmQxetQc5oRquTshumQdCPJH0l0HqcmOiG5oZGsGQyYE421wb
         E78OabCRPjwyg83Udoftn5voOZg73BsmExl6Vt2l8goMPGt7vuFvxkY1QZn7AbswaVo1
         BoapWNWmkccQuKQBZC/8np+4A385//4O1ToNac53idilrsCgnQZNLqsexy6pdBT2RWkC
         HHFBvj65BRXHIYPK0u+cDc5ywFHy0tnl+Egs8gDoKnIovIqZGeH9pkSumLEf1V6JkUnj
         J/mg==
X-Forwarded-Encrypted: i=1; AJvYcCWmvf9M2rmJ3NGGKgO9PTwnhKjHvNrTLOLwSy6rzq1r8lesfHvN7BNEb2uvrVjp91GvMGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqpfRgiD8eNet2bhs8kVjKbHOMveA2X1ZIHQnsnNGrMprcLfk
	2TeRaoxNv+wQ9LMF9GsvFJn2elqUE/SBzVx7Z2xE7LM4uISPKB6qI2Kuz2PIvaY6pGFFW3G5+iK
	jtp7lzBFHwBqqSDQHMcT6OjdFeSM=
X-Google-Smtp-Source: AGHT+IGvMZyaPLqjXpKzgo812w+c0vPSIoYjcnXI84BNT6tPR/qg0PZ/Ej/ofhQHDBYtynPO68AEabokuqvrM5oJo+w=
X-Received: by 2002:a05:6102:510e:b0:498:f38a:2c8b with SMTP id
 ada2fe7eead31-4a405901affmr7860055137.25.1728285955236; Mon, 07 Oct 2024
 00:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <CAPSxiM9eExGxy5biEr_23tCKXaUQg=tsD57VR7e2SVdvVJR+Kg@mail.gmail.com>
 <CAPig+cQ1xC9ky8+NZO0ywmYAa6Vxe2ZUbs_Ae4OTTcWM8tHY_Q@mail.gmail.com>
In-Reply-To: <CAPig+cQ1xC9ky8+NZO0ywmYAa6Vxe2ZUbs_Ae4OTTcWM8tHY_Q@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 07:25:44 +0000
Message-ID: <CAPSxiM9Z3q5Oz0PkadC72J0cU2F9D8Rh5eAtNz7aZoUZxp6PUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:24=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Sun, Oct 6, 2024 at 12:18=E2=80=AFPM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> > Kindly, help take a look if this is okay now.
> >
> > Also, I wanted to change this also to use test_line_count,
> >  test 0 =3D $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
> >
> >  But, I tried a different approach and the test kept failing.
> >
> > Similar as
> >
> > git show >output &&
> > count=3D$(grep NEVER output | wc -l) &&
> > test 0 =3D $count &&
>
> What is the actual error you encountered?
>
> By the way, we have a handy function, test_must_be_empty(), which can
> be used if you expect the output to not contain anything. As an
> example:
>
>     git show >output &&
>     grep NEVER output >actual &&
>     test_must_be_empty actual

Thanks for your review, I really appreciate it. I tried this approach,
but I was getting this particular error for the testing.

not ok 32 - multi-fixup does not fire up editor
#
# git checkout -b multi-fixup E &&
# base=3D$(git rev-parse HEAD~4) &&
# (
# set_fake_editor &&
# FAKE_COMMIT_AMEND=3D"NEVER" \
# FAKE_LINES=3D"1 fixup 2 fixup 3 fixup 4" \
# git rebase -i $base
# ) &&
# test $base =3D $(git rev-parse HEAD^) &&
# git show >output &&
# grep NEVER output >actual &&
# test_must_be_empty actual &&
# git checkout @{-1} &&
# git branch -D multi-fixup
#
Below is the particular test case

test_expect_success 'multi-fixup does not fire up editor' '
git checkout -b multi-fixup E &&
base=3D$(git rev-parse HEAD~4) &&
(
set_fake_editor &&
FAKE_COMMIT_AMEND=3D"NEVER" \
FAKE_LINES=3D"1 fixup 2 fixup 3 fixup 4" \
git rebase -i $base
) &&
test $base =3D $(git rev-parse HEAD^) &&
git show >output &&
grep NEVER output >actual &&
test_must_be_empty actual &&
git checkout @{-1} &&
git branch -D multi-fixup
'
