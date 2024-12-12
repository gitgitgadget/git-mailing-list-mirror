Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F210F2
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000165; cv=none; b=KOY2y1mugLLRUOs82G4F7aEZZY/cdXBGOHTVDl/ygOKsLs2kKMFKKj0ESLzeLh77eY45v3o82HgQk4JzXN/+/k6i23ADI+uxIJkQo31SWVGttZLqT1kCba6eyQw6usWxlOIfcR1ZOXvkU8gS0441wA9gfPIgbBpribO1zrOsF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000165; c=relaxed/simple;
	bh=x91ChNHe+9NyLiBfATMbWGOCM6Ck4+eZhL9JMVmpfMQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=abWjzUNo67OmdGBm8b7WKBqkBeBtMlESuFt+E4LqTTdy3tJunH93B/186hHTRbC1c2uHWXghcQ1cnJuD5wXA3KUD1oKcROAb9f/D4HQttRurViMZ7mMB2yiiSIdbXkwmwoL01Y+o9ELkuAaakyIuBNcrJugwK9B1gK1NaIk15JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf357A+u; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf357A+u"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c529e72bcso109365241.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 02:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734000163; x=1734604963; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8uzLSap5SfAVxWRgojDu0CWTbH1g1PvuSCZQ3ZxG/Q=;
        b=Tf357A+u011Yco63fPSYV96FfnHFRwBAu8rO3mp4Y46/Li9Z+eTWsQu2U1KONvbI9W
         DX+9KAtp9JnhNOpfzHeX0iX2Qag0tmRYWzWTHOeaictRdRbriwj/QjfIpIQO94QZkjOG
         9wgAC2g3qECAmZILSgmfIWQoHpUanxkpMoZsxhqaCSBK4duvkXyWT221iZsA3dfOSGDF
         q33S+jualkABO3y9FF0Vc9rHqoadun+Acjd2cnFvp5uj9ZECyHJpX1YUSYmj9Uqh1DPH
         LntnW2FETtYAv8pxooKIGTcvCoXPgF6yBqw42eLx4EwlLyuJvSZxUXWN2/ePsLVqGrVw
         EAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734000163; x=1734604963;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8uzLSap5SfAVxWRgojDu0CWTbH1g1PvuSCZQ3ZxG/Q=;
        b=e7lh/WCbdo6nEXVbGINF4HWzmnqxFvzKONi4y0GsXfuZTeZ+bIT4TiwsTStTJ51ojD
         47kxbb7d1d2mC4IbNgGT15P+2qA0hCv5io89sI2QSzoBQKeHNo6uvcFqPhG4rA/QzMdG
         VbHPeJ8DAQ6ugBmB6pWVyOsXcVb/wlbupSfPUudU0atfDZKqg1Z00FLvVkaKH7i3UNxR
         fhlC3o6WrNPnMgFDhqcMY17wwF+gz/4DfB9OIPqrcxB2OMHGQZM/FM9jB6qCdqzbff+p
         PmXBBa83noV7nLQ0bjbhWn37geIIB7Ta/L3YI7JAMW7WnK7it7DcXGOc2jd7c9rRgUCW
         NaAg==
X-Forwarded-Encrypted: i=1; AJvYcCWxuREUxZfatjqBm8qdzyrqxEC85cndzsShq4dCdrIrJE+KYQjjFWJYIzW0jUWU04QIFR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmrv6nzlQEr/gPJe1D5Hb5usmzxqOCQiN4fJkQcgCa1hn57iV/
	hJ5IQN7gSjLgLw2bDudHAwyMqJekgCZNuGK87/DEdhCzwgxcV16hPpnCkHc+X+wQKDNzImU7enx
	do5o+TOuDz1zbYF6mzhaPWD8prLE=
X-Gm-Gg: ASbGncsdNF36278vJQDdM0nfiZPpTviPoMeG56HnDXiay523YQqhejq6yB6IS6uX7h2
	QJOLkgTgn71H3ziR+FE5Ah6UHGyH/3FQBAJ5T
X-Google-Smtp-Source: AGHT+IEEE9Z2uSMbC/h9fWV1sSKF+KEbGHUrYR3IlcLlzgY41V3xLxPVDs66PuX9ut4ZhO0h5DuUKhlWqHCmJY92R+M=
X-Received: by 2002:a05:6102:2ac7:b0:4b0:93ef:d573 with SMTP id
 ada2fe7eead31-4b247475747mr3521007137.0.1734000162787; Thu, 12 Dec 2024
 02:42:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 02:42:41 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241211-pks-meson-ci-v1-3-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im> <20241211-pks-meson-ci-v1-3-28d18b494374@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 02:42:41 -0800
