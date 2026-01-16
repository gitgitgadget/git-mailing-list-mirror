Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3426E165
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577726; cv=none; b=Gd4uBpAOAMTQv5xk7aESQ8+82xdzAMJzcdt28xYYWo2XfXHlROTC5/m4jxRNEpSSXQ+FsTWIB9kGD8LtCjVhVl4QNFogIiNEGuNdZg+plDFqCGOm9b4hzpG3hufyXTus1BtDz+Apuy2SEjLc09BN9k6xm+8LuQ7qno2xN0uqlqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577726; c=relaxed/simple;
	bh=/OIasDVUvja275NIytNm5lXlPVWrr+Wpyb2odX79E+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfLeG1U7yH+Xn3hd1eGqurNSe1WGCN7/RPcVjZBi2jihttkEKDymBzlPKSRaFVFU0ZGQAo0W2OT1DKbtyGvu6REwsqAb7biKFs0Px9wZRPfnCRa2EXHV1IymhcNttTfa851/1FV8NSJHbZ5zKHET/7K7MCS9TZY3SnfVKsBVasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=f89eREOV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="f89eREOV"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-655af782859so1511467a12.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1768577721; x=1769182521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVDEP/bDJrk4FIshIkfSewAKfwZQS2ZhOlZR7Kmp+Ug=;
        b=f89eREOVV+H6Zu68jxjtE7i+KyWQIIlKU588a63q+sLIQmR186yCycwBMk4MCG37UL
         xH/B80ArOBnfiOIp4iPE1347GOMFnifrm5Dna3/BMZmJlJSiW5ReN61uiiUo65QSAo7H
         iJKVLc3hY2aJAwUiQPd9dqBoGsThlM+rhWSliJ44O5SkS1JkTJPIJM++1Rt2UfM6Q+46
         HTUyhnBiAqsV/xzORQiRr/pMhrR7o8JHOhh8KAiV5sboDvb9/2X0UNSSayLlGw7x927l
         VgaTrcLydD2AFTfpFQ80YLD99Gttkjnk887tiSdoAjgv+cP1C2lJ3O8qI2JBDMWSfK3P
         4nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768577721; x=1769182521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVDEP/bDJrk4FIshIkfSewAKfwZQS2ZhOlZR7Kmp+Ug=;
        b=lO+fethjMwajH44akOoBp3jcwaS9iPOlPvp+dql/KcgYcIxocLyoHoRDqpqzepBCMS
         REmAtmQ9CxjTxl4ov4OvgfOKOtTltVT5M5HE/w60k403KULxTXzX74SaQ9GU9OcVWQgh
         7cZulcuZmE3LbL8fwmdj8PLIUn00t/ihCVHb0O2vb8SLW2y9g0AIKuN0daHB62OfrEpf
         JNODL1RRZcgcAZCn0wW+QYuZTe1Ilb41RXgf39rjdvxlRZyw2GX7U+745/GYko8vPHnm
         Fho+s4+EVkZiXqO94OJexm2L7gCIYO5rs7+CU1T1dEpt4BNY9tdR69sUMk00t/P0DEb7
         CW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCcWbwLcKyLyOKINerH8P5zO4ZOjbVvT89yiSzT3+Snu4ehSXTuPp2EmYfHT3e9SMZ0YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJcxuwCy4Xk6+SuAfLfufSl/BQ9H8i1rUP4UCoVTF+Q5MKY9L
	xY9VOyVSl9bv45hmpmTTGCxNo+pV16JyFw0Nlo5Qq6lzBhQ3GG3r80Pxo4EJ2Rjeqrz6cygRFK3
	SsCN5cy3u2VQALq20Qwlww3KelXb8B7oBbveNLRJv
X-Gm-Gg: AY/fxX6c+pr9RasSraqMaeLK6gs8vqxrQQjYVa9hex6p0RsDqXdjPFzdbXExTeJYyNO
	iN5qLdwJWxSdAxK0W5ojNzNdZmAblFolBvRJbxZFwqO88VVzb/xOHIaU5pndC61ZElLOrPKsMC0
	IMbtL+VqhP8qNq00Sq/8tMnjSLmrSxDMEOuwlHN4zEnLkm7Y7hxTNxy/xlAAJO7sMHrhxj+tQCz
	TS6xAk5BTR8c+05V3psDXBf6R0ikB2TMWC1mzEETtIlwNJ65n/oyH75ezigURTEkNw=
X-Received: by 2002:a05:6402:27cd:b0:64b:83cb:d93e with SMTP id
 4fb4d7f45d1cf-65452acb45dmr2463136a12.20.1768577720925; Fri, 16 Jan 2026
 07:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fe7956e089394bb1d75f4c8af4a3347b204803.1768376879.git.gitgitgadget@gmail.com>
 <B94F0800-06B5-47BC-8C22-AAE1882E5B9C@gmail.com>
