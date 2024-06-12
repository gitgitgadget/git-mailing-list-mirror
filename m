Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD3155CA9
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183134; cv=none; b=KoDmZwVsCdZiE1y6+ojQO9KOcJOR9hA9r7Vk2mumh1IXZ/Fok2GfVFyV1WaNVOtrkH0/RqwKnnq2Tae2nMNYOQ2b9rfFGi8oCRUJ4dvyFaULgL/rXUaSS5W51g+K31IJUtfbCdErsizXOg6qBo/lRODsurXrMnAoZJT15v3LQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183134; c=relaxed/simple;
	bh=ix0bWT/HdvcaitKn96oh00XYorRkiaY6YQ+2Pa8CyWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjWRDcwnWC9kjdSRpTIBQ7CVm7l9WtAfQLe798Uqk2d20C9/vX+8DqtL3O90K3xu7RWjuLY50xZ6U5bAfm++7W/pdzCS+WCv19vHbg5qZ6G9IWH5UkFnQBhXBJmZUpEAAB9cN9dV6uTY4jK2uY0GC7LqNifKS0Ib75+MOErlMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOYUbldm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOYUbldm"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso9813542a12.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718183131; x=1718787931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH/qyqPkASUrVNGH57pbgHzf4oWu+QTo/IWy22aMs1k=;
        b=AOYUbldmKqu4bJhG2OReWju/f5cVPQcGObB36WXSNV2NQ49IiJKDpr9St0n1MXlpwp
         w87tXAijlKp1XlWQGclKVZlSzwIHpPhpJG7LCvnmFnfpLKEnFyJyc+po0XijiiyGdvWG
         kG7qk2jgYunlMRbY5X595tkcUPShLk9e992yDnNyzH9VfA49hTKKIjFx0KDwJdmL3q0N
         Mwmt1R3d3C4WRAorDPWTLIge0wr1N7BC59glFW/7QsKiElI0fr+5JtvIJWq/m+pkNtFI
         MPHyd+AQvZTyu57DM5JNWZyFPdpX03P1Zblq2tt9f9zzJ1cebE8Ptk3LY5gd4nZvjWW6
         P7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183131; x=1718787931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH/qyqPkASUrVNGH57pbgHzf4oWu+QTo/IWy22aMs1k=;
        b=q0j+5cMiv/xaLVNmqAd4jcQe7nHgCtIxxXp8wnYKzoBZ5dU9I7x82Iyt4XXTQ+Ksqa
         8tmn+FYN++3aKHpq17CpfjhqKxWhoAgnGCE5R/muzZ7KOymcaezRYfOT26uyDW8QmPAV
         jK/0cZbNvDfu/gRvXL3XvmkkBBxw/ziGrsxZpqO7PVvDI8kQMos2lOdFZiEL5SJzTrEu
         3YZ74OZ4J7cNMl5MEmy9Q1S63YqpoXjeR+nCp/6trCknbXCNkCCJRaAxdiUr4kh5e6NF
         W/kTKQJ62YIDD5YUYFqVNcrKMxMH8w7ItBoSd5eXqT3iXnLejzmOCFrs9Fq4VBK9DLwz
         eaLg==
X-Gm-Message-State: AOJu0Yww6uNlkxAoMl3zcFAZ2m6h+4w657eoWFO4hSqg5SUWzLCJPwIR
	E8E15x1j+xLHhRQ2UbROqXpZA/ny2rnTB6pdaQhH9J7/GwTznf4MDr0KvmFFTFskgFK1nB1/UYc
	IBD0YHuT15kBb5IoC+2aSQ5osQnA=
X-Google-Smtp-Source: AGHT+IFsd41UDHdTfgpZsSzcbelqwwdJ5PKwFVW9R8O8b1iac8dk6PMtNGLulcJtgf6cVWUk3bGTtdCsGbl7mPBD9jE=
X-Received: by 2002:a50:d641:0:b0:57c:ad11:e755 with SMTP id
 4fb4d7f45d1cf-57cad11f2e1mr533481a12.33.1718183130858; Wed, 12 Jun 2024
 02:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
 <20240612055031.3607-1-chandrapratap3519@gmail.com> <20240612055031.3607-6-chandrapratap3519@gmail.com>
 <ZmlHZXN8_7rKLTYk@tanuki>
In-Reply-To: <ZmlHZXN8_7rKLTYk@tanuki>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 12 Jun 2024 14:35:19 +0530
Message-ID: <CA+J6zkQANGzX=+=U9=DYfVujV68yE3-LvvrgF+bnYtgAskFRHg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] t-reftable-tree: improve the test for infix_walk()
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 at 12:29, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Jun 12, 2024 at 11:08:14AM +0530, Chandra Pratap wrote:
> > In the current testing setup for infix_walk(), the following
> > properties of an infix traversal of a tree remain untested:
> > - every node of the tree must be visited
> > - every node must be visited exactly only
>
> s/only/once
>
> > and only the property 'traversal in increasing order' is tested.
>
> Nit: this reads a bit awkward. How about "In fact, we only verify that
> the traversal happens in increasing order."
>
> > @@ -51,6 +50,7 @@ static void test_infix_walk(void)
> >  {
> >       struct tree_node *root =3D NULL;
> >       void *values[11] =3D { 0 };
> > +     void *out[20] =3D { 0 };
>
> From the test below it looks like we only expect 11 values to be added
> to `out`. Why does this array have length 20?

That's an error. I'll correct it in the next iteration.

> We could of course also use something like `ALLOC_GROW()` to grow the
> array dynamically. But that'd likely be overkill.
>
> >       struct curry c =3D { 0 };
> >       size_t i =3D 1;
> >
> > @@ -59,7 +59,11 @@ static void test_infix_walk(void)
> >               i =3D (i * 7) % 11;
> >       } while (i !=3D 1);
> >
> > -     infix_walk(root, &check_increasing, &c);
> > +     c.arr =3D (void **) &out;
>
> We can initialize this variable directly when declaring `c`:
>
>     struct curry c =3D {
>         .arr =3D &out;
>     };

Right, this seems more concise.

> Also, is the cast necessary? This is the only site where we use `struct
> curry` if I'm not mistaken, so I'd expect that the type of `arr` should
> match our expectations.

Trying to do this without a cast produces the following compilation error
for me:
initialization of =E2=80=98void **=E2=80=99 from incompatible pointer type =
=E2=80=98void * (*)[11]=E2=80=99

> > +     infix_walk(root, &store, &c);
> > +     for (i =3D 1; i < ARRAY_SIZE(values); i++)
> > +             check_pointer_eq(values + i, out[i - 1]);
>
> Let's also verify that `c.len` matches the expected number of nodes
> visited.

Sure.
