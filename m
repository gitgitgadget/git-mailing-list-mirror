Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E9224F6
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586453; cv=none; b=WsGIo4qLqPejF+gqHaoATXqnSGHZZ9VA5v7pNCmTIVA2EHXl33VE3DZINHH8NHt/r+lWQstHt17bXqWduY3165X+6Ak5f0CzLS/jYP2Rt4Q5jj0lZ01jtWylsqRi9I1UDzpJEx/CCaVEReSSOCfvU3qzgoVSdcj6KpTyySSWTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586453; c=relaxed/simple;
	bh=UsZOts6xUR53aDiMhVMid7Yk1RsSiszZfifzCFpArko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fucwAk3Nz4/TCaNvhz+b5j1oS8Nmr+87trT+Wg+0bZMONfVKUvTL21ltE8N+moj9HcsRjez/t8aBAUDdh4OvBeGQvB9BmH3mUeKRw7vZMUGviEF5qmjcoorF5QUugrHt61DBFI5mPkQW0hyh4Wxdd+Wv0S/KtN5KG0d38sA4Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxtiWtmZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxtiWtmZ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-33ca74c62acso47177091fa.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758586450; x=1759191250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juuRmdtIG9kdI0LivxQcUqY9cxV8WrFXJti3TAOvJyY=;
        b=BxtiWtmZtnxoMGB22zY0qgFanmd4HfVTxXPrfNlWvaaGzs1qGRCQ1VuEpkxDS+XdVT
         X2fnfM8dZnGU7FwTD14Cmd+JZ0pf8H3U1zUXZLmZjIjjHa0OFFkHsOw1tfXbQeobRhfs
         VEssTlV0XqxCJq63JfXLpEeQVf2jeRLurMBhliaD4ZnG7KropWuXfOB01L11f23J8unP
         Uv95rmv6Z/PU3L32HA2o6OKKpzaUe9s+igBztFclBS8AfWvwaNC3ZF+A9OyDSEsJ77+i
         rHwXOj8nQEf8LNRa5sZJ40/nWsFd9RONdno+kAejQ+MdaUpkFRIbDhheurZua2eU6c2o
         jlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758586450; x=1759191250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juuRmdtIG9kdI0LivxQcUqY9cxV8WrFXJti3TAOvJyY=;
        b=BV3iIIQ4XJMfa0C7imXvA4MvYzjtx8xTA1qLONNFpxwBxY4/UJJmH1bpX1UQ+wXFoN
         Rheo0tC4ueQDWd0YboVbGr+4+VImUfpu0pUDu+dAwjHTlcuuQXZA0up9wdMKNdUICv7k
         23uF6qK9K6fke974pr7BpYP4KJCN3pptB1F7HlZk+0r4nYjal4ziCh9yj/6tF5qD0Y8E
         lzZz7fWH0+OXTjLqabVfg8XWnV23KeGg9QwPQeLlVIMZ8g8MoRBVioNDMnO8/LjmZRVm
         5leOfoil6eGuEETIUms3WCkCP/tK/ZyskZRvz1T4EpolQPJW/tZyKI7n0mZKGKpu+7IE
         sKcA==
X-Forwarded-Encrypted: i=1; AJvYcCXouc+Y8clc5c4OR8PJsmZkH/t6Az2AWFBPcXp/puGYI0djZBdzZOsck7zLDkTCD/yhTsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DGHPyTa8XFLbIQ7hOqAnwsDlX80bIPgvxzAXTzUimFxf/Lkd
	mWVtsR+iS6MrdA7tZWR1KeN6jklkCd+UswgEzyZbsL4+nQSnWfRZFu/7LA1YtapUmIGBm4FqEjJ
	OYfqAM858iz8gsvORExvTUdwsOWNoouCbdFWi6zA=
X-Gm-Gg: ASbGncuI5AQLMtGZ9ILi/MuvI7LRAqPirAtD9lvl8cBe2izTLc/7KECQuy95ggnMT/W
	MZzhgLRScxlVMDVS+ZAZJtpnih9SdCf2Ekr5vN71O+UvNU+DtlBYC7Fl1Yh6wdS7Y2oEfq1v5Pl
	IGxi7hL/x/AHKVY996qD3ovvdsKRj7awZYnrsoDsgh6A8MsM0xpM5Y4ilMJG6h/Z8czzSqFOww5
	xt4vLmk
X-Google-Smtp-Source: AGHT+IFP1CidAmUwxuk1/CSID9uyNbi9xo6aILX41fBCz/TiN8pez7m9hMVtDwrWmls2SM64ddwhKjK81uVnstqytok=
X-Received: by 2002:a2e:bc23:0:b0:367:8b63:3364 with SMTP id
 38308e7fff4ca-36d17fd0673mr1555801fa.36.1758586449734; Mon, 22 Sep 2025
 17:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com> <xmqq1pnyru1f.fsf@gitster.g>
In-Reply-To: <xmqq1pnyru1f.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 18:13:58 -0600
X-Gm-Features: AS18NWAG-9nfQDkES3fem_nAy1PFccXrHHUu84_8xu8PMwOkt5agldzZnlIAZ9w
Message-ID: <CAH=ZcbC5Y04D4bGjfH3rZ8GKabDttFez5qb9i8mXVsfE3LF26w@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v3.
> >
> >  * Address review feedback.
> >  * Split the deletion of xdl_get_rec() into 2 commits.
>
>
> >  * Move NO, YES, MAYBE into xprepare.c, and use bool literals.
>
> The elements of this array is of type "char"; it makes me feel a bit
> awkward that the code
>
>  * assigns bool "true" or "false" to "char"
>
>  * expects that reading it in another compilation unit yields 0 or 1
>
> Instead of abusing boolean true/false, I'd rather see the code that
> assigns 0 or 1 to use 0 or 1 as literals.  As the array got a much
> better name .changed[], anybody would understand that
>
>     env->xdf.changed[line] =3D 0;
>     env->xdf.changed[line] =3D 1;
>
> mean what they mean.
>
> >  * refactor 'char rchg' to 'bool changed'
>
> Hmph, I am not sure if it is a good idea to pretend that this
> changed[] array that is more than bool to be a mere bool.  An object
> declared as type _Bool is guaranteed to be only large enough to
> store the values 0 and 1.  Granted that you cannot allocate less
> than a single bite or make an array of bits in modern architectures,
> an array of _Bool would likely be byte addressed and if you assign 2
> and read it back, you may get 2 back in practice, but I'd rather not
> to see such a strange code to live in this codebase.
>
> How about
>
>  - rename rchg[] to changed[], which is a very good move;
>
>  - optionally make it unsigned char, not char;
>
>  - the user of changed[] that uses only 0 or 1 and is not even aware
>    of that MAYBE thing use 0 or 1;
>
>  - the user of changed[] that has to be aware of that MAYBE state
>    use its own NO/YES/MAYBE for readability.
>
> Hmm?

'changed' is NEVER EVER!!! assigned anything other than 0 or 1 which
strictly makes it a bool. It's easy to mistake that because the
functions in xprepare.c that deal with NO, YES, and MAYBE are within a
few lines of 'changed'. Please re-read xdl_cleanup_records() and
xdl_clean_mmatch() very carefully. I will update my commit message to
make this more clear.
