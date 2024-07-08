Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85507146A98
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470336; cv=none; b=AmgvMX4gluTL8jqtXSbSLVQf14P5gYl/uaxvI43tKhPd45vQL/EUTwpAdjV7wkHOfQMymg21yDKZi2fGNYrDTWf0VrwMUYEi7yNLq3v4HcNYpUX4ZlY/k41zSETgyGfQzBEuy5+Yw9CTrcZmMKmMRBRaAUj7S257o26qSwwTjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470336; c=relaxed/simple;
	bh=BA5mj8EXRp46ndvzsouQYvPxI7dxY9wAOuE4LOfNTlA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbVbdNTZq9udBfTXSP10/Hx7ihVq1MOLxdlaqCc5ipgCyZf5aLZIACMqKYOA+gBugtFWIWVRxkDk+f+knuhPl+4hzbSOJfDIho2qWNLQMdwb+tSJ4IAjZieBccT2eUy/gYfIo4JJxrx3vXVxJy532MNgejg8rD+zl+dZRsd9n2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCePZUid; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCePZUid"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3cabac56b38so2857225b6e.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720470333; x=1721075133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wme3ZkMJB1fxcTbaUrqbcRtQ0Y2EQsVGBL6GUMaUUHA=;
        b=mCePZUidmUvJyzBWtSRX6mU1IY2OK32/TDmmGuClzTh3SghGPpI7+QHnJ4XdDyErq+
         wGL2VsiQewm2/B8u55xSxKLu0Rt+hTqXbtRyXWtl+etxzwNHbFjdV3VWtbLPkYFuYkqO
         enj7L8mJjbeyzMmKsRUHo2kEg+k4qKDuszN66mydk5abYM/VjMrzqPUuaVfAKmwtCx8h
         g5QnGdM8LHQwKkWHXM15RNcc7Nzk1v02QsFBVel10FOGgk7RLm3JkyXdg/H2ZHat8r+D
         nUli1vp7fLwI4LK8X/4q/XVVQuhur7lIy/knXU64mmm3AtiJdXKKU9UU3PqVt+mYy/YB
         m4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720470333; x=1721075133;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wme3ZkMJB1fxcTbaUrqbcRtQ0Y2EQsVGBL6GUMaUUHA=;
        b=AyZe/SADjm1ixBSI61HS7j+nMbopbSOO55knAyktCjH0jErwwUrl6ew6/anbW/ClMS
         XgThSqxQZ2k5vY/0IumgpE+rr6VORpZSyKyT2riqM8ClolnEXM0IaNtswHzRTSeWdUK0
         jEneGHak4gF2qbp3DEO7r9THgNjfYM79pdk8xDclU+4rgCkcnVrvmwsjK7S9ud4jpsvN
         bbQ9JFi6qygbRFX3/Jaul6Z01ANu0wEjaZoRXUXjtl7qfFs02KspTgaQGQZkDaiNi/A3
         cJpDicT6yAJNzt1F14F6UY2PeKRCCj6ttNo+tEW3gahb86bkh/QSPxTlCA3UvZ5AwnFX
         KcJg==
X-Gm-Message-State: AOJu0YzRFi5xo9zYl1uxEBSJwhGmkxVXGdFnpR507P4kC1QNfnWrnpF1
	I8bgK4WDWlEQUmB4Q5u0kqykMBzBMq4kO/vnf0nqIv3QTPUc2iS73em/6UIHKgPibnD/k4HL3ly
	FBKWxOJlDPZpmKCh8GK4bFNCit3c=
X-Google-Smtp-Source: AGHT+IHlhHJeSDndMgbpb6eJQPGr+A8eB786L9mvLUoXRsVFekjOP54azWPBNPXpuJgcLCYwfjCbL6vZT4JGqccKIOo=
X-Received: by 2002:a05:6870:658d:b0:25e:1be2:a163 with SMTP id
 586e51a60fabf-25eaec17215mr409579fac.47.1720470333476; Mon, 08 Jul 2024
 13:25:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 16:25:32 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqle2bj0dl.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-6-karthik.188@gmail.com> <xmqqle2bj0dl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 16:25:32 -0400
