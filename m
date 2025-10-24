Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B491547C9
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271425; cv=none; b=iRgHuD1/E1xQwpT1O9j4RWoWs/ql8XMXVBJ+/ESufbbmG1zqLXyAe3Ew1p7Dk9j0rLMT0EfqvZSHkg5kmIGv29/rAgPMm/noJzS411UepxMyNxhtel50cQAQDTvKW4PknzL34P2FtUeTQcmZhCbmsnTad7TJURjmzVFfTgf/mCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271425; c=relaxed/simple;
	bh=s6n8ixa3BByMsrUq5C1BJVpClHreRwXo1IIW9sbre1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOmdQEEMMVQFwyK2yN72PuOUNv0DOnUFm55K3rzLjDg3lH4K9hNC+k5yrdKZgnL9HyxnXYA/MjhhA3wiAbJgxIf1NjGUDJSzRipaW1urYTyLLK6Tw5pXiMXINUGujEmzcZv01+Y9tMuX9yKQTM3oPFK+9V7fEG4XzaUFxcw2Qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2rA7R1t; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2rA7R1t"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-941073ba029so48098739f.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271423; x=1761876223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gp4ropNL1lOESrL+KOSnM8SiaA81VaGRKKbAmlSJeI=;
        b=c2rA7R1tROQnOUsrmyIcJ+PCVsJqRqA/NTsmfFekAb5svvQlgvfBQQvecjnr3GVw1Q
         xMErUKTT49aPJDdYK2i7DBcQbOqQ5WbBkTLGxv8xvSyQshxGLJcFscWrruV65k3FPBtq
         J8vd1C26i+HhbXttiOATK0IO2LrkQYLqcxLfz4/jWIsl+mKdFFzg7oSI1G07uxP4yYE4
         Vc7WpwycDUk1U0xRPumobkHXxkKOTetymSlhvSIyiqPt4JfiGy+wsM7XtPQ4LjhrM83o
         0R3STKCYedNd9ycMsCATSFoP0Wz5ECK2vNx5xiDhJ3TlEVJGpgwmHs5FNM4KGe/DMgck
         xupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271423; x=1761876223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gp4ropNL1lOESrL+KOSnM8SiaA81VaGRKKbAmlSJeI=;
        b=qJ4RFd0dUCiwqX3L2D6jxSzMcEVpBx3HMJ9NEna9O+qTqAlnXqe/kPrZklr/LoqHiM
         UevMK7058Xdqk6Pncx9CAPODwjAAaQeGq8pjBEGQ+aH7WQRyXZG53NnYmEZyqH+J6ddv
         eMxq9xYUek49ifSLP3rK++Ul5HsOIKo051w/1BkNTrqubGSUU55ymYyw18laBx7xjsCa
         fprlFuYLrnPJUB31IZLQ/LsXNk03DMuMI4RCWW9NFjAP2Pkp+INfs9ChXBVxPt4vHrWW
         dmJ/X9nTwPaXbTNaDcWqvQfzUCJB69jqx8eruHrbLM3R/sgMLIUhH72OzNkUOJK9KzsK
         /EcQ==
X-Gm-Message-State: AOJu0YzVgjindTNkNKTDqQgg2rFc4vKF7k7vZq42rqMDmNXQxWkY6rJg
	w3Ta49FTE9WN94xfTwnf1mmGedphfvplYamVRSmI3gDkMAHW9ZK6rlM1YfsJIytpQ2Vu8RANd0V
	R2UKJD9+gKaqFHHyx0iQ+3qBWxm5XqMc=
X-Gm-Gg: ASbGncsIThjRsh0rY8lGjeQ1le7TPKBGNsYHzcjFekXZz9ZE33JA+oeUOR3N0nQrWan
	cwSD49Ez+XQ0872QnD0cHIzgsrR0fnJ/Roi3NVwZS4rWQ72HWP7MPbcptuUIJokDrrsZWBYEu2G
	NNM3lxSz0cjPk2msu2LcIBTtdYtLfq8/EkBj4Qek0zGZytdDCVRUJMTE7YEvq0Y9G+mxXsto+fI
	iAMlL1aYNClu2dVYCG84+JOe151mc896pXhSeEOv+TDdI+zIsuBCE1mI9l6
X-Google-Smtp-Source: AGHT+IH/F/FO19mYQ/1sa/Z3HmcLR9UY5+Jf4fF/q8xsh0zc0OvqcAI9COh7DCGiOYVzexiCXOR/q5iWM4yuDy12cnM=
X-Received: by 2002:a05:6e02:156c:b0:430:af13:accc with SMTP id
 e9e14a558f8ab-430c5208df1mr354818035ab.7.1761271423281; Thu, 23 Oct 2025
 19:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com> <20251013084857.1646783-5-christian.couder@gmail.com>
