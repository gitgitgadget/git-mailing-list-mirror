Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E32505D1
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694785; cv=none; b=MFShnL9ALzI3NcfYTQ76Zgg6ESkxN1FZWdsjoZeVloJtndV8+eNvWZts9te/xz4MvblZT3phAAvmz6X0Gy47cTLPTg9TZL65eOLW0lwp82kxCxpU71Rpb8eRvdWt5mWn2S91NP6+I9SfINgzLKPaTrEFILwwUnEOlPa9IuWy3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694785; c=relaxed/simple;
	bh=aS5IHiiF+8W1DOz5SFXFDT4N5Ehi0MPdoDcX1twHL6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lo+pXI33TZcCFEZTkLcNgy9VeX4uzC3Eauh30Fu2szCQ38tD4KZh+FJ0SqUqwOjgm+jeeyBChZkq9O7KBvQ7K1ufE8Vs3veT7VHRfdbvUG5fLj7tTMZE2DKHMv+ICqKk9B/5gTPU43BwR2EMAJKh8IUbL7XcKIHItjgO5VI87oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtE9q98N; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtE9q98N"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d46aaf36a2so7589535ab.3
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743694783; x=1744299583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtULk19OC4s2PcLnAwsNrE6MJvxOygXtTn1k/HM/+U0=;
        b=YtE9q98Nm8i/vXZHEdX5gIR1Ykvyq4Xd3hPBdNz44uJMTiQP3YDNi7KtXzhw2LfJzn
         I3b6ZSzrGKhKDAihp9/YPxjtbQWao8Y601NbGx+yYrOVEnZj2B8JtaSlvgRsRYILGdFP
         mMkhgT26trYpqFIKoCkL2ffVrxgWBE5lDY6L9BwkTFY/xFi95U2oJzu9BUnIEDdobvWk
         H/RdBSauE5ERs97xfPPOEAt7pKHxkLDGL8cNkGxeWJHIJGfidbdySN+7cnuRYiRpiKJG
         KbuJ2ApZUNAnPsqYe438MuYXgea5MsNaFrQAz+JQZP/1v5qe+AHicbvZIU4Xx4PlASvr
         dSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743694783; x=1744299583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtULk19OC4s2PcLnAwsNrE6MJvxOygXtTn1k/HM/+U0=;
        b=jjbKIsvaMeVB8FxgmTi9mE/DNQ4JJqTyS1tbRNTcitDQIZYIBkr+tqn6tP241Fh+wK
         5ovq2ZeD887Ybm3HLqvVXtbsLX2VSFOAmr+2d/aq0xAKYSI8Wm3GXqHORnr8BfRBNRsP
         gQSD7Vqm2RZ4zjWGvNvBseAFYPy9O/S1Ly5bWM39RKw6QMlDb0GIxt+vQSW/YyeMbNE0
         jlpir402zuCo0GqqQVYBCtnjSul5ZE9HUUT7eCYgJf0YUY8wavStruV/R/kJRMsKj54/
         2OxVEAxdv8pjvaRuM+iHxvWekAFm+upwxQp230D+MrUsrYB7X5+/cVWObfJk4Y0XL5q/
         frwg==
X-Gm-Message-State: AOJu0YxwcHS9OUtIzu285TR5sTYFF1LAnZ1pUQDWeh9zrE+cIiWOSOIA
	ZT6W9g9Jo/U5a+ASKcwk2zb0C2TMKfw+sfPLtEDi0OksIxqUhmPjDAWcGGo12Oz+eP4Q4dDDfuk
	kms1BaRTq1m29VECihYURxq9uXkL+nA==
X-Gm-Gg: ASbGnctpqSF3PCSPK1DLSkM2ckUuJhQriwkn0mF5tqVp1GDi3DZv829qTgANIPyHUwU
	XvnqFFCoVkpx4i+odRPCpZwM08RVEca0KYiWv82hmTHx5EksTyk4wwi5Fej2z7aTWF16G40kuM+
	BcuaQ/NhByeJYsEkARxmAg+NIuZAIzbdtAABdjH5yMwXCtPZc7zIXd1Ebujw==
