Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F158B651
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183817; cv=none; b=moAHm6MFCC2DZGuFGRLINvK6Pi9FMdJvOZwwUH62Kt7kaYye/foJ6BcWf/MA9lfhtrTYkxdGfIq9gWRMCjns2kFhmhwllh3mA0PFsrVH7xB6w/aiDeZUoN2knKx1v762Wb4SOPsyRw1+hWFE4XFh5FaeqTEbNSOQtpkgjzbKcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183817; c=relaxed/simple;
	bh=OXTxO+rbROnmj4j+tJKDMjmjxMaGX9aH1GCn/MKM2cQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Ye/qSXNqxhh4UrI3JLY6x2Wd5OcyuyK/LMeGnxpKuw44QmdOktSdfWFX2RTbSa2gtzyQU8/GrEJvNPOsClWz9vY+edhmbOyAysa7U+dWGowwzzrbY3G6C+o0yryuocOxw8gh0SkpFo9HHzlp3x9wInvd7hIs1jPNEUNqOuQLung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1LJqKOS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1LJqKOS"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6818eea9c3aso4877372a12.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718183815; x=1718788615; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEJD5jX0jOXeBnSKNYngH+GxRF32xLYNlNeY8SBW4ms=;
        b=C1LJqKOSk2mOKCFmOzyzXhWrshWDSUugvU9qC/v6QK95ZtBIVCR7hQCqT6YaoMEaqi
         L01iHZNK5Vo1DohnFFYIFdKYeBWetQgnb1jUyzJNTuvmOH7FTm/fXOuG3uIf5xwOGl0G
         CKjjEe/skO+1fjYvjwSZX7lI3+f28+M9CnWsFFw20+vz/JeV3XMwn/q/+kc0k5cdSz9s
         4r//BDlNB+2cY30RQTalDlKFdPme2jtu0RCm7pVU2qke933mWXZvPOG+qItlk1DuHAyh
         jwbl3rcrkVgLdRxLev3Zxgi9KeFpT9z6OqONrt5CfqHXuhk6ptLH4leTKVg/6JdygJ6x
         Cw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183815; x=1718788615;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEJD5jX0jOXeBnSKNYngH+GxRF32xLYNlNeY8SBW4ms=;
        b=DHqqB8B5AFByCHC/1Tdv6j2t/GLLUVaSygRQACF70A8yaddl1fgsPYXYY2YbeTozVF
         Vsy3mGKYhOBFgayXvq71N1wKwAyT9PlernhMsIOTcI8uySwvasIeDruRYnYThMUoaCHC
         pyfgmJw06OI1WumBdGqlETTce+kCPo0VL0vYWGjWyJNANsZMgX2RQePCc5a3+fgjhybY
         gOK7/bxXtn85TFhZNaZTp93lhGkCkwoNHFsS4gKxups8/Mu35mZw8bzPRpmUeXNuVhYH
         Whv13q0FiuNnA1dEon+sM5t5ERl/CdfVWUXxUQlZGVvO4/Zgw3DX6YG2Y25Xpe4cW0LN
         nhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7j2ES06wTNmz6soBIuAXhLTAxlsuvpSmbZ/UEy17YhVcFZ9u8XEqDwHQGkWpUl863fj6MKV13lWYBKTIs3cyfBEso
X-Gm-Message-State: AOJu0Ywo9pxL0L7rO5hcWsWViv9EZW+4bENNmbepHeBdBCaHM9N0GAl2
	/uX6JrVFZLWJ2wghn88hQHEyU3zWsK8u776cXBcJ9VYkzDqaRGi4iKBmfNlvR6bhnK0P+kZxoHr
	tP/G7RIWPSNSaUX+JOsZqAkoQ/HArFn9f
X-Google-Smtp-Source: AGHT+IEE36PYDl0CRbFbjlSkrXofQ2rynJJlucFUwIefvOhqrARwyOydeV9txnHv6Vy7Zhx2XktSE0FLIoOpTndGUtw=
X-Received: by 2002:a05:6871:3428:b0:254:7211:424b with SMTP id
 586e51a60fabf-25514b7ea40mr1390523fac.6.1718183262223; Wed, 12 Jun 2024
 02:07:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jun 2024 09:07:41 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwmmuq0ch.fsf@gitster.g>
References: <xmqqwmmuq0ch.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Jun 2024 09:07:41 +0000
Message-ID: <CAOLa=ZTMeTFD6Oyf3FiQWG9d_mbEn7Xu5ngFoVcBx7bx4hN7bg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2024, #03; Tue, 11)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000011eb9061aadb7b5"

--000000000000011eb9061aadb7b5
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/update-ref-symref (2024-06-07) 8 commits
>  - update-ref: add support for 'symref-update' command
>  - reftable: pick either 'oid' or 'target' for new updates
>  - update-ref: add support for 'symref-create' command
>  - update-ref: add support for 'symref-delete' command
>  - update-ref: add support for 'symref-verify' command
>  - refs: specify error for regular refs with `old_target`
>  - refs: create and use `ref_update_expects_existing_old_ref()`
>  - Merge branch 'kn/ref-transaction-symref' into kn/update-ref-symref
>
>  "git update-ref --stdin" learned to handle transactional updates of
>  symbolic-refs.
>
>  Will merge to 'next'?
>  source: <20240607133304.2333280-1-knayak@gitlab.com>
>

Thanks Junio, the last version was approved by Patrick [1], with a small
change suggestion, but since it was minor I didn't reroll. That said, I
think it can be merged to 'next'.

[1]: https://lore.kernel.org/git/ZmajCzuQftZlmlmS@tanuki/

--000000000000011eb9061aadb7b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8b9be819eb7a5783_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1acFpWWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHIwQy85dE5Nd1ZCaVFXTlJXWmE5UjRDVVF1c0MvVApuZXUxeFk4NXhx
dFpza3JXU09UN0NaUHZxek5EbFBGNHY4anJOdVJKeFM0VUZUYVRsemNrSjNIbkpmd05iZ0dBCnl5
cUhrVjhmTjBSTkRnaXNJYnB5OUxSR3g5Y1N6U0xpT1I1WkxmN1dWTnZDd2cyU2IyOEt5L3lYMmZI
Z2c3RUcKUU1TQm15cnBaTXpHWmFEeS9SYXVPeG5xZWZCckMvbnJsMk1BOHRXMzhUeVdLTXArcUQy
Tm9MVHJNSERVU3FVUApZRnptZ2k2eHk4dmszUEtLY2N0d2F5SHgxYWYzZ1RFT3ZIZTZrZ1h4RzBi
UGRCSDlGd3ZDK0hNcWxBSVlWUmQyCkZMMGE2bkZNN3N5R0NFUUV4T1R3WlVsemJpRWZmRXV5anlH
M1Q1YWFaNFp1WHhtZllJNEU4RVdNcC9aMnVHOWEKQzgzbDdsWGZpZWEzNnJsRWFGak15aHNBZTVv
bGhKYkdseFEvTW5sK09jR1dKRGw3UUZ6Mkg2VytocFVDbkEwQgpiU3JsOWsrKzlubDZDY0tYSi9Z
bWtuVzh6V0NCUlJqaGlKcXppS09yTGtoMHNGQTRGRVkzOVhkTVNDZmo4RlpXCnpPM2pjbng3aEh6
SFVuVXhzL0hKczhBUlBXbk1BeTdWMlJMM0hTND0KPWZSVFIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000011eb9061aadb7b5--
