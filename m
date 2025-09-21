Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942315A848
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498138; cv=none; b=LnKiklmt08lLWI5ulE5HWHy2ngZPKgeJkp4i19/PD5Ot+T1Hh9zu28nF5v53vabHV2LFlhL7o2J2iSAZLQka3Kbc2QUsQ763BuZt7+q6I415VqjIPcDkri4jtOfMf/25iF/Zvk36WNO63ewbAsMCIGdFHygkYZmJG8K6CET/clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498138; c=relaxed/simple;
	bh=ydq+lhmVnz4xYHVxH86ettiFQdN0RR5+jwpC2ZPalgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTPym8ZS+80LewaSUbT5iaeCmgavkEEg3Vzte9RImvcNcnmTfwsyrkqv5yxHx9Yciz8LplF1ArDrIJyK/043ODmjDgLpjcBrWe/ZYFFRtPopwbDeqiGu1OkZLq8vgMbdPjTctFxZ8jkjzMCfkOjwC7KBgevv2vHrxiZYujtu/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6XCpi8v; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6XCpi8v"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3652d7800a8so18036271fa.0
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 16:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758498133; x=1759102933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydq+lhmVnz4xYHVxH86ettiFQdN0RR5+jwpC2ZPalgQ=;
        b=E6XCpi8vfTjqAx1yuUmQQFpA1J1nWxh+3DV+TaVxRH9f3A60Gh9O0oa+2JRl1ocowf
         HAu0/aHzZjoU309CebBEhk6BTLanYVIPn0uCru0OsPU3GNWZBbpCsBpxJkAptL1jzxnG
         Yw0GYH5rm52C28AtjDcX0U/zH5Kbb6mNeiSPuzvQrOQ7pmcNR35vCQYupVPfhaweErmd
         deeOrOwcpr3xhvCmeSmJY0fQzDFznUaTHtpk4PzK8VKm01vT6CD7XC9CWo2vEL1XCTfk
         zpoEblFzZ7mNP+1sFWZv/hgRm9rhPStqWn64v80pi/mYyzDWPH2P2YxXf39abrc5YixQ
         wnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758498133; x=1759102933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydq+lhmVnz4xYHVxH86ettiFQdN0RR5+jwpC2ZPalgQ=;
        b=KDPlqmXI8GBrPZ1cS7ShIWby3sNFXZLGr5uqjnLNiq/9SOV++0sb60y2Ne3sfqiYi1
         MQhbOCyj75DrT8yVzkRrGxMEdoRRp/n1VKh2jR9PIe3wpF/0igDuoge6PS78c56T6uKJ
         eoWC+nrX198LIZZoNMhS/xgSiQbc9YNxGZ0NunwQ37u7lEOPs8mm75mviOe5OWPaPZy9
         g2k4ECVC5Sc20wPPUl1AjDin2n8dGhE8R71ewjQAQvP+oukwpTEPQ7egTuqvKhZhxqo3
         afER2wJ0T2589+StpqtY9WQtBnsVcATUTguquTyFHUbNhTKShZ5HINRBXYyKO6W1bJ8V
         y+2A==
X-Forwarded-Encrypted: i=1; AJvYcCUthClYKHQeKspC9QiLWxrOgWEauQoJn7NH3HnARpW0uUWp4O5lATEQwXA9GoRQ5iRDF7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyvc27W95WvjQVKcAWhY/xck4/Mrjjyxa/gPND5z5v6Z8ygnPY
	9kFV2maJf69xkFY8SwtkMrRC2yablEHnPgrHqWmc6PKdCpeXXiMqJf3DhVYBGzvrFWMM2rS0LS/
	kmCRyyR+E6nftwgK98gez9RuqH5I2p5A=
