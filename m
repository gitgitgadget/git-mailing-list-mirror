Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF451B87C4
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559063; cv=none; b=JamDnbqgK5sGAMvqwf+Pa6yF0hVLnJN8w0Y/uZphcxciXHp9ZYPpbE5iObN2670tCxEU3kHA/SGu2fFP1MnC5st/Cf8oEIvF3+M0oKQnficZ+vXLjDfVaqpl2L0I/QqSiViBzZA1lcu735slcZw5R2E6GD6/ru+cPn4XVHLgGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559063; c=relaxed/simple;
	bh=RztdIbEra6/MQJRncgy0cdd7o96i82wsH67iD8n2u7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM4bCT4pgkOHi7cIGzCBHL77J06ixIxWvXOw197u7g80HtskeGvS8zbTn/+WmXHO5bgZFEqHm+ATmbJFdbFNJOqBczeQtReAei94Llk0kyKXGFG58KsdT7qAKQkOUO3X8PC8hcGeBoLRMURsefdk1rCza1VQOeHZBLhShbILpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPDW+Axh; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPDW+Axh"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-84197b4e61aso47617439f.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 10:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732559060; x=1733163860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhH5ZcT5THjuDZuzFcxZZ1/vC0svDX+1mNbFeHw75do=;
        b=QPDW+AxhKMYv4ggDHYO9LFAbm9lIrMsD5sBPB+uP6PXlPnPSI7swOOXQ7Akb65awQd
         qy+Boz8kMiDnmIWgMYlLV6sxfLO//nvIlkmbS1dwHYlYNpvtqCvxa4RXs5rSLta2iA6G
         xp3ocrlGciBVkP6c75IgbR/GaRocVFE2517NhON3PXboCOc7iJi21KTIpba2AHCeu3A4
         QE0/iL+Yzr8Srd5b2WNRh+mJ4mEOepwMUsFU5oKfQh6kf9ybjhA6MEFsStSz6I59FEG4
         scq6g69ud8BJgznvbKvwTPWzheimcY56APwDkENRGMqT7Qu6awYoqpVDW1B118i6GqE5
         /fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732559060; x=1733163860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhH5ZcT5THjuDZuzFcxZZ1/vC0svDX+1mNbFeHw75do=;
        b=eA2kzjoybvzoIyIaY3htafK2Nm6e+MFBtsvmIPDaDGMDvo1MpSnYVhIKD4lMFb64Fw
         7OTSNrKA3Pq4DrUYftDm7l50xw7czXNu7jFnIcriqqjGl+IpSY/iTk407Ll4fTPiOgy8
         W2FfXoz5An/vuarlEazeEDjJg7HH0BBHs6pjbVhAdTcx72txkDrLi+P+Y/kbM5lF1ire
         UgGvhYIB1I9IkS28deM2Cc34gPthIHzdQErmm0DbKF2E5lYTbZko1Ql/K8Q136hmPswU
         ZNv7EbQGH13CwI955Vy2+yXslcxgkLVqPR5VLTQzfmSvuDPjWTq3Yw7UGuGD+71j81pi
         Rwwg==
X-Forwarded-Encrypted: i=1; AJvYcCVhCy9JlBUomlIwyqtta/YtEKlcFh4YdoEbykciobm22VuzAobN1i6qmQzu5v2UZ50WIjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aSqSUATW4DpPgywrmfPrHP+lifCmI+msl+/0AdV/SBvB9LFi
	8KYS+9nKi5F5zl+Hy3lc70f0HlNqePLzTyk8vSMKK8AJfdfcH0zCbcrY24VSKa9Q/M8uw5lRDTp
	S7OhNYsgTQ+6EodF/SUvVWbBSRH0=
X-Gm-Gg: ASbGncuo7OJWbUwoI3XY2zvKsqNBC5tjGqbtjlzwg3UqcV1nVNByQhxwXSWa7K+Xp5t
	yQiG3gBTWcV1waUMqeN/AP32kl14m4Rwt0m7PrxCe51w9A15P+adSuZDLuOQvTBgR
X-Google-Smtp-Source: AGHT+IESHUMMmh8C85xC1ELatG/sfDokoC0CMLOud8akCUF09BPXpjrpYlCnyPn479EzfZ2fVIOs8vvp4tCp0HXg70o=
X-Received: by 2002:a05:6602:1350:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-83ecdc4ef80mr1643075739f.3.1732559060599; Mon, 25 Nov 2024
 10:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com> <CAPig+cReWbkomYYNAY_Q+6ezukSt8sZ+Q0MP=45DY4XeS3M==w@mail.gmail.com>
In-Reply-To: <CAPig+cReWbkomYYNAY_Q+6ezukSt8sZ+Q0MP=45DY4XeS3M==w@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 25 Nov 2024 10:24:09 -0800
Message-ID: <CABPp-BHCRmzb1LwwhZWwPc6Gs5BP-UMo6qgywcYz9pWppM06Jw@mail.gmail.com>
Subject: Re: [PATCH] fast-import: disallow "." and ".." path components
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:15=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Mon, Nov 25, 2024 at 12:58=E2=80=AFPM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > If a user specified e.g.
> >    M 100644 :1 ../some-file
> > then fast-import previously would happily create a git history where
> > there is a tree in the top-level directory named "..", and with a file
> > inside that directory named "some-file".  The top-level ".." directory
> > causes problems.  While git checkout will die with errors and fsck will
> > report hasDotdot problems, the user is going to have problems trying to
> > remove the problematic file.  Simply avoid creating this bad history in
> > the first place.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > @@ -1466,6 +1466,9 @@ static int tree_content_set(
> >         e->name =3D to_atom(p, n);
> > +       if (!strcmp(e->name->str_dat, ".") || !strcmp(e->name->str_dat,=
 "..")) {
> > +               die("path %s contains invalid component", p);
> > +       }
>
> Probably not worth a reroll, but is_dot_or_dotdot() might be usable here.
>
> (And -- style nit -- the braces could be dropped.)

Good catches, thanks.  I think they are worth a reroll; I'll send one in.
