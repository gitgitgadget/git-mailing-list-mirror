Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C95730E
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027690; cv=none; b=W8mzG2USNBMSZM9+oTxXEyJwjiuwYutqjKjVy9QCKYXWEwJ79ULM49kMo5Ur/YSR4f1OrGJ/gYH+OlIPTcSOxDTIEVUsc6hvVMSTdJ260riR3lnOVbskr42B84g1gFub3RU7K50OwOmx/edgjiuoN+h2zsHc5PrOmNnrzbBQSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027690; c=relaxed/simple;
	bh=msTvniVNP5XQ8o5V/27rTu41zFOjraCPMnqd9KmWVWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXW3hhPOIeB/3Lzv8AeGwMcHvUpfCf2lOGUjMkwIfxFxsAUV3vh7AOB2hTcCYgI2nZc8ex+zUd5+jcJso/Hp2qUlVNzm0GlQJGeMYpu1vKT5bJNChKPork5oajlLF7oU6lO+FozyFTZ+95n6HmRRn9MtUTRi0f5CaIaFWptBeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Km5UXb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Km5UXb"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so1226499a12.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711027687; x=1711632487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msTvniVNP5XQ8o5V/27rTu41zFOjraCPMnqd9KmWVWo=;
        b=U1Km5UXbZEFwRXzFrjLMPLUJlNZn73PAVGRHcTCUxz0v4KKwmsEUfpVDX/8DVETNPa
         hyBXFHebVLkG3av7yrG+tAa4ebrgXa8OXbGtvvHZ1n08TD7qBe6h2eT2D4CpLxi5TruR
         RrPs6+4mmNqAoBLnfdH0PcqSRjfwOfgdb1EKXfgkIqgljyj6aEK18WozYqiBkO6kryXN
         0cbvj6itWXBhy+T7mFWd1Lqj33AmOzTy50sj9kouJB4PqOuA4Rlp0sDej0fCr/GRwEdT
         l7j2stxiMh/i8BrxKDTsT58p3FHz8evX4uR62e26VMgb15+BWjbfV15zMOsF2NRgexOX
         XC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711027687; x=1711632487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msTvniVNP5XQ8o5V/27rTu41zFOjraCPMnqd9KmWVWo=;
        b=hqJO29a7/culjBS1dkFJ746aRYIKPlyFgzeFVl5e9E5TM2qyaYNok126ZzBG7dAGv0
         6BOPu0ugL0Dar2SmMQtDUYJ/sqtBVGiC1UmtIR737yuZUtIID/BFj4Sve9srVE/qVFPN
         uxkPerAlh4WGznaNYwD+q/fOrzwDnjZsdU3uPwxF1EH0NtU4T8KznPZD46NR4ThVLPgK
         Kk6zOpNd/R4lKB8SlvXl2dTQ8Q5TcTVnzZXuOkx1I9jCDvUzL5q+GeTTIM8LMqVa68af
         wc9SOVSn7Vz3j/SHpW/JnJk/nV3ZffUeAnL63+fAJHFEXrfOSUVwkTNsZMKWd6ynPtFa
         8E2A==
X-Gm-Message-State: AOJu0YwT6doRQ0wH3hUicRlokMn7rEg51+BcmvJD3sQUUwhZrwY8cqSh
	mE6rqEwVET++Y29iBIFYF7rVtsc1p6OQCLRwPk02YV4HtnAwPcbG1e1+bNaqbE+SzdO6Mm0uH5S
	CBpiXoKqZHC7Xe3JBJTByJnPToG4=
X-Google-Smtp-Source: AGHT+IFuDxN8gO87VxxZ/xw/GyLq7dUDcauthKDooEbRaty2hyEg49SoUxrC0D9u0+W3Ft9Yud4JrG8ZEEXi5gNKXIo=
X-Received: by 2002:a05:6402:2789:b0:568:c309:f7f5 with SMTP id
 b9-20020a056402278900b00568c309f7f5mr10205649ede.6.1711027686924; Thu, 21 Mar
 2024 06:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
 <ZfwsnMWg12S2gV3C@tanuki>
In-Reply-To: <ZfwsnMWg12S2gV3C@tanuki>
From: Aryan Gupta <garyan447@gmail.com>
Date: Thu, 21 Mar 2024 14:27:56 +0100
Message-ID: <CAMbn=B73ioQ8oRucG4X8anhwrnbhJRky7BSe7DKpQad85Dt5xg@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state self-contained
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 1:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sat, Mar 16, 2024 at 07:57:49PM +0100, Aryan Gupta wrote:
> [snip]
> > -- Plan --
> > ----------------
> >
> > What is Git Bisect?
> >
> > Git Bisect is a git command which helps to find which commit
> > introduced the bug into the codebase at a faster rate by leveraging
> > the power of binary search.
> >
> >
> > The project idea is relatively easy to understand by the description
> > itself. Git bisect stores some state files such as BISECT_START,
> > BISECT_FIRST_PARENT etc which looks very similar to the naming
> > convention used for creating the refs file. Due to this similar naming
> > convention it sometimes causes unexpected results when these state
> > files are confused as the ref files.
> >
> > In order to fix this problem we can create a new ".git/bisect-state"
> > directory and store all the state files which belong to the
> > git-bisect(1) command in that directory as proposed by Patrick and
> > store all the files as follows.
> >
> >
> > - BISECT_TERMS -> bisect-state/terms
> > - BISECT_LOG -> bisect-state/log
> > - BISECT_START -> bisect-state/start
> > - BISECT_RUN -> bisect-state/run
> > - BISECT_FIRST_PARENT -> bisect-state/first-parent
> > - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok
> >
> > While the change looks very simple, it actually is. We will just
> > update all the paths from where these files are being accessed. When I
> > went through the code of bisect.c file I found that the path is pretty
> > easy to configure we just need to modify it at a few places. The main
> > problem is to efficiently handle the backward compatibility and
> > implement proper test cases to not let the existing things break. I
> > have already gone through the bisect.c file a couple of times just
> > reading and trying to understand all the functions and was able to
> > understand a lot of things about how it works.
>
> As you also mention further down in the section about backwards
> compatibility, the challenge of this project is not about doing those
> changes. That indeed is the trivial part of this whole project.
>
Yes.

> The real challenge is figuring out with the community how to ensure that
> the change is indeed backwards compatible, and that does not only
> involve backwards compatibility with Git itself, but also with other,
> third party tools. The biggest question will be whether the refactoring
> is ultimately going to be worth it in the bigger picture, or whether we
> should really just leave it be.
>
Yeah. As mentioned in my previous email even I afraid about we will be
ending with managing the bisect files at two places in order to ensure
backward compatibility.

> So personally, I rather see the biggest part of this project to find
> good middle ground with the community. It's thus of a more "political"
> nature overall.
>
Yes I think we can figure it out together as a community what should be
done to encounter this problem.

> I don't mean to discourage you with this. I just want to state up front
> where you should expect difficulties so that you don't underestimate the
> difficulty of this project overall. It could very well happen that the
> whole idea gets shot down by the community in case we figure out that it
> is simply too risky and/or not worth it in the long run.
>
Yes, it's true.

> If you want to stick with this idea then I would strongly recommend that
> you mention this in your proposal.
>
I am open to changing to another idea, I won't mind that. Because my
ultimate aim to add something (even it's a small patch) to git and if
this project will never be in use. I am willing to change it. Let me know
what you think about it.

> Patrick
