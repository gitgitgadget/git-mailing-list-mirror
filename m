Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF6188CBE
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237566; cv=none; b=EBe1s/bfCGJpFoRON+J8yEPsll0VDJpY6bS70aw5jwGMaGqTxl8VT52ld1BXdT32KHtfDS2awxE9GT+Wyq4rHpHEB79mwjgaQxOzt/x7oT2dWknspPfmVu5XD/TWrjAvUiMXQCwxJkT7FnBPXJ/GozAw9gvui9C8rrUbfeh2mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237566; c=relaxed/simple;
	bh=zfrC6vYDIH652elBjwOpwsgoROEobMpzS9JV3Rdj+JM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Balaa5+XZzOiqwSX8fZpYAVDr6Nae2G/NO7/sQ4aEQRG1sqAP6jxQrJE2y3TEYKcSHNDZv7DmmlAI4quhz+jv8qa/Of/tc8OIe60qTjygnQH/I/Uaamy8Tqa+r0XMUuiRrpCBxqpADcUCqvE0MJCYvKaczcSMj0WwvW7Xz9Pguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX6QS6Yc; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX6QS6Yc"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a482cb53bdso658439137.3
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729237563; x=1729842363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfrC6vYDIH652elBjwOpwsgoROEobMpzS9JV3Rdj+JM=;
        b=jX6QS6YcJo0bQXuWha+sRNNgfFgdIKxPFu9nGK8S2NDlgEDF2E0Hj7GLhkDs65xNrt
         D8ZPqYFZjTqwsMkhfWOwW0v64jWwfRGBmWe7iVD6TLIXZVluL+cKmkR7JBTkVXV+BBKU
         o0Alz7VE0ZsoW5BgR4tm3yYtieCWrplW7W3lbN6K/kuTyrtc22TqPbZN88OB3kGfECg7
         N8Qlp17liva5trq8pUmZBwqhfGbjeUbisgbMD4+dC543CqqhGs0iq1IddpxVStKs1chk
         5gWq++gxRbVJy48G9AZ11iMJppXXM8n1xFF8B62SsAE0ofmQpPS8WU0mjkZIYSwlsGGX
         2mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237563; x=1729842363;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfrC6vYDIH652elBjwOpwsgoROEobMpzS9JV3Rdj+JM=;
        b=Hyg5BrbOkYZr/y+cuOWeKlDO6kN2v4opn9ntueLzXrjzrGZGxEEBJIBPOznuSKRZ14
         hCd8+0vyplXkn4sVK+EXF60tDLHOby5odvodbmIncAlLG6LoTmuxO+PLNV2DleaG2eBm
         NNOYVNVSrL4MzdVi88tm5aF1jZ1GkK1dlIPqA2r9G7alw+YeAqR7pFrR0WrNRmInAVSP
         vUe5aZ1cnHJyuiStclIcWlHp61lVfcQWrVOPFZWPTJQefAw9kkf1WCDV/FCGKIWfkhW2
         fO3De6PA7lfil+Q9R+EeI34wpSJteBdhnVaWseezSo6F5jq8cCFwiSfz1MIyUmyIoks5
         9DzQ==
X-Gm-Message-State: AOJu0Yzr4q8Te04wwb308uRCzQJNi1PSMBkY/QTai3ljdsRBDx1KaGG/
	eUzuCCwJS4A0rWv0VWwjFuFVDxg7vcasRikLE+KT+glwYtK1/FgNdnUK9RIm2k6v5w3c0ir5DYJ
	bQJ3gpexIFUwlk3wXPAhPqxk4AyxoATRX
X-Google-Smtp-Source: AGHT+IF+3aqh5SXCHOzcpEyL51FYvD8RKxJQqS4dX/936slInAY6gQhAhlV3GWGeX7vwa/wV7wt7+PfKewEMaRQAPTU=
X-Received: by 2002:a05:6102:b07:b0:4a3:d4bd:257a with SMTP id
 ada2fe7eead31-4a5d6bb7119mr1254086137.23.1729237563403; Fri, 18 Oct 2024
 00:46:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Oct 2024 00:46:02 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxF6+ze67duAO8fn@nand.local>
References: <cover.1728629612.git.ps@pks.im> <cover.1729140565.git.ps@pks.im> <ZxF6+ze67duAO8fn@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 00:46:02 -0700
Message-ID: <CAOLa=ZStxERhENJ_3osJCWR7u6Pr1YeMjCf3UvTxnce9SDReLA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] reftable: stop using `struct strbuf`
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>, 
	shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b31c170624bb7e20"

--000000000000b31c170624bb7e20
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 17, 2024 at 06:53:42AM +0200, Patrick Steinhardt wrote:
>> Range-diff against v2:
>
> The range-diff looks like we're getting close here, or are already
> there. Do others agree that this is ready to start merging down?
>
> Thanks,
> Taylor

I had already reviewed version 1, having a look at the range-diff now,
seems like it is ready to be merged!

Thanks,
Karthik

--000000000000b31c170624bb7e20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6342e6ea2bdd144b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jU0VqY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUdrQy85eU5mWTR3K0tyM0k3RE1tcTc4QU5OTkZ0ZQpxUjYwTktvMFpi
Q052Vytsd0F1YTYrU2cxdmVlZ0VmVWNyZU9lYXF6bW5VVXRUdmJDVDcrY0daWFpCdTlXWlhOCmJu
M21EUTcwNy9tMUFPRUNzMjVYK3ZPclJLa09idURCSlV2dkxERTBndmVoUDAza0FYbk9ldnhRdGtn
UzJ6dUQKa3I5eWpkc0JnOHlrY2RDQzgwRS9TaitpQjFlM0UxRUx3RGlZckVleUFoU21MYmM5OW1j
V1ZYWHFTcFVRWlhvagpqZy9rVHc3U1FIWTEvREtTS1M0OWc2eVArNE11Y2VHYnZxUUtPVFEzek5H
SmNjWXkrcld5VEUyWlVFZnpYNnplCno2bEZWZWtWTXhFM0ZBd05ZQ2hnVzZadzVOUFFyekdIaTRz
WnVuaDJpZ1JwNzVKU0JGTHIrQ2d6SVFicEFBRU4KQVVzYmVaNm5XMjFVOW0zUHpQbjhKQUpRVEJV
bVFLaDU2WmZGcnBBOUU0S3RwbTFQLzFZMGNZQk1lQWJPekxhMApQV3dVRThQanlNVjFNWmxmZkpu
MXBIblF2UmJUZ00wbWFxSTRWS0hCdk5tSks1TVE4M0VxZW1Va1hZVkt4c3ZSCnI5TWE1TUEvQ2Ev
Y1ZORDdKc3ZubXdrNUlWdHZ2ZStESUFmOFJ4Yz0KPURoK28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b31c170624bb7e20--
