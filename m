Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02930DEDD
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410229; cv=pass; b=OztxbY2zKplo6eJwIKEcGfJmli3TtlLpF2M8BUT2RjuHza2+GBvx+7v4+gVntxm4yEyS21vUJvw1QXa5uYh1uiRE/T7jPh+paM+XkkgZQHR56abbRE3QwPCk+9DSW0EonWcsE0J+04jtxDD37TrKLzyHld5VBGOf404xJieuaaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410229; c=relaxed/simple;
	bh=WKiBdWT2873jWoqffe9k2ABs+gtdm9Jgaqznt0YBYGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUEAAAIedE2ER3Zjw5klZPpfcuhzsxQ04VxL1EMm1H1mt1w4F5SPSDCD4k1YRlff4l/fayMa2ny0q83JMYhbXZvrCuuL2ngRVaIJ+lacrnCXVlQKk2fwc++vM0kZBsr32I+Nx96JYZRgX09QArAx4Bv518+r19S9QNXiKQHZINU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSzwC1At; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSzwC1At"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56646a34c18so986335e0c.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 12:37:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770410228; cv=none;
        d=google.com; s=arc-20240605;
        b=fRpeGp8avfmBcux4Cxco2SkUzA3FElM0Hxn1wy8HDZA1kiinp368rITuQNXFk48plg
         f0oCvP4OnUi9RfWllwSPZF2iBmhz/Yw4uYZdlvIhtkXnDzzRBjuRSd2qDWmSyof0dFn0
         eivF0nd5PBFXv7PHFN8x9OzQjBLRB2alA7joT6QvCktQcjw6UohVWlBpWs849tuWJBPI
         hGpMHhJXLsFN775khshorj60nbHj24pLEqIIo0Olt20gn+TVultAH7MBIt1iXoKwIjDX
         VLhQwkXitCX7VUvZy7k1CIUNz9G14KPoGx/o859fL6Nweb0TeBPLLcv85rmnBeUF0Ygf
         QxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7b2RwNNQpgAPg1iMm7Ahim+1RZjGKK5bdwGSIW23TcM=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=LEBy49uMUcEFsbC8l+k2vZsRGQ1ttbeyapjUid3PZTKAhVCgf31X3+eOU/DgydrE9u
         aIOsldDU9tCYEzeiDxv25w7veSIoMvUom4l+xonXYl4zg5cDP6FS6eIgw6cAtIHmZ7hw
         Hfzw63ybelg/sPikAwEKNhnKbV/3zXx1s0mON9mhPfZg+svlG/6JgsoC8b8oiQ4RqJWZ
         HE6BNaYjhBBgQ8sooBEscL+25VPDoVm8NN20eXMFxxmypfbtztcp8LLT1/JVpi+AFnUR
         +4kFUX7CVbS0a7xz8tGlX7eNQOzJh/WuYCoANZ863V0DoUFF58NtIYyqWJugePomlqvB
         RWRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770410228; x=1771015028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b2RwNNQpgAPg1iMm7Ahim+1RZjGKK5bdwGSIW23TcM=;
        b=MSzwC1AtjOWgChWGd1jZkrMxaHUzVW5zB03JUhJeUruvlLkxF7/B4Tdap1KDZbRkhA
         KQsf0150PPG+A0yuyKZHTgRHGB+lZQYOOQNiPC6q7ZgyVjpx9za7sIsWMVKpKP0xptGp
         a/2pBJICwKzLYTzLchODbfwV+FXfsWnbV4P4p0QdFcQ5GotPLzqSEjPeyfu0ntNyPZ8o
         8GhZDOyNVQRnIhAcrodNH5Myd8u4JuwsbreNFL67NYvsBRcw7utvrn3M4l43y8VIen39
         aoX8nnAj3mK3vTUG1I0Wv5GCTlasX/S6cNeLvrF8mf37JU1V2AVba69ESJUSSgJHard/
         EzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770410228; x=1771015028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7b2RwNNQpgAPg1iMm7Ahim+1RZjGKK5bdwGSIW23TcM=;
        b=MmsREZVeWhvX7uBEcaohlLI1TcY3DLYktpM2TTeH1rlSchSOVUfIkB8yihavDH/rSK
         8L1JQ++e92nBLTItQI/1FPWroUlUwd2VADTAdLn4fHRa2Z3T54kxEH0oBeOq3TEB/eRX
         CGE2ZWWNTaiGWBce5xQWO0WH+CUl71z6yH539OYEI8T2Gjo39W2sX8cVG35jWgrf+e2z
         d84ByaeyJMIZRk1lj6RW8TGgyccJJEn6KJZxwBiUbFXd44HuCY8oxK5tIEnu06T1IPHW
         TjTx91hzl7hjd3d3jRb2Vl/Bip0dtTNwQVibIpKmPkHyqHOyxksa3xzUi5rovQG/aQ4S
         3frQ==
X-Gm-Message-State: AOJu0YzsKPt0DvwalR36CjBzkHJFi0ndVLlGcxOdqNaCXH+93sY1CnMr
	uNvX8wfoOdoeBrgbBmC64+AzXqeltCvfZOOUIlYdHiKRtruOB6u9UxoqxQRNvIXc173gdg8qjwG
	kPeVzFFXXvt2YnHM9NoNs8vB/emXLdP0=
X-Gm-Gg: AZuq6aIkU1/wm9Rdny1ZK1n4QjuLri8YtYL/Z+lL1oS4TLoiiRfXKLX3/pNXxSPUvH7
	CPSzt0JJf/L4aIJJ/JSZJh60VBBDo24zwrSu2iyiz2plG3yV3yOx4hLykfdQTRgZ3YPFkUJh/2a
	RH3nYOW6pul77wqhg8u79Y2kkraB00NqvjMwKss+GmcmTe2nUt3WHt5Te77kME1HElpmW2+eSm3
	9u76BV27whLOTZ7XzH9s6B/fhI02TjU0fZWuyEDyZg0yhXKZ53ZFFGSKJ2+UzP9pBcbADLk58I=
X-Received: by 2002:a05:6122:3383:b0:55b:305b:4e2e with SMTP id
 71dfb90a1353d-56706086977mr1192949e0c.21.1770410227586; Fri, 06 Feb 2026
 12:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqqikc9ekzz.fsf@gitster.g>
In-Reply-To: <xmqqikc9ekzz.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 6 Feb 2026 21:37:08 +0100
X-Gm-Features: AZwV_QjrdOogi-K4J2Q7K0KBbvoyLBdc9y5TzZaHjtblAb319_vFcX1eJsd8BWs
Message-ID: <CADYq+fYzJS+=DVBAAEbaHjp=sRBxsxZqQCkVMiJhJPSSpUqu7A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 8:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > @@ -1566,11 +1589,14 @@ static int patch_update_file(struct add_p_state=
 *s,
> >                                               : 1));
> >               printf(_(s->mode->prompt_mode[prompt_mode_type]),
> >                      s->buf.buf);
> > +             if (s->s.no_auto_advance && all_decided)
> > +                     printf(_("\n%s All hunks decided. What now? "),
> > +                             s->s.prompt_color);
>
> This gives an ordinary prompt for the hunk and then another one
> after it if we notice everything has been decided.  I am wondering
> if it wants to be more like
>
>         if (!s->auto_advance && all_decided)
>                 say What now?
>         else
>                 ask the usual
>
> ?

Okay noted
Thank you

Abraham
