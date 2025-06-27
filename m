Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C427F005
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014279; cv=none; b=ZxuyKGYgmZn5JZCk/sQ7ahzz2zV12qxZjEKivnJtd0S6RbA6dTdMtOak7sXQ3Ca7jorNn0W+T3mdWQm/a22Gr0deq+eIjrJ67iw+VJO/t50EEu3OctUCO69/0wDa99XYL5UqObzyMw9oK8cBbEZwV1iQTEJRqXiOYlEs8/1V4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014279; c=relaxed/simple;
	bh=TR4v0a3bwzSVaxRyufSNwLHvlYGazWt1+QlKl4AgkUs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RG1O4ZwumVSE3QXzWf21deqVnU3L86Nfc3TLaZm2nYWwal2Rj12TKlEm86efZ11TVEHaGigUakldOWHqgWX3/OYKVnz9r5unM6f2FQ7CtETT31unMx4ouF1ikTzuV1mbtUwxuX6i/KgHLoS7TLZwzRcrk8P3nnYpcsopaINImUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaKfHKw2; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaKfHKw2"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e7ade16082so482809137.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751014277; x=1751619077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TR4v0a3bwzSVaxRyufSNwLHvlYGazWt1+QlKl4AgkUs=;
        b=AaKfHKw2UAa17yD5RFyRqmo5aAeKV1OUUp6vEWs4HfSpjbPP3Z71in4PW9EXuTLdIN
         QQjrfSC2agEXPC0DEur3gqzlXZd0louH1bRRccG8GIqF4UkcemoVN6/YiFO9wFUY15WK
         3SLtxbCBNLc1dr760GsZc7Z028ELTPP49ktk27jf/rPDVv+1jU0UzRco0q1fDmzkWGC0
         WE6e0IX9aWnmULONxJS16Um1Is4sQoiF0xP+WoMTCCgBGS/Sfx0byAtXv79W2hKpilFr
         3GpgQbeNLYFWdaYEcUMjfacbC2goUEyjAg558b6959MuJC/FgYDcAOamz2AHq17xQyRo
         1bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751014277; x=1751619077;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TR4v0a3bwzSVaxRyufSNwLHvlYGazWt1+QlKl4AgkUs=;
        b=vjnJbIQwfIhPcI7h9RZuMiqseSu0RGHRikPgbMHVipAI6Zm74duwbEvkJvVLmGtgwS
         Vyvf9M2vH7yygGU95F9+rX6ei6fvGkI8ZjnSULICBxz32kO8pjdNvieS/df+40v1yLd1
         smwIdGmVqf76AEWuAC8TpxOh5RMKRlBVxXh59CiRcKkkCD8QBLmDvWmHMVATiThVvqXG
         8G5vRRg6e6Qqky9WZ9JQpkD4Wjy1T/RrmwqGr71J9vZTAKtvcb4gtiThsjDk/vL8/9Gd
         TULbGIQaCg3ATuE74E9GH6DsJqpKYQQHZIJcKJJhFO7KoJxgbU3HcLzy/nkOaQ4dNcYa
         Z/bQ==
X-Gm-Message-State: AOJu0Yy6XVVgWXylJGYxE5OQGK2l84zxx8VVoiHBkCZeorTwVpma1K5m
	3i/Z6arEuEzEtLTTkJlcg0QE4HrOe5mRUw7prkVEF6Boy9TEBlw00J0jJPmLeo21s7CPet8Tt1I
	RN6FOSZE2HHMc/2w6IBeo2J2kkjaOoq4=
X-Gm-Gg: ASbGncvNxR13i1NpL2gp7DN7aVmN28s1VhlrBjHQAAoTAIKeFzjiaRi6a48fV4Ym92b
	9oQZd5sH+CQp8TjkNg+BNKN8aw/Woc4PKq/zmeUmBx3HgS0OpH/QkPwcaciV6hKrCTc3av6T1xP
	xLIOMvm0OxYS0PIeK+b79DB7GZhQifleDxTyqaPXhMEtCq
