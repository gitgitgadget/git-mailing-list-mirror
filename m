Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7CF9DA
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336804; cv=none; b=bytGN98EkyE8w8PBp6t/s+/s7IjADCd8OpTuV3MDqLHj8vpT3CIXKpziI2osjuxfLwFCYfQOPxbx4bmhOiFpraS2rIbp8NZiEw9Z2elPAAEFYELME6i/ipdXKn0Ap3UlSx5I32XtxEQfA4H+CAdXY8FfTJyescyAUyxt3sJAFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336804; c=relaxed/simple;
	bh=jDD2r7UqrbtbAdeXoRc5yYxX2DheFuEpvpQdImWWV7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqw9yCRL8xd7Z/siR/ICfFCtymvshfjavgBrTjgRxgN2/c8qE89gd4wdK+NtCt1rECmRa+2K+7pAwaSo4yt6AUvEKWUP+2Qf/BtFRw7WyCywIvU9Td0gdS4TFNpuhTdGRoo2pxkoEvHtHntPksEGVkt44Ei5WQCujBIVErCVUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeOuEY3t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeOuEY3t"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso1840a12.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742336801; x=1742941601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VthF02+A8Gkku5qw4K1F2IEmsxzBOvmNFfXQePb/OGM=;
        b=QeOuEY3thm0yTA31GjuVdf2v404/z8ofQ2Ew6XO6kAV2nzUNZiffco/ZAqAcdPw9d9
         X5/AA/xcbAquXyU/yUDJj54BDkCnz29O5KZkH4DCF4EXioYw2ScFd09db5ja57Mjjc6J
         ItVFyAFmIfhkAuMZcL0wYhdbM61S+MaqCJ5WMkbaul3jmFcWRBR/GayYvzZTn77diTVn
         bHjDAL3lImRUYG14F7GnRJdEG8QWHF34iljERNfzLbn9gbNx1nHA09b7olBorhH3nwwq
         5otAbtZSn5XVSIVzRQtpQrfzU0d2QekdRebUtR+XzvgnNySMTRcyvVsshT9Koj8upCuu
         wOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336801; x=1742941601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VthF02+A8Gkku5qw4K1F2IEmsxzBOvmNFfXQePb/OGM=;
        b=Gt1pIwzb/Dek54a23cTDxILF+qoC43fTH6ITipgtUi/elGlBrtIHlRAT2lAFzwM3Lq
         z/DJaR1k38DWCa8VYSYy2XfDoHNzeOPfTgFZ4XtneBWyFpO1tBxGsk9DbAkAKfHrutPf
         bkpk3z3Px5HR/FTYEzmpNf6QBfDcB0l7+X3hF8n/vaFAGWZxD4BLgzB1Hu0b5e3DQzcy
         vioD1g97GZ1jZe9moqIuUdoJOXS8zhrZbH+BAp3UoF8bjdWH6Ld4Y6MxClLvFxbn2oR5
         ccBFS6CXAPzas7eq08A6rwM1FRPVNjLWEue3dCuyqlIVIVpfxaNGCqqjTe6GVhDsZJvr
         Sx9Q==
X-Gm-Message-State: AOJu0YzyPzk9jw4Xx/h2+osE5x0ID9HU/4EIstCOIUP+iF14EES0PYCW
	EO1I3Ox3kDWkWxu70sgk33AOuxz4gCEhe/XWIVTTfARXr/c3nWuqDi7fFt2bg4AAfh76e+Xhdb9
	vIG0+1m1pKh6gIHrKxKKhNNOO5j1k1x1VwE7h
X-Gm-Gg: ASbGnctxUqshgS5AnDZ+4BA3XFgjBBCKy7HQnDwExywVV9lPX2yDkMezEk3qUPjW9l/
	wxWFgdGkC69gLcIQ3pk3mPXGnI6XBjJD15IjHyD+OpyZso9worJ0wvNC+ykQofbWiCwoRkEF1JM
	g3l160X5dMVthCLjSFMK2ox9Zo1RXM4BfJ1bo2qy+mF2Pc3KzuXE+snk22eBM=
X-Google-Smtp-Source: AGHT+IEVVgcogfM8D2HCUbpJYirkLEc7X63M/+R8a3sB4OOGWjRfYvjmEbp1M6AeKO3PjNnmGEJ6VIRg9EiDnlVV9Es=
X-Received: by 2002:a05:6402:2072:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5eb81ca377cmr11772a12.7.1742336801154; Tue, 18 Mar 2025
 15:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235329.809302-3-gitster@pobox.com> <20250318220453.1937685-1-calvinwan@google.com>
In-Reply-To: <20250318220453.1937685-1-calvinwan@google.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 18 Mar 2025 15:26:30 -0700
X-Gm-Features: AQ5f1JpoZM2kX1lkBOyqds3bmbfjHqGMrvnXEJFZqHKz9WQDWJKOtUod4t2SDqY
Message-ID: <CAFySSZC=qxs43ahZSRUeFxFTXDq905OdZ8-4beGUoaScaj=ugg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: add NOT_CONSTANT macro and use it
 in atfork_prepare()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:05=E2=80=AFPM Calvin Wan <calvinwan@google.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
> > Our hope is that the number of code paths that falsely trigger
> > @@ -985,6 +985,7 @@ LIB_OBJS +=3D compat/nonblock.o
> >  LIB_OBJS +=3D compat/obstack.o
> >  LIB_OBJS +=3D compat/terminal.o
> >  LIB_OBJS +=3D compat/zlib-uncompress2.o
> > +LIB_OBJS +=3D compiler-tricks/not-a-constant.o
>
> The name is correctly added here, but in `next,` this name is set to
> `compiler-tricks/not-constant.o`.

Apologies you can ignore this -- we needed to add a reference to the new fo=
lder
internally so this was a red herring for our broken build.
