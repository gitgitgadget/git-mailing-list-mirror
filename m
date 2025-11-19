Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EE2DF15B
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593268; cv=none; b=OnxHmXcAqNXG0exhRUlR9qfbl/aJnr1dsRiyOoheDk031n253gvpDLpvPINn0rJgRoiX0Mky2UqNH20ufYXFB9xf3BWlUlOSE6KVpICPTzDKDppaXcn7eFg1dkCmd9pzkhhSngwlSde3sKeFQE0tuWay8WAMgv2BoGXRbj3CD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593268; c=relaxed/simple;
	bh=WFBxkH4tIzmIoRn75lrsewYfG54BLl2lhAtKn7xbI1s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFmlWIUphhUvz8qkDCvqtseTUGTjtr5iOvpkZm+V0nPDBUKoaRZVI2j/GEGtqhKIlKG6l3oTL4hBzuU+yvSgd7dZ1gL2k5rf6mlSHGIH8TbfLuXX4s0vwkEh8vDbTG0UxMOTcKIbzE9ef1PNQGK07zrRG9TkRTtFR8DFaTjtGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggZYTdPR; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggZYTdPR"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55ae07cf627so77937e0c.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 15:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763593263; x=1764198063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZpOTKR16AyCHAB4d8+pClE5gksGj+SsPshGJQGnbIo=;
        b=ggZYTdPRBiMtypp5tzXH4cs01PeXnN6HRQze13tKVhIodosevm9VhPBxerej1nT/bb
         MEjjnbxNwomKiSyGd3jdHJhk1GhzwbAmS/wCrasg1L2AN8D+QRoUDS4FS33C9xXnbq8g
         rNdneF2czINzKSojLWxlxYIXtW0h3dML582ep3oDcX0407SbBrk0thpqUNYbqb77DxE4
         kOq3ICIrFTtkA/ZOgR76K1Ryv78AGwhnOYR91y4NDKMNj9TRbytGHjPWrn/5cF6bUEqv
         H5XdYfwGQulpMJuSGWIZXl9TfinzWXe2rZstLId7Fgizahgg/vDwoz8q6Y2Ua/MYUesD
         zg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593263; x=1764198063;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZpOTKR16AyCHAB4d8+pClE5gksGj+SsPshGJQGnbIo=;
        b=I1Dz1jMF3u+i7974rj4EUYKq6yO6Gp/4uDtB58bg0wfdO8Qlbyc8+xGrMbAMyPveTu
         ldtJheaearys6qy2ayBHJ2WWMleTuwIsyl345fL6rK9p+s8u0Jy/oIP2lKM5b6WpnshE
         kLRYah5Ln+Jlh0N2hK87oMmM0hvJD/fJ43mLA7JNGARG0IwQphEaXXyn1lFoLf+2PVa7
         VmB0AR27SSZ9LzQ6yJwZqCg0hWtTkgn2Vom/x9XknY+2/Qkm2GwgK8clW9SfPhbhvcR9
         RyZ8FIGO+d65KbfmDVwmpRU7ITcI8TmpMwMjEIivg87uSCWkCMHzEn0EMRvTG+OAuK3R
         7UJA==
X-Gm-Message-State: AOJu0Yw8ChbMwQcLwkMTB9ZQvMY6pNV5oJtxsxJknl+tGxzBr8a4JA/7
	dLTlmsDp16tHARZHX/m0T/rr2WIj/NhZQ+UyLRwidoxpSmvdKrKFztFvOgwRXeNOEatun5Mfh1D
	DZtJqW9xSUcF0pcZdVSQMqunbTtkwJ4Q=
X-Gm-Gg: ASbGncuewN84PnIthFyR1SKQSPfr59qKx8WWdKjHSp4kto1e806yBQHmi96PS8o4nxN
	G2ES4XqLv4RXMkkzIwj0iuCsXIFzhQWZCKb2MJ/jukk5wVAUj8p4AtfwzGViN7DGHU9thVLSVu6
	PYiN5od0KBpDj8FyWZ+QfvK671XMkKl/s/pDedtGyvw6luTlV4rROPb1rtbJlFUTXtZ+XvpUQ0F
	pbxIqtEan+dpHPpaSYLJ1Xm0U9+6CirFD0aGcpB5G+rTC+jF168ABHZiD/CBn6YnsbiQbItzwop
	FMHNaRx7rTLgzPpQDf6w2D99TzcUAsIYwWVeXjFBuGbr05U6
X-Google-Smtp-Source: AGHT+IFpLkIP2hfLUcvZjzmL59CFOcwxvc6VSP5xWrh/nYHhdApZUty8DsQhWlt0HxQjsb13vudDAibKwgNEiF1LLFo=
X-Received: by 2002:a05:6122:c9d:b0:557:2551:7e9f with SMTP id
 71dfb90a1353d-55b7f21878bmr408495e0c.14.1763593262589; Wed, 19 Nov 2025
 15:01:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 23:01:01 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 23:01:01 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cQ1nF47Rvvm4gDks8Bzj0htzUkfR24WB8UdnJtcQTQwCA@mail.gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com> <CAPig+cQ1nF47Rvvm4gDks8Bzj0htzUkfR24WB8UdnJtcQTQwCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 23:01:01 +0000
