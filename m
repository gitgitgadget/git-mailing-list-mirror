Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C91854
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742107132; cv=none; b=Pp0jfiqcu3Sjlvh3XD3A8xqV+GgJSt1T+mKJvmphckfgzuYGqe2+xMYGW5Zvbb57BQK1yC0boSb90oDA8lLFlOfzpREbWuL0AlFNd0wmbITIDuKua3CAnG8olDZlTe+6vhvCwzBCSRG9uxuJfB66b9p6bm1C5d0VJG4mccAWryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742107132; c=relaxed/simple;
	bh=wttgXFjOEKSwgZFS/sOtUS+hSzKq30UOLoVJZheahPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTtb+F72A45m1cYbNGNMWaVVbN+dseGpFlz/aKY8VQOJae30yTmwZ0kIWzmM3/EVEBh26GITBiJ7fEP0iob6Cv0WChlKTx4Oau6mqBxN8vL1fkLwz5+rEYp2TTWUm08b929oqATCnvgQSpOhyrQGB/SA5UL7THc3qY3oGc0hals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b68sbE4t; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b68sbE4t"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso14900745ab.1
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742107130; x=1742711930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0iT9vW0TLw9sgWKWwwg7MyWijYwE4k4WnqQL9/l9gs=;
        b=b68sbE4tezHwcYp+t5tuRsuBOicOjpRoM61cY0MbUtMha9QTyF2Hcq+sCyWTJrVKF1
         SJ3SQxAP5LUk+xOE4OY0SyTEcYD4SWS4EwYrYwZpr26aeKUaG1deihc1uLS0dAdtOMXP
         GGUmeMIw1MhpqDOc9oDElS8vyF7AzIGiifdu0t3UUBZFE/MsRyJeMWC5J0YDfl43k3Ao
         EpuIV4p3syMQ5d1ZEbdPgR2utHjZT6ErcSD3mrnapF8RpOsvbtjwYkQ0h9d447nGzIBc
         r+UCZH/UL8oUwdRDm1IJOXBqgSz9WZlKwAXowv2ZxqhAiysaNhWvav2/Fnh4bhRK5sca
         vaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742107130; x=1742711930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0iT9vW0TLw9sgWKWwwg7MyWijYwE4k4WnqQL9/l9gs=;
        b=LjAFmBXX2iZayauMVSRyr8Vq6MT1+ZetBYD8St5dYzOvRVr0DDbK5bhhL56JKQeNaG
         c/9Er25s6wW3up3DW7DXrjBUydYX7FGSBr58ZSedVN6Sf9SOt+WMfxu46BTxAxG7nUjf
         ecwL3SqQGRPXXICcRjtoXWSh5pVOmCWl11jD3hHQERBusxFCX5RUZbB1QN10VfVt1Pp2
         y0vYUnVMcOeJt1V/UGitgBcu1mLfaNz+/Zz+QoTS39yEMG4VxaWbBU5P7Aa1pkQrA3G+
         c/6RDXKUOK71Ie9tndgCmfsgZ8FJPSwffukBko8VqWe9ObYnU3fBP6UbAEfEqwQuOWig
         nnzA==
X-Forwarded-Encrypted: i=1; AJvYcCUnrOTjmoxm6aUXN7bMnqpcsbTMfl2SisaGTV9wC9IBSUHJN9wtvThnRkiG4JoLHosrYdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56UzyJgqQi5JTOESM8qS6LXvoa1dxpqwXjtmkliCpmAIUw1X/
	mXbOm27TS2BGXughDxwyj6OCdFhBzma/v7O1OqKMQ7sdwGvbyZSu4OXRaQdEYoljpiX26+VEtxs
	ka9q95E4OHfZWlTvTtFd/XH+5aGg=
X-Gm-Gg: ASbGnctx1VWts3QI2iztCSgYzv/W2x19IdfcZbGHeQfjYSeUyLvZMg93YUjzSZoSaw6
	wByKlh81iTZhCDGXdQ4BNLXpAzjh1HZ0TEDCT6taMEOGo38jJoQGV2qYWn/LB1Bewgdific3PyL
	2FNhTPuDPSypQmbUSJ/KIGBmluERCXzS9z7PwoZTq2w0SK20Fhcfrs8ubtcw==
X-Google-Smtp-Source: AGHT+IFQj9GsGjD5ydUMGTbwtFQCHsyTmX02/Dge3oKA8vhhpB664PwdoKNkYgBM1wdiIW14fF7NDWeN2alT/K7CXJ0=
X-Received: by 2002:a05:6e02:20c7:b0:3d3:eeec:89f3 with SMTP id
 e9e14a558f8ab-3d483a2de18mr82693895ab.13.1742107129804; Sat, 15 Mar 2025
 23:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
 <xmqqy0x8l8tu.fsf@gitster.g> <Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net>
 <xmqqtt7wl85l.fsf@gitster.g> <CABPp-BHRSnNE0zj9kRjrVm4-NXt33tYBT_iSgZU-5JU9Y2vp3w@mail.gmail.com>
 <xmqqa59nh66g.fsf@gitster.g>
In-Reply-To: <xmqqa59nh66g.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 15 Mar 2025 23:38:38 -0700
X-Gm-Features: AQ5f1JrW3DaZ5_EM70AYjhr_l7JQWB1t3PnFs9n7aXTTGV4oPy5diioVv8MRnps
Message-ID: <CABPp-BF1LgdafW+PHmttuhHL1OOHPTsGpOTVuG_A0SSH5cbfbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert() calls
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> Licensing, mostly, as clever things we see are not necessarily home
> >> grown.  I know the patch came with DCO sign-off, but it does not
> >> hurt to double check.
> >
> > These two lines:
> >
> >> +extern int not_supposed_to_survive;
> >> +#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
> >
> > , which serve as the core trick, I had used elsewhere before.
>
> It may be arguable that it is too small to be copyrightable and
> there is no other way to express the idea behind that check, but
> in any case ...

That's what I had been assuming, but then you, brian, and Taylor all
pointed out how clever it was making me think otherwise.

> > Anyone got a clever alternative?
>
> ... as I cannot unsee your patch, I cannot be the one who comes up
> with a clever alternative, if we are worried about licensing with
> what you posted X-<.

Turns out we don't need an alternative.  I contacted the author, who
responded and placed the two-liner into the public domain with no
warranty of any kind.  I'll send a re-roll with an updated commit
message.
