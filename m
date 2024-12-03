Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB811F76A4
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246091; cv=none; b=up9bwHUYOReoPboDWQCTMvLBK+iba5aQon4P5Vp8DyXnhgORj2ot9qE/ZJQSWgdc/85pM9NovwAnCzUdYyZQZMbN30OUYc3CswlXWxJuumrUG11EJkW6xOAvTuE3+oCQg4le+PD7SFUVdmumRZdvyd3uGw8y/c0va+DlikP/EYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246091; c=relaxed/simple;
	bh=MEcoFl01Cl2JWNTK/yrg+1NAgI3K39EH0IiXDnPbaDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etrnNF/gdILt/G5WoheiDBpg+aiaYRBrxtz4pc3ZhqDxuixqAkZZ8DgdctJxo/OHPlzYyYlOMAp9NyqhuLb2RvmvP9LMlkIbpcI1C8+3OcY93vDNB7VK5H27c9c8jcE/YaXAFRMFaAoXgxoc2q6tm6qWgwDF4fBGi+RBP057/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PfYIJi2n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfYIJi2n"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so9182a12.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 09:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733246087; x=1733850887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/RJn1IwZvrcH5i4i/TqcZvoefj3WUsjrdiTTFsGGQk=;
        b=PfYIJi2nOSNLsllao33OSXVQKdsIgAJ+RLUXKidh8LiTKI/8++PbfkdYgH6B8i1uOA
         YomVz7T+rcKdM5sQT16u3e7Zh95HytDztK0yx+9554VmPFDiNcbRamCtWV0t7eSV8GII
         v02nkJc0i0ll3YynTQkWHaC1vO5ryB8z3/wFN2OBs7eNdNHzVl0eLyrRV8hAFbDH+bW5
         wOFpcOanPav5hVmdsrta6D4hCKRadgiCeivZwl01oaKEJ67VxwRqJoU1bR5fTjT9SYU9
         JFBj5+NPz3ysnh6BbucJuLUnmcvR0jeK8cjtXQTMEkLr2IKhyjpzX19D7bhjTvSapBYZ
         Plcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246087; x=1733850887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/RJn1IwZvrcH5i4i/TqcZvoefj3WUsjrdiTTFsGGQk=;
        b=V0eE5F4FJhyzC7RnI9yjGn0DXqZughM7DSHBcqP+AVVIo5n9EUgYTjadRFQbF+yWCr
         lCe/4rpESRapXX0ufj7kd03QeiGYfqiT2UYDz++br2DUU97zn0LxnzR+1NlKNzvr7hKL
         U42b7R44q/MInzwSmVf0wbfZtnX3paViCWBlSJOsV+02/2+gdzN1sLB57ojaA94BF6jY
         fKC8vMUswFZEKhAU0ErrWvByEU0KZ4kVHt1c71O4adgr5qFgDtHZIgUj8n5Vszkz/i72
         hakNY29f+RdEj+QBxM2EvfO3ImQ1YdUST6uAtAtYKqTUHWZ4XQGkX3XUM7E351P/VFIU
         vAng==
X-Gm-Message-State: AOJu0YwItSMpvsF3xWhUyaLZkcZMBLnnx+HJsq+Yx428l2so59AHpF0G
	ghZAJ/GwSsmJNqKL/c8H1/td2td++wZ60UnOQof5WUyTHJOUJIKpiCI54+EDOQiFPh9YsUkPMDw
	rf2B5U6GD9syC/8EGEtHT15GNDwVrowpb+Keb79JRHohMvzZtOg==
X-Gm-Gg: ASbGncvV6sWrCNIIyvRxw6KOMU3WY4WL70TPFkn9SB4HgNausWcDiFW/ZE2HTRq+FrQ
	6ht1Cw28Kdfw0q95x0qCnRqkIbk9aY6yxHwy9Mfykkj+vNwO1OjgCjc82Okb/
