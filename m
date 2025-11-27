Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297F32AACC
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239571; cv=none; b=VkGKKtrQaQRzw3n0twSHm1iXHeMoojWqOx+nhzX6KVofhE2H4EllD8KI9R7Rw7fVbm3fwaldw1pusnBLKo8Av9IqBWK/LpGXy0ZlEOzB8l01Et1vc6Pdr4wol0+ODeiYCGVGkfqlJEf+JXQrPj+qeqKkIyV3tKCnMcq423RMbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239571; c=relaxed/simple;
	bh=oHQMprnqwMpHuKKC2YQyTLFWYAeIJH7gvNEi7wPHjfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKh+CM4kU4AXVyLKERNdzeSkIDAaS4uOYS5s8SlPPWwS1lIU93/CN2dkKSEUJhrlMWcA1x1/OmqonFeEUJopGsd2YLsn4ayke9vNNzd69QTKKvemRX5WF004EbjwVhxNAeFYBhzSoEWHhzzoNJJhfOQviJ0G0IJJup9vsedc3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com; spf=pass smtp.mailfrom=zeta-soft.com; dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b=1DoBY3NB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeta-soft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b="1DoBY3NB"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so1262427a12.0
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 02:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zeta-soft-com.20230601.gappssmtp.com; s=20230601; t=1764239567; x=1764844367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2OKpfAyCMJFj2LWM5W7qbGiqFfPQX4hjtjCCJ+jnH4=;
        b=1DoBY3NBkXYkvcGzJKupprWvdzQdJpOktI5Gi1qV9fVhb23TfrGbe/8AuTaGceUTEf
         mf9xt9fcgKPXVU9sr18zcnj1sQwWcaC/zaxXoT0AkmWZHnXDF+FCP/pJa9IflzFcfE3k
         xUomV5+QSMMZxzKLcykhMidSmviyDI5Gk72vJOhR0AJgYtmJb7IHBWJ2EZEq6mOSvLS7
         XAaW31dl82ze7unluQ8VGGEWD5vQ3xdYurxPLcefVTFgTF2/q7iA5XxrCAN9+8XLFOHd
         sAg4OkxV3CTK6w1UN1ot0mk8vXK/OaSJuZaEcGXggCN0DKmL/Xdtz5m0cmnpmoCGjpcu
         rfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239567; x=1764844367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2OKpfAyCMJFj2LWM5W7qbGiqFfPQX4hjtjCCJ+jnH4=;
        b=QXN3OuNBkFe6tTfGWTgsPeb0mjt1Cqj5J7hMr+4bIO4IBZF/QWu0BQOLgS0ub/NDB8
         diMbDaiZNtG/j+r2WWB5GhRHTuQ6WRKShg3gV+U90Yu/ILFwf419L/Grl29+wD9+0oWM
         L6leDUNyrifwh62A1em1l8shOBROUxZI3ONolXbzqXPXRuiZICOPprBuKwWu0oGa4zA3
         tKMUFCyLI9mMC1UjZJ3NAQTsQgb2RDxQZLBacMxrilhpOHdRRx6AanMBuXzAGsz1J1h0
         KmKaXBDfB0grXnSlxtKN3x1sfRjJN9lkEY9x2+noOB12bRj6oDhzCIfLQH3wFWlEfARL
         uVyQ==
X-Gm-Message-State: AOJu0Yw2fVQ3PeuBh4dbWVzpdlrPv3JNWqgDP1LB66+zNQx76Nw2YlXh
	Jmhe3GOZMFgGhHddplIAMiU2NdmXtKqcmHuBa4aqCehKFyModAu0oKBjGr8NiRwt5JyaYMPkpwy
	jIff3juHJNdWKOSY1+22Go3UXWliq5bvvl75FNhzBTw==
X-Gm-Gg: ASbGncu/Ip+uoOSbQQBruV2L4O6BGxESS+y4ecWs9FqyZS8z6/bGOy14aIPb6AS6P9o
	vDIyRTMWtbMg/AvQV24Ib01sLrw67lfV7yT/7cLCkm9SHiHwpyU48ZCs0sc5WWARFAga3YrP2pU
	KYb28AiWFYo0hJEW/QCiQ5cp2kxdxIKGAxdvWvviX+Aw1MLG4O6rxK6SYyU3ic1SgMqVT5CNfha
	nrwq2jJMIfRDdyHnfTFl6rYMl31+vM0CBVUa/pdMm7dh8vVK8DWjjIGELNdQ8c1wXw=
X-Google-Smtp-Source: AGHT+IGKaCrE8hUNfA3+X5zQwzC129oRYQ2JQ9Y1gMVnO8yB/7r4Ma8yYJ0mPToHBsUg6FrwBS2+nh/SBixTSyqALQ8=
X-Received: by 2002:a17:906:d54e:b0:b73:8307:4e95 with SMTP id
 a640c23a62f3a-b76c5356e5fmr1015741566b.4.1764239566978; Thu, 27 Nov 2025
 02:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com> <da99bb0bcd8c92e0d6de8b929b67095fae251f88.1764211096.git.gitgitgadget@gmail.com>
In-Reply-To: <da99bb0bcd8c92e0d6de8b929b67095fae251f88.1764211096.git.gitgitgadget@gmail.com>
From: "Scott L. Burson" <Scott@sympoiesis.com>
Date: Thu, 27 Nov 2025 02:32:07 -0800
X-Gm-Features: AWmQ_bkPzhHAlIq-0VarNUAVqXoD8tD1bXIXsgq-Y6lzINihheY3S3Y5ud0X8NE
Message-ID: <CAF5LJ4B2PeLPZi5gD6Htqdwhj5T-5U9Od_NhDe-8kXTN1-v6_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] diff: "lisp" userdiff_driver
To: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jaydeep P Das <jaydeepjd.8914@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025, 6:38=E2=80=AFPM Scott L. Burson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
[duplicate of first message]

Hmm.  Somehow I have screwed things up so that GitGitGadget sends out
only the first commit, not including the changes in the second, nor
using the PR title and the text in the description.  Sorry for the
noise.  Is there an easy fix, or do I need to make a new PR?

-- Scott
