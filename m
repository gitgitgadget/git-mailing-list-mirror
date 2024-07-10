Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC01EB2B
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638677; cv=none; b=JP0fLDG1F9rqXb7jXA6/qiQcxJwGQygzNOvbh23HRdN5N6HA07KyaIun8irIXJmDRuvMhoPqPzBUbEUKr7tMD/vD/ZANDtIhmyiM8zy9Wf/RljhBwVTYWY8ydrlNI7C8u0Gj7rGaX19d//9sgWn3213ZN7gl9dsYVOpI6SjrO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638677; c=relaxed/simple;
	bh=wwyOjqrQY522NqxdOWuwmYCDxyoC5TlenfGOe4iIdiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RROGrQ3XJVbgSM3KBqh59NYI1gct739tn4XMoBMVgvHi8dATXid+8KhUer2MBZGDP9dkp1gOkEBD1xw5qbjmXBnCbfwVaGcwSpTZWSKNQY/JgjQOtSAd7jsV5GZN3Tg4BjB2W6cSS9Fb/bLzWpoD5fJ+2Vsuki/vDQ5wWISLWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpeQjeor; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpeQjeor"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7036e383089so27036a34.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720638675; x=1721243475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwyOjqrQY522NqxdOWuwmYCDxyoC5TlenfGOe4iIdiI=;
        b=FpeQjeorf65dYL5ifPA33jq+H1CPJGkNhxBDH+IlL4H0I++VKlDu0ppTJoEIsuJkNC
         2igSCfyYASWdzQ+uP4R+KUq5TwHhT4JYf4AyS2hiD3s0ZKjK34Mzi9j7pw5ytw4U4tmP
         9Pran2tP2NSYOqWr6ymU5HKYwYeFOHx5sgfOlu1vA24EKFa4DiD/LwVz4ETbhysoxuGL
         SHKJyPwHO+SU2Xt5UUsNo53eB9cA6QqyWJ6Tp3ZBHERC4ipjlVu2K7MI4XrhrTeQy3kY
         0ulud/7pe3w8TdoEvtaJDsaL0vO+Pvvd2HOA7Krze4FJUCFoz4XkxGimPjGB5co/KaL4
         bd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638675; x=1721243475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwyOjqrQY522NqxdOWuwmYCDxyoC5TlenfGOe4iIdiI=;
        b=o7EZ6GeOkB8dsHa9PHJgs9ClSQTFerncC+09Qhq43axWN5hl2NYsXiadxblOXGNRMw
         pD5qDUqXB93CbIQdqc9Ao/jnu2TcSkciPs1IpJoABPca4n+GRXQy3SC/bqLrdFbZylfR
         4f1orSwWvLSTv0rITBhIEJo66Sh0UTgBpW+FPM4Odt5DxZjKv7v3bO+8g8OoccS+hOIY
         tohGmU/RkYRBA6CaJRwmvysyqyhN/Xei6XKK7ESokMli6Q6zXo4/DvjR5v7ITgX65tNC
         jEnG355AsCFf8EOKs4m8KPUSAV/XFqFHosqZR/GNfcyuOpjrBj7TZqmgUwVUPRo8i5yH
         CEUA==
X-Gm-Message-State: AOJu0Yx/CfmSrff1yzE5d8XljdFBJ80Ar4p+QknApPltw440alF6OW2X
	cAGqwdQJ84HMEwDXCkbS7P6fp1J9+uKG5RSzhoFu46qO1PqDrD93bCFbzdbezyzvuknEswGhIAa
	yDfISC8gdTVm0/ZPcU9r7j1JFw6cyR6l1UCIt
X-Google-Smtp-Source: AGHT+IHEq/eTfVnw9EgIkLt38RWRP8L6BBrH+fAVC7m+sdaURhKtwxY2m9ix2RP4rBiS9GMOw34jv2gIu/L2JOWBO1Q=
X-Received: by 2002:a05:6870:45a4:b0:25e:1817:e4a3 with SMTP id
 586e51a60fabf-25eaec16bc9mr5458524fac.40.1720638674765; Wed, 10 Jul 2024
 12:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
In-Reply-To: <20240709225042.2005233-1-emilyshaffer@google.com>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 10 Jul 2024 12:11:01 -0700
Message-ID: <CAO_smVjZ7DSPdL+KYCm2mQ=q55XbEH7Vu_jLxkAa5WTcD9rq8A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 3:50=E2=80=AFPM Emily Shaffer <emilyshaffer@google.c=
om> wrote:
> +* If you rely on some configuration or behavior, add a test for it. You =
may
> +find it easier to add a unit test ensuring the behavior you need than to=
 add an
> +integration test; either one works. Untested behavior is subject to brea=
kage at
> +any time.

Should we state that we reserve the right to reject these tests if
they would put what we feel is an excessive burden on the git
developers? i.e. a requirement to use C89 would be rejected
(obviously). a requirement to support 16-bit platforms would also be
rejected. I don't know that we need to list examples for what we'd
reject, they could be implied that we're likely to accept anything
else.

> +** Clearly label these tests as necessary for platform compatibility. Ad=
d them
> +to an isolated compatibility-related test suite, like a new t* file or u=
nit test
> +suite, so that they're easy to remove when compatibility is no longer re=
quired.
> +If the specific compatibility need is gated behind an issue with another
> +project, link to documentation of that issue (like a bug or email thread=
) to
> +make it easier to tell when that compatibility need goes away.

I think that we likely won't have the ability to investigate whether
it's _truly_ gone away ourselves, and there's no guarantee that the
person that added these tests will be able to vet it either (maybe
they've switched jobs, for example).

I think we should take a stance that may be considered hostile, but I
can't really think of a better one:
- there needs to be a regular (6 month? 12 month? no longer than 12
month surely...) reaffirmation by the interested party that this is
still a requirement for them. This comes in the form of updating a
date in the codebase, not just a message on the list. If this
reaffirmation does not happen, we are allowed to assume that this is
not needed anymore and remove the test that's binding us to supporting
that. We should probably go a step further and intentionally violate
the test condition, so that any builds done by the interested parties
break immediately (which should be caught by the other processes
documented here; if they don't break, then it was correct to remove
the restriction).
- _most_ of these restrictions should probably have a limited number
of reaffirmations? I feel like this needs to be handled on a
case-by-case basis, but I want us to be clear that just because we
accepted these restrictions in the past doesn't mean we will accept
them indefinitely.
- Just because there's a reaffirmation doesn't mean we're guaranteeing
we won't delete the test before the affirmation "expires". If there's
an urgent security need to do something, and it can't be done without
breaking this, we'll choose to break this test. If there's general
consensus to do something (adopt a new language standard version, for
example), there's no guarantee we'll wait until all the existing
affirmations expire.

The thinking here is that this test is imposing a restriction on the
git developers that we've agreed to take on as a favor: we are going
to restrict ourselves from doing X _for the time being_ not
necessarily because it'll break you, but because it's a bad experience
for the git developers to create a patch series that lands and then
gets backed out when the breakage on $non_standard_platform is
detected on seen/next/master.
