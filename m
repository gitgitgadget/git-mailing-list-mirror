Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077A1C3C1A
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710195; cv=none; b=myMsO4KEF2xrwJ1kNfqUEm1PGhD7s1J229GMvEaxRHudQpHysRZSuL3474XAHl417fXztW4PENHSBRgwrqBL62ltNrdBEesf1z7Dc+K1AvE8SQ6cL+yxXbXrdfkWhqiFSC7McxaIPgBgWMB3h+tRulCcxYqhwxRXJMa6QPYJ7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710195; c=relaxed/simple;
	bh=wUT89IB92fa+1SvAbfKuCZ4e/HXRMvfsSrEGWyZAkK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGQUIvW0mI3ITn6GOOfsKkk8UxSdJUFaGL4fs8CYxboVOn9FxTxyYQ7HEIV8laqWKcOBkGo6ZveELS47beJHUPvXUEK6+BzLhkncQY0Y1zdA0JeNf8tMjJ/sSVED1pnWAVSi2sQpIAS0j2/mvy5iC/Rz8TwxGOuxQs3vQtN4JCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+5+xZCF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+5+xZCF"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so3503051a12.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 01:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737710192; x=1738314992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUT89IB92fa+1SvAbfKuCZ4e/HXRMvfsSrEGWyZAkK4=;
        b=d+5+xZCFDBQrR6Yeu6m930ZywQzcr9K6Radg7/UfVOGBXiLpjDeMTo2lnBaPcMIWrQ
         C16W5tuyoUoSbIQ3QcUm78ArO4bM28MVcadDSQzIGQCouy9p9wRfjgOdoDTJU/kIHI1Z
         Hx63ia9ZWWPKYk5dzPiXr1c2pwF6bW2BJn687BnsznAaLeYdCpeZxbUC+DiF952HRP8H
         bhNls5geHN423yh0ky6rA6H31K4nNjntfq/dTYEZqzueYn3XRaY+LFeOlKnTBHP7qgEM
         I/DmLOwvevs12GPMVua8uQ25+K0CFDMICdv3YhosL+cJRzgGEesC8p0zBVwcJvHgIATP
         JDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737710192; x=1738314992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUT89IB92fa+1SvAbfKuCZ4e/HXRMvfsSrEGWyZAkK4=;
        b=jwI7aDNW74hkYV4wSLRMDDSx+PU0jkUgb0ADxf43X0I7vMXGRyfRNfzz3m977yrvIX
         E35SI4v7YM1B7losWZHR2A5+MVHz/EcfQ7wNJyu/UntwvyXVfNTUvhJ/FlXGDUeRvkuz
         kBqvY3twRD3C5OSvU1w4IHuIi2sRPv/keVjq+kBVxoKKOKAClxxo3QDUYF2uI5FUJcUG
         5/c/wI3PuyR0qUguLNBuQ+eBX0u9tK0ZXDZa83a+AFZu5Dm31oKM2sCTJCqLM4hvoy3j
         kz8Wn6Il3liyENOm8jEPpKTRD5FVJD1TmDrRd7nMKeEhFqLG4A3C++e7zcktVwrs0AnP
         9evQ==
X-Gm-Message-State: AOJu0Yz3duUNglA8Bgh8XkwK6MCJaTj/gCf6m8JICw0F1rpwk2Zmt3Je
	UCl1wJPQAbEcJbgyckZUmtS0xoyjTS1nwTEHn1n2rYn74aqUh8b+QZz+cTmDwaxh7md8ILhN9b4
	plDf8Hk7FbU5fSqrF4x0psvegoHs=
X-Gm-Gg: ASbGnctK0ueUAdMdEadI+3AHb9QILQZNHj5lvPyz88IQVNz5pADw30Ju62QNBiJFnAj
	5EzjlI0dWZ+eBrUONxNwTOrKADyNtU5wqEn7nkIqQvqh8rL+Bc6yo9PXCbc34/nr4
X-Google-Smtp-Source: AGHT+IFKrzQlyhMLpp18STNRfqAEG1Px3UtFHPeik36rj7255TSz4ZH+EC9xY6QJO+ZKkAQNAaHR+PEpxihEHvpIV40=
X-Received: by 2002:a50:d58c:0:b0:5d3:e8d1:a46 with SMTP id
 4fb4d7f45d1cf-5db7db12cdamr21617698a12.30.1737710191944; Fri, 24 Jan 2025
 01:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im> <20250110-b4-pks-ci-fixes-v4-2-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-2-6e4613446080@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Jan 2025 10:16:19 +0100
X-Gm-Features: AWEUYZkLt1Ss5ekH7j5poBryg6TQIEt8jKqxlcuS5a_CVd6dRSG_hDiHppQiNUk
Message-ID: <CAP8UFD1NX4C2jpbcb=CtX6w5qj3tZPchQ+bdHCX4x9fFqyBrBQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] t7422: fix flaky test caused by buffered stdout
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 12:32=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:

> Fix the issue by generating a couple thousand nested submodules and
> matching on the first nested submodule. This ensures that the recursive
> git-submodule(1) process completely fills its stdout buffer,

The patch looks great to me and I like the previous discussion with
Peff about it. I just want to say that, after reading the discussion
and then this paragraph, I wondered if it would have been possible to
instead have a `test-tool submodule` helper that would behave the same
as `git submodule` except that it would call setvbuf() to reduce the
size of the stdout buffer. This might have allowed a test that didn't
need 2000 nested submodules, and thus might have been faster. No need
to change anything though.

> which makes
> subsequent writes block until the downstream consumer of the pipe either
> reads more or closes it.
