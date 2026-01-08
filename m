Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93426290
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767834791; cv=none; b=rTMyzlMUHQ+Z22The8FD8AoXKsdP9H1twDNSI5POq2u4xDxgCV+Ex/NIuzsm6PmLsnbSIs12A4g/LesJVHhS0RxO1MFpfrg+UXezveb8SpdoBFJHtqOV1G6Xzqg0BjwO3Oy0elIehJ17uv/P11DMdmTy6MHRmPGXyOUw2B1ILWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767834791; c=relaxed/simple;
	bh=IAgoVflLExH4ur9u1k4ietGpHE3PWskniqEqMm1UyEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/GppsUP0VHLl8Y5n6eICYAToie/wud4HajK2wj6IzJmKfUc2JxVMFRc/p2L/kSZarMtJ0NCBCoOLnugO6JhXL9W71LjzR2UcZYVgdtk/FB8T9agL4UQtTmTt7PXxrYJKarL4VYhlOJdCmmDshWVhrX/pBdo2aMIshNHDMV2MS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv7IaM6v; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv7IaM6v"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11bfa33cb7eso2822762c88.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 17:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767834788; x=1768439588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqr3gdyagfBa4sW+D04+bHnBVdmBKNHqmeKmlLgai78=;
        b=hv7IaM6vm76LxmQ8A8a6bkb2wGmtu7j+qQ+uqXuQrMq+uEB8omBUuG+uNAacp/rbkD
         f+tu3QsNEnlSOyOXYRjDV4bp5vaj5al4sFEE0XcwBDJZ8VMbrVHA2LPQAulDHdxYD/Oq
         zcZQwI/DvY+Lj+eS0ID0TgazuVMv1W8NQuLpCa+dKwobLtxf+etcmMGgd9PhB31BpJhG
         RNw1LbE1iK48zroPxH5NYTpvPQA0jkoQ5Dw1XzRYfdGjtB64Q5IwLBz6wDgVMmqqU+eA
         HRKKFRSlbvCp0oG7FCxoebxu4+I5l6i1W0XL1qG/H97H77FwytIHjqiPhNYBktPSixWq
         T/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767834788; x=1768439588;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqr3gdyagfBa4sW+D04+bHnBVdmBKNHqmeKmlLgai78=;
        b=xCbQM+Yrd/MqlhePss5ERttRxNTsT7o5y6o55Z0MQU1CRzI90YsH5fpvR4ozjNHwGF
         mIeJgYk79nN23arFn0ETzj9bCYYfz070jTbJNmN68BBp9+EeswsOPwUKSwSu1SIyTWRs
         +RCffBCYpAW0+xXPbkD3oThKdk4Z46ofLI4XpfutqArrImvcTC7OlKQPSOCe9vf0jE63
         RsPfnf7VoDlYQuVD5wAx+meAxtFakKdSHszmbjk2pyTZ+NHTKTgT84SRNKG4fLmuIsTg
         IlyBVSLFpHn1dpZX3dexRPPMM1qj75q9qTYXYnrFbVGUr59yvppmEuQfqyEVy++KAXkU
         raEw==
X-Forwarded-Encrypted: i=1; AJvYcCXNFHxF2jo3FSkPiAEe/jSrSJdFmlxKBYV/yCNxTu12UOPbrd+qDbn+eHftSX9rwdYaokU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIaz7Fr8MfMF52Jmgc7N/XmoyVjNpq4EpzaiYTDprc/R0HQcC
	IIA/eQzwVSVIHZbzzNFW9yXrxsAegxLbQTl2NWB0zZYCLJ5cbbU8rDRN
X-Gm-Gg: AY/fxX5l9hLuOpKa/Zx79fZ9ghSWYv/tmns0ZEzQosu8TAxQ2txhJso4ek3kfoPWlbN
	JknfIOqH/Is5Eiim2R5TUxpqxpoDU69OGWscKVoGiPtfXEUXwkYq3g8rdq2Edi0xDDC+5X3fLri
	JdnSAWKjc4r1wg8UB6Ys6aI3Kq+kwUnfWRzfpKTk1DtLdHmn4JpNb0gDoX5P1hL/t0557IrUhfD
	+DGlEGiBs5OTXKJ3I2n9934KUWAvXjIKExqvMQ3L/lMj5B99KxgG+ANEe2zfm/mIbzmQcan//3v
	B7T2hvKBd/EX1J8EyY5LRjcThdXNzstGsZvt3Oxayc4lj2koz9Fr8NaVOofdhSbf5wz/iPvh39P
	NkebBCOQKKTne/fFBrcoiJAuF059pam3qkV16NRW0KANPBYbaYvYo7bnM4IS/HZYoOiEP
