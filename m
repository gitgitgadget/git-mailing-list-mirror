Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B91779A5
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493300; cv=none; b=oS6r95P2Zl02Bf3aCldRMBS3qPwCYfbV7D617lH7SxDHlk7vpFJwnQfjzC/nrRk6594KGcDloF+U3XjBPN9ZDQ0d7EF9D8mAAiDdkcFD/InZQOhDpQGUlcFPxkH5JNmxO0mdTbLq+zGs3F/3jUp4hd4pdyB98YA2IAWZNuVkYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493300; c=relaxed/simple;
	bh=lu2mwSxWRjBR+hryAi3rbkv770SmcbyUcMnGfQvYV5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU2wJa6jOSd0B17HY7nlbOoZ6InVt6JzEqTnr+inttyJqp2RIRcqXzt0DE413h6YdpywiUUOmqGuBatExkGhw1iNY87E99b2PKoPagEopC645ouDACbAbVdflu59Ys8KOcFqKHDlbJ6AyH/wfK2AsFAhn+RzeExzjs5o5HeGwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV5eiYyy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV5eiYyy"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a868d7f92feso35904966b.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725493297; x=1726098097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjZZcu6NPcIfLkaTK5Ysf8vS6EOXzXZmgHZQrGTn+Ds=;
        b=lV5eiYyywqnckDn9F/jXTp+w8EgURZmixNwHDe/+AF6PXtQuDx4GQrxUt/Cxmx5dis
         kUqYSb/cPOaDoWAZm1h/9CKpY7ATchossH6pLKIJWKRRsQazVuWjmHbHPtYXdsbCMi6j
         A1mgeeoYqhG0AnVRF3z0Cb46tqHXeKnIKrOZqDtVogt7vDbkxGMxbnzMruPXQ/TQVKPZ
         ke74pHUnY44KLUp4XZvIHjGc4DPQTtxN2IHC91AydL4ZIKZqiizqbCl2BVjw3Gth6Rdh
         k/eTVvtXUXwXBHFQUwFcS04h0JC/v9+kUFpQCcKuWdFpogF34IYbv3OW2Vl2Q9TY+71y
         NrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725493297; x=1726098097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjZZcu6NPcIfLkaTK5Ysf8vS6EOXzXZmgHZQrGTn+Ds=;
        b=SG75vh0F/zyFCdJQ7LgCSeb2omL+VIkwpPaosPnXigBpA0tEtxK9l8jaSG1vrpXvbe
         paRht41TlEySEwi2GGO7Fyra+QlmW15K6nspxWVaw8CMnjJlFKoFSNS1X6djjR8vlHds
         RhLSQdnMCf4rGx9Matl+BKkJx9v9LlviG6CkVMAVdxWSY0w8yRN0eJ818nGIbkze1LfI
         dCRyxEPOaCKoFONLrSb1mLtmbfhIjMOBIBEv/AevwRnlHPHDiwAzqsODsX2ptSKfLibd
         s1BAsMYvrj8oKMxpXysOkD+SWBXbS0BnMXKdHFVR5qmrdFlH5U7pqvuEnolvPE9X4ck1
         cRJA==
X-Gm-Message-State: AOJu0YwxOuY+rWFw+PGaD9RW+vplt6xwoJX3vTLTSF9Z3SXBzZ0/eckf
	HmqhpS49wfWW8urD2nILrydBO7HEkYJhtLuP/3UTEofA+6d+MYJhZpJb5OUC09elLuHcDHCD7YX
	WNuMMIP48slf4izbdTqBB8IPTNBc=
X-Google-Smtp-Source: AGHT+IHpsI3uQFDu9n8EnfKdIIKX6hJ3NovbfbSsyuCuEYMnOPCuYpkXmYI3YOagxEqAInZLLYUClZsCOxz8WSLRqcY=
X-Received: by 2002:a17:907:f197:b0:a8a:3f78:7b71 with SMTP id
 a640c23a62f3a-a8a3f79dc17mr290181066b.37.1725493297026; Wed, 04 Sep 2024
 16:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
 <xmqqle07ebcj.fsf@gitster.g>
In-Reply-To: <xmqqle07ebcj.fsf@gitster.g>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Thu, 5 Sep 2024 11:41:26 +1200
Message-ID: <CANrWfmQXVpbZpSKjhq-2Mfbr1G0gbom+mBPgoFMxfjJKLEe5gw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=60git_fetch_=2D=2Drefmap=3D=3Crefspec=3E=E2=80=A6_=3Crepository=3E_=3Cr?=
	=?UTF-8?Q?efspec=3E=E2=80=A6=E2=80=8B=60_providing_NON=2Dempty_=3Crefspec=3E_to_the_=2D=2Drefmap?=
	=?UTF-8?Q?_ALSO_causes_Git_to_ignore_the_configured_refspecs?=
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Junio C Hamano Thank you for the explanation!
As you said, "refmap only specifies the where the stuff is stored
locally" (what to fetch is specified by last command line arguments),
but the issue with this report is a bit complicated because it's about
whether "only refmap specifies the where the stuff is stored locally".
After I search "empty value" or "empty string" in
https://git-scm.com/docs/git-config , the most intuitive behavior of
`git fetch --refmap` (for me) is:
`git fetch <remote> <branch>...` uses `remote.<remote>.fetch`;
`git fetch --refmap=3D<refspec> --refmap=3D<refspec> <remote> <branch>...`
uses `remote.<remote>.fetch` and all the `--refmap=3D<refspec>`s;
`git fetch --refmap=3D'' --refmap=3D<refspec> --refmap=3D<refspec> <remote>
<branch>...` uses all the `--refmap=3D<refspec>`s;
I'll post an example of all of these being used at the same time to both of=
 you.

On Thu, Sep 5, 2024 at 2:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Han Jiang <jhcarl0814@gmail.com> writes:
>
> > What happened instead? (Actual behavior)
> >
> > In `git fetch --refmap=3D'+refs/heads/branch1:refs/remotes/server/branc=
h1'
> > server branch1 branch2`,
> > `remote.server.fetch=3D+refs/heads/*:refs/remotes/server/*` is replaced
> > by `--refmap=3D'+refs/heads/branch1:refs/remotes/server/branch1'`,
> > so these are what would be done:
> > branch1 -> server/branch1
>
> This is totally expected.
>
> A refspec specifies "what to fetch" and "where to store locally what
> we fetched" at the same time.  A refmap only specifies the "where
> the stuff is stored locally" part, and what to fetch is specified
> separately.  You asked branch1 and branch2 to be fetched (peek into
> the .git/FETCH_HEAD file to see both objects are fetched) from the
> command line arguments, and your refmap specified where to store
> what you got from their refs/heads/branch1.  As the refmap does not
> say anything about any other branches, they are not stored anywhere
> in your local refs/ namespace.
>
> Typically --refmap is given with a glob, but the story is the same
> there.  If you fetched refs/notes/commits from that same server with
> a refmap to map "refs/heads/*:refs/remotes/server/*", the notes commit
> is not mapped to anywhere with the refmap, so nothing will happen to
> it.
>
>
