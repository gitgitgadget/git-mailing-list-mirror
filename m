Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3152741BC
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432708; cv=none; b=s5V4hCI2JF35i/qX+I9toO/z5x6pNnmgnO2Oj9l0ljUAXsliOgioCkjJicB5iYdlCbetB3S52IfcPdobg4YFbAJ1K1Mw0h1vIPTUEZSKzpSpfK1cjUzOP/r/58O17OGzua0zcq59wCtb/s7gTyyx3HP+depbWHp0YRY3aPh5TTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432708; c=relaxed/simple;
	bh=EKBJ67M2HtpsShtNCTWfIOIy2R0SP9ImnAvd4HfBhNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=he51PyYWsPtwuDaix24wvOncU+LevHDa3zy29HAPOrRLoFYz/2hBd2gAhgKyC2srmsULoT53j7lo2EEo+TJbLu+pYpcKfifOa9emv91AHg0ui4dIPBelehoZQLc5yADWlnEBx32yZtOtrgpL9hVRriVdv5ss8ZS5+kcofeQwFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPP6F6BG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPP6F6BG"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-367ce660b61so12504181fa.1
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759432705; x=1760037505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKBJ67M2HtpsShtNCTWfIOIy2R0SP9ImnAvd4HfBhNw=;
        b=MPP6F6BGaQG3tiLKxpnJ/6n1hb6AdbUjX4hqB5S89Gq/iz62fPUrDC1aCWDLvyUX+K
         BB6gjK75PGDICH1acxGBmhrALBToRIUuz8hiD/hIq0F2DTzlI54MRdfx74YY5LG6XNDJ
         h/xNcYGMiTDufEphAb+lVuGunesbLHXDYUBvsgKRNJr0zpUuvn2JoDhFEnUFtBWgg8qy
         Lort307X6vUdWbtF53x3pz5VpjnBzGqTvvkYYmqM7XBtfepS+/Syo65Q7PLsjjUqUMm/
         tQbLe/H3+LgWV3r6wgVSWOqtc7ujjj9p2ARdsm10Qh/tXndzB6Q8r2y2MvvLpbEb1yZI
         n8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432705; x=1760037505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKBJ67M2HtpsShtNCTWfIOIy2R0SP9ImnAvd4HfBhNw=;
        b=Nc7yByDYvAEZ9RHEYqQ8cpOQjb65MDerTnLFHc2xTDjm2wXrDGcIf5zH+8Ldiyi+FQ
         3UCFLAsKaHtptW9dFsKOXoadRsR4JV4GLtwwFTBTBTpD0zvBEMII51gaYqRvSqGN4Plf
         xFDuCrKPSHZ5j1V2QJhGVnDD/5xomI++AqeZ8d6UGuCzlvna5hTMWWXKLPeRvFyMCHEH
         N4BE9o75IAbM5ZCUDk/JZv54dL5iOCKjYiDGncm9lDstQvsJJink934zAIA5wXqpVF37
         //zYwFXtbW58nYbafR1uOEaQFk1TQusebCiDEFzK8UjLBzTziCSDZ/CnaJihK7tj1sUQ
         TvJg==
X-Forwarded-Encrypted: i=1; AJvYcCUnr4RU5EWEr9bicYZ0p2ByGP9kYVA/Wk1gP8Lnqe41FcxukAHsLo1zb2Iyc+YBPL7vh2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEsa8AVD0vjJyuSg46L/ayBlxse+wQ8s2aIWmvNd4Ox2qlw+W
	avNWDv1r5aGM9y9OeyK87ENwnB5bwhrgD3AIHVx0OwFRkC0B7L2xHGd2IbHdnVc1f2ABFvppCZL
	rQkOY5pPmNvhJwE+sfsXRzyZhCN5fWpk=
X-Gm-Gg: ASbGnct4SnwxiQvzRlnmwDaxAWOHgxGsWwZSy/qQbnI9gEYGyWSCuilcdBHKts7hsce
	ldRwTcLrdhRUEwNaSjrmDofq3ph8jCMAqKOzCbOSiay0VDE7ii9cP0sA7JlgBCFPYQ2Fv5ZzfFj
	HCf1xS4aEIVE+uYf4SRdn8t4Xg583QLRsoeDtKy/Miy9FYd2/vTWBpufycW7BkHY6SvFTbr0YzG
	R5Nh9z/Fu8AbURQMjimrtLoVVUTw39E
X-Google-Smtp-Source: AGHT+IET6dPbXtLpaPGKrlN78EKFS2JnknF2/aTAcwc61QoHKqStm3PErrnLobGyhzr5QdrrbP7X/hx+EKtjFASwwU0=
X-Received: by 2002:a2e:bc8c:0:b0:337:e5fc:d2d with SMTP id
 38308e7fff4ca-374c37eb3f8mr795051fa.24.1759432704487; Thu, 02 Oct 2025
 12:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
 <aN4R51_j2ieF-sjy@pks.im> <xmqq1pnlzayy.fsf@gitster.g> <aN6bL07N8Qz6USTf@pks.im>
 <CAH=ZcbBQ2abBS5n=_OZ=qY_K=on9sBa_sK2HbbBzbwa41gWFQg@mail.gmail.com> <xmqqy0ptuo0i.fsf@gitster.g>
In-Reply-To: <xmqqy0ptuo0i.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 2 Oct 2025 13:18:12 -0600
X-Gm-Features: AS18NWDfsdTmY7klFEbxz1WX67IhFCs4fo4vrLWsCfQB8koS9-u5Cezu9-eOMpI
Message-ID: <CAH=ZcbB9hZfnVUgSc00zBWzqbAYeU+UxrrbJsnymqVtM-Xw6Pw@mail.gmail.com>
Subject: Re: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> > I will go with your preference Junio. Do you prefer your way or Patrick=
's way?
>
> With step [1/3] shuffling lines around, the advantage of keeping
> XDIFF_OBJS and REFTABLE_OBJS to make the result merge-friendly
> disappeared, so I am perfectly fine to throw everything into
> LIB_OBJS.

Sounds good. I'll do that in my next version.