X-Google-Smtp-Source: AGHT+IETl8vBVTvM80SdYBIRposwvrLDP3tbKKXUcSLkuCmZhz0ET+ZeMUEukfhGsQTGJNrn+KKZ0g==
X-Received: by 2002:a05:7022:48d:b0:11a:fec5:d005 with SMTP id a92af1059eb24-121f8afe9d1mr3876417c88.10.1767834787577;
        Wed, 07 Jan 2026 17:13:07 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::361d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm12063795c88.4.2026.01.07.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:13:07 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>,  Matthieu
 Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Matheus Tavares <matheus.tavb@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
In-Reply-To: <aV7ujZ2FeO7EleT5@fruit.crustytoothpaste.net>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
	<aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
	<CALH9GrYOjb92gjrtdjwapFH9L73XGg1Kan8uz1aVLpSXNURi+Q@mail.gmail.com>
	<aV2ZS1lvLivi8xRH@fruit.crustytoothpaste.net>
	<87secimchc.fsf@gmail.com>
	<aV7ujZ2FeO7EleT5@fruit.crustytoothpaste.net>
Date: Wed, 07 Jan 2026 17:13:05 -0800
Message-ID: <87ldi8aov2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-01-07 at 01:35:11, Collin Funk wrote:
>> An unfortunate trend that I have seen with Rust programs is that they
>> completely disregard the systems locale. E.g. using
>> LC_ALL=3Den_US.ISO-8859-1 and passing an "=C3=80" character as an option=
 will
>> typically fail since it is encoded as 0xC0 which is not a valid UTF-8
>> character.
>
> Git does not usually directly read input and then convert it to other
> encodings unless specifically asked to (e.g., `working-tree-encoding`),
> so I fully expect that nothing will change there.  However, in many
> cases, Git also currently does not honour LC_ALL, such as for commit
> messages.

That makes sense.

>> I figured it was worth bringing up since Git may wany to think about it
>> some before introducing more Rust. I think it can be worked around by
>> using OsString [1], but I guess many people choose not to.
>
> The people who have been working on Rust have been very careful to not
> make assumptions that all data is UTF-8, and I don't expect that to
> change.

Great, glad that it was considered. I guess you have to worry about
crates, but I think I recall wide agreement that Git was going to be
careful with what it decides to use.

> OsString is slightly problematic because it is effectively UTF-8-ish (on
> Windows, it's actually WTF-8 and on Unix it allows arbitrary bytes) but
> there is no portable way to get any consistent byte encoding out of it.
> (In versions of Rust too new for us to use, there is a function that
> provides a byte encoding but it's not guaranteed to be stable across
> versions.)  I have some custom code in one of my branches to handle the
> conversion to and from OsString to a consistent byte encoding using some
> traits to paper over the operating system differences.

Interesting, good to know. Thanks.

Unrelated to encoding, but two other things I noticed about Rust. Before
main() SIGPIPE is set to SIG_IGN which can be seen with the programs
below:

    $ cat main.rs=20
    use std::io::{self, Write};
    fn main() -> io::Result<()> {
        io::stdout().write_all(b"hello world\n")?;
        Ok(())
    }
    $ cat main.c
    #include <unistd.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <errno.h>
    int
    main (void)
    {
      static const char message[] =3D "hello world\n";
      if (write (STDOUT_FILENO, message, sizeof message - 1) < 0)
        {
          fprintf (stderr, "%s\n", strerror (errno));
          return EXIT_FAILURE;
        }
      return EXIT_SUCCESS;
    }
    $ rustc main.rs
    $ gcc main.c
    $ ./main | :
    Error: Os { code: 32, kind: BrokenPipe, message: "Broken pipe" }
    $ echo ${PIPESTATUS[@]}
    1 0
    $ ./a.out | :
    $ echo ${PIPESTATUS[@]}
    141 0

Before executing a program using the standard library, SIGPIPE will be
set to SIG_DFL. That is better than not doing that, but both behaviors
mean that the typical behavior of inheriting signal actions from the
parent process is impossible without hacks or an unstable feature that
has been unfortunately stagnant for years [1].

Before main() all standard file descriptors are also opened. While
reasonable in many cases, is not the desired behavior for all programs.
Using the same example programs:

    $ ./main >&-
    $ echo $?
    0
    $ ./a.out >&-
    Bad file descriptor
    $ echo $?
    1

I'm not sure if either of those will affect 'git' at all, assuming it is
mostly library code that is called from C.

But it will likely have to be considered if someone wants to write a
program that goes in libexec that is executed by 'git'.

Collin

[1] https://dev-doc.rust-lang.org/beta/unstable-book/language-features/unix=
-sigpipe.html
