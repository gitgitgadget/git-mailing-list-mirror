Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EC01ACDFD
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648498; cv=none; b=eJGWZkpXhHW3VPbiHp4Ya/WJFEWzZlqDA/B5712XzFlv8s1GsZa3wiaZ0DqXgMkujDS9tN/g6kqztxN+JyW4fZywrX4P0NVjwNOnFR1ltCFJAnShRgFWSscZWG5z1qi8zbC8segb2HRXQ0BPJkP310B3E+iyh+Fmz8DHdi8cpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648498; c=relaxed/simple;
	bh=24gBCYs9knxBnosHodzxl/yuy+e5OEs62lDgE5nBOMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7vM8TllAMtiQ/sKpk5wxsMApeAu5hhHtTNcdbh5l7pOsQxqq0pwhWBnSfUtbudXp79Fp9P0+TZ2Q0r3pYsh+gYa2E+HRcwikKQ0SCr6Op6pKQhpCBsAUQpUW2vmRE3cndiafN41fuMESVoL+wMWi0zzR99EjFmrwnVv/YTcGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx8QzZV6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx8QzZV6"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c1a760df5so19479816d6.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648496; x=1761253296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24gBCYs9knxBnosHodzxl/yuy+e5OEs62lDgE5nBOMg=;
        b=Mx8QzZV6cYrSlBOHocpNEjsDjqtdJWTQqaa2+NfWlFbhzkCpXja6dlc/eE561tkIDF
         bo1X+qIx2DtBLyQvEbEHZEJH6FnLgR1xIkpNjb7InsDX145h8zsijep1PGIYwVidphol
         YlwT57PcGr8KGM8Q6sn/Fn8jmPl8gEpyoisVKjnNUjTk5XE+C7ZlBHJE3tS+JTz5mJ9W
         nPGt/4bpr6L2XNotyCAuppLki3roX7in30Ct9CjJ/IcbOFRyGJ2DiU6XaIE5pWHcgHk8
         ceNMeRc5uwnR3k54DuMWbFuJc8ZnLUir8DBPqvGkZ/BPZtwkPlXE5DCp+Y82BmYqB8/8
         eQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648496; x=1761253296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24gBCYs9knxBnosHodzxl/yuy+e5OEs62lDgE5nBOMg=;
        b=moqsK9iicav8fowFMI7helOZzidkfN6ejxvQR8xCfqzxZ7XMRlrzWTBVSb8lJkxIVC
         Wajyl5pBcnw8feeOC82yIeaUznfLXo2Cy4HvqGNjD2b1rHNE4khETPDtpVzIVLAkthru
         d3dvOqI1IpDG6V5+s+aWVH+iKDtcYUJOmrn63SnnOsvRPznu2RfOlrsoNJaap4yd3vQP
         PAUOIgBB9Ycp32JE5Wcn45gi8U5IigHxuPMuQFnoOq4tSfNufGRwNfY2xwKmkLfWOK13
         0JSoJJed+5FuOrFpwuMfpg1jdx0duSXs2d5KKU50XI1JoSFIh1zX7K11OGI9c11d8GRu
         nBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhRf/+AzZubDp0NN+zOwURa45HkAB9Vl4XE0Pqbv1TQ1P/zMyXetGtoa2jN2bBp+hwPvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bPUngyWRzedpKZhbvhnyGPQtvtae88EnFhHyqGmj45u3XW6b
	Qsj/dDZIFy16gne7RPAxo120/UQND2vUjMwz+KIpGbe21+OACIyP0OajARm67Yh7jehRlAYTUIj
	5oYe6Iz0PCkkxPWcKfbZ+yrwFnXU/GDRZq2TjtneMP0vU
X-Gm-Gg: ASbGncuX64cTnNmkZbs1SpwVdK/E0oky+Y2g3ohYAvkSQA862YA/4+45Fw7RkpRKzK7
	lbOy72a3Qzi5dfoS/eT1LmdwegpmuhKkIRaUGko/gbmx2GDuih8ZEAN9znruQVCjr8kIwqY4qw4
	R37+SWbJ9U5UVQbwuiGzAQ5vMbFcG5+/rZftoq6cn6zwuzl+7xUeIvgMAJdOLuLnpaDOmP05blx
	SN5mntry6HQIC0PH/3DZVeEMIoNtjvHYLgGZkWCzZ6T+axD8heOLBhAWiewd4alAngVTPNmyzyJ
	mz0YBSHFrVNppZfc/+4X7UQyfwu8Fmhc
X-Google-Smtp-Source: AGHT+IGVEX8ZXP3YKBlnp5kfciuhgWmsSP7OkIMaNPWIAAAkIkbbRx770dCl1UcoczPQlfKxccQ8or9zTAC1/8FGA+g=
X-Received: by 2002:a05:6214:55c1:b0:87c:2282:993e with SMTP id
 6a1803df08f44-87c22829b22mr12386776d6.2.1760648496082; Thu, 16 Oct 2025
 14:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016184420.78268-1-okhuomonajayi54@gmail.com>
 <xmqq4iry4r3e.fsf@gitster.g> <CAFpMFfBe7+pMUL8aaDkGkPUaE9RhCW25OJhJy69EcukgSFn9+A@mail.gmail.com>
 <5b52ee84-8889-4357-ac46-93ce5b6b100e@app.fastmail.com>
In-Reply-To: <5b52ee84-8889-4357-ac46-93ce5b6b100e@app.fastmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 16 Oct 2025 22:01:24 +0100
X-Gm-Features: AS18NWBxYFTIAPbXrh-0NnrxENMpn_1c8z4juEDRfa5XfRunM3owUB7EQTiu0fc
Message-ID: <CAFpMFfC1cut5=qwoRfvv+zCgqvN6z2WS=R7ynjwSd6LB0aJD0g@mail.gmail.com>
Subject: Re: [PATCH] gpg-interface: trim only CR characters that precede LF
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Haha, Yeah Kristoffer! , I see how =E2=80=9Cthe the=E2=80=9D can sneak in I=
=E2=80=99ll watch
out for that too =F0=9F=98=84

On Thu, Oct 16, 2025 at 9:54=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Oct 16, 2025, at 21:38, Okhuomon Ajayi wrote:
> > Hi Junio,
> > Haha, I smiled at your =E2=80=9Cteh=E2=80=9D comment =E2=80=94 I myself=
 often make teh same typo
>
> But on the other hand I think the the easiest mistake to overlook is
> when the article is doubled.
