Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFC1487C8
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270617; cv=none; b=b9snRJmMBPHmmhWuZEtoxFyoFl/uoR7jqISmwEp75kcfOut6m47ZYfCZR0zfH5V+R9kGjcVkjb3/xz/acUKTwsqSXE/Szko7sPWB8mFUTttG1En5RUHlg+CI10qkmIDzh4fnkaEoYXK/9fhTqOb01g5aayp974y+erb/bC04Bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270617; c=relaxed/simple;
	bh=WciOfUhfVCHpVrPP6sSjzkN4rlngfxbTaHwncY/5X70=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhudXqljXibCIgXshurcKzy1HrZUuWqwpKYo8RqVO+Ci/08xJ91btAxVgKwWfdh5To0M+88bGNP16nyih2Sp6PKXfvveuurTJ7ees7bRssIZazHxUrdVujKYCrLrz3mv3+ti9WS4KwQFH/wDOBga1GbBvdx5Agrmf+EZ+qT9c9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGwTaGr5; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGwTaGr5"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523d8c024dfso279771e0c.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741270614; x=1741875414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lnmS6TVYedDc5N50QDTMw9uT/r3Gh7Y6SUQP/1znEvY=;
        b=KGwTaGr5R0h/XTqqu0YYg4DmbG6pIAB3NiqjKze0JtKnJfNBcBYDf4okjMlQU1k8A0
         cQtrNYlEp/yJiGvkkuzkM2tS3OCOaLVxHpzMzBrBp1l4cZTF9l2UQmgR/I7BW+lo7ppB
         RGnti8KOyvEvbFRkMhkXvU/bpdEpsWq2IfE6/zJxJhvr1ky5F9GH3wt7gmDo17xp0zEc
         +2hmI5kd5ERURfV3RausU0R/wie+ZaqTwO44D5RBmjj5F3GeptH8KjkVVrlUlbxKkRfW
         1wFiFBMPrubSC5vLULebmjbb73/G1MS9Ha0MO9kqqQOAqGr5sSVbqWptqSWZxG3E0x3V
         Ov9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270614; x=1741875414;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnmS6TVYedDc5N50QDTMw9uT/r3Gh7Y6SUQP/1znEvY=;
        b=DXhbb280sQnN3ZmByIGYeQAWe2g6BuJ3vtrom64l7XgkOiUFWsfcG4gOmdlgWBvGaE
         73k4EGOZyFbYcKf/vBDXzZO79zCH9QtbcTPXxqMQYmH7ETv9fudFNBjT3m+URpuQgCch
         ebsxvMHmZPSrpK5yg0YLRnfymaL95TxeG1Bup7fhIae1ZH/EqVR8J4QFvYHhwU6/ZQPg
         Y4si+vJtlcgsOrSjk8lvpEIuWVN0tr51EaOvZTqQjxtrSzLcdMOPDviwC0NHJJxC4B06
         Trs4vO7wTNxb5sRmxerZTtEjhRBtJEhvhTtM/d3OZxNGmE1sXwBOz5mGKBgipHf0OHF8
         rnwA==
X-Forwarded-Encrypted: i=1; AJvYcCVC5vBy+WY96x61Toe7U2feBX+jaCqUxlnBZ6og1vHyzzQ8Ou/aTCjP8dPjEJWpjhF2wVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA50H0Ch4jl3aPoM2pQWT/588fywCvXa5w6v372md9UcjLwXif
	U//yl9uBrc4PXE43VfOlqb0fnCll+IOVUdyLOjNxUPzYmdr7686wIkFutNziSQCtM+3N7NVVsGb
	p9DTcUtQBvlAc7t4KPk7NNzIFTII=
X-Gm-Gg: ASbGncu2qMffZLA0itWjyNFn7ogUsr1ylq0YrBYA/OyDloW2LrMGL7pbntIOLbGbfu+
	jub9Cj3D0MRztPcKHaG0XFGlxEHLM5mi8cC657d5MauLf4UL9RWCUzDXWaow3SxWlALSwtOhHg/
	DWJcd0TY5KuaRr+eoa2eqckyfOeJ8=
