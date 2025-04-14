Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2927F730
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640750; cv=none; b=E8D8OIjFRXfyTf2MSiDMKEz+dC2s3RNWOtGHWz3iGKBuRSz8ZPSvWsvIOrutQv07V5GIyrR9c8f3/x8rj+Qbr7oFFzZINeiivDfabk4virDnqGNXk8/4OD4qB41AVuXenAfi4ujuYIsBwEwDoE9UPfHoQVeqYyMSm7xN1vuV+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640750; c=relaxed/simple;
	bh=JhzVl2uRbg8y3/EtQ8S2tDEtgFqzuQxDpVGZqdjgux0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhndzPDzcvic9qyibeNJF4vqAiPOEhjJOkbzvnFCucDtncSdFHTeWKtZU7qQcV5J+TPwtCtfLdJZjSylhQdps37/0/AKfMIOz6gpubwOfOv9/CiRdRhyU1GK7HcAJlk60Ky168ujVCcf93NONGfDdLy7w4vQr908Dh6IokEbtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/sqFM2l; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/sqFM2l"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c560c55bc1so447921985a.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640747; x=1745245547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JM17u3kPjnvpJyGDdjurt8P2R1vN+zozpYV4trNQjrs=;
        b=J/sqFM2l6jrmK1axGkOjDW6RvqdBaXpxRGrCrjBPD1sbA9NrIrRLWOEpYmRrzDZvwY
         Bt/zjY4h6xRRJ9O+69KietNtfEjODXCjzs2hod7aNLn2Ep1RuuK3nZGlaSyYJSuXCXf9
         Hv8owKFKN0NnIJFuB1+bmfLCesplwJN/d5LfSamulzogy2rHy5JuItHMdRSI6INk2pTH
         ymvtierWvdhkY8CxeFkifLglASzYakT2xOo54IGu2cIUT3S3XI2TkEo//re1Hr2gMhGk
         sUxtlTd9LL1ZrvwASqIIBCEuqyctDz4o/b8GnH+gNoSFjpr3C8B/OmLgyTQe920lSnr3
         1xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640747; x=1745245547;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JM17u3kPjnvpJyGDdjurt8P2R1vN+zozpYV4trNQjrs=;
        b=FVcSsuqgpt0Ef4zEllB4Ycjmwek45F5neaq0JPZaVZhJnIH3WfJHmuTDvQkuUKXlrk
         bzrJnOVUhqG2go/3Ho6KvIkABImqegfDGwe0EY983NLj+npkjnv9ZiklOthmibis7SOm
         X68zs/SyXxIwqJGKB6HZtqy/TG+XqrwplVKNp/Tv3lYajotNTDeDpNmBHOaUvdg7fKV+
         LYQz7k1GwujT4iGFihQvwo4UDHuHD3A8rNnVipx40GgQE9+25MDvnnaXy99MnhzAOodV
         tcum02fic27uytDZTOxqlpJd45mpa5H4Mk+dJpboC6OfeSTPa+wBNYpihuugvTFgHT4n
         i8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXGuK1akiMbyEi4EqQgEIJZlNsEUn34iaA4TnwLncjTMT7uycSkSHiB559D65ndsgzLiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfofalZpqZerEccX+BBey5TAorMpsMmGEUPq/vy2PCyYRXIGcS
	5DiuzuX7p6MOLAdWWk6MsxnwmaqGC9Ezm74q+PTlN5jZ2A2rGYBG8DnuAyWfFRiaX5SUOOpBXLn
	c+O8IgN3Ty/SnBAva8uMwCy+6AfU=
X-Gm-Gg: ASbGncuZph5edeFU3iFu0e0vDReSb2bkhR3rmQSVZpj9HO8RvytHMLuX60njWSacdD7
	aReQGFAZMURqcZvHcQvMM8zGV4x4ML6jCEvkmB6g4j3lNXS9f4fyXfbq8dcxVUehoEYf1Gj2lJF
	sXsd8T71eG1YUAOECx/fCODpSGFoFlPX8LJJKz8YtpYaVoQ0C1UXQT6MQ=
