Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77F1FBEA8
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766859751; cv=none; b=hV8UVkut7yMOhHXYOYWITFLDC446lG+F0CcbwJt98LObs14uFxoYFROAUjPZAHpKWQjdC/CL4JCjKU0j/QNROgQuNwPpUCRxjbp6fzg3+QpjWqB5xn5K8jFvKbtmSlqFj1DcqiXwqlncNTu29ZtQLGyAPhnYAYshIqLrheDYU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766859751; c=relaxed/simple;
	bh=RXmTBQZ73UV9jlf9jZtLcwJxyrCrfJFZ2v4I7Fxpbf8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=e3QhmjStC81E9L36I9HNNNjL02f0j32HQh+SCAO/GmnpIRVfnfIzU8FS/9AY9QQlDqRRyLhS7ZDqzV61Ods/G4A9xgX2JtY0jfOH2k0nmWUBA4DaaI2HUKY23xEhcaRdw56cZdjUJO2ArsPx+cwRHlgPHWqxWTV5ouEbmHuDY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHUa+Ghh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHUa+Ghh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8887f43b224so119527516d6.1
        for <git@vger.kernel.org>; Sat, 27 Dec 2025 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766859748; x=1767464548; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEAZC2RPwhmFLP4RFDUltwPjhYePUjG2CQFisiqcjHI=;
        b=lHUa+GhhpZWk5jyGMYGGPHpGi78u47fdvSbnq61//F2tc+p9CUFUGam+phTlIlNjRG
         Y0d3H+p3y/Ayv2IIvHnFf4ZSoQ1Yst+RgvopWpXYFStxakHhD/6f3994ZabhZKJBqQto
         4tLhGfnqSRmBGulpbKnngJlcdbrOePQ3QPB+ZOwU5eLHDyQRD4Hayc30ohIOdjjW/c//
         fJfz4yDHFDjhqjpriOXS4l+Rm2A+etGavm64nt1Dw7pbmrhemml3C7w4UmFU/COPPX1k
         Qx7qBA2Ciu+BQzNo6ug8tuhoelhXO9wz00oxX/L3TlpYkBPHj94NJ6Wg4LkE2ajVCeyH
         ieAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766859748; x=1767464548;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEAZC2RPwhmFLP4RFDUltwPjhYePUjG2CQFisiqcjHI=;
        b=sZz5iGbukoxhIQXEPHcQgQqf3aKULCz2f/IH2oJxJ2C/XcuI+sa2UClffl9JoqMmXR
         fZBKGjV1vAnj2XA0Xun4LrUTavPW3k4ca+pQvKv2o+Rf44A63qhaBa0mpOwgc7WkAlTZ
         aO7kHPKVQgTkbVWVB+/uQ3f9mx2NVrosF/25FtjoSmhC06IQzfd9aJo7jN/MH3eV+58X
         oGPQGqat0/Brq8DgeSRPnm1Kz8kLjFjG8ZwQPKOcZ41aZqwyNOZfJLlkB5CGEKi/M9hY
         IIlKghc20tfhogknqVUYRJEjNGBLZEl1G8SWAO5Bd7fUiEgfxbnDEo4u5qlO74uAOzQ8
         HRpw==
X-Gm-Message-State: AOJu0YyUxkfB6Hnrc6L7DqV52bwE4b8GuEV+aKcz0C4BuY0eZUQ3DI7l
	KpnYYsMNmIlRlZAM0c/QOBEqrl/oy3M3waK1HDosZlYLFaCRBrVt4Nsi
X-Gm-Gg: AY/fxX6YinczoYo2zXIlPJRZ7gjtlyxjwLHEhf7uD7CSFft5RnimfrbRHI3XHiLGfsv
	m6sOXoxRATjYUbRGTzJhyxp/Y4N7RpQEd+Y/4Np3oZbijNUfW94aIfZQUX83W9FOqrUTPR3kS6L
	aHFEsfm2Shy+nhH2lderB+7iat26llsw8PZvtRuHXr4WKHMVqa5bYMeUgcLmUIaz7k+ZCt8AyNQ
	dQZMdRLpDcuONcJMAV3bjl0A8dmPA9rPzZ+0D1WLoWCcr17NjZ1E9VxIFztpGcvVpneyauwL52z
	fOFuVpX/ja93g43s8ibmMigIynoWX9wZnvjtyu6AHZvVCqc/Vi49OMbWvMxeQ32B7RyZGcNWKbr
	C2kDq6PQ4EzIrv3mmimr0GQDcIPM5MYiiwVn1iS+K0mc2ZLU+sMsz3DgZO1n/7drpGho7uIOBWg
	jQKBInGE93Aj4u+qwMzyZKaVVsp459ijpa8OOh99iVBOv1Hp8rFg==
