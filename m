Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41972512E4
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219217; cv=none; b=BntA0wzq/XlAMJ3dzvgE5yUF1tmslOy2eCnS0z5SgvRAXLQ83KlBTTdi058rP9AokUJLgEA22h/jhEo0Kaw+DFsQtzDrVlhmUePguH/ch6QeoxxZVyUbQ+E51ljHq8lEW0ybdnerd5YGtwTizEcylanlhUFC3VpXx6AIgU3frbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219217; c=relaxed/simple;
	bh=E4EqOLWhzpKZgFCyu8exaqJdCR9peJWcuRdRC1hfMpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6LxolzxUavcsjpyct85EUqLNAhkpy3fYa1rlpcn2qTnHGuElYzXYyt/flw9DwdvmHiMS88a+MCKZCJfqMOo0g6m7HT5sJRgqlff3uhK3Ya0hObFWJeJ6hh0U8k3JoyHxVLC6jeHj6r18N87AABqEGY8W2ESNnPWrQMZ3XfceRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEwYwQ4D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEwYwQ4D"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so900393466b.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 12:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739219213; x=1739824013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4EqOLWhzpKZgFCyu8exaqJdCR9peJWcuRdRC1hfMpg=;
        b=XEwYwQ4DVXM6nzewJAabF/Zyfs5vNhvC5r2XaMavS6GrA1qX8X11Jb0kMC1OUqasIl
         jsA/TuSi+NrhIHjxtbH8FS9GCccUYGixkX+OJ+Ykn1TA+WhXo23EUOmaI1S1nbVmg/uN
         NJRmCW91kwFlI+d8P47WKo3PxUMOXlIiZw4RYRlnNhL6cEdtUlWBGVwgkfEmBixZeZbf
         1b24OL0h7nzxLKsPK4wVIEMC/tWa5RacVHH0RFOdRAFKRWNriuk2q8wbaRZeSMHG2wl3
         uTSzN5dHe7J9X5bFzevd8KTSUzGy5c2/hqAurbW+A38yOGu3rLaDxEojBuodooY3hvbv
         tmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219213; x=1739824013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4EqOLWhzpKZgFCyu8exaqJdCR9peJWcuRdRC1hfMpg=;
        b=OqZU/5cB89FNrI0TZWO6Rq/F998QjVkeHGfZiAPP8e6O+c8xAf1+atbvsCW5YdFqg/
         +Tec863Wotw95CZfKu7AyeMhD4VCHTAJUmt31j/RfpTgcwcquhfapqGexZig65LeHqUm
         M4lesL6U9MvAQJFhn7vS9FRln3HpCZKZ79gqFS/dqMh/de5HppLqS9UkJ/Czy8FlEX0J
         SBoUzDHrEMBOZnSS2zYTCALlMApt5Q8Jnnj+b8413lWgXmg6QOwQSpw167H5A0poYmwy
         XLiWQ/L5lgYvBvaBsI8h2eYq2NW9unDgd1F44j148E5znMKCBH6BhcqUJqoDOGvjDFDY
         qdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzJqXmWZppAqCI4IqisGoif8iCNH5InBMpqrYuGqgnFpn7oOXfokkyR13ESujGd5CJEJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNs+vN6Zhb/PVfOq9BONV8G0dl+GicGFIQl7KXj75eoNKP3OCZ
	oumt+Jid8OryXteYcUZJ61PB1MPj0H7r3oQUR5rxGIbInTsgPinbmLBvSD2ROKcgBYe54UFio3B
	F0tvdPfLILTx+Pa+Sf7r0YH1VlXE=
X-Gm-Gg: ASbGncvyRf0THzzvOdBdKy3K0mY41nErFi1sxLttM+NadaLvxDqVpa+i8P8zLgrpZtO
	YJRKcAYFHcUr3DSIaXFJKKl+epSeic0sckyasrRiA/xK98Nkl9Sn1tfY/m4x1aavnNP9dtCxeDo
	0QRPe/+nG7ugM7vXY4siLhXQJEzjY=
X-Google-Smtp-Source: AGHT+IFDw9NIwVTxl0ChSqWwpEc12s5xMOX2TyAiK0gGdJ+BTQIVQDlpcz40W+K1nQCufqYp71vJ7uzpocxo58z3Wpc=
X-Received: by 2002:a17:907:d8a:b0:aae:b259:ef6c with SMTP id
 a640c23a62f3a-ab7897dfdebmr1393308066b.0.1739219212856; Mon, 10 Feb 2025
 12:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g> <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
 <CAMMLpeQvJUZJuwvK-H=M_FFedpgazGOPH=7wvPCg3U8RrxEtkA@mail.gmail.com>
In-Reply-To: <CAMMLpeQvJUZJuwvK-H=M_FFedpgazGOPH=7wvPCg3U8RrxEtkA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 10 Feb 2025 15:26:41 -0500
X-Gm-Features: AWEUYZlY5XsDi2pXXLtp9H-YetuyMlzpwbh6Dmk9r1tCvOAC2aj7eD2-sHCmZlc
Message-ID: <CALnO6CDZ=rq_eZESzi++VFk081ddosHMpKQV4QHNFJbnsOMAzg@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:36=E2=80=AFPM Alex Henrie <alexhenrie24@gmail.com>=
 wrote:
>
> On Tue, Feb 4, 2025 at 8:11=E2=80=AFPM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
> >
> > When running "git pull" with the following configuration options, we
> > fail to merge divergent branches:
> >
> > - pull.ff=3Donly
> > - pull.rebase (unset)
> > - branch.<current_branch>.rebase=3Dtrue
> >
> > Yet it seems that the user intended to make rebase the default for the
> > current branch while using --ff-only for non-rebase pulls.
>
> You make an interesting point. The idea is that more specific options
> override less specific options. In this case, "fast-forward only" is
> more specific than "rebase" (because rebasing might or might not
> fast-forward), but "my branch" is also more specific than "all
> branches". So which option should win? =F0=9F=A4=94

Precisely! I think "my branch" is most specific here, but Junio's
argument is (if I understand it) that pull.ff=3Donly is _stronger_,
regardless of specificity.

>
> On Wed, Feb 5, 2025 at 2:14=E2=80=AFPM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
>
> > Is there, then, an existing combination that means roughly to treat
> > `git pull` with no other options like this:
> > - if not rebasing, forbid merging and be equivalent to --ff-only
> > - if rebasing is requested (because of branch.name.rebase or --rebase
> > or =E2=80=A6?), allow it
>
> I think what we're missing is a branch.<name>.ffOnly option to make a
> particular branch fast-forward only. Such an option would be
> especially useful for the master branch, but you could set it on all
> of your branches except the ones that you want to rebase. We could
> even have a branch.autoSetupFfOnly option to turn on ffOnly
> automatically for new branches.

That is probably something that is missing, and might solve the
problem, but I don't know that these in particular are something I
need (read: want to implement).

How do you (and Junio, and others) feel about
pull.ff=3DonlyUnlessOverridden? The meaning would be "like --ff-only
except when branch.<name>.rebase says otherwise."

The name of the value can be workshopped (I initially thought of
"override" as a short value, but it may be too short to convey its
intended meaning). Perhaps "onlyOr[Branch]Rebase"?

I think this would be a smaller change that meets my needs without
changing the meaning of ff=3Donly.

>
> -Alex
