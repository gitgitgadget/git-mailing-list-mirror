Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12D25CC41
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620858; cv=none; b=Cf8ywZwNhyfgIOCTBbivJpVZwiXcU+KFCV4HWlK4NG41GT3BINes1bXaPAQ7I5v8qqyvaQIZbmPy8o8jekGtzPG1tQqjK48cQb8V0QWQ4kKYPZDuG1DSSjtZfHl9TL9Q1eeINQHaMmpLWynsQD+0WkQe1cDcC+oU5HCHg+f5M48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620858; c=relaxed/simple;
	bh=fBr5oY+Q/JQwSs/1fhqVur29TbzgJb1qCC+UOJPxTyY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJqTZCH+wHRohai79vvmXWsVFWsDvTnftVy9RCUVGgAnNkN/Zug1jpF20KsUhu8vCazCRTP5fm8vy94cBF3Tjia9EZpMl8uPqfqckEN78IFizgsz57e6S4RWzU+Cp7zszCHERRxHN8PHb/r9Z25sYSPvXpYOJoB8Qm3YwOlucQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx9g+NUY; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx9g+NUY"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-525da75d902so1894054e0c.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746620856; x=1747225656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBr5oY+Q/JQwSs/1fhqVur29TbzgJb1qCC+UOJPxTyY=;
        b=Qx9g+NUYQBNHObMQoATaBluHDnvFp+RXfHbt8s+4ngVZSo2iVqUC7uMvZN9A9zCqYN
         83vFLhwlJEA8cQLvcgZ0au1Rmob2wT3LQwwRqET6j6FcAk5Sn4Uk/qVhVOSDvZkbK67s
         4u228K7YcMjkvNsfOrTnH3u/MDSvpC6/13r37CCm9pwj9ij4Azy+ECNl1UmSIKDYB65B
         GqNiyJld9U6qJA6/W8zQqncgk81ZD1moMRsv2L2lGzd9TF3xuRS/KCx701IS795+ordM
         8h8JAmJKCtT4v5iYBgfuHOv42ZRdH268kUmaQVKdymI+Iu9SOgp9coNRWhrAlzp+YOqo
         vJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746620856; x=1747225656;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBr5oY+Q/JQwSs/1fhqVur29TbzgJb1qCC+UOJPxTyY=;
        b=LfF1/Wo2rBGY0Ll6nHQbe09sn2zOG5d/wXVSExQqx9a+ImvkKkohH/K/j+QfaK1hpU
         K9AZExkrxyNx4qTi4cLmekv554meVZtCkCwrX81XPFU6bPzk+Vtck9zm3NkJ0bl3Fwa0
         vWX+NF1bBEyHisOrGJnA7k/5YGFqdmIEswgeKrSWgxcjoYtc4JGybA2W3Ck2V4I4cIJe
         +c9o5qwjDqF0ZvudUKWl145hZZ2442l9D80oFxu1RmwubjTuJn3n7MMbndHNA1DtzqEf
         oKuj6+Ty5w2+eFAQXlYyMP6dEFlTb1hwW98EipOij5xFa0A8Rf5YETqf4vBF1ZQfXyOz
         U6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEPY2G/4WyWYefrqBCzuqlYJsXDS9AgGMtAZhA/yH+NjnCdvHv8+uOpuVYQ9GLt3+PyD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKNtBFTNXrYwP4Vis0dbQggQ2ErBp3Eox1tuBe7MXr96EzheZ
	AnDnKjD5lFPofeMRb/5SRm82B3MFOGwZHLa5GQwp6YJIp0WjYYw3vFZh7b9VT8tjBeVCsk/owG8
	8fQniyQRUjxgaI610MZYM4sc4/Ac=
X-Gm-Gg: ASbGnct/PlEtrUdrN8Bo/aPmTwKdVuIitqb6VwHe/5RyDIlpD7atNKtBrTUF+8PO9rh
	DCABrHCISG4El6QTunYOWLTtanZTCWtMiVCIJFbttb30BRbg79j6MOJjM2kPAizkuR0WNlkVMrl
	azC1TRlbCE1/dIYrmALnK608zg8xn4Sl4=
