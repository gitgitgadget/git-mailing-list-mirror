Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FE28CF52
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316532; cv=none; b=QNxs+4CEUzwzqB0eLl4EFKT1+tdJtv1o1Hy7cL6HANJjHf9O5b9ksl+Ve6CRtFdB//BgXY/I//ot21Bn9qg8oycrEi3fMO+ppZBG+CSOZapQHr5kUe7qhkzqE9zj7h/1plIrvFPSMqddWf10pzM5rG6Wt4OCEBIM+sdo7pqFS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316532; c=relaxed/simple;
	bh=EDkWoo4B9keGDGaDZqs3vCxnnJDBWXsQqAkv1SXDfgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQaGE5/EX7prFOqfGEy9K/PcBn9FQy2m2wIDqE/ngNIXWnsaEeMtNLOXqJCZ9Ld3zY5jL6TZpc2ZBj8smx4439gD+BrEM72AS4dqAum/UJkZa6MGANvPCZdfZtgSmrHMMDoLsMOH49DVo/P7NbG6dS8gl/Lb7dd4B9Sarj+a0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJqSf6F8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJqSf6F8"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-351c164936eso24147581fa.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758316528; x=1758921328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNUe3+Fx0GVMPzBtk0WbdYUHMwWzrYvLA9Jp6lwVCjQ=;
        b=lJqSf6F8QloE1107Jgi9G2h0RPnaB+KxHWDNYrLzHGit19EIplmR/lhWBqao3huPlB
         I1vNQ+yYwPFJk9cWtx9M/FRaBYLEzUfChhlT1QhCNOAfH8uiaanBKZXlSqLjk/A6JP+r
         SuOA5e+7l35Aj3gQBRUmprtCrOhkgOJVR3SWQ4DF3RZt9okUGN6vFXp/gaS5hqaiVlht
         4gH5LeKErjN2FhPI7jP+ijZ+BME3akFvSZSqppkC1qhTmlqSj3oUnLgzYQajWQs5DobT
         om6KxC4rHFAt/AKfK+rMvEzVIh3Iv2yTNerqaEsOH1UOIgVTy8eLLu66JAsXd6sqokYp
         rqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316528; x=1758921328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNUe3+Fx0GVMPzBtk0WbdYUHMwWzrYvLA9Jp6lwVCjQ=;
        b=Hvq6FCKABQrCapWb5t8VV164NC28iLV74WFIy8j0wboC6BslN092ljUMlZexzoT1jt
         LEAGwFzh7rOoSa7TR0d9iZ+BeDhS5wPyMBEu/cSlTaCFgeXo7CjWdUj1fQ5Ctn4NNC0Z
         jKTo92D3INRnmpLJ8GbF/JajB2XczTiWoIn+otQsym0aNG38xdOLFSys1SVU6oTVNm6B
         0hHsQHSVPNNxZHsQwTm2Xqhf0sOm+faNLq3oIeKQNc9VkJAjlq8Q6oPdZCUBH2VVnkp/
         F3JobPhIq6EKsi4clCU+MpAUpPHGN4EjcED/WEcU5xntfwA3XrErLYEbFzm4TbPzt+Bd
         hyvQ==
X-Gm-Message-State: AOJu0YyWFkiPPocUv6TB0GS355K4EUotl6k6pxCwDCX8Tq2YHOSACWA1
	c9juxlgcNhvmVhLRw978YEjkXYkRZt1FaM4dbwEp5mzdY5k88OoqUQDCBq+a+w0UfuO4yEC5U59
	Q40m4ALzsbw+u96Ju0x2C9j4+KMTYCDA=
X-Gm-Gg: ASbGncs3lXi/7KyTOMx6tg4qFMPy2B3bIhNMw5LWbt/eWJUq2ZPA3uCFqjj3UtWOk5k
	dqtrVM2SLY1xLBBKvDccFJC6NQaQksAzsj/kerKH1/25gQ+6ziNmBfJWheLJx7BIW8lQ8vYcDGp
	KqmqCgNtK+RxSTHOSXnfHhXmY04Pw912Fih4JS/UJeNxAaWDyA6HwlSxxrmwbiUvN4sXSRiEAwG
	m4yiA==
