Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B93C1F
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344979; cv=none; b=jkhD51mcwWsIoOEUkXkk4ZiLSOSrl28h+oVd0XTK/iVbxtiu3JFvhbCN4rAimtr+jL+QXpbNwduk+qSUZg+VZm5X/ATFhOedZLvsJTPlz9kevKv13KEnc4CekJEjHAupr624jS2TkYK0KeqFAHDcxmrJBFH0d7vCvqPQ+umWJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344979; c=relaxed/simple;
	bh=dpcytT51cK6RztIgjqlGDWFhNcIJ5/EqQFBmPBcqRKQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Ob5IlKDaqbDY/DXyoDm1u7PdVcqQYCawzX8iN0JazA1lsBvKxX1mDGIEvRmDnXxpDR+S+gqLIuf42RbYuy7g98GwJbE2kFZDZ5rvkn0+bbAIMgMz9h8Q+srbfNV8f/fCzQZT1KVWUslrnPWy8hq+cO0briv2GX5s7kTijglCvHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9JzTJGl; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9JzTJGl"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93f63c8592cso8950758241.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767344977; x=1767949777; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tB6RzbQykVoJJ0K5Ua218DeUisHO8hXw4s8orNaVwZI=;
        b=J9JzTJGlY/zXH6OLzetMiTx1Xh00E5nPMuSmfBkHb0qElHkfv3U4aoYvBY8pdObvNC
         KtGpkv8Ehma/23SkieDc64fp4KGL+MsAeZjVvqTZTF1k/hI4UNa/ZMflkRCINhTN0q3P
         UVB+BHW9aySm35ArEYtFmJO+rQOZ7rG0kUjFjvo7SljIk7Ogqdfo9c5dXwPuvT/NgehK
         ulcM1BjfkrjTts3Ol3Y1xW8fwdCMXjMXJEuejCzB5LYCtIVOoznQEHVwgC+nrBIB+ox6
         m7+c746wXN3fkJwkH9zOFjgE42Q1P/dEhe+Zhkl/yaKAtsjAWblE3x7eGGOD5DKuYw52
         48cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767344977; x=1767949777;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tB6RzbQykVoJJ0K5Ua218DeUisHO8hXw4s8orNaVwZI=;
        b=gMqlgm39L/iGkWR/1J5QCBDXB/E2c8h9G8GMdfXH28gd/IKOa0u8/52oYFDJo4zcyN
         /xeqjnvbJdFWP4nVEualy03t9rrQrxGvhkmAJkZ9wbdRBar+c/LHKS522uVM6Oh6xxyD
         T69MWgvl8kb7bgLDBzLs0M9SRoT4rjZoOKmceuzsxOAdi6rEGR9L/fVfxPj5bXw5ELBq
         TDueIFnUCIauor5YrH50thio8wR91FeIIJdwlX27H1xdWyEAVQT8OLdRSu9RCEX59Xl4
         occnBULfyIRTavOCtyX96wRtQF2/Bmy2XRQgwpuY0ne9AnZeYxORUCl4qyfH0XjjElbD
         arKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMRVrtmjHEbMGXFk5Av2TMtKUWPI3dOCcZJZC18Hu4JYb12xshSrLhglXwxQjboBqhMlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDqFuCQSfajQvs/72Xu7jgjUAKICHMvxwnhkndvanuIls5MH+v
	i6AuM14INNmjdR8PR4AdGDDylAQFw6sbO+8v+oHjQMt8mAKUFuf0XZ7uKZtj9LHfULW6N/9T8TL
	yBK9PLNg3XmcSsXfUWf0NETrJbye6mt9NffcaA0A=
X-Gm-Gg: AY/fxX67+sK9DQsIYqFyEpGoQO3UODSksO9Ul6S2szcHKc7srdXlGPEWJg5IqiGaf+p
	n46aBhRchTrESQhgTOxIPCRbBexB1Ah0A2sm9UUoQ1KBapFkfOEffdaCGUlXX8GSmhubpHM3EaN
	ljP96nGaGrWD/G7Rzruk+opx25/U8Sg7563Dpp3UYOT7h9y7BikszQqPwfy9tJ9vhjpGcLWglD0
	G7XsMief17ouzjGWRrUNYM/g0hoBporEaLkdyk2tJSeVj3poSqIYLzg1pFH71QigUCBHmBgzzcj
	XGELxSDxhu9waHvQbvr4P3Xb2SfPDA==