X-Gm-Gg: ASbGncuv/dduw/+AcQQTk1hy56r6Gqew2yGKyW3HaoJgsNpf47pNAr8zos8kU6Vak8a
	ezcH2IA5kbFK6SCTHuE379SFN0XBt03CGtjenNW3+ZFEAX+NDm+cvz/f+rZo8BkBxmkrK/jOk8+
	06zyaoH2KqDsSBR7yn+DD7Lg7Ki+cjCtEx66oq1ZaWUaQXQvaO+GFSxuFbBrZ3nhxPQIVKbPm2p
	hwbP4hJ
X-Google-Smtp-Source: AGHT+IHmwVjNOiRalOU2G6xPxBcPf3KXC8CaMiEIFjCOdhxT89jmdBaX+lnM4T5OVbzNbgjwdEXhxdeqk2gB8OLUvko=
X-Received: by 2002:a05:651c:2119:b0:36a:53fe:77a6 with SMTP id
 38308e7fff4ca-36a53fe802bmr12927211fa.45.1758498132566; Sun, 21 Sep 2025
 16:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
 <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
 <002001dc2a84$cda40380$68ec0a80$@nexbridge.com> <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com>
 <002c01dc2a95$400315f0$c00941d0$@nexbridge.com> <CAH=ZcbDGaxiW=QCTrRo3YqxS-rY0e5h5PrnKQt9htJfn4firJA@mail.gmail.com>
 <003401dc2aa6$623d1420$26b73c60$@nexbridge.com> <CAH=ZcbA0jpntXjPnrVi13Sz1PipnyBLNWKW4Q5taGEHqBrqj-A@mail.gmail.com>
 <008501dc2b4c$7f5ea450$7e1becf0$@nexbridge.com>
In-Reply-To: <008501dc2b4c$7f5ea450$7e1becf0$@nexbridge.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sun, 21 Sep 2025 17:42:01 -0600
X-Gm-Features: AS18NWCc7abnXNW-l579vCBiw6B7aKr7PN5BEWpUtP4alxkqmVqlgShXEmgpNRQ
Message-ID: <CAH=ZcbAop=z8-zA_aEE+sTHErg0gjzYRnqCd3XQF9=_TakBK8A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
To: rsbecker@nexbridge.com
Cc: 20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im, 
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org, 
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org, 
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, newren@gmail.com, 
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im, 
	sam@gentoo.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 5:07=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> Not really no. There is momentum for Rust on NonStop. It just takes time =
to get
> budget for the effort. After getting budget, it takes time for the port. =
I am likely to
> have some involvement in that, one way or another. NonStop does support g=
it,
> mostly through my ongoing efforts and they do use it extensively. This re=
ally is a
> crucial application and the NonStop team does understand the implications=
. The
> problem is that everything takes time, more than git is allowing in this =
case. I cannot
> disclose more than that.

Ah, thank you for correcting me.

> Yes, people are screaming at me to fix it, which is not easy. The policy =
is not the
> Problem, but the technical limitations are. It is not a surprise, because=
 I was involved
> In the POSIX effort when it was first introduced on NonStop, not that man=
y "in the know"
> Listened to my concerns, which are now having significant consequences.

I think you've mentioned threading as a major technical hurdle for
Rust and GCC somewhere else on the mailing list (correct me if I'm
wrong). That's why I've worked very hard on single threaded only
translations. Also, I've been targeting Rust version 1.63.0 because
that's what debian requires and so my local Rust development is locked
to that version. I've managed to translate a huge amount of xdiff to
Rust using no Cargo dependencies. I figure if I keep my Rust adoption
effort as bare bones as possible that'll make it easier for NonStop to
catch up to Git's Rust bare minimum requirement. I have been talking
about adding cbindgen which pulls in like 40+ dependencies, but that's
a different case because its only purpose is to generate C header
files from parsed Rust files. I can write my Rust in a way that
cbindgen can be disabled and the generated header files can be checked
into Git or acquired somewhere else.

I have 2 questions for you.
What parts of Rust do you think will be easy to port?
What parts of Rust do you think will be difficult to port?
