Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9E18EB8
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689958; cv=none; b=JDijbvZV2dW4GsQyl4rq1a5bkY57rCgSEGrWJEF/YzbjjpNxr+TSeOy6mXOGd9AkGSpNUi3xVomZaPxJiq9EDYlq38Ty6EVCeJWoJ9G+0gtLcTJvEUc/sUFri7tmizebNdgnUdqO2Gb4aureWjrd0PPzXsjViTOV1XImpmXuZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689958; c=relaxed/simple;
	bh=vKBDxZEOodbnQAaXkYJStAZq4aDhvY+3vOUHKUBCvhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVcjJuqsqShNOWDcWz5ITa4reSy9tAt/o5HcQuxJsqwR4AczjWzoaU7Saa0WHYQ+dRLUQTt+QpueTWULBtRmxIzSQF2R03hkh1YS1IwAAez7yue2gqxkQcS3tzXj4+M78GCJoBM7bi03EFlEBWJIQeeuHOLiPhXjvFxB8U1aoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmNexy+a; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmNexy+a"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9dd7e5f6eso2153428b6e.2
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721689956; x=1722294756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VNHXtm+pk5O+n8P3cjOxwUMBs8pjhmNBZs0FQwAweI=;
        b=EmNexy+anO1jIGCLo2U+1LqKQEcHvv8wHfRRypsOJtU0qFsYU7oUmZ7npovREspz7C
         gTbnVQ84tWVHCrZdsZJ9Htmpyz9zWnL6lY9zCaK5D+KhMGrxrWtRWoUnx9zRUk7KDZHV
         SWz0W/noT4p+q6Jzuhm3HbIdpOLXauUEiqQMvu/DAm1D3ErqcGR/ryHrpGhyrIMiv3cZ
         G3YRwhesd6SJbFd7f22kuXFT6/P7xivxe9S+QKgXnAXxVIpHY7OMLVGuow7anjGnsBp2
         DMRjMASifjRuN6MXlv8j7k58YQGBMA0SRha0SuT3MFX8vGJa51JOkwEK7tb6aqu9WQgV
         kI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721689956; x=1722294756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VNHXtm+pk5O+n8P3cjOxwUMBs8pjhmNBZs0FQwAweI=;
        b=AdhnoYYc8ZxzmGV1ptACUJrVPclVfCyMz5RYfG12VFcSz75oZ2GprB0H1/IE2HM5FZ
         C2FPw4Y2e12kFdutE18Mdk38QDsVLFQlCkUtaqc6/3fUCMysssbpzWaYXVGmwDFeOY8Z
         ZlNaskn+ImIRswU9IUeHh3Twwhi7vRdfABBro9TPunkWveus0my0gt984HMnH1myNVJx
         yWzlRgul1PGMcY+o8IA4BY2MbbMoFCEUkSYhLPu+xRMS3Jk3avVDbNLYNS3+9VRGBF09
         0EvlPNWH5o1rvMaXDj2bByP/OyfAHLG3/NB982l4YSry3iTCy4T6qtbrPTlpqDfv7iQi
         n7sg==
X-Forwarded-Encrypted: i=1; AJvYcCXKLjotjTT8YXkDcwFRgvtJqRfTqbctH5k+TdQv9kWxxk8Q18ZJBzp51gtmpP7s2lOgQzerm8Ik1XdCEUMYAVYUpoqH
X-Gm-Message-State: AOJu0YzhjHRiVaVPCuy/7P/MDMcKHzL3sNIluWneunPqs1CThvKvunAz
	WJQO8Njd2c2VtJdvYkEjFgllWB+IMjrBR4JWXv8AxX7LDbN8PY/n+33wlTe++AbXR1eiRsjwXa2
	Xr+RfdHYOADj9NLiiv5nt0RJiJvsoX+lxwek5
X-Google-Smtp-Source: AGHT+IF0FojZ7/WsZytdFsoMxosOXvaVmeb5YbZSQiT0IlNjh6oG2iwt0Xa750AiGPzxu0A97Kahqnlho5L8mkGxAf0=
X-Received: by 2002:a05:6871:b12:b0:263:3b45:b7dd with SMTP id
 586e51a60fabf-2638df809ffmr5112482fac.1.1721689955344; Mon, 22 Jul 2024
 16:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com> <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com> <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com> <xmqqv80xcpe5.fsf@gitster.g>
 <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com> <xmqqa5i9b51m.fsf@gitster.g> <xmqqbk2p9lwi.fsf_-_@gitster.g>
