Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C955C08
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939709; cv=none; b=nzEwSMbAZt+7snbTHrQlMYImQl179VHZzaMLDP/n2FSmF47nxhj0r/PGotUks7l6x5M39oWbclsFHNOzag9mzn2cmOvA9JzZD74zeE/XvdF8NOyYw3NH1TADJwjssLR9s/x62ubVxvMNVdbo0zYUFTNC6swhwP2ekNHyuiBV0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939709; c=relaxed/simple;
	bh=7sMLX4/h59IY2jJBXD15+LvWBAWc8boFU7Cmat36Gv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOy/3Pyc09DisnwYJG5da+K6Nnpbts/2TGqnxV/l0JigcbvdLAFeTd9RZlylFwzKBJY90qOPmrumqVoMVFKIuPCh7ochRGWjBaGMGY5+eWUfm/xqgKA1+LkOGemDmp5LGVhyPXeR3FTKWdg25h/pctkRN8VYpYuev/8hu/1O6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIDnbEjp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIDnbEjp"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e552eff09so289752266b.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 01:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708939706; x=1709544506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAa7RLzdYf5XhISxCwFVo3iBBT8rU+WNUGQyzWtDPW0=;
        b=LIDnbEjpj1LM0EcXGjgoNFKWOVgpbZDg4rHSfG1UsxjU/tS0Hlvl0cze/XM138BkLE
         kwCIUsLP1HtELPXtsnhk4AhbbA6NuTXVEeGMEj1TUqNeigzhGB4e0Uoekoj+i4o0+tfQ
         /uoODt4I3W3kzkVF0VxSCtTKm+GjJHAWKI4bsclQNXMwpC/iIx+fXjE38XyKHee6roGp
         X5lIqc9RMzcHhQIN+NG6swrumKd4eX6Mnjh11UGC64hm75qtX75pFhwEIcNSXNDiaiNi
         yDmqBPDSuArPdUUk1Yu+ruUtHxK3ld0AvtdfK3LQiU/J2IPZ5BCmhstuQYodzHnlzoWi
         3Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939706; x=1709544506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAa7RLzdYf5XhISxCwFVo3iBBT8rU+WNUGQyzWtDPW0=;
        b=gSvTS0MneIJvZUOphau+z4Z8NESvFvxsu7NIId6Y3HmjMWyYuEjtDcXOdlxS35lvYI
         wKrDAmFpkyy7dMr+PKgOhjrVJB+QzSJT/AU7Eyfi2viJ35nGSxj9I244kKu0dGsaAVtK
         UaAfsKF2ORRA53RK3wcLAKnCi8+crKHw1jNS5bYDtk5SWVRpthVRcjfySeCQLtJu1AEq
         4zgEI06z/mlm9O5RR3EIzgHg8PYjLsqElqUvWwQP7NIyr0i2gi/D4aI3pFx+urvVKOyv
         VdlWgJ7nakEpKxlyFWzZ0xIGVH3N6u71C4ND4grNLL24YFYrje3g5tryisz96VBwT20g
         mgMw==
X-Gm-Message-State: AOJu0Yzgpx2S8B44/OlzUyxejExXvOI0o2zIxcjeYoUdKI6W8J7LLT/a
	VunhebhXfFv3pMTtWUPBUk2JAeXBl95AjWJYPMgdjhgc6V3s6TUcIBVy3IJ50jWPsgsisdDIfJe
	7Cst7wCqyfPNgKZSthnQv92DMYulHEFi1
X-Google-Smtp-Source: AGHT+IEbPz7ym/v5fWViSkG+JPvfgs3fm/hIz9QaWBvieaq2ICex++I/AKb58V7zwln61IpiPXeCkOTJHlcLqJY3QeY=
X-Received: by 2002:a17:906:4c53:b0:a3f:a6c6:25b5 with SMTP id
 d19-20020a1709064c5300b00a3fa6c625b5mr4389099ejw.69.1708939705987; Mon, 26
 Feb 2024 01:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225112722.89221-1-l.s.r@web.de> <20240225112722.89221-4-l.s.r@web.de>
In-Reply-To: <20240225112722.89221-4-l.s.r@web.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 Feb 2024 10:28:14 +0100
Message-ID: <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 12:27=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
>
> Simplify TEST_CHAR_CLASS by using TEST for each character separately.
> This increases the number of tests to 3598,

Does this mean that when all the tests pass there will be 3598 lines
of output on the terminal instead of 14 before this patch?

If that's the case, I don't like this.

> but avoids the need for
> using internal functions and test_msg() for custom messages.  The
> resulting macro has minimal test setup overhead.

Yeah, the code looks definitely cleaner, but a clean output is important to=
o.

Thanks!
