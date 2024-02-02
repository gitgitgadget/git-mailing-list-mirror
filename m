Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D817BA0
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858617; cv=none; b=fG87P2cx9k96lAf2GiyrRvyLJckgNuaFrWWtjA9fby3nFHWsqd9qgxSXM3r9Qk6A66YChQKyG1dt5WzsaYLqCI/ybvr9+XrXrIRpULqeWqxx95vxu86Japhjv6Sm+98Ko5jxbitj5ZqCEiROQNLeAjE87fvx8/F6rNF7QVzxDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858617; c=relaxed/simple;
	bh=BI1Vu8uSmdzoWSw2fGm9hrbNYB1S6FEHnw/JNKEYQrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tpO6GFa3GPgoN0aPEpa2kXeoSR7vp2UihIcSaMwsM6o7kqlwd0vgjd5yIdeJve9IoMJYy6PgbYBuTT+8uniUuL6b5RVHzna2JPo0LIidpP8/DgG29vr4RUx4Ts7dvcxWXZ9hY6itUQJKEjMMn0bxfEy4rv1B3CcXop7T/qWz+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdPyqJ+z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdPyqJ+z"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ba5fdf1aso2487684276.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 23:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706858615; x=1707463415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxDgt4v2X+sc4fJrxvBUA3oDaqFLT67fswEJm1BLdPk=;
        b=NdPyqJ+zTND0Hg9Uu6xm42y6DQkOV1Fa1S1WGrUF6TITm+eHwYIcO5dmz3kHmv+bP3
         gngGOxnv2g1+mE9JgRKQdCmVA0MjFwYVf4Ys22nM21DnxBDOK7+xGLYWiTrt7HUjXgG/
         A22WOPRYKN+hdjibNhFCfdJmMopwHQZP7jN/9FzsEWvL3flagx+sxQTXNtxz+bc6FjtG
         GV1K0a7KtTDg8Hj0ByHz7heM2DFoZljkwPOWbNOSDLiTkU39FsNYOG9Ew783W9uKBoQw
         IWWNpTog3XET81cIxHIbiLowEstV1EXbrcoqIbWqM2gsI+m4vmiKKNcxelR55h9KL4HF
         gJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858615; x=1707463415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxDgt4v2X+sc4fJrxvBUA3oDaqFLT67fswEJm1BLdPk=;
        b=u2ad+pu1nq3qMAoGETXzTiobCF30DLeTcbKMZzr3ikF38yvkqyTe4qmWZgsyHcNYXT
         0p0S6/yID1Abeogami+VgmzoiX14M7LEKuTjiEz6buXEhIchcWIpPy1z+TUriLRuMdeX
         QdUcPeyWCbM3PmBMI7v+JlA6v45W1gQPaKcHIIEPrNoSTg7Yde2rjRaGIFLTGMvTo4Oj
         nhmMoM8g8zSg5l1VSTAEnKom6Sv9+zGi5CxfxcStiDlP7t3aRwTjPInV87BJTvCgmo8+
         TAOiS3+Fy/iinXbskRm0pDMyv7dqCn2VHbRSkQ+zzItwRaegvaiqmrid/5tGfjn5vaXN
         P1Eg==
X-Gm-Message-State: AOJu0YxsSZ3lxA/yz7OOzqIZqgw1Ozqi2hMEyjCxD/M5uKs5KGtdxF5n
	467YsWLfqQCAPLkNtWL2QxD5hZTiB0peQHxTx9nyviZQvbN0172zOkEw14Xxmptk98K4Nj3f+bl
	xCA==
X-Google-Smtp-Source: AGHT+IHw9xv4uU8b4CNIXHou8JJaZwwCuF39z5Nc8/O74xJOLojXBO8oY9iizlz9snH3RFDxWWtO09EmN1M=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2402:b0:dc2:2ace:860 with SMTP id
 dr2-20020a056902240200b00dc22ace0860mr71913ybb.2.1706858615056; Thu, 01 Feb
 2024 23:23:35 -0800 (PST)
Date: Thu, 01 Feb 2024 23:23:33 -0800
In-Reply-To: <xmqqa5okyori.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
 <xmqqy1c545y0.fsf@gitster.g> <xmqqa5ol409k.fsf@gitster.g> <owlyv879106s.fsf@fine.c.googlers.com>
 <xmqqfryd2drm.fsf@gitster.g> <owlyo7d011no.fsf@fine.c.googlers.com> <xmqqa5okyori.fsf@gitster.g>
Message-ID: <owlyil371g96.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> I am planning to spend today trying to break up this patch into smaller
>> preparatory chunks that still end up at the same state as this patch.
>>
>> Will post another update on how this goes by EOD. Thanks.

I'm happy to report that this breaking-up of things is going a lot
smoother than expected. The hard part is not so much the rearranging of
code but rather thinking up of good commit messages to explain the
intent of each smaller step. I have most of this patch broken up into
much smaller steps with all tests passing.

> I stopped reading the function after noticing the double unfolding,
> so there may be similar "why do we do this unexplained new thing in
> the function that the original didn't?" issues in the "same state",

Yep, and these unexplained new things are the things I am recalling
(from a few weeks back when I first started this series) and am now
trying to find the right commit messages for.

> In any case, if I understood your plan I heard from you in the
> discussion yesterday correctly, the unfolding should not be added to
> format (to make it double),

Yes, it will be done during parsing for now. This is because of
additional refactors that are coming in the later series, which ...

> but would be moved from parse to format
> in a single step.  It would avoid making it double, and would make
> the parse step about purely parsing without modification, which is a
> very worthwhile thing to do.

... achieve this exact thing (unfolding is done "lazily" during
formatting only, not "eagerly" as we do now during parsing).

> So I am not sure if we want to end up
> with the same state in the first place, though.
>
> THanks.

So far the breaking-up of this patch has not revealed a need to change
the end result significantly from what I have here. But I admit I am not
sure this will be the case for the other patches that need similar
treatment in this series.

Considering how it took me most of the day to break up this single
patch, I am not sure I can get a v4 ready by tomorrow. Might need a few
days for that.

Thank you for your very helpful review comments for this series so far.
They have been quite illuminating. :)