X-Google-Smtp-Source: AGHT+IEXkFc5qpDGTI1tTicKJ/xv7rHvt7VqQzYAEXEkk7y7B41Vfw3q48EHaArovnyehDDqfGhmxQ==
X-Received: by 2002:a05:6214:610c:b0:88a:30aa:6c01 with SMTP id 6a1803df08f44-88d843346a7mr321908676d6.57.1766859748348;
        Sat, 27 Dec 2025 10:22:28 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b091:b14f:8cf2:abef:79d4:3f78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a83f6f3sm195063976d6.55.2025.12.27.10.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:22:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Metadata for merge conflicts during rebase (to aid rustc) and potential for better user experience?
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <CAHnEOG29C1fRBZtpEkebat8znMst7D1JiWdqDAVJQceYqMZGkA@mail.gmail.com>
Cc: git@vger.kernel.org
Date: Sat, 27 Dec 2025 13:22:17 -0500
Message-Id: <C9EB355F-1CDF-4ACA-8EDF-498B457E85C9@gmail.com>
References: <CAHnEOG29C1fRBZtpEkebat8znMst7D1JiWdqDAVJQceYqMZGkA@mail.gmail.com>
To: =?utf-8?Q?Esteban_K=C3=BCber?= <esteban@kuber.com.ar>
X-Mailer: iPhone Mail (21F90)


> Le 24 d=C3=A9c. 2025 =C3=A0 10:03, Esteban K=C3=BCber <esteban@kuber.com.a=
r> a =C3=A9crit :
>=20
> =EF=BB=BFOn Mon, Dec 22, 2025 at 1:56=E2=80=AFPM D. Ben Knoble <ben.knoble=
@gmail.com> wrote:
>>> On Mon, Dec 22, 2025 at 9:31=E2=80=AFAM Esteban K=C3=BCber <esteban@kube=
r.com.ar> wrote:
>>> The questions I have are:
>>> - can I *avoid* `--points-at` in any way to identify what branch we're
>>>  rebasing onto?
>> According to "git help rebase", ORIG_HEAD is not reliable but @{1} should=
 be.
>=20
> After talking with other members of the compiler team, people have
> concerns about invoking git from the compiler, as it can be a vector
> for unwanted behavior. I would agree with that assessment, so I am
> trying to settle on a mechanism where I can parse git state myself
> (on a best-effort basis; this is only for diagnostics, so fully
> featured support for all environments is not necessary).
>=20
>>> - is there already a better way to identify if the rebase was triggered b=
y
>>>  `git rebase` or `git pull` (configured to rebase)?
>> I haven't studied the internals on this yet, but I think the common
>> pattern is to look at REBASE_HEAD vs. MERGE_HEAD.
>=20
> Thank you for the additional information! That prompted me to look
> into the rest of the files once more, which gave me some hacky ideas
> on how to get the data I want, and this indeed seems to be
> sufficient to differentiate these two.

I think you will have issues with the reftables backend, then, which stores r=
eferences differently (and is _probably_ simpler to access via git, though t=
his might motivate contributing support to libgit2; this was also mentioned r=
ecently in Discord).

