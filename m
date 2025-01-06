Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FC1DD874
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169665; cv=none; b=DY4+1VWHS7K2b6C/meeSJux8C2JyVXHD31sGUDqAWhxGlBe2zrcVImQvnu2QjfwkeQRheOFwd2Uz3kpQYT8dXs4NiCyXl6+ZnH6YneDU61u3sosOfaF3jcJ5JCgHLBMTiY81DuKfyKhrJdOA4c4GE0OC3QO8eVVBHHnRwiwc5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169665; c=relaxed/simple;
	bh=4FbPPtDdG2fUA5tOuQkShC0AMhvP0KXC/KRQPUAql34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipri5bOP6gGRoUEKaFuvVgcgIrM3dKtMXNK/falIqoHNHtO4MghckXJ6zOQG3EqHlQ9cdpC4ZL81Mq86es5pGktzfBzXup4v5Weqxn3132aUaGM/RI3smxJv1IeYqNKUihSE2uIcqgah8ckrVEeCJjYd4/Saace65HkzIeEyppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAATKJhz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAATKJhz"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso22836029a12.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 05:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169662; x=1736774462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5zapdz5BwS2KKB2KTGSDDITjMsu5GVIGq1LBoHZW84=;
        b=CAATKJhzONPpsLOb9HLs5+Q3fpaxVHSWlkiC/i1q7gcY04adBLmmFaIbih4OsgiIjp
         DcqqXrwykwAm3ZwImtMTdlYtST1dkR+nfHbStDQrJunJBF6wmsIgwxcrRkDi8bls6xx4
         FlmpcXt/xZjBSKJ3d2GpIHPhiOGLSd7buymwTIOJjhRf6MtOLfwdOSxXziOQURjcffgW
         gqGN14ccGOEyhVAB6WHc2XUzLykzxPFqOkR50IkutXuKa8eVwUUEo2xE0p52h2IBndza
         kyqHGPaSzpxvNDYYlwhuD+P4f8cy9qtZxWjXrfUiHvLB/7ZLPBIHy0nZTkII0LQ+fXUn
         gJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169662; x=1736774462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5zapdz5BwS2KKB2KTGSDDITjMsu5GVIGq1LBoHZW84=;
        b=m3HUDtET2YsGKs/5nYhsHtJSbyyjfpzD6IaX0XUY92Q6DeGjciK7EP3j7bwa2/th2l
         b3Fv+WdvbrwUTT8LwKsWH+zB70ejIr5w0w49OLANOHkoARmTPw7Y4w7FcRdw8qUYcb5M
         gbABjVJDbf62V673TcTIaOYzT9BwkJKeuTKhV7S/kMrllFKTL7fghbboA7um+I2LV0fX
         hNHvEPYL+JuD9tSQcKug0ieGygVRl8jqiuiIG8eF+QNwoURSf78fW53ZYIhe6BI/c1eb
         n+p7RmwrwKfJmV5znqSpmE6k1fguxf5ICuI12McGSzAbN9H42lCIc0v2P0ZXkTFuRPez
         OsMw==
X-Gm-Message-State: AOJu0YyJ+33f6/YhFeRgDnOqNyzoIx4E8jTMIdELv/sTGfO5p2Ae5B0Z
	fXEy1Viwbc0v9gWwZubB+8HAdwo5jzvNKwV/9lmwAY3DjRO+q4t1nCy4xs3TK5lEu+oz7wSJfm4
	0mUANMB1bqD6xToC8e8xFsIXuXXwV9zHE
X-Gm-Gg: ASbGncuHppoPYiCHKeFWMQd+oqDIx1sNsOH31Q/TJ4Rn0SHxGZgQwcosWZKXq5+EqCt
	zQwhDp27UffG2uzgPQO914bO2AcQClvgPJ5CEDcxo
X-Google-Smtp-Source: AGHT+IEOjEc/LgnPJ8pVTgHQNrNHy7oJ7+IaaAU6cwNzvXIUhdpJgeVeToJjdARQHoLsiHcqLHyPyuHDA+4sPLnnKtk=
X-Received: by 2002:a05:6402:3594:b0:5d7:ea25:c72f with SMTP id
 4fb4d7f45d1cf-5d81ddfbf03mr48092727a12.25.1736169661962; Mon, 06 Jan 2025
 05:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-1-2ce87c053536@pks.im> <CAP8UFD1wM29BFX7ndh905dX8aDF_vdG_azf9phnY+Cgutgfj_Q@mail.gmail.com>
In-Reply-To: <CAP8UFD1wM29BFX7ndh905dX8aDF_vdG_azf9phnY+Cgutgfj_Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 6 Jan 2025 14:20:50 +0100
X-Gm-Features: AbW1kvZsNa9JMhEoNaqwqUfQeFDQzBCW3AexxpuI4pH8ejbG1KQkwGlMa9T5wrU
Message-ID: <CAP8UFD3c6Z55m=frXqWS1ffrOK2y-MO8E6vMXsv9q6eWkSYBjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: wire up build option for deprecated features
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 12:18=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Jan 6, 2025 at 8:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > With 57ec9254eb (docs: introduce document to announce breaking changes,
> > 2024-06-14), we have introduced a new document that tracks upcoming
> > breaking changes in the Git project. In 2454970930 (BreakingChanges:
> > early adopter option, 2024-10-11) we have amended the document a bit to
> > mention that any introduced breaking changes must be accompanied by
> > logic that allows us to enable the breaking change at compile-time.
> > While we already have two breaking changes lined up, neither of them ha=
s
> > such a switch because they predate those instructions.
> >
> > Introduce the proposed `WITH_BREAKING_CHANGES` preprocessor macro and
> > wire it up with both our Makefiles and Meson.
>
> It's not clear from the above if the two already lined up breaking
> changes are going to use the new build option in this patch, in a
> following patch or in a future patch series after this one. Let's
> see...

It looks like the two already lined up breaking changes are:

  - removing pack-redundant which is handled in patch 4/5, and
  - removing the "branches/" and "remotes/" directories which is
handled in patch 5/5.

Fine, but I think it would be better to be explicit about this.

Thanks.
