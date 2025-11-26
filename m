Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532882EE60B
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198392; cv=none; b=sJdyFmr7HGJuoj7CnkGkeVdAFk1ABve65tSXk7LpfkNuioGP2GhmY7fm+0xYN9pEksUxersVIJc/OHBinDEbKzV6EXzi1ZFr/H7bPf1Cg9lgW7+dpADhvPj9OBEARvbCKqonxnu0t5yIiEbxyINPxIfONsEzADcO8RlfM5cxSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198392; c=relaxed/simple;
	bh=2qqLC8KQyOakRmRc2Xt70VlnUpT7iyNLgrUlHPgBB80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyoKgqWvurxXzaWk89fo6FFoTUq9R4rRrQuW7OW2V3Qa6iB6QhDUX42rxqZiqoC1GMxjw3Gby+WY1521IBvOGhYdfE8M1U5ivTL5rbDHFkeVjwthrzLHMoCfr04/hZmd+Sz3grb+sDcMP7dKCL326Nb5rag0pb50cXPDqCO351U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtnG+U7x; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtnG+U7x"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-9486adc1aa9so13331639f.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764198390; x=1764803190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tnavi0XA45ybca3dbUNO2j1zIntw2hUiTtgoa0J1eQ=;
        b=dtnG+U7xqW/qVAtjqP5uslmxb7JN/1b+HvfTNk5x4Ba0NxaOJ23wNQafbPSk3Qn5sr
         8HSt4l0v6EZM3+47LEI7UuLN8ZsJAzp+/IVGtmOm8M1PHPLjSf8oxIdT5zM+n3ypDlU2
         w4R7PLWQxAWu6brjilBRrznCRpvOuVnyajLRzXUDmonrjk2b8WuyPXlm9Zznv8nXnQ42
         biutRMU51g9X1upM/6yRtDNXPSuuVACjUE9labgwR7svYyEMIulFJDOCUQlLHCrWjQc5
         uQ4rtF7N5OQ+4e79PMJDvr7EhQ5faoA7zPkwNF8cFxDqL+0ljKFnX8NnMEkfpHI1ELz2
         sgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764198390; x=1764803190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Tnavi0XA45ybca3dbUNO2j1zIntw2hUiTtgoa0J1eQ=;
        b=dMxQ9WJNVEWz3CoEKC/NfA13e2i+VSxVG+RCGMo9t8p1MAT10GUrv8r9jvSnFeW/Py
         3jick6WMk50VwTeB4CzcksGf543FK1tROUVVPByZR+p6W5ja1cgMv1ly7les9t4iMZmD
         rf1BBae8YFCsSZo6X57uQN9We4WmRa+D/iUw+LgBmOWTDCpChQ8wTOFcMCczunrQULm7
         V0j27eDB42C7F3gatSkJQfKXbJmJ9F5V0FxiTbgrDJ3uFoGn0VL6S+dpruO6WtpyprG0
         zj/86gQZGgTW7Us18lBLQQ+SPiErUmAiCEhj/+bnlTTN/Gb9lomnOgeWOlLVGYQlWVhJ
         LZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlIikmU/2arm8gSMzJYFt2fXH39PufgSdqSYtwQxSuN088yVrol3wZq6pwbcUD45+v4Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqF2kFihEKn1Sl+m50qY4lUVWhXmPXkwkNKYBk0FHsRtKH9IU
	5dBV/wFtv/WhBdIFoe8HLFSEGJH1RT9jSDlT+lht3iWYEE8tA6D2GuDmV7iBLra3O2Gj5Kdyq07
	FCbQhu5qITgNLoLHk2Zm4DMGH3XmvHjY=
