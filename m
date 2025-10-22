Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116D257835
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168732; cv=none; b=qSVo5pjfBVzGzdFdYxVzZLIVVGmoQwNB+0kaEuQCYlvm9oXOD6s2ui5+zBlevKp9POgDhGIwxe4HWr8Ay2/hvzH3DjjFYu/H6gp01lf2Yb5es+V+bZ+F72qqlzINed1ZvCFkGswxYt4cZac97MiXp2UCKSamO+8Jadjja9Hmv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168732; c=relaxed/simple;
	bh=DEcLABJq5qJ3ZLlRvvK4EkJV44vej089OT21Kjitqos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxX3n0E4/09wk8ku9msRSoBzAOYtqj5wS5JTac9wRsjJS3Ue2+pK2zpGsUdtoUf0H3YIw4NWl65Qq1xr/6HAaBXk9SJws51qQA19EC1Y4nQnm+NGppZuNPH82/GH+HkJhJJyItKrxiGzAbyMxsxjD/wlm7kxvi83MmWt5n9SKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTS6kMvJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTS6kMvJ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57992ba129eso97436e87.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761168729; x=1761773529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nMAJafFChP18Q+qoFFTcuazmKz0jFB33dA5IY0yJ7E=;
        b=OTS6kMvJxtpbbxgkcymYxFzVUP6d2I4qpJxjUoPBisR9qVq8KC9qFNsV5nWSBiKmS/
         FrQIqofwiL+qeMh2rQ6anjgJZe+IYseEAZ+MZvNrvIvON5RNvxASSN8fOSGGwR4hobq5
         bdT6YM0US56gOJDQLbiKv6gUpEUAJ5vSPWoRvroYrYOSo5SJf8u9iHYCeuvplL63zd0r
         9nduouv4HXTD0EO3o/4fjCpUPx2b1MiYYDEoU+tFUZop6q75FkKoUflmfSs1003hWVvY
         IBjgAqHzPHPqARQ1Dtd1fm5LIUR1OgOP0pZA1H6UEiyK8XOCJcyo4/9iuamw29p4jMAJ
         TGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761168729; x=1761773529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nMAJafFChP18Q+qoFFTcuazmKz0jFB33dA5IY0yJ7E=;
        b=XvJ3HS4NeVD4058lXVQjCQ4cbRQtZ5hAJNZ7p8xltvD2ei+OnCj3kWL0EoRHjdqvsw
         h8AmllUhOdX54ufSmWQ/vI+RcwmDi9qO+0PHtD3gfPYqpLwTYSDknOpxho6Xo7uRr9qW
         3XlWTmdwZYGeyKBphOD8zx5JtbuGXOr0Sf6C05Sf+FFaf1zcK57g2mwgak6HLrjIer8K
         ct6cgo4mefa+wfkbzEQosD9ecPg8Pg5I7Eyg1zkOxqVZ+1HWc/kebMrL2ksFxiEwREbh
         tqt50fVeonkpWjpsuRpz0tzS59OhsPYGVbRPotgMGfrnzGior2ULceg1EzVut8qFiGxv
         qmig==
X-Forwarded-Encrypted: i=1; AJvYcCWJohDorGXHkSeA10NqeGGZmB/JbsS15RFIDFCO7nxcuEqJkYwLIuuSd79sv90knhIS1sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTNlV+bKn8ymIJbw2u7iK9W6AWifTTtadSmMuqwo5rb0zt/kH
	x52bzBMDo7W9UWj1+k4G06hn3jG3MCxTf837RzWBZl3VgeMmG+Z0z5Lp7Xkft/lLRecIX903TDL
	ZrzoZnMi+kCCJIeK5EqlW1rBmXmcSEc8=
X-Gm-Gg: ASbGncshPAoDzEdBCK7LM0o3n8R7HqLlYkAqWa7JVAlwJTgCq5rxjX3uUqkCBh8xZOT
	Er6UgiA5QgBNCVTKLGyzR/h4tCicVqz3YeVRd01KgnvabueKT9fRFLXFLT6LrVarXpvo3fp18AE
	8ALsoYJrLsOwCpgsqUnvj900FyhObxqxqHl1b7bNm2lPtVufhiDKIVeculDYPAIxhOOMpmGJPpX
	jGdbmx4F4zQUF0osTz7qpJHl2cGsoc4ZZGbPLNZ46YuBMKlTPS9dilgj5jLq5FtjpP085qT
