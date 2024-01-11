Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04A59B78
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="SQ8A7CRs"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso5091922276.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 15:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705017194; x=1705621994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiPQK21s7VaPGACRLVNKdQ2CEws1ZyBo2AyqReZ6Owk=;
        b=SQ8A7CRstYuS4YfZo3cDd3wY0G2X7c2NPp+DcDG+cB58b4dJ6gc+RNRQ2LMn/YuRE4
         /3DNDU0+IyvrpYJvirx37Wt6UnVj9LbVEs7o8c9ibbIQtTsgIgecUDRhcJAqx8JNkBqb
         hdpvV67gHDe+uTYSUGhefzghL0Cv3IEoffRdXQmEXw9hpybY5ii0QKe2dvTHyBmkp2fI
         3cw1P682kx65SHK+GsP8hv7kj4XY4+KAq9HeKZjHLxMX0yMRoYhvD/3Si1LdsRs5Q8dO
         fyiyev14adIVk2XEUyt8ISQl97Q2+AmgmjFw6cBTpAcm0UgIbnv17OePWtoX0Mie5pAa
         eyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705017194; x=1705621994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiPQK21s7VaPGACRLVNKdQ2CEws1ZyBo2AyqReZ6Owk=;
        b=kIKaIs9wJElBiMu5br9E00a8F3sgUJPqiKxq1iXs6uTjyC8JHmN2ejEVXy1wdf72+w
         222+6bto/gfN80QZD1JbpheJzzTp800FtosiGp4O06ddYnpvQxhQPC7qLAWSpeHSE3iB
         WZlnIoxcCLJ6WsJNIMxnmqnZ438eCdM7O90voWA7KLZv+N+sc54ZJVjl+eJBro/u4LDR
         jWrcnAxxrazbzhjoZCuSwoWB+KAvu+dgWfFYDzivr/hylZ06z3duTEIyM/yD3EFyDkhP
         23jwzcTOeoZznxdHdvy9TgrUGkli50wEpV+wS4h9sYwACaIUokMbmpdosBNK/pTnMDVK
         K6nA==
X-Gm-Message-State: AOJu0YzfgXeXZ+WluQv6IebK4/DBYCkPwTT8/a8atS5vteELfkGopK+P
	7OevY7TMkxquNsl2iw4r/1NF15RDyBR0eMmGsVUG/95Cu1g/kA==
X-Google-Smtp-Source: AGHT+IHetCpHK0WRzAiFZXVFdvY9CpCYoKivd8pBjRgIiFfm9zcLO6kVUwwn7odLeLpiSJH4dGrH5NJuyBZJ2YL0JjM=
X-Received: by 2002:a05:6902:1888:b0:dbd:9dc3:ea0 with SMTP id
 cj8-20020a056902188800b00dbd9dc30ea0mr32546ybb.79.1705017194270; Thu, 11 Jan
 2024 15:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local>
In-Reply-To: <ZZ77NQkSuiRxRDwt@nand.local>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 11 Jan 2024 18:53:01 -0500
Message-ID: <CALNs47s3tUQoOD4ejdoTn6y12ywjL0j5hWU-fUnBLe_o3vV5SQ@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:19=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Over the holiday break at the end of last year I spent some time
> thinking on what it would take to introduce Rust into the Git project.
>
> There is significant work underway to introduce Rust into the Linux
> kernel (see [1], [2]). Among their stated goals, I think there are a few
> which could be potentially relevant to the Git project:
>
>   - Lower risk of memory safety bugs, data races, memory leaks, etc.
>     thanks to the language's safety guarantees.
>
>   - Easier to gain confidence when refactoring or introducing new code
>     in Rust (assuming little to no use of the language's `unsafe`
>     feature).
>
>   - Contributing to Git becomes easier and accessible to a broader group
>     of programmers by relying on a more modern language.
>
> Given the allure of these benefits, I think it's at least worth
> considering and discussing how Rust might make its way into Junio's
> tree.
>
> I imagine that the transition state would involve some parts of the
> project being built in C and calling into Rust code via FFI (and perhaps
> vice-versa, with Rust code calling back into the existing C codebase).
> Luckily for us, Rust's FFI provides a zero-cost abstraction [3], meaning
> there is no performance impact when calling code from one language in
> the other.
>
> Some open questions from me, at least to get the discussion going are:
>
>   1. Platform support. The Rust compiler (rustc) does not enjoy the same
>      widespread availability that C compilers do. For instance, I
>      suspect that NonStop, AIX, Solaris, among others may not be
>      supported.
>
>      One possible alternative is to have those platforms use a Rust
>      front-end for a compiler that they do support. The gccrs [4]
>      project would allow us to compile Rust anywhere where GCC is
>      available. The rustc_codegen_gcc [5] project uses GCC's libgccjit
>      API to target GCC from rustc itself.
>
>   2. Migration. What parts of Git are easiest to convert to Rust? My
>      hunch is that the answer is any stand-alone libraries, like
>      strbuf.h. I'm not sure how we should identify these, though, and in
>      what order we would want to move them over.
>
>   3. Interaction with the lib-ification effort. There is lots of work
>      going on in an effort to lib-ify much of the Git codebase done by
>      Google. I'm not sure how this would interact with that effort, but
>      we should make sure that one isn't a blocker for the other.
>
> I'm curious to hear what others think about this. I think that this
> would be an exciting and worthwhile direction for the project. Let's
> see!
>
> Thanks,
> Taylor
>
> [1]: https://rust-for-linux.com/
> [2]: https://lore.kernel.org/rust-for-linux/20210414184604.23473-1-ojeda@=
kernel.org/
> [3]: https://blog.rust-lang.org/2015/04/24/Rust-Once-Run-Everywhere.html#=
c-talking-to-rust
> [4]: https://github.com/Rust-GCC/gccrs
> [5]: https://github.com/rust-lang/rustc_codegen_gcc
>

Two good reference codebases out there:

Abstractions over libgit2
    Repo: https://github.com/rust-lang/git2-rs
    Docs: https://docs.rs/git2/latest/git2/

gix, a WIP reimplementation of git. This is far from complete but does
a lot of threading / async to apparently get quite fast.
    Repo: https://github.com/Byron/gitoxide
    Docs: https://docs.rs/gix/latest/gix/

If the git project does decide to go forward with this, there is
probably a lot of completed work that can be pulled from either of
those sources.
