Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D96213EFB
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418410; cv=none; b=Knu0oprahyD647sgKAdxiWcYgtC72CfYFYNNWVWj9OdhAzrpe2WLvDDVFNQIUAhuvNDjIYHaDsrY6oIdCdyx864PS9sDNJSumqdr0JZ9JF3FoVstyF2zli2PgCMv5H8lhDo1fc+YO8ynFNW4hi2ZjiMBaD8mqHbhLxy+op/5Db8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418410; c=relaxed/simple;
	bh=BGnayJjWk0BfFMCZ7GLFGNZMm6xy0qIGufDt9RDs4o0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PuX1rQSFHJsyfMz4xg58QhGZuC1FSOq3ggZfUAub2XDgO0SIsCcJEDTcaFELsgwhnN/zVJzmotq73wNpmxIDPISQmkzh8cuPCT1oB7mAKjUz66faOekw/RZrXS/VyvNDYWROrlXMmQw1KB9aRHx5q3jXm8461O3qxmALOuVdntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lioMEFsV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lioMEFsV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso53616585e9.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728418407; x=1729023207; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGnayJjWk0BfFMCZ7GLFGNZMm6xy0qIGufDt9RDs4o0=;
        b=lioMEFsVqxRy9XvUeAImduDCtrVZN57hAerabyVjd7F2fpyug4k71w1AiFOYAdJuPd
         qb7kwMmCIjRfnTspM0Z7rAg/DoC/sSnnKOB3KHonQCTI7zxqGDmWd5MT9OZJwaZEyRq6
         VnCnCpdJat4oZ0/lungCtKVfM7w8b4ciJeV3Q9F/Hh7iJl+bC6x+kHLxm8v3SuWA8PjW
         US/cib6r+y+JhNYr0LaeaSZ/JXMFJ/N4mvf4v2QaLI4pjXTTsCjOvrTFuwU7VyHWyZYV
         tH45RcJbiiZTZiBu0RHfJWm4qNRtIP91DbTElTmmieFFGktxK/2x2CGA3fdKVArVMOIS
         FbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728418407; x=1729023207;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGnayJjWk0BfFMCZ7GLFGNZMm6xy0qIGufDt9RDs4o0=;
        b=eSlE0eEzPEZV2qA6QK7XidbIxKiLITAPUrlxykEd8YwYDnkENdx8qtob8UG0wp4tUO
         vH47nf7lm3k/BupEYCxE2YAiIQx++ji60jLENcGkBUjPMGY1gZ0WlvcLh3VY/5iKVz9/
         MScBknhduRTsRw7SIQKrEqKKLOPWQCqOkrS98rr4JYmLeTB1blF+ALeLm+VMMjXbwAeI
         C7rQ7F9r26nZLfUFX3KBt+q49KoCZNSYjUaGyN/0o4/f6/Ydbi0jS48OjEcCiFbLff2L
         xLwK5ubQalhQ0WX0DZwLmQF+UhoW/obciIqOrOrCsjDuh1pjMfgZtSDiA6vNoHc3el5z
         pFxw==
X-Gm-Message-State: AOJu0YxxS9HwqeEjBa/cC10WgwdLToxMNjaItYG2eOHc5TiiRI5Xn5tC
	cxYqlO4gIaJc+wJTi8Rsqv03trTnll2EFA6ubn8Gnk1GlI9ldgS6XQUjCg==
X-Google-Smtp-Source: AGHT+IFph7HBEPX8POdfsy07q8n6BCMACDFHtnACCb/iQxLts+CO8yiw65axX+rjo8ac7LsNdfZtTA==
X-Received: by 2002:a05:600c:1d8c:b0:42c:b2fa:1c15 with SMTP id 5b1f17b1804b1-42f85abe372mr104188045e9.15.1728418406976;
        Tue, 08 Oct 2024 13:13:26 -0700 (PDT)
Received: from smtpclient.apple ([2a00:23c7:890d:5f01:2cbf:b5f5:42f:9d0e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89eaabc5sm118795005e9.27.2024.10.08.13.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 13:13:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Interest in a Git meetup in Bay Area, California?
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
Date: Tue, 8 Oct 2024 21:13:16 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 Emily Shaffer <nasamuffin@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50C75377-2AD5-4DDE-980F-21C5D0425008@gmail.com>
References: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
To: Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On 8 Oct 2024, at 18:09, Emily Shaffer <nasamuffin@google.com> wrote:
>=20
> After seeing Berlin have a meetup recently[1], I wonder if we have
> enough critical mass for a similar meetup in Silicon Valley. I know of
> my own team and one or two other contributors in the Bay, but since
> there are so many developers here, surely there must be more?
>=20
> Please respond (directly to me is fine, if you don't want the whole
> world to know your location) with answers to the following, iff you
> are in or near the Bay Area and interested to meet.

We (GerritForge) are based in Sunnyvale, CA, and would be interested.
Currently, we host the GerritMeets once a month (see =
https://www.meetup.com/gerritmeets/), and we often talk about Git =
topics.

Gerrit is 100% based on Git for everything, including reviews and all =
meta-data.
Not a surprise, therefore, that 90% of the Gerrit topics are actually =
Git topics.

> * Which part of the Bay is your preference? (San Francisco / East Bay
> / South Bay / Peninsula / other)

San Francisco is always a bit far to reach if you don=E2=80=99t live in =
the city.

Anywhere around Mountain View / Sunnyvale / Cupertino / San Jose would =
be best for us.

> * Which days of the week/time of the day are you most available? (e.g.
> weekdays after 6pm, weekend mornings, only Thursdays coinciding with
> the crescent waning moon)
>=20
> * If you are interested in helping to organize such a meetup, please
> indicate this.

Dani typically organises the GerritMeets; I=E2=80=99m sure he would be =
happy to help with the Git meetups as well :-)

Luca.=
