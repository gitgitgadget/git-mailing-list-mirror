Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B932236E8
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765241060; cv=none; b=KX4X7EXEAdTuT1kOui2FZavD6EJV0vkmVxf7BI6h6an90Hm6ShuWkktA480dnH+7HNR1gEYCJ2SJnCRk9qn3g2xvXQ7+iFTpgtk4Szgrp2eislK0h4tMSbXVCbJFzQGWT/vZ4x+McZX3pG9od/ih0hW7bLl2MyQ5sHqRKiTL08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765241060; c=relaxed/simple;
	bh=Yzx9BlscsXeedfFRgNSAqXz09TgzJTbvO+eb08CX1GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXB38bmEutRxZlHwQuHFJPF29jxfiwofb9zBcYFDZabZNzHxXxuoLFfk3cQiGLiFiPCMRS9YUYhkdgByizUxxJmVn76ZXiCaMqd6iQvvtu+qLP8iGc3EPQMyLzkQ+t8Lpar0NjxttgGUd+zddn86M9p7NRZbsyKGp7X7ALkTHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpTeFJcF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpTeFJcF"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so5283013e87.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765241057; x=1765845857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj5uhrUO1gVnUrsk7PoItidc8h4rWSUm8VLWuRm6kA0=;
        b=YpTeFJcFGCeSNWSi1oOgXLxmy7S8iOP5/u3YEUhNpXDS9wTGgcbp41tQe0/I1gFTH8
         QEZ0/tIheGR9coCaXoFgJN7Y/5qucH9ZMYlP6o2cGCTbwFoEYYBear4uS+8qXgJbvi80
         iX3G/6viuIzkyhGg+Wf63UcrJu/1iLbUs7LvmQWZ1LDVnzO+mRMgBudjfjMnOo/tsm+2
         mgtUvWHmUp7iwxhZj0jSkBCE6Ci7wyWgdltUJXORqykcSbPD8jzCHsME5biVVXWU3MHd
         QIr5XfHs8dlgx5HQi5tAlhsMInGanYylhP6aksk6X/sG/5dXzbEOqgbomNedTxeD2xlO
         YGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765241057; x=1765845857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj5uhrUO1gVnUrsk7PoItidc8h4rWSUm8VLWuRm6kA0=;
        b=hQ3WWXURq9FNsnCpzBm0jDpHv2idTKH+e36DEVMUPJqXT4XRid4N2FufsI3g+B9B4u
         V/5FgFZVSoUTtGHgJ6l5GeC6tR9z2G1RxlN8LTpaDOq9MwRxlWnW2ll0WH9qIs6mG83g
         dK769N3gLzgkxxa4zM5rJiptexE/Pe/8h0fHoVJai9DAKz1ScC1XBrMTdVZVXu7cughd
         jEv+tnPz+xsLAJtIOh1OgPuM0sMbbOunHjzihLxRFqTJjVWTD03SsNJAEspG6gPc69ha
         RBKgNlbmcGG0PM4hP/xWiN59BUhSluDXbkTJPc1TwIW8IaEXi0qJoMdMBlgSvnKK/s7b
         TktQ==
X-Gm-Message-State: AOJu0Yyr4MYWuQLWYoN/a0R20YS3irw1SWD7z/1zdYkFmdYHudZeA074
	XKLoOqFvfEhBQmXzA2x8crDKc2dzwLoUkB2iE9irj4zZEJ6a7ckCNunkbVIrZqslSv7aSrbxD1k
	M9MsTLI6mVMhBmVdfTcOBnOp1l/i24tTcuw==
X-Gm-Gg: ASbGncvpkmHBqGck9pd4NTQmKmC28YXHYrgsFpEJd3TxtuKiWMO5v1mPSJB2i0BDTQN
	IefU/2oAGfmVLAaXRO4yGE+y7pD6B74ftU37a5ihZyYOFwI11x/+hFiCWlBZER/YOAsTsJhdLel
	PccLwImqbzy/SYvI8C+ziCKphFOAOUtjL2R5EBQpS+k/e8El2VqWTaMZK7nd4VLqDyIghD/AGPW
	dJjFTEf5HxEMWE3vXjps1LI8MndSJ0sRgR+I5dKagXb/7/s+vun9yBQ2w3QQx982V+vwEc90uxo
	uOCblnAylKBfMhG144LEXOjD1jvPRWO2XUUkrE8CZqcMznOXjIIJ8LIiLhoixzIefeI=
X-Google-Smtp-Source: AGHT+IGwZ0noPqKfrQ9OwB+zjuweN6LffWLiAxtZYbZ2q7XBdCAgtDKhRojaLlrr2buX5xLLVVJNOmXIHiul5cfsPY8=
X-Received: by 2002:a05:6512:1248:b0:598:dea9:4f45 with SMTP id
 2adb3069b0e04-598dea95066mr3211192e87.51.1765241056752; Mon, 08 Dec 2025
 16:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
 <3tucvydzaelj2mngkocb75l52nssxkkdtt3dj4paviatd3uvnc@u2sy4vig7owz> <874iq1vxwt.fsf@iotcl.com>
In-Reply-To: <874iq1vxwt.fsf@iotcl.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Mon, 8 Dec 2025 16:44:05 -0800
X-Gm-Features: AQt7F2rFbfHAarqcpa2JUO37BRrWsPQVStyxfxEx_LbSgPC864Uon3XgQlLTMwg
Message-ID: <CAPUEspjifD8MYp6UR4pE91OqcJQdFafpeG8zNo1kfdxhnch_3A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Few fixes for cross-compiling with Meson
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 6:41=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
> > On Tue, Dec 02, 2025 at 11:48:07AM -0800, Toon Claes wrote:
> >> I was cross-compiling for s390x.
> >
> > Just to clarify, you mean Linux on IBM Z/LinuxOne, not 64bit ZOS/ZVM,
> > right?
>
> I'm sorry, I'm not aware of the correct terminology here.

IBM marketing doesn't make it easier, but yes IBM mainframes can run
multiple OS, and I have to admit I was kind of surprised to read we
had a working meson cross compilation for Z/OS, because I know that at
least cmake has issues even building natively.

> If I run file(1) on the compiled binary, I'm getting:
>
>     ELF 64-bit MSB pie executable, IBM S/390, version 1 (SYSV),
>     dynamically linked, interpreter /lib/ld64.so.1, for GNU/Linux 3.2.0

So this is 64-bit Big Endian linux for the s390x architecture (likely
compatible with z13 or higher CPUs)

I happen to have one of those under the desk running RHEL9/s390x, so
will be happy to test your crosscompiled binaries, assuming it is as
simple as installing them somewhere and running something like `make
test`

Carlo
