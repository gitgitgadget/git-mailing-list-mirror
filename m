Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C6434B434
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672165; cv=none; b=l+agM9rA/TB9EvTrUrKy2je+TPBfehPnG2uwW9trQZLXlEidOB0zNjrUeP+zGaMxcD2bcECJag/hY4P2hKuRCjqVVuyln7I4WQ5ROAyc0i5WaXcdms2mRTO5dhXuB40edym71z+5Sel4UHa8WzSwhnfh8ZgYiIU1vsLwaIhkPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672165; c=relaxed/simple;
	bh=t12pLepbaiywwtxiX8NW7VNspIgek31FI2DW8n0Bm+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzTpOAtsHoMeOhlhxgJr6khACvgXxB8dMgkX07ig4kEN1wiVHbD25LP8+tqoq2ig1etvJvrd9nUHSzzTkmB3RffHl00OdqQbmvuDY8OBjOpRvs7ekLkSpOGBVR43Cu3bKDjNC2jlQRtVNv+a6j415SLVWHBvR9qHqggJnIZm49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILwe1k45; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILwe1k45"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-362acd22c78so59066011fa.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672162; x=1762276962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HIyZ3eljq7xvDywECoIqQfwaeX6Ymh7q8LvJUFvxvc=;
        b=ILwe1k45v2q2UHtzc52DaPugZwo6fM2Ti3cfqXTlTk/7+1zlldMmN/en2i82YhSPbl
         RPXwvyxMc55sinksjhQ3ucLGwuveB8XTrGt+wtZoocILkf3+J7cCsbDSBDvTCRA2WMg2
         72luMtw5zhmDN5EpwwYhAp5f6WDwgOHoGXEPgaM4MOALS+3TMzHHoyUevozHZ1JgZbEb
         Gv/K3Bvt8wjT4vvR8c60UvxDPWB1zi+qarx9JPkLtmtkdBdJTNqBU/M7xjKOx7lzuVyn
         cm9+a6tL2kjiH37/eYAXQ/YtjL2PY0dU5ZIhcxsUlcvNW6M9TcigBaKYSappfwLAaC6q
         nWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672162; x=1762276962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HIyZ3eljq7xvDywECoIqQfwaeX6Ymh7q8LvJUFvxvc=;
        b=UozebQvw2ueJBDPrEmAQKoQ2rsuZlRiljcaMrtZNeDX/57QKp6HDOs6Txn3TAG+a1z
         3O4vTIsdwJtfkdDxk2NdL1tb+/kRNVKD3/avd9UBVVKmJEZg+CWDrE8cOT0LYyE8G9lT
         Ihy9i65ZchFfYX6IqZwyUm9WVW1MA9vM4MJkZ8TeS97KOxS6Vp69Zxlt3yl2uUnnWqAW
         ChwiUWyjTzdnzvvIQR+6rnG2KvY2AdipzY7Nl9wVR3AIsEwFg1eDOrPE2rMHwnGyfaqi
         3hTGCv7S3twwYm+lTBBaC/ryEkoiD9oaeRMeauSvS2mfkwE02jPVD8q3HTOewnFhXHeh
         /TBg==
X-Gm-Message-State: AOJu0YyiT355N+zaIMqQHA9G77qVCa9ZaexoRs9LIqH4o8O3sx9VKVFx
	BWKWrdVqEmikTYe4CYqWlD572nhFcKu5XAjol3ZTM0GUCTTz4XZB5TCsUpetxXH0Gy4KczjQNDh
	cwbzPdv62b4KdqNcpCjZ/c45EU5b6p7U=
X-Gm-Gg: ASbGncsqhQS/WebeY3vJaKgA/eUWUCci/NYAjyYwk/95XsI+oLYwbqk6mBrhT+VEKTW
	Cuc1a5CnuF7kag19dd0d3ycqQPz5BS1tNVuHX5CaQcafStwdB7Jv12op2fIBrAA94eVleW3nakt
	/Okb2HOoeYqLGWxykE86EM7Fp0HQXHMpIHzKSygFYCiHvKtaoFr00Vsm4luuHKrwszWo+R717kD
	ZXb/rP186Oo1OsMM0GYDYbMfiP8uqK8wyr5/Pzwp8UBJxs5udYx7rF1JgSUyw==
X-Google-Smtp-Source: AGHT+IES6RED6aNREWq+NFLsMd4NFSwfty3AHvTfJ3v4x0OgWGew44e/lTj0uDAfCWU59e6rSVVzu1JOgKPLuuHo2tE=
X-Received: by 2002:a05:651c:1462:b0:378:dced:2c89 with SMTP id
 38308e7fff4ca-37a0537d1cfmr608521fa.49.1761672161443; Tue, 28 Oct 2025
 10:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net> <20251027004404.2152927-8-sandals@crustytoothpaste.net>
In-Reply-To: <20251027004404.2152927-8-sandals@crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 11:22:30 -0600
X-Gm-Features: AWmQ_bm8T6mmeTq_JHSGeEMmOs27isYBR4kgp2ltU7lv48_ZBuNl-92HlqCoAtM
Message-ID: <CAH=ZcbDYq1A79rNmFULtwPMM2z+4zBH-DCgCFOEA4Pt1D76Swg@mail.gmail.com>
Subject: Re: [PATCH 07/14] csum-file: define hashwrite's count as a uint32_t
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:44=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> We want to call this code from Rust and ensure that the types are the
> same for compatibility, which is easiest to do if the type is a fixed
> size.  Since unsigned int is 32 bits on all the platforms we care about,
> define it as a uint32_t instead.

I'm always in favor of converting to unambiguous types.