X-Google-Smtp-Source: AGHT+IEdUui8oy/GnvA+N+6o/Jq2S48pnI2+AE1IhGNoqMx9aKWW4YXeECehzP8QhgHU1zd32sz+ehWRdImMURUiWrs=
X-Received: by 2002:a05:620a:472c:b0:7c5:3d60:7f8d with SMTP id
 af79cd13be357-7c7af0d40f4mr1525991785a.19.1744640747022; Mon, 14 Apr 2025
 07:25:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 07:25:45 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 07:25:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87mscj5dxe.fsf@iotcl.com>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com> <87mscj5dxe.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 07:25:45 -0700
X-Gm-Features: ATxdqUFj7ETGFJSVBlj_WFIL2Qc8gPWa4vcdviGHiIfNvJjWcFlzpAmytMcD9XQ
Message-ID: <CAOLa=ZQTwqyAU2cSFCQL4Ofc+dVyT5h6x5Ojyi=Bo6uYqze3Vg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] meson: add support for 'hdr-check'
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000fcf9340632bdd36f"

--000000000000fcf9340632bdd36f
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The Makefile supports a target called 'hdr-check', which checks if
>> individual header files can be independently compiled. Let's port this
>> functionality to meson, our new build system too. The implementation
>> resembles that of the Makefile and provides the same check.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 790d178007..6fce1aa618 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -655,6 +655,12 @@ if git.found()
>>    endforeach
>>  endif
>>
>> +headers_generated = [
>> +  'command-list.h',
>> +  'config-list.h',
>> +  'hook-list.h'
>> +]
>
> Can we maybe compose this list by instead doing:
>
>     generated_headers = []
>     foreach f : builtin_sources + libgit_sources + third_party_sources
>       if f.endswith(".h")
>         generated_headers += f
>       endif
>     endforeach
>
> (This would take `third_party_sources` into account as suggested by
> Patrick[1]).
>

This does make sense, but this also feels like an overkill to only get
three headers.

> If we consider that too much magic, I would suggest:
>
>     generated_headers = []
>     builtin_sources += custom_target(
>       output: 'config-list.h',
>       command: [
>         shell,
>         meson.current_source_dir() + '/generate-configlist.sh',
>         meson.current_source_dir(),
>         '@OUTPUT@',
>       ],
>       env: script_environment,
>     )
>     generated_headers += 'config-list.h'
>
> I hope this would reduce the chance to forget to add more headers to
> this list (assuming people copy the code blurb from another location).
>

This looks nice, Let me modify accordingly!

> --
> Toon

--000000000000fcf9340632bdd36f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5ba867df7d898a32_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mOUd1Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memVNQy85N05CbDVySVR5MmEwMjhFSTdOZVVIZGtFdQo1U1RWZThoMGhS
bkcxVEJBTTJKOG43NTdCZTgyV01CY0lobnBNOGlFRW5GallvY0VUNkMzdEc5OWhHS1RtSGJxCjgv
TXVZa0IwYXdKaDZSN2tBbWVSZWp3M2l5c3A5YW5ZazNLOHQ5Z09KTWdjNzE1bGVaby9jbGUzb2ZD
VGZXbGUKb2lDQWxTMnNReEY0ZTVaTEV5MHVIbGNKQnRJWmQ3M2FMZzIyOExza0Nvcnh6VlNIdmwy
RkZnV3FCcHdoWkltdAo3ellOc3ZvVVpsY3lvV04xQXR4Q0FYNGZXQWlTSENjalFFWjJEaWhLcWlM
Z2lIeXh1SGpxeGJFNHBRc3I0VCtNCndTQXBBZkFCTE1XalJNbVcvbjFKYlgyV2FmVUNUR2tDTTdR
aVNFQjNmK3BtVWVjRUEwbEFWRGROWEJFQXE2WXUKYlZ5dkJrSzkrdFdGV1NXSXVBdmNOK3hZa3JI
Y0NOcGppL3g0SGVNTlFNL0tzd2JhQWpDUjN6SFQ2Mk0wN1pPVwo1M2lGQ3RlbUZSbnY5c1BDSGYx
M1hXRTk1RTVJWDRkTHN6azZVUnVTeFpDUEdPRGZtai93OVBVTm84NjRvMW8wCk5pZVY1UlZYSHo4
TTIyUUt2WmNpL0E2Y0dncVZoM0dTdnZxMTUzaz0KPVdKWG4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fcf9340632bdd36f--
