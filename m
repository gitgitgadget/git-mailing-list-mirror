Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A354242D88
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610510; cv=none; b=UKaq8FBu2qukkr7pNFmZvrt67p2HkkIbrWM2qO35oAMdTqHwQU6WHpqnjH9rnGkkJnUxq5YmMTFpZQzVG1fb5OlipVXm+x3yHeRQ/59DczffOF0GWjoQxgsbxAboptZaxmPYsq/uHoakvrSXhshj2vK7X/mhLzpF1o85BWcHvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610510; c=relaxed/simple;
	bh=HuL0lXpOWw4BpRP9MAyh8k9Xkxni8sKvhL6dpoJawPc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0iyMec3gqtOdMHeYm2HMTqzeW0O3cellXjVQaZVvLucaPmj8GW/Y8Z/rmWnDr1XpXv3+Om8vQuwVrGZ1lpr/mflOGJQqVOidXMAKHcgTpxL/ToU7otnyRwtSqmaAK3rf2090Vxp7SK8yO1rxLu/sztUDyw3Ia6x4YcI1kMAQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBTk/jX7; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBTk/jX7"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b26332196so2820304e0c.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767610508; x=1768215308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuL0lXpOWw4BpRP9MAyh8k9Xkxni8sKvhL6dpoJawPc=;
        b=bBTk/jX7fadtkc02nTHoR2liBeB3YbZeU5v2DlkNfD0Uhw9lfnoUuqroZvAPZJCISO
         nuVbaWS/Dj53W7fQmd02pUmIFidR+w2cjy7ny8ECRLhHoJMcMzeObm6ftwqoj5I6NN/L
         u96/KTTBAbJPHmIkOozzSl5dGPU+7EUdsHzJA1oV9/8pzOetBPSidWEB5Kw9jn5W++Zl
         ta6p9TqxZ8urwxkFpdNMfcNWcNU9mPqTCm7Nw8SVEhpHKQpxK3rb4dGxvN/S/JbilNOv
         63+1AKy9TILfDGIporOP9BHqOMfseKI6Qw6EhU/DrvR6tWiOrxH1u08NZ4owPEIeoN14
         FN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767610508; x=1768215308;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuL0lXpOWw4BpRP9MAyh8k9Xkxni8sKvhL6dpoJawPc=;
        b=ODc5MEi1vDy272Uyd9Rq9508VxwaR0M2ZFzzYF8ypfOItgo+gzKuUYW5VudbsMtTzY
         xEjCtcEtv7hf4ZoolvTx4A8E4w3Vs4s88k5H/E4kyKOoLPp6xFTHHrbTZt2R/86Tb5/o
         cOvmeKqWJjgoZ2R0kv+XZ5VihautHmM1+k59neBQQdiadKLaJHL1KLAofmt7iVstg7wC
         Pez7utMN7OiHoLAbwRXxsm5DitRpotp4D12u76+m2l7c8ZOYXf4dJtNFvpmHIxE52KI8
         IV4aicke7t5szedO/pVG5OMFX7ANQ9A8e0O5ywx27XQqsGn5VzchYn8uECqR/GJaaEje
         ioLQ==
X-Gm-Message-State: AOJu0Yy0agQtZY1AyU0OTM3oa3ja9bQjk1vSs1/pcV5GXig2PTgAewhX
	q7u85xAgVn0KqmpEGcZkbpSmibTMSZ0Xkwy85tU7la7OFLmiiI+oSK0LiGydvBdXD2Rf8xfHXUc
	U1RSMp5Uwm5nphD018bMZbhuFPNVk6OM=
X-Gm-Gg: AY/fxX79syrqcSUCFdk6k2emwfSqswLhSTv45FCXpL54EXGj30kItOcLhCb2h+0IDdA
	FYd2GR3Qd2BlbhvrvzxjkwRO0jP87q1JKRUKKXiJqkYMnTBgrfT8Ga/Fp9DXe/NYcD7oav+xsIJ
	lujqTgN2DCHRV8jTR5OK6Xs7RxY/YBvA1kPDkOUnRY/xz8rcM8L/QkY65BSdm55+gicuhPl9mLQ
	2vu/a/PVwFRUYJq9IHE8CRojfIODtmfDeporpVkqzM1JhfuydlLks2uDDIAxBwDnUo2N+LTtW4n
	dvKIGuIDtX3Y9mgMJ4/J0HYVSnoMOYvj3dU34549
