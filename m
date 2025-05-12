Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7C25A2C5
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070371; cv=none; b=GmZLxevUb7XrWtmU2dVk8ikbzSnkYoHgy8I+IKfMmAFugcfRdCJYUa+XWGbiVuIQzhR72YsArCNKzbLROHwIy+cn3PTFVf204Ua7b2THaRyZNzSHZhdiwSrFoHI7fd3cFEIQ64GU/uOKo8z0RmktlHL1y4oR6M6Ev2tj+LOWmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070371; c=relaxed/simple;
	bh=gU94J4Bb6BvpE48bnyT6BHe0u2lXB/BhHHXeKasaUrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Umcxtb0mD8w69P9GZlb0j0CLQwmCtehDkM1OwWRNjyVTI3pMKD261h7eoFt/tapi+ycWuVBGJxyqtOO1Rs2eK2R56yfgJbM03Jt7xd7G8vDtocVU5ay91CE1hWpdX0MHKQylgMAqSlCm2iA6FFXtGWO0bwrZdO0VHC4uD/aIU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2YclO04; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2YclO04"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso754a12.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747070368; x=1747675168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=erKnu/R7OHI7jQlA3DCep4JWxuhlDeYYBJsCF7wTaQo=;
        b=J2YclO04g5VmfrKWsKOBRoSvi5JDoMWyqRfPaRDzYfmRDWGLQ+uAP4jEzRzN2gHgbm
         An4Z3uPfjQeGC4dnCKEMVgG4ebKAyN1Pzr7ARTOkOlrcYj4aI4iV4qyYmcigezqIX14I
         IazGshpplLUfXs4xsYmd51x0GCxXmwVGqno7jaQGKu9QWDa8NFpm1slycD4uGlsxtR2F
         NkH+8EXOnLZVUZ4HdMKIa46xlhGbJhbkWD0/jacS9XMMkr4v1SRtaeM2F97dakP4n+sy
         381nHXeiIzH1xLgbHzfjvS8f1Gztfzx434Pa+GeSQr97bt8MNLiQYcmvDK3Nl+odaEr4
         YyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747070368; x=1747675168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erKnu/R7OHI7jQlA3DCep4JWxuhlDeYYBJsCF7wTaQo=;
        b=JcGC+bbJG4ZMLhf1rgFWc6tIaTtN6PRDBVa4gwJNSyc1uE9YRYI+hhqdHHp7FTHiPD
         j2A1SIAbx6nH/d94ama6Z6J3lJ0HBiftkOpeWamnahmANh0s5W5AIiqoODamCmiB1BnT
         QWXPPiY93N8SDOJ+Hxy888Uxje12942tqpg7f5jma/DPTHED/kxVs+uqQeWCW2JAImYf
         v/YvePxBs9YICplCPA+kFi5NYpOYecN94oBR19hVRI+IbTE/mxX0usRcYdIuZv1184Nc
         wj0efP5IuMjAi1I/seqYQtF2zJhBSbegtjf1c9IkYVGBBRLBLihsHRy9ZZLvxM/+kJY7
         VXWw==
X-Forwarded-Encrypted: i=1; AJvYcCU2WiCNpEobSTECLS9JmUyW1yOh2Fb+aXCWzmkwOL5rmQS4mKN4Iy+VjQr1dWt9kmKBLBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycRg7f3eqxeBXrWrmSU0HEmGw9BUIw4aIsBY86bMUckiIvdLr
	zpYU/hFsHnV3MxPly7lje2u7YiSw+eS9dVt1bew9cqXf8ravz/2V9BhUbhU6GQJ7muSiO4YMGnA
	dsfE6EOHZf2cErAYA3rtpTjym22vkGvVTOeLH
