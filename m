Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5D2222B4
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475143; cv=none; b=Ieclcf7Bw/1/tHx82Vd1W33tLD6Y3l/sigcQ4P08YU8GYm3mWB9oqdX4KiLbJzj45j5MpA5P+uGK1Hfv8/8eBg7s27MRQSwtFOo5kOu5obsB316sc3gdpZfbyKivpdB6++jZqCNtTXskOpq40g9LD446sZKSB2YLSsT/mUFUWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475143; c=relaxed/simple;
	bh=z8BpO7A4LXVQO2c2exKRUisFASUw+ZC+1M1FtHZgLXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOFCAhLJVkEvzBRYL92gtLAUspM1cFeroO/en8nA3FnNcAnt37Lf4S95VzDEp0ACY7xsjIM0lSBsbi6ajvZbbgFlgfsoLrjZK9oKKYV2lHnAJ3m8Brdj91FYULvy/eiYkSVlLAg8IvfXBpKddWkpObdqvho4K552RfB7w+uvdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs4MwswM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs4MwswM"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso4408072a12.0
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759475140; x=1760079940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/8/tR4eCyw2SW5WO9h4jEQfA8lzIQZ9mUVjbmv98r4=;
        b=Gs4MwswM0UIs7zpIckRnD3wp+thD76VObIYUU0o8qqouCg5f7wIBy1PepjpY1uNUXE
         O7Wd3FBwNpCXWVT+8vdRHbV4ONcjV3o8gAN85FpCX6Yu1naJVe7JW2AZ7044XWn/3L3I
         rx5immhZa7xp1AyKEpX4rU3bxMMbFd7dOAra2KIwppDaXILzpf1RZVPCdS8FXvghCnyL
         SW/76g8Be7Rm8+DPoBSJzqR+sFdgKKAs5vIho1ygJO1C3EXskn/urImxiwfbPJYfu7W+
         Wdsb9cP28YVd7n6dEYkwHyplBL1jIZvxiFpwGWExL5Fg6EKFj1RB0v7FbR9wPfkKF/4U
         1BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475140; x=1760079940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/8/tR4eCyw2SW5WO9h4jEQfA8lzIQZ9mUVjbmv98r4=;
        b=ru6SKt8vMZYMUI0YctTxTbE5dmp9wB/PmVn6uni8kBCwFuR8KgngZX68QYFmJebjIG
         SzybiS3cg56nzEVN56TiN4r0nE61l0uG/gADz+ayY6jRZHzfSZD3NY6xFp59LyqDO1H3
         do03AjnebVi7s4z4xjKGrJmToDx7xmDwx57DSWjJnosfDcdiy66CKIhk5PNeyxDqNN0Z
         +bzM4yQuiHao51pJkWbYS1buijDw5u2vpmJ5NqF4qx5nYj5OAgg9O0mQn6MXA4+6pFzR
         Kspqf4y+KL6NJXFS3nqOPXU5WDlkFjmZyLvHeBNxuPeLffKvGJjVgkT0tLGz133gzuqV
         PkzA==
X-Forwarded-Encrypted: i=1; AJvYcCV0a8TGvKATbkWgjkUMQMoyat2pd01Fi4p8ELj2tY46NALgQtqiGj/rtAXqAS8mK0zV75k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+pP/I+9Q8nu0DJimhNK61FaypRe9S00wzYWU15AxRDdVpPKbw
	62qMwOsakcleZI2Qr2y59+FUPK6O6KW69q15oH3y2nBzO74mO7eKT/qMkxuGd+gA378iU7IO2J6
	N+/paNquwIL2Ek6yo328SsnJIIAWN3nrZb3kYz2w=
X-Gm-Gg: ASbGncuQoMfcxIOArmGQfx5PDu9M7PPB9pHFWY8oX1cLuf5tyQda/+KstQyPLbgDlC3
	7IRvsy1rvb+3BB0R8Mv1CW7zsTBapTBPJE5Dtyuu7jVQmMbQFzt6eFzZDUj9oGU7LJMlH/GP90c
	Fe7jvv6M6JGHL8qXU7FipXpmGahDT9vldISf9M6TG7lDsI4GJzh5tzxTDW+fQQl0xNT943jnNj3
	d9FcgaTyKv7j5o+RwA0FXWa3Pp60CEuhwpyjXF0NQ==
X-Google-Smtp-Source: AGHT+IHy8swUfKR9F5x/r3GAfseUNzej+yY4XGAjwe6w38GGaVo4Hnms1FRBFyBYS4z5Lq/vCz8N2jiS/07ryj1qw/A=
X-Received: by 2002:a50:ec95:0:b0:62f:4828:c7d5 with SMTP id
 4fb4d7f45d1cf-63904eac1f4mr1847345a12.16.1759475139736; Fri, 03 Oct 2025
 00:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com> <CABPp-BGcbdygEjndAjXo9utUhTac7JTHscX4iiwk4UZcHonXvg@mail.gmail.com>
In-Reply-To: <CABPp-BGcbdygEjndAjXo9utUhTac7JTHscX4iiwk4UZcHonXvg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Oct 2025 09:05:27 +0200
X-Gm-Features: AS18NWC5irXReN-zt4rvHS-vSuAK9Va0QOabjj-YvEtip9E7Yk3zSs_OwQXhIpI
Message-ID: <CAP8UFD294t9qhQBjRS5cun4fwga0BseRHFmOapG0gpKS3r-6UQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Elijah Newren <newren@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im, code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:55=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
>
> Hi Christian,
>
> Excellent review, I just have one tangential question for you...
>
> On Tue, Sep 30, 2025 at 1:24=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Sat, Sep 27, 2025 at 1:09=E2=80=AFAM Siddharth Asthana
> > <siddharthasthana31@gmail.com> wrote:
> > >
> > > The git replay command currently outputs update commands that must be
> > > piped to git update-ref --stdin to actually update references:
> > >
> > >     git replay --onto main topic1..topic2 | git update-ref --stdin
> > >
> > > This design has significant limitations for server-side operations. T=
he
> > > two-command pipeline creates coordination complexity, provides no ato=
mic
> > > transaction guarantees by default, and complicates automation in bare
> > > repository environments where git replay is primarily used.
> >
> > Yeah, right.
>
> I'm unsure if you are expressing disbelief, or agreeing when you use
> this phrase.

I was agreeing with the general idea that having to pipe the output
into `git update-ref --stdin` to actually update references has
significant limitations (in particular for the server side use of the
command I am interested in).

I didn't check every point, especially the "provides no atomic
transaction guarantees by default", my bad.

> Most commonly when I see it, I assume the former (see
> https://dictionary.cambridge.org/us/dictionary/english/yeah-right and
> https://www.merriam-webster.com/dictionary/yeah for example), but I
> think you've consistently used this with the opposite connotation.  Am
> I correct on that?  (This is a particular phrase where tone of voice
> used would be really helpful, which doesn't get included in emails
> unfortunately.)

Yes, you are correct. I knew that it could be used to express
disbelief, but I thought that use was mostly a familiar oral one, and
the context would make it clear that I was agreeing. I will be more
careful when using it.
