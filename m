Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C62E62BB
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716797; cv=none; b=DvWBlDaeLOqf0OD48QYvV+gWWZwybm1DfZ99/sOOCOzWxLGzJPxzPcNNB92VrlKr3MCyTb5sTqSLexwCC9/MHPmtPvQXbacHO/jwiHJzssXPe59rb+bPvRZeMrbkt83zbV5DRkxCRc7KuxGfH+kZwtMys2yW5rLpsEN/AAipQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716797; c=relaxed/simple;
	bh=RtFTX/hXw5tyV64aQ0ibc0KQj02yK8oT3p0J9SqPjf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6hq9h0bDRct4paptAnF/rfab/dUtZenamNUSxWeWKQHSDtexXPSSTT+EQ61NBGXB3aiCNtTE83FLrpQoagJ5wEKQqDpkWCKOldfb7kgAxe6Oyb0UUUnR1pxELyxkTwBY9muohm5NRz2v24v5oEsh0iuYtOkOXuVHd7mJHylRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zmWl8HM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zmWl8HM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f09f2b3959so3782a12.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743716794; x=1744321594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP1hpuUIGturwSsjkoQPwsFyNU0zWC7ElzFLqhteoGg=;
        b=3zmWl8HMI3/HOVrLb9IHBZXXDptOdHxmQsz8XadZBFopbghcUkPDBFoT+9kZB2gfjS
         b1dAwa9wv6+TcacIKL94un3aUxcW5RsezwukGeBF/P3bFv2FELv+EMmBpYZCFto1hULo
         aILO8v4Jc1SJLGaYokK15FMOaHi/ucCJMzYAmkcRLwyIwbXJrFJkhjsoCQsgPcheLsh5
         CbBYZDb7Rqw1KlCwwTZFL6oTt3gT5cHLASddGGjn/9D71+0AIKvlVH1zo5i1hvJWHz1L
         Zz2qxoprlHh+MfqDxyfp3+uOgFJeT+I6RUo+S2oS/SvtgYRpJjjWXugsxkJBL1dJgXnl
         O41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716794; x=1744321594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP1hpuUIGturwSsjkoQPwsFyNU0zWC7ElzFLqhteoGg=;
        b=cMxDvobWdazgzqpmVo6wPjF2u5LR9Q/r92RJRU0vZi85VZpD52Mrx7sgyG4rbwGWgH
         r8FXyrrluzoRjpoyaQ8QHTya86MnjRPghXCJ5fyEQiimpIosQlMTECj8NhMEnQBdOHtj
         u2oR9PbFZkFwO1Rl+W7urcHvbtx0hvmAsNHzg+PErpM+7pRLC/aZneftpDQukXQqBn9q
         U20qznUC5s66OX7iPA4qsxqr14agYk+2QZLYWJNdQ6MERKRuvWRCxh3ahU9LWQjh1WsA
         zV5nRri4eWZynAh9n3X+/8QFnKKYO/YNWhsSBRtVVTHBF7dlnlQgEVuIWl3BAehxzq10
         qzgw==
X-Forwarded-Encrypted: i=1; AJvYcCW2bH44VTLJaRuIQF1DD/skew8Lkah1ZAIJRdukUtIcOFw5QbVXH/38NvkbLu7j3f/Ob3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mMbM97hJGIvujG3p8g7ZFL9c2HedUVyOATfvL9Ng4tuYqfcl
	JDTpoAHmpqxDTcimMJisFfkCPFOKeSmF9d7NtWmbjsvJSa1jxEMlUygomhCSotp2NpmJi5cvVBb
	baPYKX9qs9eipCjwac39p9CVJ3K2o6s5rPYBc
X-Gm-Gg: ASbGncsMXo4ZBblYwVV68fTNiK1YsByQjHqvcnOlTY4wbEtHEcUL+EG0AOuxW9MG8MK
	aHuClyk3A/TD7Lv4osQ3+Fp9TR2SFDbJyp9xdhVmsAHlDQhl9qOcBIs4j6Ao3mXcRibO0eq6h5k
	cu1C2EWTbdtYluX2SM3ZM5rdokzgjK/qzguc8xqemjUgRJ3+l8G2TcdQdP
X-Google-Smtp-Source: AGHT+IHaDeKxD+IRQEbYwG1zljoHwIzCFuYhpLhIX+XXC0cs0HUys/Wha3/Kx2OzCQOVH9v7mWDnZkUHaxiMLvAvXwk=
X-Received: by 2002:a05:6402:6d3:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5f0b4945f88mr32708a12.4.1743716794056; Thu, 03 Apr 2025
 14:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <Z-5QR57zgSsm6jNP@pks.im> <CABPp-BGwXaiohvfSdr96hzKNPYXQqz+_okxLNj7P9KSjX2PW6g@mail.gmail.com>
 <D8X571K4M77Y.2PVKK2KQCRBOM@buenzli.dev> <CABPp-BFr+4iy7awessWSY8NzzswY1-=30L4VvOZMpFDoOxJUgg@mail.gmail.com>
In-Reply-To: <CABPp-BFr+4iy7awessWSY8NzzswY1-=30L4VvOZMpFDoOxJUgg@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 3 Apr 2025 14:46:22 -0700
X-Gm-Features: AQ5f1JojpCtg1ICwQ3lHq5r_i9Y7DjHwk7Bd4e9iyL_0YcZhUHkmOziuHGRonj4
Message-ID: <CAESOdVB7VhEhBJJYVY8ZdbShQPRKcoWu=7YQPBwRp93iH2yvWA@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Elijah Newren <newren@gmail.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Patrick Steinhardt <ps@pks.im>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 at 09:39, Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Apr 3, 2025 at 9:25=E2=80=AFAM Remo Senekowitsch <remo@buenzli.de=
v> wrote:
> >
> > On Thu Apr 3, 2025 at 5:56 PM CEST, Elijah Newren wrote:
> > > On Thu, Apr 3, 2025 at 2:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >>
> > >>   - Extending revisions to allow specifying commits by change ID.
> > >
> > > Would this essentially be similar to <rev>^{/<text>} except searching
> > > specifically change-id headers rather than commit message?
> >
> > One benefit of using the "reverse-hex" format (hex with a different
> > alphabet: z(0) through k(25)) we're proposing is that it allows a
> > change-id or its prefix to be used in the same place as a commit hash,
> > without ambiguity.
>
> I already saw that, but this doesn't address my question.

Jujutsu has a persistent index of change ids to commit ids. It's
similar to Git's commit graph. As you might expect, this index often
has multiple commits for a single change id. When needed, we then
build an in-memory index of only the subset of commits currently
reachable from the visible head commits (you can think of it as all
currently reachable commits from Git branches, but we don't require a
branch to keep a commit visible). When you do something like `jj show
xyz`, we use that in-memory index to find the relevant commits. That's
usually just one commit.

By the way, we actually have another level of lookup that happens
before that. You can configure an expression for the set of commits
you want to prioritize short change id prefixes and commit id prefixes
for. If you say that you want all commits that are not ancestors of
any remote-tracking branch to be shorter, for example, then we build
an additional in-memory index of only those commits. That means that
both change id prefixes and commit id prefixes are often just a few
characters long, even in huge repos like the monorepo at Google.
