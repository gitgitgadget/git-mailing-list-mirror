Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551452D948A
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566046; cv=none; b=jGadlA8khIHCO+SZ4CxfIXmVBlVqX23CC7WEeZzPwpqr8GF1jwuaC38qnJTrg7gC3PGUlvJnTxhs0GXcx6sCxzEwpXwv6xh6IKxr3hWN/5slh++zmFxytP50ExVx16GhjuJK23R//HmPu+qifdkOwDnd9ElOoQ925PgpXdk21ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566046; c=relaxed/simple;
	bh=1KITZd6ZXARWx9MObdv3VEHhQXdV/hNIW2us+Bm3G+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFJhHPUW5yV/irjOqs/wQ1DR4mPv2WH7zooarSvnJzANnFki4QtTaClIjVGV9PGdtjd9j24CQuGI+Bf8fBzQT/gHmeThVi7cNkl+Ay+7AQ1vs1PE07q4UhqbBeTfE6fy8Nu+L4S3dQmkeqejm6ooi5Bc4dVNQ7SECaP0r38xV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vul2nNSZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vul2nNSZ"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36bf096b092so12512221fa.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758566042; x=1759170842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KITZd6ZXARWx9MObdv3VEHhQXdV/hNIW2us+Bm3G+0=;
        b=Vul2nNSZv3fgbl6KlPvZBkybrtBTeNv8B5EsaUrk0MZU/E/epfm4WR8/qGwpO4LkmL
         6fWsElnsdu7zSZlnhNwITGQoq7wIwDiNPvqn9UaANdUL8HG1T2cAdPFnKWpjfQmRfxsX
         MZNljvISZ8O8zkvwjpnPJV5wj6cSUO7uk5GH1SkH6U8GHIhXSRVYDpg6BXeOqTCu46da
         sL4vqWoO68G5HK0SYH8+MT0EvqQcV3NQIupEY3vJM3MbjcASIHaDkijkfFbM1+f4XSi8
         qQWi3VdmqofMKCEp/Tp6iZjm1PepoyylRb1UTy9ajD2DHHFKWcxcDsMqCJDEQkR6Z+VD
         SCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758566042; x=1759170842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KITZd6ZXARWx9MObdv3VEHhQXdV/hNIW2us+Bm3G+0=;
        b=FkFqShN+pB4WEgI8Hmr7yPvBDdXIUgQhDq4DFuv0nv3uWCoNAvAz0s2TLU4+mFz+ic
         q1jeKhrPq+q/PzQJJmnnWNfcboeB4BYmKWrhRObzjFAqf+jkrtHI2hlwrzrT6fUUKZKH
         7BeR+QRDBWbgtmlOUcwyq/OenOa3QaprI/hWKwHwfE2xa05uxNgb5b5Br2rbmuGqCWpu
         5IwNnow3SDT/pOhSHJe5J4gQm10o11ulXD/wX+fEChvOj1+lwRSu9xz+dFQoN/4L6VPW
         GzkgGZoChAxNL+QBOl3L+syK0/UEuZ3UDl2IvkinlV3l5yUUe+XiVZEn4PgGFDCf5614
         TlXg==
X-Forwarded-Encrypted: i=1; AJvYcCWnhDjRoFlQIixMJ2khL/eSw1egtd8bm7pSLlGxP7zPsmLlA4r/prfaK3joxJbFctqjRQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTgLOyqbbp0eWsU3aNuBOqLla5YBUVtNha/FLtjvJjswqGrOs
	RC2Uv3UfPZFu7Yws8Y1Sh6ZOEx7ce6v/M4j52lCj3pLX0YdmpuWkEvo8wjNVZs7doKXaZWiSajc
	Zm5BHZ0GuKBY78gNE5FNjiRR1G82LmeU=
X-Gm-Gg: ASbGncstAsixppwJmTvvLMPhLkKIpYF8p8b7YnlIszr5YcO5wRmsiFtwtL4spSjzI0D
	ZiUDCtz80ZgtLMhA4BscBrwDr51t6SI+oWKTfjNvY+o62oArZExu09UCntb71fFhc4hsJxLCco2
	2CHY2z+VytvcWUuy2f2XPFXBkVw7ZlcCeHzN65ShQ0cBjQ8fDFZm5Odze2uRidfZUITY9pFK/Vk
	puDgDcG
X-Google-Smtp-Source: AGHT+IHxQfZWokwZhs3JxaV04m5gxk/gUHjnTXNBHHCZmmm75HJb+FTVoJgcLp/4mm1FAlraVGxBb39YE12TuXo9biQ=
X-Received: by 2002:a2e:be11:0:b0:350:b715:51f1 with SMTP id
 38308e7fff4ca-3641c63392bmr43321591fa.39.1758566042163; Mon, 22 Sep 2025
 11:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <aMpODEpyaaVhFMO0@pks.im>
 <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
 <aNFIozagGc0MoseL@pks.im> <CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
 <xmqqikhav3i0.fsf@gitster.g> <CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
 <CAH=ZcbC_ecyPeLS_0DfN3+w9RTqcrt6Je08RPXqb6pJVGaPjuw@mail.gmail.com> <xmqqqzvytkqi.fsf@gitster.g>
In-Reply-To: <xmqqqzvytkqi.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 12:33:50 -0600
X-Gm-Features: AS18NWASc4Y7zJ95sJ9UbvG5D_OIFaBVll5WAid-W_gF6eHpBpHktpdHWJiCsbk
Message-ID: <CAH=ZcbA5hAM9kmO410KzVW7RXWWiwX2oJk6GGPP+6oVYatRVOw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > I just tried this in Rust and it turns out you actually can use u16 as
> > a struct field name. My bad. I think that's a bad idea and should be
> > discouraged though.
>
> That's a great news.
>
> It means we do not have to worry about existing variables and
> structure member names at all while working with cbindgen.

You've convinced me that we shouldn't use Rust type names in C. I've
already refactored my code to use [ui]int(8|16|32|64)_t in part 2 of
my xdiff cleanup.
