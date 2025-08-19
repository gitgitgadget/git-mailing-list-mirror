Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE23451AB
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597477; cv=none; b=Fgm41qeHP4CmcIkfSj6T6C781jFjg6Fo2251Nr85VLFQj8baDhxW0+Mh/yRIJQTvQNnPnoYC48Fcke7YDLppqTU21TDQxPWNX1rjg+po8LfOmz8A6WT0dpO8KP3YSFYtFtXUPdHwB4KidMoiw+BKBFQfMBp0bVx4JAbDm9dCTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597477; c=relaxed/simple;
	bh=8/I41jj2X0J3yptUEFAaBHUVN3QDe5mbremC6z/Fj5s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=dUDFT4FPkQ0bwbkC81HwC41/QdJf4L++5sgWLyoINisIdVQOMbqqHK4dcnz+kfG2mh9LxopiS7uIO0Au2opHKFDWHDTosreXpdbeGPV9lbmImy2wi1qIWliQ7LXQroMVHyAImhDvNCkVmP5rTdT4+0fgoSGa/4XyMcEePv1WWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqHmL5RE; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqHmL5RE"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-50f8b94c6adso1234219137.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755597475; x=1756202275; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYz5R+H14mMqVefzj2Z8/LodVDgksvlrk/jQc4nMIyQ=;
        b=hqHmL5REaY1e2oCNnQMXAQTXLP0GLNR30CnO0jH6Y3/0DK5ae/MSlLyhYvtJi3vkkp
         IEj8reFHB+mfd9givjMOSbM7uYsmCUmH2hw9ul8HvNFXJXW3V8o0zv1g9ahfNjFYYn1X
         kQ/8hQnVf0cXLN9UjIsKaIZ55xYSonj7hMenhGudok3w223geBcm29sV5O8/30qsY3AH
         qCXkMTj71b10kjrs8bDd3DniOS+OnCyZnV3AccqZaJ/I0k7XQbTbLGHiRZW+OeBEiEBi
         yFpK3RrfLb1tRZKaxeLwPIiJKq/ngoLD9Z404M9Z8ysxCJKDY/gI+uGV/BEgURoag3MZ
         gDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597475; x=1756202275;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYz5R+H14mMqVefzj2Z8/LodVDgksvlrk/jQc4nMIyQ=;
        b=JHTYlehK/pu5AbDS37hhABSfizvffaghF7N11C4BD17ARlVQdltubUDiz9UepY3VHz
         HwzXRe3V+iJiRkzaZT5gXmthO/0SykfAoodA7PrMqKZYu3/JXePH85GnvlXjmdmaHIx7
         /3wK0TyR0FXVBSLA6N8CspnWp64CjJovkKAN40rKuoIcWt/g75SZc+jN2hUc+sXODgbG
         7Zy8zeBgsmxAIwuxJTzZDgTY23GKBtUpa9AmuCpqrTLuunf23Sw0FCoEfpbHmJZTkJpz
         nt/3wS1SXe5UEUE+baZe+sQBdSKW1J//3mfqO0CMwLUZySZquGc3WtV83mCciMTY3QfU
         ZDIw==
X-Forwarded-Encrypted: i=1; AJvYcCWuzhXhbHLBefwQpEpnwPV9RaW8v3TwkLBjDkJRhRvR6CqbZHfXBURZXOUOqN1v14RLugs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzldoWsePwhwaa0SPlqvE64hqGPXEYKYFqc4rhnZRhVTQcsBodc
	CHW1oir9VUjW9UOdCpXWsrX+rnVXxrrQdOIK3uJvdb6Tq5mTsjxAT0tFrXd2Lm4moj5cQ1vn4hJ
	n9F95hozfJ+HMcW9QsYVUgobFWN8wBzw/8g==
