Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76732D6E71
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932184; cv=none; b=bAlWe04S214iZyqeCcdle8OpULZwbP5hG6/4N8hdWMPKY6GpIkS27ndJSic7QKLQazvOsbSs1dA5VsDa/I1fUy9bkUdLCPCPYzm3DLoqFfQ6iodRn2tbRXsAbNFTQMmAjsmtMX3WAsqx6hq+EwVnmkiigdu4RMIG0lecH7iHxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932184; c=relaxed/simple;
	bh=mgxY/P6UWN9siYM2UCSMBceb71oeqkJtxGKMQPOgskw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCAywgkpoWV/GKcLuhOnrSU95NdMgIPxLCiUqC1YF6oqWQTene/TNNnTT8AKWIVaClbRZOWoXukGfr9mzDFD2ho+ao5fSHv52DDpgjwuW2TkjoCOimAP7Dmh62qk0cL3YQ0GpfqjYK3q5jqCBQ6wJZb4CKqKBbpQgsl0RoAOZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHMBQnOY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHMBQnOY"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b046fc9f359so608506966b.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757932181; x=1758536981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAmET/DiNLa1MZIGgUmKV0cqbRSyPGJ6YbrgxexdpAc=;
        b=DHMBQnOYMpzIUHFC6obFdAZ1PHlY33rTBBfVhxWrdza8eogllizt0VYrO8XHiONQe/
         F97uLKHzVk3FNFOQ5KyNZMSA7HGob7C4nH9ia6DPXyySIn3xKPpjFNWe47XwZNgvk/Ox
         z1fjYXPsRRYkdTkqXVqHimGVXOMG666B+ChCl3ohtZcG0FEIesqz1SFQNArUokiRxMQz
         0LlAeD/HIO5m5UA0VIB949v06fxSPQ9GQq9+Z3444r1XMbXX38Mxuh8OvkmbN/G55LWE
         35Y8GmSZENZSR2omWPqMj/VscdnFP2lsMkMsfniWs3/AGcfmIuxhUd+vGvaPIBfFUjat
         dGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757932181; x=1758536981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAmET/DiNLa1MZIGgUmKV0cqbRSyPGJ6YbrgxexdpAc=;
        b=RiCZctAmkb0Mq3OIe8XUYiduZZ7nqEfdaupTQMeMjVpIVLZSJ6O0uvEM+8P4XY6I+0
         gbotv/cLBSyWllYQKIcdvfcD4J8NSo6aL0tXrXxwLnVD9zxsUncoKnivcA/THO+QyizZ
         sKU6GB7pm0znqQ2BAb62EDHl67BqWGWFi3rEkOaBaiw9F2Sm96nj3UmIJRxYZ98AYWRy
         60uNmWWxV04KaDX+VvdaBh8GdZY8h+cfJx6FzWdpr2kWvHRIKoG0Bp7pfP4+BxdXyh90
         vo1Jm7NDd2Wql1mKg6PuLEfVd7mZLkxHzAVweEb6JXNIKdt+AAjC0ExgtDFxUN0KDvc4
         OC3g==
X-Gm-Message-State: AOJu0YwZih/o/LytmGbg0oiRJZ8vy05DBJ0QRDTLTKB+5JYVYxnA4Hg2
	a0XKTZEsw0SqIB/IQm+y/CAWsSa4h213ltf0pTF4ktUg28rAohWD8vXzhsZBjfxreFMtYkHT109
	RrgOOP+u0pL0kMSO1Ro4qoKbn1Qcb4pM=
X-Gm-Gg: ASbGncsjjDYiZd2u/iniqerQgSEU9zAL/IFJFCfFjijCaPe7oDEahhwIX/kZoYMP8+g
	r9bmvmaUVfC3LK/wmkVg7L5UOhKhQMMmlOhwB5l17khv31niLAvSzwmOzCJiJN9gAtcyaeQFlbY
	uevaQmoKM9lXRiLgaONA6MCkJeedkdPVj4gJ+ZhMSrHAlUgwy2wlyXH3zK5LLMg9Ud35vNnEfIa
	8kT7Mo5hnI70Jww+/yI
X-Google-Smtp-Source: AGHT+IEJKOrJLlbCY+g0RHU6pGhLl4XeISc1i6IkdrwsxRoY5u00ZmmWG/X5KDLRCLXqkmNaiQLlNopIR0bMOjEDkUY=
X-Received: by 2002:a17:907:d16:b0:b04:6338:c936 with SMTP id
 a640c23a62f3a-b07c35b8e53mr1287195466b.17.1757932181027; Mon, 15 Sep 2025
 03:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-3-christian.couder@gmail.com> <xmqqtt1as08f.fsf@gitster.g>
 <CAP8UFD0EAuGdMWY2ff_kjaQnZ3w7VP2ftM6Y4Hr3T4HQTsFB3w@mail.gmail.com> <xmqqa52zoizs.fsf@gitster.g>
In-Reply-To: <xmqqa52zoizs.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 15 Sep 2025 12:29:28 +0200
X-Gm-Features: AS18NWBl6VwWVMJKtGAFgDgHzi9C5SZph-N23wd3OHmCNWfs9HLbMm8EaM4H8R4
Message-ID: <CAP8UFD2RVZHqb4EwULmmR3hJJKuxajeOOLe5_p3DYcz2dmdzYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> ...  Was it so important that we pass a
> >> broken signature without inspecting in STRIP mode?  I am guessing
> >> that is the reason why the new code tries hard to avoid calling the
> >> parse_one_signature() function in these case arms.
> >
> > Yeah, I thought it was cleaner and a bit faster if we don't parse
> > signatures when in STRIP mode. That's why I did it like this.
>
> I do not think parsing performance matters all that much here, but I
> think it is a good idea to recover from malformed signature lines if
> the parsing code can detect some.  It is likely that the user may be
> using STRIP hoping that they can skip bad or unknown signature data
> in the incoming stream, so it is beneficial to be lenient there.

Yeah, parse_one_signature() expects a signature to be in the 'gpgsig
<hash-algo> <signature-format>' and might die() in case it cannot
validate <hash-algo> or <signature-format>.

So it seems to me that I should change the code back so that its
behavior is the same as in v1, while trying to avoid what you called
code ergonomics regression when you reviewed v1. Ok, let's see if I
find a way to do that.

Thanks.
