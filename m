Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773B5F54E
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845433; cv=none; b=khqeeW+5y0bE4+My83RJNaAYQ25besd4wWJw7xMKmtnKbUkf2yI7YjRdXwQbA8I5+UWneRCScZasO7gr7d+kTOmmwatQ0v9t74T2KVQ4DlXPDiqYo9u5SD+NlPinpK0roBdTb/CbK356NqliXCNwHvAUaqltuTYsxiZobpZ37x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845433; c=relaxed/simple;
	bh=jn3cNNzoNxN2hNzdEVhKW7TcN/UyflcXJTdI7svrx2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BnLunEjF7qKlU9LM5caSuZ6s26pVAbvGSFuvvucKt46E5Zcmo7lXGurP4dlQjg+OcV5LN7g38zFiUGkr7mm5BV7T1j5uk0hz46PoZHcRS7fMoCgs7Wt33nz9nlhbJBWDxWN0+ccL2MCTLqiW1sAcrCDQS7HFsyHekxQNKsI+XpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gjhks7AM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gjhks7AM"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60761bdbd4cso36876367b3.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707845430; x=1708450230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2e7x8vYec7YDxNQAxT/afsLlbvGF/yo8v0O3i/YFPI=;
        b=Gjhks7AMh0ChqyFk4t0D3KhBm0NOnvzwPrSFu6wb3y4gndbaLlhPnFOzv8cnVbvZ2N
         AIiJOg6gLC6dYu3uxRUl90zLp8XyAmj28wt7qO4s2dAR7mivB57NT4CjvboHq/EAMufH
         kA3Z43YAVAVwvf+HOOTIxT/xauwyif+EV1T1aVp+6oX13l7woIo+IS1UDH7sFipYoFmH
         MokhWgtX3l7aSM+CVgj0WACeFdcZItB+tg2Qvi3hta7PboCW1e6aPPfN24ibrxt0k+lf
         lNbFTK4IpIylEjKxuw837hRvh6A53GXT+I/HO+AA2B8N6oHwqt2KJupfw4AfdfspW9Bj
         XW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845430; x=1708450230;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2e7x8vYec7YDxNQAxT/afsLlbvGF/yo8v0O3i/YFPI=;
        b=kFqXUY0QIMiYXBj2k1q2L6/2jjfsjYpBzxYQpmC5kQat5czNGZjG6kE/09VI0QHdVc
         eZLzoa9vLKaJ329++Z3pwEZD+IB5WNMqnn/APd9BMR9xy2yqOgiwn84VTbBdTcuvbinU
         gD/i+LJDlojpOHO7R2dCUX7xhpQHmiaCOIfPFS8SHh31WdvNwfB3nVlF/W/KQjg1Z3bM
         xI1nSU21Palxe5m8Yx6GUYCB8tc4L7R2/BGHIIhdU/7nq5H4Rf6bwYWrUW4RKXgNlRw0
         ywRV0ANI+b+yKoa9+4kaseQ0rHE7qxreySNzk+rwe6r9Nnisoi7HRnaOsT7n9abTNpXb
         NRJA==
X-Gm-Message-State: AOJu0Yyuu4a9sAXv0+BsI30H9Hmq/UJhqBxm0Fz7kVnZEsF7uMhiok+Q
	S4c6VxanXhIwE8TzPyyK9x6LOLSJfRft7u0uBzj9zFq9A/m6hhdBSHCB9vB/OBa1yJDZmzM5F1+
	eVA==
X-Google-Smtp-Source: AGHT+IFwNoatbvMVn0hqUwWwXXt5C9uMFETHA1VsjAogD3HXQkpZyBitRSN8wkudG8IJwuM/aLO2wWQUZgY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:f0d:b0:dcc:50ca:e153 with SMTP id
 et13-20020a0569020f0d00b00dcc50cae153mr679606ybb.7.1707845430005; Tue, 13 Feb
 2024 09:30:30 -0800 (PST)
Date: Tue, 13 Feb 2024 09:30:28 -0800
In-Reply-To: <CAP8UFD283wk9b+D+s3azcg9DHjaonaq6-eY1KDHkP8UWZYVXQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <31725832224e3d6b14066af8a87eaf4ab589179e.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD283wk9b+D+s3azcg9DHjaonaq6-eY1KDHkP8UWZYVXQg@mail.gmail.com>
Message-ID: <owlyo7ckb7bf.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 16/28] trailer: finish formatting unification
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
>>  /*
>> - * Format the trailers from the commit msg "msg" into the strbuf "out".
>> - * Note two caveats about "opts":
>> - *
>> - *   - this is primarily a helper for pretty.c, and not
>> - *     all of the flags are supported.
>> - *
>> - *   - this differs from process_trailers slightly in that we always fo=
rmat
>> - *     only the trailer block itself, even if the "only_trailers" optio=
n is not
>> - *     set.
>
> This makes me wonder if there was actually a good reason why
> format_trailers() and format_trailer_info() were 2 different
> functions. Is there info about this in the commit message of the
> commit which introduced this comment?

Good question. I see a388b10fc1 (pretty: move trailer formatting to
trailer.c, 2017-08-15) and there it says:

    pretty: move trailer formatting to trailer.c
   =20
    The next commit will add many features to the %(trailer)
    placeholder in pretty.c. We'll need to access some internal
    functions of trailer.c for that, so our options are either:
   =20
      1. expose those functions publicly
   =20
    or
   =20
      2. make an entry point into trailer.c to do the formatting
   =20
    Doing (2) ends up exposing less surface area, though do note
    that caveats in the docstring of the new function.

so it looks like this function started out from pretty.c and did not
have access to all of the trailer implementation internals, and was
never intended to replace (unify) the formatting machinery in trailer.c
both before and after that commit. This seems like good information to
include in the commit message, so I will do so in the next reroll.

Aside: it is interesting that the current patch series is taking the
direction of (1) instead of (2) as was done in the past (we had a choice
to "libify" at that time but did not do so, in order to "expos[e] less
surface area [in <trailer.h>]").
