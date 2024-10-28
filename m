Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE51DF747
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140802; cv=none; b=AM1yFpFpxzdxvbtWVKPG47Runcz4MQep+nIuMDRYJUxU4bFzpBLJl6eQEHuwko0Vip7cE0HAYOY+0J79pIjxPs99G61a4NMtloW2nGYrmhHx+IWUIN/fLUblT+4gw0FsfeswH0QRCphoINScxjjVNhpdNm8TDajePjCJRKpjjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140802; c=relaxed/simple;
	bh=6eflgDwDg3eVoUKCJQPKVu6zLe3YzkVOuP/qu6Cu1yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/cP5lVuyyIFpR4inGV5U29zCF5VMi5K6Q4b2lmx9/N+HnBnH0pYkhBllixvEUM+2Qu1o+RMica6Pup0TJeSKn3lvS3YFDr3mJVAQDlzGTqZNoSFMif8S1ZnVYLRPkB6lDAm+Bz2IuULauvm60GizqNCC16rz4AJyz+G2vTL/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXYZ+sqf; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXYZ+sqf"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so189159439f.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140799; x=1730745599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyKQDCCSoi7GkGsTk4PFQY7+eZ8U0YPXJ0QSM13UnzA=;
        b=GXYZ+sqfEh2GaczFaw1W9wOWFFVG6a6tQKRCko49y9bTA1G2KjqvC/W9SH7QIFnCMY
         OfpKEJzKywlsXXd2DfCPJ59/+UZf+A65bEc6LZxS3lPrHSHh4mvJUKbX2eAM6akgK1vp
         b1ez68UZXZ9djh2fWGHnTy0uWvlB/jup3JHMxBWubZxDaPrJP1LC6aRCst3jo465frE7
         OdPhW60JS40m0B2XRLEXsi5sgV6xnrUGGNlEb3+cHkWBR8mOSJQooB1WGqsDOP7jXI46
         AdoN9DAT0po3MXCLhQpzJMPHeRx7aoXQaQEElNuYTTVkv5ixCWOWWQ2WnNjKJwFbSzGl
         EjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140799; x=1730745599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyKQDCCSoi7GkGsTk4PFQY7+eZ8U0YPXJ0QSM13UnzA=;
        b=VxEtRNGqfKw1kRn8dciOXd68mfaIwdcKyqIUcipQpozHTP7v7oalyXBCiwczfBMFpR
         YkcIxtsTGGuj4uxxf70kv5VJLPVeNPq6T8cccuig+in86lSrqhpSZSYwllkZ8xCYp4Iv
         9D841VpeVgG3L2Q7WP9Csix/MeWNm0f9APH4jCE5618kvN+uYoeHlxGHgSgsbbdQywSW
         9cgyqJCO8/qdXwZhnAocCrUc8xt677yHPhXV/7MZSUTjEjpLVkC4Pbuh2bseAnzgaC2U
         Fp3fwXdla7UQlEn8CSHxIP9zoiWt3C/MxrDX8fEeOq0Y6tvqimj+6/hT8OpvFS44pDTf
         NqIw==
X-Forwarded-Encrypted: i=1; AJvYcCVX+J+k0R/c+kWqSfDm9i4tIb6R8KrkKLmo1+UK/diu/4NAnwEJtqpPkyoEGkGhoWLRI34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzboq46c+jiJDOOJ0gV7MMLAkoEvsee3GtL1dBv1bmosWK8QUV6
	fLVxOtCT4Gy25sEUXmhcqo1Y06lKIHvuRLM41rH4jCtC5ALu/FS3RwaUnppwzdmajZLPNZ3nw04
	9CAiFHRb1qyKg+Q09GKa+Vl1gW8o=
X-Google-Smtp-Source: AGHT+IGxYOhZktYgGhnXjj7NnnzRsjnEKmz9LjkigXUBvjzTZVkxsVIQ+O6IqKvuOdMm4C78pnwv5gmAbVlDV3w5d5s=
X-Received: by 2002:a05:6602:6d12:b0:835:46cb:6747 with SMTP id
 ca18e2360f4ac-83b1c3da9f8mr827333139f.4.1730140799223; Mon, 28 Oct 2024
 11:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>
 <Zx/TwhuG4Ni7mf6F@nand.local>
In-Reply-To: <Zx/TwhuG4Ni7mf6F@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 28 Oct 2024 11:39:47 -0700
Message-ID: <CABPp-BFB+eG7WVJFm3EBfgKzuspAYn9KpDHodpgKuFmWefARBw@mail.gmail.com>
Subject: Re: Inconsistent handling of corrupt patches based on line endings
To: Taylor Blau <me@ttaylorr.com>
Cc: =?UTF-8?Q?Peregi_Tam=C3=A1s?= <petamas@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:11=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Mon, Oct 28, 2024 at 05:57:54PM +0100, Peregi Tam=C3=A1s wrote:
> > Hi all,
> >
> > I might've found an inconsistency in how git-apply treats corrupt patch=
es
> > (representing empty context lines with completely empty lines instead o=
f
> > lines containing a single space - usually a result of a "trim trailing
> > whitespace" editor setting) based on whether the patch file uses
> > Windows-style line endings (CRLF) or Unix-style line endings (LF only).
>
> Let's see if any recent apply.c folks have thoughts...:
>
> $ git shortlog -nse --no-merges --since=3D3.years.ago.. -- apply.c
>     21  Elijah Newren <newren@gmail.com>
>     12  Patrick Steinhardt <ps@pks.im>
>      7  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>      5  Junio C Hamano <gitster@pobox.com>
>      4  Jeff King <peff@peff.net>
>      4  Ren=C3=A9 Scharfe <l.s.r@web.de>

...and thus we learn why no one wanted to clean up the header files in
git.git before me.  ;-)

I believe this behavior was caused by:

$ git log -1 b507b465f7831612b9d9fc643e3e5218b64e5bfa
commit b507b465f7831612b9d9fc643e3e5218b64e5bfa
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Oct 19 19:26:08 2006 -0700

    git-apply: prepare for upcoming GNU diff -u format change.

    The latest GNU diff from CVS emits an empty line to express
    an empty context line, instead of more traditional "single
    white space followed by a newline".  Do not get broken by it.

    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

That code special-cased a line containing '\n' but not a line
containing only '\r\n'.

As to whether that's correct, personally I'd rather only special case
workaround important existing clients.  Back in 2006, working with GNU
diff was incredibly important, and I'd say is still important today.
I can see Peregi's comment that this make line ending slightly
inconsistent, but I feel like the blank-line handling is a workaround
for an existing client we want to interoperate with and absent a
similar important client with mis-behaving '\r\n'-only lines, I
wouldn't be interested in adding support for it.  But that's just my
off-the-cuff feeling and I don't feel strongly about it.  Further, all
but one of my contributions above were mere header changes, so if
others have other opinions, they should probably be weighted more
heavily than mine on this topic.
