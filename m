Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CD287516
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327309; cv=none; b=V0Fl5S/Dgw0ZOvj8snbin5tm+gJ/e06ld2RYsqdlBi5J3HC9J/36+0Opc1B0PWR8EEpSou1yOP4DCqHkUBBit51ylEQ8ts9bqKFhxgWOKSrfN2/UI//S80QovWFR4d/VOfdbuAshCao1LU2Lel6wwn1EXdScplZA3PqPovojev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327309; c=relaxed/simple;
	bh=xUaYqlsK4BW84ZWuwjcS15a9U8461rg9mP/R0PhEHWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ9QGT3VQB5kzfTyCue4gabmZmm0Pz6u41ba66awiiKY4MZZjRnzU+6k9TKJQc9x409l7kWVLw1lYRvNXFHJiEIKDSqoy1gzqTkpKgsM4g6WKlRRr0W8KPLlAMQuMqIWVQymVUJoELr43yNkXrgPWCuS7rjKziBQthMYDpQhIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sh3hhaPo; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh3hhaPo"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78e7ba9fc29so82368867b3.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768327307; x=1768932107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUaYqlsK4BW84ZWuwjcS15a9U8461rg9mP/R0PhEHWo=;
        b=Sh3hhaPo8tyDtXU1c9iwXfTP1mEoid9gvrisAfabvLx3q3oE/Ytu+YVBudDSlXSdMj
         jX19AzDMb5816ghglZfzJ9BtSIs96JSOPjjjLRTlCem3c/u15hjJf1yU1Jyj0bvmPigi
         w3dsILfjc8PQImp9gtvVau/Uzar4tDY/5sMBd+LbObE8DisN66tA1iqt9Bg1MNb9VU2u
         Han+h24R/lncnHeKMRtBR0wS6n/bGybrByiDppSJ0Sna85BTxB1uNeyP9wbqkMcV7RRu
         aaRcAofq40GxbYHHb+irDRE5c9UOj064mplzcMTJx/rpLuY7HMktrEfCn79l0r9SzE3u
         I9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768327307; x=1768932107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xUaYqlsK4BW84ZWuwjcS15a9U8461rg9mP/R0PhEHWo=;
        b=XddkFK3Te3jXtywgXTK+9HZaQyuI651q0jaKQW2OBMbVYhcLb5x+Eh0NHeOdRA94s8
         uWMb+oWB+ebR87h4y2itWO3KcAeVv8pGOBPTZ/2xl0fs219xGKFPukmHFiQ3ReJhZl1E
         3GO9shFkjbk6rTRBAv57b8aQb1CqnIiASsThFA09hsIqCgpkIQ87Ct9b7OHVN9wVhXOa
         iLICLyRNrdk3haNPb/ouc7JaNWgh4wnMh5QmxDT+Vd3Q0uikHPLoL9PSQYgqgujsp4Sq
         5Ql/iIpIqRBv4YzgIOLaVU44WgiwDA1sPZHAGF1q6YtU0qBo8q6KeJiDWfzaE5uS81xP
         dJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5tfGUOIPcjeMQUBzyJY+SPp1eRaWFQqb9tD+4pppSKGG0t2rEz/33taPR9AMGVEPxoVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkn6aKNL0OaLxzllM0ZSe0r+59bc9rytVzqcckLPN2gGy0ZZiM
	Vf0U1BYEaZROWulKAuXgX0TlUFXs/kNXAn4E/WCoMPdE/YE5/3U1005N1GHZkf7jmovLP2gKPsG
	k8bIGL/2JFxsLP922ryKDk78m6Qv0kus2sCoqM79xCQ==
X-Gm-Gg: AY/fxX6LiknNOus2QqIJ6XUR4PdzqkPqA6y6XjhYHBCB+qSO0KOcvTmsjXeBvHw6Iia
	1TB6LR4w4hVZRCPzSw3P0Pymj7AtaQA1ggLG7NwWzvSeFgMLHm2C4Ufs7JnUkhu7RjsqPGSlkPq
	ejZB7Ra2YvLuMgtffFuT+J8JD4FoJG2B03Wa4GkWTJGFIayLEFHSNdyDZZOC7qlNaWpiJ5F7r9L
	ZrL+DkjtIeflfQH9JJEDM6CQZGIkbIfrxrkzRK8gPlwT7RNC9YXsE7XP1d5eIsXKzrb7lo=
X-Received: by 2002:a05:690e:1519:b0:63f:ab8d:a572 with SMTP id
 956f58d0204a3-64901a9c6e2mr82132d50.4.1768327306134; Tue, 13 Jan 2026
 10:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2733434-f632-4be5-a9e0-28412b4043c4@igalia.com>
 <018701dc84a4$39555970$ac000c50$@nexbridge.com> <CALE2CrSUFt_HGy1+9H08OMZLTjdZt=NZsqvqa1a-rbvDOzjVWw@mail.gmail.com>
In-Reply-To: <CALE2CrSUFt_HGy1+9H08OMZLTjdZt=NZsqvqa1a-rbvDOzjVWw@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 13 Jan 2026 23:31:34 +0530
X-Gm-Features: AZwV_QgqWzblb5psnYSPqKuE1FxYUhcNFZHuqurZPsZo-NkEgme8I-ulN3isBXM
Message-ID: <CALE2CrS9YAqnX8ikNYzyD_i3H1rzhFQvKLijbnbkZh7VqOSZOQ@mail.gmail.com>
Subject: Re: git shortlog --committer vs --committer=<pattern>
To: rsbecker@nexbridge.com
Cc: Manuel Rego Casasnovas <rego@igalia.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Follow up to my previous mail.

After checking the generated git-shortlog(1) and git shortlog --help, both
--committer (grouping) and --committer=3D<pattern> (commit limiting) are
indeed documented correctly.

The real issue is the option parser ambiguity that Junio described, where
--committer=3Dfoo is parsed as the grouping option and rejected, even thoug=
h
the filtering form exists.

So this is not a documentation error but a command line parsing limitation.
Thanks for the clarification.

On Tue, Jan 13, 2026 at 9:50=E2=80=AFPM Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Hi Junio,
>
> Thanks for the clarification.
>
> I confirmed that this comes from git-shortlog pulling in
> Documentation/rev-list-options.adoc, which documents
> --author=3D<pattern> and --committer=3D<pattern>, even though
> git shortlog treats --committer as an alias for --group=3Dcommitter
> and therefore cannot accept a value.
>
> So this looks like a documentation mismatch rather than just
> the website.
>
> I will prepare a documentation patch to make git-shortlog=E2=80=99s
> options unambiguous.
>
> Thanks,
> Pushkar
>
> On Tue, Jan 13, 2026 at 9:28=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >
> > On January 13, 2026 10:23 AM, Manuel Rego Casasnovas wrote:
> > >Doing something like this in a Git repository returns an error (git ve=
rsion 2.51.0):
> > >$ git shortlog --committer=3Dfoo
> > >error: option `committer' takes no value
> > >
> > >However the option "--committer=3D<pattern>" is in the documentation:
> > >https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt--=
-
> > >committerpattern
> > >
> > >But it seems to be in conflict with "--committer":
> > >https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt--=
-
> > >committer
> > >
> > >It would be nice to either allow using "--committer=3D<pattern>" for s=
hortlog, or if
> > >that's not possible fix the documentation.
> >
> > I do not see --committer=3D<pattern>, but do see --committer pattern in=
 the online
> > help and documentation. --committer is an alias for --group=3Dcommitter=
.
> > Pattern applies to the log entries.
> >
> >
