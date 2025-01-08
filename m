Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE114A82
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736342099; cv=none; b=rToGXtHMpTimU+I66++0eHHUluwYPuVKuWusx4VPHXitNObowCS9zWaKC7WoUoFZfVGb90bVbMLLYjkQn4I5Ss0Wg1+KiaGOGT/TgF4NPKosCHI3p7JJRTl94eVFevARM6nPu/3BGjJp2yJhvKdPvqPPtKhMGyKjR9GAWy+6x6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736342099; c=relaxed/simple;
	bh=h6kRVNcQTlp0ipUzNxQW0u3Yg9oaer+G0K0H5VSVBUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZXGX5RSbjLiBpdbX/MxDWyIcZLGhct9ZT0nq6/JIebwu9+ZuJLy8xtUL5HNHBl0emsN+tIKvUCpc5J4/At4YuGFvz4ijjLNb3r8lGAybnalpjudrLq98vuRRgNtolYP+zcbPUXatQWrgo1GmpK4zxTqV7dgZmG4eLoUY+ZfjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAMcqooO; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAMcqooO"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5188c6f260cso5380759e0c.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736342097; x=1736946897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK/08OxvhsckpOTRwD7Yn8GCrXm+KWOrO2OIeXCfqPU=;
        b=CAMcqooORbnam7/jZ3l4xOsJqsW5lmDEWI/+NHys5bxrUHhW8Arj+UQG8rvM3kmXJU
         HVnRhj3iiOEkCo8Vu19XJyZJ9eFtGbLKQIkvaxqnQTXphdZf0HmcqPo3TGqgKQnULQ04
         nuWSeccmMkD6IL4KLi66EJ9v3MIo+15k8aVmvINhFotW1zbO+uAM/PEH7OtgPHUa+Lnp
         nolGMlqpzAopHej5Exx3/VqY8dvi9F6y7m+r5Rib8vA3GI7FAYz4EmluvGaNa+ohB+NL
         zDet7S503tSIIslm2SVQZxtC1NLqcIVBDB0LrUyvESIqlXR335NSaYw5KJ37jBF62g2V
         /BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736342097; x=1736946897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK/08OxvhsckpOTRwD7Yn8GCrXm+KWOrO2OIeXCfqPU=;
        b=TYeyllFnfVOVJjAAqnLqnUBX5LcZcWyJtpos+ZJBGvrLRxBFmUrX4f41LPFgshGAY1
         RbD8JDNvKu7XUbmzUa4DtKGBe3XwZ3VOZyU8v/0txTeLo9TagcouQaF6epWM4lbg0jxr
         Ef17r6f92I2KXet2KEdEAn8bvZ57zDyo20BDCLcaB4jOu2Guqz5QAW5xC1/9cufNCqfR
         rSRCnDu/apOj1cyBIUZ4y5BncmBjwXJylROBsYN/HzLBbFjBdncl8qbvgwV+zrkPLvOc
         EXcRcQYAoXqtiFS8nmrGDIGREh3DdungOoFKjqac3Fhjrc18TPCN4SJNT2ULiIm6XxNI
         ponA==
X-Gm-Message-State: AOJu0YwHrl1fpLySTK7St6RsgHESYDTuBYjGwJMa1vObvL/91x3Kzggm
	2YCyzoK1VIHj9CRuL4ZUK4Syv8PKwlkTQnls0TnkflVMKMbF9W4E+Pzad6kn9OnewoUwHiZzZwd
	yBVZTLtxV9UD8wQAbhXVfFCqm/vo=
X-Gm-Gg: ASbGnctLDg0SEE7dOUn0/w0PDdnWfTkt4z3lx3AsYlckajhV+cChzplqiMwQ8ATKJy6
	QZYEDHc4dS4l7tmYj4czwqt6+FzaoEAD+nAj8FQ==
X-Google-Smtp-Source: AGHT+IHk2YY7OhjPD0fj405oaPS3RkmPVLNlc+EdlZk2nwl6KxqpgBFo23fGCt9OLNfVVsd9nyqUNr50j9F/NRs59s4=
X-Received: by 2002:a05:6122:50b:b0:518:81aa:899b with SMTP id
 71dfb90a1353d-51c6c46b315mr1428318e0c.6.1736342097127; Wed, 08 Jan 2025
 05:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-4-usmanakinyemi202@gmail.com> <CAPig+cQJM1TOad=buG0h2-3OnxEH6SUBz23y+wYq9GeUzhMwaA@mail.gmail.com>
