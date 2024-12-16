Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09F1DDEA
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359608; cv=none; b=uQSsT9c1nrTzDpXrilu7xjQMu7QZZ8N/k9fX8SMJEOk3PjBRV6dx9b5ztM6H3iqElnKrjhK854LiLgPvm0ukt6C3J5xxWLcv+nFkTV0hfCGd24MpujBudt532IaGmPOMch6NtMEkQeJcnfMM8e8aE+Q92l2NyJqnHHAJj/FUv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359608; c=relaxed/simple;
	bh=S8BZZ/+oYPATKMAif5nPvVXvzPidZppzkha7nSiZ+AE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvzPy39OOIDx0WI49zsG4hIgIHx8RD+jv//YktWoL0yKqJnkE5qbQiFuncwrZ+xm8BeN24JoJ2ty5XBkpm5GLhcFaplD0LqlFBmMQzuNUmFgvVEOYmB1rfYMvImOmWTtvSc0ykXt4HwrEcduzPK9po9WaHpqIfs9yqrXUuR4CMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYqXya/8; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYqXya/8"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afe7429d37so1147562137.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734359605; x=1734964405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZIWw2oDXrkgRo9/gllYrEOYiPKiiloswCk98s1wBZ0=;
        b=CYqXya/8FYr/MZ1dqoHUUjK0FRqKvrTJLcyF8kTRt9FYbthXHvkuarO4aFGeo4qF41
         WjXgQUHnbYPDw967BWswsnFo1Px6zx3e7eJMUfW7JJx8x7Rv/SKWTVMELmlweqHJq/P9
         KhQ2cBHbmwrPW+Ccc2/E52eTJJnPJQCgPGKXNKO1FsO0bOHR8AFN8KrL8Jz/c4z4y8Io
         cviW/rq+uyjClqGsy75w2+AIpWFie86PiIX9gTeCIpCOd8zcoStZV1Mn0go+N/r8BhHs
         XlZnRq6dwqapDyYxBlcjdlS6s8wyYjROP6h8sb6y2/ZvT61B8frB6BCHZeYcnaWCAZWL
         b7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359605; x=1734964405;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZIWw2oDXrkgRo9/gllYrEOYiPKiiloswCk98s1wBZ0=;
        b=tpgTRtZsnva0IJwetl6rpA9K1ypk+pOVyBY9FUTvVDbJmJn8rEhL3NkIHlLw2M3hKD
         a4ivjuUB3Hl8pVpbnHxDW4AN1xmithutfmP8/wr+961Wh2FzFjIjL7fVhasd3LrybHnp
         1A25DQbPG6CfuoeJrt4w2A3kAVkcFgq4SYOtFNPFbQRaLMmfUn7KbVQFAY/gUi62cHkU
         b42ttKs+hONXBWybCrRDjyaeEP5URXQC8aOvGOQZwbuK14yyIXEuPTGrn+zhSbpt/VCB
         OsFuFQtWApeQCX1MdE8PwBvwNlahdK+A5zpSF6aX1Bw0+qPE3Km6KEWQoVoxRqe+PA5C
         2OIA==
X-Gm-Message-State: AOJu0YzHas0fltRRrZM69YxkUb1jmVd8bW685E4nat9P+eAZ+K6Z9uRA
	bgD4RIQ0a5bzXyvIDdWDmKmlLwx0Uy3FOertQKaq034vXHHF//+mn4zFaukJELyJ4H7CVi01w1n
	g5ODSwuu+gIsq7mOEcTFaLJ42UPI=
X-Gm-Gg: ASbGnctj+zOpZod8Jy5cowtQD910dITD8JTXq4YSzrPOumlnbu7SexPStU2OmGTYtpD
	HaBRGrX13TVlc2M75D2R4RR9UAQ8jJ7a9mhZc
X-Google-Smtp-Source: AGHT+IHeLEPSacCBjLZCYvI5kKJWPIEMC+ZVM0J4jkawpAPeOmwiiGj9WiA9khWVJMGc/g7DRWrGFxuP1KGdZjKXCno=
X-Received: by 2002:a05:6122:2228:b0:518:9dca:f0fb with SMTP id
 71dfb90a1353d-518ca47e2e8mr9668965e0c.11.1734359605387; Mon, 16 Dec 2024
 06:33:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 09:33:24 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq34io8ptl.fsf@gitster.g>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com> <xmqq34io8ptl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Dec 2024 09:33:24 -0500
Message-ID: <CAOLa=ZQHaGO+o=9vda0eA62K1kvdpi0yjm6adxEDhVhn4NFbpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] refs: add reflog support to `git refs migrate`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000031492406296410f6"

--00000000000031492406296410f6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Overall, this series is a bit more involved, and I would appreciate it
>> if it receives a bit more scrutiny.
>>
>> The series is based on top of e66fd72e97 (The fourteenth batch,
>> 2024-12-06) with `kn/reftable-writer-log-write-verify` merged in.
>
> t1460.6 does not pass for me.  I noticed it after I merged it to
> 'seen', but it fails standalone as well.
>

Thanks Junio, seems like this passes on GCC and that is what I was
using. Sadly, it also passes on older clang version, which is what the
CI uses. Unfortunately I assumed that the CI passing [1] should be
validation enough. But I can indeed reproduce this locally with clang.

Patrick posted a fix on the list [1] and also discovered one more while
we were discussing off the list. I'll send in the next version with both
of those included once I validate all the tests once more.

[1]: https://gitlab.com/gitlab-org/git/-/pipelines/1589854339
[2]: https://lore.kernel.org/r/Z1_KzlKc7RBfas4L@pks.im

[snip]

--00000000000031492406296410f6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5e168a6a5df94475_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kZ09qSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHRIQy93T1lYdW9hQUkvY2Y2SEFtUnJ1Ung4WmJNNgpobzRjSTVuckFP
bGs3czBCZkM2TGNMMHNhMXpwNzlKa21TNTFwQW8zalduL3Y3a3EyaVBxREE2ejFKWlJqOE9ECnFX
QXFsaW95QkZzOGlOdExsNUwvWDBpMDdodkNQT2Q2elZ1ZnJPRUt1VmJwRDZ1SXdWVVBWbmhDZExW
RSs1NUUKYTB6aUp1dDltUTlWb1AvYm5lTVN4WnZuSlllR0ozREVxc3FMVGlmZ3NzUFh1QTZVR3Rp
NmlPWkVnNVV1RkFmQQpQZG5SaUNIWDFYRWFRdHhuQmFkWTVQRUZhRmxtbk15amdnZjYzTWtzSWtY
MGlnRDZuTWhLWmhnZlRjQVVickJDCjNGdjYwUHM3ckZnRmczcmlETmszQ2ZNYkJsd3dYYkI3cklV
bkFxS0NhRDlqRTJQZGpTQTBsVU5zUnV1cDZRakwKUHE3Zlhtemk4TmZvQkN3Y1dRdDJuK2ZSUFRZ
d3hiS1psNGNuYnA0TENEcUFGcTZyWXVKdGhDMkRVd01pU0FlQworZUxyUlBVeGNFWUNndTJDTnRh
R1dTVTk0elNWSFJQZDFBblIvQkVyVEdMaHI3R2FRaDNCRnFTNTVGN0FQTmorCkI5RzRkNVllYTJu
Qk95WHQrVW55MGY1ZzJvbU5BOXZacXo3aHI2VT0KPUJHMjEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000031492406296410f6--