X-Google-Smtp-Source: AGHT+IHN+uA/h+WPiLnL1pFsUGhX6PnhDtJv0hSPP0pzb7a2mtsmjg50FgFekBJ52HvmKFVpU5lDS/32mf4h18e0wEc=
X-Received: by 2002:a2e:ad10:0:b0:376:389b:b4f7 with SMTP id
 38308e7fff4ca-378d6f49848mr126521fa.40.1761168728808; Wed, 22 Oct 2025
 14:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
 <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com> <a0711cfe-6e44-44d6-b66b-84a296e113d2@gmail.com>
In-Reply-To: <a0711cfe-6e44-44d6-b66b-84a296e113d2@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 22 Oct 2025 15:31:57 -0600
X-Gm-Features: AS18NWC4W3MPPsbziiTmBfuFiDQDAOdRBq6gmCmXOxEiVdpPu9S595oS1XGgV6o
Message-ID: <CAH=ZcbD7FeRHtYvN_4=qHApB-AwK18=KRU2SGWNg8ADkrFM-Fw@mail.gmail.com>
Subject: Re: [PATCH 5/9] xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:03=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ezekiel
>
> On 21/10/2025 00:29, Ezekiel Newren wrote:
> > On Wed, Oct 15, 2025 at 3:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Ezekiel Newren <ezekielnewren@gmail.com>
> >>
> >> The ha field is serving two different purposes, which makes the code
> >> harder to read. At first glance it looks like many places assume
> >> there could never be hash collisions between lines of the two input
> >> files. In reality, line_hash is used together with xdl_recmatch() to
> >> ensure correct comparisons of lines, even when collisions occur.
> >>
> >> To make this clearer, the old ha field has been split:
> >>    * line_hash: The straightforward hash of a line, requiring no
> >>      additional context.
> >>    * minimal_perfect_hash: Not a new concept, but now a separate
> >>      field. It comes from the classifier's general-purpose hash table,
> >>      which assigns each line a unique and minimal hash across the two
> >>      files.
> >>
> >> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > I'm a bit surprised that nobody has commented on this patch.
>
> I've been off the list and I haven't caught up with this series yet.
>
> > I thought
> > that someone would have criticized the length of the name
> > "minimal_perfect_hash" or asked me why I was splitting one field into
> > two.
>
> I think "perfect_hash" would be fine if we want a shorter name. More
> importantly it would be helpful to explain why the two fields have
> different types. I assume it is because the perfect_hash is used as an
> array index and therefore size_t is a better match for rust's usize than
> uint64_t.

Your understanding is correct. line_hash is fixed width while
minimal_perfect_hash is meant to be used as an array index into
memory. I'll update my commit message to make this more clear.

> How much more memory do we end up using by adding second hash
> member to the struct? If the aim is to show that only one of them is
> used at a time then a union might be more appropriate but I doubt that
> plays well with rust.

xrecord_t used to be defined with a pointer, so we're at the same
size. But more importantly I plan on splitting minimal_perfect_hash
out of xrecord_t into its own array. I think the diff algorithms end
up being a little bit faster with a separate array because each
element is only 8 bytes instead of 32.

In v2.51.0:
typedef struct s_xrecord {
       struct s_xrecord *next;
       char const *ptr;
       long size;
       unsigned long ha;
} xrecord_t;

This patch series:
typedef struct s_xrecord {
       uint8_t const *ptr;
       size_t size;
       uint64_t line_hash;
       size_t minimal_perfect_hash;
} xrecord_t;

> I'll try and have a look at the other patches later this week. I think
> the type changes are going to need careful review.

I appreciate the careful review. I figured it would be best to limit
the scope of this patch series to type changes, so that it wasn't
bogged down by other stuff.