X-Google-Smtp-Source: AGHT+IGoLkmtgV2hxtu/W4XOmVT8FrrrR8fyiFV4rbkuHmn3ioDw3H2/Um4AKBc4cU8H+zSXyRzJ2oqeJTqYXupRKpk=
X-Received: by 2002:a05:6102:dd1:b0:4e7:db33:5725 with SMTP id
 ada2fe7eead31-4ee4f4f849fmr2039993137.3.1751014276882; Fri, 27 Jun 2025
 01:51:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Jun 2025 01:51:16 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <qxewasf6rxt6mnbwvfhxarcbvfsn6cnc2jskpddsb5fhxfhpwq@5d727iud7wfp>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com> <qxewasf6rxt6mnbwvfhxarcbvfsn6cnc2jskpddsb5fhxfhpwq@5d727iud7wfp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Jun 2025 01:51:16 -0700
X-Gm-Features: Ac12FXyiymtRjTXNXgfyxSTOMcgdU9BIfLSKXIWydkbh1n-mzRjC9pznGQNdfLA
Message-ID: <CAOLa=ZR_ZhjxYgN4pZsjOuC52PZjGMCzLJVZbwGQb=Q9W-0HSQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120 characters
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000f8838a063889c7a7"

--000000000000f8838a063889c7a7
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/06/25 06:43PM, Karthik Nayak wrote:
>> As per 'Documentation/CodingGuidelines', we try to keep to at most 80
>> characters per line. However, there are often certain cases where we
>> extend this for the sake of readability.
>>
>> Add a maximum limit of 120 characters to the '.editorconfig'. This means
>> that if an individual line exceeds 120 characters, the editor will wrap
>> that line. This provides a lot wiggle room over the recommended 80
>> character limit.
>

Hello Justin,

> I frequently use the format operator in vim to reformat entire blocks of
> text and it is commonly configured to use `max_line_length` from an
> `.editorconfig` file to know when to wrap lines. Changing the value to
> 120 would cause my editor to prefer 120 character lines when
> reformatting, which I would personally not like.
>

It would only wrap lines longer than 120 columns. Currently editorconfig
doesn't wrap any line length. So we're essentially saying, any line
above 120 is not something we want to accept and hence wrap. This
doesn't mean that shorter lines will be combined together. Wouldn't this
be better than the current situation?

> Being that `max_line_length` is only a suggestion for the editor, I
> think we may be better off setting it to 80 characters or leaving it
> unset entirely.
>
> -Justin
>
>> Contrary to settings within '.clang-format' which are used for
>> statically formatting source code, the '.editorconfig' rules are hints
>> to the editor. These are not enforced by CI and are guidelines for
>> editors to follow. As such, the 'max_line_length' used here is only
>> supported in a set of editors [1].
>>
>> [1]: https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties#max_line_length
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

--000000000000f8838a063889c7a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dcf8c054925219_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oZVc0SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmRQQy80b0phbCs1R0hlaWdFdG5iRWJDOHdhWVpDOApud01DNlB6N0RU
VjBYQ0NibVhPU0JCaHorclZBNVd5YnhreGRkNGt4UXJ0NXRDT1ptQTBlQ2ZGd2xjQjJWTnFDCmhy
Y24rYkc3RTkyYUNoYWZVcUpJbUU4cHZwWC8xaUZEYmVNZ29pSjZSSXRMNDRCbG9aaXBGUW1mTGs2
U3V2RGkKTFRDeERCci9CRXM4Q2htMGxoU21jaWxpcGlHSWFralVvYUQ0S1RiQWFlNlBCRkxrMjNC
eW9TZkIyVEV1em1aTgpYdWY3Qkt3VG5ON2tkTmNoclF0MndRVE80NFRYWGlFVkZQSmdtdUx6Q1Fq
ajQ4OFlYczNLN3AyM1JaVUswNTdZCmlsejZsZzNpMENkWVlZT0ljR0dIUzJRWjdXTlZUcGtsNzZV
OW0vVWc3d2QvdkVtZzVLdVV0cGh2VmxIK1VJQzkKaWJ5ZVVIWTdTTHd3R0EwRmp5TEdGQW9CcE1G
WUZmMnRXMUw0QytyYm9NSHFNMGhaRXkxc2h5alRndmNvcytGSgo5V0JMMGo0aUdsTTFJdEtkb291
NTMzdDFZNC9ORU5ObjNHbzNKcUF5WjNGVGpGWCtKZnpteVo2aXlUaDF6TEJXCngrYWRsRTA3N0lW
b2JyRHQyNXZvSW5ZaGNRQmh2QjVJRnBhNW1vaz0KPUZaUUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f8838a063889c7a7--
