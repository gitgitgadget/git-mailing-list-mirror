Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B91DA5E
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622358; cv=none; b=MwrtGIMwpW68gxJ2rY3Bjr2Vu10FNZBAXzSJ/ioL/1CRA3qbgDOFSwBflyZXLfi5iTN4QVQQHcxR/zfNzGCXPGEjJnNDsSwKFVwkXOr2NqXMRmI45bSZC6H49nB3AyVYACEkaPFfM3B8XZzcTK14cHsWYc+REbzPmchM2CrE16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622358; c=relaxed/simple;
	bh=Dw9Nf4DWXdwl+YNGkk7xVnZwTpjc1QhmJ6NFtTqHu9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FyT/jykZB6FlvuIUSQZhUwwHmOuGG5c5/e5RIH6moe25ntfVkZGfXq8MdElS7f/EcMLlN3XGx1CKU8RYirhsN4MbzNyMlx2E0SPSJBkdLOcMKFqc1RIaZ8O06Sq9O8SiyEUGVqtQ3wRTv5Q8bzZekjlCZPlGciEtGqQHjYXSOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHQ/A0A8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHQ/A0A8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ce105ddef5so217534a12.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 15:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705622357; x=1706227157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSh7hqZMqk6nIkzj1/CJMuHffROA4dKKX1WRfRWXRHc=;
        b=JHQ/A0A8N2DehOsGLzMdQ+jOG7KMBL0eQALBERmW/zTLUSk29XpwhgGGS4+ngan3Jn
         kkD4k2zDUNGywXSvcElULhRbmACka/5Hz0lZykGeJxrItPcN1kSPU9tUiZOXgCOJJACW
         Tu8g5ZmOPkWB1gn+WapFuDZurSCI0VwLo06HQ2SXs6mi8aiIAwBqdEmtRDUux7e0Knec
         s9NNksFmgZnN4A3YW8YOn/duu3ih/go/oWtOI4k193wB/fZ6EXb+Gu3f6ExVqrSwL3HI
         e0XK7jObtfK/xM+bCLHEZeJRWoB1EEE6hxYZU/LBgJ+ZMNJso/NmI68hjVrYZ4tquGyA
         EXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622357; x=1706227157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSh7hqZMqk6nIkzj1/CJMuHffROA4dKKX1WRfRWXRHc=;
        b=AKFSn8DtHbxgfsv6r5NIuG/z2wdZMqGutx4qFOL784Btyin5orIrvMzrm2oIHsvn2k
         mbYNUqihGfxc6pYV/1kN82TuBGcAZoAPD8qZQy2HFDjXD3C1zdc2GTjO4VggJAcl1Kig
         ZOGmGZNHoi3IoCKI2K5bQtrWYxbGGvAcKtmo/30ARLuvV5JpelQBG42kw8E0wrInpsCC
         ehsTQ5EnqG8/icnZG85sJBzrEw/IIbm6cROWAdtYr4z01kqbUn2/8vObFudefN3aFaPc
         vbAA1EBSYr6S+4sV9yxViI0EUiS3eWqoJK/xz+1c/004GeyrPKGwalSW16FaaIdlvkNp
         PamQ==
X-Gm-Message-State: AOJu0YwtOkQOJp4/ZIaa3ohnCZp4k8o/m9Odoll+Huh/qBzZVVf+OCWI
	H46dY3g2i72WapOa7dTOzVGh21idJ6/PZP715NLj6ILncAaOos+dPv/l1X8e0UwKQW9Fj0tMEcQ
	Ddg==
X-Google-Smtp-Source: AGHT+IFvqs4nqLXqY3AxvOIZ/TW18AaLchSdEY91hfKlGthM6bEIsHqB9JHuwArq7bICA6jZbrHpiAYVytc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:2fc1:0:b0:5ce:196:6e4d with SMTP id
 v184-20020a632fc1000000b005ce01966e4dmr8403pgv.1.1705622356702; Thu, 18 Jan
 2024 15:59:16 -0800 (PST)
Date: Thu, 18 Jan 2024 15:59:15 -0800
In-Reply-To: <20240116151029.GC2119690@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com> <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
 <owly8r4qi5zj.fsf@fine.c.googlers.com> <20240116151029.GC2119690@coredump.intra.peff.net>
