Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601D23817D
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376157; cv=none; b=Ye4lySZ6gutT3FLsE82YIkC0gG2vDI60DlqxmF2zfnKjKPvsKDEGHYdGJfkVbVXT7aUUP4bZspXdFcewLRQ0OFCTsDnjeUrwM4t6r0uW5wOl8Wh+71UOkCSFKnBGr/biCJ1Q8C7bXxyKxzerKt0RX+RY0LnByoHKtEXHaIpdAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376157; c=relaxed/simple;
	bh=+/S+mFad6Xv6sRRVW4+ku37JRmtbafcrKXfUvWf4PcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnHcp+4mHejXs5B6pTySRbnl7cOOFzpY6mXbzIhMC3bebP2hIbaRbXCeoG28RNmVTTyld1kXAGxOHAi6Z0V6W6Lii/QaDF83mWtYGZkgkia0he5BiMrfv5Oyz7P+9rpeo4xfqmY3WNPpY+6bSWdYx4gB95pJyrNTNyP+bPVFpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE0BG+Ra; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE0BG+Ra"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87499a3cd37so38964926d6.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760376155; x=1760980955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/S+mFad6Xv6sRRVW4+ku37JRmtbafcrKXfUvWf4PcE=;
        b=LE0BG+RaBnqFiyBrholYBV98EFqlfyjsQhAanpz4gOk+99WVYl54DSQsiVasmLQtaI
         s69sWAL7Wadmk5/ffVo4P7iU6TUXTBpvZ5WUCrlvX+P2CJ0jeEXLvq+HOOeELytCI2WN
         Eolhaw1qmUEnGhNX8tjJAR/cKGX6GcMV9peMs0x/zyLhoq+YnBd2IjIoPsRX8sMFghzx
         pRROuUG1w2YR6bq7WydOCkMDAzAiPPzcr2WYCCKJYKykpiMHKx+3PuLnvWaPV+5XvNj3
         Vo/jF+0cqhH41qcEvBex/p5Mj6Z8qf1agKGNh3049XIJFZC6q9ddlU6OGqKSfjBp+G76
         Xfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376155; x=1760980955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/S+mFad6Xv6sRRVW4+ku37JRmtbafcrKXfUvWf4PcE=;
        b=iCfx/ndkalep3DPFAh5m+G012+c0g2b7aNJMgy4eg1t4zJfs12cwM9m7jC8Ihrd1/O
         iRogDpVR7KhvsZgYOh9WNvZQgKmLzAzin4etltaDXHNjvrjWr2m2I8coClfqYeivpN6p
         44FRch6G/SakLBF3hE3i2cANor+ZwDkg9Dj+2PI20qO6tWWWkURYq5Ns04xKAQ09QRhU
         cWKChQ1bqvNg03ikAyeJ/YOsWuQrOFOHAo3gQIlT8cqIUaFqTjqmCytvf+ZpgndUXAl7
         9bvZPJBPKegTBv0VJo+kTfjgIWDU/GuzkaACEmjrDYx5ekz+ED1aK5nu1+/xdEIcUzX+
         2mVg==
X-Gm-Message-State: AOJu0Yx6wXmrTNjj0XmLCig0/ran7WiBbouXa1ND44ME47UnLOrhIqcp
	x2Ck/ye5B7VM9LDl4d2gydgy+H/3WJdEST8rXavptfWGmN37FX+vOo14exEeCUBJAMAlo9SoFcF
	ZouY9Eb0KhGuxpk9apo1xWCcLSdYsxgM=
X-Gm-Gg: ASbGncuZ36BbUvcU/s1yVJ5nUBcd7FFmhr63kUgY3jPLnM03U18Y8BCENdWonmWYVwN
	q8HF2lpdEj4ve2WdZOOFxDfe2lfLJrESnaqvWiTYZatpYVFDKgF0bx1f+uJC5PszyoFfB57eXBq
	f0M/XRVphtW7TOeszXGBjOzicxhok1WYXttsBAAU12Ck+hZgvDTcuvbDj+vC7uBMwIOBiWi0Ydi
	Ud55L+7QhRhXJKfLgadRaSpl7Bn3awK71CdVkRxgUJNhzrIomzX5GGUu3QlGPI0kQ/H2beTB8s=
X-Google-Smtp-Source: AGHT+IFQ+Yos64s6aiNkbNHeK4LVTglW3LbbtWufBab2PACfkaSGBldzZNgScthbaRgv1vrRF6/2ODMlNBdE1bC4XJ8=
X-Received: by 2002:a05:6214:2528:b0:86c:7f02:ac62 with SMTP id
 6a1803df08f44-87b2ef44c4bmr333848436d6.54.1760376154958; Mon, 13 Oct 2025
 10:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013165320.201333-1-okhuomonajayi54@gmail.com> <xmqq4is23evz.fsf@gitster.g>
In-Reply-To: <xmqq4is23evz.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 13 Oct 2025 18:22:24 +0100
X-Gm-Features: AS18NWAgHkdMwvOOraixbYLypZ5-Wx09wllFDQje3WJpA_jfRki8boHfbLDDESI
Message-ID: <CAFpMFfBXhfy7ecBzR-cnGViivQG3AHGrQ00vSTnVY6OdxZPSLg@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that explains it.

I didn=E2=80=99t compile test before sending my mistake. I see now that opt=
 is
passed into commit_patch_id() (and friends) and those functions modify
the diff_options structure, so making opt const is incorrect. The real
issue is the mismatch introduced by the hashmap API declaring
cmpfn_data as const void *, which is what the NEEDSWORK comment was
flagging.

I=E2=80=99ll revert my local change, run a build and tests, and then think
about safer alternatives (or leave the NEEDSWORK comment in place if
changing the hashmap API isn=E2=80=99t appropriate).
Thanks for the clarification.
