Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF51FF5E3
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878349; cv=none; b=roJeC5pTsSRBLSuXlDeEUc/8gZ3q2Wsv0wtvaioGP27JXbNfo1hl0Axzob2Oy633UyA9qk8JYMGySETss84qSyn6UxCEWgb9sLVZDx5mn0fOzGeiAk8/XotdjDDKT1dmptf/pcCvFJAf128so2xAmDy5Hkow3tCu77k3JrJb4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878349; c=relaxed/simple;
	bh=QF0pPJMPWkwRCAJ/wnheMLpxMVuiTT4zgU/4QMnJwFU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iD+GxZiiy67apRfGMuLQg1g/4s//CC8YGJn0KTL0krdhwpWxzd5xw/reMO3uRwZtL6TcpNyRnoXBF98nbytaCwgEjMRLgnYWH8w/SSnXADtEHfKL3CVJ3VxzEAqxSiRTL0NMyXn7hOMvUmbMFx3UCi07X0ezgA1/o5vmXpiOH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIi/WkHf; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIi/WkHf"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8815049d0a8so873184241.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 01:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751878346; x=1752483146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+228gnCNqA5updjxQ2fTKhZ8Lw1KuqjEozgvamG3Hw=;
        b=bIi/WkHfiMZiSofOmJtH/+kNXKcbVWBL0no573nmeb+4pdrdT6hN4Zf+QPupJe2ySw
         6q//j7Mn7hgJnU+VbV5qvigQPjuTb+mRVQCaS3NU5anuh/CPzrjAtCmwW7eo3oV8poo9
         j6JUI7YpBm37c7KUU7BvZOoxXxX+vSHTXXMwfDeEXy9mg3fdwYVhuYtyeyjuQ4UISSng
         saeGD1C7RMhKhozB/gNiH6Cdn6eijwtX4dKH6cRRCuEkTrMv+//63RwIkLpViUATXTnG
         EDsT/4peimZivnXf1mgP2B6EZK4OQsQHrYIlIKliybsYfahIVtpw4UuC2UXPXrJ3dR0s
         Sucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751878346; x=1752483146;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+228gnCNqA5updjxQ2fTKhZ8Lw1KuqjEozgvamG3Hw=;
        b=RdKieCxwVQigfcYPVkjB/eDnDV/j+Diki5FBl990U+5ryzE4FIfSpjd8lvuiTbApcH
         k98Fa7oIFtUX/SepTpu34rFfuuVBa/IE2rOc1iYdwcyGGM9FsXVo1i6BLj6yskocRAgm
         R31Vu7rWrZt++xKN5sBf2BuK5C4ysNSeJMWSEiJjdLYncBDPjOHA08bddeu4I3MtAcPI
         g8itr0o0npQFte74ygz7Q1qS3+bBHaGhJQf/4zQmqTZyiA8G4Mj+K9xmgaWGFabQnxHh
         6H7t7jDcPsEeFL7scWLtzBmVlHA9K2F0uvGzkZLtHsiBDI2HKRGWj8TTQ5Nl9iQYt3gm
         ijsw==
X-Gm-Message-State: AOJu0YxN60JRfF6svzlH8SftadBe3M888V38NCx0COzThIZ7ynH8BjqE
	K3uhAb+/OcBZVUs/0UsO7zaS/4UmF5d/NGFRyr3x3dufvqx5O+aHWiykIUQPxAc8X03tIoeNm5n
	PtkU4aiNsm6dDfNbCayk6nQ+eYx2IU24=
X-Gm-Gg: ASbGncv3JOG0bcetLVYVvgl9+fBs31lPDYBxYV6akMO/FyZxz2RpVW/xml7DUD9g9B2
	4WBEBEYTbnmeuWh8YwjsrmKQZZputUbDOfAIK0ewaOl2i5AyuYzqUmZwMNr45EWz/gH4FXRFzyF
	XgQw2iTQufreAd25WW+omM9bomd0T4Hy2zqkzWED8TdnjwsxPFdqXgyn53S3cAXGoiGxIPchm7/
	NMEvA==
