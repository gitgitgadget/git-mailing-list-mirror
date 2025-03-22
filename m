Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693DD1632C7
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650994; cv=none; b=Lz5uE6qxoJQ73zwjN7GDCeeEMd7EHi5n2r/7sVWyaYVEBsUnsK7qkIMtVFjSo3WkfgQrIBi1mQ3BUhZb2+f/CBv/6uspGkHHlg7FoEWjTzpEymbAjpA+kLRX8N30kP15+JX/EXI3E56xHA47zGGUNz1OAn9dyWXY+m5nvwghqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650994; c=relaxed/simple;
	bh=+/P73Z9w6Lh++C1CePIn3qj558FW371bOthftowhWnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y25KPUQL1q3U4GE7pStau2bNeb/wh0EvEukTKgfdCjUxnQCcCBjBX9SjzlHVk8HVAKHH4a4mgpHcddewEy5uViXEH1VPSuYc63pKVKOJxOFNtHOqc+GjXaOtp26z0ReBAjShjkzeHK3W9SMizfP1T9q355zadR3lbz8nd/ufocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgorioU8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgorioU8"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3b12e8518so637373666b.0
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742650990; x=1743255790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re7MC/1u9pcGzLuTR/rL2ptWtrr4bf9zL3R10gtvyQ0=;
        b=MgorioU8/SkJjPDZpYlMEdW7zKs0N+ANgmsslGtYY+NWJNxBQi7EsglM+kp84+vI7q
         lJE0Eaa9HNZbj46OfZ0sR6Xy4AqKvIuDSi+XvjscwR+KBYLzhul74XY9XntmMchOymxa
         QnKwOG+zOGJlIVEkfmZVOpJdYNxZNRRPpfU1xbeM46noj0lGpr6OGf9Ws4BsYjQJ9MKa
         N6mFM5NXJSloRu9QpSevHYfFp2PX5siSDlApEkLKvgzhzquAyJ25sCqJSipHK70+EgD4
         5rbGgjdWCG/cwJ8MCipcZU8yRX3WuIOYBrp3d5m1dXXnnDFoZkn1Jj+JCqfY5x1Nk1pJ
         dKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742650990; x=1743255790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re7MC/1u9pcGzLuTR/rL2ptWtrr4bf9zL3R10gtvyQ0=;
        b=nIMS0egg1LTAvOzaxQ7SltuxnbEwSvyGIjMrM3UU6087B/oSqqT/l+G613sIReAwIi
         LpM39jJ7LCEmv8tfxParueDJlokqJg2PMnJ61SHuEFDJFRoxpDSFNBMfbySmSKzsLq/A
         LESJH3H03Cse6EiqnkDLzOLcupB41GbQSo24MitwQrsCGynqVWI9re1Jrw1aXMkddp8R
         GPVOt7ZHJMi+XGbkQYinC0tV2QyUJhGG5skksViSI7G2mMsKJFte64syijbVEb2I2dBe
         9S692rBXaokgp2/TyD0vj45gG9zZkRIhtKn7IuqzFN/Cie0CSgPQ9Ou1yrq0ELVjYQ73
         QKvw==
X-Forwarded-Encrypted: i=1; AJvYcCUvh007OczU3EHh3IDvMrOR5DASUBOkoIxjBdl/qq9yr7LaDlWufsxjj8u1FqbrohO6vz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtqoGtmvU7vqW+SBli9Hiwq0qhyAXa/G/K6sXHXi9hcOUF/mE
	mVFNDQbNsZNZ2saMj2O2jMVyhXQMCeK6cs9c9gQdyLjhrr1Zy9kQybUnaXj6wnGq4B+8lYjFhoZ
	RBUoecL8dky2Vq/MmPC6jxBxfMFs=
X-Gm-Gg: ASbGncuGqJUFCh6UG+iYvgDlXB1D2biS8LZn2LzvCiF3xSx703KwB+wF6IvhcXImZYc
	9lRtSE6ctNKu60L2KPeZzVIMJhxevBtj38shAlzwMlXAynF3U7OM0qG4DNnSJcr9Y1hzq6gNORW
	PplKxAs1UiuvwQIp2f5E5jYZ/FMK3toCflRc7U
X-Google-Smtp-Source: AGHT+IHdyhqo+mtwwexwIFzwk2+nCh4FGFmI0l8DkQY3LqjR5SeVagY0+8fVwtcD90Sd+1G1M1xQSjIuelaYPSuR0mw=
X-Received: by 2002:a17:907:958a:b0:ab7:b30:42ed with SMTP id
 a640c23a62f3a-ac3f1de5aabmr740386066b.0.1742650990422; Sat, 22 Mar 2025
 06:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
 <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com> <20230320170158.GA2614670@coredump.intra.peff.net>
In-Reply-To: <20230320170158.GA2614670@coredump.intra.peff.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Mar 2025 15:42:34 +0200
X-Gm-Features: AQ5f1JqbnfzM4bLkqPKrv7AmOKWyXWf_8vvan208fdcGb2aWuLHkoN-2-SE5Y1I
Message-ID: <CAHp75Vf8bB8o9feJHe4FpNo0TnfoRLG+C0roD4a1OaqN3NDj-A@mail.gmail.com>
Subject: Re: git rebase issue
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 7:02=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Mon, Mar 20, 2023 at 02:10:38PM +0200, Andy Shevchenko wrote:
>
> > > > With the new release I have got an error
> > > >
> > > >   fatal: 'netboot' is already checked out at ...
> > > >
> > > > To work around this I have to split the above to
> > > >
> > > >   git checkout --ignore-other-worktrees "$branch"
> > > >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"
> > > >
> > > > which makes all these too inconvenient.
> > > >
> > > > Any suggestions?
> >
> > So, what should I do? Today I got again to help manually with my (used
> > to working) scripts.
>
> Running "git log --grep=3Dalready.checked.out" suggests that it may be
> b5cabb4a967 (rebase: refuse to switch to branch already checked out
> elsewhere, 2020-02-23).
>
> Adding its author to the cc, who may be able to say more. But my
> understanding is that this was probably fixing a bug (though I don't
> know all the implications of having a branch checked out in multiple
> worktrees).

FWIW, the last couple of versions (since I was not updating Git from
the sources too often, usually once per half a  year or so, I don't
know the exact version which fixes it to me, and I don't want spend
time to find that, because it works :) of Git seem to work properly to
me. Thank you to everyone who made that happen!

--=20
With Best Regards,
Andy Shevchenko
