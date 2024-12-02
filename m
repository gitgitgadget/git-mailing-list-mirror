Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40284800
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168734; cv=none; b=miXGXEBUQy/hn+w+QeKFYtXvp4+gFOErrf+fCoa3SjXwfz0RO2Pqfvqn4h2umOkGhtU4S7etpXPsghFZ+7BEFYS4bMTFpOGl8+Rx5zjQeHBLo1ugGidfcsbqC1qsmo3b8uBEAoUzm69dUK8w12qZHoC06smpLK3n+FHPxcTm0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168734; c=relaxed/simple;
	bh=3Z5gwff6E8WyVp54N7AAhwKNnUH+iYLZ1VzPjplQ93A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4GpDdvxfa4cHDatFMINebZcuegFdtcNfbg87C2goYW8Wh+/tNJ1pVtmDwAVj2aJK82H5IYqb/ZsEumbLy58gJPXmkxy8KrwMx4h09dsiAmMZ0MKe/1a5ptHkcGCFkLQ15p4yV8DxNo1vK8d6oAKUBwJa1XxEKMYSrvdxmUZdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlaykZJL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlaykZJL"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so35730a12.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 11:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733168730; x=1733773530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffwbeWdx7GrEsHe3o+ifFIcIeO4A01e5jtopfEHQ3rM=;
        b=MlaykZJL9XbNLOxuCHaqZbH44jNRZAVZtYc6OkKB3RwuLlAWAeBcOEY67EIc0+Lzvg
         M2oQgDF9J8eAoo35cO+fOmUQx/Pg29kRUZvcbkUJrD24CbHuytCrgA7ec21FcppdWI5R
         KVGhnuPQCBW/MBEVuJb8yg4LLhWwxdgV+iowFzr0+VHs0Lv2FAw0jI7Kh5T9loZTBjgV
         UNMmyGd2dAaVM1iPPviX+FUWO4hqlpoEr1S9k5NtlJCe5asXkAdEFXKVY1sU9CqfmOOR
         4VgPalFM19nSbLC6DVTfsl8dfdLI6q/8m1nHy/+bk7lQA2UMWJNGPTMmvPnYTeUXo11T
         DX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168730; x=1733773530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffwbeWdx7GrEsHe3o+ifFIcIeO4A01e5jtopfEHQ3rM=;
        b=VVAZeLludmNb8FcMJNo64enn6dw2cTQh/N1FNMYbQYdwlO5ObpT/oYYz9nZk5l0ypK
         XmpeNMk9OWAE41G0GlClaQSbtx1h/DUKyMz8FyFEn4hY5RpAzBYjWlxRcqJcPAwU6F6x
         NuWiQ4EYdqKj7QGS5bfMHu60QLTJnwxEjWyMHeRiTYw9qHujDy+NAh2zSBjSbyD/YEWM
         I5pRiWM5nUGxvyi8ALz89J9+dKyMHxLCjz+yCDtpkucRrnl+hRqjnI0hawN4SZCqv+Gl
         KofUEW0J+dEtKRQ05hFlGHpjYlO8nDwazEAuubssnP8yLVLqBc+bT1qRDJlWihIxNO9h
         HPcg==
X-Gm-Message-State: AOJu0YzMJKwykCQ7TcgIby5u4JJdtPE0ltuLy/xYrjJrdOiIPA8XPaMa
	fqHxO867sLpX57jQV26A7c4uaTdPXhMFefsMcKo17IVmQ+otm7iBq6cvO2clxbzWXF9vrDoHcaj
	TvMGTkd4J9PPOVCZA2q/Tv7FfDKEfRrh4y8ET
X-Gm-Gg: ASbGncukuvyDodv3ZSO96mOgRg+VQmAzjCF8/kxf20iHr6XXpH9UfxdCfDoudUn4+R2
	YepTp8wwuzDcADtZ/g8rDs5xYWW5YuL0hHTANRj7yqLgEhS0dVDIzZZWVfSbe
X-Google-Smtp-Source: AGHT+IFpG1oI2UfmDpljdtTEFVcT+thaUTbncJV9F3p/rQ3ary+u4DUgCODFi1bnxWEBnHHeA7WHIOkYwSZGmSMa5IM=
X-Received: by 2002:a05:6402:35c2:b0:5d0:a982:91a7 with SMTP id
 4fb4d7f45d1cf-5d0a982a46bmr241922a12.6.1733168730348; Mon, 02 Dec 2024
 11:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
 <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
In-Reply-To: <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
From: Kai Koponen <kaikoponen@google.com>
Date: Mon, 2 Dec 2024 14:45:17 -0500
Message-ID: <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
Subject: Re: rev-list --ancestry-path with arg - bug or undocumented requirement
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From 447a2367f8d3318e69adccc1b011b0d04792e438 Mon Sep 17 00:00:00 2001
From: Kai Koponen <kaikoponen@google.com>
Date: Mon, 2 Dec 2024 19:32:25 +0000
Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions

Signed-off-by: Kai Koponen <kaikopone@google.com>
---
 Documentation/rev-list-options.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/rev-list-options.txt
b/Documentation/rev-list-options.txt
index 00ccf68744..1c678294af 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -412,12 +412,13 @@ Default mode::

 --ancestry-path[=3D<commit>]::
  When given a range of commits to display (e.g. 'commit1..commit2'
- or 'commit2 {caret}commit1'), only display commits in that range
- that are ancestors of <commit>, descendants of <commit>, or
- <commit> itself.  If no commit is specified, use 'commit1' (the
- excluded part of the range) as <commit>.  Can be passed multiple
- times; if so, a commit is included if it is any of the commits
- given or if it is an ancestor or descendant of one of them.
+ or 'commit2 {caret}commit1'), and a commit <commit> in that range,
+ only display commits in that range that are ancestors of <commit>,
+ descendants of <commit>, or <commit> itself. If no commit is
+ specified, use 'commit1' (the excluded part of the range) as
+ <commit>.  Can be passed multiple times; if so, a commit is
+ included if it is any of the commits given or if it is an ancestor
+ or descendant of one of them.

 A more detailed explanation follows.

--=20
2.47.0.338.g60cca15819-goog

On Tue, Nov 19, 2024 at 10:22=E2=80=AFPM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Tue, Nov 19, 2024 at 1:53=E2=80=AFPM Kai Koponen <kaikoponen@google.co=
m> wrote:
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > Create a toy repo with commits in the following structure:
> > A - B - C
> >      \
> >       D
> >
> > Run `git rev-list --ancestry-path=3DD A..C`.
> >
> > What did you expect to happen? (Expected behavior)
> > Commits A and B should be listed.
> >
> > What happened instead? (Actual behavior)
> > No commits listed.
> >
> > What's different between what you expected and what actually happened?
> > --ancestry-path with a commit arg seems to return 0 results unless the
> > specified commit is itself part of the range. The rev-list documentatio=
n
> > does not mention that this is a requirement.
>
> Yeah, the commit message that introduced --ancestry-path=3DCOMMIT did
> document this in its commit message (see
> 257418c59040c13bfa839e01922e21833cda6a52257418c59040 (revision: allow
> --ancestry-path to take an argument, 2022-08-19)), and I think my
> original documentation patch was a little clearer on this point, but
> when Jonathan suggested an alternative for the documentation
> (https://lore.kernel.org/git/20220818222416.3567602-1-jonathantanmy@googl=
e.com/),
> I didn't think about someone attempting a commit outside the
> ancestry-path as the argument.  My bad.
>
> Based on the references above, would you like to suggest a
> documentation patch to ensure this requirement is documented?
