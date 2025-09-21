Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E9E552
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758415108; cv=none; b=cLBvffGdC95AYkmPwK7UaajOt47FcX1iaGAdb/dNMbj/9mSNQWcDT24/d+lZCBVprpacJJx46ndJNmht/dwTh9BT2jZA9IiJJXFige9nmDEf/mRzvpowULiMCkWmeI2psCGCy2PQFlik24PS84zH3VA0djK1+84V1RjS7KYey9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758415108; c=relaxed/simple;
	bh=sZjpqrtou2cnrKZ0S7IiyHruWJN6Y1ieOevZH5svTOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fck0MFTley9piiczdpeGtwoXQwXACerr1tzoDN8lOCsSHu6CvTtvdD98S6bIPS598ugCSxkFOhZsg0Zp06V8PKK/2oWfx8E6kW70zHK+3nIJYIEZcRQJLcHU86nHnCQKuxtD4emfqNLoDdMZIFXNTjPKXACjG/+2ky4baGADMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqoR1B/W; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqoR1B/W"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36a6a39752bso1087571fa.0
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758415105; x=1759019905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFPpUqVNvu5npGXXd+/LbuAlBrN1kNC9H2dgU0A5i9Y=;
        b=fqoR1B/WCbh7e/LdryL+GB6lu2dpQhHLOr8LtfaWoAecvM9Ol15RaScEMsB1sTkt/U
         E1w7+kapl+rD5/Mmag1akC1JY3AhQWMW1eXMUC9OZVljdvqDilIciJvIXWjc8f7WSd75
         pUXnDGGZmHZtOD2L2Otd7lSECG8Ip7Z+YB9thwHEwNtOThuQsVl4ZPQow8YVVIezoDzC
         s0pAJzxkov62zb5xB1cGi2nplpVp8hpgsVHeMJIAxZYDVW3AFHRNu1oHFuM27kJBqEbq
         u98AvwKDVZSOOj0wXvQKxAPanIHnDATRYvm6D8nk2K+3kMSW0+naOLEr9kodzVURrF62
         MdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758415105; x=1759019905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFPpUqVNvu5npGXXd+/LbuAlBrN1kNC9H2dgU0A5i9Y=;
        b=ZtKtBsph54IZ/nLEtPxu55X+SzSI0VamO0qAd938zj7VZPV3YZVKFCVnfs32XVX+VU
         02zNbuSFLNVEhkBWYba+SIpzO4UJJE4uOa8xOTxxQpntJeTtpY7WJwyfA0fiDtYRCo3n
         4lQV/UZ8/VctsLludKzE7j3gz0846gVOpmyuds+/93ngKnb9ngmJ8zSa91gEm8xKMmJd
         Pj/BJlboYgfGAfFo4Dbe85dTuix+VBHIDNu0fvFobcMpCx1joBIJ52t89wwi/y2uniyL
         DA80g4cvRfFcE87Y4/eaeEVzALeCENQmBMKfyf5qV+B9lI7xfiBem48SVWDYzNKDUMyy
         nYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi3caqkkncEUSB0ifK+tOUs0Gxqn0DzmCH+hWnkdWvb74BB2zi473r5uZWX6nx/rhsIkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWtLbxHNbVEj6BIdM4jWFR7gzTPpMj0q3PVze+INx1bg9Zqj1
	rgdV9tERDdC5jEwXdk7BV7CfO4aFXnZcy7FnYa8kO9+62LC1l525Afd/5tVLGSHQ/Ex5GrPZq5N
	aPBlV4J4B55ayln2JvB3zru8Ukn3zGfg=
X-Gm-Gg: ASbGncstjQVmNmpZr4tmUtr0TSEWHFHhLndXQBtOtz0Sok6BZ5sBvkXefYP8sAN/QCL
	8P5Tp/9O9gt75d/ayDY28Qd6dyegJNmxDImNf3GhjT47dxswst2RBFG/S3p7npCy0mcTWQvy4+4
	V8zYXdT3msU0V/0C9Rf0208K9y1CSGRSzNsQJE/jdbadr+RjJuqTt8B1VLXEpysTjZcDwpL0rtH
	BZfxsbj
X-Google-Smtp-Source: AGHT+IHbOLV4Ta4vxxt4PzqTOh/VIdgMXl6C7GZS2BUMU2jzHZpMgunkvCM79pVSrsEi0YOs9yCHaJXVcDZLiYktqnU=
X-Received: by 2002:a05:651c:4344:10b0:32c:bf84:eb05 with SMTP id
 38308e7fff4ca-36419e3e855mr28720101fa.33.1758415104894; Sat, 20 Sep 2025
 17:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <1e404c3290bd4ba8b4973a597b976c301138cf73.1758294992.git.gitgitgadget@gmail.com>
 <xmqqms6owu7o.fsf@gitster.g>
In-Reply-To: <xmqqms6owu7o.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 20 Sep 2025 18:38:13 -0600
X-Gm-Features: AS18NWC7rht7ovIC2vWiFp2iNKui7bmAzy8KL5uxf3HS4WAIURUyTY4sco3sxEI
Message-ID: <CAH=ZcbD4oi1hdWDK8s2g6mQGrk+kwWffnSYE5gQZ_d3Z2Z3euA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] xdiff: treat xdfile_t.rchg like an enum
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 6:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> I am not comfortable with the idea of exposing a set of overly
> genericly named macros like these, especially when they are *meant*
> only to be used with xdfile_t.rchg, to those *.c files.  So far,
> when they include <xdiff-interface.h> (or <ll-merge.h>), they have
> been rest assured that their namespaces won't be contaminated and
> they would not risk stepping on others' toes as long as they stay
> away from inventing their own xdsomething or s_xsomething (neither
> of which is quite similar to how we name our symbols and types).

What if I move NO, YES, MAYBE into xprepare.c and refactor `char rchg`
to `bool changed`? The problem with bool is that C needs to include
stdbool.h to match how Rust defines bool. git-compat-util.h didn't
include it, then it did, then it didn't because compat/posix.h
included it instead.

How do you feel about xdiff.h including compat/posix.h too? If we
don't use bool on the C side then Rust is going to be littered with
some_condition !=3D 0 or other_condition =3D=3D 0 and won't be as clear tha=
t
it's a boolean instead of a numeric type.
