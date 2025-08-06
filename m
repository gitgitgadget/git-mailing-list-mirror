Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01572614
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464844; cv=none; b=LDZg9n/rg7ADRFYwOtEob+kJQcUWWR5DL9LMBqwqD9YaX9/muihTFuLaQj0qxcHs99JJMAY73HvnCTfLFBgcu/rmmf+41noJ4cHbJ2j662ZKne4caEiXil13wlmWBstj55Wri6/aUHH95u4TcihG2Myrmb3+aaQYbt+AnRfbf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464844; c=relaxed/simple;
	bh=5OTStVudtGYRwnhWSbBNBNW2z1nr1kA8EuvEd+JZVqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF4zGXwwuLEvC3MBWjXufaKBlganoecU9LvrTyJgTEg9M+kUEzh0e3j88cvU0Mt0PPfU7zecltOsAAZj7OWduQRW+fZ0UnIVJThApmFrVmGJ5jKeBbRIB37TA4dL1uBRHQ/7P3lI31ID7Ydsn8HoXfEop6fP285lBrvd1UX/5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1cfZV8j; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1cfZV8j"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e7949d9753so2122404137.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754464841; x=1755069641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xt9YRv4SMiD6uraW2r9FIKTOXNpD2/txINHQ1jyztk=;
        b=l1cfZV8jiKZqu4xWQzz+Kta42fJC7YoPZemsCgSAtE8aIpymQ5NkYs1bt24GkZztDo
         9tpLAfjw0B/5UqotCHSjUeDz740z1U7iKA0orBoaN0E3jDGo+5B8ZeiNhaMPo64B9nrV
         c/kvJa+A4iD/B2U7rUQEraWK54AzqCB7a14r2vCFe1TIGFsVGovolOwZVdJq0ZG/XD+t
         xE1f18l/cay76s7GTpkO/b9L4zgdtmktzGqSkb0rj34SBmeqOvnL88DGlGv9TYU0tI6+
         v/WHOyTbCGGpQBYklw67c8Gd9LuRoVradhLBVGaRoI+JLLSzNwjUKxa5EDHqaMOQD3Ci
         Mg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464841; x=1755069641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xt9YRv4SMiD6uraW2r9FIKTOXNpD2/txINHQ1jyztk=;
        b=wz0BJQ/rY3YiMKG/MsMOgCxmmT2srk6dhmwgVLNPzg8pBite6fv6hdpp6WyVrXYWIc
         WW7/uGPs/D3SbIbBBuBM6tQ5gvzHk9XUeQbXm4/ZoggMd4TAhkir5KnTt5ys/QZAzAwX
         ttSvi46YyAjxKKVVl9neVscsTn1jHO/ywSQLfjbnYytaUhKs2H/7QpIH1cTbBY8PK4Wa
         JsxEly89UeCYhpIW7Bzg+Fdtq8ZfMVzU0YdhP3UcD/B3ek4nnQqhLvsgwEYMkIJoJowp
         u85vGRKPAZK11sDqQhajVY84xsidgW9hSGHNdzfcnwi9cyGi5KKJy55R+L79USjNXIlE
         3WSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVmfI9xorAcksuD/El3go5FsZg4TOLhoWkMWAq7fTevmo7tcGubH08AHAENmxyIMcrFgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVw8a7XYvBdG9APHPcuZR7R5iB80G6a2PmLQzlpFnNrDs2F2uL
	Y5KY5ZU05kZxeKuRXfE7f4Rt7FvK9KHuL80GN5KCRTANtC+2tU2taRh1eZo9+Yb5g84qr0mMOnb
	Zsn6lqN80k6pBLM1gmS3bkh0XmsUDa4c=
X-Gm-Gg: ASbGncvhRKDLMP3sA1PrtijTNnHoF6WUA9Az5RkXhHZUIWvCV/G9eCoRumnp23TjoOE
	xfNCdM+/YVcj5DRxFI0+qq/YxHejSSFJPfGY2ZqyhNhGsOSwb71WQ/0d4r3eJhOZvrjzb6cvV0T
	0/b5zBeXWncuAdV90srsyTIukIjc9gOLjbmIKfKpAlRp4e8t9DYg4OZgWqkrO/Od8lq9sgla4uu
	qS0lfc=
X-Google-Smtp-Source: AGHT+IEyYZjGp5Zo8H8or/5FYstbV5KsZjicyq44Wjgrs83+3WZBHC45R3INVsU2GhhHALHcFg45ZGYeV4pZmOmHzLo=
X-Received: by 2002:a05:6102:3050:b0:4fb:372d:6d70 with SMTP id
 ada2fe7eead31-50373d14ademr728652137.26.1754464841376; Wed, 06 Aug 2025
 00:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250803020744.1037392-1-usmanakinyemi202@gmail.com> <20250803020744.1037392-2-usmanakinyemi202@gmail.com>
 <CALnO6CBCynikVcZq17SxOTfwuRMM86cv+BWQb0zZoOdMYX-72g@mail.gmail.com> <xmqqpldce24h.fsf@gitster.g>
In-Reply-To: <xmqqpldce24h.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 6 Aug 2025 12:50:30 +0530
X-Gm-Features: Ac12FXz87uxjixv5UE7x84yryJ92dR_1Z9_C6bg_5BH9xxxFc4FFt4MCEIwE8Tg
Message-ID: <CAPSxiM9d9LkH125ikjwRc1z7PQZfDYpkab0ZHQKFrCpxg6eVJQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] t/t1517: automate `git subcmd -h` tests outside a repository
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 11:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > All fine, just leaving a note for myself ;) I didn't see any mention
> > of the changed base in the cover letter, so I was confused. (Rebasing
> > onto latest master makes sense to me, but I'm not sure what the list
> > convention is).
>
> Once you picked a base, usually it is a good idea to keep it, unless
> making a trial merge of the resulting topic branch into 'master'
> leaves conflicts that are not trivial.  And I do appreciate your
> noticing and mentioning that it is recommended to have a comment in
> the cover letter (or a comment after the three-dash line if a single
> patch topic) that the new iteration has been based on which commit.
Thanks for this and noted.
>
> Thanks.