X-Google-Smtp-Source: AGHT+IFVrK6BfuoYn8D4Sqx2vtqvvmiOSOkqMNKsJwAyRjdCVkEsbpN6pgmLf68Ela2fnxIVqSW7UJqP6X0/lxbbGck=
X-Received: by 2002:a05:6122:8c0b:b0:520:61ee:c815 with SMTP id
 71dfb90a1353d-523c62ce727mr3752817e0c.10.1741270614320; Thu, 06 Mar 2025
 06:16:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 09:16:53 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-12-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im> <20250228-pks-update-ref-optimization-v4-12-6425c04268b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 09:16:53 -0500
X-Gm-Features: AQ5f1Joi3Kj0VWzw3HjQbmJvgiBe_Spg-u3cMfPJX4h4fWLBZGXRO-wTtkWx7p0
Message-ID: <CAOLa=ZT1ZVKGQ2KLiZY14hRH2qobaz6=V6qNXjcLkwhRvZPEnw@mail.gmail.com>
Subject: Re: [PATCH v4 12/16] refs/iterator: implement seeking for reftable iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000006cc547062fad28f7"

--0000000000006cc547062fad28f7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Implement seeking of reftable iterators. As the low-level reftable
> iterators already support seeking this change is straight-forward. Two
> notes though:
>
>   - We do not support seeking on reflog iterators. It is unclear what
>     seeking would even look like in this context, as you typically would
>     want to seek to a specific entry in the reflog for a specific ref.
>     There is not currently a usecase for this, but if there ever is we
>     can implement seeking in the future.
>

Nit: This last sentence reads a little weird, perhaps:

  There is currently no use case for this, but if one arises in the
  future, we can implement seeking.

>   - We start to check whether `reftable_stack_init_ref_iterator()` is
>     successful.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>

The patch looks good.

[snip]

--0000000000006cc547062fad28f7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ff3483cd8aa4f783_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSnJsTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGsyQy85YjdkTWgrSEp3YXRlbkQzSkVnOFBmbFhVRApwcnAycEs5VUE4
aG9hMFpFYnVaREFDNTRFUU1DSVlnKzZudnFNdWxHMmRlOGVDZXA3SUh1RFJRdU80MEl0S2RTClhv
YjduWVB5eDVlMHo2OVUwUGFRZ1l1VGluWFJXdTVWNUpIVnIvQ2dWOHMzaHd3U2dRUEpNZFpUazVj
OU9WcG0KaCtUN095Y2VraWNGa3NtQjVXTk1HaWtuUW9ITjZFY29YNXhvMXlhdEZQbVQrVHRldS9y
OGZnZE9TMmJXZDlwbQoyMUxaNzFYdXcrOGE5bUNCQzdXTkhxRlQ0V2xTYkF0V1ZVVzhnQmZpVkxy
NUFBUDJmT0VnQ0pCK1VWdktUYmlnCjJCWWczQzFYTFR3bUdmZEFjU3Btd0VqUjNYUWM0UnR5M2ZX
WFpENFdoa1ZHKzRNdjREVlB4aHlkOFVFVjlzSE0KTFdUNGUyU2tJSTMvZjYyUWN5Y3RBVURGRGgx
Rmg2eVl1SkxkbW5BdTB6T3NoamNVZzN3bkV4S0xOY1NWSEZKLwpjUCtkUFQ1U2JhVk9XMkxySFR3
MkRBem45MXJvbFMzbEJ2RU1aUERBZGlwRldyZXpoS2tDQmNDcFZyWHhKRXZYCmhhdk1jS2JNTXlL
anVPNi9GUkZwNm9ENlI2S0lQdCtsbGwyd041MD0KPXdBd1EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006cc547062fad28f7--
