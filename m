Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8497D098
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418864; cv=none; b=Olf21nfeImQj/N0l/+5a3A2Gt53SRy2QXmdxiCRTnAvIfOAD2Rd5tAeDqiVBW9X1tZRWyaUwbyE+t2p4weUpp+1U1cl++gtXw9oS4mW5qU4k6Hadjd9T4ZGXoJLjdjGyUKdbuZ3SrgVV6w/J/8o37MqVA5fAvYz3YYv5kihV0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418864; c=relaxed/simple;
	bh=mgMFTQ7vihhIFwu+ty6N2H3KSvTLDrVhJ25zva3wEr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9ZxARWU9eqFGdfbXZtD+0XsErYxrEbxQDONqxyCKzc4I5YmQz/anBEcZunzH23Y90XDOsoXEPJH82oczGAYQiJ/+Y1XHf4cm45rw6MtDhKujYsKnLeZ56tewmQwaGAATpliSDdDZTjJqMAC66r6Q33SLVbEMeq/cjQKfBDW+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+m+g+1L; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+m+g+1L"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-435764dabc6so263450b6e.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754418862; x=1755023662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsOKpYXpkgjBFh3J/fMJLMpQqfyHafIOIjaqMMEgz7E=;
        b=S+m+g+1LIM1MFPwZlFd5QI91DZVp6Yjd2W3LUizgATsWwkrmQkDrWSEuYXRsv8Fdei
         URgxkSc06P2enOQDJYS3SqAiSQGNBv8tTZk83b62WOYL1M56aJP4NcsS5lV2gAqV536e
         GVmrLTLDNnh84BaGWrQ5pfpXapGjTSFMJywV5zqH9OtZ0+/9ogK5wjAURnHXFLMa+SLC
         PM4rY9mj4zOXDjWo8tIv89uJiK1Sh67kaOMIU4IwqW3QPAOLsrQ/5fo8CROL/SYFhbQh
         icSyjUaduqmIdVcKUdhj4GkEEu89D+btKe3WMBMHC+ErTsJe0Gu1BkLsvZNy7beexoIR
         EMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418862; x=1755023662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsOKpYXpkgjBFh3J/fMJLMpQqfyHafIOIjaqMMEgz7E=;
        b=PLxvT9egwombx6HJwdGZfcCY8dKtvEW7awbnFXflWMVYgH/dW0GapUAHZM5TSQNqTK
         WPbjDI05H27pGz8P6E3qRKoLwrHO0JAfAdtW6fhtoxpBM8/x7dbO3jbUJQG0cI6ikPfM
         Kj7IKim7suLKZxAK9nzDXxF+vjMM30H7AzwdlmRutuq9M7mFsyf5WvPA1hY2VltzPAG6
         m7EAzGLOAmfTviXOxGKa/yMwBcVv9kkv7hJCC/ICvJHoGO3HmoSduGlZTFxjjPjdZMuN
         Zq0iqNSSYsNFMUCE8Cy/FzAj4WDEBwx5Yv6x1rv+RqAg2vly7RMFJn7zlv5SWoL6WAxI
         X2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7T1UuVbj9WzJqeIWReNNbb2rOy8gUL7FtG6MpWMEtkfV1njqUwGtBa1aO7DvR8XxchQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgNd+bskGosoLyPByaJ0J5S/eczGBUeqzac64iZRUKdEOVCqu
	XyIGTDpTuewYAYYr8vPR0Gnw1jpEidXI4AyYKURMBURIgp1anczVO/GtvsmWBUKkpZ8CmZn8ds0
	EcUljs8MrRfWhQQ3yRr0W1CjH5p1zWQE=
X-Gm-Gg: ASbGncs6dkPychILNcmIKOeKrqxkA5qHYKld7FYXAK94lOPijfeVKiN6RqvBJz0p0NN
	w308maTJHVO/w8xcd7N7dJCMU/GoLt6oDSxaq9ix2uTAN+zUrQuBZ60a4SlvQcUxllZMlUZ9Yb0
	REzW9vR9LYzpOfX8Gel6HVJHaxOaoMESPR0mifAsAsAb5Y4AvQ9gr9eE2hAoWodVlfTyujp/EAV
	vPmnazUjm6f3zr1+8uhWMfoz387JIdzPr0fsWuM
X-Google-Smtp-Source: AGHT+IGSnn7nC2Naona9/8oZx36KLiVjaQlfYQ4FOlZgc2uJAnLuHOQDLtSi/6UQjDOwf1IQuCdiwDWGWMnwZz4z+To=
X-Received: by 2002:a05:6808:124d:b0:435:73cc:5b6c with SMTP id
 5614622812f47-4357a024b55mr150927b6e.3.1754418862163; Tue, 05 Aug 2025
 11:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <2c7d4e022c59609bf263a7045fceb1854441bb29.1753197791.git.gitgitgadget@gmail.com>
 <aIx7SXfRabJWpa0D@pks.im> <CABPp-BF_UGf2VXvkAj=nkEPwo=FVQTgVvrDFURkBnFv4Wkiknw@mail.gmail.com>
 <aJGK6XFdmYj50I9J@pks.im>