X-Gm-Gg: ASbGnctUVlSKguFsuhTyXDp/FxAXYO6x3VJaOy6er3r7BM8RgdewulHgvWCxkuI4MLx
	ulbBbv7dCEW7cvey1GFB1Efu3tbIjpZHp+T3VDJFJPwUP4PNqlTLNCC7jeklHEjqQ+ZrK6BdzMx
	zww11w3E9fNqeTrQFnZGx07wN/NF8OmCP3NzapmyNatASxL6keeFSPOynmuH6r6YEE2kaf7/Wex
	Q==
X-Google-Smtp-Source: AGHT+IEbQs5b7eq2h7/BfIya5SeWaCqa1c405PQRAyCi+wQmnmKJTefrJGG4CY/1A3Swb1B9xWJD6eaxN1ZCE75ILjo=
X-Received: by 2002:a05:6402:12c6:b0:5fa:ac6f:ff97 with SMTP id
 4fb4d7f45d1cf-5fcc9387ce5mr166504a12.2.1747070367829; Mon, 12 May 2025
 10:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby> <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com> <xmqqtt5pu5g8.fsf@gitster.g>
In-Reply-To: <xmqqtt5pu5g8.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Mon, 12 May 2025 10:19:16 -0700
X-Gm-Features: AX0GCFuIa0t2tO8hXLo6o17I_mvDp_Z4GeN07Mjsf4JN69xCdHuqCAAX9iaS-js
Message-ID: <CAESOdVD-8j9k2Dq9WgiR9WWO09mpfR9Xxe3pMUWg-KoTfELG8w@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Nico Williams <nico@cryptonector.com>, 
	Remo Senekowitsch <remo@buenzli.dev>, "Theodore Ts'o" <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 10:03, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@google.com> writes:
>
> > If we instead had something like Mercurial's Changeset Evolution
> > (explicitly recording how commits have evolved), then we could have a
> > similar identifier that was based on the original version of a commit.
> > To make lookup by this kind of change ID faster, we could have an
> > index from commit ID to change ID (i.e. original commit ID). This
> > seems to imply a commit can have 0 or 1 predecessors (0 for brand new
> > commits, 1 for rewrites), which is different from Mercurial's
> > Changeset Evolution, but not necessarily bad. For this kind of change
> > ID to be the same across repos, and assuming the predecessor pointer
> > is stored in the commit, we need to make sure to transfer all commits
> > back to the original commit when we push to a remote. As I think we've
> > talked about before here, that can be problematic because the user has
> > to be careful to check that the intermediate commits did not have
> > anything sensitive in them. It's also often wasteful to share all the
> > intermediate commits with other developers. Another option is to
> > transfer the predecessor pointer outside of the commit object. That
> > has its own problems, like being able to create cycles in the
> > predecessor graph.
>
> A few comments (not necessarily strong suggestions).
>
>  - I do not think you need to limit the predecessor pointers to 0 or
>    1; when you started from N commits and worked to produce the
>    final single commit, the result would naturally have N predecessors.
>
>  - The predecessor pointers do not necessarily have to participate
>    in the object transfer, just like filtered/lazy clones can ignore
>    the tree pointer in a commit object when making a commit-only
>    clone and the contained trees are fetched from the promisor
>    on-demand.  It can even be set to be filtered out by default,
>    since it would make unnecessary transfer cost people would not
>    care most of the time, and only made available when the user
>    expresses that they want to know how the change resulted in the
>    current shape.

Sorry, what I meant that those two things (limiting it to 0 or 1
predecessor and transferring predecessors to the remote) would be
needed if you want to be able to use the predecessor pointers to infer
a "change ID" that allows you to do things like `jj describe qx -m
'new
description'; jj new qx`. Oh, I suppose the former can be relaxed by
simply saying that the change ID is defined as (or derived from) the
last commit ID you reach by walking predecessors backwards by
following the first predecessor pointer if there are several. You
still need to transfer at least that whole chain to the remote if you
want to make sure that others agree about the change ID (though you
only need to transfer the chain of first predecessors).
