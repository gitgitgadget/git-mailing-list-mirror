Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205081751
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459616; cv=none; b=Dsn0s248o7KI94HX8O5WVm9TUBEfCBPu3BZ/X8FLzWZ2EuOMwqarsFDYnCPGUtVvM0Fxnt+lbibP3kD0jdNzfFe4B07Cid1oMHrNIP2EjrMFmfAsV2G0FJjgKQHfzJj42gAZUOTkRxrBKt8tKf/8hxwR9Fj8QFje3P2nrnmqn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459616; c=relaxed/simple;
	bh=OVxpdPn/jyiow5uYrLg7/YrLxHmv1QiQ40GQHEWTNZQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ8M5aQAf9Mc9adbSmMjWst3PJVqm2+eLCPWHUyOO+Cwn+SGUUxj4hkIe9ELlTFBwedxIfjy59cD8vftEL1AopoHPcYfzX8mV0/f2wWBWp2RiPOV5zQ/K9WJ0SdxX+8uNAXCVnIvbhvB9KMRY8JK1h/HEsIZAdYyOQ8mJWJolQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQx6Z/Vd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQx6Z/Vd"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee92f7137bso35081351fa.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720459612; x=1721064412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEFgRuF4SsUhtkNl0Y0h3KJrLxYVYJbWOTt78F7p804=;
        b=eQx6Z/VdBRnOswDVRGp9y261u10RdaeVhZ/SvI6YllH/LrhizD/a8uSyKBZSKUOzac
         ANHxkxt9VqQ2VNnl5vS4Oy7Xkt48przuKpCj9Ueibzk+MIwd0w+sRF8T7cPkIGXzPn/c
         vlpWq/lUSkm3PQhN+brO4OSLNmRPdJiU9ewVgZ79QWcGHQyzrfUImvIJKiuYrcIthdnK
         +DfpSLpZErhU3fOIoMR/wsDWWT9g1ilIuYo6axiN5+mRss4ak1MKi97454doenlBLjV3
         jFY6GsVg5fng1Qa0xOO6WPCeT702bvOr2fQaZv4IKrZmTBW0AGgSnqL8lR8olHHZGp8i
         K4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720459612; x=1721064412;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEFgRuF4SsUhtkNl0Y0h3KJrLxYVYJbWOTt78F7p804=;
        b=AFKg/zJ6hlmC0BydUTsTOf9L30pSr/KohkMWkNUfoEcpoIGpx18jxOEVrHUbe9nikY
         fybgpPVxpK+H/sNn8cd2Mn76Auh7FqXk943aFChUlre/RboDe68cfVh/bSETMcRnjUOd
         9ZcYa3JAz8paiHB5XALPFaTWcopg4xlLTC9FxpjMbG1NvfCcrERCY2opCTGWfFv+paNW
         e+pbq9BASkzwESlg1AfB3LFtPhAosYTlMu1Zls8oiG9VFgUm8pEQt7O5em6BDDn7fGN+
         5ho5KomJlyWj/81HmodjopqH0kwse1ll0Sbb5PJWmYkHtDKQAKyhpTpHeRLqKxjHa0Ph
         KMkg==
X-Gm-Message-State: AOJu0YwESVdjxBNrCmbZnCV7J7NYFTVMxwZfMW2N868yNiVFj/18A4ZW
	ul1vZ3L2m5wcAfdpPBORAddKs3HsAxWIuftXlEcjR4j8YFAM/4Pfcr0QQ1zUyq9ajPn3+HDUyyA
	bCGzm5jue+VME48IgJegXkzI14fo=
X-Google-Smtp-Source: AGHT+IH+YNbErN/AZuA7y8aeV+m2sLMbbGev+TVZHyUydM6FfqjK13JAZAWsWDHmzmR/41MrhiqBndoFYZsDSdIGmOY=
X-Received: by 2002:a2e:9048:0:b0:2ee:6254:f9f1 with SMTP id
 38308e7fff4ca-2eeb30b8afdmr2908561fa.6.1720459612262; Mon, 08 Jul 2024
 10:26:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 13:26:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qybj039.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-7-karthik.188@gmail.com> <xmqq8qybj039.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 13:26:50 -0400
Message-ID: <CAOLa=ZQUv7=CKFY7YwfVeOW0qobJbMU8nadN4daB7Lb2=eJc8Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] clang-format: formalize some of the spacing rules
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000000a2ce4061cbfb800"

--0000000000000a2ce4061cbfb800
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> There are some spacing rules that we follow in the project and it makes
>> sen to formalize them:
>> * Ensure there is no space inserted after the logical not '!' operator.
>
> Shouldn't the rule be more like "no space between any single operand
> prefix or postfix operator and its operand"?  "foo++", "--foo", "~0"
> are the examples that come to my mind.
>

The rule here is SpaceAfterLogicalNot [1], is specific to logical not
operator. Unfortunately I couldn't find a general rule for unary
operators. That would be very useful indeed.

>> * Ensure there is no space before the case statement's color.
>
> "color" -> "colon".
>

Will fix, thanks!

>> * Ensure there is no space before the first bracket '[' of an array.
>> * Ensure there is no space in empty blocks.
>
> Hmph, I actually thought we preferred to be more explicit, using
>
> 	if (foo)
> 		; /* nothing */
>
> instead of any of
>
> 	if (foo) {}
> 	if (foo) { }
> 	if (foo) { ; }
> 	if (foo) { ; /* nothing */ }
>
> to write an empty statement.
>

Yup, that is correct. This rule doesn't state that we need to use 'if (foo) {}'
over the more explicit format. It only states that if we do create an
empty block without statements, the rule is to have no spaces.

We only have a few instances of this in our code.

[1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#spaceafterlogicalnot

[snip]

--0000000000000a2ce4061cbfb800
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: efae252766eb7fae_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTUlWZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnJFQy85dnpmaVphdzBNaitqUmMzdTJ3dkxXaEdjSAp4clJLQzdrZDJ0
OFBUbjd5bFJ6ay9YSWdDYlh1SGNod2lOY1pDTW5UVG0wYnhTR08zMlNPc25HRVZWQnJwRkw1ClRZ
bWZGa282WnozTFlkS2M4V2VVSDRURGlRWURyd3FRQnhoQkdHRmovcWV4OVcyS0Q5M3dMRDJnamgv
MkpwRnUKT3JVWEZOa3krZDJxdHlSd2MzaFVlTWI1aVk3Q3lDaG5DalJDblUxdWYrNGhyNXdBUElN
VGljTXJFdURQSTZtbAo5VlprVXkxbVh6TkE0bDhrc1BXUU53QUhIWUVFWXZIK1dFQ0huL05QR2Yv
V3NzaXhINE4rN1hvT0FlZlJzRzBkClhoUWNUU3F1T2tvdWxJRmhIZkd0OXZHRHJhbjRONnBKNUNu
TmttTVNtSWJRLzNuTFBzV2tlbFNxMVo2ckEyUGYKU25UWmpKVDZ4WTZLVW5NaFZSVVQyMlFLOE5G
TG5aQ0t0Q2xXaGRWTE9Yb3EwNkxXSVJ0NGhjOVNPb01mZHRnMwpRSVl4M2FXY3BRaE5aRGJYMDJP
cDFVK3hKNlVYWHFmUGkrRlN2a1VhSDlrUmdaUUhGencxSWVkK0ZGN2F2WXVTCkFBY2NOVUtVWDlV
YzVubWNxdjc2NjhTbXllQjdxWEJmcTdRblBQOD0KPUorMVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000a2ce4061cbfb800--
