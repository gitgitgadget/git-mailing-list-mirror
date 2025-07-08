Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1139461
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011147; cv=none; b=M8Bi+LVxZswWIl6cgypT3Ff+/5Rg/eu/C0ij3IJSzPRymgULLoxynsA0klT1TDIeJ8LUhfhMHupfTYwhN/YQRoBp0ek85u0QFNCOPaZxgro02Hz/ikbr5ZX1iruDHSVmXIikrPn+fUVkjI21NEgmOJKcsEaRZVQYHsHJ5/RYQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011147; c=relaxed/simple;
	bh=iGCMhCcy092csh616TLUwUs8+GimUJLFAzEBgCMqvy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndZHJdSUOFw9IKWmbMPSy30F4oeCqGizBNp31t7m2BfAdTLBpUx4Uc6E8cD2SzqxTBbSP9NEbIZo0Rjv6BC9taOCcPBn3C2LRadRVWfo/fg2arTZGEBjgsA0Ammb43gypFlLUsCRWn6QYKZBpQ32ew6taSRIcppgBmF07+D7Gx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3UTQkBn; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3UTQkBn"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86cdb330b48so449974139f.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752011145; x=1752615945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbegOQXv+8UcIwA6teh4YmL/vpuuDfjZq/6r/z8bgdI=;
        b=J3UTQkBn9ZgGtNf1bK/5VBZsn+ou8EQaLVo86cXwWMAJM923J2nye+Zayzr1xlwmm1
         Xh+8qwASM9gNLjTjSiIk7Pv77LECrbdJiZQSr3pduh7QCIxpCa5BrjrzN/xg6Xsou/Fb
         jGsINrjci5Clnqd0tN/6V2AIjmMfpwMGKKH4GszSTqunz2XlI8tFqvRDJApQ9k37hBzg
         gB16he3HA9ff9nNh9Qg9gNqgyb6Y5dKVHCZiO6JvhB2+FeTV2VRca5Plq3z6DS37xNyQ
         PHwWvpX/6VZOGbo1FznxyEsZ5AY0TeQ5C9bTfZFdeVZKHuyUxIfbUiWszXeFuFJHaduQ
         dzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752011145; x=1752615945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbegOQXv+8UcIwA6teh4YmL/vpuuDfjZq/6r/z8bgdI=;
        b=IbEnLu9xaaZIXTIxHThi1IiozH/NfvczzSlpIAF2bEvVz/0aIeb+sWGZ+A1ZnRU9me
         +bCIfgBwHsWIEW225IGfAQgqfZztwatuUnfrl8Fl0shFEfdNNHKDKaztIruwmzeX3mhQ
         pLE/K1nzLzxVehMjULO0yzJQamXlFnWbPMezdwX7K2HUePeStwPf6bFpyVHtL1KD6vuX
         eKP8dqZSLSHNNt4oCLsPQUW8eK7f0yzYlcp3HMdzFJ+OrPqtpcFRsI81ulr4GQKCkJNR
         ZCW7NJ6pAvo6M0BXGgGcSmWSyBaAHdXK8PnPa3RTzY4UglanoPPQFteKlEVXwTKf6n8G
         ez8Q==
X-Gm-Message-State: AOJu0YwAsf9zx4cBUfM7J8+l01SA4IH2fatFkb8pFPWQKjsF0DYhWwPA
	f0ULzRlbtEWhbSX05NNNjnQF6DVtPrqABsabqxezBkG44t/N8VMRKzzcA5Roc3Lhp3Hq6ETAmnW
	U7yxGj6MjOIlrFyg3oykVmujgXU1ZznA=
X-Gm-Gg: ASbGncsrqIptsY0wJIrt1kLmNHraGz5L7Sv6aJB0xkTDVyNuU5b/8uyn2I6jtNfn8K5
	MKTGS3zQRVRpjK7i4gpoyItQjMq+9D+cCeGjk8pxWJ5sL7uUC73CwXk7NK4Fd8nMjwHeq+cghBo
	/qIsWgBxCq+g9lRCfWgFmk1sNBNJyc30r3DDtGhiZH6ePtv1QLNUiyMLktxA==
X-Google-Smtp-Source: AGHT+IFV7sGqO8QSurnvcqqWmP9kWPPnlOAA14Y0/s29tBBOzasRUBtOV0ESZrbXXMuk0AodFRGd8oWlk/i+NFjcYT0=
X-Received: by 2002:a05:6602:4a0e:b0:876:c8e9:8b11 with SMTP id
 ca18e2360f4ac-8795b0eff7fmr35704439f.8.1752011145086; Tue, 08 Jul 2025
 14:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com> <80d7a7641daa7a6f0e1db73e0a433701e9f37209.1751973594.git.gitgitgadget@gmail.com>
In-Reply-To: <80d7a7641daa7a6f0e1db73e0a433701e9f37209.1751973594.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 8 Jul 2025 14:45:33 -0700
X-Gm-Features: Ac12FXwbzyufQvjnzZU4OuTJixJGTxd1glxP6OiOPF7dAkZLPs2LGPDFmVyu97s
Message-ID: <CABPp-BHTZgJTpxFSszEUvfrk1AP=OnTC8mKJ5ddZfH2mZu3WaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sparse-index: point users to new 'clean' action
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:20=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> In my experience, the most-common reason that the sparse index must
> expand to a full one is because there is some leftover file in a tracked
> directory that is now outside of the sparse-checkout. The new 'git
> sparse-checkout clean' command will find and delete these directories,
> so point users to it when they hit the sparse index expansion advice.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  sparse-index.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 5634abafaa07..5d14795063b5 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -32,7 +32,8 @@ int give_advice_on_expansion =3D 1;
>         "Your working directory likely has contents that are outside of\n=
"     \
>         "your sparse-checkout patterns. Use 'git sparse-checkout list' to=
\n"   \
>         "see your sparse-checkout definition and compare it to your worki=
ng\n" \
> -       "directory contents. Running 'git clean' may assist in this clean=
up."
> +       "directory contents. Running 'git sparse-checkout clean' may assi=
st\n" \
> +       "in this cleanup."
>
>  struct modify_index_context {
>         struct index_state *write;
> --
> gitgitgadget

Makes sense, once we work out any wrinkles with `git sparse-checkout clean`=
.
