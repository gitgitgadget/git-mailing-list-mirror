Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D080618
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529941; cv=none; b=ptTxXX/Jdyi7kww7Qm2Ap8SbCQe7b5wijBcIrWvcfT0hTnOB672tKJE239Rh3K1IQSSrMQJzPx7gd1Ng0ZRBuXHsqQA4EryE1MrrTjMW2vZ60ngbCtwz6NhZFHPuvtL/mQNT16ehausPOjmA/D7YWCK9/3O1qyJDj+Qm7SRqFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529941; c=relaxed/simple;
	bh=jiE2dT1Gv08gJOPR2tcj+CHn5BqGi0uZnIfv7Mtmcr0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=W6VX4q7qhDXUeh+ZeMBuL0qjGwmZ0Z/R8ClBPzqr70YN2WZlYgOkMZPPnnpMZ3498wVGUjbjSI22teciRKd2/CGzYBBnN+m3QUqgomvNzD7rbCfbMxw57JLwsHLEs2zXVg+hB4vnm67W8wpm0clS6o7VWSOvHTV+p6t1a+79COc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN2Th8T0; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN2Th8T0"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59d29103089so247909eaf.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708529939; x=1709134739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiE2dT1Gv08gJOPR2tcj+CHn5BqGi0uZnIfv7Mtmcr0=;
        b=mN2Th8T0iOueZbLzV0cKkXKe9qCtJ8XuuBA2qrBj58xftUQEaqTnoAO6Ugy+g6ldED
         1H41NuX7BjWm30jR2dezIDo+g9HH8ico1TQfiMxIW7uQXbh7eVQjWUvQ99gnVMDONYls
         NOpRsfS+uc0eA70cXIstMbJ3IxIl7eOXD69krYgtjIWr8AzihnLVDHfz9NSBfAiap7yp
         8IoQIM3pPzjBXCq3IZsrjizdgntaMv1kWj0sAhKP6Qh2iOlGarsNqemAD6sRRlbwWmZj
         mTLccLTwfOBiU3ZbNFZJWeYbJPl8eDADZXHbLvxIU+fXqVTqkqtxF8JgFNg/BnPhvd+e
         sHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529939; x=1709134739;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jiE2dT1Gv08gJOPR2tcj+CHn5BqGi0uZnIfv7Mtmcr0=;
        b=BCgGFOTxMKmVSpA0pBKEuVyMwCL9M7kIgTvNPn01mSqKx9cnEJ58iK78KhRaT8yF4d
         t2bfxebwVQrkR14nrYDAM3BcS6xHShzppJcarnn6gv3uk1R4lQWrs3uGMI/vSpA9FVUf
         DHZZWba46TJHmTZHqzB4dewLqZVyIGPriR0VXDjQd8iEBqHrJ0D0uoORpt1VzjiB/G6d
         D7l6NpGUj59/WsDHZphK+IGaO1MpVgoH+CoZ4ul1VtotWi47vywzl7JCVWJAbU4Y4VKz
         7gTGZwsrCMHZMyA/sXwJUNUVfvpPDFraoOe0BhaJMRynLLCI6HABAYMhdxX8tK3tYH7E
         PPXA==
X-Forwarded-Encrypted: i=1; AJvYcCW1el4eJaRsV3WSW4nti4Kejdt/EQZlYmkN/2aMjz1BLmQ+IMedqfGENzgDOtbLvffgFvuv2yDd4TnekkDgxVXef1W2
X-Gm-Message-State: AOJu0Yy8bjTsmd7CAXxk3tbWc1ZwPuxW2W89vkA5gv+mz26ebuUQabaB
	NJpbnxNQ7aaVXE70Q49KUQ9L/Fr2W44KLN8bL7YPQ7F5W4u1QasPor/+k045
X-Google-Smtp-Source: AGHT+IFEk0ttXu8qGCGk3BJoCtnxDj/7s6sg8ZNru0N58rKQ9BKLRdAvfbPQ3GlqPWK0zicdddyeuA==
X-Received: by 2002:a05:6820:2c90:b0:599:e8ff:66d9 with SMTP id dx16-20020a0568202c9000b00599e8ff66d9mr17274966oob.1.1708529938712;
        Wed, 21 Feb 2024 07:38:58 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-h.epic.com. [199.204.56.213])
        by smtp.gmail.com with ESMTPSA id a4-20020ac844a4000000b0042a9b28733fsm4501079qto.89.2024.02.21.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:38:58 -0800 (PST)
References: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
 <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
 <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
 <m04je1dhdx.fsf@epic96565.epic.com>
 <CAB=tB2uZb+8QLmrk_tK5PKJtDE=RmBr=eBBb7U7ygSmkFoXvWg@mail.gmail.com>
 <m0zfvtc0a4.fsf@epic96565.epic.com>
 <CAB=tB2vKj45yr3amMbhv_dYBdqYOtoiMS7Ecx4WO1TE2STHEsA@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Maarten Ackermans <maarten.ackermans@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: Breaking change with "git log -n" since 2.43
Date: Wed, 21 Feb 2024 09:34:28 -0600
In-reply-to: <CAB=tB2vKj45yr3amMbhv_dYBdqYOtoiMS7Ecx4WO1TE2STHEsA@mail.gmail.com>
Message-ID: <m0v86hbze6.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Maarten Ackermans <maarten.ackermans@gmail.com> writes:

> I think you=E2=80=99re right, so reinstating the original behavior with a
> deprecation warning would be more prudent.
>
> After the grace period, if invalid input is given, fall back to output
> all with a warning. Or you can go the strict route again and crash
> with a fatal error (hard to imagine an actual use case for such a
> large, specific number, anyway).

To be clear, I'm not advocating we go back to the prior behavior. I'm
just clarifying what your proposal would mean.

I don't pretend to have any nuanced understanding of how the Git project
handles situations like this, but IMHO, I would have to fall back to the
principle of least surprise. Rejecting invalid input is not a crash --
it is a useful guardrail to ensure the user and the computer agree on
what's been requested / what's going to happen.

Again, I don't have any experience with how similar situations are
handled here, but I would contend that the behavior you describe as the
breaking behavior is the behavior that should exist long-term.

--
Sean Allred