X-Google-Smtp-Source: AGHT+IEKg5cZIbM2+0NSbaZLGy87Lv5XWgkSjGt0KIlZ7Rwt8Ufe3l+P2MN/E7PFV2QqK2m34PvM4z4OuJuWY0WcYzg=
X-Received: by 2002:a2e:b8d4:0:b0:35e:2503:d53b with SMTP id
 38308e7fff4ca-36416cc6bc4mr13555791fa.10.1758316527985; Fri, 19 Sep 2025
 14:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
 <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net> <CACEPZDU2Bu2c9RFBwD499-UUNyQGuRRXNbMx0aBrqwGoc=4EhQ@mail.gmail.com>
 <aMyGHriNpmekoqD5@fruit.crustytoothpaste.net>
In-Reply-To: <aMyGHriNpmekoqD5@fruit.crustytoothpaste.net>
From: Antonio Mennillo <antoniomennillo87@gmail.com>
Date: Fri, 19 Sep 2025 23:14:51 +0200
X-Gm-Features: AS18NWC_8hGQduF7eoq5mFPF0qV6q_qJ-Q2IalIScYA-CfzaAhtcz_H7Hxmn2z8
Message-ID: <CACEPZDWgoa18LAhzOzu__jy8ssgR8-PmZb6gmDzCS=q6f25=wA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC=5D_git=2Drebase=2Dclean=3A_mitigating_a_=E2=80=9Csemantic?=
	=?UTF-8?Q?_conflict_cascade=E2=80=9D_during_rebase?=
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Thank you again for the feedback, it gave me a fundamental piece of
puzzle about Git's design constraints that I hadn't fully considered.

You're right about tree-sitter being inappropriate for Git core. That
approach is too narrow, covering only specific languages. My v2.0.0
already prioritizes Git's existing plumbing to track content changes
universally, with tree-sitter as an optional enhancement. This stays
content-agnostic and removes that which I can define as a source of
nondeterminism and heuristic complexity that it's elegant to avoid.

To summarize the mechanism:

1) Squash the feature branch into a single commit: temporarily
compressing the branch makes all internal semantic dependencies
visible at once, avoiding cascade conflicts during step-by-step rebase
with non-atomic commits.

2) Resolve conflicts once with full context: the semantic issues are
"suspended" in this unified state where everything is coherent.

