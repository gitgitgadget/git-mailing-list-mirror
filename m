Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBC32D0C6
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632721; cv=none; b=pcICGivdhr2DVs7xyQtYDCmxQaOY09JINx3oQdb9K//jJWc37xx2hEAUOtSkwNco0lnuEq/RyW+okk9jlFTlQQv32B6x1OSsfs+f2jXwgLdjhlckdDi3nHiEd5I0PDsdV6DWQlsU5X4fEdcroho2tt79jjCzLKaqV2JeL7aVgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632721; c=relaxed/simple;
	bh=tLknqJE4A1LB1NZggvlASuvpmVVF4Rez3zJJTBa0N10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDVUtMAodpKcKf9bZVxwmw7EAwKu5Hf/Up05PoyYEMmPqw38b3wBUBys+TuNNRfvHvbRO11gmq2OE8Py26rb/hGVKwve8yZHLz+KtDqQrLpSvVoGM97vY0cnqoyN6r5UBo26pVtyzGjr6/jtR5aGshxUYwzjjh5g+jFDjwuRkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AD2gGW3X; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AD2gGW3X"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-634cc96ccaeso9430a12.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760632718; x=1761237518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/KuhZeD6Bj1hJrHQNhlmKuU7XXrx7gzhOJiJwDN9Ka0=;
        b=AD2gGW3Xj7xqOOGlLGReEYjA5dj8w21wKNMG0yJhvDpeRvKLuWrh7VfKZIU6y7+nNd
         GtLkkyGHFs/1h24JmHgX9jAfJxy7sDoJdSRXHA+4CSfNoz+dgwM5IPBiQMncFk+FxPAc
         2C+5gUGFM21T+k3aC2LAfheGTxB23qd2I4c+pEgcDb/wXG8cklTEA28f+x+8mJ2qROL9
         6AfEvcYbeybAoA1JnlGtGvV22Vfi39boYUMzPJZSQLd/KeDHXaDugHyMHldS5NaGsBbv
         tLPZe9w5IxjFoeDoMXTXWWMMVml6PBjx/mzuWWWDyXTIXHUaLdjt8IK4wJa5VXM/BCa1
         MGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632718; x=1761237518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KuhZeD6Bj1hJrHQNhlmKuU7XXrx7gzhOJiJwDN9Ka0=;
        b=t42jZTMi2JMKKC4M5d8KEDNEAtpRtemppWs6SBoiIhjouJpGDPIt8NuOLrQYkTp9fY
         Db9aZCBmnsxV0dwJDcOOze3kz+f/31Rzb/7sbgLkOwDjosyQbOD8qYfA0AAgxqi4OGnH
         mA1WOSxtCCB0BY9NRPTSdKOturi14hjPNTUIXvJN4ob62uVdwMurBtaJvLLhQZXja7gi
         HMcH0cZQUC/Bhk5dpOAYNb5aXRrYcrnpdc1323UAwdP1iUw1U08ZrM8Zn4oj0FAbwtU/
         qkzwI/PVCLRbD/uf/IEZesU/DpSfnyg1dmYJBodmwzqNaMmjd614zgIOdqOIFPPdWm3l
         naqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtnyjOi2SduLPj18IlLmAbQ08Bq3q6anCPdfkqcNVhJt0xXD43A7L0JYx2HMX7lDG8BXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzskBu54fWbb/v9rYBVtdDxPjCuq+6LEkiHWXE5RxHxaGDVqp8i
	CCYjzlkABuMRKuied8TZlbQ34lZJyCPjaKiQ097U5OszvY2/r68YzTY8Y6W+inKyDb45ziKOzyc
	bTMhLwRWYYI360vCgJ7z9raAQNzd4zN276rfCndkn
X-Gm-Gg: ASbGncvPTWfSakIe5/El+Vd81YkWjVK97dLSwP5rsgQa9LLq1Um++Co5JS6JDrhlPza
	2RjRtauN8g0DTTfQoTFajL3pNiZEDLourvePJ0XVwpu35nI9qHqibSyMCPoZP3xYCPmoO6Ujr/D
	YYSufiH0T/r89vnUqmWkjpiDfWqRDY+YbLtecDWM41YbZfwkZK0tUvglsmI3ds7dq6/ti0yEWD7
	ZLcnIYAz5x0Y1NaflCjaCL7aimk4CrL0IfJAYqfHJzrEph4xN6crddaQrXGJdVoZc72bOg999UD
	c4v/Nty53GDsx5I=
X-Google-Smtp-Source: AGHT+IGQpoejargSfE5HMiy5DUeJ5EL3FTKWP7e5uzrXff2rhfPByRfrkt60LfNQwclS7pjom0kHO+PSsHKh8Hb9vkE=
X-Received: by 2002:a50:ed13:0:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-63bebfe1112mr229609a12.6.1760632718096; Thu, 16 Oct 2025
 09:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
 <aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net> <xmqqh5vz7ygc.fsf@gitster.g>
In-Reply-To: <xmqqh5vz7ygc.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 16 Oct 2025 09:38:26 -0700
X-Gm-Features: AS18NWCkS1SFladLJYaOyBJ4ucUqVvh3ObD9JU1ko_OuuAyIV263V188JOCPrVs
Message-ID: <CAESOdVAEN=YeMqozR4438L-U7mZ3nhRnMB5PV_sUPmwuWSkbhQ@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Oct 2025 at 06:44, Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> >> +Support for "git diff X..Y" syntax will be removed. Use "git diff X Y" instead.
> >> +This will open up the syntax for a more consistent interpretation of
> >> +"git diff $(git merge-base X Y) Y".
> >
> > I feel like this is going to break a whole lot of existing scripts and
> > probably more than a few forges as well.  It seems especially bad that
> > we would add it back in the future with a completely different meaning,
> > since we'll have some people that use 10-year LTS distros that go from,
> > say, Git 2.51 to Git 3.xx, where the latter reintroduces the syntax with
> > different semantics.
> >
> > We've never really changed the meaning of things like revisions or
> > revision-adjacent code in the past and I think those kinds of things
> > we're pretty much stuck with forever.  With that in mind, I don't think
> > this is a good idea.
>
> I do not think X..Y (or X...Y), if accepted by commands, would never
> change their meanings in the middle of the commands' lives.
> Teaching "git diff" to complain and barf on X..Y is a possibility,
> but to do the same for X...Y, we would need to come up with an
> alternative syntax first.
>
> The same for "git checkout master..."  that detaches HEAD at the
> fork point of the current topic (so that I can "git am" in a new
> iteration of patches on top).

I couldn't get this to work:

$ git checkout main... --
fatal: invalid reference: main...

But don't worry about it. I think your point about there being other
commands that support the triple-dot syntax is still valid.

>  As the syntax "git diff master..."
> is symmetric with it, if one were to change, both should change to
> the same.

Agreed. Some syntax for getting the merge base revision makes sense.

>
> Thanks.
>
>