X-Gm-Gg: ASbGnct+9JtqKGAiUuJMxC38STEPYHRv/18gdToS0Nf1c5O9xfqevj8P6A0zOu2YO2H
	DmFZhPBGzcRqPyDRL61bv01/1AxDG5NVRIPxOJdaMg1dgl0yz0X8pRcR3oQGHv+vvwxtOalZIRW
	5TcNf7EO3AJSHicYFWbGZ6arp4j9Cr84VgCHOiMzBoqiKpp36H0YJr2mjTL87SUG5EMAaplzjFC
	6v/wRszWto9yJ3P6kpGZMRw5nDeNKBo1bPfVBZremKjvyKBzmPk7ob4T+65RNxJw6rmL2J8zlF6
	tYECgVB0Yc1boN9AqT/SUzGx4iKG
X-Google-Smtp-Source: AGHT+IFHbR5xAZpGIqe9JuxJL6z+qx5CeUAfbHDFfEa19AWB9ZuCzOJkwVlVa5L2Wkrx7OQj/OrrcGt9RstG7YN9Qg0=
X-Received: by 2002:a05:6638:4e11:b0:5b7:d710:6611 with SMTP id
 8926c6da1cb9f-5b967a8b20cmr15417193173.20.1764198390297; Wed, 26 Nov 2025
 15:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com> <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
 <CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
 <xmqq3460ocv7.fsf@gitster.g> <xmqq3460mr3c.fsf@gitster.g>
In-Reply-To: <xmqq3460mr3c.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Nov 2025 15:06:19 -0800
X-Gm-Features: AWmQ_bkwNYoifFgTah1l7nMjkrAThUj_GZq3MYWPHvULCR1r4MO2YiJusTnrHuk
Message-ID: <CABPp-BHcCX8LDccRoarsqNO=YVr7a8gp67oc87b7taAmjch4dQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, karthik.188@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >>> I'm struggling to understand when I'd want to do this. Why would I wa=
nt
> >>> to update 'feature' to point to the reverted version of its last tree
> >>> commits rebased onto 'main'?
> >>> ...
> >> I was going to say the same thing, but from a different angle.
> >>
> >> The sequencer in git is used for three different types of operations:
> >> rebasing, cherry-picking, and reverting a range (with a sequence of
> >> reverts rather than one big revert).  In replay, these correspond to
> >> --onto, --advance, and the new thing you are trying to add.  As such,
> >> it should be its own new mode.
> >
> > This is a great comment that clarifies what the problem is with this.
>
> Stepping back a bit, is it just me who thinks that the "--onto"
> option is a misnamed "--rebase", and the "--advance" option is a
> misnamed "--cherry-pick"?

Is the goal to make connections between existing commands for folks
already very familiar with git, at the expense of comprehensibility
for new users and command lines that look somewhat illogical?

For either a rebase or a cherry-pick operation you have: (A) a range
of commits to be transplanted, (B) a base on which to build from, and
(C) the choice of which ref(s) should be updated to point to the
transplanted commits.  cherry-pick assumed HEAD for both (B) and (C).
rebase formed an implicit range instead of letting the user specify
(in a way which has always made it difficult to teach to new users,
IMO, but I digress), which involves HEAD and also used HEAD for (C).
git replay removes all assumptions about HEAD, which means there is
much more freedom for (A), (B), and (C), but I think it also makes it
more important to try to make command lines at least a bit more
self-describing for users to learn.

=3D=3D Example command lines today =3D=3D

  git replay --onto main feature~3..feature

This command replays the commits in the range feature~3..feature onto
main, and updates feature to point at the result.

  git replay --advance main feature~3..feature

This command replays the commits in the range feature~3..feature onto
main, and advances main to point at the result.

(Both replay the same commit range on the same base, they differ only
in which refs are updated at the end.)

=3D=3D Example command lines from your proposal =3D=3D

   git replay --rebase main feature~3..feature

This command to me would suggest that main is being rebased, but it
isn't -- it rebases feature~3..feature onto main while updating
feature to point at the result.  I find the "--rebase main" part of
this command line confusing.

   git replay --cherry-pick main feature~3..feature

This command to me would suggest that main is being cherry-picked, but
it isn't -- it cherry-picks feature~3..feature onto main while
updating main to point at the result.  Again, I find the
"--cherry-pick main" part of this command line confusing.
