Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1811EEFC
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763482; cv=none; b=EfNfdlwuKypk7faTYfpKpwIgXKWmI/zKTpnIOzqaCG9ZpLBrXPeL772rb0xEckkxasYOoZ83fbe+y565dGjnBCNR38UqhIlYXw/ftjNn1Ntgoax2tt/SqRfSDZOOjVU8TRHkI+JIUVQsGTSYD20rSalNRLG+Tiz3c9nsUakCQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763482; c=relaxed/simple;
	bh=BH5NFu6dteooNZI8C4mUYR0rRnDVLb50glXWllvKHTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtsKOYUb8qsOD05YpZTe0jBm9n4/SIrj0CcAZeH4JVE20ETWhkP8NpTOjquud0GBwe8bDWH/F0ugncvql4OavtpQbNNF6FIOd9I2krM77j4ln+rHnSuA6CAUeET61FLwQPccSfHfbITI7QdBAZdCYrkr49EfD0nMfz/2p/B/LwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6d8HtaK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6d8HtaK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso38722166b.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714763479; x=1715368279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH5NFu6dteooNZI8C4mUYR0rRnDVLb50glXWllvKHTU=;
        b=Z6d8HtaKzVo/yqzOApugUPvGO1LULhqVCXc9yTPOo/UmM6gqAIPeDTG/ShDrKFIh94
         7A27DTrqhAO5k4IWQnEm5aPIz3rt5sg6hb16iGAOCM40DEs6t8ORUjn6ma/LFxvjnDu9
         e76pKosqkApcUQ/B9YmN482Tln9A2FcAf5A3yxaKRV60O/OLCX7MN1+w8e71MqJ7os9Q
         c0LB1s4sCXUpO1tOHKBiOgX2CvuVs2HHGi6BJ6lamKyQO/EMB6/iiH5tuDjXf09+XdoH
         w9KqEpBa3wZ2HJU7jlo7JXPyad3IvyI70tBJHmApG2gPLJgaWj+6JPkj4wiLOjomxKUm
         g65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763479; x=1715368279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BH5NFu6dteooNZI8C4mUYR0rRnDVLb50glXWllvKHTU=;
        b=DTlE2VHSg4IfVEr10H7jraOzxHR4xTCK61rrTuw/3TjBCmETmC072Uv3+wPVKM1bV0
         gdLYz/30vl6H7CkoTDmkmI+MzjIwP9DPwcQnC/QApAHksyN1994UYG8uxI3WwEznVJ0m
         2sRY/krbl8KVHfKsrAW0w/xU34L/hmatWdDc4cVfGg2Xlw21RKqcJr9J5ZbKA+C9ZDBa
         R9sNx/Bv9AkRAeHRN1gbOtvD0MaB5iG9lueFznaby+f0EVYNK98EIZkkvvFkMeAEupJS
         39bIVevFF3l49Et1f1u5ZdxyrtC1/CLx+6Gfpu0zdTZjL4ptRABhD0VzDlPQ5ng57LBk
         b2Xw==
X-Gm-Message-State: AOJu0Yw4mgrWsJAPM/TfRNPiz7D98vHt01YjB941cDsul5OPmHU4tAGf
	gcaPB1Dmj6hFIzKfTCA361PI8C3EWFmb/Vgx8LmvzVW96S0MUfY3fjGwgdczr+CbLZ7luYQhVsD
	zvium3HtUAy5OITOvDdBRyvExs08=
X-Google-Smtp-Source: AGHT+IFLapsgW2bNBxPELXYp7DTGy/qkYIaf6gsSkWJeLsFKQOzP38SKTbQxO1PE9VVFuu6RxdsOFuBrzwCmLinIYIY=
X-Received: by 2002:a50:8d16:0:b0:572:6ab0:6afc with SMTP id
 s22-20020a508d16000000b005726ab06afcmr2431802eds.33.1714763478727; Fri, 03
 May 2024 12:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADDzAfNz3R5yj1SdJYbBe0f8m3Sp-R+X6dRpYoJ8Foj6zijcDA@mail.gmail.com>
 <xmqqmsp7aqoa.fsf@gitster.g>
In-Reply-To: <xmqqmsp7aqoa.fsf@gitster.g>
From: Kang-Che Sung <explorer09@gmail.com>
Date: Sat, 4 May 2024 03:11:06 +0800
Message-ID: <CADDzAfPbSv00AfzdJ5DZbXM8YjAr=po6Y_1Y0weyw5dvVA6qFg@mail.gmail.com>
Subject: Re: Combined diff format: Show all filenames by default?
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, May 3, 2024 at 10:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Kang-Che Sung <explorer09@gmail.com> writes:
>
> > My reason for making it default:
> > ...
> > As the "combined diff" format is likely to last for a long time, it
> > would be good for Git to set a right default for presenting this
> > format.
>
> As the format HAS ALREADY lasted for a long time since its
> introduction in d8f4790e (diff-tree --cc: denser combined diff
> output for a merge commit., 2006-01-24), it is too late to change
> the default.

I wonder what things would break if we change the default behavior of this?

> If a scripted use wants to parse out all the pathnames, it can write
> the option on the command line just once in the script file and
> forget about it.
>
> For interactive use, the standard answer is "you can alias only for
> yourself in ~/.git/config", but unfortunately, because the alias
> works at the command level (e.g., an alias that allows "git lc" to
> work as "git log --cc --combined-all-paths" can be written), an
> optional behaviour like --combined-all-paths that is shared across a
> family of commands (e.g., "log" and "show" both would benefit) is a
> bit awkward to handle.

Well, I won't expect the default to be changed for uses in scripts or
GUI frontends. I wish to change the default for interactive, terminal
uses, so that usability comes in "out of the box".

And I don't want the "alias command" workaround for a few reasons:

1. It seems like the `--combined-all-paths` would also affect the
"file-by-file" diff output ("git diff-index", "git diff-tree" and
like), and I am not requesting to change the default of this one.
2. The combined diff format is used in many places - including "git
diff" when there is a conflict, and a "git show" of a merge commit
when the merge was not trivial and human merging was involved.
3. And this diff output style should ideally be a "git config" option
that users can tweak it for personal preference (including reverting
to the old, "`--no-combined-all-paths`" behavior when needed).

I know there would be compatibility problems with GUIs and scripts if
we change the default like this, but the GUIs and scripts should fix
them, as git is already able to output three filename header lines for
the merge/combined diff. I just request to make it the default.
