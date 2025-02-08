Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4602C9D
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974240; cv=none; b=qfzMhvKgK96UsFHjrRmGkKTsC4cl3ASOnErYA36ZQHQXMu+Do06TloyR9vqqVgwZa8ToMpQmUzzyHs6VfShh9yiOUhGh8/5TswG3HMHQu8+jJanLwDMceXzzLpULtB5wOnB1dOzRyfisrjadYfkg0wYtrPD7DgtuSvM8eIpNi7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974240; c=relaxed/simple;
	bh=FEn/X0CA39o9IAHL6QaI/qahl0ehNQj3pKcYE9LJfoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Y5Zzq65hSlVD3NiIfsaAbVFtwIGg846sRwNi2Yv2anFT/twYhEadOZbyO8NTcDDeD8/C0swnRvnFU+G9NhH4IePkjg/a0dV6ByaSIT5TuSfB9yzf1kMdqIU1uMjFr0ktNimLFKc8ZdKPCMSFPioOQhGKoX4WL3aL8hlgSDOSfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOiNeldX; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOiNeldX"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844d555491eso77936139f.0
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 16:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738974236; x=1739579036; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4U6cTFO6tWnmVflqh42ZeDRvIT7vxCtXLUX1JMjDP4=;
        b=QOiNeldXsXlQtVcleieF3na2GuA12wb2sA28nQYO0hJfTPyZfarQw3jmcW+F/hB4En
         jyvLj4lMSL1qoNGs99TSBslz9I1LwBAaF3HxwjkW+OEtLW33Lptkc8bxUfirokagoSZ9
         4I1eeHXbq60qwWfSsLkFjlqyU4An2E16LQU/PeaJGmpm18iSvWi8kVvO4uOIkVe7Fkv7
         kTL1j5iJQgxSPbJH5rxxSXmocPkfLuhiu8CXA9QcsbT4Oo4wx0tGxe/r1PIwOsk9NY1v
         vDRDkF3aHDHPfEWM5J+Pjt7JRUyqIVsa3lqYkph6FUAjPlZfuygiMj4Yf8n3iWsKTicV
         jmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738974236; x=1739579036;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4U6cTFO6tWnmVflqh42ZeDRvIT7vxCtXLUX1JMjDP4=;
        b=Ge11xto3PZpX5FvfEgRCDnqq9diRCyUSMQsP4Z1TByGP5sb9+uAjbLD7io93IiFsHY
         KQsfdpz7wNkMDASS7YDiB65n5M1gonUCSuKwA4BcxyQ+A1KhuZEiYGRX4DI82sTt9Nnr
         nIx8ND3MRzjfuFKBFBo2CIgjXQA4c/2ZAMovZL6mmVS+NnJ8M1WktKBF58qgLd3354mn
         3mKWxzoXVWtWal3MkWUK9HlGp6VlZDOp98Yy/6cBXYrpcYBtlkKChSKfelmPvBwE9rCi
         miyjKC0gD+mqU7IqYWtNgSIA8nVriAolY76af0PdwFS2yMaab9j72B1LdjBU6Uw7nYNa
         +jWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVht0Lu0eBoAOJ+E/SRNWCAuy/vcNNXXELZU4neb9d0TkeTB3k7gFoHtAScK9LkSeNa6KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvzgv4/TUdZU83DajGHAreS+cGGQUu612uIeULJHXWILXaBdc
	XXxrr5sQVP50SuEcbIPF71Z+NRIgsi2QfjD8De6tIofpwHK5p1NJn8Sui+lB0RTxY9NBR/5QmaP
	ehvJsXrnXblHa1dLkdxIfoNHTi3VSBvMF
X-Gm-Gg: ASbGncsnPnPjpfD9n1Wnl6Lk0SHMtY+NE6IgGQyA7c+dcMdy7D7yLQs25YDyR3pND9y
	J531DqomrFsFTBZj4+wS1p/IrtTUvGExIPN+L87HKETswkINawRygxBekioC8u8sCcZ6Y55z75Z
	cE8zfma07Avc8oRmkKCaHwwJxWpr6Alg==
X-Google-Smtp-Source: AGHT+IG2icDt30ZgDVs6uzijdjRiIaiZ9mZF3hjV/1hbZ4p9t2LTvn3lmndmQJE0Q4QbvLmgNdYk4ebBqoU56PCalV0=
X-Received: by 2002:a05:6602:3711:b0:843:ea9a:acc4 with SMTP id
 ca18e2360f4ac-854fd8b2920mr602211139f.8.1738974236368; Fri, 07 Feb 2025
 16:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de> <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com> <20250207203248.GG30202@raven.inka.de>
In-Reply-To: <20250207203248.GG30202@raven.inka.de>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Feb 2025 16:23:45 -0800
X-Gm-Features: AWEUYZlw_pkilmJwCZQsf0o_FGSOZYxgMfWISWpeLi2MQY91OyEAaHY7ytJzwuo
Message-ID: <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:34=E2=80=AFPM Josef Wolf <jw@raven.inka.de> wrote=
:
>
> On Fri, Feb 07, 2025 at 06:01:43AM -0800, Elijah Newren wrote:
> > On Fri, Feb 7, 2025 at 3:13=E2=80=AFAM Chris Torek <chris.torek@gmail.c=
om> wrote:
>
> > renormalizing
> > all files proactively in the merge machinery whenever a merge or
> > cherry-pick is done would be orders of magnitude slower for any
> > decently sized repository; it's simply out of the question.
>
> Sounds like trade of time against correctness?

I may have misunderstood what folks were saying in my reading &
skimming of this thread.  I thought some folks were suggesting

   git rebase --root -X renormalize

as a way to renormalize the history, assuming you have linear history.
I was arguing against that; it's not going to work and isn't meant
to[1].  I also see I didn't look closely enough at Phillip's
suggestion, which was:

   git rebase --root -x 'git add --renormalize . && { git diff --quiet
--cached || git commit --amend --no-edit; }'

which will work if you do a lot of manual work to resolve line ending
difference conflicts.  Since the git add at each step will modify the
files on which the next commit is based, that causes the application
of the subsequent commit to conflict, and you probably will have
difficulty seeing those conflicts since they tend to just be line
ending differences.  But, mixing that with Brian's suggestion, you
get:

  git rebase --root -X renormalize -x 'git add --renormalize . && {
git diff --quiet --cached || git commit --amend --no-edit; }'

which should probably work if you have a linear history (though I've
never tried it myself; I've never actually used the renormalization
stuff beyond making sure that merge-ort matched merge-recursive).  The
`git add --renormalize .` does the work of changing files, and the `-X
renormalize` to git allows it to handle merging subsequent commits
with the munged line ending differences as it does its work.

Were you trying one of these three?  Or something else?

Elijah


[1] The renormalize option to the merge machinery ensures that new
blobs produced by the merge have normalized content, and avoid
conflicts when the only differences between files are normalization
ones.  This option does not ensure that new trees only reference new
content nor that they only reference normalized content; _any_
pre-existing blobs in the repository are fair game for new trees to
reference.  As per the manual: "renormalize...This runs a virtual
check-out and check-in of all three stages of a file when resolving a
three-way merge..."  So, the existing behavior of the renormalize
option to rebase/cherry-pick/merge is correct.  It may not be what you
want, but I don't think cherry-picking/rebasing/merging with the
renormalize option is the right tool for this job.
