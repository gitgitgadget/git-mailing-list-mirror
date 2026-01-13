Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13D2D9EDB
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321252; cv=none; b=jmHC9+hq12IfivwHVLY0yys+gHM4z3tAoZuS4bguaXJ2IIe1tTW4zztB64gOmiFM3zZqoUZzO07oXZtH7XYLKcgbWUYl+C3y4idPiVFbGCmvz0la5SBHb5sdAsRhrskQZJuulFp0KaxRp7KfF5Jf3i0W9Eaq7sHcG3oKlnbLPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321252; c=relaxed/simple;
	bh=zFSatW3fAfth5ScddsQWG2kE4C+oHWP5NNcg+gutlS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7pzVEwodpd+zti90eCTyvJP45gnhMeMZ6tqg4jVTTbMnRAqS4E/pFCGN4RegvrPpUXHkLMLMKOH1x9rm0dgO0dH2jjznxHxYYUM4z1QCeW3jIs1pDnvQYF4iB+2IFSPVDoz23mHgi8gV9jvm6jhwiKpFlvPgBSPlOmBjmCzys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgOwHS6A; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgOwHS6A"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7939e7b648aso469597b3.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768321249; x=1768926049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFSatW3fAfth5ScddsQWG2kE4C+oHWP5NNcg+gutlS0=;
        b=KgOwHS6AQzLdvazThirL3b5+A2ux55GupnzAV4FL7Gnhe/N3uEmM2XdxB25jLywre5
         4y4ccMWR7GIsioqegLB50o389mUnM28DmHp2jh5KmmrMi1psd9sVuCwW9vbeqGW0GKKE
         nctcqX+0c25Mp0StxeU+UaPEsSnv581fLld/0Y9BaauL68t93bgFjJwoLG9dGwgCNd7O
         3PhGM0/2Knk3spN3j4Pp2Vqo7IDC2R512dMRndJEFGdoRcAyt60eH4/JNOuszxa2i/i/
         kO1Fs317Ru4XifS0XyJkrlD+cSAdFJkTu/OQKfWOV48AjYqLNMaUE1+tUNxX26gARCiv
         g9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321249; x=1768926049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFSatW3fAfth5ScddsQWG2kE4C+oHWP5NNcg+gutlS0=;
        b=Sk7ku8iHfrS8lfuL1hQ8eZKlgO5235un1Zb9lK/5TocFmjOI/wDAvtikBsHS5m3KnB
         C6L9S8CGrzf+a1tWFF8Tw1uhKfAnBdx9psPoo77c3JKlVOOvgfPG2hhh1qiqu72vT1o6
         003b/EhU+2VyQ28flFJcBAMMkBNb7m40G1IQIOo19kgleq6fB475Q3DVaLYRohpJgAwA
         1hcfTyNjJZvZGWHabqVr+fUgFo2Ydp3ftaL3xWaYBd18U8ANPTcGp58iPfEULRhux2aU
         6nCq55/214hbDEWEzofty7I9zVM09aIZeWcg3KQ4HoBsnWD3Np/0GkEx+q9aE0oNQlzL
         WPpg==
X-Forwarded-Encrypted: i=1; AJvYcCUYP1044auW6AmJmwmrk5RGwZWXUwguK5Bd5UC6DtQp6szGGf9I6BfUb6Nc+zDvqe9PT+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUhaCQHDmzCvw1Xklhyk0Yb99/q0c3KefMT/fdGEyegYQFeyV
	JfdaRHvws3fYZdo/cVmZ+el4k06FbAuCCR/ay3c9lJVDCXjU/UHIbdqjYFtdWPjtcSnghP9qjMI
	+jZGYMMMp5tpaMm5g84zrGmGWr4MrgJYMG5wMGNQ=
X-Gm-Gg: AY/fxX58ySrRNt62RrkSqlaeZuAz4HdRC7EMAsVPkGUR24GfHcGS+/++xPEHjj4CbY6
	FK+HT0QxdsmXskB98cCVCzpIEMmZiF88WuKuLzax8uME+blYb+t4Yb6kvrjFr5tCQsJ7lTv/Jde
	mBnU9lgkpUVWtwCC2WKArndiOrK827iB+RwIO7KawwSdpFqcoXx6h9ewNZw7qZCDD0W4yiTro7l
	gPmm9hDVsB5Yu1lIaF9gAinQrg1EvaRUSyyrwOdnsytW2Qmylzaih6lbG4SvXE/pzTO++Q=
X-Google-Smtp-Source: AGHT+IEPVB0erUNSoV8zIfI4E+pFTRvYgYTvt5MUNUi98FZssxWz1hgkmiIMV5FzVmc25Kwac2a6dBAdX53ttfxvb8g=
X-Received: by 2002:a05:690e:4187:b0:63f:c0ce:f158 with SMTP id
 956f58d0204a3-64716b8dc86mr18525907d50.30.1768321249472; Tue, 13 Jan 2026
 08:20:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2733434-f632-4be5-a9e0-28412b4043c4@igalia.com> <018701dc84a4$39555970$ac000c50$@nexbridge.com>
In-Reply-To: <018701dc84a4$39555970$ac000c50$@nexbridge.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 13 Jan 2026 21:50:38 +0530
X-Gm-Features: AZwV_QhUDKlqK1UzeGiZrRHW21NzKQqMrqDHytak3JWmNZjssppSZgr37cUB6UQ
Message-ID: <CALE2CrSUFt_HGy1+9H08OMZLTjdZt=NZsqvqa1a-rbvDOzjVWw@mail.gmail.com>
Subject: Re: git shortlog --committer vs --committer=<pattern>
To: rsbecker@nexbridge.com
Cc: Manuel Rego Casasnovas <rego@igalia.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks for the clarification.

I confirmed that this comes from git-shortlog pulling in
Documentation/rev-list-options.adoc, which documents
--author=3D<pattern> and --committer=3D<pattern>, even though
git shortlog treats --committer as an alias for --group=3Dcommitter
and therefore cannot accept a value.

So this looks like a documentation mismatch rather than just
the website.

I will prepare a documentation patch to make git-shortlog=E2=80=99s
options unambiguous.

Thanks,
Pushkar

On Tue, Jan 13, 2026 at 9:28=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On January 13, 2026 10:23 AM, Manuel Rego Casasnovas wrote:
> >Doing something like this in a Git repository returns an error (git vers=
ion 2.51.0):
> >$ git shortlog --committer=3Dfoo
> >error: option `committer' takes no value
> >
> >However the option "--committer=3D<pattern>" is in the documentation:
> >https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt---
> >committerpattern
> >
> >But it seems to be in conflict with "--committer":
> >https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt---
> >committer
> >
> >It would be nice to either allow using "--committer=3D<pattern>" for sho=
rtlog, or if
> >that's not possible fix the documentation.
>
> I do not see --committer=3D<pattern>, but do see --committer pattern in t=
he online
> help and documentation. --committer is an alias for --group=3Dcommitter.
> Pattern applies to the log entries.
>
>