In-Reply-To: <xmqqbk2p9lwi.fsf_-_@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 22 Jul 2024 16:12:21 -0700
Message-ID: <CAO_smVhd4LY_F0Wgt1CfsidFAB1n_8Rv3sXaBCgrCuOVMxS5cw@mail.gmail.com>
Subject: Re: Re* [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>, 
	Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 2:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Rub=C3=A9n Justo <rjusto@gmail.com> writes:
> >
> >>> It's a very convincing theory but it does not seem to match my
> >>> observation.  Is there a difference in shells used, or something?
> >>
> >> Have you tried your tweak in the "linux-gcc (ubuntu-20.04)" test
> >> environment where the problem was detected?  In that environment, the
> >> value of GIT_PAGER is not passed to Git in that test.
> >
> > So, we may have a shell that does not behave like others ;-)  Do you
> > know what shell is being used?
>
> So we have an answer:
>
>   https://github.com/git/git/actions/runs/10047627546/job/27769808515
>
> tells us that the problematic shell is used in the job.
>
> It is
>
> ii  dash           0.5.10.2-6     amd64        POSIX-compliant shell
>
> running on Ubuntu 20.04 that is "too POSIXly correct"[*] and behaves
> differently from what the tests expect.
>
> Somebody should write this combination down somewhere in the
> documentation so that we can answer (better yet, we do not have to
> answer) when somebody wonders if we know of a version of shell that
> refuses to do an one-shot export for shell functions as we na=C3=AFvely
> expect.
>
>
> [Reference]
>
>  * https://lore.kernel.org/git/4B5027B8.2090507@viscovery.net/
>
>
> ----- >8 --------- >8 --------- >8 --------- >8 ----
> CodingGuidelines: give an example shell that "fails" "VAR=3DVAL shell_fun=
c"
>
> Over the years, we accumulated the community wisdom to avoid the
> common "one-short export" construct for shell functions, but seem to
> have lost on which exact platform it is known to fail.  Now during
> an investigation on a breakage for a recent topic, let's document
> one example of failing shell.
>
> This does *not* mean that we can freely start using the construct
> once Ubuntu 20.04 is retired.  But it does mean that we cannot use
> the construct until Ubuntu 20.04 is fully retired from the machines
> that matter.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuideli=
nes
> index 1d92b2da03..a3ecb4ac5a 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -204,6 +204,29 @@ For shell scripts specifically (not exhaustive):
>         local variable=3D"$value"
>         local variable=3D"$(command args)"
>
> + - The common construct
> +
> +       VAR=3DVAL command args
> +
> +   to temporarily set and export environment variable VAR only while
> +   "command args" is running is handy, but some versions of dash (like
> +   0.5.10.2-6 found on Ubuntu 20.04) makes a temporary assignment

I was also able to reproduce both aspects of this behavior (doesn't
export, value is retained) with ksh (sh (AT&T Research) 93u+m/1.0.8
2024-01-01), which is the current version on debian testing. So maybe
"some versions of ksh (tested: 93u+m/1.0.8 2024-01-01) and dash
(0.5.10.2-6)"? Or maybe we move the 'some versions' around, because I
think it's probably all versions of ksh :)

I don't know how easily discoverable this is, though. I think I'd
still want some linkage between t/check-non-portable-shell.pl and this
section of this file? I probably wouldn't think to look here if I
received that error from the check-non-portable-shell.pl linter.

Otherwise, looks good.

> +   without exporting the variable, when command is *not* an external
> +   command.  We often have to resort to subshell with explicit export,
> +   i.e.
> +
> +       (incorrect)
> +       VAR=3DVAL func args
> +
> +       (correct)
> +       (
> +               VAR=3DVAL && export VAR &&
> +               func args
> +       )
> +
> +   but be careful that the effect "func" makes to the variables in the
> +   current shell will be lost across the subshell boundary.
> +
>   - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
>     "\xc2\xa2") in printf format strings, since hexadecimal escape
>     sequences are not portable.
