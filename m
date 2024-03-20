Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240303FB97
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945303; cv=none; b=WfhmUZc/iWxBssjeOyc21/uD/giMr8vjqcITITab0XAdG9TY/qHffZCHp87j/VoCdvD6mtiYaws06kPw2iU5TfuQA3Hf6syzSpGcpsBQMMIhPpuzA7j8N1ueMbT0vSv/SoW6S2Jtd3rj2gj7a/QeYDyWUtjlv/L73KWjd8htkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945303; c=relaxed/simple;
	bh=dNsQH6l8g5QYGNnLigc6ZRF8jYtOnjZaLGJlcWwZ9+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtoZvC7yLydbJrU3NB7YzFcZ8HzHcmJS9jiba1/x1tpvOMqplD04Dgu6kPtG8kbD1wt+jX+ZGxtoFnctoL9jSu4fo1FFE22n3yoXkS5Hin8eFcguP0qlywymL8tW5/og3FNARd3HfYcxD99eKSOO4tPlyys7IsTHBIkGgoD6sVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC5yTK41; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC5yTK41"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56a2bb1d84eso1786827a12.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710945300; x=1711550100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hsuKrM/Q+vr7r1EjF34U6tR1P7XGs8U0QFGtjgMEWXs=;
        b=WC5yTK417OGwkWUeirR1Htyx0z9VsKjxj2u1Ies9Ex3m7Ed/a/Xz7n5ajRTPVoLxnE
         MLkF1aSQXI/0nZD+jlDEYaLaXdLbMZ0/hqiE6XNfJjrQOtamUH5z8zG4JbBDAZNORwzs
         YgmuyDX2rDxtmIlOqDKoxq5ku5KKxFge10s8DUpY1u6DUIqnEouMk7slqUHyTvLwVQnq
         I9DWEpcchqlwiz6tYpOvvE/u6dNjuNbj+Fd6rNaysZWw2kH/UP93cgkbnk1L/jM+O8Vw
         UgFJV0LXIu5LbEYQHZWSKTDG7NaKC8lp3KXbZVttmulHfIpasOKstKZschl6m4njGta6
         BDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945300; x=1711550100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsuKrM/Q+vr7r1EjF34U6tR1P7XGs8U0QFGtjgMEWXs=;
        b=WZPLjJ26i4kv1Edx089tCadPOkd/9xoqp4fc08lHYdpK12F0AsT8tFeafIE/izJXlc
         Ti2z9t2jjV4ojE1JJNVe/L2rhuWWtCguzjHYKzXXsaJVGaB9yoq+2KrYWblC7Ec3l7JK
         TsPjkMZQSJ+2v0Cw+vMqFlnOD/0U4lTnSI6RDeIat5ng07wNQ4aXRbQiMbaC6RVP7fuU
         8rrit9fkbblmKt+N1K0w4gyDRv5WPJ4UwiEU+uLUsLiP9MLRqcRx+k5ksCSgVwE2yB1u
         nb3DP/HS+ThD+hMvYUFr3b70bqJ40e+QxQTAnPZzJQXpclRLb9Z/CMzuXJ1jYMWM3uKz
         xjcw==
X-Forwarded-Encrypted: i=1; AJvYcCVvVx6x5k3IjUgWL/sJhih6LMSN6Ydm/aExdPYw3IPPqfh5Y/rq0qNHUSLj+D9V8uNk6ljTcXTF8VrNyXdBaIqXyJpb
X-Gm-Message-State: AOJu0Yz/sYYhbAhAawthPfXh7G4p/0XppRYbHjAC1kpVUYzh4riVEvex
	xT9LUPePZE0eOiNrfZm1O4Lzeo5S0p4h/PS262RRd6dFOf5z6ttBhs2N79Os31vOZGgz5gUndmZ
	vMkllrkSTBPFnkJNy2GhgUck/4X+g3TS10G0=
X-Google-Smtp-Source: AGHT+IG1wwhz6iz8JXJQD+EmlZsj2vK5CsGrdzkY7xk76E4OBbw9dNTnSJRp/8cND9F1G4xrfF8Pb1YOJFT4Ld22XNc=
X-Received: by 2002:a50:8e19:0:b0:566:7769:11c with SMTP id
 25-20020a508e19000000b005667769011cmr5513046edw.19.1710945300270; Wed, 20 Mar
 2024 07:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309181828.45496-1-ignacio@iencinas.com> <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
 <xmqqa5mulycz.fsf@gitster.g> <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
 <20240320001934.GA903718@coredump.intra.peff.net> <CAPig+cT9QxRZhZyZV=Txt1VfqzDZX=gDbXvFg1nO=rjeMFaBeQ@mail.gmail.com>
 <CAPig+cS_hCOnAuwRd_dY5h37-wgHCk2tjS7asm2Dm_p=s41X3Q@mail.gmail.com>
In-Reply-To: <CAPig+cS_hCOnAuwRd_dY5h37-wgHCk2tjS7asm2Dm_p=s41X3Q@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 20 Mar 2024 07:34:48 -0700
Message-ID: <CAPx1GvcVZgsU+WHecLd8PWo_MN+wJj6wQ-G5nxYvWnOUOhfQng@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	rsbecker@nexbridge.com, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

The suggestion for having `git var` list GIT_HOSTNAME gave me
an idea: perhaps instead of, or in addition to, a `hostname`
condition in the `includeif` code, we could:

 * have an `includeif:env:...` condition that tests an env
   variable against a pattern; and/or
 * use $GIT_HOSTNAME as the variable.

We'd then set `GIT_HOSTNAME` to the gethostname() result *unless*
it's already set.

This gives users much more flexibility, because:

 * they can use the hostname and/or arbitrary-env-var condition;
 * they can then *set* GIT_HOSTNAME to the short or full
   hostname at their discretion if the default is not suitable
   for some reason; and of course
 * they can, as noted, use `git var` to find the default setting.

Chris
