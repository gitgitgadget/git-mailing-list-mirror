Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42A23027D
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996886; cv=none; b=dBM41K8UTvGcED9VBLSLV4eESgFL7gk3+NLaTEZpTLmTHpFQEQmQpMnJlTVGL7Oa6BBF5xfI6seNLGPLmq6d5voUi3O1WqjJ8f0HdE7jCKdjF6sp2qZY5cAsd6CP/ZuL1igWEApZ3TbrJfrjq6oS9MJ6heMhK3F57dECwlABcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996886; c=relaxed/simple;
	bh=xieV6S94fuGZbEQDfWRPxz4nfWpFLWGpK5Rklz3xhPw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhFb72VvfiTtuxWaey39ctfEgIrWXOq4IeQ/nAhTPqmg/+EenrPo+N3gpPpQyRkFvLd5cGj+IotYHnxHbPSGvbwR0xwUBwmMSmJwWDCH0rwMhiIvEctNtTv3/oanQ1IOxcbAI1gtqoZdKcI0ehEo+VmoGdJEn2/Q3FISCEVfcFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeALFsjx; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeALFsjx"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4b9486a15a0so800289137.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996883; x=1740601683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nrDgdmcsfkna8xkag7WBaJne+XIMo1eJjeTH//H2Rwc=;
        b=XeALFsjxlLnXMa9EkqIZSW5qAZXWHzMZHFw3hYNTfmoftKAqA2yVpBPvctd1O8KMly
         wkVSidtwlfnR52nkAOJGhKy46DTmzZUE7ux7tG2sgZmpR5/dX8qDQsDvHpEFPOn/Ri9K
         AZfS88VEwun2YMyU8P0WzMP5B1vwphnZjISjjVVbYAhNK9IO6q6AMV+F0lweYdr0WnNL
         e8fWYaLIfYcmPAXs1cdmAUC89alcR5bQb2OREHJI+2PafMlvBRglRMX46d1d1arCJ+GQ
         M6hts13Sb4xv8OXBqr9Of3O0vUdSmsCoEt8558LZ3hHn3JMCESz0RLk/nWaiSEjItyDa
         4kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996883; x=1740601683;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrDgdmcsfkna8xkag7WBaJne+XIMo1eJjeTH//H2Rwc=;
        b=dlza0QGDyAzRol75cMTu3rrkOw2qbBmdxuP5gxN6Z0PhtLteSS7LeEEiHKNipdMAcG
         sbTPXCWAiqfYsKBYM/vlgKH2Q0WGySIInP8dS+lB2otYReUb0AmUk1kRfyKjMa3UE8Dl
         kt7JjaLFQYG7BGbjdW2nEr1b5HTWSu83n31eBpWbBg0N3CSwaSgxHisuEp2blt9P4We/
         +3YvftimHcSF7K6ovDHike+quvppMV7jcAK5tb/YvBRC8nPtWUk6D9BqTkTow+MuSJ5e
         eMgsolkfsyZakfzyIogm+EIhUWYyQ5gOJqW6v28bPbAwm0svSfniIR+c65KzVoKJ0J0n
         Ke5Q==
X-Gm-Message-State: AOJu0Yy6hD9xb9sTxRPYt3tagU9yAMDg76AGtm5A6tU7tuL3qzRfcmMz
	wxtCkaDYd9CoGKvKtOxRFdcqxZGwmcqBo/M229IzSaR5TFcK84cvqmyk5KpPiA1GXLNAfm5MZuz
	ua3NxWIZoxMmgHRSWTvnuxiITMpM=
X-Gm-Gg: ASbGnctbYzhaCv1XqmmRR/zyZw367FbxsZroPsXH/zARWD6uFu4PG4ICIhBHt7CrMQj
	NgvfHnCF/kx8VbdFjorS4bGQEjPXK0iKpx1j7sE+K/+J4Gc2BXcG559yrlTrDa7gv39azEMZzBO
	RgeYS2HF15SNc8L8Q5Xu2jWfMahnfsSUA=
