Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496912B82
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814304; cv=none; b=pOdxfEQarK2W22RIRn6qSIcGnuaKzY0EQMw6KUZ1tfkD6LfEMIDT59W+tYrn82CM6Fzf8LisIlFAfUIV5xk42OQr2SrFdS+E/lG+xT8QVmrvqssTZAMIrXesXjAqCFf5ulYHyAszz4mljOClR/XJM2X8Nntdq1uw+7lhb6lL6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814304; c=relaxed/simple;
	bh=plo+nW8waYyL02ni4gX98ik3qkugy07beXIPI9+n3WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCohku4yMYWivVrda6FDS0+L/ts2eOa+ctk2119udAYkh2pYeU+TGQV3Fe/4a9mOaX3NAs6WKXIDY6QiNx9wly0tLbEeonvP5NW4T0PMJHHvmdI9kcO+KPyySFgQHPrATgUuZKpE5UCwfxy1tb7hPRlk9wLm+FWiF4chptVvHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNzjd/nm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNzjd/nm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so274667866b.2
        for <git@vger.kernel.org>; Sat, 24 Feb 2024 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708814301; x=1709419101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drfYJ/Is20YgkA3H5Gy9Gm8hAAcMm1JZzDqpwM6Ywpo=;
        b=pNzjd/nmvu08vJodeUQEdSAxxIs8uhRRsKAPHG4zT4O+makhofTPEECxQKxptxJy7V
         kQuRqCznGt5loT5xREqs13ALIeJeoVO6Wk8x6yJMdIqO/s5oGk7PVPM/nXozyGn+NqbN
         oGLGsaqRXpr/LWgsEkD2zuxYdswxZRiSlza2uHK6vqZ10WBWo+n4Yb8I3wamMRPEj8Cq
         P8iNckdjCWccdc4SSji1WEqGvTiW2OhugzLX17nZaG8yZgZRDBeue0SALnZAg1ROLg7y
         8CdqQexppObRPvbDwfxE/hvXSG1+62FQSYfTY/C2GxWFF1tUab57wn0r7wX/tbMvTYUr
         NJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814301; x=1709419101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drfYJ/Is20YgkA3H5Gy9Gm8hAAcMm1JZzDqpwM6Ywpo=;
        b=C9XOI3H1NQxtMe1y3X+78kgb3C1YcvGiUYY+fcqsyh4fyzYp2AdQWzrMHLkJ+h8SqZ
         bBHtM6SPb6Pl5Zh+8+eWdK5lKrCuN35WULqhWrreITxK/4vCvlfXjc1pZCtkBiPU4/PL
         FccldjnziXQWhMWKx6DC6haWEcn5aRj0EI1OX4TcTv2kfZvoc5U5EUUOHMPwUfPSKUfd
         XUpzwnKY94te8NYZN2V3hooBy1C9yX8JXTGvFOkg4OQQZIel1lzQvtE0davyy1vYKkei
         GvslhN0n4nx/xLH/9v/nV7ZkutJACm7KfXIUjj/CxkyFpRLRKn/RRA/lm0CQP46/5oJV
         OTDA==
X-Gm-Message-State: AOJu0YyjqWNDfPehLS4bvqBkM+oMj6Hj9w7PVAGnhNdK9KQ/i4JXsHPp
	yCam63NOs6JnpGc/jMF92J99mEk3HdP9mw411A7T+B1ZTDSTD1j6aZ3lrn4RtD0hyo8t3nN6H2k
	B0H3J9yCIYc4Ksr0DpYnJN1x/us2+9EjZ+cB/
X-Google-Smtp-Source: AGHT+IGKVVppdkX4EX6nyoCGHtmPhARqpVWSHSPB5nz5/RPh88OX3SALtk/OXts0qACtlkQZgaYSiMt1zgx4UtEqvP0=
X-Received: by 2002:a17:907:984c:b0:a3e:4404:dc7 with SMTP id
 jj12-20020a170907984c00b00a3e44040dc7mr2385647ejc.23.1708814300819; Sat, 24
 Feb 2024 14:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4jdxmx2e.fsf@gitster.g>
