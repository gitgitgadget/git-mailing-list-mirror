Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94044A730
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136299; cv=pass; b=k5i3+VJi2ev+sAo9C6Y4jrDEIYWOqaOzDBmbgJrKaUeYBYllsMsKGX7vhswgadr27Lt6WVrNbyTJ4y2PRMiqH8XpU6KsFlyOrCqIxujTadv1ujAYf1jEilG4+6RgLvYTz2FQ9Mw84HOOlIrM4aw7rURreG+hxqOYqStohr3p6a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136299; c=relaxed/simple;
	bh=eHF2fiMNhKABGBx8F9E0IazHQ3bmUOfdi+XyqFdjySU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEWaBQtVJWDJ9jX+u9gVBVFlnKFK21LuwBnDTKbvy6Nqvll7T0HQCFnpoxTYSTrMKD27zoDLmxUK4HAsUGwC77Q9AL5/SP8fIWfcxvibfxx3qH00AUpH/3xQa1PZvKniSl6zHOmKp4hMX1YgudQhg4hKeTbViqQxvEdt0fZPWLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FZ/yOsow; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FZ/yOsow"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8299f1ca86fso1852028b3a.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 02:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773136291; cv=none;
        d=google.com; s=arc-20240605;
        b=ihaxx6cH3LxL80zGoDEGTZX4TpR8RerAhm7TfszFXe7EVyqZqVK36cR95CxT11opT7
         0Vf+AmhuxUEjFpu4DaHUADkjMEQPnhpnw5OZHJ5TQ1QN43OlKN+4/VS4z418lIfaQsk2
         nGIWDW/XDb09+juK7eCt4b+wYCNh74Tp2a/rXMoGZe7ZRzjVdo8L9oO0Dog6F8lVAVKA
         CwuJQUIeKj/lLoIhzxQqFTlS8eXNNgB7ZHENTOzuzB6wEByXhakngHEwDBy03TFZmkZP
         U/lU3hHe9QPiMR1u6uk/JfiEUBuASL8zsRYydSheF6aIHSBwMA+J6JaDYgVO1d+Gavbi
         RpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSK/kqVzy9JKKjImlDgk1/XfqcEvGf7+IAd6nmfQ+xM=;
        fh=ZORMJqG0VLIhOvWrjxavcxyXj6U7NsTr4WKgNAzIB9s=;
        b=X//kNlk19S/Bdj+2YSLoEVsq5Y57vmL8qAA/cVVlFYkYL9ENfF4ssgwXXtV9KBG3Ww
         DMStrPTmqcBCn0pBOJkPBwuR/6kAIV3aGtAAmaW3GUeyGCb+Th+ArvR6fZGktOrTbhm0
         ZlBd3NGQWJzQaMYSiEAEL9kdVGpN+tEv1Sa8gWv2NJwbRbf3yuqMT47GmJLsFFBRczjx
         oZDKpyHv1FiZLv8HHkmABRZrXcGFxdHzSfFWHVQlySmMjFOdcvukLHyAG96Ea8Fxdgyq
         Kkm4Bg+1v/I4+gO2+BtlVmttkv/BEENQ+II2bqxr/dkH9kEts3DbkLDY8RDg6akiXXp2
         nWng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773136291; x=1773741091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSK/kqVzy9JKKjImlDgk1/XfqcEvGf7+IAd6nmfQ+xM=;
        b=FZ/yOsowIQ5fL+k5QTPURdCHADr84hGhCm8WzcXlwYb1r3YHvtU+qRVK/A563aCN1d
         JSjBdFAbtygJGI88eTbRy5b4sgc0Ku0HRDj++4Scfxm3goLvlU7F+A3XVXi8g2hZIsSK
         KoZkxg8emc0N5Qz4rRxfTEkvlEv3K4q/nOX2r14ndFGwU5IbP3iTn/I5Fo5VbVNCTC8O
         A/0jqWuZcjSFouL/MeFtttrFR1pkaPNyqvFSYVAiONGXiIuQLySyaggasbIPLp7eRfTB
         Mq1riXyyVtbfO8GF0H2UCWVWah8hDOA440hNRZuaGNarRYgc1Fr34nBp+vevgkW9mbAs
         yCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136291; x=1773741091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSK/kqVzy9JKKjImlDgk1/XfqcEvGf7+IAd6nmfQ+xM=;
        b=kwl6z61lNQW24KKSwZNeIRqgaMHr9ru2fKumt+MEYahbTmyQuC0O5bDgkm1xpj/miQ
         d0OzHwZ6uthm7v6o3m/nX1bw1VnKbYRZi+YReS/bxcIBDGkxabVpCY5gWxMt9dgy//n8
         Kg+DJaqbiimwImX5FoYwfnRPRyufCg6jU5qvg2ANLeZiVkWsPx0zxPOUGixP4XHMYdaW
         1LVGMVgVtSWuEvdOPLBorVDkbte7rz21I0SncT7PVD2sNifOZmj14Fo9rigrsiC5Ptls
         /fYmYsAzax+vjRxPBucwnIkHqkrBdA8oNjZK/uWMTkxiDBp4+3FiT2pRYfcSJpglQ7GE
         MEzg==