X-Google-Smtp-Source: AGHT+IGAI51am14VQO4f7qkZLVwq+MLxdUl7RypEWLahOaFnW76E8EhV+2w/T58nOMZrXRLheR6SKApZ4g8NIyS58zY=
X-Received: by 2002:a05:6122:1d0f:b0:55b:305b:4e47 with SMTP id
 71dfb90a1353d-5615bec9b3cmr15140859e0c.19.1767610508010; Mon, 05 Jan 2026
 02:55:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 05:55:07 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 05:55:07 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CALE2CrQoXZjkpd+Lswd=qME9nkmUGu3HK8XacZ+Xz6Y2w+=t3A@mail.gmail.com>
References: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com>
 <aVqIjHIi6aKvFYXg@Adekunles-MacBook-Air.local> <CALE2CrQoXZjkpd+Lswd=qME9nkmUGu3HK8XacZ+Xz6Y2w+=t3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Jan 2026 05:55:07 -0500
X-Gm-Features: AQt7F2rICPSUaW7WSVbzt9QdK9kt1NPij8zalYArTsR2THkZMHDEDtOjQDwXsjI
Message-ID: <CAOLa=ZQOryB1nf86BUkmL8JB88S+C4=z120uoExO7t9wmMP_Ow@mail.gmail.com>
Subject: Re: [PATCH v3] t1300: use test helpers instead of test builtins
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, 
	Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000006e81ae0647a1e474"

--0000000000006e81ae0647a1e474
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> Hi Abraham,
>
> Thanks for pointing that out.
>
> Understood. I should keep the commit message itself focused on the change=
,
> and describe what was updated between versions under the `---` section.
>
> I will send a v4 with the commit message adjusted accordingly and include=
 a
> "Changes in v4" note below the separator.
>
> Thanks for the clarification.
> Pushkar
>

I also find using b4 [1] to be very beneficial to handle this. Where b4
provides patch versioning and you can simply worry about your commits :)

[1]: https://b4.docs.kernel.org/en/latest/

> On Sun, Jan 4, 2026 at 9:04=E2=80=AFPM Abraham Samuel Adekunle
> <abrahamadekunle50@gmail.com> wrote:
>>
>> >This version updates the commit message to avoid calling `test` a shell
>> >primitive, as suggested.
>>
>> >Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
>> >---
>>
>> Hello Pushkar,
>>
>> I think the right approach to send an updated version after modifying yo=
ur commit
>> message is to modify your commit message to INCLUDE the recommendation, =
not change
>> the commit message to the recommendation alone.
>> Then under these three dashes after the 'Signed-off-by:', (---), which i=
s here,
>> where I am currently replying to you, you state what you changed in the =
new version
>> compared to the previous version.
>>
>> e.g
>>
>> Changes in v3:
>> - Modified commit message to ...
>> - Modified subject to use builtin instead of primitive
>>
>>
>> Thanks
>> Abraham.

--0000000000006e81ae0647a1e474
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 29c39753092308a0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sYm1Ja1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menFQQy85QWw3MmNEaFhRRk44U3N0UW9MMG1wRGg5dgo3SkxPRGJpYjlZ
LzZ3VXEwNlIvQVNiaG00YkxLVHpWMTNwYXQ1WEF6UVByK1ExejBhZGlmOWJ3cGFGejRXUDM2CnpC
dVIrSkdsNng4NlNjQ3lDSXBCZFR2TkpMUndwTDRmV2VZTllVTDlPSVlTV2cvcXh5cmF1Tm53Q0pY
SWdwaG4KVDJuZDZKSS84Y0dBTFlsWW1YdFNneVJ3ZkJFWUQxa3hDQy92cVl4MjlJUS9TOEh5MFR3
bG9xM1B2TXcybG1XVgoxL29lWUhJYjlxQmxEVkxkbGVqYXNuWWtxNFR1VkpRVkJkaE5lOGxEaE5I
U1VJY2JaZUx3MngxQU5rdmxrZE5NCjdvYzh4U3RPbEEvNTVOUE9UY3hWNEFucjJPWXhrcGIzUUIw
eitqZGVEU1VYR2RXeEhSd3RiYjd6ekNHZThzUW4KSk4wak5tVnVrZGtkdUZvcmtxQXdwSVF3MzB1
ZWlvdHpxQjN1Z2piTkRiLzI2alAxdFJvcG81cGRHaUxSeDh4cwpMcTBJZm92aXN0NmpyRWZxY2V5
dUxHNFlZTTIydytNemNLNEV0dDBUbmlCczZOTXZzN2pvaEVGMVRjeXVtcDUyCldIREp3NjhOTFJm
OG9iUU9yWkcxWlN2WnlqUGZQc255ZmVnZzQ3TT0KPTB2OCsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006e81ae0647a1e474--
