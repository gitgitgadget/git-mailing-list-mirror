Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F31F3B85
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295862; cv=none; b=HPQthUQA5sd5NcLopblBzO8XYYdt8fcfOkfrC0MIDookORi51HPl6ECFaDyThAJSnNAshpVEW/Hvtp0oxlzlCmn3nsep41vUPmjE550IPCIcqgU9DrXO/wAomngjzzQIFuNfb07QIJxiW1LXSlOPeTuVh0LkWyRAvrDLBKrnqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295862; c=relaxed/simple;
	bh=G7OgombhE7WWNvXeh2UkWCU5zwbZgWDKMhoD4pc6rQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTLZ64ntNSQ6gsyinaUNeywWSSXvKrx8OyWJrGxUp7qItRm1PSNrPZiZtvU3/fr3nrpNazzDzTq8kx5PWxp6PYskv4LRUEfh4hJRt1F5fzCmLuFpPxzrYdqeid8w0MmWtdNF1245RsB8kEg1/1FLVUhxb7RnFU069BwhE/TMDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZi+syxr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZi+syxr"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so9850933a12.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742295855; x=1742900655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4GFu4jgZuNGEomZmcIweinwQJkVr/23YgAEbNON4po=;
        b=GZi+syxr2u5NP4UFjQqKeB+jWWQhGQpkL7IcK7KoKre595Xm+j8hGeHboxHeGBLaHU
         e+dy5zGLmk5kWfYvRzJx3zUUI+b0Ek6wDfS9X/sjq5FNwVh2RE6dSWA6D1IHTeQeUwFn
         LT5PrpPCGoeqgH5zP5qNBE6Xe4lsL4173QXmlxJFGN4126xd4/RQ/6yHw1fgG9Sxlu1L
         NoiSKK8BI+Ci57q5xXQ8Ez3+fLcMvpSP0qS8BSCLFUJWGYnEZC5tt0cpakQmgYTVnace
         +XU2xpcn1oNuMw8R3qlNOLYa4S0/U/hJnImxGYn3xEAlXhpDWUbQbroRy5yObjpG5vfi
         dQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295855; x=1742900655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4GFu4jgZuNGEomZmcIweinwQJkVr/23YgAEbNON4po=;
        b=Vqr2koQVREzUogK793CSgH6vXRsYKbQgZI3eqlagRBavHFjdx9l8/7d9JTcu6s+UU/
         XlkfPEdU4kuFx0nBInaM4Cmz8z9kGwiop0J2dCrrNnyLGd+z/0xYJV47v/bhzuTP4k+R
         MZo3zOlY/UVjm6pWABpTQtN1Q4IUPizcfN/W2KJdcCKBDpEXrIOojPVoU6ZwKR+2loz9
         m2wO8zY21yXTiR3jN2fbcMumB4B1gcwWzhzOKkUAXhVEJ9kcG5cuLkhJZZIcZzYOm5QA
         c+XY2EqPTAezDXWOfT/XMRckrtCkT7ua5XpGOFLj8Yt59zNn0uweoyxKKHzp7eXeRwU5
         wN/A==
X-Gm-Message-State: AOJu0Ywx5KF/SGFftaPpumSPbRk6zcR/2p9zKwBygcEIiGiwm7G3tKUq
	jm0QmuLhICSPEfCd0YI4ZHHm9BmR9/XrKbiGx9ynVy6fjglQ8veuavUEqL/AhfxJODMckvI9iNN
	/UdgGOkykKGaTSJcxq4CyoiW6JkY=
X-Gm-Gg: ASbGncs0dpDv1VTLiw4dgj5wMXKMfv6Bkmp1V5z7FbORefiP9gunyRjg8TwFCOvRwDV
	mJ2Nqc6jSG8BpFCuahUQirJ6VYBEPcU0aLj0FnjQ/CHMi4NG/uk/qbLC+08JWW7oEyvKIzdmueX
	Nn8V1wdB9UOWE9YOxy35yvb5W+noTrSGMgofSjw12BHIFFL72BRdiDhO0pdggg
X-Google-Smtp-Source: AGHT+IFWcEQwx+0RcwRZGgFVo+3eimNzllBvnA8VO9yqRm4cADoL3PL1lAwN1dG9+Ghaaq265UyapLB0y1dsXKp8cCA=
X-Received: by 2002:aa7:cc10:0:b0:5eb:4e69:2578 with SMTP id
 4fb4d7f45d1cf-5eb4e6929c6mr1106908a12.13.1742295855182; Tue, 18 Mar 2025
 04:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313103859.817127-1-christian.couder@gmail.com>
 <20250314141203.2548803-1-christian.couder@gmail.com> <20250314141203.2548803-4-christian.couder@gmail.com>
 <xmqqo6y3h67u.fsf@gitster.g>
In-Reply-To: <xmqqo6y3h67u.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Mar 2025 12:04:03 +0100
X-Gm-Features: AQ5f1JokpfXgv-YmhhSb4bDIX6SONwEcA7ogbFNKChJynX7zMcfyU-Cor8tPCfw
Message-ID: <CAP8UFD1oNNgEkYCX8QZo4CbEe-=_P2M0bGup-RvLPXNhpYDh8A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] promisor-remote: compare remote names case sensitively
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 6:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Because the "[remote "nick"] fetch =3D ..." configuration variables
> > have the nickname in the second part, the nicknames are case
> > sensitive, unlike the first and the third component (i.e.
> > "remote.origin.fetch" and "Remote.origin.FETCH" are the same thing,
> > but "remote.Origin.fetch" and "remote.origin.fetch" are different).
>
> I double-checked what the control flow that passes through
> remote.c:handle_config() does, and the above is in line with what
> remote_get() does.
>
> remote.c:read_config() populates the nickname-to-remote hashmap by
> using handle_config() callback, which calls make_remote() with the
> second level name (e.g. "Origin" and "origin" in the last example of
> the above), which is passed to memhash() not memihash() when looking
> up or registering the remote.
>
> If we used case insensitive comparison in the new code, a malicious
> large-object promisor remote could have told us to use "Origin" as
> an extra promisor and in response the new code may noticed that we
> have "origin" and tried to equate it with what the other side told
> us.  But when the existing code actually interacts with the promisor
> remote, it wouldn't have found any configured remote under the name
> "Origin", and something funny would start from there.  By using the
> right remote consistently throughout the system, we would not get
> confused that way, which is good.

Yeah, right. Thanks for looking into it.

I don't think this needs to be in the commit message, so I haven't
changed this patch in the next version. But I would be fine with
adding your explanations or something similar if someone thinks it's
worth it.