X-Gm-Gg: ASbGnctI5HHx+XEWT61WwyTzOOVSg2rsA5BR270vmcZB77lBxsJ5os5XSQxxLvtYmYd
	zbOpsvFBVTV5nRzZdNoJWYHuYC/So+Drn/LnlYVkAtYx4hT6F3NPRXnZ5h/tA/tMEdoJSKd1hd3
	szDFLn2v6iH5ETg+TWj1TUqcEeOpapEsncgU26v280umOytwgbJmKoehH3PvczDHJXT8KVTjvwS
	H+lX5JyaqQ6GJQ7ZQ4=
X-Google-Smtp-Source: AGHT+IEk9VWLf3LBjPJxwI2BfFHabLoh30yqSn5XB3bpToS8Yo4skIHEpIswtaQQap4x30efiAkInZiWO6j20YbpypQ=
X-Received: by 2002:a05:6102:38ce:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-51923a263b0mr507147137.16.1755597475164; Tue, 19 Aug 2025
 02:57:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:57:54 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:57:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Aug 2025 02:57:54 -0700
X-Gm-Features: Ac12FXxMHwYkmCb7ZUnoEMoPJXnoL8W1Gkk6wOEuBxpwAZ9WsU34CjvwBdHWcdk
Message-ID: <CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com>
Subject: Re: [PATCH 03/16] odb: move initialization bit into `struct packfile_store`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e054d3063cb4e3d4"

--000000000000e054d3063cb4e3d4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/packfile.h b/packfile.h
> index 1404b80917..573564b19e 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -64,6 +64,12 @@ struct packfile_store {
>  	 * list.
>  	 */
>  	struct packed_git *packs;
> +
> +	/*
> +	 * Whether packfiles have already been populated with this store's
> +	 * packs.
> +	 */
> +	unsigned initialized : 1;
>  };
>

Nit: I know this is moved from existing code, but might be nice to
adhere to our format rules here and remove spaces around the bit field.

Tangent: Also this is something that is only mentioned in the
'.clang-format' but not in any of our documentation, should we add it to
the documentation? Usage seems to be around the same for both types.

>  /*
>
> --
> 2.51.0.261.g7ce5a0a67e.dirty

--000000000000e054d3063cb4e3d4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8a608f1eb9f8d1a0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pa1NxRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0J2REFDSHJ6aWRVN1lLQWNDUDhHVHFZVlJlVFp3VAp6YUYzN2ZUZkQ2
S2t4RWNYa3NjWmEyTzNRdTQzSTFMZG5OelBiMFFNcUNXWnIrSTVhTHRBeFdwV3h2TElJS2ppCjFq
MjMvQzl0U0tzTzJCdWNIcUY1OEt5d0RHb01mcUhDMnRnWjkza2FLbWlIMHI0R1luWmJIU3EyMWJJ
WmxhSDgKU3hlVkpGRExpTlRXWDlFMUtzbytDRmpsNlBPeGtwSEJUeXBycEhmTk1MUC9JWUlGbGdX
OVlUSXVOemMwTXhJOQpmWmZ2Z1hkNkQ1L0JDendZckIvSk5DaFhGdE5ESndGYkJxcStoZEJ5U3Zo
MVNDTkZSVFpSc1p1aGlXK0FpS0ZaCkhWOWxLSE0vZGxHSjNoNUc0OHdYb1JPeXJXdDArNGJCT2s0
ay9NaXh0Z2R1bUpWaUYxTTB6aHA1MCtkVVdoRVkKRlQ0dHFzTS9zRGRKUUNVTkIxaWNZaWcrWUhJ
YUgrZG9zYTg0VUV1L1MxVWNlMEZXdkxIN3FETjRnU2crWFZKeQpwUHk1UnloNTltRGtKWjBVNjl0
NzV6bjlrOCtBK0Q4cmcwY0p5SGhXcmlmc0tpcHhpOVB0WlRKY0VkOUhHUmhsCnNXUXFud0s5Mmh1
ZkJaa1pYSlhjY1RhNUs4NkxiNmszRWFtbStIYz0KPWpOY1MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e054d3063cb4e3d4--