X-Google-Smtp-Source: AGHT+IEyXNkQn9U9dbiK8zXthRgZiVqP8sPDFwT8+ln/rp+y6Ikylf4Uo0zEsQ3G5grt2CHCXV8wglwKaU4Tgq0XR1M=
X-Received: by 2002:a05:6102:162b:b0:4e9:b66d:3c29 with SMTP id
 ada2fe7eead31-4f2f23dc4b9mr6477824137.19.1751878346226; Mon, 07 Jul 2025
 01:52:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Jul 2025 04:52:24 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87ecuwc5n4.fsf@igel.home>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
 <87ms9kcbtq.fsf@igel.home> <CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
 <87ikk8c8jr.fsf@igel.home> <CAOLa=ZR2=5iZzUVTS1o81a5NhLLiyHLiJfznz2Us5q0VLU74og@mail.gmail.com>
 <87ecuwc5n4.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 7 Jul 2025 04:52:24 -0400
X-Gm-Features: Ac12FXz24Ir0uOR8EJaSHhJh2Y-IkmPex6WCBOgwuD5nnb9kay13h0LH9qgIRnU
Message-ID: <CAOLa=ZRSFH7F=cU2owPjhVrupSSubEArak6abmhRcP97wStVyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000008459ad063952f6fc"

--0000000000008459ad063952f6fc
Content-Type: text/plain; charset="UTF-8"

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 04 2025, Karthik Nayak wrote:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> On Jul 04 2025, Karthik Nayak wrote:
>>>
>>>> Consider the example
>>>>
>>>>   $ git for-each-ref
>>>>   refs/heads/bar
>>>>   refs/heads/foo
>>>>   refs/heads/main
>>>>
>>>>   $ git for-each-ref --seek=refs/heads/cat
>>>>   refs/heads/foo
>>>>   refs/heads/main
>>>>
>>>> You can see that the reference doesn't have to exist.
>>>
>>> That is even more confusing.  What is the first matching ref if none of
>>> them match?  Doesn't that mean skipping _all_ refs?
>>>
>>
>> Well the idea is it would seek to the offset where the reference would
>> fit in.
>>
>> This is to ensure that seeks to references which were deleted
>> concurrently doesn't leave the client hanging with no results while
>> paginating over all references.
>
> Then don't call it a pattern.  Pattern matching is a set operation,
> independent of sorting.  What you really have is a marker that divides
> the sorted list in two parts according to how the marker sorts.  And
> that makes --start-with more descriptive and less ambiguous.
>

Fair enough. I'll change the documentation and description in the next
version.

> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

--0000000000008459ad063952f6fc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 649915b3d93ffdf4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ocmlzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEhKQy85eEhNRlE5eWNiYjI4eGUwckJ2eUJUUFZZMQpPcGpvbUdWYUtx
NlBsb3BGUGZIbVk3MnVtc1dlalhzbjJsNTNYYXkvUjZpK0lIQjRFMkRxUHlzaFlnb0IvNVlwClZj
Q0tkQmhKT01hbFJieUZXZyt1eHYxNWRmNW5jV2pRbEtLTzU4V2Z2Uy84UHRrbkdQQzU0S21GWVNR
ZVlKODcKci9tclllbEY1bTh0QXpwRjR5ZDdLMjdaTjQvRE1wOUF3RDk1bTRWcytjSFVCWjB0MW9j
dm9LYklLUldxaUFPUgo4WG10MFVwTjZGbnRDaXZkWk5FVEdjcjRndU5VTTFma0h6V2loL0VsdFox
dnVqTWZNNE9lT0NjZjBWeG1oWjJoCjB0WmxZSWhmR1RNL2NCQzNSQ0NQUVVVYUx3VXAvTitxUUpS
djhvRlU5ZkF5enljNGpRcnNpQTM4dmQ5U0pmSE0KTzhCaWIrT3d1Z1QvbVZaMitsVTIwRW4zSmJC
Nk5jaUxJa1FGQVlGaUZHQ2hTeUtheHU0UWNFek9CWGg0N3UzUgpyYXJnUy9qL1ZzejRqUklqelFv
MzRMblZqWUNudDIyYTEzRXlSTUsrSTFrWjBMWTJ2UFNLWFhWSkJMVkpiK1k2CkVjVVJZZVpwMWpZ
ZnpDUG5XVkxGb05uRnJMcEgzYmRnMDJPbWZJVT0KPVhWL0sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008459ad063952f6fc--
