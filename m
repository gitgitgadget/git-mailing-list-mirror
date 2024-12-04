Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FF18FC75
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350926; cv=none; b=SLbgjkb+ZrwGZjYRsBDJk+JgEGMyZjqI+hBq9yxgPOJ4dobH7sIMh9zi7aRUvi/7EZ6iZuf/qZFT1TxGT3fCKK4M8fYgWrOn7NogOD5AFX4XvdJqdGLBanNb+I8j1jfzNXQsh1rAwHES99ZOWAgWjccSYu8GSoAu0A7ohADsmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350926; c=relaxed/simple;
	bh=i0qJNWy2mXnrPN24OnresvoAizKOMFaF3UiQ2K1SRkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HsDuy6CVfJsR0Zn9QReImMbLkA6gIN2K4wKn5SJQXjfUQz/iyl/+soXT3ZY95PGywKmnzqnFHYLNXuQ2in889oViCAUTB4KSGG68I2icM8bbEf5jEJJUJdEzC2Tk1edyFG7KsYL6ic2llY3yR1AgFmTeKbNZHi8/bVXwSlkug/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH8jYgQl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH8jYgQl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a742481aso2585685e9.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 14:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733350923; x=1733955723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2poZ2HBr6ZtjH7YeO+s8H58dulF2pYvaVhASMrWnSo=;
        b=ZH8jYgQlu2i5K7xIDr2WXOJjhB8z3JkdONEG6aA1MoVJc0OVh7KNvGd3I3tg1JDtKY
         jsDE6P/phfa8rYq/7IbKP9k26/rEuDRfH4RcSuZX3V0OOJluOEo8qPoLuu51U/E5AUMm
         4kONHJejrkmvYgVwzMqtuBcmeneowwRcPgNlE0+9g0CVjSk3VsXI1HZa32QBAsEQ4NjT
         6pARa3mLs2iUmeKlwhou7mb6Tzg7I/KxhjMbf82y92arOcpQbP8v0EYm64JtKze4SfAY
         Hd3yiyCLuOomuWeJ6lEeRQePND3/sZRJSzpG2t7fgXTkUtrjFggo8hTv86S3os3Ya6SB
         rdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350923; x=1733955723;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2poZ2HBr6ZtjH7YeO+s8H58dulF2pYvaVhASMrWnSo=;
        b=p6E7+59VSE66GNOMf1VPTSam+Xwke/+xsvJCprdgUCi4J3JCWZpINPadZVhJGSlb40
         TJRf6sVg0QMbOeAiwEpx5bEnSQLP/ege2WSAeNUzU0cotZqinhQZpdlIb1D4DMmoKMNS
         JjXHqSqoF1jATQpKwD8OtWGBJYTvwKqNpLNleDwuvZABoPSrYwC7O9BWMDgtUZQjrF2K
         ITdwXGNpZ1Hl/WdtEmqDrdwrCbBy4EzsV/438k/tSSRX2gnjV3vw8ho4u8bIuHoyzpXz
         Kf9OUdbEYeZ+ibx22F4fJTa3tS5bHYEQW2kvmOhA8+PTY7OJCNgL0cVsbq39wkCqb4TQ
         zslg==
X-Forwarded-Encrypted: i=1; AJvYcCUxfjZ+08Qiz+YhEOX4Gm8ym2J0WYzR84g/iTkZWeuWl3YmQUItISRp4RIxZ0pXJq7Gi68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrHMr0znlOlerxX/GNt+xSuQixHpPlsBa2QdmOt7iLSkZOW0w
	F6whiH8eTAFBxUKRzW5iZWP94I4o/uAAymQuRfA1P29XBNujI142
X-Gm-Gg: ASbGncsL95IExW4p9EjOV8DjT4/JusPXqG7yZMpgwO7BYNobcpOhrCNt5RvDAEVJXVc
	+0AfJbwgezlziUAqKrdwRIm60GZn86ENqfxX3BDZgaJeI5nTooJqWCR6U5HVg3YeeV0tltPMVFk
	lFnb2tzp4VFv2vslRBXcQttVEjMYHCK5G9XacYbqoe0k5r3sjcSVTfoHhKown6FHJ3G4xzoB3Hc
	TAlDj4uevX4ykYypeidnn2IYZUXaZAOpFD11MkC
X-Google-Smtp-Source: AGHT+IEDMQ77mknlRCi45KMjwqp9o5DO4XB8rvaaPuFzi0lGE5IIhGyGM6dP7ckwb7XhOB+moujLqQ==
X-Received: by 2002:a05:6000:a15:b0:385:df19:cbf with SMTP id ffacd0b85a97d-385fd40ad8dmr6161253f8f.28.1733350922768;
        Wed, 04 Dec 2024 14:22:02 -0800 (PST)