X-Google-Smtp-Source: AGHT+IFgvV3V5qk+Q5xLV1w1IX0qwyZI/5VJETOaVszsnvCQcoSfsbNvx8CUz9wxWJ0I6uvE5BpWg/FxvpRd+4pyem0=
X-Received: by 2002:a05:6102:c4d:b0:4bb:c5ad:af1a with SMTP id
 ada2fe7eead31-4be992c1f10mr430658137.7.1739996883290; Wed, 19 Feb 2025
 12:28:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 12:28:02 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwmdlg92k.fsf@gitster.g>
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
 <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
 <87a5aiqmeq.fsf@iotcl.com> <xmqqwmdlg92k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Feb 2025 12:28:02 -0800
X-Gm-Features: AWEUYZlyNBFJXEdU8In6yUjxK4dcoaS4DV3KRrHYnHpvLrM5x_t5znQk_2Q0mVs
Message-ID: <CAOLa=ZT025hWSG0JuoWTUe5aDgPg1fcHDaAhuQ+CxHQ2zvreXw@mail.gmail.com>
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="00000000000023c0ec062e84987f"

--00000000000023c0ec062e84987f
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> So can I suggest to name the option `--no-reflog`? To me that makes it
>> more obvious the reflog won't exist no more after migrating, and is more
>> in line with the common UX of Git. Also emphasizing this more clearly in
>> the commit message and help message also would be advised.
>
> I have always thought, until I saw the message I am responding to,
> that everybody would expect that "migrate --skip=X --skip=Y" that
> usually migrates X and Y and Z would lose X and Y with the
> transition.  But I realized that it was most likely because I happen
> to know that the choice between reftable and files backends is
> "which one do you take, you cannot have both at the same time", and
> it was clear that "skip and keep using the old form" is not on the
> table.  For all others, your interpretation of the option name is
> entirely plausible.  So I agree `--no-reflog` is really an excellent
> suggestion, even though `--reflog` option would be a no-op, and
> `--no-refs` would be a "Huh?" option that only logically makes sense
> to have for completeness but nobody would want to use ;-)

I share the same reaction. I didn't consider that flow of thought at
all. So I too agree with name change. Let me push in a new version.
Although I'm not sure if, Junio, you want to wait for the `git reflog
drop` command that we were discussing before accepting this topic [1].
I'll leave that to your discretion.

[1]: https://lore.kernel.org/all/xmqq4j0xpvmu.fsf@gitster.g/

--00000000000023c0ec062e84987f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2bc2b1f5d3d3e3f2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lMlB0RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTZHQy85d1VVTkh5b1BxY0xkd2VVdXlGekphdCtBOAovaFdaOVl0S1lB
MkFIZ2N6Z3gvTEk4cGV5ZWpwVXRSRTB3azlYbFdLeHVlK2x0TllkUC94T0pVd3ptRkZ0aWhHClFI
bzJXMFVDenZLSjd4N2J1MEE4bG1OUXdJZEE0dDE0S2JoZkp2OXZxeWpPalduTFdiMTVrK25jTHlm
SXBQMVAKOFZRRkpKTjd4R0VzUVRLN0NQZXBpTUdVVHdrVFdmaUlOcFFNYmEyNHdiMEJUQTE5RjJI
azhOSGx0dm1iUE1nRApkNVlZRlZZOEVlWEFnSmNCOEptZGwzTnVWZTdULzE4M2ZpSnpHNDFERVQ5
VVg3ZEU1cHN0NmdkT29xUzNkSDBmClUreEd5SXFRSU95NG5oZm5aNzZZTUU2aXc2UStCQTFpcEdH
Wk9oNE1ZZHczck5Xbk5jQkZTR0NTL2VZS3BGVnAKcXpmQmNFQUk0L1pBVVMyeU15U1FMSVJxOHRj
TWZvand6THZ1ZTB3N2g4UStjTkY2MUczWU16Q1VzQ2FTazgyUQorL0UrTU5BYSsxUFlBTGZFVjJL
ZHpwWm1xd0VhbWwvUE13OHVUZ0lEVVBITXZlRU9UeEFVaWYxeGVwUnBQTi9yCkJzcFNGeW5JTjll
S2QyV2g5RDhURyswSHdrdXQxbVcwbEIvSGowaz0KPUVFL20KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000023c0ec062e84987f--
