Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2728695
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211270; cv=none; b=iA6HHe85uduvDDJ2E/Bur2zf+L1BgE05IMvD3XHv5ekBnJnTAXJm0UAPtInhxgNyC+mEO4TShjFloj06qaLKh4VHtoCO7DGRHuumZxIl8JP7s0+C/N51hSDGuFE+uaDMzLk0G3EJi+4+nSsPH4QeJXjFEN7SBrsoK18gcYFbNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211270; c=relaxed/simple;
	bh=nQ0rQ7KkNCDjUXvsOygCWnPkbjYlN4F9ojQm2bv3lOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh3o7sU9xKpvOEFoEoaPrPmHvb3YSsxhErywlPgTZeeoUWTjyMTh9PCN/hy2rDgvQRG/xk84OtoDXpqk1IDCACWoRjO8XXh5D6OlXRx5IHVFeRjPWiAqLvKuLbtJyBG7oMP7TyCJNZm2639Men5VBpv9TEY40ak6SqlrywrSgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH9+Q+Ug; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH9+Q+Ug"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640c9c85255so3017886d50.3
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 04:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763211268; x=1763816068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qL4DiPAwnHtcs+yXQUB2Y0DBCsgWUqEicbSMFSrr2dU=;
        b=dH9+Q+Ug90WxBF7JNjtMdiLKmm+AcGLyAyyH5dwGcjWTbquNX+VrsNJ5cnY0oM7/0p
         jm3NxSPAkbi4aGYCBV2Hl/ZXmJ0sURrz6xiQkaDCQUdJfJU+q9t/S+rC7OIedUupRhgu
         INo25bp1ERcxdyEVhrCmTUn3pmB0bCVO5fspk59kAIxL69ozlHvqGAYK3EwY61mY7HNj
         TyUCmkpatefnJ6lJucA1zCEpuRO0JmqfSQ963CdTqghxJIlWkwJJt2SPXaxllamZj/V5
         CVaPmCMb6U5D9xiamTYxxYzbVf1trYLA3+CAStSA8qKX65O6d4OLmcZjf1AHwPh60N8+
         mmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763211268; x=1763816068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qL4DiPAwnHtcs+yXQUB2Y0DBCsgWUqEicbSMFSrr2dU=;
        b=Nr4nM8AyNV3cK+/UBiSMXYN2AOBiywGp5RlVI/SdDYuabInmrK7ldj7ZNXG1eh5iSw
         9kNdfEGzfulxOMD2EGRNkFOyBWOE+u72FJydQ5May2ZthFQFBn+k/afE2uiOMlprcXqR
         oYj02Y99lGhfLPq8voI3QgRkq6UHLw9L+mZ8OCoSHiYV3SyQIm04GF24+ruWHAg+oLTw
         4re+7+/sEW7vFwE/Tg/g4lkyZ+WoAftD/WCiCdcCb2MBzk+ZnpvA/tNIqO+I70Q36b27
         p13yRG6lBDFOPWr3cKBmgDSBrxW2TcVXnZYSxmtuRlCNqZJ/RwxAExgRYGgYEKDGmxJ5
         NqCQ==
X-Gm-Message-State: AOJu0YxR2vB/aGJl8UOb3evpj7cl/TcpXRb8jlPW0GMEEzpiZPzxJ/Bv
	TniEdVlWKuTzlTj9gdCRRB+DyEx5WjSPVGE6uvLJbD1pFdUIx/bjxkYz/v/bL6lhe7MicjRALs4
	VqOcsYK4c4HWBy/YFSrXmgUp4Wa0ILX8=
X-Gm-Gg: ASbGncuStmQyIySaXON05QPNl6b5IzYg4Ig1VMEfk2glBS+8WRFxjlqcKaHtfy4oy8H
	Yjap+LPEsVbHZoJv9PWjKhuZDAkOwYs0XsPtFa72GaEVdl8RjbOANEm152z5ukrHpO4S9KlVYrH
	kTBYo36Z2UPAAI24c0fac7FVfWR9zJy0EmZgyokNipGesVUHR9s6nS8oUtRTKGf4rCslWWjzxfZ
	/8Gcy76QEOOFptNOdugcHxdkY9A7t/TBRO6lv5y38KhmYLcF6SizSdxOPmvTLE0Uiv5hPGp
X-Google-Smtp-Source: AGHT+IFZNpBaAte6Q99ttnda4C+eJkfqgp7yICp83Q9GJ9GcwhDZLC8o9pcWdy60qNRa5r9SlGGp2WzbzypuvLLU3Pg=
X-Received: by 2002:a05:690e:2553:b0:63f:a7dc:159e with SMTP id
 956f58d0204a3-641e7501e1emr3688801d50.29.1763211267910; Sat, 15 Nov 2025
 04:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763098804.git.worldhello.net@gmail.com>
 <a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
 <xmqqa50oiduy.fsf@gitster.g>
In-Reply-To: <xmqqa50oiduy.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sat, 15 Nov 2025 20:54:16 +0800
X-Gm-Features: AWmQ_bl2hk2DuXxgi7KtzOAOobLZ7pZNWRnm1qbU8VOCMM_k7TAS9Rv4RLHmkS0
Message-ID: <CANYiYbEFN9BHtNh1PQ9C3gDJasq1PaKnkcH-Nq=FddUCAcMGqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8 characters
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 4:00=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> Not about the contents of the patch, but how was the list of
> addresses on CC produced?  Do they all have enough stakes in the
> code being updated that they do not mind getting spammed like this?

I=E2=80=99m cc=E2=80=99ing this patch series to all Git l10n team leads to =
inform them
that the issue has been identified and will be fixed.

> Also, you had a non-address "Gemini <noreply@developers.google.com>",
> which forced me and anybody who will respond to the patch edit Cc
> address list (or suffer bounces).  Please don't.

Will remove this trailer.

> >     |     * =E6=8F=90=E4=BA=A4   |  279 |
> >     |     * =E6=A0=91      |  740 |
> >     |     * =E6=95=B0=E6=8D=AE=E5=AF=B9=E8=B1=A1 | 1168 |
> >     |     * =E6=A0=87=E7=AD=BE   |   30 |
>
> As there is a concrete reproduction sample from a specific tool, ...

This output of the `git repo structure` command is based on the
Chinese translation for Git 2.52. The next reroll will retain only the
table header, which is sufficient to demonstrate the issue.

>
> >  builtin/repo.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
>
> ... it is a good idea to protect the change with a new test or two
> to make sure the expected alignment in the output.

Will add test cases for strbuf_utf8_align(), a function newly
introduced in builtin/repo.c.
