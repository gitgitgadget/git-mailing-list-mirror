Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD9320F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326896; cv=none; b=HRhyI1+Hw3RXyYqlBphUIN6XtN5fHq1/82bgoj5rKEqKivQF4/KhpfZJCCiDN/IwgHHzXzZg91Y+wsoK3eQ3xGnoP+mKD/1m22GUz4K2CRDe6ZYTDfF0HJ9UwTXryt/vnKYh/VgnNgaeJeJPyZrKJXaDqltPOkWt5aYy8mathug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326896; c=relaxed/simple;
	bh=A1PAD4dWQmfhya/M/oWFqpizWqt2Bp0nVjpYgOYypR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzeUSRiMsF47QKZ7jNuClY9f3ICnGSAke5Av/iMv63Qq1Dcg/4TvpPCeY1OS7VrbDdjGLOpXorI6nNigdddtYhyOmF6tPCeUFwm3+ksnezaMFEp6V+RUCpM2BOUIuTkRSxZqscwAr58lZMb3v/N6KVtsLKmfTETTLk06m3Ym0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmsxZEF1; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmsxZEF1"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50a44ec17d9so99872e0c.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326893; x=1728931693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1PAD4dWQmfhya/M/oWFqpizWqt2Bp0nVjpYgOYypR4=;
        b=WmsxZEF129on+1LvB1+cqBqdiUB9rFyOMDLhKm/pon7tp1Yv33UD2fVSsi28W/jXfd
         IDfrBMl2Fa68/SpM2A3t8lTLHsUq30/xRoBPXIZyPy52JrlIoTOvD6ogyt7RMblNDI/v
         42xHLJ5ehUwTpZ+FzQNWf6O0MiWVUulE9XGQYwQQH+y5F0+pb/xVSeso1AuwrWb8ktq3
         HbbSEX4+TX2RxfTBgGya/MtuZrhO3QNBlt5lWLt3toSQPXuTY8o/ZKJseZhl1nh21GIS
         661a31vhjAyz+dQsDTdZSirW2KKLe3Ld7GUf85YPb7wb3LaHwmsD//I/Kk84cxHKNICX
         q+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326893; x=1728931693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1PAD4dWQmfhya/M/oWFqpizWqt2Bp0nVjpYgOYypR4=;
        b=lK24TmHVyUgV6qS+LMT02FY33GZCtWuhW9jWhVmookuBJTaBJZfT1OmZG+9lHf1UOG
         DTGEID0LeLTbTpvmp8y3PkXj3Th1qKDE1nNTu1OmOpm9KMFXGZAhzZqfzT9RfvCz+Ogi
         WXw/6wGiilzT8mY88aCsc3TbiuL70wVvJPgZcR9d6DGiyZwAQ2FAkJ3Y/Jy/ghF28mKM
         NG4SiHa8bmQvElLyL5QiVWLJ3O9MmIUixDX2GGwUgonegoVzsEK4esW/hw0gXvGbMaBT
         2j0WMQXv7h4P+TbXB2x/XfY8hTk8DEh9AWn1I2w9neYkAk769ahCw2xAupWUgRowS/Vz
         aNDA==
X-Forwarded-Encrypted: i=1; AJvYcCWfI7o5Idsd1cYGJDugdQqG83ZP9TrsCKDxl2IIuZVnwk6kY9IBBUOQCn31Zp2Kf2kWzTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPE+IGj45FW+uJUOT9w40fCSQBfYL1POdiYnohrt74GQ/07468
	jeybCjT6h4C8DE6+BdHr3ttB1be02dBX9OY01gOd879Gu0d6Q+glOP6Wutqwi3Xngnct514ndK/
	Co5f3x1w4473uvvN65SysJWPnyVDm3Xx9DMzdA0Kr
X-Google-Smtp-Source: AGHT+IHCZJPC8skKOcWL4UxDHBV70476gdsNtCt1cB6P0pbqqgyW70DqFnxw/NIw1vUD1Y/XTZck7fpX9OG2GevicCY=
X-Received: by 2002:a05:6122:45a0:b0:500:ffbf:e11 with SMTP id
 71dfb90a1353d-50c8554fd7amr2897718e0c.2.1728326892984; Mon, 07 Oct 2024
 11:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
 <834250ef-46ec-4667-8e41-e427472fd623@gmail.com> <CAO1n887uu5qUcqLcdKfh8FBKJAQUCGqVOnAzX7WWiFEnuuMF3A@mail.gmail.com>
 <CAO1n887hN81j5h12t-6xpNQAQ5uOx1wxLz48c+O4hZE-pWdY8A@mail.gmail.com> <ZwNx-sKJJNDQ4sIC@pks.im>
In-Reply-To: <ZwNx-sKJJNDQ4sIC@pks.im>
From: Abraham Samuel <sammymore50@gmail.com>
Date: Mon, 7 Oct 2024 19:48:00 +0100
Message-ID: <CAO1n885jtQag_2gHkuVFggBH444vKCK2chuxfecvniuN7SMBMA@mail.gmail.com>
Subject: Re: [Outreachy]
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 6:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi Abraham,
>
> On Sun, Oct 06, 2024 at 10:57:26AM +0100, Abraham Samuel wrote:
> > Hi Philip,
>
> one note up front: we tend to not top-post on this mailing list. The
> reply to an email should either go below the quoted parts, or if you
> want to reply to multiple parts of the mail you can provide your answers
> inline like I do here.
>
> [snip]
> > Please kindly let me know the possibility of doing these microprojects.
> > Thanks
>
> All of the examples you picked seem valid. You do not require something
> like approval to work on those projects, but it would be nice to check
> that there are no concurrent threads on the Git mailing list that handle
> the same microprojects. I'm not aware of any though, so please feel free
> to pick any one of your proposals and work on it.
>
> Thanks!
>
> Patrick

Thank you very much Patrick, I appreciate your time. Please I hope I
am replying the correct way this time.
I have created a pull request on GitGitGadget, please can someone
kindly allow me. Here is the link to the pull request
https://github.com/gitgitgadget/git/pull/1811.
Thank you.
