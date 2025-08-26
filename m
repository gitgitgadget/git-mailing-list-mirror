Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFE27AC41
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252102; cv=none; b=QYGHgrOYT469btWmzDy77F1g6QaKmSz/pDsc/3AkFbJvQ+GViWcXtGhKSH8aMHnZzVQV5964JwPIaobtvEF6ioRxh7TNW+bnemp0Bqacl0kgtHMud3+QXWaqwDZnJXROZTup5o+STCB0B+WhsVN+aBgcuzjYISy/uiBQOKdutDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252102; c=relaxed/simple;
	bh=rc2UNDfkMnQeWlodstx0FhfAmC7quE7/yQnaSHStJPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE+qdnXXpHN1yNElQdZMZSVdlUVG1UOCNL0qVDtTvtilFggFiMtzj6RC5OogT8gqJ7Ez/P/kzJyzv3zUwFKnGURZJ16qhRevJZtRjNW1FfPD7F/LjGSaBQSr2UWRLmj1kb5B/v3m91a+nLC3AEBryeqG3i0trYETDuACiMiiGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfGLNAqU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfGLNAqU"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e87050b077so911647585a.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756252100; x=1756856900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61YtBQLnP+QvwN9rDJywK+lUAyenEyRll3caJ5blaBQ=;
        b=MfGLNAqUnDhPdUPwCb3RWAwsZAqYWeNZx7b/9x5T3vrCCKLbgyAhFz03POLkIoWveb
         44QKdIFohw0SLGS//Dw3/HQbNOtGQepOEx6ull+lgq9EoWacCV+owqx7wbbk/iri9UCb
         7tTXWCJraP5iTyqcj8sWkjpKcGxkQ4v56xsdqL8IqUE64CVMFDXMhUYLe0jNJTN9pt1j
         zjxDV/6v6mWyvqYCCb7pT+yYgiPp00QxdsGJ8nhr9Nrb6nQwUK/811Ly1rmavZdvV9Eo
         lCsS++pmRfKGbGVl+5GoEfvSPrlwFegiqbfQTi4NOGCt/SDi5nUqj+p31/UIaRCjAd2G
         yAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756252100; x=1756856900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61YtBQLnP+QvwN9rDJywK+lUAyenEyRll3caJ5blaBQ=;
        b=ni7FXbMLT3I14XDlDbAPEfGkAgWnGxVdltcOMaIsu+Usqqj0H92UU19RB28HhTLZKs
         IyttPDVzo+1DBXYewYz39ciPnrCxXs3EY5XdfZ9qnHLOC4y0ZP5/nU/LKqmS9+d2Abnq
         I+5QQwskZbfbmTKWvsHmBDYrnjDZhkRzFH8FcMbjn5VlRISmLRTUgDEs4P/Iav3x2HCC
         GZQOZgglOXb4+MvaslYrA5XXka0Xi9+RDNy60TLXQyYF0g+d4gym4QnTslo6wX0vmlF2
         YQlCqYqNfB1AbL521zHVjXlN6Oe1qZ0M3kQO+4YrdgBQ2mbh+shvgVPIxs9/8HsKfLOr
         E5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdbd5VJtzRMYm2F6FjaVZioRfwgCth+1rnJ3wEQdFlxGBcF2GW1bAQxC+vE2IDb80lwHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/zA45cM9WCRj3aCd7VIeNrStsSe78rSoR226ItI0Cjpr1JNf
	8G4SUSefBNzNNn8pnLc8D9CQZuKSp1kkMLcA0+ptGGO+J5SzRmSdxDf+0RjfwyleOFx5IA293nF
	EIIl1yQlYFvdVdnBmwPBUtjr8El6vbepOfXjC1V3b
X-Gm-Gg: ASbGncv6qhbaWHGc6Vy2rZJf9LxlgKc2BEqbVFPpIHThccmd3iRKhU4TmFPytqlfgjS
	Pvh87gWeJRyO15jyElf4llZDIimRJ8s1qp24ewGiReq89QAFn32q3iNeeI95gIYNllOqwt6TnRj
	vnk5Dpd65hVg85LtqNIhavtg4H0URLnxiW5CXuZ7vl1B2P1aAYcdqKnJiLVjXxMl+Hkpn7SOs64
	a0g2mlcjo9HgikIjv6wmLQyxKA4PmrwyO8cWaExn6nR
