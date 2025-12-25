Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5D2AE90
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766697805; cv=none; b=IS3sW2MuokqlfWZOIShJhFxF2BKs3QvWO7ntVv80KnZeenT69NozCpMr2Y3XileLsdg236Bn4ugFiW/Hhz8gIIEXb2cyB5EysgbTaX1oJWSjIEZKgNuGBu+w4fi6RF6mQwgQyl/DS+IIcLwOedXNiLw9S/otq3thZmotyrp6WME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766697805; c=relaxed/simple;
	bh=HmDnnVnpaICOZ6TfOGwtemqc8iiroFk78aMvYPWbrRI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAnzmZ/nShi4Suvbt9s0cAKE0U+cOtwiR84CLfN/z40D1oGDYb6sAxyyQXw+uE9kOjH5ce2HQyOkqKyzLqXOZJqRuebqxMQTdG+5NptlR+jAiJV8J44Vp/Gpm6OOxYc60aZe1VXsSkd1jJ1g52+vsTfIzcZRYM5tOFmMvmWaoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbCjfAiD; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbCjfAiD"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5e19e72c2a7so358551137.3
        for <git@vger.kernel.org>; Thu, 25 Dec 2025 13:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766697802; x=1767302602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmDnnVnpaICOZ6TfOGwtemqc8iiroFk78aMvYPWbrRI=;
        b=WbCjfAiDaybiUymoXYqtgvCLd9SSFPxyKSTTM7A+Omgw29qVUccACcAiW3k3NWkkon
         KsBhkGbPyixjLeB8RsJyIlnPPhpWUwco5lGcNMAaZWd3Fz5i1dWzbneiQJ87Gu3JSSSL
         cjUW6b7zZ3cIBpd1w28QC3Tr5Bk1PTQLjXn61ywgP97cThHYbWjIbTk3LQ8fJbAQKPUz
         qEtx458O3bhI8oOUhEvfLnL9n54w3VVmtbw8h9w7egfIviO4KH4/ILtU8GcJTkrzc8Hk
         2GkcvQ99rdI/BsxlGTkJlxfg4czy2DyWyya0IgT8igRBgUoo4pTQscrWw77LPNyztSOO
         rfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766697802; x=1767302602;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmDnnVnpaICOZ6TfOGwtemqc8iiroFk78aMvYPWbrRI=;
        b=gMOPjSwNaGzph5okSTBMTNDjD6DfLnfxSvuNelqNyRSWKbvAgMGn8Oj8BJcbXlzSOX
         yTljHnsOL3jiAli/dJRHgWjmwgj7XjOv1G/ii+z4p9CaMSKIsL2LteYhgzbuSlNeeaci
         2lKZfhuJYgMaEv8B6MxGtIFgAfIyC0+GU8aQcr+om/WdJ6cYXkiwRI5oI6NELprvA01E
         nfWSoeZJozLFqulgikHuNiiwQC76Mtew/Xnj2Jiwvvn1vZ35RyemfGNzTyjVuVBs3DNL
         Siiu1n10WXijkZ+dCRUjiFkNfnjvFUNdvbUEJgdTlO0LUaLvlcBLBWcP4L93AnYvtpFZ
         tzxA==
X-Gm-Message-State: AOJu0Yzzc8G01+SEniB8k/jEkwfF8Kii6QxRXBaRhJ+9gmi/QiudkdJX
	STGPA94l+QT6o/g8ugwzwgz+czlkf8kG+v61mhAMXrxgWvHo4w5UUOW4J/iscVu2JcA0Aly6IE3
	GocTMFlsoXqIdV/UhL8SKVRBOMyihGIg=
X-Gm-Gg: AY/fxX4RhrArUJY25fFokG7nO9amt5py7eqdNZ+B+fYOkCZXp/MLl6xLENufb2F9bj5
	GvvNUR81rVRTpSXL3QqSaCvrKA4kuzoXNuQtLlh0mRr+eWKaRxToltyln0usyADGZb1NrnQU0ki
	qLSVcLJmsWBzZMhCerXvT4RNVMzgoqxU2RPdzPaqa/whSJCxowGPRmwjTDfz8bb/Qgb7xYo2z7h
	3BEv4ok7Kge716FRR7/2SYRDy3Eik9sSgx85usoIzEgGJ2CkOLZlDZx5KvLGuGBqz1gcQMzJ9RT
	LNeg49fQc0DK4/MepCTr+/PpxIdqrg==