X-Gm-Features: AWmQ_bl0OW_OXZZcjMiAhpAmfSTrRu7cLjlu-NtsPJCXweb_7v6uesU_9brA0M8
Message-ID: <CAOLa=ZQvG+D7NwT1mW50pC6+QGc7_PSvoTA8GgK0cvDKondx8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f208a90643fa8d03"

--000000000000f208a90643fa8d03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Nov 19, 2025 at 4:49=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>> Git allows setting a different object directory via
>> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
>> This asymmetry makes it difficult to test different reference backends
>> or use alternative reference storage locations without modifying the
>> repository structure.
>>
>> Add a new environment variable 'GIT_REF_URI' that specifies both the
>> reference backend and directory path using a URI format:
>> [...]
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
>> @@ -0,0 +1,109 @@
>> +test_expect_success 'empty uri provided' '
>> +       test_when_finished "rm -rf repo" &&
>> +       git init --ref-format=3Dfiles repo &&
>> +       (
>> +               cd repo &&
>> +               GIT_REF_URI=3D"" &&
>> +               export GIT_REF_URI &&
>> +               ! git refs list 2>err &&
>
> Should this (and all other tests) be using `test_must_fail` rather than `=
!`?
>

Initially I used 'BUG()' instead of 'error()', which was wrong, but
meant that I couldn't use `test_must_fail`. I've fixed that now, but
this was missed. Thanks.

>> +               test_grep "reference backend uri is empty" err
>> +       )
>> +'
>> +ref_formats=3D"files reftable"
>> +for from_format in $ref_formats
>> +do
>> +       for to_format in $ref_formats
>> +       do
>> +               if test "$from_format" =3D "$to_format"
>> +               then
>> +                       continue
>> +               fi
>> +
>> +               test_expect_success 'read from other reference backend' =
'
>> +                       test_when_finished "rm -rf repo" &&
>> +                       git init --ref-format=3Dfiles repo &&
>> +                       (
>> +                               cd repo &&
>> +                               test_commit 1 &&
>> +                               test_commit 2 &&
>> +                               test_commit 3 &&
>> +
>> +                               git refs migrate --dry-run --ref-format=
=3Dreftable >out &&
>> +                               REFTABLE_PATH=3D$(cat out | sed "s/.* ${=
SQ}\(.*\)${SQ}/\1/") &&
>> +                               git refs list >expect &&
>> +                               GIT_REF_URI=3D"reftable://$REFTABLE_PATH=
" git refs list >actual &&
>> +                               test_cmp expect actual
>> +                       )
>> +               '
>> +
>> +               test_expect_success 'write to other reference backend' '
>> +                       [...]
>> +               '
>> +       done
>> +done
>
> Something seems amiss here. Presumably, this nested loop wants to test
> various combinations but the `from_format` and `to_format` variables
> are never consulted in the tests; instead the tests just hardcode
> specific ref-format values.
>
> Also, if this is indeed meant to be loop-driven, then it would be
> helpful for the test titles to include the values of `$from_format`
> and `$to_format`.

Indeed. I was hasty, will fix :)

--000000000000f208a90643fa8d03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 285384fd600b9748_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZVRDc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meG00Qy85SE9laUpERllkY2I4NjNmbmtKSW4xMm1JeQpoaXRGanVQY29k
NVZjUyt4S3hhMHl0TVFDZXltSjUxSjBpTzRYaHVscDgxZ2t3SUd1N1o4TzhiR2JGaVZycjUvCmVK
RWgrZ3oxZE9WR3MrVkhVcWRPQyt4c0dpL1B2cXB1NENLNjhwSUkxblVpVE02T0oxQVpFM2ZnRlc3
ak5hbTYKKzN5Q3l2bzhYUlN3WEk1aGVhUDluNEphQ3NhU3dHNC9UZGhUaWN3RW95Vkd2UytrN0p6
YVQ0YkYzbXB2YTZ3TQpubC9IbXJyN2hUWkdrb1BvaW5HdjVSSnpMSTcvRUs5TzNuN3hUVTVWNHVH
NCtMeW1BNHcyUWM5cStBL3lpVUM1CmZsRGhFa085bmE0T1VtNTJhQnBkb1g1M001alJHUXVNRjZo
STFpRkVLcjg0ZE9ueTk3dkloVjVmdWIvWTdSN0cKM3I5YlhicFN6eGlBeXUyKzVzK05NTlZJODd4
YVh5WmpmVk95NEppa1dnWGtid1hSQ2M1WHlzSFROM3hJbFd4QQpHNTlLaGZoQTEwUG1YNXlsYmx2
QVhlT3RDeERYMkM1MEJ4aGg3T3NvVyswZmcrM0M0cDV2aGEvUm1IdTBPdVZPCnYzaHhtaXBQYTF0
L2NXWFErcTBUbHg3cVVicUNtc0laUDM1amI5bz0KPTBQWTQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f208a90643fa8d03--
