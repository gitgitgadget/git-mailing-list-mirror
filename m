Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816828E9
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754009; cv=none; b=YYa0HrXwVU/Bx8V1rGNW8/NZ/THLjHb4xwuqvQJ4ocC6vJrNRNLAblgLJXRaOgB4Dd9YxU65M7OFmytJr4fwH3wILDZyNEh1qiDzi+rVCgSF5LuMYuq26Dz8nqCYih7EVKxKUkq6mwzpxphou4658a6ahYwnyYjkTM4BnxHvXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754009; c=relaxed/simple;
	bh=UWoqdnEzBF62IAaXlufwB0dqeaH7abVyVBx8dF3QAMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUiFZpF26fFGWfRoH3fSbGUB0RlJYwKC1NPamSvbQER5+juHreDiil7v+pqAdGQ6bePi4/nMhzRVDkHMi5i3MxANPhAXaEu61Ng2hqU1RVYEG41KquC+mEVAjWRZJgZlhJ0DIPoSgoeGfeHuVW4eVv5WPEGD/vzfpamWcfVAYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmZstayZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmZstayZ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso3217651fa.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758754006; x=1759358806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZBNak23Po/tejGhqC9OXeL3h2/FGXTEqiAFvJekIjc=;
        b=cmZstayZ0hmG57q8gQ9gSmjjr6LWVSp29kTxI5DhAyntMAzBCaVBeKLbAoYOFR5dyt
         7Wy0+s5Z2fcfoMSAU1vNaaZGIbyp8DUOz5Rld1bv3UdPJnuNWfTozEnqc0S3nbpO6GuP
         hhpbns0e44RGWXIPsaSTPEOsUyt/F2cjKE+UNnR4RHcNPfirL9LKZU0vVJkjvsvyY5va
         mWyCQQ6HOjQHZwF95FA7NBpHaw3Ubetq+s0c1UuzF15sJg27QMbExABxDmY8BLNoR7E9
         89hCWB7YgS7SbkfreGcHlSiGKje4e57xk1uACSJ0Gdyd+sWa+LAo7+Jg1u0h8ARwJrHH
         HHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754006; x=1759358806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZBNak23Po/tejGhqC9OXeL3h2/FGXTEqiAFvJekIjc=;
        b=ryJLq/746IXb/mViKApZm3i3TglcddVekisw59wkVCEnpU+e3sfpcpPIKtl2DW2Oei
         ZWGb2fORPp2UjKFNQB2ANEfn0qll8g8LGpwfKF+27gQ6EVCGJ+qovJ8JU4CrDblRsw7F
         WsnTC4smatmSas6YK2PDIyBQuxeL2MMwjc3ICbqXaZp+ejTnd8FbV8bI29NEvNvsKxuX
         195RwilL9yD7dk9WwnqMraJ2cm7EbFm7DGwg8wUzuqaIZsKx8whaZPPmSGOuYkmtLUqd
         iKlNKRg0uoufvCBXlYBo35OApIkNp1m94689ZyP5JyLaIxPGub5f/VrvWbgT/h4KEqyb
         j1wA==
X-Forwarded-Encrypted: i=1; AJvYcCWUyGine1vt64Uu9cUxqNG9F//abax9xk7GRB3cNuzv6MJSI/DCzIRQ15Lnrw3ZXHbjc90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeLMPx+FqD/kEt0B3L02cpgUyMb0UbV2GQSNvfyVjd8EN3ZbN
	tpvSRs038oCDJSOmA/Fycw3Y39ULc6o2XUgoi1Lm3DtYMZmEwNmmaC1uiAjjS9628jDievOv2pU
	zSvKLeKHAw0wYcd6WJj66KizlX/aQ1MWXhfHHzjOmlg==
X-Gm-Gg: ASbGnctrGoYPoF9097iuPEipIFgTtWmbIIftmYbke7s3veZ0eJzatqF3hdaSDN59Oen
	xvdAESYXN4pGkRMX1eoBEYUXim1ZC5Mffs4z88vVDM31fd78WKGXf7FtQiBT+JWR5hIRp2iwHuJ
	ZD/Dy0/MUmM7qYNbZqRsVNAjcIM7of7kBf+l705Lphk2fn4okm8f28pzlyYtDhAE/ynucIP1Hpj
	SMOKUVl
X-Google-Smtp-Source: AGHT+IHAaVdvbghexyQzUU26H4iLAsON7M4orW1GwfUZl464ycTmHCCsMrcngNHsMRUULgBogBAizdJuQklmlkq1z80=
X-Received: by 2002:a05:651c:2551:20b0:36c:983e:479c with SMTP id
 38308e7fff4ca-36fb318e7f1mr1000531fa.20.1758754005601; Wed, 24 Sep 2025
 15:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
 <0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com> <CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
 <xmqqqzvvn9tq.fsf@gitster.g> <CAH=ZcbAcvoXJYPHE=mcZSqPLuUPxKcSs-vd307X7uXi+aG3evw@mail.gmail.com>
 <xmqqikh7k05r.fsf@gitster.g>
In-Reply-To: <xmqqikh7k05r.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 16:46:34 -0600
X-Gm-Features: AS18NWA5KJCjp3pQkZbG8y3_Aa-9KiKmOjHkB-4iXDdXlZj9MXFFwq0SY9sEreI
Message-ID: <CAH=ZcbAm8++qGNX883epk0h3NA-Z=8+RX1bDJeTe=n2jjSsdmg@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 3:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> > I have a question for everyone: Does preparing C code to be translated
> > into Rust count as a valid reason for changing it? Provided that there
> > is no violation of the Git style (or very small in some cases).
> >
> > If my intent was to keep this as C code forever I'd agree, but...
>
> You'd agree that "I am preparing this for eventual rewrite" would be
> a valid reason?  Or you are agreeing with something else?

I'd agree that my reasons for making this change are insufficient. I
think usage tracking tools _is_ a weak argument, but perhaps not quite
as weak as what you're thinking. For example, when I renamed the rchg
field to changed, it was as simple as right-clicking the field,
choosing Rename, typing 'changed', and letting the IDE update every
use. Patch 11/13, "xdiff: rename rchg -> changed in xdfile_t", was
generated directly from that one action. That patch was clean because
I had already gone through and removed all the aliases of that field.

> > My
> > other reason is that it more closely follows Rust paradigms. Creating
> > multiple pointers to the same memory in Rust subverts the borrow
> > checker's ability to keep track of who owns the memory.
>
> Sure.  But looking at the use of rchg[12] in xdl_build_script(), if
> they were "const char *", combined with the fact that they are local
> and their addresses are never taken (to be leaked to our callers),
> you wouldn't have much trouble with the current code, or would you
> still have issues?

For xdl_build_script() specifically it would work just fine keeping
the local variable aliasing in. I think this is another case of
personal preference vs established style. Which path would you prefer
that I take?

1. Drop this commit and remember to refactor rchg1, rchg2 to changed1,
and changed2.
2. Keep this commit with reasons like this:
  * Refactor churn: Later commits will refactor rchg.
  * No additional meaning: The local variables express the same
meaning as the struct field itself. Also, the conditional and the
inner loop is easy enough to follow without using the local aliases to
make the code shorter.

My preference is number 2.