>=20
>>> - if neither of the above has a "yes" answer, would git consider *adding=
*
>>>  that information, both for third-parties as well as to extend its own U=
I?
>> I think "git status" already shows some of this (maybe not the
>> branches in question, but certainly the "it looks like you're in the
>> middle of a rebase/merge/cherry-pick/etc.").
>=20
> I looked around again and arrived to the following conclusions:
>=20
> - presence of .git/rebase-merge (and its files) is enough to
>  differentiate between a rebase and a merge
> - .git/rebase-merge/head-name is enough to identify one of the sections
> - identifying *at least* one of the sections is enough to make the
>  output clear enough (even if ideally you'd identify both)
> - the sha in FETCH_HEAD matching .git/rebase-merge/onto is enough
>  to identify that we're dealing with a `git rebase --rebase`
> - there's information that is only present in MERGE_MSG in
>  free-form text, that isn't present anywhere else
> - I can extract the "missing" information for either the
>  identifying information of where we are merging, be it because of
>  a `git pull --no-rebase` or `git merge`; the only issue I see is
>  in having to rely that the output will not change from either of
>  "Merge branch 'main' into branch-name" and
>  "Merge branch 'main' of example.url:user/repo" (how much trouble
>  am I inviting if I were to try and rely on this text not changing
>  so that I can get 'main' and the remote url from here?)

I think you can also get just remote names here, and I=E2=80=99m not sure ho=
w to define remote URL when I think there=E2=80=99s support for multiple URL=
s for a single remote, so it would be a lot of best-effort work IMO. Not tha=
t it isn=E2=80=99t worth it, but you=E2=80=99d want to decide what is worth p=
utting the effort into.

>=20
> With this, I'm successfully able to identify at least one of the
> sections in the patches in all cases, which is "good enough" for my
> use-case, and with some hacks I can identify both for all but the
> `git rebase` case, without having to invoke git.
>=20
> Beyond hearing from any warnings about me relying on the textual
> format of MERGE_MSG or mistakes on the assumptions laid above, I
> would like to suggest two changes to git that I think would be
> beneficial to devs and users.
>=20
> First, the information present in MERGE_MSG should be available in a
> more structured format, to allow for tools to deal with git state in
> a less coupled way. (This might not be worth it, and the textual
> representation is already "stable enough" to rely on.)

I think specifying what information is valuable here would help inform a con=
crete proposal. My first thought is that it could be added to {human,machine=
}-readable git status, but that=E2=80=99s less accessible to programs that d=
on=E2=80=99t want to invoke Git.

>=20
> Secondly, and perhaps more importantly, when generating the diff
> markers that end up in the user files, their description includes
> only the full sha or HEAD, or the short-sha and the commit message.
> I would propose that the branch be identified as well in the
> generated code.  This could look something like:
>=20
> `git rebase`:
> <<<<<<< HEAD [branch 'main']
> =3D=3D=3D=3D=3D=3D=3D
>>>>>>>> e644375 (commit message) [branch 'name']
>=20
> `git merge`:
> <<<<<<< HEAD [branch 'name']
> =3D=3D=3D=3D=3D=3D=3D
> ------- between this marker and `>>>>>>>` is the code from branch 'master'=

>   println!("Hello, main!");
>>>>>>>> [branch 'main']
>=20
> `git pull --rebase`:
> <<<<<<< HEAD [local branch 'main']
> =3D=3D=3D=3D=3D=3D=3D
>>>>>>>> 8191e7e4f9f82be45bdd4e71c37d2adcf4f88aa2 [branch 'main' of example.=
tld:user/repo]
>=20
> `git pull --no-rebase`:
> <<<<<<< HEAD [branch 'main' of example.tld:user/repo]
> =3D=3D=3D=3D=3D=3D=3D
>>>>>>>> ebbeec7 (commit message) [local branch 'main']
>=20
> The format doesn't have to match the above exactly, but having the
> commit *and branch* information will make it much easier for people
> to identify things at a glance, at the cost of some additional
> verbosity in the generated code.

I suppose if no branch was used in the original operation, we could omit it.=


I would probably say =E2=80=9Cfrom branch X,=E2=80=9D since in a typical reb=
ase only the very last commit is actually pointed at directly by the branch.=


> The source of the issue is that where "our" and "their" code is in
> the patch depends on a somewhat "arbitrary" distinction (as far as
> a non-implementer is concerned) and it *swaps places* depending on
> whether we are rebasing or merging. Adding some context to the
> resulting patches would go a long way of mitigating the confusion
> this causes.
>=20
> Happy holidays,
> Esteban K=C3=BCber

I can=E2=80=99t seem to puzzle it out, but it seems like perhaps you=E2=80=99=
d have a better solution than optionally sprinkling branch names if we addre=
ssed (somehow) this other issue about location of code? Idk.

Of course you won=E2=80=99t be able to assume =E2=80=9Cmain=E2=80=9D is alwa=
ys the effective =E2=80=9Cours=E2=80=9D ;) so maybe I=E2=80=99m confused abo=
ut how those 2 things play together.=20=
