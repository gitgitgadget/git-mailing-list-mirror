Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FC3570BA
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471236; cv=none; b=UaS20zke4+wc4GonpO4L6y06e0IxObFKLIOpVac7neTXILfYtAFGil+YwrUaPjmko/9DT1VOu5RT/7O7U3S+Jr/1ce87Q+Gi4B810dJFPpE4nMtU9trWVG+CldmzUFgGIuuXoDmMfEJ2GLu6mXS65rE51x/a/+mxKrwBzVme3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471236; c=relaxed/simple;
	bh=lezCYUAHxEYjnYVMFMF/9Q/MSoOdLhZE8Az1jv8LTfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1k97xDj5alwpKKtSatZ7O/v02pLVcSgGglEe3ELsj8W6U0xHzetlqCk7DjS9XteaPkRbH7UBtW1QduX7TVkXzCFMnQwLZStPm48OXSvUg5cMzwJOyG9aReVCOgeyjmZ+wRby7hcSFj8yHMnsJ9i4Pf3aw+gQBPJLKdDlDt/8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfBrvL+L; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfBrvL+L"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a3340391cso1628041fa.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762471233; x=1763076033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDgRd73jn4Rupe7qPVG+D6XBKCD9m3z3xJIWzhpF/KE=;
        b=ZfBrvL+LcbBYfDCAyFrYFDQi5OgGSqntsPiwpAtEl7I03uczUaOWWaNdTajQardw7k
         cMgMQRB8UgZYmwYPmIYrrm/FMRBR6AY6GvLeT/hndaQWSdCDmeNwPx6bM7n08mxohP0i
         9yzxQhT2IIIdrVCIeiR9K1OgALC+yjARvKwGGCYK5pdj7Qo3QVHzpJpHkEzacrGVQIqd
         vS3xc0BiCx0J6NS3MfNitxh8IfmnYH/xh52TMDNxpio2UocElfl1/UDZ6/9KuUlMBIWs
         M72WB8AuYckfWCw6f75u21meFf6lnS0pEfSXYAOF9fiA9EyN32e2MHJvBDFaR3pFq9Rq
         HVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471233; x=1763076033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yDgRd73jn4Rupe7qPVG+D6XBKCD9m3z3xJIWzhpF/KE=;
        b=nN6FRkGeShB3hEsJ4cqMDxew8GWk7vwJRGk6e2s3CGe0e2/yLlE8uRr2TNCoFr6rMS
         8PesV6QpkrOs4ww4NZ9XCQ7r9mXOt2Flp/sBFQhlM1ToabvNr9YMr2oDfZzVQGzf6nWL
         DR4SqF2AREiE2aIDhgga93cAYEWb72GK2N9ypZ7d+kr8jxc9bQvCd7Z0Msjs4juq4iUi
         fASz6TtrgMqgEfdMaojJ4o+VuNVmP90bf67qyNgZAvSlgKpPwPi7KytqvSrjMGjHsBxJ
         dHXAmwCca/GFiEcqOc9oo/hWuWamPSZy77kDQKpImpLxPyqPryLYRC9xUWeXq7H30V+7
         +Wng==
X-Forwarded-Encrypted: i=1; AJvYcCXfD6hUBQ2j3Tpe0KZj+CJj709VtqeEcSSN9QD2pC4wWcb8R93IMcou4MecQRwSUt3qeG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2X8K+TZ8UHD3iPHKMUn4KEQr24+T77KSVCvt8FP2RIi5tbjnE
	BgFQPZ6B7VvhoPPfF8GDiVMTTHbYyHOgRy7qrgGRG7QURZyWd8WObxEkrEaJMG7W4hxTSPArajH
	wQzq3geZwXa8XgdJ40EbgO/lWvmT1QDqWAw==
X-Gm-Gg: ASbGnct9HplnCprRBWlrN7F3wHKXcbhP2TBXuoeOc32t5NbUSy9zKKuTnEQyqC2nq5u
	hZnuWMSiAuw+LkTMjXpm/jRSPC1mfLfRpx3biyp9otx9A1j6nvx3mM79AHPiJGDHrleQAsnnUrc
	3+9GtRaRUAJrXg0Nrlt0v7FLSYdlIyrxxcln1zzgX7FJuTSgbf936So9C16A0dr+rmkfp9+A+R7
	RHhgE490qppOUFG7d3wq6bjkvVut09w1dIjLgVcLlIcRoM+pZlCyet5gTucfA==
X-Google-Smtp-Source: AGHT+IGlD8J9hSTSnFr4EWg1wevl7f3xc8RiWu7m9E9j4jEY1/Fb6aMASe3pu9niXlZfjApLkMZztBdiK8paTbtgyWo=
X-Received: by 2002:a2e:9cc5:0:b0:375:d1e4:21b7 with SMTP id
 38308e7fff4ca-37a7333dabemr2053161fa.45.1762471232753; Thu, 06 Nov 2025
 15:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com> <59054ea0cb65718dbac500d342bc960bdb5066c1.1761776388.git.gitgitgadget@gmail.com>
 <a66fb440-058e-4cd8-8971-9c320c0387e8@gmail.com>
In-Reply-To: <a66fb440-058e-4cd8-8971-9c320c0387e8@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 6 Nov 2025 16:20:21 -0700
X-Gm-Features: AWmQ_bmsqEnZj9fbN9IH7CneBMPBdMmRbZdHOUcu8pQ0r7C3jh-QZnOTkhPsm88
Message-ID: <CAH=ZcbCnH_3C9D4fppVAL3yZpVKGvJ6SM1FrPwpj5fufEbFNtQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:00=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ezekiel
>
> On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > The ha field is serving two different purposes, which makes the code
> > harder to read. At first glance it looks like many places assume
> > there could never be hash collisions between lines of the two input
> > files. In reality, line_hash is used together with xdl_recmatch() to
> > ensure correct comparisons of lines, even when collisions occur.
> >
> > To make this clearer, the old ha field has been split:
> >    * line_hash: The straightforward hash of a line, requiring no
> >      additional context.
> >    * minimal_perfect_hash: Not a new concept, but now a separate
> >      field. It comes from the classifier's general-purpose hash table,
> >      which assigns each line a unique and minimal hash across the two
> >      files.
>
> It would be nice to explain the differing types for the two fields in
> the commit message.

I'll add something like:
line_hash is a uint64_t because it is the output of a fixed width hash
function. minimal_perfect_hash is size_t because its purpose is to
index into an array. This also avoids the problem of having to cast to
usize on the Rust side every time minimal_perfect_hash is used to
index a slice.

> > diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> > index 85e56021da..16236bd045 100644
> > --- a/xdiff/xprepare.c
> > +++ b/xdiff/xprepare.c
> > @@ -96,9 +96,9 @@ static int xdl_classify_record(unsigned int pass, xdl=
classifier_t *cf, xrecord_t
> >       long hi;
> >       xdlclass_t *rcrec;
> >
> > -     hi =3D (long) XDL_HASHLONG(rec->ha, cf->hbits);
> > +     hi =3D (long) XDL_HASHLONG(rec->line_hash, cf->hbits);
>
> "hi" is only used as an array index so it might be nicer to change it to
> size_t and avoid this cast instead.

I agree. I'll make that change.
