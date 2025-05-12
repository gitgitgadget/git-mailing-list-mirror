Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DDC2E403
	for <git@vger.kernel.org>; Mon, 12 May 2025 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086241; cv=none; b=tpECqfevFKqSmDduHSGtGhu07JpYW/GrjPg791nUAKWlpLz5yqLOfREFII3FZqc3ePB6+OQgSDdq3X/9IxXvyNATVxdV9PaBwq0q6o+0xwblIOMbsJ9fWShH7kDVMnfRsornUsgWNRMPZWJCAQcue1VO6QLdHtRwR9Yef1ZXh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086241; c=relaxed/simple;
	bh=YejSyLgFw29dhH3sKhTeyZNi/LRKcvyXBfIRL5+/CiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JN3L4REP/WTcryYgRIs3diL+jsh/SpL7/gRN90SQuPkQPRJApHDAF1xyBUzfFEOdl2NLvAnuEh+a482YHqsGJLzbuy/8m7jrg8yeYDjpTLuW6Ev8GXgPKxjITfCmzPFhpCjQJbAP4L/GakG5TvGSaXWUMijDLz9dQpCyuG0D2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9k/6IjA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9k/6IjA"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fc4fc27983so1467a12.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747086238; x=1747691038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCXXRJn0s/9Jr/wHJ2U5Fhqe+MCctkPyo3BFvSYwmpc=;
        b=W9k/6IjADT+crhcmB8Ykp6WBblpI4sxnNI1FOEAoO/6RC028kaPunE5eAUg64pIjRs
         MMGndmUK7DfaZyvC9LiNpqBEHaKwm0aY5BeseOja7AMJ3h5GjAEi1XNG4Vfr6hNcrm9h
         tljlJOwRAQ8XBRDm/hKjBfr0YqJmxmd9gf2U7249JWzZ0A39iutCJgI9txT089AkkQ4g
         G8QhqdFqOWsYER+U+fjO2f0DqhO4Be0FniITD9IcoWqFSG+OgpQmqHlo191el7HPgjss
         XEcM1gUB37uVMjFxLXTXu2IEahSwmmXLwOL1vp7D9XAJaMbZ3cpcPRCWnEmiRlwt+6Lc
         O6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747086238; x=1747691038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCXXRJn0s/9Jr/wHJ2U5Fhqe+MCctkPyo3BFvSYwmpc=;
        b=PhymB4WBgZNkXjKybZNE9Aumdm8Z1vzfV0ZGC0xh6yRzBf+qLuADxRM/bp4TES/3Lg
         HYXMgh55l+Wj9+p8oyr0RmPdig8/fEPc6q8QMb2GImXvRgMEnbSn4VoAE8ALRJK0csGa
         SyJquTh9nu8eJk6GjNqVOYMMSVKoPYo6JlZef1OD6QyQbzP+PN1pEUMwmBYC12BYrzto
         5ub+vN3wA1HKqQM7MBOCVlji6hCpxlzv9oiksb2MdTmFe9QPvgzV3XjXPMlgGflmGVtN
         FtZe5a7iUZjOkcYi13bMX2DIN15X7h2PmqPzE/Jb0ot8+JTXNhIJHXuTLUtb/S2+7M79
         9GGA==
X-Forwarded-Encrypted: i=1; AJvYcCXbO5/0iyktyr9JN6Ysg1efGEQArGjWMd/nUsXH2EBHemNZ6NH+OVxBiiZxD3Wxkve14cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+HBh8xWCN1DPoJlsp84qVkqNLdOgAsVGlJuK22PHB+pZBzvS
	fvZlLI9HafbYjLWcYNuzmIN6E/SZkhm2X7Jprk9LUOwJrdhQ7vOhchGEEjm7u6mfAjMjran3aHn
	eTGlTqQKEqsPkyb4AN7wz9L7FOiWalkz1LMpvcojl
X-Gm-Gg: ASbGncslkyh1b2DGxU91/C2TejErj//jLWR5cMIFOqUDsccbSxOFAOYC7HQXDo8FLgW
	0VH0Yz4Zm7o5Zc1kpwrJTzB/fYtT9YQOZTMvR5VtuvxeLzyKTRv4mphpkpXZErmee+qAV/TWICr
	j1livz1HefCVYKuW7+J8cTnZB0B/aLiLlP8F20zfzoI8ty0hpkXFJdJppQ6Hxt8Xk=
X-Google-Smtp-Source: AGHT+IG4JMZ6HJp680LmVZy2zOGZi6HwVAUUpkqkRsTsEpdIdM/8Xb+GX69N7VX9ErR5uWRVQjGQhPdC8ZPu6f+Xclg=
X-Received: by 2002:a05:6402:2030:b0:5fd:6065:7bbc with SMTP id
 4fb4d7f45d1cf-5ff1974bdb0mr36661a12.0.1747086237584; Mon, 12 May 2025
 14:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby> <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby> <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com> <aCJi+4q6DZhnfdy+@ubby>
In-Reply-To: <aCJi+4q6DZhnfdy+@ubby>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Mon, 12 May 2025 14:43:46 -0700
X-Gm-Features: AX0GCFvmpjdHikKdkw34N7Kb0kusY6RJ94Zh2RqtPsu7KI7XKtdYoQ86B33brhs
Message-ID: <CAESOdVD_Cse6AjwLb-4QKjdo4ESWwF3FzSS5JaHbE6ZrMjFeZw@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Nico Williams <nico@cryptonector.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Remo Senekowitsch <remo@buenzli.dev>, 
	"Theodore Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 14:07, Nico Williams <nico@cryptonector.com> wrote:
>
> On Sat, May 10, 2025 at 01:31:32PM -0700, Martin von Zweigbergk wrote:
> > To me, the main benefit is being able to refer to an evolving change
> > by a stable ID. That enables things like `jj describe qx -m 'new
> > description'; jj new qx` (update commit message, then switch to it)
> > without having to look up the new commit ID after setting the
> > description.
>
> Notionally this is not different from renaming a file.  You have a name
> (file name, commit message subject) and you have the thing it refers to
> (file contents, tree object).
>
>   <insert sub-thread about why Git does not have inode numbers for
>    files, does not record rename/copy intent, and depends on file
>    content similarity checks to detect renames>
>
> If Git can do file content similarity checking to discover renames, then
> surely so can jj and other CR tools do commit similarity checking to
> discover commit message changes.  Is there anything that makes the
> preceding statement incorrect?

That wouldn't work in the `jj describe qx -m 'new description'; jj new
qx` example I used above, right? I think you're suggesting that when
the user runs `jj describe qx -m 'new description'`, we should compare
the reachable commits before the command to the reachable commits
after the command and then record in some storage that the new commit
is part of the same "change" as the old commit. Is that what you
meant? In this particular case, the commit message obviously changed,
so comparing the commit messages will obviously fail. We could of
course make this command record the information itself, however.

> > Given that we already have this stable ID, [...]
>
> "We" == jujutsu?

Yes, sorry :)

> How is this stable ID constructed?

It's just random bytes (16 when using the Git backend, 32 in the
Google backend).

> How would things other than jj construct these?  We spent many messages
> trying to work that out and in my estimate that wasn't settled.

Random bytes has worked well for jj.