X-Google-Smtp-Source: AGHT+IFNGyfnAypEJkcX5ConlRp37Q3MuK9hTdzKcOe0pLKUG/aUinN73rI4Tc830DqiDKLs4ichcQN89K9Vz+kD9MI=
X-Received: by 2002:a05:6102:510a:b0:5e0:d009:e4d7 with SMTP id
 ada2fe7eead31-5eb0237d823mr15198208137.1.1767344976880; Fri, 02 Jan 2026
 01:09:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 04:09:35 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 04:09:35 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com>
References: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 2 Jan 2026 04:09:35 -0500
X-Gm-Features: AQt7F2p__6vT8T4C84YWODhqCky9W1defBwJDXN88ieDoz5ChohXzr11TZ46SUk
Message-ID: <CAOLa=ZQrKO-Aeoa_9E9Gi3rzM2AuVETDT4sUEuc0V8XQUyk4Pw@mail.gmail.com>
Subject: Re: [PATCH] t1300: use test helpers instead of shell primitives
To: pushkarkumarsingh1970@gmail.com, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008b04190647641150"

--0000000000008b04190647641150
Content-Type: text/plain; charset="UTF-8"

pushkarkumarsingh1970@gmail.com writes:

> From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
>
> Replace plain "test -f" checks with "test_path_is_file" and symbolic

So 'test -f' checks for regular files

> link checks with "test_path_is_symlink". The test framework helpers

and 'test -h' check for symlinks. Would be nice to also mention the
latter.

> provide clearer diagnostics and better consistency across the test
> suite.

> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  t/t1300-config.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 358d636379..9850fcd5b5 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1232,12 +1232,12 @@ test_expect_success SYMLINKS 'symlinked configuration' '
>  	test_when_finished "rm myconfig" &&

Tangent: Not your patch's responsibility, but we should also remove
'notyet' :)

>  	ln -s notyet myconfig &&
>  	git config --file=myconfig test.frotz nitfol &&
> -	test -h myconfig &&
> -	test -f notyet &&
> +	test_path_is_symlink myconfig &&
> +	test_path_is_file notyet &&
>  	test "z$(git config --file=notyet test.frotz)" = znitfol &&
>  	git config --file=myconfig test.xyzzy rezrov &&
> -	test -h myconfig &&
> -	test -f notyet &&
> +	test_path_is_symlink myconfig &&
> +	test_path_is_file notyet &&
>  	cat >expect <<-\EOF &&
>  	nitfol
>  	rezrov
> --
> 2.43.0

The patch looks good. We have two files, one being a regular file and
another being a symlink to that regular file and we simple need to
ensure that they exist.

--0000000000008b04190647641150
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 678149d97468534a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sWGkwNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1ZJQy85UXhwbjNBbzVrcTdCYk04czM0UlRXRXR0dgpMNkc0ZWhaeHZI
SVhiQnpBMm43SloxRFE0RHI0aERETDZiaXhzdXdRTk8ydEl4VFhnUHZnTmRIenZTTDZ5OXFCCm93
d3JXcTRzc3lNZEgwd1NhSW1ETWVPSHE5Y3oxcG53d0hJb2t5SXZRKzI0Z3M3UlJzOWI2cDR3V3Zh
b09BU3YKUEJUaFFVMjByTzFEVDllTDNaT0UrSzA4WFNQL0I5Tlkwb3lxQXc5YUVCbm9OUVQ5SXFC
UDVUQURSeWN4ZlBSdwp6a3dESzBCaE9xR3RScVNxRUFOQ1ZsbEF2S0hNRDJ1TFpwQ1BYWXRjRzJU
REt5OEZFSVV0UmdManZNYXhQM01rCnljR04zSnpwRnN6aFUvTEhOekFOUlA2dmtsbGtYSUJ4Yldx
bWhLRG1DUklKMEdrTzdGZ21GN3V1R0NueFRWeG4KT2dzM0JEbnlieU1DV1g0R1h5ek1Ob1ZMWVYw
aE1kcU4xVkQ0NGZEVmJZajFWbHN5TEtOWjA3NlJ5aGxBbFlmRAp2Z3UvYk9lbUxhTkZmYWZ1aDFT
V2hFREtCVGdTYlY2UzlPemVlT0tTM0xSZ3RKUEY4dHRvUUFPYjVVNjdQVkZCCit1TEtZQk1KK09U
Syt0QWg5ZENVN3hGaGhDdHo0SURseXF2Qy9XUT0KPTh6NHYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008b04190647641150--