X-Gm-Message-State: AOJu0YytksVxtS4ecyUmcLnrhRBclPX9MAhaMJMVhHus4hXAHSGZJDBG
	FImgButpG/j233bRUyFXZmuNbUAWln24dHj5Hoj6CGb/aDmYN3f6IQRntIh4/Btj9IoUG5vxtLc
	qwKo4QWg62AKj85o8Pf//4pcc/0uVsZT8FA==
X-Gm-Gg: ATEYQzx8DhyuK9M2y4+bL6qsclPXneGgiPSQ4h8NfMxNyI9LAhcdT+oQdVX7aiOaPGD
	4H28DB+ZLqsw8c7drFb4RrTcrGvEFEvqpT+pZu5SKSEZ3CrXG8wlTrrNgh9UzSQZl91tk73ZyRm
	PJmXebjUNSrO3SxgbPKYWBm6gzPxZp4vUlkL93Au+gfa5tg+6qm1E2qfwv+WA3NBOPPc5GyHfvx
	OAWyvbKs78NzG6f/3/OX4mniz1ALS53UdRKbWUJ4hMr6tt1tjm2igekBWodFR0Or/psYvEETY7M
	S/kWzEPmCCXRduVSlSzJTVZywc7OM4hHkrAvPupN2l3pqLWI5JUsKg==
X-Received: by 2002:a05:6a00:3d13:b0:829:73f4:6ff with SMTP id
 d2e1a72fcca58-829a2f428ddmr13416764b3a.37.1773136291141; Tue, 10 Mar 2026
 02:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772837832.git.mroik@delayed.space> <cover.1772839973.git.mroik@delayed.space>
 <be7197aef5a7bc3de06216054fee6ee67e65cc33.1772839973.git.mroik@delayed.space>
In-Reply-To: <be7197aef5a7bc3de06216054fee6ee67e65cc33.1772839973.git.mroik@delayed.space>
From: Bert Wesarg <bert.wesarg@googlemail.com>
Date: Tue, 10 Mar 2026 10:51:17 +0100
X-Gm-Features: AaiRm50kpzvnR6BJOzOo4LD10NgYcanX70yydE05WGKNjntxwlYp67FLYp6ttRU
Message-ID: <CAKPyHN1tCzX0Yqd-5KeWqBEC=nCkAySn9q7q+TY08XHqztjMkw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] docs: add usage for the cover-letter fmt feature
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 12:38=E2=80=AFAM Mirko Faina <mroik@delayed.space> w=
rote:
>
> Document the new "--cover-letter-format" option in format-patch and its
> related configuration variable "format.commitListFormat".
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  Documentation/config/format.adoc    |  5 +++++
>  Documentation/git-format-patch.adoc | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/config/format.adoc b/Documentation/config/form=
at.adoc
> index ab0710e86a..ea5ec5df7a 100644
> --- a/Documentation/config/format.adoc
> +++ b/Documentation/config/format.adoc
> @@ -101,6 +101,11 @@ format.coverLetter::
>         generate a cover-letter only when there's more than one patch.
>         Default is false.
>
> +format.commitListFormat::
> +       When the `--cover-letter-format` option is not given, `format-pat=
ch`
> +       uses the value of this variable to decide how to format the title=
 of
> +       each commit. Default to `shortlog`.
> +

"Defaults to `shortlog`."

or

"Default is `shortlog`."

4 to 1 for the former style in that file.

And it looks like that other one is right above. So maybe change this
too, so its always "Defaults to =E2=80=A6"?

Bert

>  format.outputDirectory::
>         Set a custom directory to store the resulting files instead of th=
e
>         current working directory. All directory components will be creat=
ed.
> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-form=
at-patch.adoc
> index 9a7807ca71..668330a015 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -24,6 +24,7 @@ SYNOPSIS
>                    [(--reroll-count|-v) <n>]
>                    [--to=3D<email>] [--cc=3D<email>]
>                    [--[no-]cover-letter] [--quiet]
> +                  [--cover-letter-format=3D<format-spec>]
>                    [--[no-]encode-email-headers]
>                    [--no-notes | --notes[=3D<ref>]]
>                    [--interdiff=3D<previous>]
> @@ -321,6 +322,17 @@ feeding the result to `git send-email`.
>         containing the branch description, shortlog and the overall diffs=
tat.  You can
>         fill in a description in the file before sending it out.
>
> +--cover-letter-format=3D<format-spec>::
> +       Specify the format in which to generate the commit list of the
> +       patch series. This option is available if the user wants to use
> +       an alternative to the default `shortlog` format. The accepted
> +       values for format-spec are "shortlog" or a format string
> +       prefixed with `log:`.
> +       e.g. `log: %s (%an)`
> +       If defined, defaults to the `format.commitListFormat` configurati=
on
> +       variable.
> +       This option is relevant only if a cover letter is generated.
> +
>  --encode-email-headers::
>  --no-encode-email-headers::
>         Encode email headers that have non-ASCII characters with
> @@ -452,6 +464,7 @@ with configuration variables.
>         signOff =3D true
>         outputDirectory =3D <directory>
>         coverLetter =3D auto
> +       commitListFormat =3D shortlog
>         coverFromDescription =3D auto
>  ------------
>
> --
> 2.53.0.5.gbe7197aef5
>
>
