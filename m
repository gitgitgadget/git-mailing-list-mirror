Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50C1537C8
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499751; cv=none; b=hvmSHsovEi7JJx0e6gWN+z7S2pU/MHB2XsgJtZaSU38GiXA67jVSp5K2nit1HqIlyTWsY2r9Zk83X6XGAZsSU9ttbUJ8oTwirBcb2li8T8iIrHrV8dzKsQvDD7KLMaWfBj0X/mvm4yDT/5pMywSW4ewBXo7vfoTYEn1L4TxQsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499751; c=relaxed/simple;
	bh=LfOaIz5vOVXzvOmmhbq0GyFupjSHgqKbV7KpEGewCYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=grqocU37XEU8koe9AJDC/BNAn4cbX7tQ2LWQY7XVAIR4r8uJYRNZsJzowdV0eRnNxP8jwVXODU7aCg7ySRv2p7VzAHZxzm4HQ+aImMJFfSjNZaI9fCREG7OkzXy/quFoe6Ig8x+uy942csezLo8MQ3ulT9JAS1ocRsuQ1oBhttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hp0QKQRE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hp0QKQRE"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso4933814e87.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723499748; x=1724104548; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSclLofCQHxw/exkVY2mrmoaZlEJTNudaGL1jsWFiNU=;
        b=hp0QKQREJKqbdSenBjMGONmKhCef0TjBhuYOOFFwOxoymQ16l3OhM3sO1ygsEHc6OO
         NQo5CiSKEn6/ME0n8uY5extv/4FE3bk41Ja20Nur5BF6WxG6pKh+bkgUcUwa0vAnyE6N
         uLtAA4s1TptMmRmuAi5ZwsQGiq0SXhuAKJMtJyuMxA7jpINN5XHIa3L5a9+9J1RPJEgN
         u9I7Tqa0XvJKsRKCKb7FKy05lsvjP3dpR8TpNFXLj2N2LS2szu2FLeUBa8ql22dchAxf
         yxu6oijUMnNvtl51usj5aKd42yfPz0wtBDypExt6ZHgqxngwnIcio3b88X1HOWhro1Wu
         x1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723499748; x=1724104548;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSclLofCQHxw/exkVY2mrmoaZlEJTNudaGL1jsWFiNU=;
        b=s1yIcj3suGyWFEWCWB8fJNlOBTmHzTDGFaklsBsdyf3gbh3MYDBaZ2f6VJevYp87Ef
         bIJZ4S3A/CeWc6eroXiy1zXZVFtUukYN8RnZG5HjuK+y0yFjbFgs7pvMcFpP48pm+g9N
         nNm0SuBBADT2i3dUBpfl8KnxV4LIGEk3c8H6sWu6rid2/9Hxn/xSzNrtXFiaqNqBt2Oa
         vTeDHpf/xJdR//VV/xarW4zqbNaAaMtFIuzm54ycuzUlZGJhOkDCdy+qooakfyvypwqC
         M1dt37bMq5/NxraGBA96ptDidp9QoKh4TTgq7oaYa3rhOotH8TPRNvp8HlBfklw9APtH
         +4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5IQEZvepD9d/ZqJEWtPM3azgHQc8yTpCYzkwHgoLmgmuUgSkWCG2VnTKYspBEIoNIDHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJG9JWgnvocvC7/53oVmb1r8EKZemQ2TNLjqSvwe9agVtxPLg
	t1T1aHZlefp/vcOLzS8CqSOkgMGgwdDzwOmFcTLtUBffVFxGwjUkk1I77gileHBvTo8Pf1dRWSg
	bQ8AMHgFMCyAdONYdFuMUdBMPa0GdmwGEkk8h
X-Google-Smtp-Source: AGHT+IEVUe+m9bcxOphd3v+0TvzW158poMAcVuxf551d8J7pm9lqxFt+A6+KL6BjVdhv8ZeLoS0EVPfQfqUcxs4k1rA=
X-Received: by 2002:a05:6512:1249:b0:52d:582e:8093 with SMTP id
 2adb3069b0e04-53213658542mr986579e87.23.1723499747592; Mon, 12 Aug 2024
 14:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
 <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com> <bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
In-Reply-To: <bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 12 Aug 2024 14:55:33 -0700
Message-ID: <CAO_smViBnmc4r3MizV5kE406_TvXiwCWtC0jyDb-FT-zp9H9bg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and git_configset_clear_and_free()
To: Josh Steadmon <steadmon@google.com>, phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 2:39=E2=80=AFPM Josh Steadmon <steadmon@google.com>=
 wrote:
>
> On 2024.08.12 10:10, Phillip Wood wrote:
> > Hi Josh
> >
> > On 09/08/2024 23:41, Josh Steadmon wrote:
> > > Add git_configset_alloc() and git_configset_clear_and_free() function=
s
> > > so that callers can manage config_set structs on the heap. This also
> > > allows non-C external consumers to treat config_sets as opaque struct=
s.
> >
> > Do we really need to add this code to config.c rather than handling it =
in
> > the wrapper layer in the next patch?
> >
> > Looking ahead I wonder how useful it is to users of the library to sepa=
rate
> > out allocation from initialization. A function that allocates and
> > initializes a configset would be more convenient and harder to misuse.
> > Calling release functions *_free() rather than *_clear_and_free() would=
 be
> > more convenient as well. I also noticed that the data types are not
> > namespaced when they are exported. So perhaps we could drop this patch =
and
> > add the following to the next patch.
> >
> > /*
> >  * Namespace data types as well as functions and ensure consistent
> >  * naming of data types and the functions that operate on them.
> >  */
> > struct libgit_configset {
> >       struct config_set set;
> > };
> >
> > struct libgit_configset *libgit_configset_new() {
> >       struct libgit_configset *set =3D xmalloc(sizeof(*set));
> >
> >       git_configset_init(&set->set);
> >       return set;
> > }
> >
> > void libgit_configset_free(struct libgit_configset *set) {
> >       git_configset_clear(&set->set);
> >       free(set);
> > }
> >
> > Best Wishes
> >
> > Phillip
>
> Hmmm I see your point, but I am also hoping to keep the symbol export
> shim as small as possible, so that we can try to autogenerate it rather
> than add entries by hand. However, if people feel strongly that we don't
> want to add helper functions like *_alloc() or *_free() for types that do=
n't
> already have them upstream, perhaps we can just put them in a separate
> rust-helpers.c file or something.

I'm thinking of this patch series as two closely related but
technically separable things: the creation of a .a/.so that can be
used outside of git, and the rust wrapper around that library. I think
these functions would be needed by all users of the library,
regardless of what language they're implemented in. i.e. they
shouldn't be thought of as 'rust helpers' and instead just the way
that the library is designed. _All_ functions that allocate memory
should have a paired "free" method, and that should be used
exclusively, regardless of host language.

So nit: I wouldn't call it rust-helpers.c ;)
