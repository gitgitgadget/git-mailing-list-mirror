Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAF4A1A
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749031760; cv=none; b=m25SLgOlPG/mjaHo7RaCX/a7PPYHD6Wal+/BbGAIC1i0Z32jCA32AVMkjgfzSLQ3pGOUveIx2lHzYXsKUhW4HEkoNkT/X48lCjSm3dgB/X0V6nwL3fBOba33QKK+gZHUeJ1z8IfIxlbCHohkbrnx+umEAlhV8jw5vc87r88RnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749031760; c=relaxed/simple;
	bh=794ytLGHul+RZqi0cRK1tTa389EPgiw5UznT2lSGrDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERON0dCaLNPV4z4LxtuCG6XmgI+Dh905NaLiG/Ks18YkYTagpsyHne3liAHp6NTHvflhs7GjSWpMrtRJcolg9OZ5+/CKxgOmWPMe7sbYPlV851E9nRby5nZhPCaxU67q/vyS4GpBAP+w1R8/wIi0kegcqC+UQLELaIMWme6LsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb4F3e61; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb4F3e61"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e5e6ab7b8so60907727b3.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749031757; x=1749636557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SV6XlA4vfsDUhsMJO7CzBLN5i0auRGiZZ7PQSdirhU=;
        b=gb4F3e61rycmV8BlL6AfVGzomdysmIN3JGDX41Js8rlQQdlb6N5AIAaMhirdZFpsEI
         Q0o7eGhZ8uGrlpVxD68ockKGYrd8yTZlLG4Li/U/Z2Kd1gA2l3BQUKbnkwE5gssOmfYp
         S5N2XMI/bjuPSVAYd3RMRhvxQcfa9UYKylQzczSS4rW9eR9358nZDWE6MGF5N1Sv6dTF
         iiqOMWIVYsvkLzDizpFbGbkh5DWv6bHxYaTydZPnrabC+TXCopQXrDXg1+noO3wRullQ
         94YBI8uDoYIzDk3VWuOvd+Ivii98Oc6y6ryJRZ3PBOvT7HzRWrCQSe7ywvkLRfc0/M8a
         5utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749031757; x=1749636557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SV6XlA4vfsDUhsMJO7CzBLN5i0auRGiZZ7PQSdirhU=;
        b=oXG+VySZQvWzmccOCIL/LZIQVQcZIkLxtRa+/Bc31pYGqkQc4sX5Sk8rajKt+C1hXu
         oSH1nb7qE8XSZEA1D2yqBxtpJqtEWHH9x4z+mmf3jKDE1I0W6bbKs8LohzPDCLD+66oc
         wgqMpGvIIx95GPoxHIam9ARpkCnItczLLllinK7BNaprI4aizVNFLsqWkWOcPehUAg9x
         tFvfsZB1MKJ7s5BYFOqSXb1D/FAKORWQIYd3ycP9XuqHgZMb6L9ILknUFFIs4jnyOeqN
         Oj6A6rDUALelw4fR+mrUNx8TTEpIcHE2EfnKErJDj+s5r/nlOwXVvENRQ3NU1lhfXkXj
         hdaA==
X-Gm-Message-State: AOJu0YxAPbnKWqJqKjgTPEdHEp96dCc+tTYUDIPcgFjk8zAfnUV1c3IT
	Mp1Ge2vzYM3R4uxSekgDJ/+pM1GUmomW7Pi5aTwLZj4+Z5VlpbXwM06uaa+z4VvemSNHdvmTjmw
	OpqHtCeOwqR03+WCwJMWp6RFFxvXxMgojJJ4RRjNkAw==
X-Gm-Gg: ASbGnctQJDjmwk08+scqTS0kz5PyT7zmQQPQoYi1fBDMJ2Ej6Y0HzY4kQCSS4SIOja/
	STAe7Jt5zcFqfLTMIlbc04jJ4igFajx3JqPHAcAh8pZAVaQdO1NjpVyvUr4iKFjLkGxYAEsRwK2
	+4J03vNoRdrx9SJFBZFIlQ2hgKKtqkXghl0/4=
X-Google-Smtp-Source: AGHT+IEq/wJHpOhFAWP5/Q3KyuPya+XvhU3reKhb1PlBUMDFWirw9EQL+6KvH29ESjP7ko6sm4IAOeyRVEt7kTbw1tE=
X-Received: by 2002:a05:690c:7008:b0:70e:7638:a3a9 with SMTP id
 00721157ae682-710da1cea1amr28081397b3.18.1749031756924; Wed, 04 Jun 2025
 03:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602122559.208780-1-kuforiji98@gmail.com> <xmqqldq8is69.fsf@gitster.g>
In-Reply-To: <xmqqldq8is69.fsf@gitster.g>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Wed, 4 Jun 2025 11:09:04 +0100
X-Gm-Features: AX0GCFsRit7JxpYMkj-IQuHZkPTBEZXgQWFA7FWWgWiiNQH669XIyajAMMhmZuA
Message-ID: <CAGedMtdV87hx7BvFEnH+oqgojcT9CO6m1fTScMqey057TpMggQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] t/unit-tests: convert unit-tests to use clar
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

I'll make a v4 patch to clean up and finalize the series :)

Thanks
Seyi

On Tue, 3 Jun 2025 at 19:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> > This small patch series marks the final batch of our existing unit test
> > files transitioned to the Clar testing framework. It covers all the
> > reftable-related test files, and is part of our ongoing effort to
> > standardize our testing framework to enhance its maintainability.
> >
> > Changes in v3:
> >  - some code refactoring based on review, which includes initial creation
> >  of reftable helper functions to
> >  t/unit-tests/lib-reftable-clar-test.{c,h} files in the initial commit
>
> I guess this is no longer a "small patch series" ;-)
>
> Are we done iterating, or will there be a small and final finishing
> touch interation?
>
> No need to rush, as we won't be merging things down to 'master'
> until the 2.50 final gets tagged, but preparing a reasonably well
> cooked topic in 'next' for the next cycle is always a good idea.
>
> Thanks.
