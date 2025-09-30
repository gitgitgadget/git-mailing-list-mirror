Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D62145B16
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260953; cv=none; b=cEE7L4zQ8aW9c7MLmwZ8wJ9M1s5VlEyjgYCZyD+wVgo4VrKwLHL9bwSis7c1T69HyTktS5b1YFYmtpOF1NMicr//QJIIjh6P2JtkcWKLtNNZsNAMcd0ocuxp1RWzNo/CIHeCo1gNj5YP8fSrh3lvVCnPchbhMp/SI1p+cRc7Xj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260953; c=relaxed/simple;
	bh=hDcnu0XJVoZIg9+Kv/Qjn+E7q9VplkMttfyuB5XHWDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkBIF3qNu5Iy6YPBbrBdq+0OJz6yXnnfNqYh85qX+C9nUsdWhXcmxkN3ELcojl7ifUmYWBHMzvwbcCFZnPZnFOnMfBOGv4JCBkA/frcHCwAgtO7KOb3gVkv/MeZKl4QbOt9pPrVyv8rsAflC073fLhfKMlq3OxfVn4qSd8po6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4AdDfsg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4AdDfsg"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-365df96398bso1718731fa.0
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759260949; x=1759865749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDcnu0XJVoZIg9+Kv/Qjn+E7q9VplkMttfyuB5XHWDc=;
        b=V4AdDfsgB2vyuNt6snxzCQf+Gvq4+RSI1jTFlqHY/1QnhGGCwfpSD+Z82Usz30VD1j
         YXC/s0vHuz8EC27poeXpnbSwQdBLgeqcAUA0SB4lVbtHQClXc2dopSQYwbA7d+ho3JKH
         zZMeVwoO4L0TvOuH6YOLvhsBnsbboEZ6n4FGj1x2lLdw56+tRfEavDm8cCQnqKkwAAb9
         HgqgbDhZvqu4OwN7gswSJdipM4y/g5nz/k3VwZHAQ+xb52FAAMePzjB1e6netJSDdKfG
         L7rUXpArVSBnIaSh95ZAakQYjYIKutTK8coVSTs1NSOJCFQNJoVdh6+KzAniIF3Yi9dE
         FGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260949; x=1759865749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDcnu0XJVoZIg9+Kv/Qjn+E7q9VplkMttfyuB5XHWDc=;
        b=bOrDeeNhcFg0XEKAQO046I7OrhOFURvzyslDuL4qkaEW8+V0JEabXtPeEZrJ0OiFzT
         l1OCtcw0ZLgsKJyhC35wi1A1+mYuQz6k4RF3jRY5DzxjNx/Gf7dBJdClF4iBvTmG1Tit
         AoqBQP7Vd4DZuhqQCL2ZuJKQ9sijTsg02jJ1cdFutTOl3gGf4i8C8nXnJBZCw4u+MQq/
         JWNW+zkZxfD5eHuzZJMkaXSHXmJ5o7wNM4H5ILQG4ItllWyLTSnnkrDx+ylzR+x8guGt
         aU9eFVSmYdJEjwsZn3RFjFEBQQrVfLLsyaw5AWtSkaqtxy3jT1N4Gp0OLCeb77S5lvSW
         1udw==
X-Forwarded-Encrypted: i=1; AJvYcCWTml2oQT2CAG5nfHiCGXAdOBOPb7Mh+oKe8jl7cOP3Wl/egOfW0rFEQtJRKWVuoenRHnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XyPGtwIf+OBgGdIZcgHJTcEt4at/ETj9CYlxrAtAO0DVwlgf
	ejTp3B5bQYbCllmpgg8a8KGggsiEaYOLMf1WAuFT0ituVgTsUltUGPArr5TDupRbpm3Z4K5LIAc
	xMrHhLKitg3MUhCZP7jv8HvNBy6bnwto=
X-Gm-Gg: ASbGnctUwrP8/GX77dQCSjqL5djszB86sXaRXj3q3wVJUvEkhfnFTyj2D59G2/WIHRv
	IFHAg1NR0hh9MjM20xh1MA6Sm3z2efHWXvFr9RCj6+Gysm0HK1dbPalIWuwLPF3nq9ToRjDC/18
	NUUZxhWdcMqTsqBV28sl2Tlz+67uqP0BT1b+gNng/waNt4MSN9me2GIqAkk2EduwnJCHw/m24jm
	TgEyVVGbR2rzIGNzrVs3QTfp4GaRa82
X-Google-Smtp-Source: AGHT+IGEpVQ0DVSh6HxDr7L02DFvXil/fsGJpcEhdDI7hEWEFtlvzR/0GNHc2ZAz3MDhV5uL142GHE1j2IUONBf5dCI=
X-Received: by 2002:a2e:b88a:0:b0:337:e2c3:c080 with SMTP id
 38308e7fff4ca-373a6793e3fmr3314211fa.16.1759260948962; Tue, 30 Sep 2025
 12:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <7d3a7e617c68cba19e6ea1195bd6d753a5795a4d.1758662670.git.gitgitgadget@gmail.com>
 <db85429d-2c89-43ec-a92e-96ad8d0049ce@app.fastmail.com>
In-Reply-To: <db85429d-2c89-43ec-a92e-96ad8d0049ce@app.fastmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 30 Sep 2025 13:35:37 -0600
X-Gm-Features: AS18NWAo2ZKrYCxfmS5TKRl6ihihYWdVeVSzNiLPkAgt_jxI_sE21VjN-_x7mO8
Message-ID: <CAH=ZcbDjFh0wtWyU_1x-GCgzt3a0xUye+RU-LY-9rMBtVoSnTA@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] xdiff: delete superfluous function xdl_get_rec()
 in xemit
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 7:31=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> > When xrecord_t was a linked list, and recs didn't exist, I assume this
> > function walked the list until it found the right record. Accessing
> > a contiguous array is so trival that this function is now superfluous.
>
> s/trival/trivial/

I think that other than this typo this patch series is ready to be
merged in. I would prefer that Junio fix this typo, so I don't spam
the mailing list with such a small change.
