Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80714A83
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485526; cv=none; b=NM+zANv65e0XksuhxkioSX6zpbHoG1CAEN9OHMZDgL72hS/ci2BJEFkg5WIySDyVrFRHaGRvYzYsn71XDZJo4S76WKdWIDEX52Ko2v5/SuVgodbB5LmWsXMHEZKngoOcL0ci9jvYjghUW0ZIxryKqknCoWznW0Qf4r7CcNNcZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485526; c=relaxed/simple;
	bh=1K6ka75otplHcEVT5gUe/BACRxjfdcFVSncHW6H0s4s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=XP/mHGh8W31sUlUbO0sI4PITeuy5Rs2kylUDP48uIORg79QcSaMbblP/pcARyZgWWgmWWwD1c9xw0cBt/nYjkehUjE3/lNVXjPUPYUFADynxCR5mVDcRDNpd3n/cl33p4fcn3b1ElK7yzSsPmzx3lAjBeJ7lSg8YKWsCAIVz+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg2wK/8h; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg2wK/8h"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2eb5c4dad6so48917066b.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 01:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705485523; x=1706090323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K6ka75otplHcEVT5gUe/BACRxjfdcFVSncHW6H0s4s=;
        b=Jg2wK/8hO8X8ijNsAAezivhwrCWq1SccVg997wk+6lKkxZKxtDtaH7Ng3HUAlyC46y
         uBPbBZm2ql80wHpLYuf/QPQ9dGKMRjoNPu2CeaeEvW3tvCwP7HPA+IA7WegyjLeTKZ4z
         AfOky0RJe1/xAokrkIoS65OZSTKlTx/z2bf9oA193eHBENczuT6L1cchJpm9fOXwN7dB
         Qpui+3yixY4e0E5Hli2Ol2Qbl93xB+gNXQ+gDVwm/dcnKiyouADNNYHPXoVMI3mDcutr
         ktMkzikDX57Sy5ZL9L8jAlll65iNq/leA5U/XGXwaTBTZ60UdZlQJ6WgOWV20Ib2ddUQ
         J5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485523; x=1706090323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K6ka75otplHcEVT5gUe/BACRxjfdcFVSncHW6H0s4s=;
        b=vYLVcCaj0kj+Qmu34F4dUNO3uLx/BG0RyzyI8qOPUibvXRuShM4ngH5/DdAQ7fl5O2
         nOGhbpDv0jel5LAHJQWZCGPAQY8J0nkOiCsLiaRS+RVzYkLbJ4Fad0BJJOJnV3WQyaeK
         hHcJRFq6o7aXH/KqpSwikF1Z8LCEIi1OgIRBXXPPyVFOoXnnlVHBwjolaLWUVi+pHpzD
         IFdj2Q3SXS3ejIi5UMjWOgxjlKB92dctZl0GTZlmXE9bB/ZVDVUXfr3JulmCg5C2G9if
         9lcuH9sQGxsRpX2dHdfiTGGxGvu5Mmc5kAxQjTD8P7qQvKIJ5RQhb3bp2P1EEBr1NZ64
         GHxg==
X-Gm-Message-State: AOJu0YwuqaOE1aQglxsv6L22Ze4OR1dEMq3gojAvEhZxHed20NHBlsf5
	ozSFnvySRfq7atyM9+ym+1h+jCK9Pynhh7wAUdA=
X-Google-Smtp-Source: AGHT+IFuhY4uHZTwCsOuvx/Z6hwNLIj+73Nkx0ve4rTBxrjzsXoS+6s/rB5u/IrGTA+NZ1EK/K8eIiuK0gd4VeKNNQU=
X-Received: by 2002:a17:906:274a:b0:a2c:6bea:58a8 with SMTP id
 a10-20020a170906274a00b00a2c6bea58a8mr4740378ejd.37.1705485523001; Wed, 17
 Jan 2024 01:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117081405.14012-2-mi.al.lohmann@gmail.com> <20240117091905.14354-1-mi.al.lohmann@gmail.com>
In-Reply-To: <20240117091905.14354-1-mi.al.lohmann@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 17 Jan 2024 10:58:31 +0100
Message-ID: <CAP8UFD3g_N+JJ_cdas2ZdsBPxuQFBXW8yY+1nC6AKvQppOYaDw@mail.gmail.com>
Subject: Re: Full disclosure
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org, newren@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:20=E2=80=AFAM Michael Lohmann
<mi.al.lohmann@gmail.com> wrote:
>
> Just as a disclosure: I was told that my contributions are not welcome [1=
]
> (even though I have to say that I don't fully agree with the reasoning), =
but I
> did not want to leave these patches alone.

I might have missed something, but as far as I see in the email you
mention, you weren't told that your contributions are not welcome.
Junio reviewed your patch and agreed with some of Peff's comments
about your patch. It just means that they both think your patch could
be further improved. They didn't reject your patch, nor your
contributions in general.

> @Junio C Hamano: Please take this into account when deciding if you want =
to
> accept the patches. This is just for transparancy and I will not do any m=
ore
> contributions than potentially finishing this one. If you do not want the=
se
> patches from me, but it was still deemed to be an interesting feature: co=
uld
> someone else take over?
>
> Michael
>
> [1]: https://lore.kernel.org/git/xmqqil3ybets.fsf@gitster.g/
>