Message-ID: <owlyy1cmgpm4.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
From: Linus Arver <linusa@google.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Jan 15, 2024 at 02:31:12PM -0800, Linus Arver wrote:
>
>> > +static int pair_chunk_expect_fn(const unsigned char *chunk_start,
>> > +				size_t chunk_size,
>> > +				void *data)
>> > +{
>> > +	struct pair_chunk_data *pcd = data;
>> > +	if (chunk_size / pcd->record_size != pcd->record_nr)
>> > +		return -1;
>> > +	*pcd->p = chunk_start;
>> > +	return 0;
>> > +}
>> > +
>> 
>> I don't think this function should assume anything about the inputs
>> (chunk_size, record_size, nor record_nr). If we are asking the helper to
>> be the common tool for multiple locations, it should assume even less
>> about what these inputs could look like.
>>
>> For example, if record_size is 0 this will lead to a
>> divide-by-zero. Likewise, if record_nr is zero it doesn't make
>> sense to check if chunk_size fits into record_size * record_nr.
>
> I'm not sure that divide-by-zero is a big deal, because 0-length
> fixed-size records do not make any sense to ask about.

So why not make this function check for this? While it may be true that
0-length fixed-size records are impossible currently, nothing guarantees
they will always be that way all the time in the future.

> And even if
> somebody accidentally passed 0, even though it won't be caught by the
> compiler, it would barf on any input, so even rudimentary testing would
> catch it.

If somebody is accidentally passing an invalid value to a function, then
it feels right for that function to be able to handle it instead of
crashing (or doing any other undefined behavior) with division-by-zero.

Taking a step back though, maybe I am being overly defensive about
possible failure modes. I don't know the surrounding area well so I
might be overreacting.

> A zero record_nr is a perfectly reasonable thing to ask about. If you
> have a chunk file with zero entries for some entity, then we are
> checking that the chunk is the expected zero length as well.

Right.

>> And even if there are no (unexpected) zero-values involved, shouldn't we
>> also check for nonsensical comparisons, such as if chunk_size is smaller
>> than record_size?
>
> Aren't we checking that already? If chunk_size is less than record_size,
> then the division will result in "0". If the expected number of records
> is not also 0, then that's a bogus file.

I was thinking of an early return like

    if (chunk_size < record_size)
        return CHUNK_TOO_SMALL

before evaluating (chunk_size / pcd->record_size != pcd->record_nr).
You're correct that the division will result in "0" if chunk_size is
less than record_size. But I didn't like having the extra mental load
for reading and understanding the correctness of "if (chunk_size /
pcd->record_size != pcd->record_nr)" for that case. IOW, the more early
returns we have for known-bad cases, by the time we get to "if
(chunk_size / pcd->record_size != pcd->record_nr)" it would be that much
easier to understand that code.
 
> What we really care about here is that we won't walk off the end of the
> buffer while looking at N fixed-size records ...

Ah, I see. This sort of insight would be great to have as a comment in
the code.

> ... (in that sense, the "too
> big" test is overly careful, but it's easy to include as a sanity
> check).

OK.

>> So in summary there appear to be the following possibilities:
>> 
>> CHUNK_MISSING
>> CHUNK_TOO_SMALL
>> CHUNK_OK
>> CHUNK_TOO_BIG_ALIGNED
>> CHUNK_TOO_BIG_MISALIGNED
>
> So yes, I agree all these cases exist. We detect them all except the
> "misaligned" case (which I think was discussed earlier in the thread as
> not worth caring too much about).

OK.

> But...
>
>> (on top of the cases where record_* inputs are zero).
>> 
>> And it seems prudent to treat each of the not-OK cases differently
>> (including how we report error messages) once we know which category we
>> fall into.
>
> I'm not sure it is worth caring too much about the different cases. From
> the caller's perspective the end result is always to avoid using the
> chunk/file.

Ah OK. Then yes, it does seem like caring about the different cases is
too much from the callers' perspective.

But I do think that checking the different cases with early returns will
at least help readability (and as a bonus assure future Git developers
that divide-by-zero errors are impossible).
