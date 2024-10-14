Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0781C8FB3
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941016; cv=none; b=Nr8Z/QYoGUqExcL/TsRppn/C875U1khZQYuvvuCnRKxkpWHBoP/Ta2qoIrx/JiSx7YP/JUfebUmfy+OOWuCktecrs8yxcxhyl9cyXSmK2srOLY4M9rIMo8nsarnEb5vWFQxWZW6rn1aKCh5gE947JIpdOvq0uk0HEb5NLJizPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941016; c=relaxed/simple;
	bh=h+pvl9W9uqnTfcnOQ1UGbrHEi+8J2/kKssa20+O3cJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKa1Svt2fjmo42Qn6AfSYcZCjthPYkdcg/1oMjli/lPFVdazYNjAiL2FQekklSEf1ouK/7+TWI7TOQrB/vuf01k3k1e6TVYcrOjt/if0Snds1Zjh7WeF8LS24idMkVshwuanxJN39qRAt/A+qe1wo2aDpG2IvJfmSc8fXrpWvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fuCK+UCe; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuCK+UCe"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso1257736a12.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728941013; x=1729545813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0xGLkKDDGmNlnbzKYE2Dt6R+ob1IhIyFPg1S26GhQQ=;
        b=fuCK+UCeeCryMiaTVaKrPKmxkTy/OTpgpXpdhpf5kFvRmemzA2nDzKms8bhtUwUPY1
         hxRNIlLDltvQOCkvdtpP9RnWINl1IvD8mng8JF3618fduMsK/v5dj3JsVinknR71R0Ag
         /L7Fg90+O9yAsdCrOZnaUpmJsmNtbooknwV9wA7RDt9AdS11U1ABjtHQ9jKLL0zzIz/U
         VIKWpOkfXVRdwJ3sjpnk9gS1YeQFK7FS94Tpm9zq0Z0qdOiL97yQqOUeMM2FqWBGo6q4
         vPvcTS5HhqsPOouFvfozWyZ6OwX3qJN3Ebuhf68/Elt9vVqoH9rMzTn/QlXpY4zDrvCu
         xNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941013; x=1729545813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0xGLkKDDGmNlnbzKYE2Dt6R+ob1IhIyFPg1S26GhQQ=;
        b=avcWQYxMAVMoaedIsD3xhKZYy7o/uVzuKyMz1b5Ik388EwczfFwXr5bgOnxVC95hpo
         T+gUc+ANaDrNSVrfLWaqP14hWpV1SSNxZ4W84uGuGqfvOZJW2VvWtGntVsFXtEhfg1gd
         IT6dCv07d1dF6j8Ca6v7vzOAJNkr6VeExCmXSsttT16US/Ppx+DxICNT5TJuYoShmyF1
         NUss0AzumiYyj6u0ElQNZBuwEs/hl71CXU0AMuX4njCL5fIyAxxO9S2yvcBGm9CtwGYG
         gcZZ564PYsfzK/4Yo33mpiaVvpkLm9+lO1Za3icxX5gxJAebjA0IRZcXHhiKZ0R2PWlm
         zm4A==
X-Gm-Message-State: AOJu0YzgwJc0CA5+Xi46vrsMMDCkTiRVebGZKjZU4IFCEQ26Ic04ryXy
	Ql8ExCORkO1zePvBYqF/VRxS8LJQlR26UCKm2tdB6g+imGZ81zqVNwCuNfRCNVzsnCXT7NHty+1
	q+pHzSJRUiYF7ju8+W1deGqXFse20ukObk15d
X-Google-Smtp-Source: AGHT+IGxAKOTsURkLKm3ZSoHVSpw60/2NyLf+2Zmfl3cYrWKXPftiqesSmzjGzk4ZjMW8vsnNKcPSiVbOOH0y7tD8AA=
X-Received: by 2002:a17:907:2ce6:b0:a99:ff70:3abd with SMTP id
 a640c23a62f3a-a99ff703c38mr484845266b.31.1728941012995; Mon, 14 Oct 2024
 14:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728697428.git.karthik.188@gmail.com> <36a53299c1ab1b55a09b7e1d499832e6715ebaba.1728697428.git.karthik.188@gmail.com>
In-Reply-To: <36a53299c1ab1b55a09b7e1d499832e6715ebaba.1728697428.git.karthik.188@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 14 Oct 2024 14:23:21 -0700
Message-ID: <CAO_smVg8aVjUFixKOicCJqQgAGhrbVPa9Q9Z8+OKKM+Thsx2oQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clang-format: don't align expressions after linebreaks
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> We enforce alignment of expressions after linebreaks. Which means for
> code such as
>
>     return a || b;
>
> it will expect:
>
>    return a ||
>           b;
>
> we instead want 'b' to be indent with tabs, which is already done by the
> 'ContinuationIndentWidth' variable.

Why do we want `b` to be indented by 8 columns instead of aligned? I
think this is harder to read:

int some_int_variable =3D aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa +
        bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb;

Of course, this is even better, if it fits in 80 cols:

int some_int_variable =3D
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa + bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb;

> So let's explicitly set
> 'AlignOperands' to false.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .clang-format | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/.clang-format b/.clang-format
> index 9547fe1b77..b48e7813e4 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -42,10 +42,9 @@ AlignConsecutiveMacros: true
>  #   int cccccccc;
>  AlignEscapedNewlines: Left
>
> -# Align operands of binary and ternary expressions
> -# int aaa =3D bbbbbbbbbbb +
> -#           cccccc;
> -AlignOperands: true
> +# Don't enforce alignment after linebreaks and instead
> +# rely on the ContinuationIndentWidth value.
> +AlignOperands: false
>
>  # Don't align trailing comments
>  # int a; // Comment a
> --
> 2.47.0
>