X-Google-Smtp-Source: AGHT+IELqzW59f06n5VzByytze7GsYZy+Gwk+3LGR/wGqia3F5Rc3+OtGLTjmVVHGEjDvVFeDmWz/d2BF8QhMAkFZpw=
X-Received: by 2002:a05:620a:19a0:b0:7f3:4a0f:3595 with SMTP id
 af79cd13be357-7f34a0f3d17mr753777685a.36.1756252099485; Tue, 26 Aug 2025
 16:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7byqkp3p.fsf@gitster.g> <20250826233525.2635432-1-davvid@gmail.com>
In-Reply-To: <20250826233525.2635432-1-davvid@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Tue, 26 Aug 2025 16:48:07 -0700
X-Gm-Features: Ac12FXw9Of0skDIjJUQGA-bfMoYCHUaVVPd7aEMGGcBjz2DppbIgfL8FFBieJ_U
Message-ID: <CAO_smViX+EVyq5AzO3dwfcBGdenuZ1w89ksse=6MXYv8xi+q1g@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: build libgit-rs and libgit-sys serially
To: David Aguilar <davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:35=E2=80=AFPM David Aguilar <davvid@gmail.com> wr=
ote:
>
> "make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock warnings
> and can trigger ld errors during the build.
>
> The build errors are caused by two inner "make" invocations getting
> triggered concurrently: once inside of libgit-sys and another inside of
> libgit-rs.
>
> Make libgit-rs depend on libgit-sys so that "make" prevents them
> from running concurrently. Apply the same logic to the test invocations.
> Use cargo's "--manifest-path" option instead of "cd" in the recipes.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>
> Differences since v0:
>
> * The targets have been split apart into
> separate targets so that the libgit-rs targets can be made to
> depend on the libgit-sys targets.
>
> * cargo build/test --manifest-path is being used to simplify
> the build recipe by eliminating the "cd" step, which would
> have been duplicated in the split-out target.
>
> * t/Makefile has been updated to apply the same logic.
>
>  Makefile   | 11 +++++------
>  t/Makefile | 14 ++++----------
>  2 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 29a53520fd..539e6907b4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3983,13 +3983,12 @@ unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) =
t/helper/test-tool$X
>         $(MAKE) -C t/ unit-tests
>
>  .PHONY: libgit-sys libgit-rs
> -libgit-sys libgit-rs:
> -       $(QUIET)(\
> -               cd contrib/$@ && \
> -               cargo build \
> -       )
> +libgit-sys:
> +       $(QUIET)cargo build --manifest-path contrib/libgit-sys/Cargo.toml
> +libgit-rs: libgit-sys
> +       $(QUIET)cargo build --manifest-path contrib/libgit-rs/Cargo.toml
>  ifdef INCLUDE_LIBGIT_RS
> -all:: libgit-sys libgit-rs
> +all:: libgit-rs
>  endif
>
>  LIBGIT_PUB_OBJS +=3D contrib/libgit-sys/public_symbol_export.o
> diff --git a/t/Makefile b/t/Makefile
> index 791e0a0978..29dd226c7d 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -190,15 +190,9 @@ perf:
>
>  .PHONY: libgit-sys-test libgit-rs-test
>  libgit-sys-test:
> -       $(QUIET)(\
> -               cd ../contrib/libgit-sys && \
> -               cargo test \
> -       )
> -libgit-rs-test:
> -       $(QUIET)(\
> -               cd ../contrib/libgit-rs && \
> -               cargo test \
> -       )
> +       $(QUIET)cargo test --manifest-path ../contrib/libgit-sys/Cargo.to=
ml
> +libgit-rs-test: libgit-sys-test
> +       $(QUIET)cargo test --manifest-path ../contrib/libgit-rs/Cargo.tom=
l
>  ifdef INCLUDE_LIBGIT_RS
> -all:: libgit-sys-test libgit-rs-test
> +all:: libgit-rs-test
>  endif
> --
> 2.50.0.7.ge90cf88798

This version looks good to me, thanks!