X-Google-Smtp-Source: AGHT+IH+2oHPeMbiTyvfZE0hTA2CJnmUbUo9Ibx/s7DL+HCYpV5W//JtvpxrEZSjlnjV3pp3YwOBHoPls7foWlYvjns=
X-Received: by 2002:a05:6102:945:b0:5d3:fed4:ac2b with SMTP id
 ada2fe7eead31-5eb1a609ee0mr5819351137.1.1766697802496; Thu, 25 Dec 2025
 13:23:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Dec 2025 16:23:20 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Dec 2025 16:23:20 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqzf7fw2hd.fsf@gitster.g>
References: <pull.2130.git.git.1766074249443.gitgitgadget@gmail.com> <xmqqzf7fw2hd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Dec 2025 16:23:20 -0500
X-Gm-Features: AQt7F2phpfCJMKdwopIlOvqIXSOnq6HuqWJmyMSXVenq2KMSnVIjYnihogGxdFs
Message-ID: <CAOLa=ZQwrdXOocxB1A5TyGYBecQYcM2r2p8ZUZfBiav04cuSGw@mail.gmail.com>
Subject: Re: [PATCH] refs: dereference the value of the required pointer
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, AZero13 <gfunni234@gmail.com>, 
	AZero13 via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f19a160646cd62bc"

--000000000000f19a160646cd62bc
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Greg Funni <gfunni234@gmail.com>
>>
>> Currently, this always prints yes because required is non-null.
>>
>> This is the wrong behavior. The boolean must be
>> dereferenced.
>
> The line is blamed to f6c5ca38 (refs: add a `optimize_required`
> field to `struct ref_storage_be`, 2025-11-08); the author CC'ed for
> an Ack.
>
> Thanks.
>

My responses are a bit slow due to being on holiday.

The patch looks good to me, the fix makes sense. Thanks both!

--000000000000f19a160646cd62bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4a766adf28e5b2da_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sTnEwY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzYyREFDa0JqdnFSNEY3b3BsS3dsdGx1OGJUa1dzZgp4QXF1RVBmOWYw
VkFqZ1B1TVRiZ3hLVEJiOWdscHlMRnpocTNHOXI2N1E2N1dtYnIvR2JNTFFiQVpUa29KWXQ1Ck5m
ZlJXb1R1c2ZVdCtrKzJaOUcvN01QemEzYjhVTG9BVEhjQi9WcjRhTklqdEhYRXMzSjRybk5sdUVw
ZysrQUkKVExtM1ZIRENBWnlLUFJtdUs1UnNLc0VCS3A0MlRzeXptZ0k5eHh2REhrc3Jhc3pjYmhB
SEt6NDJHZTArOHh2NwoyZVEvZXJza1pJbkNLdDJacUd0eEY4OVdMTkRIaTZVT3Y2cXRhbGlyRzUv
enpXdUZFbk0zdEdXK1BmT3NVVTFRCmM1aEJZSnRpaHJHMlBpM2MyNUd3dEt1NlV3Z25hMjVuNEtE
Zm1yR3JWRlhZSld3OGkvdkdENW9XWkJac1lOZCsKaGhSUy8rUjBwSTVia1FGR2NKSzcyWlBuRERC
WnBWNXkxUUw4SkV1bzVOZm0xVDR5UFdpUmxocFVYeXg4bVA5WQo2S2NDcDN3aHVpQUZTQXh2WEp0
cEZrUTQ2eFRZNkRES1kyYnBoN1gwWmpDL1AzeVFGUnJ2ZEI4T29GcytQZnhwCnB3S3hQWU9KV0Mr
K20rbzVCei9hZkxuSWh2T2VVTFYxdERScThiZz0KPWt5ZHYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f19a160646cd62bc--