Message-ID: <CAOLa=ZRtQ2ab8_gf348eirDdrJYjSKm28aR6YPeY+7JE=77nOQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] t/unit-tests: rename clar-based unit tests to have a
 common prefix
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000be79140629105fab"

--000000000000be79140629105fab
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> All of the code files for unit tests using the self-grown unit testing
> framework have have a "t-" prefix to their name. This makes it easy to

s/have have/have

> identify them and use globbing in our Makefile and in other places. On
> the other hand though, our clar-based unit tests have no prefix at all
> and thus cannot easily be discerned from other files in the unit test
> directory.
>
> Introduce a new "u-" prefix for clar-based unit tests. This prefix will
> be used in a subsequent commit to easily identify such tests.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile                              | 4 ++--
>  t/meson.build                         | 4 ++--
>  t/unit-tests/generate-clar-decls.sh   | 5 ++++-
>  t/unit-tests/{ctype.c => u-ctype.c}   | 0
>  t/unit-tests/{strvec.c => u-strvec.c} | 0
>  5 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2506f3b7e3377ab1a376338c86a727b2ae92a6e9..6eafaf174aaa380ad8e6a86f75d003eb6c058fb3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1344,8 +1344,8 @@ THIRD_PARTY_SOURCES += sha1dc/%
>  THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
>  THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
>
> -CLAR_TEST_SUITES += ctype
> -CLAR_TEST_SUITES += strvec
> +CLAR_TEST_SUITES += u-ctype
> +CLAR_TEST_SUITES += u-strvec
>  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> diff --git a/t/meson.build b/t/meson.build
> index 13fe854ba0a18f9b83dbc48651f581198042ffd3..9e676e69363ed6311426500d98fe281e30d26bcb 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1,6 +1,6 @@
>  clar_test_suites = [
> -  'unit-tests/ctype.c',
> -  'unit-tests/strvec.c',
> +  'unit-tests/u-ctype.c',
> +  'unit-tests/u-strvec.c',
>  ]
>
>  clar_sources = [
> diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
> index 688e0885f4f28182c3afe19c067b6d59dcacccfc..3b315c64b3711bfccc5941852a0782e02cee82f0 100755
> --- a/t/unit-tests/generate-clar-decls.sh
> +++ b/t/unit-tests/generate-clar-decls.sh
> @@ -11,6 +11,9 @@ shift
>
>  for suite in "$@"
>  do
> -	sed -ne "s/^\(void test_$(basename "${suite%.c}")__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
> +	suite_name=$(basename "$suite")

So this strips away all dir and keeps the file name.
So `t/unit-tests/u-strvec.c` becomes `u-strvec.c`

> +	suite_name=${suite_name%.c}

We strip the .c here, so `u-strvec.c` becomes `u-strvec`

> +	suite_name=${suite_name#u-}

So we finally strip the `u-` prefix here.

> +	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||

Then we find all test functions in those files. Makes sense.

[snip]

--000000000000be79140629105fab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1fdaafbaf6207f63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYXZoNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHU5REFDQUF0V3VyRm5YUW1xVDJIY1daZmhnUXZxeAp1eVd6bVpiZ0hP
dHVYQXFrWWNaeDBxc0Q2QkpnZSsxSzU5RGlWeEN5VTBKaFBFRFpOU0ZiVW9HbjVFa3g5bDBWClhO
eDBNUnJjTVBkNm5KRHZoWUcraUdvZjFYekNocHNQZFk4MnQzVDltQklIeE5yUGNBT0M5cC9IVzlz
TCtsanUKZGhaalo1TGRabnNrNHFISGJlMEtCWE9NazNuRFgxdlNpNVRuOVkxbS9FSEVoSEp5Z2xK
d0tUalRXeE1lK3FyegpaZGhJSjNoREJhbUIvdGhLZU5KQm04RXhXWFZGcXE4RTJnUXNubk1ZRkNV
UjNHMGl6UFZ4dUl2ZmJsV0lNU00wCjQvUnU0YUxvbXU2dGNJK3BkbVdSaW4zem1LZVJPL2VMbFhG
NldjVlpocGxob2tHZWowMEh6OFMvSlYxTlBqU2wKeG1JbStnMWdYdHhncEpSdjNrb1VsdW83c1hF
QnpUbmNXdnRCaU8rbE9ERkJyaGxNTVVCazVjajdWaUpkdGwzNAo4ZHVHVUVkTVFta3Vkcnl4NjRQ
SHVRM0FEUzZxZ3pQRGVMQzQyUFdJTHptRlNQTUlYM3h2dEp4aWdYZ3BPVitXCkgxNHMvQWhITTdT
S3U0SlBWdkMrMEp3VWMxb2tmL25qUGZRSk8vST0KPVZ6ZVgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000be79140629105fab--
