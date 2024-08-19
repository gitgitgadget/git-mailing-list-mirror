Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830011D696
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071587; cv=none; b=fMcPm4PPbXvjV0K1K/eXUy9os8dU2QTv8H5BN4T/URnpPOTUMN0FfjjjGy3psg6JoVApdaJhT6cwNLw1e4KAyPHXLrzZvqILVwKJQDTilIjFjC9DJd9SSLEuKLKQAxnkaylDvIGiOPE5OEPvr/s7imXW7trEkcGwaoeK6QrHXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071587; c=relaxed/simple;
	bh=LPsd6FXIdy8Ea84XE2gDt12MQedpduqlgBSRV0DjPck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p86KXwuryCA9H+qgqNzxJlupCvuKH0YJzZA+sNdZRMME/C4+vj58oFIWLtfBt6qRNTMuD5xiU7bPBWoNEh6LmmxCtAAb0vHB2WSOYBTlMFgJopTnUGGlwuHmMd1Q1UBNC8ZI7KKmOc9otDiPeL519UiaNBnn+Leag54V9xbMlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK5oKhLb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK5oKhLb"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so5708144e87.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724071583; x=1724676383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dcCA02XhiW7uODXKJJJjACw916GhVyyKdZH6/Uge6o=;
        b=lK5oKhLb4PwdMF+Z7OCtxFZpGOqZ9qDFfIKIv5YTfbUCvZ8qB2ox9h25zlFYnqcQ/I
         DSMwM3mJxpIoQye4GTp92/cLloZn2jL4qkdB+yf3Zybrjg3mbiZKzyPE567kPiSWjY70
         i/MwOtVWBSYXpOT81r0K1lFvs/2p0e8hYFvEK65CQubwpScyfI8XrrMQQzjVmgSpdrQr
         pzAfDugPyLkJ2RYDxqeVMkUWU4CqoV386RbsqFCuZsh+CMAPuEb/td5xP1jtq+XTMGEG
         Cz5Oxsi4G7Pvdrw+vIR3UtVxe8ICclzNCyvvKEm5p5ixBQJnGCeP8LelE+N8aHieXj9H
         G5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071583; x=1724676383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dcCA02XhiW7uODXKJJJjACw916GhVyyKdZH6/Uge6o=;
        b=jsW5SjA1z4WWMDT15OBBUP/x2w744eLCjD6PnMgCyNvwCYHz71xcvpaabX6eUTpj9w
         Uayl6wX1gRV8jOnKPn3xGjkMYuBSlJwAhnJqo5CfjD5v2pQuFpbN1j1Wx0fWn1z3R5Sx
         2dhHLcl6+HPUy4Ja4++jNfu0tOAAL+lrOOBvHDLOlQq97gGHPUfT9fB5eDRMJYKtDaCO
         4wz4GCD6LAPTP97enSfCLDGZLFO1rGA4WNMaD/0JVRyZi9F/repJqklfOcv9eQyY4h8w
         fiC06DzA0s/IzFjzZwZP7exR6iTl1agD1LsHp50m7mbcz9vEetlhQrS4sTRrpjbmxnVz
         er4A==
X-Gm-Message-State: AOJu0YwCmBatzaZ5VDOzGAGDZ+i+8rbwYGN6s941zaVzuDxljHTaIspi
	X9cH6Yp1FZn9MmqTD/4BUNYtr5RtmdW6J90VDI54pdSzQ8nL4vct1SqFsI7gZWnN+CvpbwBb7vR
	++2Wu4eKiBPxNtE6yR9UJFRFHMx8=
X-Google-Smtp-Source: AGHT+IG2gMiS+zjARuZAeG0bsWBJdHlD+19+NGaCNtEw1o/hgwJnac7AueHLjU5uFE3wiXg/rDOtZtvfE+uP5MNsh7w=
X-Received: by 2002:a05:6512:3045:b0:52b:9c8a:734f with SMTP id
 2adb3069b0e04-5331c6e54a6mr8138521e87.50.1724071582762; Mon, 19 Aug 2024
 05:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813172432.55487-1-shyamthakkar001@gmail.com> <20240814142057.94671-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240814142057.94671-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Aug 2024 14:46:11 +0200
