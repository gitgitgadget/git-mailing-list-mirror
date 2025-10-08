Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8D4A01
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908638; cv=none; b=tPWb0KnAo81jDeIq+aX7hxmSaiawwBGY9nqMAuhO4/7cs87B/x8nOS/EdqcLUGqKs/vk8u++UhWggNsIawW6uBaX9xzTybJd5QyaCSBW6j+w7DpVfO1EdAbP7dTO+XkLXKKY31eWN/hiEeg0Dr0FAVgC3IEKgjEbpWnF1kb47Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908638; c=relaxed/simple;
	bh=BJVlKN7kWM6CPxehVnk+404JD8/tXRM1UW6JCXcdilQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iub7o6tzQSQH0XPGp77lFWbsyYyLOO7WPAuhHX+g7j/P/5JXUQsCyT4wOjlhfP64G8EGaW5IHDS/sdBNGuhTNvmd1R6lhT7cAskKr5YVhmXpkbcp6J0rV9OmjvaIlFv130CLo2fU6VbUu6rt2fvZ4+UOMGcBrPY7LvXvjszYwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3yF4vg4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3yF4vg4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso13182296a12.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908635; x=1760513435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhmh9xOKafQUoGVqeyv6Ra2NuY+LTVWh2pVU6xmbCFI=;
        b=X3yF4vg4GsKqJOd3+9IjlJroIqVps66kSuaS1LviG1UbEve3t7NI8cP0qQ8RaQMopw
         +AzKdyl9M6sYbRUsOojKKcLNlOim06vmQaKlkpa9dvmVvmPMydVKdnXpqmPGoVM3HaM6
         FYwo1Mm8zF7y90amSxqOH5jVOviXIb7nr9NA20M4Rb83HIvaoOv3FThrBscPBYDJmR4n
         UTgWKpEereNlYP8/MoN8f1eogHQhSoi/2aqie6r+E670e6aZ7vCJx7/CNWa2yYw+rfTS
         WudFFrH7rzr1wUsiQs0Fn6Eb71t7PkXcpijB/CZJJ7khTen8CqNWsSu8MTPE6EkMk0KG
         2igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908635; x=1760513435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhmh9xOKafQUoGVqeyv6Ra2NuY+LTVWh2pVU6xmbCFI=;
        b=BW0LyOlJw6wGy34dMYkEVwa0DyPrKuP1MFSi7OxoEUQ+3MegYupt4lFMGdORwiEufm
         /NQc3D5wwdMQzYyrWgFBcFMepFioN91rBWA48EK3nAj7nPx7kkBpJ4yA7d3P0rq5511H
         jnmcmir8vQ6n2O7OoNPGFUbjs8pjDhiQtgS0K9oPtAgBPEjwLFR+Z5QgmKLWNmlqxDE5
         t4EbNyXTarGFKzn3Rb6VyoFeJzWZxTnWvSz9dzZx9KrZaTndJIQPyKZViPiQ4aaCbCI0
         xToda9D5kgxzNGajCxhJGaiT+BAru8Wa29Y1kNJMQ+ZE0YEivMHHPXACw4x8Rlzxj0O9
         ZeWA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Li+aEChDJe8MrGr0ASV+4G26uN4YkOlJjzzs4TgwRQ6ldsjx22SUDVcsC/UYSF0Vye4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lzGpEul219ImqgcUD89BrrkFEG8KYcAjaW04vUhMvudXplg4
	nNa9MnFhIHIRtDH26Km0x9Rzj0oqP7+ClfFNBkjmBM2WL5ZeM5UWNGA+ZNGO02xLSI8k6ad6d+y
	3xygdENYZSm0Ru1SjCeDaP4pmkSgVpl8=
X-Gm-Gg: ASbGncs/x5aFu51+x6BhVmYnN8VR33nl9ZP+5ZzCl1yhHEIxYYjT79ehYZh0VT17hgk
	qcoRTgYPPAFM14/Xbzgt2ouwzNnPBJH0kh3lRN0SmbT5tGdG/1uzEsdHNVFxnx/Mpk3eAF0PUhv
	Z4R/i0EUKADpTxxiuBTU7mbHTv2pebMN/wyP5nSxACZd5dj4BDpcD8eaokSxJ4tAch7MxiB4iLu
	cJF+LLE5eZ73UtwQ0utSGzRiXCDQDE=
X-Google-Smtp-Source: AGHT+IEjNEUUxx4M0ZpCooHGZEL9qD8Qkz2ARIk1u5z61m0R3CHIhJjZw8Zq43NeSt8WAnqZ97P6eSgdJy513o2E2+U=
X-Received: by 2002:a17:907:3f21:b0:b3e:8252:cd53 with SMTP id
 a640c23a62f3a-b50ab27f351mr276783166b.27.1759908634861; Wed, 08 Oct 2025
 00:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net> <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
In-Reply-To: <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 09:30:21 +0200
X-Gm-Features: AS18NWBEyeVsdYI1lf1vX5BqYy2_eX3GGVLW3oDP3HBHYfBD-2vFUMEa8Cfh1SM
Message-ID: <CAP8UFD3QUQpnUYGS1qtfGbxOynJrZ-Q5aPPyjb7oij-6YSx7Wg@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:48=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Wed, Oct 1, 2025 at 2:37=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:

> > We could say something like this:
> >
> >   Please do not sign off your work if you=E2=80=99re using an LLM to co=
ntribute
> >   unless you have included copyright and license information for all th=
e
> >   code used in that LLM.
>
> Would this mean that you wanted to ban contributions like d12166d3c8bb
> (Merge branch 'en/docfixes', 2023-10-23), available on the list over
> at https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadget@gmai=
l.com/
> ?   We don't need to go theoretical, I've already contributed such a
> patch series before -- 2 years ago -- and it was merged.  Granted,
> that was entirely documentation, and I called out the usage of AI in
> the cover letter, and I manually checked every change (discarding many
> of them) and split it into commits on my own, could easily explain any
> change and why it was good, etc.  And I was upfront about all of it.

This is a good example why we don't want to ban any use of generated AI. Th=
anks.

> If any use of AI is bad, do we need to revert that series?