Received: from gmail.com ([88.14.48.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4045sm159201f8f.8.2024.12.04.14.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:22:02 -0800 (PST)
Message-ID: <8ea38d79-9e1e-4d69-b734-273ebddbe384@gmail.com>
Date: Wed, 4 Dec 2024 23:22:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically initialized
 vector
To: karthik nayak <karthik.188@gmail.com>, Git List <git@vger.kernel.org>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
 <CAOLa=ZRaXZWmuLsmq9AFkzUFCa__=3rzAYkhULA4duJnGxcoyg@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZRaXZWmuLsmq9AFkzUFCa__=3rzAYkhULA4duJnGxcoyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Dec 04, 2024 at 11:26:27AM +0000, karthik nayak wrote:

> Nit: Is the commit subject missing a verb?

I guess something like "To strvec_splice" sounded good in my head 
:)

> 
> > We use a singleton empty array to initialize a `struct strvec`,
> > similar to the empty string singleton we use to initialize a `struct
> > strbuf`.
> >
> 
> So a singleton empty array is a statically allocated array element, so
> for strvec, this would be `const char *empty_strvec[] = { NULL }`.
> 
> > Note that an empty strvec instance (with zero elements) does not
> > necessarily need to be an instance initialized with the singleton.
> > Let's refer to strvec instances initialized with the singleton as
> > "empty-singleton" instances.
> >
> 
> Right, so when we add elements ideally, we ideally check whether it is a
> singleton or not. This is evident in `strvec_push_nodup()`:
> 
>     void strvec_push_nodup(struct strvec *array, char *value)
>     {
>     	if (array->v == empty_strvec)
>     		array->v = NULL;
> 
>     	ALLOC_GROW(array->v, array->nr + 2, array->alloc);
>     	array->v[array->nr++] = value;
>     	array->v[array->nr] = NULL;
>     }
> 
> >     As a side note, this is the current `strvec_pop()`:
> >
> >     void strvec_pop(struct strvec *array)
> >     {
> >     	if (!array->nr)
> >     		return;
> >     	free((char *)array->v[array->nr - 1]);
> >     	array->v[array->nr - 1] = NULL;
> >     	array->nr--;
> >     }
> >
> >     So, with `strvec_pop()` an instance can become empty but it does
> >     not going to be the an "empty-singleton".
> 
> Correct, since we simply set the array element to NULL, but this is
> still a dynamically allocated array.
> 
> Nit: The sentence reads a bit weirdly.
> 
> > This "empty-singleton" circumstance requires us to be careful when
> > adding elements to instances.  Specifically, when adding the first
> > element:  we detach the strvec instance from the singleton and set the
> > internal pointer in the instance to NULL.  After this point we apply
> > `realloc()` on the pointer.  We do this in `strvec_push_nodup()`, for
> > example.
> >
> > The recently introduced `strvec_splice()` API is expected to be
> > normally used with non-empty strvec's.  However, it can also end up
> > being used with "empty-singleton" strvec's:
> >
> >        struct strvec arr = STRVEC_INIT;
> >        int a = 0, b = 0;
> >
> >        ... no modification to arr, a or b ...
> >
> >        const char *rep[] = { "foo" };
> >        strvec_splice(&arr, a, b, rep, ARRAY_SIZE(rep));
> >
> > So, we'll try to add elements to an "empty-singleton" strvec instance.
> >
> > Avoid misapplying `realloc()` to the singleton in `strvec_splice()` by
> > adding a special case for "empty-singleton" strvec's.
> >
> 
> So everything said here makes sense, that's a great explanation.

Thanks.

> 
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >
> > This iteration adds more detail to the message plus a minor change to
> > remove some unnecessary parentheses.
> >
> > Junio: My message in the previous iteration was aimed at readers like
> > Patrick, who is also the author of `strvec_splice()`.  I certainly
> > assumed too much prior knowledge, which made the review unnecessarily
> > laborious.
> >
> > Rereading what I wrote last night, perhaps the problem now is excess.
> > I hope not. In any case, here it is :-)
> >
> 
> I would say this is very useful over the first iteration, considering I
> am someone without prior knowledge here.

I'm glad to read that.  I guess Junio is to blame ;)  Thanks.

> 
> > Thanks.
> >
> >  strvec.c              | 10 ++++++----
> >  t/unit-tests/strvec.c | 10 ++++++++++
> >  2 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/strvec.c b/strvec.c
> > index d1cf4e2496..087c020f5b 100644
> > --- a/strvec.c
> > +++ b/strvec.c
> > @@ -61,16 +61,18 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
> >  {
> >  	if (idx + len > array->nr)
> >  		BUG("range outside of array boundary");
> > -	if (replacement_len > len)
> > +	if (replacement_len > len) {
> > +		if (array->v == empty_strvec)
> > +			array->v = NULL;
> >  		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
> >  			   array->alloc);
> > +	}
> >  	for (size_t i = 0; i < len; i++)
> >  		free((char *)array->v[idx + i]);
> > -	if (replacement_len != len) {
> > +	if ((replacement_len != len) && array->nr)
> >  		memmove(array->v + idx + replacement_len, array->v + idx + len,
> >  			(array->nr - idx - len + 1) * sizeof(char *));
> > -		array->nr += (replacement_len - len);
> > -	}
> > +	array->nr += replacement_len - len;
> 
> Why is this second block of changes needed? Will array-nr ever be 0 when
> we reach here?

I'm not sure I understand your questions.

At that point, `array->nr` is the initial number of entries in the
vector.  It can be 0 when `strvec_splice()` is applied to an empty
vector.

We are moving the line where we update "array->nr" outside the `if`
block because we want to do it even when we are not moving existing
entries.  Again, this happens when `strvec_splice()` is applied to an
empty vector.

Finally, we don't mind too much (or value more the simplicity) of the
now unconditional update of "array->nr" because a clever compiler will
give us the third arm of the if: "else -> do nothing".  When
`replacement_len == len` => "array->nr += 0" => do nothing.

> 
> >  	for (size_t i = 0; i < replacement_len; i++)
> >  		array->v[idx + i] = xstrdup(replacement[i]);
> >  }
> 
> [snip]

Thank you for your review.
