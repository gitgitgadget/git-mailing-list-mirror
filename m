Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B81149C41
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754141933; cv=none; b=HQ+5/ZSwN5DzKP34VaIwKQ6TDfIqx3QCL3G0iNzwKa0BE1JFJAUqhw3XRVKx+D/JeoVPZsWZBaeVuJA0T+cUn2j9H0AzJF/E4qCbGn0JDGTW8I4gFBtnmWLrCk8+yd2uTv1aFGvfI+3yg94+hFdJAaHkp48BxfCZfOmpOrvy/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754141933; c=relaxed/simple;
	bh=GFV3A6PsEIG83ztRrpicmz6gAREHFmuqEkytXbRx9Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7VstSs5pKyRN/icOmBhsfNAA3c60/fmj1dpMbAxE0FkoOSStUknVTtGoex7uc3RTMWYQvd0MrMOS9ec/6as3MFa8u4/rV58/jfacrGiIJ+xbXf7ozdrwcv2r5cCOewglnQtG3jCY3yzvE6b+hvYfEH90jTSoUpmaDI1dsjzV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgi1OeAS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgi1OeAS"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af0dc229478so275054666b.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754141930; x=1754746730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tnABZZVtWX4IOyEPPsukuGh/qdFCwCFFPO7xZjkyy0=;
        b=lgi1OeAS06XImANW7CZXnOVju+SlFiFdJUBzAlOaJmIXLjZ81gKrZRrSO0UIjzU2ex
         4TP71FQVMoppkN4n2mGcUAmnZ2/Ec9ip3gjvO7lQcAKMpTu8KK2B5gJu9e0QZaiXWhos
         1yL1Qhj4ix1rM5nBT6CWZ9sRkQCLp+PuKKDJe04/MLB7gUR6azU3S/k9yIULDOyTXGQr
         vMSxdUT5fOFSPpcXQB5RyEPtSP90tqsnf3ahdxPxHWORJ1ixyF4yRD7SM+MOIjjx+dpN
         E2hRKDyx0JaBJbCuXXJ2SQ3C2F0yQKUPwfm4EhWgqeJtROW4Q1vS22N2mJETCVJAWoVo
         hfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754141930; x=1754746730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tnABZZVtWX4IOyEPPsukuGh/qdFCwCFFPO7xZjkyy0=;
        b=UOh6/JZw9SmiZcB4MlqBX202u9LoatTWnLliq8OaGR9YvDHdzx2zdXZYEMzdJz1fHn
         drTBYYXJ0ypNJreB+ZMp8UgrnjhzgCiT9/I/ZassjxQ0/19xNuFPGznnBr65DBTUzNBh
         4VpXVBr547EPrZ6AkXMFEzEc0MQh9yWiXe+EmBzGbGw5xT2z2C9R7w9imiMY3ArgpkBT
         9QNkgUkRiOPRX/7ubhU+BHOG88WWMRcJhmYKJaE4zZZpXC8v9/Gu4007zWo1SGVbzxqs
         Kg7plwliv2kekEpTlBuNLjNKSeZmy4jDAMhPWW++W5ALUppDUp2r4LSlV6mpGaOIlY9T
         marw==
X-Forwarded-Encrypted: i=1; AJvYcCVN5NpTw1TdN6vHM1oUa35QwxEeoKOws7DmNqAJZLVhttGPjU99a7I5VezruA0rrDyRdHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5m82ApsKNyeVaqKT/NW25IkWahHqYz+JNR2wSM5TMtgLLybw
	tgUj+QJa2E2pFGie1uJAOorx79jCg8Yv2n1+v2AJ+/fcFtlcFs3BvoGYDQ7h4YCDdNRpkw9iXmZ
	qhLPl7hjQqYjsGFMnFth+oD4NS5PYJpY=
X-Gm-Gg: ASbGncunhHCoAv57CadV55ZXOq0wtv5960qRNt+TfKh6oSYENDhDtX6P5ilrOY3vy5d
	74Ua/DZ2IoESQgawJHB7aZH8cHYu1ftUvXeoHum3bsUVH1QJPPN/H3nkLi5gGb/KOLuDRBs7ERh
	I1HiZq/apULkBkMfEJWmD7kR6xe+PJwiO3tn67PqAJycV80KYgIJ3JmA7ckyJ1lejbS04WIBMR1
	XydADUkWA==
X-Google-Smtp-Source: AGHT+IF06IAiErxohcBpjfEzS/HgDMr+ARJI+P/0fgLanBgBP485LuzoARc2dOIJjrSKhgxMLK9HGOGecbM1U3oi9LI=
X-Received: by 2002:a17:907:3d9f:b0:af9:3d0a:f382 with SMTP id
 a640c23a62f3a-af94019049bmr349717766b.46.1754141929554; Sat, 02 Aug 2025
 06:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716133206.1787549-1-toon@iotcl.com> <20250730175510.987383-2-toon@iotcl.com>
 <CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
 <aIyVft9PdlorttzZ@pks.im> <xmqq7bznm0nk.fsf@gitster.g> <CAP8UFD3rV5CmHbbmg9vQodJ3U=WxfmWHnaio+7RcBAKz=2Ar-A@mail.gmail.com>
 <CAP8UFD1hdykpEaFrs1VoHbU1f-vT7xL2R6uvFWzjPQKRp0eoEw@mail.gmail.com>
In-Reply-To: <CAP8UFD1hdykpEaFrs1VoHbU1f-vT7xL2R6uvFWzjPQKRp0eoEw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 2 Aug 2025 15:38:37 +0200
X-Gm-Features: Ac12FXyC6-YykDhkNYzpFPtET_sujq61GnDEBOP6PMLgA2VU_MYJ8kybYAqVMnw
Message-ID: <CAP8UFD0Hrb-=TRNkueBw06Mgu6Hp1zO8qZVOFVLi8Qp4xkas+w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 1:31=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:

> Q: Do you have other examples than strbuf_release using "release"
> where the function behaves like a "clear" function?
>
> A:
>
> Yes=E2=80=AF=E2=80=93 a handful of other helpers are spelled =E2=80=9C*_r=
elease()=E2=80=9D, yet they
> merely clear the inside of an on=E2=80=91stack/object=E2=80=91lifetime st=
ruct and
> leave the container itself reusable
>
> - Line reader: void line_buffer_release(struct line_buffer *buf);
>   Closes the underlying file descriptor and frees its internal scratch
> space; the struct line_buffer itself remains valid and can be
> re=E2=80=91initialised with line_buffer_open() if desired.
>
> - Packet=E2=80=91line writer: void packet_writer_release(struct packet_wr=
iter *writer);
>   Calls strbuf_release(&writer=E2=80=91>scratch_buf) and clears a few fla=
gs;
> the struct packet_writer lives on so the caller may point it at
> another FILE * later.
>
> - FS=E2=80=91monitor IPC channel: void fsmonitor_ipc__release(struct
> fsmonitor_ipc *ipc);
>   Shuts down the socket, frees small temp buffers, and zeroes the
> struct for re=E2=80=91use inside the long=E2=80=91running daemon.
>
> All of these match the behaviour of strbuf_release() rather than that
> of the many *_free() helpers which actually free()=E2=80=AFthe struct its=
elf.

Actually it looks like it hallucinated those examples. It's true that
strbuf_release() makes it possible to reuse the struct, but it's not
efficient as memory needs to be reallocated.

Sorry for the noise.
