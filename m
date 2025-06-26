Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5C1FF7DC
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926482; cv=none; b=PrPj6LwHsSkS0MSpI1tkgEFQM/DmuDHja6B/K8mlvF6Y7KdNhCjkKjP0JsPYlABXc7rZuN4yEGkOX/HAd4ZCGuUevbygPkEkfjMtLT9mBYOzSxaWZIdCPDCC95qrVsuAFWTbMuYWGZNfjRJvY8q3Ij0Plnml2xTfYVoFJCKIPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926482; c=relaxed/simple;
	bh=/s4Oe3SzgkKIWHbIYYspRNKFzH3cGg+U4uNMFvnZ9x8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0n877RyQgFi+vghlHvOF/ssLX3+zrs/xIg+WVtKBvbQRQcvDZc+oVqzQY1WRqPFv+QvO1Xm6UfsU4L4A5PLtgPNP9OwRkTRCsa+rOIvM6rXqpSzl+V2XH31dVl3krDFu/AEClr01HTm2nZD3C9uLEdt2JLCWEiRPGUxTmmNba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYindY4f; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYindY4f"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e9c6b44477so462125137.3
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750926480; x=1751531280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8JgZp4Vw6dv7IV+qhYdhFqIc/OTbmNoWRNl2RYjMg/o=;
        b=LYindY4fvIK/9x1gBYQxtZIiU3152feZgMLyaAfs8+l7RNQkwg/Qlrw8yiBKNMedXU
         5fgQa9MMiS06D/AazH5/IiaH43QeGKGU1MbUtXxkPZvmWSOYHxmHYuLO8Kg/gDsleOsF
         yDEaEXN/UMDGKMXMCIyUViNvyjOH6VU0NR/zWQ+zyYYusUTIOUhzCpEQzYoEiEXT64v3
         HqftYvl7HNzZHP3W6BxP+/Ns1SrSwFQHdgn1BUcp1ni+22hflP5IebLnH5w5Bb1f9K/E
         PqYTAHwQ/3PeUdAfgloqDoA6LT+mAJi7RjWwMaJuU1o+LpwGGahh381FidSgupVnX/a4
         iH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926480; x=1751531280;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JgZp4Vw6dv7IV+qhYdhFqIc/OTbmNoWRNl2RYjMg/o=;
        b=EvVeaUh33PIaTo52Z7Fki0qb7Zu329jcfyp+D5RrEubIpBwS+cndYZ3z7X2cF6VfNZ
         xVOOwSEvwyLzCePaaWPkWZNABB/VX44XleaCFxnnb9rrTPJPV4VtghgRg87e4bM1Ynaw
         kJ9gT4y3J8Gx/pMSYozvuFHuOs5cpklc+1qR160wQx7Eunj9oV1prB+Mf6kdaoBLFDi1
         lAI/Qk5/w2CldXgL5o8KdbDAriKVJw0qt/biRl0fVK21mUDCwbNGmmxihY5v+Rx29GDy
         Lv7x0/bPAIaZRSbIvutlgqwTzdcuJxppkl/UbqFNL3evDebaeGfZq096USxS1RISuaNU
         TFlg==
X-Gm-Message-State: AOJu0YzqoyAiu5iMUhpZQm2a4vCTmQiiuRpu7E3ZxJmNgxJIGTUffijU
	SBjcgR92M8lzLOacuj0ykDhyJak3Z8WZbalwjKAWRYRn/vv2VvL+tlbWjpwFLCGr1shwmkLGe6C
	YQNpWBlmCzJm7Tc3O7CnrgooB+C7UMXI=
X-Gm-Gg: ASbGncs8rA9NqzLn6YatEJIIpK2oPHCV2V76xFS7gpAHA+MlTIgxOjca5SoxHi+Bodx
	YOSEgmBG+Rx5eY91kIivVmzAJ8MKCnu4IASSBc5IfwWH8TkhIdtWqyHNOspgI26Z0iGXKyiDX8v
	4KBbNfTlA+z017wM202TXHFp5G2weX5SPFA9+D6BGUOQ5UxN2Lpf3cfTtv7zUyqExpMVTgxQGvt
	+HF9Q==
X-Google-Smtp-Source: AGHT+IH7QhWI6gOfbyXcf3ZZCr7nrziY0oIZtGgicWGxDtYCwM22ajgoM8BtGMHURfnpkGy6AXU9/3DOFYRQisWpnPM=
X-Received: by 2002:a05:6102:d93:b0:4e9:b612:9013 with SMTP id
 ada2fe7eead31-4ecc765d389mr4700749137.13.1750926480302; Thu, 26 Jun 2025
 01:28:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Jun 2025 08:27:59 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6ubu0ic.fsf@gitster.g>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com> <xmqqo6ubu0ic.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Jun 2025 08:27:59 +0000
