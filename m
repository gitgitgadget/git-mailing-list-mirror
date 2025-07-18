Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B721C9F4
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875797; cv=none; b=G3vpuazciu8r4GcQKGPJ1Fhyy3GU9i0EIFyLj/kJnppf8CQj5zFHEWPBd2F3WaqNAAY6VJ7TfbzV8aYMyeytk9insBmOmvXm0uhtsVoWCgAzbC5SbmC0EcwsxpVGHNwUfWN7cQ9Zpcd/6ep3UaQKDOVj96VlYUYCiubLgQRSwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875797; c=relaxed/simple;
	bh=ueApP0y0KkjiAk146UQzDOyKKZDHSZeQkUR9qCnbMG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD8zSzrmios3PF8OAkP+SUoQPiJyFX0hxdYWWUZIGnsLbGhCoSb3mnrsxcNXUPEH8ow7lGNok3G6sTHIK2ISGceN78BEx3aFSjLcttdsXOjipBhOcA86dXs/YlFJUALy+9QMYvQQvr8w3QIFmsOHlG8zNukrsyK9okMFg4Bd37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoiBBel9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoiBBel9"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55502821bd2so3201367e87.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752875794; x=1753480594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEm8rB+7LKrKv4QgWvjLEfbruI4IoHrX1Ikgoh5DnJA=;
        b=PoiBBel99mzw8SatyGhmCl+rAX4fc0caD6jiTkFLGzWcacSSN5shuAmvXpbOrsIsKH
         y44oEe8b46v+jnX3ptu5WIcdpIrXkLvtYjQvPCCKDFjYcBEEbI5cbnHk2D3pdf72NHFP
         /j+ULBi5IJ23sPuYa0CK144Z4lu76r4riXqK2GYhsbRCv8GeJCfS3t0uz4A2ywgq0D97
         D1nS6efXRirNS3cKS6uT03Mg28JC+5chBbH33N63URDQplmHPWPqsZ7Gzvb9tCi1nCwa
         XKLsjXDBBu9w/loILBfc/4b36KURNWXg3NSejfNPfh/iKQnX8cbM2azc0qR5oFQYpMzY
         2kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875794; x=1753480594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEm8rB+7LKrKv4QgWvjLEfbruI4IoHrX1Ikgoh5DnJA=;
        b=YHK9Gdbujhy6NBCoLQUZiTOsufRofN3nyrvm206XREPzqqx+odxONY/UEsZT7t6vAY
         O9Ar1AhMc4DL3+Rbb3cS/zhQWgiD4uDw6xftpPnywmHchTXVZ1JV3BjoDte5Eitl0+zJ
         W3g/CbKsuiDmiEKhFUwoNTQtw6LcCkU4KXBBf1h1upTtI0JIMQRgHWCLXlaUivggL7oQ
         CDDMimTsbKMKudJXFxdpnqUw+KmsvyiXmUfRx0yetfTrifGl4TvtDmXZohMbPd0GZmJy
         2E+HvwwlXIazq45dWZBb1ANEYPQ0k4ODM8tbXYYZhFtSuiyOrtEbDcipaR/KAg9fv5fM
         1QVw==
X-Forwarded-Encrypted: i=1; AJvYcCVVSdFzZf6M+Qx9ISWMxoDqCYRllM2rGjiRfpZOngEaAmnNTBhmHNZf/PxiDj401voT3aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojXCfLAURWqNMNCFYYmcJKRa+MqUTGNlRfchYFvBPR4jNDB8r
	u/ezfv4QyRvHnkOLaGtftPn+QItKm8umkkDBN7IhCuJpN7nqkb39VAIqrfTBTDu76LxsNKoT2xU
	ffP8S5vIgciL0vHTlMXBoqKm11pj4bC49eQ==
X-Gm-Gg: ASbGncvBJFZc6EE2IOvY+gcrKpfJzXzm/eIm3mP8c0gp27a8w9L/01T662Rbz+wxMAy
	T+Xow8bvWR5SVkqgBharolUPQUpGamBMw+8pzJF7qOC665VOdqUr/QmBmtuTIpUN2Qid3idQVoJ
	69T3wZDaCc2PATkLfr61LruNrQw+yciF1EAKHGF0N1UtIV//JmiUV1lTIq1Q4YwO/j4xdqKReMO
	lmpadum
X-Google-Smtp-Source: AGHT+IEiB6U6PMJ75kY5xThYCm+f2Sh9QGqVDdX+FxMTOjaPB3/kUtwO4qvfZXBfKwWbv3IZi9w08MTUs9dEM5T5t9Q=
X-Received: by 2002:a05:6512:12cc:b0:554:e7f2:d759 with SMTP id
 2adb3069b0e04-55a23f35d41mr3877008e87.28.1752875793638; Fri, 18 Jul 2025
 14:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <xmqqjz454l96.fsf@gitster.g>
In-Reply-To: <xmqqjz454l96.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 18 Jul 2025 15:56:22 -0600
X-Gm-Features: Ac12FXwN8GLW9vwZuTjkFgRukgvHPnoVfmC9IIYO8NdvnPxHdHROgqSfZmwWFBc
Message-ID: <CAH=ZcbCVVOMEFmWp1JEDNRWGE2+F3zQ5jT48JhD_2ycR2kOv3Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 8:38=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This series accelerates xdiff by 5-19%.
>
> ;-)
>
> Do we know how much of that can be attributed to the hash algorithm
> difference, and how much for languages?

This is difficult to answer because xdl_hash_record() hashes the
string as it determines its length. Xxhash uses simd instructions, so
all data must be contiguous and processed as blocks rather than byte
by byte. The components cannot be directly compared due to the nature
of processing differences.

> The earlier parts of the series to trim unused code and refactor
> look to me that they are good changes regardless of whether we
> introduce a different hash algorithm, and/or we use an
> implementation of that different hash algorithm written in Rust.
> IOW, even if neither of these two happens, I would think that the
> earlier parts are independently good pieces.
>
> Thanks for starting this effort.  And thanks Elijah for helping.
>
> And in case nobody has said this yet, welcome to the Git development
> community.

Thanks to you and everyone else for your review comments. I'm going to
need time to investigate and respond.
