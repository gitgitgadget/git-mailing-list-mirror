Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7A13959D
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364368; cv=none; b=Ohk054ZspcM4eAtRTdQub7LDOmyU/TfjD14YGvGyO9eQJoU9CfL8Ch7l2oIi2i1Lsx04DuttCVdhQeb0IbSBDpve8/2UOw1vatR57aM2AgmMDin7WN4THjY/X0UNnTXUlmYyABXFR3PVrCrtZgyLZVvHAMZtOtW6F3Zhlv6MKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364368; c=relaxed/simple;
	bh=A1mLR8JWBnqdEw15rCXS7pOIzxZBqB6uF3dIDHME/Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN/UHjYSGsXdJI9h1NM77a8FIPAXS5dFZo8+D4Zt/4zrSorWXm8zuRIbNYjdcY7X1Tez1Y9sNPTue5Uky6cJLJEV2TZOSOelutKTDeHcQ96i6JtBdNTGbivASkEjzEgq04+8mHXMQ8UIo6PHmh3sCJ/k6PWMBdjpIWMGo3+dPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoVjNmcD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoVjNmcD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so53598505e9.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728364365; x=1728969165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHh6H2Gw8c+noffEeoxaltdPeisG0c31wtjdu2Pf/NQ=;
        b=XoVjNmcD6RIEYia4Qs+xfSMOTcNLLlG3/NRNYPCtqU7aMWMrDpU0280js6lilzbGrd
         R9dTFqaS2DfYPP/64z+GcbLxGBb4Ks+ir13RD9HfP4H6dlcyo7MzyBkqBV3CmUzVOp9X
         shkYKxvBFNEffHFwu/pMHCWXe9zfvVT3dP5XVMqfXCau8NNAeYoHkCMiVc9S8CXIC/kl
         vRNLab2phQsjJPonIAcbHfzPulAZXQEfXd+nT7xSQjvB4OvL0baaq+ulHKySX/YCFDlB
         XxuzQWygkWk+A2wFjBtyIPkfUBz9FacOeVPJNFc6kTAlIEIMF3xrDLa83U+5QUgDtwwm
         TRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364365; x=1728969165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHh6H2Gw8c+noffEeoxaltdPeisG0c31wtjdu2Pf/NQ=;
        b=QKvQ63q/rYVCOZl+/j69/qkAJF3KuAzC0fpeXWB96eO6FTd25ZrSJRT7emFoYTkyeq
         VB6uB8xdQC+z1cPxZ7OH9A3WNL5cKQj5mlZuoZvVJ0p2UUxZdYWHdx52v74PPSPGnBWO
         +2zR53jeJw4r1wF1zWw2xTOo3CL+IWHru3FR5og9bCaVIUmSh72FDfVPWUlqdruqIPg0
         nSguGsc+GunEcDh6QK+5r+NFO/lui5mCM4owE/QThZfEJM0dxBuyDLLIgwBtjjaoOMYd
         haMqT5ue/4xLQmUQaieRm6/zFqmo2tO0liqPkIM6t092eNfnc+CoHl+bEiEiWOaDnC8t
         Nbww==
X-Forwarded-Encrypted: i=1; AJvYcCXgAA7LooeTtslIFkgr33jujCRxsZOrE9QhsH1bvMMTrYyHTIFMr5rl2xLFDdgFepa6kw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwjNtdmv3n4O0LMfzYWU5UN1i5EFj6QCKa3WhVXNYEs3dN9Pt
	AW/2ZC3UBB9tbUf2HoDD1q3pYbMCEtN0UBS14CL61aF+UNYP5OZpth1wOd7hnXU3EA9J7mqVi31
	h07QBQoCnSCNy+Y6MbvhxkqOzVxY=
X-Google-Smtp-Source: AGHT+IEOtGqJENOvZKfu6MO6Vuljii7pKAGZ5sK2ybqC/KS6MAxCbxXdFnzTv/AEENUF0Nqn+Yt0DcIA+dZQast+CCQ=
X-Received: by 2002:a05:600c:501f:b0:42c:acb0:ddb6 with SMTP id
 5b1f17b1804b1-42f8bce09b4mr76496375e9.9.1728364365140; Mon, 07 Oct 2024
 22:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com> <xmqq34l75pr7.fsf@gitster.g>