X-Google-Smtp-Source: AGHT+IGwk0Ngo2f6dKN65m1iQ4AJmFPevslHXyE8qngWoCpiBdCWpDolhphHGuDmrfpKjmipCq+jMaOA3Uz5R377mdU=
X-Received: by 2002:a05:6e02:2388:b0:3d3:dfa2:4642 with SMTP id
 e9e14a558f8ab-3d5e0934066mr223989985ab.13.1743694783120; Thu, 03 Apr 2025
 08:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
In-Reply-To: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 08:39:31 -0700
X-Gm-Features: AQ5f1JqfJTMYtL2lcM_TRTkxsPSdD1Oily3vjz-i6BdSTAkZRheUkRnWbru3PNk
Message-ID: <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 11:48=E2=80=AFAM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> Hi,
>
> The Gerrit, GitButler, and Jujutsu projects all have a concept of
> a "change id", and it behaves in a similar way between the three
> tools. The change id is conceptually associated with a commit.
> It follows a commit as its rewritten (e.g. by amending and
> rebasing). The three projects currently store and format the
> change id differently. We would like to unify that so we can
> interoperate better. We hope the Git project is also interested
> in preserving and using this header.
>
> There are many benefits to having a change id even if it's just
> local. I mentioned some in my email to this mailing list in [1].
> For example, it enables
> `git rebase main <change ID>; git switch <change ID>` without
> requiring the user to look up the hash of the rewritten commit.

But <change ID> isn't unique, right?  The whole point of having the
change ID is to preserve it despite edits (e.g. rebase, commit
--amend, cherry-pick), meaning that you end up with multiple commits
with the same <change ID>.

Why would this work?

And if it does work, isn't it expensive since you'd need to walk
history to find it?  Or do you keep an extra lookup table on the side
somewhere?

> If the change id also transferred between repos and preserved by
> a forge (such as Gerrit), it enables the change id to be used to
> identify a code review.
>
> Here's how the change ids are currently stored and formatted:
>
>  * Gerrit currently stores change ids in a commit trailer called
>    `Change-Id`. It always starts with the letter 'I' and is
>    followed by 40 hex digits. For example:
>    `Change-Id: Ib563e78c3fedcff262255fa025441daa3202311b`.
>
>  * GitButler currently stores change ids in a commit footer
>    called `gitbutler-change-id` (older versions used
>    `change-id`). It's written as 32 hex digits separated by
>    dashes as in the UUID  format. For example:
>    `gitbutler-change-id  7d0fbc63-032d-413c-8ae8-610fbeb713c0`.
>
>  * Jujutsu currently stores change ids in a local storage outside
>    of the Git repo and is therefore not part of the Git commit
>    id. It is stored as 16 bytes. It is rendered to the user as
>   "reverse hex" using 'z' through 'k' as hex digits ('z' =3D 0,
>   'k' =3D 15). This allows even short prefixes to be distinguished
>    from commit  ids, which is a very useful property when used in
>    the CLI.
>
> As mentioned, the three projects would like to use the same
> storage and format. I think we have a consensus to store it in a
> Git commit header called `change-id` as a 32 reverse-hex digis.
> For example: `change-id ywlktllmukprnxnmzzprukpuwyztylwt`.

Yaay, I always hated it as a trailer.

> There is a design doc [2] about the impact on Gerrit and how to
> handle various cases where the client doesn't understand the
> `change-id` header. That also includes some discussion about
> whether cherry-picking should preserve the change id or create a
> new one. I think there is a lot of value in having a
> standardized header regardless of what we decide about
> cherry-picks.

cherry-pick & rebase preserve author name, email & time, while
creating a new committer name, email, & time.  To me, the change-id is
about the authorship, and since these commands already preserve
authorship, it'd seem weird to me to have cherry-pick not preserve the
change-id by default.

> So, to be clear, this is mostly a heads up at this point; we don't
> depend on any immediate changes from the Git project.

I appreciate the heads up, and agree based on what I've seen so far
that you can at least get started without Git changes.

However, I think you'd want git to preserve the change-id headers upon
git commit --amend, rebase, or cherry-pick, which would require some
git changes.  And you may want git to preserve them when doing a
fast-export, and be able to read them in with fast-import.

Anyway, I was a voice in the past that was kind of against these,
though that was mostly as a commit footer.  Plus, the number of
projects using them, hearing about their experience at Git Merge, and
realizing that part of my objection was due to misuse of Gerrit by
some folks in the past have all lead me to change my opinion.
