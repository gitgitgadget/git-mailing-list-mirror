Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D717BB6
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780129; cv=none; b=FCPjTE/MlngL66QzvTpk2206T8gR9iHEGdstLxP8oyonSZGQzC4abcm4wSqO2vHeGCuUE+c8scxUsev8mqUrSAu2MgKvY5/OEBVHKJTv+My0h4CLhjHi9mJc+4DiOnSogQT8ISg1HBjCiL8QhIfx95fnJW4AKcne8wwAdR0bmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780129; c=relaxed/simple;
	bh=fc1KrW3BpfKtsAIE2RAIXiIP4gxjRNU7OJFQM8umBvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoG1A8J/1VgKm37qY50L7q6yYPL7TsUfj39mq5eZ96eYugBfgs/QHLUWNy7ldKEZy79OiwgMmetMK214Xz+lmdzf6AIr3OLoadHkeUk1UPQw9/bDtWHNipNwvYOGMP493BWDuoDUYcG3Li5lU4vmxsjEkqy77XX9uLtmuYeymdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPKd1Q8Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPKd1Q8Q"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1299034066b.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741780126; x=1742384926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc1KrW3BpfKtsAIE2RAIXiIP4gxjRNU7OJFQM8umBvQ=;
        b=dPKd1Q8QKe5fifPKQWX4Vg74VzFMkPdFZoaeXXnoF/tzFKQswA8MjC+zaOnUU5xaf3
         vzZDG4MKWPOsVWBHUzlWuEoosyQ07xNEX/tjM4DZKeq0ZX7p33LgOuRXsJtVtYYdRnzC
         CbrS7KIjHojqLCiicjUYyu+QuazYYjV0cpXa3+/mOCZj8ug2iOqbiZvljnCvMvVHUjt3
         R6LsPkwKLcBt9rGQ0KhwO8cZgUVPzR8w1F9ZN0bctcHvl77ePbo6+0L/8wcTAOCWg8ez
         RxSBhZ6exuy1lvBLnKgB4mwsDujS/LeY5DUFvkdWcw/qO3pdmmvf2NYgobYNKCN6hdME
         htsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780126; x=1742384926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc1KrW3BpfKtsAIE2RAIXiIP4gxjRNU7OJFQM8umBvQ=;
        b=Iy6+RDMWEJv6si4jIPyyUmxxuy0A2CcNP8gmSB1TKwL2Yqli/sf2+m98sdkSff5q3Z
         R2bEgqxcHBWVsfQh1tzQK/Uwj+xKyWlHku9A+cBiRWQBJPovVDSlvVT04F1R4caRVuzZ
         +MlsstR0XRgJFKeOk0kEKwgEwKX90IqA6F128/FWJ2CH+yk+EPd8ZWl63+tVC/j2n4km
         /6OraDCL9ZRMf13giv+fzPJrKHYwrkaM9JGVaqFceHnDiEzJan97bUtf8P/PN7D+gifx
         UODsgSgICIo7MjY+/oqW0HHekm+L5ZUwpHrz0JlOH7kW2H1gXQBDquIpbVZ312C66A9v
         pvnQ==
X-Gm-Message-State: AOJu0YzAFCW4UGUV13VUGdxvRXslWsQ58vOHZf6TMIZdGGrwBFyLSpg8
	0FC1zT7ty5As45Wq8zaMkiJsUYlj/Nmy/WndK9JrSoeIcM5GBNdKGbtRf3OBGFzbNixEb8pyWdE
	gyPPxPz2q0pf68+5OB9QwdniSXvw=
X-Gm-Gg: ASbGncvGZSS9UMpgn7da1M/7TDT2v4ZPG9oFuQgQYxFd4olOcQ5jD95lO1sSF/2jOJU
	g2C6AwxdfI4iE6Fx6aVK1xERzVYFrMz9EYh/kU0MxdnHbwNFZ6szxUOsI8nTgkBZvXvITkIZLsY
	jYlaAwKx6S5hl0vXyTTbNIJo6Fwec4
X-Google-Smtp-Source: AGHT+IE8E9sGHz1P2clU7aV4lGcdj/6LdvtkDWRNnw8jeJGDQcJQClghVtkH3FXgaid88jotkgZTLmJ/Yb1PXHxU2Eg=
X-Received: by 2002:a17:906:ef0a:b0:abf:6e6a:885c with SMTP id
 a640c23a62f3a-ac252628fadmr2758654766b.23.1741780125694; Wed, 12 Mar 2025
 04:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074053.1886097-1-christian.couder@gmail.com>
 <20250311152413.1059343-1-christian.couder@gmail.com> <xmqqikof4i60.fsf@gitster.g>
In-Reply-To: <xmqqikof4i60.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Mar 2025 12:48:34 +0100
X-Gm-Features: AQ5f1JpiZeVKbIDc-XA2yFe7IeAVDSDSykolGmEH14oSSqMOwKdXZ4_ICDBsjzM
Message-ID: <CAP8UFD1v7+AO7BJRN2VomM8e8FRbUZF=eP=nvvrdh6VzTwJpNA@mail.gmail.com>
Subject: Re: [PATCH v2] promisor-remote: fix segfault when remote URL is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > We could have modified strvec_push() to behave like
> > strvec_push_nodup() and accept `NULL`, but it's not clear that it's
> > the right thing to do for the strvec API. 'strvec' is a kind of NULL
> > terminated array that is designed to be compatible with 'argv'
> > variables used on the command line. So we might want to disallow
> > pushing any `NULL` in it instead.
> >
> > It's also not clear if `xstrdup(NULL)` should crash or BUG or just
> > return NULL.
>
> Yup, the above two paragraphs are irrelevant, I would think.

I have removed them.

Thanks.
