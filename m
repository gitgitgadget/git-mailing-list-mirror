Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FA15B57B
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877168; cv=none; b=B4BoFWjMnjgQAnjhVKBAA+GKGuPrMx1Qs6pBEe1JGMoJeJ5dAUxs5VL0TMFPgBSGxFD5CzuowbCIG8IV7ywORh2RzxF+qqY812+/aOHAiqq137jDuxaQiAa+ZAirlgO9WzFM5JQFFHqsFIYARpP67jCgimYgdTtBELsHYwBnhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877168; c=relaxed/simple;
	bh=eIfGAPjBbaEQVNDeGbZRlPHGD+cxbGKsAnMSNNtNSCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPK4uObbrrh0xjkke4FfX7pPeajNRc+klrz54O/R+LDPMEPo0g/5u9qA1H2u7lOhDQdDx2KfMOyyxRnh6T8WfMFIEq5ru2nnTCOsKkuHrmv4M0foO4D1sZG8Y3FO9mWX4IjNIszT7Ge4aqE+jAkIVslMmrGIOm7OZucrxS+TkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiSasnSf; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiSasnSf"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49299adf8adso3279683137.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722877166; x=1723481966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOzYfKCA/UJQw3uWXRhrjI/1PVp+N2CDwUPWRAXq7jA=;
        b=fiSasnSfS0s96yPfZ2mjccwZQ2/elnXi6YBg6lxFa3Z6bEClBXYKyMy+b3XpSX2Wve
         40DFJPTZG/ObFJg2r4/UByKzvtlsJ/iqtnYbBrqq3xfK1eQPHAHYwRmx3juysgLKVh1j
         JT9upRXVMT/aypmfHwuMdBWeLS5cnREbVO3386aD6x8O3S7EBj5/0LhdggLjKRBLICSS
         FvgAnaTplWbHtE2/z0MLPXL7/3vf5jFMgZGQz4X7ECj4zd33qmUWW6AdOJ2uKS5UgcWV
         bJHFOhzn+LQ+ipYfgptd4KOurGMYnCHIcJhPH8Xy+s5tXoeWzWGDPVh2v/32B23Owpkp
         pozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877166; x=1723481966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOzYfKCA/UJQw3uWXRhrjI/1PVp+N2CDwUPWRAXq7jA=;
        b=fbUqGI0LqxdzdJoWluoZXhHu55mFVA1SXP9SuieTOTcUkg6Q4HuOaW07kop9Prni32
         IjuGBHRPNEIp3lg21hDGrgWmP1ZWg0TlGXNOL6Qt4ipHa17m059t9imKsSng/K/vjPOY
         47xEcVvg2VZsgShk8dWNGYl0wlTVbXUjHpAB5+BnWRDJlCzC4CRPEPX2bYqgYKnQdcLi
         xUcHq5w0tbYBYaexT+wmcQ1l88anpGO4NT5JczP+DjWiREub4B1pOoGv/Ra46xaHq4Xi
         zX+0MBVczcfPylzR/H581km+tzqzrkzQxtLS6L8/uJw/AAe1bGk8KSuvUgs0kI+0c1Pe
         gmGg==
X-Gm-Message-State: AOJu0YzxaXHZFrUpJh3a1wHi+3FdE5rBfGHi2642WElqmtiU0i27/I3H
	d1+kvS5G7vJtQ1Qp8rHHJCUhyTfs/wSKVuM1VzQqLTbBeQnukapg4eoqxXFRbKsaLAXsvz2JnrB
	T/AgC2DfulyjSp3cBeyGgskUMekFHBunP
X-Google-Smtp-Source: AGHT+IENnz3fZg3WjMAojIBIVfQgeXLnIwf96YIBxSnR5EJjkDslvl5Ua7WvbCYuZ17myF5TShtL2uFvrXWgjLuMX88=
X-Received: by 2002:a05:6102:54a9:b0:493:c3b2:b5ba with SMTP id
 ada2fe7eead31-4945bdb9f08mr16977887137.6.1722877165932; Mon, 05 Aug 2024
 09:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
 <xmqqy15b2aiz.fsf@gitster.g>
In-Reply-To: <xmqqy15b2aiz.fsf@gitster.g>
From: Matt Thompson <fortran@gmail.com>
Date: Mon, 5 Aug 2024 12:58:57 -0400
Message-ID: <CAFb48S8+X0=Zqi8oisB0fAgx7HoyQrahF-RGQdagXTX3RdfSNQ@mail.gmail.com>
Subject: Re: Bug: Git sees branch as valid commit ref and works; should fail
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well, I tried the "for-each-ref" command and:

$ git for-each-ref | grep /bugfix/mathomp4/trivial-ci-commit-gcc14
$ echo $?
1

Indeed, if I try a few other greps, there are no "trivial" or "gcc14":

$ git for-each-ref | grep -i gcc14
$ echo $?
1
$ git for-each-ref | grep -i trivial
$ echo $?
1

But, I did some experimenting and I found that "ci-gcc14" does
trigger...something:

$ git for-each-ref | grep -i ci-gcc14
mathomp4@gslwl2023080107 ~/GitBugReport/fvdycore geos/main
$ echo $?
0

But I'm confused as to how the grep returned a status of 0 but didn't
print anything? So it said "Yes I see this string" but it actually
didn't? And it can switch to it:

$ git switch ci-gcc14
fatal: a branch is expected, got commit 'ci-gcc14'
hint: If you want to detach HEAD at the commit, try again with the
--detach option.
mathomp4@gslwl2023080107 ~/GitBugReport/fvdycore geos/main
$ git switch --detach ci-gcc14
HEAD is now at cc14d30 removed an unused module use in fv_sg


On Mon, Aug 5, 2024 at 12:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Matt Thompson <fortran@gmail.com> writes:
>
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > $ git clone https://github.com/GEOS-ESM/GFDL_atmos_cubed_sphere.git fvd=
ycore
> > $ cd fvdycore
> > $ git checkout bugfix/mathomp4/trivial-ci-commit-gcc14
> >
> > What did you expect to happen? (Expected behavior)
> >
> > I expected a failure as there is no branch named
> > 'bugfix/mathomp4/trivial-ci-commit-gcc14' in the repository.
>
> If you run
>
>   $ git for-each-ref | grep /bugfix/mathomp4/trivial-ci-commit-gcc14
>
> I suspect you have a remote-tracking branch that matches the
> pattern.  In such a case, "bugfix/mathomp4/trivial-ci-commit-gcc14"
> is a very valid way to refer to a commit to any Git command.  It is
> handy to say "git show bugfix/mathomp4/trivial-ci-commit-gcc14", for
> example.
>
> And when "git checkout" is given a commit that is not a local
> branch, what it did below (by the way, thanks for giving a very
> accurate "Actual behavior" description in your report) is very much
> expected behaviour, including the part that it gave a message to
> advise how to work on a detached HEAD.
>
> > What happened instead? (Actual behavior)
> >
> > $ git checkout bugfix/mathomp4/trivial-ci-commit-gcc14
> > Note: switching to 'bugfix/mathomp4/trivial-ci-commit-gcc14'.
> > ...
>


--=20
Matt Thompson
   =E2=80=9CThe fact is, this is about us identifying what we do best and
   finding more ways of doing less of it better=E2=80=9D -- Director of Bet=
ter
Anna Rampton
