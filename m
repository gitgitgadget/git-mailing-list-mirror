Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132743AD7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134830; cv=none; b=C/bdOnbSEoUfAaMEon9c4ZzlUcdcUEiyOoIzJe3aIyMY5bW0SY3ejUsrrDokjpikREMl3njiwHZaO0sGDkZFSPoIFSXcaqeS5EiM/5OmJi30oLBxQYD+lj2NyNnNCUcOoTcFxsX59XnBLvCIJaXeVn5Sm0FqxOJ5eehAhAwOZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134830; c=relaxed/simple;
	bh=fAKwcSrZDFHFrWUS+22blkLILYf4XdiyO/BnDmKYh38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLzXe3AmSTF7I35HSbw0x0mYMaizfAhCwYQWfOgf7R+931uysSeSN4K7L2vKhpOkV86NjaCo6jTb+oEpxMpNoKkLjxuBo1XFHuJ3JBQgAW+HgEZalLFPXVKGhjvaZTGqQavnM6iuaYSjDICQ/zj6ZR6QUjpzyQvtWJk2gn2PE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTxMi4MG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTxMi4MG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4405cf01a7fso60191cf.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718134828; x=1718739628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAKwcSrZDFHFrWUS+22blkLILYf4XdiyO/BnDmKYh38=;
        b=lTxMi4MGDwolpXkR1wNIJqQmXHNt5umPwIN7DvFdvFpPOppgBBZM21iytwtMfwk/yC
         XoQD9pbJ8GPtqmSUv8dNF92JD7bn2bka9npBRp6xvK95o7nnL7y3Cv2itd+1MDKw2hmp
         NITYr50j909HvSGYgkLDhwPFxFBxJiUT6KPXx2LteAxNg4sWHGW9ztXQaVixTyJ2tK+O
         FfgTnBGhOwtsFvh0ImoDaQRoK2CnKME1W6CGK3cwDDwVfI8y/kTErh/fY/CmbKt+jmyl
         54M3EAuTfu7L6ZHHnmmUysYC6ZP7NZoS1srKvWkliSTihnguizHhu/BRALi+31gV8G0J
         Pezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718134828; x=1718739628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAKwcSrZDFHFrWUS+22blkLILYf4XdiyO/BnDmKYh38=;
        b=FRTkTzLHD8QjnM8m/tjrBV341zbWbpqyQe99bfsO+LTGMSw/mZshuCZPoapIeMe8SD
         jf42tIZk8MUhrQ9iGbN4BvtafOqp4B4P8lpf/ZkPEDIF8DswsrsUZNmhmYhdRaZkGmyd
         G5sFmhqwMRZxe8J5PYY+dIrgTxfLlzhamZYdLWXUcqxu/W4rGATkwXozszjFPCHfKKh7
         2OGB8LZRgGLFTEHOJgo6qtCBYMAp0c0ws9FK506KutNQp1NPRAk+AaZ88Qf1NEm9AlcX
         lHEh1TUzWjGK1L7zPx77fjfs7OrjNqknddDb+pp0U98BN3QN44VBNba0HKkUf607hPk8
         F7dA==
X-Forwarded-Encrypted: i=1; AJvYcCULgVzzfzoKF6ZxJ2g9l5iR5K5MLRddgm1jtgz9I7JIm/rVdxdMun6Rfj0XXg0i1UMGOPw0+gRprDkBLVcarWvVDp9y
X-Gm-Message-State: AOJu0YxE3gnlK91jbJ801BRu/VyAfbp5dOGJF5uKIW2AFIUrY0KtliD6
	4kGtCb/kdOoy769s3Mnkii/tJ19aooLm/XczVcaDUSbA3M8F25QWHnuiC+jS2J2+PdwtncwZKVV
	kiqkFAmZ7pFadJOZlBrXvbDB/XfyuCHzIfwLt
X-Google-Smtp-Source: AGHT+IHK71rD8eW8qy/AUPHTzVfexOLmgMtK+s0IRX4mJ8r8AcV11H2eh9pntYcCklvuwumpd8b8N2VYqp9cJAKyCYM=
X-Received: by 2002:a05:622a:2a15:b0:441:53bc:4f95 with SMTP id
 d75a77b69052e-44158e92a19mr463701cf.5.1718134827872; Tue, 11 Jun 2024
 12:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com> <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com> <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net> <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
 <20240611062623.GA3248245@coredump.intra.peff.net>
In-Reply-To: <20240611062623.GA3248245@coredump.intra.peff.net>
From: Ivan Frade <ifrade@google.com>
Date: Tue, 11 Jun 2024 12:40:14 -0700
Message-ID: <CANQMx9W9dCoxbzwP5c3CJjiw8Q7hcZgxrUxajt8EAkShvbdm8Q@mail.gmail.com>
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: Jeff King <peff@peff.net>
Cc: Emily Shaffer <nasamuffin@google.com>, ellie <el@horse64.org>, rsbecker@nexbridge.com, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:27=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 10, 2024 at 12:04:30PM -0700, Emily Shaffer wrote:
>
> > > One strategy people have worked on is for servers to point clients at
> > > static packfiles (which _do_ remain byte-for-byte identical, and can =
be
> > > resumed) to get some of the objects. But it requires some scheme on t=
he
> > > server side to decide when and how to create those packfiles. So whil=
e
> > > there is support inside Git itself for this idea (both on the server =
and
> > > client side), I don't know of any servers where it is in active use.
> >
> > We use packfile offloading heavily at Google (any repositories hosted
> > at *.googlesource.com, as well as our internal-facing hosting). It
> > works quite well for us scaling large projects like Android and
> > Chrome; we've been using it for some time now and are happy with it.
>
> Cool! I'm glad to hear it is in use.
>
> It might be helpful for other potential users if you can share how you
> decide when to create the off-loaded packfiles, what goes in them, and
> so on. IIRC the server-side config is mostly geared at stuffing a few
> large blobs into a pack (since each blob must have an individual config
> key). Maybe JGit (which I'm assuming is what powers googlesource) has
> better options there.

IIRC the upstream conf was oriented to offload individual blobs. In
JGit/Google we do the offloading at pack level. We write to storage
and CDN when creating a pack and keep the offloaded location in the
pack metadata. We do this only in certain conditions (GC, above a
certain size,...).

At serving time, if we see that we need to send a pack "as-is" (all
objects inside are needed) and it has an offload, then we mark it to
send the URL instead of the contents. As the offload is just a copy of
the pack, we can use the pack bitmap to know what is there or not.

> > However, one thing that's missing is the resumable download Ellie is
> > describing.

Another thing missing in the offload story is supporting offloads in
non-http protocols. e.g. after cloning via my-protocol://, being able
to fetch my-protocol://blah/blah urls.

Ivan