In-Reply-To: <aJGK6XFdmYj50I9J@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 11:34:11 -0700
X-Gm-Features: Ac12FXyGDjJUgEMV4RfrJrCGvTXOhtLJHB8lsurpJrp3cWOGeMJE9qt8O0UlcGs
Message-ID: <CABPp-BFnA0QV0BuJOLij80d2JXJt1h9vvNm+oFuwW2Gahdtc4Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] merge-ort: fix incorrect file handling
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 9:39=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Aug 04, 2025 at 03:08:50PM -0700, Elijah Newren wrote:
> > On Fri, Aug 1, 2025 at 1:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > On Tue, Jul 22, 2025 at 03:23:10PM +0000, Elijah Newren via GitGitGad=
get wrote:
> > > > Further, commit 98a1a00d5301 (t6423: add a testcase causing a faile=
d
> > > > assertion in process_renames, 2025-03-06), fixed an issue with
> > > > rename-to-self but added a new testcase, 12n, that only checked for
> > > > whether the merge ran to completion.  A few commits ago, we modifie=
d
> > > > this test to check for the number of entries in the index -- but no=
ted
> > > > that the number was wrong.  And we also noted a
> > > > silently-keep-instead-of-delete bug at the same time in the new tes=
tcase
> > > > 12n2.
> > > >
> > > > Fix to merge-ort to prevent multiple bugs with rename-to-self cases=
:
> > > >   * silent deletion of file expected to be kept (t6423 testcase 12i=
2)
> > > >   * silent retention of file expected to be removed (t6423 testcase=
 12n2)
> > > >   * wrong number of extries left in the index (t6423 testcase 12n)
> > >
> > > I think it would have been nice to also go a bit more in depth for wh=
at
> > > the bug actually was and how it's fixed. You do add a comment, but th=
at
> > > only adds a single sentence of context.
> >
> > Would something like this help:
> >
> > ...all of these issues come up because in a rename-to-self case, when
> > we have a rename A->B, both A and B name the same file.  The code in
> > process_renames() assumes A & B are different, and tries to move the
> > higher order stages and file contents so that they are associated just
> > with the new path, but the assumptions of A & B being different can
> > cause A to be deleted when it's not supposed to be or mark B as
> > resolved and kept in place when it's supposed to be deleted.  Since A
> > & B are already the same path in the rename-to-self case, we can
> > simply skip the steps in process_renames() for such files.
>
> Yes, it would!

Great, I'll include it in the next round, which I'll send out soon.

> > > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > > ---
> > > >  merge-ort.c                         | 11 +++++
> > > >  t/t6423-merge-rename-directories.sh | 69 +++++++++++++++++++++++++=
++--
> > > >  2 files changed, 77 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/merge-ort.c b/merge-ort.c
> > > > index 9b9d82ed10f7..feb06720c7e1 100644
> > > > --- a/merge-ort.c
> > > > +++ b/merge-ort.c
> > > > @@ -2873,6 +2873,17 @@ static int process_renames(struct merge_opti=
ons *opt,
> > > >                       newinfo =3D new_ent->value;
> > > >               }
> > > >
> > > > +             /*
> > > > +              * Directory renames can result in rename-to-self, wh=
ich we
> > > > +              * want to skip so we don't mark oldpath for deletion=
.
> > > > +              *
> > > > +              * Note that we can avoid strcmp here because of prio=
r
> > > > +              * diligence in apply_directory_rename_modifications(=
) to
> > > > +              * ensure we reused existing paths from opt->priv->pa=
ths.
> > > > +              */
> > > > +             if (oldpath =3D=3D newpath)
> > > > +                     continue;
> > >
> > > Makes me wonder whether the additional brittleness is worth the saved
> > > `strcmp()` comparison. But on the other hand we do have tests now tha=
t
> > > would break if the memory allocation patterns ever changed, so that's
> > > reassuring.
> >
> > There's no brittleness here; one of the many optimizations in
> > merge-ort.c was to intern *all* pathnames in struct
> > merge_options_internal's "paths" member; any code that needs to
> > generate/compute a filename that may be part of the merge must check
> > if that path already exists in opt->priv->paths, and if so use that
> > pointer instead so that all filename comparisons can be done with
> > cheap pointer comparisons.  See the big comment near the top of
> > merge_options_internal.  Nearly all such
> > string-equality-via-pointer-equality checks were introduced about the
> > same time, and in other functions, which makes this one kind of an
> > outlier.  I figured whoever reviewed this patch or ran across this in
> > the code might get surprised by the pointer comparison, so I tried to
> > add a comment to address any questions.  Looks like I wasn't thorough
> > enough (and the first paragraph of the comment pre-dated my finding
> > other bugs this patch fixed, which makes it slightly confusing), so
> > I'll try to see if I can improve it for v2.
>
> I think the current version is good enough -- it feels brittle to me,
> but I don't see a strong reason to change it.

Okay.  Note that if there was a strong reason to change it, the logic
to do so would mean that the pointer-comparison-instead-of-strcmp
optimization used on pathnames in several other places of merge-ort
would also need to change, because they are all based on the same
interning-of-pathname-strings to allow that optimization to be safe.
I did notice that the merge_options_internal comment on the paths
member could perhaps be improved slightly; I'll include that too.