Message-ID: <CAOLa=ZSb_S7X7pdFPp0r5bfNc3o95mGe5pU+rC1T_yM89NRqCw@mail.gmail.com>
Subject: Re: [PATCH 5/8] clang-format: avoid braces on simple single-statement bodies
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="00000000000012e797061cc23755"

--00000000000012e797061cc23755
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Set the 'RemoveBracesLLVM' to 'true' which ensures that we avoid curly
>> braces for single-statement bodies in conditional blocks.
>
> Hmph, two warnings in its documentation [*] sound ominous, especially
> the second one that says:
>
>     Warning
>
>     Setting this option to true could lead to incorrect code
>     formatting due to clang-format=E2=80=99s lack of complete semantic
>     information. As such, extra care should be taken to review code
>     changes made by this option.
>
> which implies it may not necessarily a good idea to add to
> automation without telling contributors that they may get hit with a
> false positive (or incorrect rewrite).
>

Agreed on this one. I'm a bit skeptical to be honest too. I think I
should have added information about the warning in the commit too. I
will for next round. Overall, this also contributes to the reason why I
decided these CI jobs need to be allowed to fail.

>
> Reading from the examples in that documentation page, it was unclear
> how it would handle if/else if/.../else cascade where not all branches
> are multi-statement blocks, e.g.,
>
> 	if (A) {
> 		do_A_thing();
> 	} else if (B) {
> 		do_B_thing();
> 	} else {
> 		do_C_things();
> 		do_other_things();
> 	}
>
> but looking around I am getting a feeling that the tool would do the
> right thing, i.e., to match our preference that is to use {braces}
> around all branches, if I am not mistaken.
>

Yup, that was my understanding and what I could see from some quick
trials that I did too.

It would be a great win to have this though, because it is one of the
things that always get me.

>
> [Reference]
>
>  * https://releases.llvm.org/16.0.0/tools/clang/docs/ClangFormatStyleOpti=
ons.html#:~:text=3DRemoveBracesLLVM
>
>> +# Remove optional braces of control statements (if, else, for, and whil=
e)
>> +# according to the LLVM coding style
>> +# This avoids braces on simple single-statement bodies of statements.
>
> "... but keeps braces if one side of if/else if/.../else cascade has
> multi-statement body."
>

Makes sense, will add.

>> +RemoveBracesLLVM: true

Overall I must say, I'd be okay if this patch is also dropped from this
series.

--00000000000012e797061cc23755
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 58b33af22c6f2284_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTVN6b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTZhQy85Mll2TG5ldlE5aStNWlVQNzh2Q21OUzBwagpCamRSaEhBb2h6
UVRSVDdPYk1WU29HaXduNzRIcUgzRU8zdnN3RCtGc3ZUN2FwVThVZXlKTnRIVXk5YUc3TytuCjJK
S0p5TlpCTmROZU4yK1J4dkJ5ZXJFd3BkbW9kR3ZPbVdoTWgzWVB2TWhRaXN0S0V3OXg3bW1zUWZz
WnlRTDMKU014NC9OTU5kZnJmQVptN1ZQYzdaSTJRRjR0WWRuL1A4S245bUtxaHZpWkQ3WnBuQ25s
REVkQUVUYUN5UDZRSApwbFdmejYzd2U2YXRIZkFqVUVNM0NPUktoMkRHaXlSTXZrQThGUDg4LzlB
dUlVSWhyK2hrdmxZdjBpSUluc29YCjFMUFRYZ3R6endpWE5qTkxlVHR3akFBcjQ4S0VHa2ZkQ0Yv
QklWSkZXZG93WXUrcjM2ODdiYVVpU1JzdGlZbk4KcmhFQWJSdHFNVFdJY0FUQnFXTFdkSmcwNklZ
ZG1kQStJZnhZUnIwbTJhSnBCS3pSdnFwNDdZM2VCQVFJL3RGbwptcVdpMEQxZ21HQjl2aGprVHZk
RlFmd3Zvb09HYUZSRi9rL0twVDFoeWwyNGdrYmxZWTk4dVhJcUlLN0h1MzBSCkxpU25xcW5zUFJJ
dWRTY3MvUVMvYUtnNUFYRDZhTTAzQmRXUzlTcz0KPWxpOEIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000012e797061cc23755--