In-Reply-To: <B94F0800-06B5-47BC-8C22-AAE1882E5B9C@gmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Fri, 16 Jan 2026 16:35:10 +0100
X-Gm-Features: AZwV_QjJKqLOyYwbqjQEJ8ynBEPbAB1XWjGkslwONhqV7xx3BZA9OYFqE16LtkA
Message-ID: <CA+GP4bqY02wcESuz1vPMcknigx_fUXFfi_xQ1EG_muGw6EszRg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] Documentation: update add --force option +
 ignore=all config
To: Ben Knoble <ben.knoble@gmail.com>
Cc: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Brandon Williams <bwilliams.eng@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for feedback. Noted and will be fixed as this:

...
When set to "all" will never consider the submodule modified. It can
nevertheless be staged using the option --force and it will then show up
in the output of status.
When set to "dirty" will ignore all changes to the submodule's work tree an=
d
takes only differences between the HEAD of the submodule and the commit
recorded in the superproject into account. "untracked" will additionally
let submodules with modified tracked files in their work tree show up.
When set to "none"(default) It also show submodules as changed if they have
untracked files in their work tree.
..
// Claus

On Wed, Jan 14, 2026 at 6:53=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> > Le 14 janv. 2026 =C3=A0 02:48, Claus Schneider(Eficode) via GitGitGadge=
t <gitgitgadget@gmail.com> a =C3=A9crit :
> >
> > =EF=BB=BFFrom: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
> >
> > - git-add.adoc: Update the --force documentation for submodule behaviou=
r
> >  to be added even the given configuration ignore=3Dall.
> > - gitmodules.adoc and config/submodule.adoc: The submodule config
> >  ignore=3Dall now need --force in order to update the index.
> >
> > Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> > ---
> > Documentation/config/submodule.adoc | 13 +++++++------
> > Documentation/git-add.adoc          |  5 ++++-
> > Documentation/gitmodules.adoc       |  5 ++++-
> > 3 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/config/submodule.adoc b/Documentation/config=
/submodule.adoc
> > index 0672d99117..250a6133d8 100644
> > --- a/Documentation/config/submodule.adoc
> > +++ b/Documentation/config/submodule.adoc
> > @@ -32,15 +32,16 @@ submodule.<name>.fetchRecurseSubmodules::
> >
> > submodule.<name>.ignore::
> >    Defines under what circumstances "git status" and the diff family sh=
ow
> > -    a submodule as modified. When set to "all", it will never be consi=
dered
> > -    modified (but it will nonetheless show up in the output of status =
and
> > -    commit when it has been staged), "dirty" will ignore all changes
> > -    to the submodule's work tree and
> > +    a submodule as modified.
> > +    Set to "all" will never consider the
>
> Throughout this patch, missing =E2=80=9CWhen set to=E2=80=A6=E2=80=9D for=
 idiomatic English.
>
> > submodule modified. It can
> > +    nevertheless be staged using the option --force and it will then s=
how up
> > +    in the output of status.
> > +    Set to "dirty" will ignore all changes to the submodule's work tre=
e and
> >    takes only differences between the HEAD of the submodule and the com=
mit
> >    recorded in the superproject into account. "untracked" will addition=
ally
> >    let submodules with modified tracked files in their work tree show u=
p.
> > -    Using "none" (the default when this option is not set) also shows
> > -    submodules that have untracked files in their work tree as changed=
.
> > +    Set to "none"(default) It is also shows submodules that have untra=
cked
> > +    files in their work tree as changed.
> >    This setting overrides any setting made in .gitmodules for this subm=
odule,
> >    both settings can be overridden on the command line by using the
> >    "--ignore-submodules" option. The 'git submodule' commands are not
> > diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> > index 6192daeb03..941135dc63 100644
> > --- a/Documentation/git-add.adoc
> > +++ b/Documentation/git-add.adoc
> > @@ -75,7 +75,10 @@ in linkgit:gitglossary[7].
> >
> > `-f`::
> > `--force`::
> > -    Allow adding otherwise ignored files.
> > +    Allow adding otherwise ignored files. The option is also used when
> > +    `submodule.<name>.ignore=3Dall` is set, but you want to stage an
> > +    update of the submodule. The `path` to the submodule must be expli=
citly
> > +    specified.
> >
> > `--sparse`::
> >    Allow updating index entries outside of the sparse-checkout cone.
> > diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.a=
doc
> > index d9bec8b187..3792da96aa 100644
> > --- a/Documentation/gitmodules.adoc
> > +++ b/Documentation/gitmodules.adoc
> > @@ -70,7 +70,10 @@ submodule.<name>.ignore::
> > --
> >    all;; The submodule will never be considered modified (but will
> >        nonetheless show up in the output of status and commit when it h=
as
> > -        been staged).
> > +        been staged). Add `(new commits)` can be overruled using the
> > +        `git add --force <submodule.path>`.
> > +        The setting affects `status`, `update-index`, `diff` and `log`=
(due
> > +        to underlaying `diff`).
> >
> >    dirty;; All changes to the submodule's work tree will be ignored, on=
ly
> >        committed differences between the `HEAD` of the submodule and it=
s
> > --
> > gitgitgadget
> >