X-Gm-Features: Ac12FXxCF5O0Sicj7MWQan4XNYV6OyvyeVYiBhhuFseDCbIWnvbfY0UPompTTBQ
Message-ID: <CAOLa=ZRu-fBsNpoSzb8z2xUfM7WUUcdR1XRd8zr1U+P61QRccA@mail.gmail.com>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120 characters
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000e30891063875567c"

--000000000000e30891063875567c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> As per 'Documentation/CodingGuidelines', we try to keep to at most 80
>> characters per line. However, there are often certain cases where we
>> extend this for the sake of readability.
>>
>> Add a maximum limit of 120 characters to the '.editorconfig'. This means
>> that if an individual line exceeds 120 characters, the editor will wrap
>> that line. This provides a lot wiggle room over the recommended 80
>> character limit.
>
> Ideally "when the line is overly long to be more than 120 columns,
> please wrap it to 80 columns or less" is what we want.
>

Yup, this would be nice, but neither '.editorconfig' or '.clang-format'
support a rule like this.

> If the
> result of formatting a single 125 column line leaves us with two
> lines, one with 100 columns and another with 25 columns, this would
> not be very useful.  As this is meant to give suggestions without
> enforcing hard rule, wouldn't it make more sense to set it to 80?
>
> I dunno.
>

So my intent was to instead was to allow the user to be in charge of
line-wrapping, but for no reason should that go beyond 120 columns.

I'm happy to change that to 80 columns, this does mean that supported
editors will start wrapping at 80 columns. Users will have to override
as necessary.

>> Contrary to settings within '.clang-format' which are used for
>> statically formatting source code, the '.editorconfig' rules are hints
>> to the editor. These are not enforced by CI and are guidelines for
>> editors to follow. As such, the 'max_line_length' used here is only
>> supported in a set of editors [1].
>>
>> [1]: https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties#max_line_length
>
> Thanks.
>
> The discussion around "rulers" https://github.com/editorconfig/editorconfig/issues/89
> was also interesting.
>

Indeed. That would be a really nice feature and in line with what we
would want.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  .editorconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.editorconfig b/.editorconfig
>> index 2d3929b591..d0f940fd23 100644
>> --- a/.editorconfig
>> +++ b/.editorconfig
>> @@ -7,6 +7,7 @@ insert_final_newline = true
>>  [{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
>>  indent_style = tab
>>  tab_width = 8
>> +max_line_length = 120
>>
>>  [*.py]
>>  indent_style = space

--000000000000e30891063875567c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e484f08fe5b183d4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oZEJJc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzNZQy85bXpqY29naE9KWFZtMDAzNytyQ3pyd294ZgpzRUJ4cDl4OUtP
dWxNaUU1ZHNIbmd5UlN2M3FmWU9Ra3JJQk8vRXQwNC9CWVh6RUhHY05CUEFjYlYrQnNwODlCCnlo
L1VhZTFMdUNPRFVac25vQUd4NVJNeW9aMFhIUWVoaFF0dVJSZ2VuOWtJeEN1WkJPYjBzb2cvdjFz
ME5sckIKZThneE01Vzl1V2g1aGdBcEVmOE4wbUl4VjFKdHc3ZjZWaENZeVBEbVNRNFcyZXV6dWhP
VTBweGpzeU1tNkdLSgo1UmZUR3p3NVNydXVvWHUvb3Jtb29OU0orMGp4aVVicU52elh2VGpaWXM3
ZXRHK3l4bTZNdGtsSHlNeHBYSmkxCkh3Z1VNYnBPT2ZlWk9ibVVmTk45ZlRsZzBwdmZRdHI5VEdK
aXZvOWxnQlZsUXZ4Rm9ycDM3TDlPMmlIemMxL1cKem5meFpsUDBpOVNJbHB5RTl4WWd2VStkS3BG
cUdrUklkS1hsNG8xVFNJT01sWEZZU1pPZjZ1YTVNcVFNQ2kvLwpIMWdvcWtPeW9rNGlkWm1ob3VM
Zk1QYVlXSWZPZjNrQlRaZG9KYTdYYksrYzRTRktKNGc1OCtObWJyNURQOGJZCjBBVFpjRHlWS00z
VWM3MGswOFpDYzRlRDgzWXRpdkxqR0FSc1Axbz0KPVhkTTUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e30891063875567c--