In-Reply-To: <xmqq4jdxmx2e.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Sat, 24 Feb 2024 14:38:09 -0800
Message-ID: <CAO_smVg4E4bENU18tiv8xnscnk46i=GW=Kq+xKvO1Nf7qCGy_A@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify the wording on <git-compat-util.h> requirement
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 12:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> The reason why we insist including the compat-util header as the
> very first thing is because it is our mechanism to absorb the
> differences across platforms, like the order in which system header
> files must be included, and C preprocessor feature macros that are
> needed to trigger certain features we want out of the systems, and
> insulate other headers and sources from such minutiae.
>
> Earlier we tried to clarify the rule in the coding guidelines
> document, but the wording was a bit fuzzy that can lead to
> misinterpretations like you can include xdiff/xinclude.h only to
> avoid having to include git-compat-util.h file even if you have
> nothing to do with xdiff implementation, for example.  "You do not
> have to include more than one of these" were also misleading and
> would have been puzzling if you _needed_ to depend on more than one
> of these approved headers (answer: you are allowed to include them
> all if you need the declarations in them for reasons other than that
> you want to avoid including compat-util yourself).
>
> Instead of using the phrase "approved headers", enumerate them as
> exceptions, each labeled with intended audiences, to avoid such
> misinterpretations.  The structure also makes it easier to add new
> exceptions, so add the description of "t/unit-tests/test-lib.h"
> being an exception only for the unit tests implementation as an
> example.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * git-std-lib folks CC'ed to show them where to put their exception
>    when things start to stabilize; Elijah CC'ed for his 8bff5ca0
>    (treewide: ensure one of the appropriate headers is sourced
>    first, 2023-02-24) and bc5c5ec0 (cache.h: remove this
>    no-longer-used header, 2023-05-16).
>
>  Documentation/CodingGuidelines | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuideli=
nes
> index 578587a471..b3443dd773 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -446,12 +446,30 @@ For C programs:
>     detail.
>
>   - The first #include in C files, except in platform specific compat/
> -   implementations and sha1dc/, must be either "git-compat-util.h" or
> -   one of the approved headers that includes it first for you.  (The
> -   approved headers currently include "builtin.h",
> -   "t/helper/test-tool.h", "xdiff/xinclude.h", or
> -   "reftable/system.h".)  You do not have to include more than one of
> -   these.
> +   implementations and sha1dc/, must be "git-compat-util.h".  In
> +   addition:

This "In addition" ties to the "are allowed to" 19 lines below, which
was confusing for me until I intentionally ignored the "In addition",
continued reading, and finally caught the other piece of it. Perhaps
either `Exceptions:`, or something like `The following cases are
allowed to assume that their header file includes "git-compat-util.h",
and they do not have to include "git-compat-util.h" themselves:` -- I
have a slight preference for the latter form, but I worry that the
"These headers must be the first header file to be "#include"d in
them" bit will be missed. So maybe if we went with the latter version,
we change each bullet point to include that qualification. Example: -
the implementation of the built-in commands in the "builtin/"
directory that include "builtin.h" as the first header". I don't know
if we need the reasoning why you'd #include these files in the bullets
below, which is why I didn't include it here. I'm assuming there's a
concern about implying that builtin/foo.c should include builtin.h
instead of git-compat-util.h (even if foo.c doesn't use cmd_foo()?).

> +
> +   - the implementation of the built-in commands in the "builtin/"
> +     directory that include "builtin.h" for the cmd_foo() prototype
> +     definition
> +
> +   - the test helper programs in the "t/helper/" directory that include
> +     "t/helper/test-tool.h" for the cmd__foo() prototype definition
> +
> +   - the xdiff implementation in the "xdiff/" directory that includes
> +     "xdiff/xinclude.h" for the xdiff machinery internals
> +
> +   - the unit test programs in "t/unit-tests/" directory that include
> +     "test-lib.h" that gives them the unit-tests framework
> +
> +   - the source files that implement reftable in the "reftable/"
> +     directory that include "reftable/system.h" for the reftable
> +     internals
> +
> +   are allowed to assume that their header file includes
> +   "git-compat-util.h", and they do not have to include
> +   "git-compat-util.h" themselves.  These headers must be the first
> +   header file to be "#include"d in them, though.
>
>   - A C file must directly include the header files that declare the
>     functions and the types it uses, except for the functions and types
