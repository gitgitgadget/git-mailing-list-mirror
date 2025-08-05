Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F448242D70
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411010; cv=none; b=BfjBBzTgY4/vAeLGJYPhmAyFHkPKEiEUNesBhVw8SRZU1szqfSJlK176y1j04IEhyvqwxM1gKvcBuoCx+2pG2TgXxdOYW/48RnqXfBkQaDpuLrjyw6zjLcTpL8CvWVnjYbPj1PDJ4XQGhWe+Jm36O13/CpRwez11dHyBz5RGkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411010; c=relaxed/simple;
	bh=VEKkiHqE8qRiz28VCTvLsBemXmGWOxb/0Qocszc/W2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li56GzuEaxmsTmzfbVPJI1d6Wuw6AL25h/fZ82qTfn+dlaVU6nwMndH5O3S7sZNUw3fZgnSN6Rjl67waZYB0lSQsYx8ryM3c7sUY5c1CBdgkGBiNtQMn8Bq4VlLEjihyHHmiZNyO8wuIKNvv9I2hqU+aPlC48npb8UWw3tfiZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVTsYGZd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVTsYGZd"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af66d49daffso812381766b.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754411007; x=1755015807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H6OlTXXt1JZzKiYXysv3R9X3lx0mpka928yF14u+X0=;
        b=OVTsYGZdnAu9SJSjoEU2CE3CEQAhA5To7oaY4vWzHUz4CHQtb5qYm2vc1uFZEW6gaZ
         YSlu/SA/zmCCZ+hYLgEnhwWWyoHZoNpbzeWFH3vE2yBzkMLzaIMGY7yONg0E6Xsi2bQg
         GVsA9aSl9is8g48cnuYVr9P/4BdzSPtbYRtY1t9Yl9q3c3t5hoOnHgDkFVC9F1lRcDQh
         dayyMF6nP40iXhFVjVTfr8BcMSkDimcC6F6oD3S4esyQLMl43AeWknsI6Oe0jndpMdUy
         YIuqXbxt9ZxfDM4EOKRFelTrmxtqktsFEyJ/+odumTJVqyrDOJb92Vcpz4n7ZTA57aXG
         wtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754411007; x=1755015807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H6OlTXXt1JZzKiYXysv3R9X3lx0mpka928yF14u+X0=;
        b=AM208ZymOhXkmcG2IT0W5VKcm8HElYBHaLEQhza7vTvbLUxROckdoSLPs69+OeQnx0
         bv1gwO+o1fP13+4H63DBKySOe09Q7u7BFqTFC9qQzuut2wltus2goHww7vis6Aro0KJx
         z1mh2g/pnyEXQb50o7ukhCBD0PZABjHTfRwVwW9qq9HquHV956dTRYTwAjv3bAU+3XCi
         lAdybfP+sgRjblzUQlPxlfjLUCiPRSxYFWvGjTdAroXqnWvPi8AfA4CMqM5sH7nPOuzy
         W6LCFdLg/LVzctkzSZEUWu9Qq9XjOysBKTW9qLTisrV2M8kZYdPh389EVFuHFrDsVV4a
         G5QQ==
X-Gm-Message-State: AOJu0Yw0FJZmKG8qatg4UvgbpxdeP2/YxEqw6X0iDXYCE0A4vQ9BjHDV
	/HqNT/d0kClCapa92ev4KIuI5/BhFB7n4Eb67cxT20uxnbX3U6UDl/ORgpzY/Yv4XvruiL658oU
	ZDI5l9PB6PZjkv6z5KtPcz1yicXkFVI4X27v829A=
X-Gm-Gg: ASbGncsb7MFQPZApbSWc0g40fCFvJEEWSabUl7UU2oRzajXco6oHtmIOkPLxUd4csVY
	NZsiPa/MgBcvteK+86Xo/cKYBqUAbvG2aGDE7vYaVrCR9NnkBVJb8QwnuxHifyWd+6PwjfnYYv+
	jSm1xOGvqdq5AhXejg5Nykha/eLhhZbdNk/+qkOfgXYCiw4m9Os02Tv32TK4e3EgAFAZ5n/rTOT
	NanQ9q8zHvu1Pie+s+gWUsLbhpcL4rmpEXY96LuxA==
X-Google-Smtp-Source: AGHT+IGKcEwbii8R8KJhnVin3eykoCWdUWt80AK985JvWPuQ8psf/qX5J7hJoQY/Z2p7n06EqZ0RiREfEjj4inNsKZY=
X-Received: by 2002:a17:907:a70f:b0:af9:6813:892e with SMTP id
 a640c23a62f3a-af96813c46fmr999537866b.51.1754411007177; Tue, 05 Aug 2025
 09:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqms8fbilv.fsf@gitster.g> <CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
 <xmqq4ium3w2x.fsf@gitster.g>
In-Reply-To: <xmqq4ium3w2x.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 5 Aug 2025 12:23:15 -0400
X-Gm-Features: Ac12FXx1e8ICh4hKFjKocSCHRgEO1tjAhbRXdFgOFuotUAP219PQYQzmeKwggdM
Message-ID: <CALnO6CBLF2Zxhy=mvz61U7M3X3UNA-V8R4tkzOvVjKWpEwi8Mg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > .... This is true whether I use
> > my copy of the topic or the one you publish (4c8db1e55c (builtin: also
> > setup gently for --help-all, 2025-08-03)).
>
> I think the breakage I saw was while testing the 'seen' branch as a
> whole, so there may be some interactions with other topics.  IIRC,
> it was running "git repo --help-all" when I saw the complaints.

Hm. Will try again with the whole seen branch, but after merging
lo/repo-info locally then

    make -j $(nproc) SANITIZE=3Dleak CC=3Dgcc-14
    (cd t && prove t1517*)

still didn't fail.

--=20
D. Ben Knoble
