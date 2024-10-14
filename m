Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716A4683
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940377; cv=none; b=EoiwSNw9KKJhXRk+Of8egHprz6+gHAmAyZVamG0S3ANZ9KbAFThqfHsqoaNN+lt5dHm+Fm73W1YitJwsLOT0dt/eXwplRw1oDgYmOJzxxfrUscQTUs856Usdp+CPGSKVIaZqVxtfPp7dks9D6IqJTaIpXhPwKiahJqgTS5AQmBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940377; c=relaxed/simple;
	bh=pbIKl5Vzo+6r5WIorcPlA8ZcRnfZ1iIKfuaDnx5wWuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8H2Gkuz+JQQNAtafY9ikEhJ+PnNZdm7D7hhIAREhGzHTs5JJHmden2fBHr6B1aY2sbX4J7au+wNHie63oSEA1YaWF45m6KcZ5qRRmLtvpFimB2nhI5cLTy2F2udZsaaDcbly5VJu/v+tzcgCabjwMo+bAWtlFZcxUudo5Py1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdvXcVyD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdvXcVyD"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso64523266b.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728940374; x=1729545174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq9ofcpHqvcFeygRYC0OmrJ1un3eOq//tKp53UXxbIo=;
        b=UdvXcVyDoifwh6GIEeICrrmOETBYs7tb9sYas3OH+5zEmtoTgJy5uSydrwIrMQ7RJl
         RbVY/bn6mRIsWy3f4DQihUsEcCtcdI7zzRQsVLKZr5eA/02eZo8XBsj6nO1hIyoYCJNY
         VwJischlkiu9lc5IkTNng333AAps8WXEFN0P1XyDBEaT+jI9N+P6BGXRhvAUm2yHne3W
         3MgfN1unkq8nO+97bA8/AsJC5lkTjlLcZGu5ktV4E2nCnWjkDte8YrcApkvp2bAVPR99
         gCOs3w8umrus51A95S3Ai/jP4AoXr4eMbsBqs8fwj2nfj8ykruZBh7i30G/LH2yzm2DS
         STWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940374; x=1729545174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq9ofcpHqvcFeygRYC0OmrJ1un3eOq//tKp53UXxbIo=;
        b=eIVawoEulwRCNQCF8h6mpjDaaqwX3B4KGJmFSHbNuqPoagcCQy4dUTvZvFwR83KJQF
         WEQZhpO6U4biDxHMvAsb8tOvJY1G8ZNbd2YVDCnPlXqSB/PyFxw5bZ1abP6Y5ailGBRe
         bjLejkO8VWjRkp2f5OeNyoQF1z0qFQS3QLKu+NtHLzSrUzJ6x8TD5xzAysKQ72MivDgC
         w56fLPf+P2JVl7vm/INTv4m6FpgRgO7sNu6vf+2PhHSrgZJrJY6zi3MTdfkROYTcWQX3
         ave4ARd40UP6RV4idt1mYGRq5HowIrMxk+wassc4GRodAitFN5eJ7Uso6WGnWVqOaeeM
         QRew==
X-Gm-Message-State: AOJu0YzDxkn0OEsSLxn6OMwIKl4sVhCRrYsiYD8nLhF5ysPBI6YQhpjw
	j2ZwkQjQQYjOkLlBfZicZCZ+RksYshIrTqCgHq8nPB9WYjPw89OuQzXvfE1G1Jg5U+fcV/LrNGI
	9D21WtHhhtMbDwHYZLtBuyy/JdK5tg4k2gMTgCFayRhRpQEeIRet5
X-Google-Smtp-Source: AGHT+IFsdE8hlMabkEXT/18avlID2Qb7yx7KH7HluXqOtNEc4LqNu67p5urJ+XoDapxwVuNFLZPgKKbz3kXYpkkNE+g=
X-Received: by 2002:a17:907:9810:b0:a9a:ad8:fc56 with SMTP id
 a640c23a62f3a-a9a0ad93126mr497774766b.44.1728940374199; Mon, 14 Oct 2024
 14:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728697428.git.karthik.188@gmail.com> <1586d5376915a4662c92b8c0881596952c4500bb.1728697428.git.karthik.188@gmail.com>
In-Reply-To: <1586d5376915a4662c92b8c0881596952c4500bb.1728697428.git.karthik.188@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 14 Oct 2024 14:12:42 -0700
Message-ID: <CAO_smVhS8zw_Hk1OrsTg==4spziQOiQtOt+Hg8x-rEQVR+66rw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clang-format: align consecutive macro definitions
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> We generally align consecutive macro definitions for better readability:
>
>   #define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
>   #define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
>   #define OUTPUT_RAW_TIMESTAMP        (1U<<2)
>   #define OUTPUT_PORCELAIN            (1U<<3)

I like this change, thanks. Is there a way of apply clang-format for
*only* one rule/aspect? i.e. can we apply *only* this, and preserve
every other line? At first glance, I don't see a way of doing it. If
there was, I might recommend a whole series just to applying these
changes, but with how out of compliance much of the codebase is today,
that's not going to be feasible; we'd need to format it in a way that
we might not want (the current style), and then fix it, and that seems
counterproductive.

>
> over
>
>   #define OUTPUT_ANNOTATE_COMPAT (1U<<0)
>   #define OUTPUT_LONG_OBJECT_NAME (1U<<1)
>   #define OUTPUT_RAW_TIMESTAMP (1U<<2)
>   #define OUTPUT_PORCELAIN (1U<<3)
>
> So let's add the rule in clang-format to follow this.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .clang-format | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.clang-format b/.clang-format
> index 66a2360ae5..9547fe1b77 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -32,6 +32,9 @@ AlignConsecutiveAssignments: false
>  # double b =3D 3.14;
>  AlignConsecutiveDeclarations: false
>
> +# Align consecutive macro definitions.
> +AlignConsecutiveMacros: true
> +
>  # Align escaped newlines as far left as possible
>  # #define A   \
>  #   int aaaa; \
> --
> 2.47.0
>
