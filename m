Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACD24887E
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376525; cv=none; b=Zc7SWCYj/ha6shIk/SGB5mrFyiAT0QKenbKpj+Wus9U00mPBSXc75MYH13qZxHP78sx8ZAgJIGbbrXvjqw9QO9KOKOy4P6AUeycNxBxXM6m/m2RjKvjcaQiJeqcjnVbyiBZ0ukY74y5oJLG1xzSxXtNGzUmslBaMsppTQqBK0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376525; c=relaxed/simple;
	bh=pb+VZggcqFGGWjiJBOgowsPH61tq2B0QbEInM0KoVAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seMMrEAE8C5vApzuH07kN/8FJMYlvrOv8cce1POm0wEVN9YhdJXLv2qBKuZBRTueMhqywyeb+a0JW93kHoErcX8lfcx5d6uj04jT2HNWzVKG+Su78/5vOqhFALASjIL2AClRqbJsxIh+OLZP/xBCCZz1CyfiqglTqzFvNQ6mv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8dgFyaf; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8dgFyaf"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523f19d39d3so151970e0c.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 11:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741376523; x=1741981323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUwnwRFMzLNCd7rfwFhJocUVJPSxdIqIHmu2Z0ppDoU=;
        b=Y8dgFyafo2Ce34FcRXN8wdTx3zvpiIqLoefmDn+abwlcQ3ehiCQlwyr3fl7GiSIHK4
         KVwU0piUe4MVspIqcYHz1FEm9WHyUSUk+fgYfMiWNE2ueLtapwRGQ+3H/nwTwLkAAD1Z
         FlfdK0dMqLNlTXSJGh/o8X5eJhTdT1hjjCV0VVHH75esVZLJ9s/Fvep32N+i07kr8MzN
         yRTqhdHFOD2mgE5afqTkgFc7MRKo5pGbBON4F2s21ynexwnGUBbBfJtviiUjbuS04Pxz
         TcDLnjZM2Q0x14VRR+oV+lIgWS1QJzAkH0CrcEVhEyoCUrthUL7WUyB8Am6nfEixnUNW
         Hmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376523; x=1741981323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUwnwRFMzLNCd7rfwFhJocUVJPSxdIqIHmu2Z0ppDoU=;
        b=jUbVheiTc0Xu/DP5Vd5VFkywyLlox7rc7t6Eifo8zL2sTXv9ImhKj+NmBq/jo+0A7R
         htZHBdstwD4F5jMpHPBcWgf6kymGasknhJQfnImgiXByEY1tTGDC20N0JIxNCP5qHg8W
         ScIPFjV8bW/EvwU0ZoB+xUNOmVZ2kk/0r6XTfftH+54JmkkAJMe0hfbgizDHiTTGKFic
         Kriq6JSIhdFpU+6qxijhfGXioCP6x+QwJHCaTBctaq3FZbj7uon3IHEmCAvj3129MRVH
         Z8ehbvQ2wiEUfvHSaTLZifGWT7ul2CURiVoMQ1/bXg3xDGUfxGlLrfuHy6dYe7cxlBtP
         RuFA==
X-Gm-Message-State: AOJu0YwrwnlJuEhSUxWrd3gymk1WEzVTadQoP5RsuEEF08tmnc91GUxv
	tk9nyZsWcVUCCIzLqJH4+c8dKvnXujLPd7mBaQB8cSQxdBonkF/MDnFws7L2ncFypob3EvevPDo
	it2lliRe2qp2rDf467r9JjJeYd5I=
X-Gm-Gg: ASbGncvOl8/DqQ9vp3440gveNwEh+aEncQk4mxiNY0FcqWc3G53zYBYOYW2IbN6ZfW4
	NmoyuhiAkyiYakYsCBEmLkEQF58DCHNS/6Gbm4ukZLt95pE1i4azi/EfhOjQm5adB8MuGL/OQfp
	NxYA6/CvLbaC1nAMtzls96f3qqMQ==
X-Google-Smtp-Source: AGHT+IEwb/s41YoJAaT93TKlmQ/C/HC8gUV5w7ADnQx2Sxm7D4ZMSWb0CI52J8/zPrZqugfLhTDXbEyv6Y6PMKvPHAs=
X-Received: by 2002:a05:6122:1696:b0:520:61ee:c814 with SMTP id
 71dfb90a1353d-523e40d68fdmr3323452e0c.1.1741376523042; Fri, 07 Mar 2025
 11:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com> <20250306143629.1267358-9-usmanakinyemi202@gmail.com>
 <xmqqzfhyggzb.fsf@gitster.g> <CAPSxiM_fLNUvg86TtCHZTbsE_VnhKdMiDa3pfLPsLa3ThZfxmw@mail.gmail.com>
 <xmqqfrjpexks.fsf@gitster.g>
In-Reply-To: <xmqqfrjpexks.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 8 Mar 2025 01:11:51 +0530
X-Gm-Features: AQ5f1JqpPeoEQ8fGGEP_HUjmp8M0TqamOZLupYvEHJBhatu6ODUvGEw9xOMFQSE
Message-ID: <CAPSxiM_6Z8gVMnRYwccZTMWbJJSU56X4engcx=PK3cSN5FgDPg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] builtin/checkout-index: stop using `the_repository`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, johncai86@gmail.com, 
	me@ttaylorr.com, ps@pks.im, shejialuo@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> >> Hmph, if we are passing anything down to these code paths, I would
> >> have expected that it would be an instance of "struct index_state".
> >>
> >> Do these two helper functions need anything other than that from the
> >> repository instance?
> > No, they do not. They could possibly do in the future and is there any
> > reason why we might want to pass the "struct index_state" instead of
> > the whole "struct repository" ?
>
> You are asking a wrong question.
>
> When there are two things, A and B, where B is a piece of data with
> a smaller scope that is contained within A, unless your function
> needs to access parts of A that is impossible to access if you fed
> it only B, limiting the interface to the smallest piece necessary
> (in this case, B) is always the better design.  A potential caller
> that only has B and not A can still call your function that takes B
> if you designed the API that way.  If you insist that the caller
> pass A (and infer which B to use as part of A), a potential caller
> that only has B cannot call your function.
>
> So, with that understanding of a general principle in mind, you need
> a stronger justification to pass the larger object A that goes
> against the best practice, saying "Even though we do not have to
> pass A because only B is necessary, we pass A because ...".  And you
> just said there is no such reason why you need a repository and for
> these functions an index_state is sufficient.
>
> There are many functions that only need "struct index_state"
> instance and obtains one from their callers.  They do not have a
> repository object, other than the one that is referred to from the
> index_state (to keep track of which repository it originated from).
>
> But this pointer is not designed to round-trip.  There can be, and
> there indeed are, code paths that use multiple index_state instances
> associated with one repository.  But a repository instance has only
> one ".index" member.  It means if you pass a repository, you are
> making it impossible for your potential callers that has secondary
> index_state instances.
Thanks for the explanation.

I did not know or think about this before.

I will make changes to this in the next iteration.

Thank you.
>