X-Google-Smtp-Source: AGHT+IHw51HKQ9fZulehugazqAcXwDSHF06eba/QvlS4/QmmjOp+c5cKcM36mNsmlpEJni/bBOqD/kKKDjkgjb/KY5c=
X-Received: by 2002:a05:6102:808f:b0:4bb:dba6:99cd with SMTP id
 ada2fe7eead31-4dc737cd225mr2532901137.8.1746620856159; Wed, 07 May 2025
 05:27:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 May 2025 08:27:34 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 May 2025 08:27:34 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250429145243.992252-2-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 May 2025 08:27:34 -0400
X-Gm-Features: ATxdqUEoC_x0fSJpkh1jGDjEz_nGEAPaL5_dmcrc_fnRHy-d_iZ9hed4Yam1fdU
Message-ID: <CAOLa=ZRL6nRb0+Bf1u9b45UZGnsB1yPVJ81Mt884onEYhZ7JtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] promisor-remote: refactor to get rid of 'struct strvec'
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000b060eb06348adb24"

--000000000000b060eb06348adb24
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

[snip]

> +/*
> + * Linked list for promisor remotes involved in the "promisor-remote"
> + * protocol capability.
> + *
> + * 'fields' contains a defined set of field name/value pairs for
> + * each promisor remote. Field names are stored in the 'string'
> + * member, and values in the 'util' member.
> + *
> + * Currently supported field names:
> + * - "name": The name of the promisor remote.
> + * - "url": The URL of the promisor remote.
> + *
> + * Except for "name", each "<field_name>/<field_value>" pair should
> + * correspond to a "remote.<name>.<field_name>" config variable set to
> + * <field_value> where "<name>" is a promisor remote name.
> + *
> + * 'fields' should not be sorted, as we will rely on the order we put
> + * things into it. So, for example, 'string_list_append()' should be
> + * used instead of 'string_list_insert()'.
> + */
>

Dumb question: As I read through the patch, I realized we really care
about the order of the fields and it is mentioned here too. Why is the
order important? Shouldn't the client be satisfied as long as the
required fields are present? Or is this merely an implementation issue
where we simply parse the information in a specific order?

--000000000000b060eb06348adb24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d19e21744d77fcb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nYlViVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWtkQy9zSGJEOVlhaVZaV1BGTy93L0hmRGpYWDRoNApOaGRUc0xBSGMr
bm5rNEJINWVMR3FaWUFNcVFZbnM3NzFSSVJXc093V3RuRDBRa3l5TTlYR3ovZi82akdCeURHCjNT
bW9WMDJxZUYybVZPZmYwT3pOazZOU2JzV0EvaGRzcmt5RkdlUVE2ZUh6K0tRdEJiNHpiMmNxTXFt
SXJqaUoKUkV5UkFXWDZTUzFpVklFSTcrY01SWW1GeGx4TXRJaUNnMytUbWJNcUx6M0dpUm9QcWU5
d3c3TUh6SEQrOXV6MApnVEU0SFM3OS9uUmRMVFRyNUdVSjduVkIyY0pRSmR2V3BHWm9ZeHNSWXpH
alpqNGQxUUc1QVZ3ZEdhVVhIQUwvCnJuZEZncWY4MDNqTVQ3YVBJZWNtcktndHNxWW8wTzFEcWY3
VG12WUFpWlA2L2M3RE5PMFpxR1BDOGJHL3YwYTAKMytnMzJRYmZoRjIrZEhpOURhNXVYVS9zQm9Q
YXZXdkJlRmpGWmQ4UEd6Smc0UWMvSE5nUEYzY0lLRndCdWZKbgphK1p5bTAvSGZiWTg2VndPbHdM
QlR6RXY0a3gzdW9KdUsyeUtQdVp5NWFTdUxVWFJKa3A3VDNWWEFsTWFtRmQzCmdsSnlmSm9QeDJi
czYyNDFveGxLTktRN0VNK0Fmbld6cGNiRmJNND0KPUJWa3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b060eb06348adb24--