In-Reply-To: <xmqq34l75pr7.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 8 Oct 2024 06:12:34 +0100
Message-ID: <CADYq+faT1J7cj3v=q+aJbUrVUc-0AHP6DwDh7kXbQ5TrL4tinQ@mail.gmail.com>
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
To: Junio C Hamano <gitster@pobox.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:48=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> > The test_path_* helper functions provide error messages which show the =
cause
> > of the test failures.
>
> > Hence they are used to replace every instance of
> > test - [def] uses in the script.
>
> It is unclear the use of present tense "they are used" describes the
> status quo, or the way you wish the test script were written.
>
> The usual way to compose a log message of this project is to
>
>  - Give an observation on how the current system work in the present
>    tense (so no need to say "Currently X is Y", just "X is Y"), and
>    discuss what you perceive as a problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to the codebase to "become like so".
>
> in this order.
>
> Also, for a patch like this one, which is rather large, repetitious,
> and tire reviewers to miss simple typos easily, giving a procedure
> to mechanically validate the patch would help.  Instead of having to
> match up "test -f" that was removed with "test_is_file" that was
> added, while ensuring the pathname given to them are the same, a
> reader can reason about what the mechanical rewrite is doing, and
> when the reader is convinced that the mechanical rewrite is doing
> the right thing, being able to mechanically compare the result of
> the procedure with the result of applying a patch is a really
> powerful thing.
>
> I probably would have written your two paragraphs more like the
> first two paragraphs below, followed by the validation procedure,
> like this:
>
>     This test script uses "test -[edf]", but when a test fails
>     because a file given to "test -f" does not exist, it fails
>     silently.
>
>     Use test_path_* helpers, which are designed to give better error
>     messages when their expectations are not met.
>
>     If you pass the current test script through
>
>         sed -e 's/^\(   *\)test -f /\1test_path_is_file /' \
>             -e 's/^\(   *\)test -d /\1test_path_is_dir /' \
>             -e 's/^\(   *\)test -e /\1test_path_exists /' \
>             -e 's/^\(   *\)! test -[edf] /\1test_path_is_missing /' \
>             -e 's/^\(   *\)test ! -[edf] /\1test_path_is_missing /'
>
>     and then compare the result with the result of applying this
>     patch, you will see an instance of "! (test -e 3)", which was
>     manually replaced with "test_path_is_missing 3", and everything
>     else should match.
>
> And I did perform the sed script, aka "how would I reproduce what is
> in this patch" procedure, and compared the result with this patch.
> The patch seems to be doing the right thing.
>
> Manual validation is still needed for "test ! -f foo".  If the
> original expects 'foo' to be gone, and has a reason to expect 'foo'
> to be a file when the code being tested is broken, then rewriting it
> into "test_path_is_missing" is OK.  But otherwise, the original
> would have been happy when 'foo' existed as a directory and
> rewriting it into "test_path_is_missing" is not quite right.
>
> This check cannot be done mechanically, unfortunately.  Hits from
>
>    $ git show | grep -e 'test ! -[df]'
>
> need to be eyeballed to make sure that it is reasonable to rewrite
> "test ! -f foo" into "test_path_is_missing foo".
>
> For example:
>
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean &&
> > ...
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
>
> this test creates a.out and src/part3.c as regular files before
> running "git clean", so the expected failure modes do not include
> a.out to be a directory (which would also make "test ! -f a.out"
> happy), and rewriting it to "test_path_is_missing a.out" is fine.
>
> I did *not* go through all the instances of test_path_is_missing
> in the postimage of this patch.  Instead of forcing reviewers to
> do so on their own, mentioning that the author did that already
> would probably help the process.
>
> Thanks.

Hi Junio,
Thank you very much for your time and very detailed review. I will
make corrections in my next patch.