Message-ID: <CAP8UFD2-VbyK-ZecDKEvgKicWrVe=e=z6mH_xjmrf=a4ZAYd8w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3] t: migrate t0110-urlmatch-normalization to the
 new framework
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:21=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> helper/test-urlmatch-normalization along with
> t0110-urlmatch-normalization test the `url_normalize()` function from
> 'urlmatch.h'. Migrate them to the unit testing framework for better
> performance. And also add different test_msg()s for better debugging.
>
> In the migration, last two of the checks from `t_url_general_escape()`
> were slightly changed compared to the shellscript. This involves changing

Nit: s/shellscript/shell script/

>
> '\'' -> '
> '\!' -> !
>
> in the urls of those checks. This is because in C strings, we don't
> need to escape "'" and "!". Other than these two, all the urls were
> pasted verbatim from the shellscript.

Nit: s/shellscript/shell script/

> Another change is the removal of MINGW prerequisite from one of the

Nit: s/of MINGW prerequisite/of a MINGW prerequisite/

> test. It was there because[1] on Windows, the command line is a
> Unicode string, it is not possible to pass arbitrary bytes to a
> program. But in unit tests we don't have this limitation.
>
> And since we can construct strings with arbitrary bytes in C, let's
> also remove the test files which contain URLs with arbitrary bytes in
> the 't/t0110' directory and instead embed those URLs in the unit test
> code itself.
>
> [1]: https://lore.kernel.org/git/53CAC8EF.6020707@gmail.com/
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> This version addresses Junio's review and removes the restriction
> of running the unit tests in the 't/' and 't/unit-tests/bin'
> introduced in v2 by embedding the URLs in the code itself.

Nice change.

[...]

> +static void compare_normalized_urls(const char *url1, const char *url2,
> +                                   size_t equal)

Nit: it's better to use 'unsigned int' or just 'int' for bool flags
like "equal". Or is there a reason to use 'size_t' instead?

> +{
> +       char *url1_norm =3D url_normalize(url1, NULL);
> +       char *url2_norm =3D url_normalize(url2, NULL);
> +
> +       if (equal) {
> +               if (!check_str(url1_norm, url2_norm))
> +                       test_msg("input url1: %s\n  input url2: %s", url1=
,
> +                                url2);
> +       } else if (!check_int(strcmp(url1_norm, url2_norm), !=3D, 0)) {
> +               test_msg(" url1_norm: %s\n   url2_norm: %s\n"
> +                        "  input url1: %s\n  input url2: %s",
> +                        url1_norm, url2_norm, url1, url2);

Nit: something like "normalized url1" might be a bit better than
"url1_norm" as for the 'url1' variable we use "input url1" instead of
just "url1".

> +       }
> +       free(url1_norm);
> +       free(url2_norm);
> +}
> +
> +static void check_normalized_url_length(const char *url, size_t len)
> +{
> +       struct url_info info;
> +       char *url_norm =3D url_normalize(url, &info);
> +
> +       if (!check_int(info.url_len, =3D=3D, len))
> +               test_msg("     input url: %s\n  normalized url: %s", url,
> +                        url_norm);

Above "normalized url" is used for "url_norm" which is good.

> +       free(url_norm);
> +}
> +
> +/* Note that only file: URLs should be allowed without a host */

Nit: maybe s/file:/"file:"/ would make things a bit clearer.

[...]

> +/*
> + * http://@foo specifies an empty user name but does not specify a passw=
ord
> + * http://foo  specifies neither a user name nor a password
> + * So they should not be equivalent
> + */

Nit: the above comment would be a bit better with URLs inside double
quotes, with a full stop (period) at the end of each sentence and with
only one space character between "http://foo" and "specifies".

Except for the above nits, I am happy with this version. Thanks.