X-Google-Smtp-Source: AGHT+IGqnsuey8DwkkVYo4z+N+K4y0oiz8nr9Q9phnquzKVAhzwRHjQQtgp0+q2PYdcGLkLlo0oM28ElNavF0FzXFVs=
X-Received: by 2002:a05:6402:4c7:b0:5d0:84a6:f1a1 with SMTP id
 4fb4d7f45d1cf-5d106a4fce5mr84959a12.6.1733246086919; Tue, 03 Dec 2024
 09:14:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
 <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
 <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com> <xmqqfrn5h8zj.fsf@gitster.g>
In-Reply-To: <xmqqfrn5h8zj.fsf@gitster.g>
From: Kai Koponen <kaikoponen@google.com>
Date: Tue, 3 Dec 2024 12:14:34 -0500
Message-ID: <CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The rev-list documentation doesn't mention that the given
commit must be in the specified commit range, leading
to unexpected results.

Signed-off-by: Kai Koponen <kaikopone@google.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt
b/Documentation/rev-list-options.txt
index 00ccf68744..f0a46f9da5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -412,7 +412,7 @@ Default mode::

 --ancestry-path[=3D<commit>]::
  When given a range of commits to display (e.g. 'commit1..commit2'
- or 'commit2 {caret}commit1'), only display commits in that range
+ or 'commit2 {caret}commit1'), and a commit <commit> in that range,
only display commits in that range
  that are ancestors of <commit>, descendants of <commit>, or
  <commit> itself.  If no commit is specified, use 'commit1' (the
  excluded part of the range) as <commit>.  Can be passed multiple
--=20
2.47.0.338.g60cca15819-goog

On Mon, Dec 2, 2024 at 8:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Kai Koponen <kaikoponen@google.com> writes:
>
> > From 447a2367f8d3318e69adccc1b011b0d04792e438 Mon Sep 17 00:00:00 2001
>
> Do not include this line.
>
> It is not a part of message, but merely added as a mark that a new
> message starts here in case there are two or more patch e-mail
> messages in a file.  Since you are sending one patch per one e-mail
> message, you do not want it.
>
> > From: Kai Koponen <kaikoponen@google.com>
>
> Let your MUA have it on the From: header of your message; you do not
> want this line when your MUA is configured correctly (and yours is;
> we see From: header saying the same thing).
>
> > Date: Mon, 2 Dec 2024 19:32:25 +0000
>
> You do not want this, either.  Your MUA records on Date: header the
> time general public saw this change for the first time.
>
> > Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions
>
> Put this in the e-mail header.  We add [PATCH] for a very good reason:
> make it easier to find patches in the mailing list traffic.
>
> >
>
> Here is where you "sell" your changes by explaining why we are
> making this change (like "existing text allows misinterpretation
> that makes it sound like doing this and that are possible, which is
> not true").  Please do not leave it empty.
>
> > Signed-off-by: Kai Koponen <kaikopone@google.com>
> > ---
> >  Documentation/rev-list-options.txt | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/rev-list-options.txt
> > b/Documentation/rev-list-options.txt
> > index 00ccf68744..1c678294af 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -412,12 +412,13 @@ Default mode::
> >
> >  --ancestry-path[=3D<commit>]::
> >   When given a range of commits to display (e.g. 'commit1..commit2'
> > - or 'commit2 {caret}commit1'), only display commits in that range
> > - that are ancestors of <commit>, descendants of <commit>, or
> > - <commit> itself.  If no commit is specified, use 'commit1' (the
> > - excluded part of the range) as <commit>.  Can be passed multiple
> > - times; if so, a commit is included if it is any of the commits
> > - given or if it is an ancestor or descendant of one of them.
> > + or 'commit2 {caret}commit1'), and a commit <commit> in that range,
> > + only display commits in that range that are ancestors of <commit>,
> > + descendants of <commit>, or <commit> itself. If no commit is
> > + specified, use 'commit1' (the excluded part of the range) as
> > + <commit>.  Can be passed multiple times; if so, a commit is
> > + included if it is any of the commits given or if it is an ancestor
> > + or descendant of one of them.
>
> As these files in Documentation/ are input to formatting programs,
> please do not reflow the text unnecessarily so that what you changed
> stand out, instead of forcing reviewers to go word-by-word to sift
> through the changes to see what got really changed.
>
> Thanks.