3) Restore original commits by replaying saved diffs: using a
hash-based approach with git's native diff/apply machinery, the tool
remains file-type agnostic. The restored commits may still break
individually (e.g., won't compile in isolation), but the branch is now
rebased with granular history preserved.

To address your header file example specifically: when common.h no
longer includes stdlib.h after rebasing onto main, you would indeed
need to add #include <stdlib.h> during conflict resolution. With my
tool, you'd add this include once while resolving the squashed
commit's conflicts. The fix then persists through all restored commits
- so instead of potentially fixing the same missing header multiple
times across commits during a normal rebase, you handle it once.
You're correct that the tool cannot determine which specific commit
should ideally contain this fix (that would require compilation
testing), but it prevents the cascading resolution burden while
preserving the granular history.


The key point: this doesn't fix non-atomic commits. The semantic
problems remain if you examine individual commits. But it prevents
these issues from causing redundant conflict resolution during rebase
by compressing the timeline of the branch in a single instant "t"
where the semantic non-atomic misalignment appears simultaneously.

The tool trades ideal per-commit correctness for efficiency in
real-world scenarios where atomic commits aren't always achievable
(junior developers, emergency fixes, legacy codebases).

Regarding expectations: documentation will be clear that this only
reduces redundant conflict resolution. It doesn't make commits atomic
or understand semantics. It manages semantic inconsistency by
compression, intended as reduced dimensionality. The defects remain in
history but no longer interfere with rebasing.

I apologize if the code evolution seems rushed - v2.0.0 was developed
quickly to establish a working implementation of the core concept. For
v3.0.0, I plan to remove tree-sitter entirely to achieve complete
language-agnosticism. I'll also need to properly evaluate edge cases
like submodules and merge commits through integration testing, though
the squash operation should hopefully be quite independent from these
structures. My testing focus will be on ensuring determinism, proper
rollback capabilities, and full idempotency across all supported
scenarios.

The current implementation is available at
https://github.com/anthem87/clean-rebase/tree/v2.0.0 if you'd like to
explore the approach.

Thanks again for the patience and the attention.

Best regards,
Antonio


Il giorno ven 19 set 2025 alle ore 00:22 brian m. carlson
<sandals@crustytoothpaste.net> ha scritto:
>
> On 2025-09-18 at 17:02:59, Antonio Mennillo wrote:
> > Hi Brian,
> >
> > Thank you for the thoughtful response, and please excuse me if I am a
> > bit clumsy =E2=80=94
> > this is my first interaction with the Git community.
> >
> > > Usually we would recommend that each commit be atomic...
> >
> > I perfectly understand this best practice. In my context, working with
> > many junior developers,
> > it is not always possible to enforce atomic commits. In some
> > =E2=80=9Cemergency=E2=80=9D situations we
> > squashed just to make progress, even if that meant losing granularity.
>
> Yeah, I've seen that at previous employers.  Even where I work now, I
> definitely see differing levels of interest in atomic commits with nice
> commit messages.
>
> > Your explanation really helped me see things more clearly, and I apprec=
iated
> > the constructive (non-toxic) way you put it.
>
> Well, thank you.
>
> > Yes, rerere helps with repeated textual conflicts, but the scenario I
> > worry about
> > is semantic: if commit M changes an interface and commit N implements i=
t, then
> > changing M during rebase can make N semantically invalid. rerere
> > cannot solve that
> > =E2=80=94 it remembers markers, but cannot understand that =E2=80=9Cthi=
s
> > implementation no longer
> > matches the interface.=E2=80=9D
>
> Yes, this is effectively unavoidable because Git doesn't know the
> structure of your code or data.  For instance, in Rust, I could add a
> new mandatory-to-implement method to a trait and then all
> implementations would need an update.
>
> > That feedback inspired me to improve the tool. Version 2.0.0
> > (literally born today,
> > thanks to your comment) now works differently:
> >
> > 1. Temporarily squash the feature branch (so the rebase is effectively =
`1/1`)
> > 2. Resolve conflicts once, with the full final context
> > 3. Automatically re-expand the squash by replaying saved diffs, restori=
ng
> >    the original commits (with new hashes, as expected in any rebase)
>
> You haven't described exactly how this works, but it looks like it
> performs a fixed set of transforms (e.g., symbol renames).  That can be
> useful, but it isn't sufficient in a lot of cases.
>
> For instance, in some work on Git I'm doing, I need to include a header
> file for a function.  It was previously included in another header, but
> my rebase onto the main branch had it removed, so I need to add it into
> the C file I'm working on.  The only way I can 100% know which commit
> needs that change programmatically is to try to compile on each commit
> until it fails, and insert it there.  This, of course, requires atomic
> commits.
>
> In a lot of cases, I use git-autofixup[0], which looks at changed lines
> in the diff to determine which commit to squash the changes into. It's a
> great idea, but it has limitations, since sometimes a change logically
> attaches to a commit but isn't close to it in the context of the diff
> (such as my header inclusion change above), and sometimes I've changed
> similar lines in an earlier commit A (where my change should be
> squashed) as well as in later commit B, yet it gets attributed to B
> accidentally.  It's convenient and generally works well, but I have to
> be careful not to trust it entirely.
>
> > I would be very interested in whether the community sees this worth exp=
loring
> > as an **experimental rebase strategy** (something like `git rebase
> > --squash-restore`),
> > or if it overlaps with existing mechanisms I am not aware of.
>
> I think the fact that it adds a dependency on tree-sitter is kind of a
> non-starter for us.  We're currently having a mildly contentious
> discussion over the use of Rust in Git and it won't be mandatory until
> Git 3.0.
>
> It certainly covers some use cases, but it looks like it only handles
> deletions, file renames, and symbol renames, and the latter only for a
> small set of file types.  There's a lot of cases that it doesn't handle,
> and I'm afraid that people will end up disappointed by expecting it to
> magically handle a lot more than it does.  That doesn't mean it isn't a
> useful and valuable tool for many use cases, but users may have much
> higher expectations that it will magically solve their problems when
> that isn't the case.  I have some tools that I've written myself that
> are like that, for instance.
>
> I'll also point out that we try to avoid hard-coding known languages.
> People use lots of languages with Git, some of which are not even known
> to Vim, which has an exceptionally complete list of file types and
> syntax highlighting.  People also do non-code things with Git; for
> instance, I store my creative writing in a repository, and other people
> use Git for working on documentation or technical books.  As much as
> possible, we want tooling that works for at least generic text files and
> ideally, all files.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