In-Reply-To: <CAPig+cQJM1TOad=buG0h2-3OnxEH6SUBz23y+wYq9GeUzhMwaA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Jan 2025 18:44:46 +0530
X-Gm-Features: AbW1kvYqN_E9eUutVdp8fBMIjUS0Ur-clDvxs8y-JTsC2BVSzEmA5nLppZaM4F8
Message-ID: <CAPSxiM8_08xY5JSG2tU=1hLz3M+16i_jwgMXa48mvzbeYV1x-g@mail.gmail.com>
Subject: Re: [PATCH 3/4] connect: advertise OS version
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:47=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Mon, Jan 6, 2025 at 5:37=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> > As some issues that can happen with a Git client can be operating syste=
m
> > specific, it can be useful for a server to know which OS a client is
> > using. In the same way it can be useful for a client to know which OS
> > a server is using.
> >
> > Let's introduce a new protocol (`os-version`) allowing Git clients and
> > servers to exchange operating system information. The protocol is
> > controlled by the new `transfer.advertiseOSVersion` config option.
> >
> > Add the `transfer.advertiseOSVersion` config option to address
> > privacy concerns issue. It defaults to `true` and can be changed to
> > `false`. When enabled, this option makes clients and servers send each
> > other the OS name (e.g., "Linux" or "Windows"). The information is
> > retrieved using the 'sysname' field of the `uname(2)` system call.
> >
> > However, there are differences between `uname(1)` (command-line utility=
)
> > and `uname(2)` (system call) outputs on Windows. These discrepancies
> > complicate testing on Windows platforms. For example:
> >   - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
> >   .2024-02-14.20:17.UTC.x86_64
> >   - `uname(2)` output: Windows.10.0.20348
> >
> > Until a good way to test the feature on Windows is found, the
> > transfer.advertiseOSVersion is set to false on Windows during testing.
>
> This is because the uname(2) you mention above is not actually
> system-supplied but is instead faked up Git itself for the Git for
> Windows port. See git/compat/mingw.c:uname().
>
> The typical way to work around this sort of issue is to ensure that
> you check Git against Git itself instead of checking Git against
> "system". To do so, you would implement a new "test-util" command, say
> `test-util uname`, in git/t/helpers/test-uname.c which internally
> calls the same uname() function that other parts of Git call. Doing so
> ensures consistency of output.
>
> Whether or not it makes sense to go through that extra work for this
> particular case is a different question.
Hi Eric,

Thank you for the explanation. I will look into it.
>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> > diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.s=
h
> > @@ -123,9 +123,19 @@ test_expect_success 'git receive-pack --advertise-=
refs: v1' '
> >  test_expect_success 'git upload-pack --advertise-refs: v2' '
> > +       printf "agent=3DFAKE" >agent_and_os_name &&
> > +       if test_have_prereq WINDOWS
> > +       then
> > +               # We do not use test_config here so that any tests belo=
w can reuse
> > +               # the "expect" file from this test
> > +               git config transfer.advertiseOSVersion false
>
> Should this have a comment explaining why you're disabling
> transfer.advertiseOSVersion, in particular that you found uname() on
> Windows unreliable, thus need to disable the check for this case?
>
> The comment you did compose exposes a fragility of the tests: in
> particular that subsequent tests rely upon a side-effect of this test.
> The fact that you had to include a special comment explaining the
> problem argues for a cleaner solution, such as splitting out part of
> this code into a separate test which comes before this one:
> specifically, a "setup"-type test which creates the "expect" file
> which gets reused by multiple tests.
I will work on it and update it in the next iteration.
Thank you very much.
Usman.
>
> > +       else
> > +               printf "\nos-version=3D%s\n" $(uname -s | test_redact_n=
on_printables) >>agent_and_os_name
> > +       fi &&
> > diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> > @@ -8,13 +8,23 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >  test_expect_success 'test capability advertisement' '
> > +       printf "agent=3Dgit/$(git version | cut -d" " -f3)" >agent_and_=
os_name &&
> > +       if test_have_prereq WINDOWS
> > +       then
> > +               # We do not use test_config here so that tests below wi=
ll be able to reuse
> > +               # the expect.base and expect.trailer files
> > +               git config transfer.advertiseOSVersion false
>
> Ditto.
>
> > +       else
> > +               printf "\nos-version=3D%s\n" $(uname -s | test_redact_n=
on_printables) >>agent_and_os_name
> > +       fi &&