In-Reply-To: <20251013084857.1646783-5-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Oct 2025 22:03:30 -0400
X-Gm-Features: AS18NWDSZCnvk5Nyz-L6YiAMAP4bg3lz40PdKcXA1TfEY2723YxMzj8TNssW3a8
Message-ID: <CABPp-BHMNQB8Dc-xq_JbL_73PQ+wUDwxWSKUQyjFGGYWUyiWvw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] fast-export: handle all kinds of tag signatures
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:49=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Currently the handle_tag() function in "builtin/fast-export.c" searches
> only for "\n-----BEGIN PGP SIGNATURE-----\n" in the tag message to find
> a tag signature.
>
> This doesn't handle all kinds of OpenPGP signatures as some can start
> with "-----BEGIN PGP MESSAGE-----" too, and this doesn't handle SSH and
> X.509 signatures either as they use "-----BEGIN SSH SIGNATURE-----" and
> "-----BEGIN SIGNED MESSAGE-----" respectively.
>
> To handle all these kinds of tag signatures supported by Git, let's use
> the parse_signed_buffer() function to properly find signatures in tag
> messages.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/fast-export.c  |  7 +++----
>  t/t9350-fast-export.sh | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index dc2486f9a8..7adbc55f0d 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -931,9 +931,8 @@ static void handle_tag(const char *name, struct tag *=
tag)
>
>         /* handle signed tags */
>         if (message) {
> -               const char *signature =3D strstr(message,
> -                                              "\n-----BEGIN PGP SIGNATUR=
E-----\n");
> -               if (signature)
> +               size_t sig_offset =3D parse_signed_buffer(message, messag=
e_size);
> +               if (sig_offset < message_size)

Always nice to remove a special hard-coded (and incomplete) additional
parsing with a call to the official function we have to handle this.

>                         switch (signed_tag_mode) {
>                         case SIGN_ABORT:
>                                 die("encountered signed tag %s; use "
> @@ -950,7 +949,7 @@ static void handle_tag(const char *name, struct tag *=
tag)
>                                         oid_to_hex(&tag->object.oid));
>                                 /* fallthru */
>                         case SIGN_STRIP:
> -                               message_size =3D signature + 1 - message;
> +                               message_size =3D sig_offset;
>                                 break;
>                         }
>         }
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 21ff26939c..3d153a4805 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -279,6 +279,42 @@ test_expect_success 'signed-tags=3Dwarn-strip' '
>         test -s err
>  '
>
> +test_expect_success GPGSM 'setup X.509 signed tag' '
> +       test_config gpg.format x509 &&
> +       test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +
> +       git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD=
) &&
> +       ANNOTATED_TAG_COUNT=3D$((ANNOTATED_TAG_COUNT + 1))
> +'
> +
> +test_expect_success GPGSM 'signed-tags=3Dverbatim with X.509' '
> +       git fast-export --signed-tags=3Dverbatim x509-signed > output &&
> +       test_grep "SIGNED MESSAGE" output
> +'
> +
> +test_expect_success GPGSM 'signed-tags=3Dstrip with X.509' '
> +       git fast-export --signed-tags=3Dstrip x509-signed > output &&
> +       test_grep ! "SIGNED MESSAGE" output
> +'
> +
> +test_expect_success GPGSSH 'setup SSH signed tag' '
> +       test_config gpg.format ssh &&
> +       test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
> +
> +       git tag -s -m "SSH signed tag" ssh-signed $(git rev-parse HEAD) &=
&
> +       ANNOTATED_TAG_COUNT=3D$((ANNOTATED_TAG_COUNT + 1))
> +'
> +
> +test_expect_success GPGSSH 'signed-tags=3Dverbatim with SSH' '
> +       git fast-export --signed-tags=3Dverbatim ssh-signed > output &&
> +       test_grep "SSH SIGNATURE" output
> +'
> +
> +test_expect_success GPGSSH 'signed-tags=3Dstrip with SSH' '
> +       git fast-export --signed-tags=3Dstrip ssh-signed > output &&
> +       test_grep ! "SSH SIGNATURE" output
> +'
> +
>  test_expect_success GPG 'set up signed commit' '
>
>         # Generate a commit with both "gpgsig" and "encoding" set, so
> --
> 2.51.0.438.g6987fc0bae

Looks good.
