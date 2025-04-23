Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FF27F4ED
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430048; cv=none; b=lrdt3l+vIjHGNxhelqF/kVKUJoF8FedS/pV8lnopNhI/AmK0ZZzCksvodJH7pvmtGKQhVJxj9yYCXjMEGm1s0lrNMKzGfHZARXjDcwVDB9TdqesMd6jS2+7/HoL4ZxkxklpvcNnNf/UCAkR6rqeiIzoreOvQwtr352sEE+6GZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430048; c=relaxed/simple;
	bh=EjHo74XlywsHUtUD87SGglhb9Sf+EtLXR59rrT8dQ3Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGBlaPUgaRk/Zf3Q6DE8XYUrN+4ckQWXsb7Gj9BeA1ISdfz4mwf+zXAIitdJWwic+lfQtqLrIxImpRDyzxdclTppaijip4amjSn879WRBbmz49V9U8RwmB+eDhnTHPShtXXa4TXNp+oXg4NvhqqF7ZzO/E34t6HW6iqrEkW0z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0s1xV04; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0s1xV04"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5259331b31eso59464e0c.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430045; x=1746034845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=96pmP8F70q8zlArE9+JW/LVt9WZWmgRD7kSSvH3f1/M=;
        b=O0s1xV04o9f/ptMZ4j5Z21WYJyNbmd0Vf4V9FtQlHZZp/8PCS4lfY5pJu1GyAAlLbe
         Thz101j+NgxF+dnBQpwgzmZKeJhADd6DmpD5r7xb1gaP35TqXIoHsoTTrPmOe/gbTS8T
         Dvwe1A6NhNYmJAOf3X7gWm8DO25JRTR+8tfudhoduOlA5bZTkqxTF7/BJj7DYPP27mEx
         BciRcegwOSr45zJ0Mhh3GEKPo5/9emMVUkoWFDHuh6McruesS+1BE6hLVyRRwMcC9aak
         AjwNQPGubFKweBt/sFE49CjMtl3aaTbCmhGerqNGszLm3ztrOTijMLx0cvPTklgyX9RM
         q2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430045; x=1746034845;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96pmP8F70q8zlArE9+JW/LVt9WZWmgRD7kSSvH3f1/M=;
        b=C7FMA/oRuLaa4fu2Eu064bOPpkSSa/IYbecVXqDN36bupqGHnn9yFez6lzPmpvaRG1
         ZJ9yb3F1ZHUzp40Y2PgRlCXiNJhGnc3p5XBwiWwSYsE6nbXDmGh1xA6QfbXoopI1rJVj
         V8p1RDk0jLRRrHJz5x7YqiOarlH7KsLrzC4fxv2I/3LJBy1nA1+UObL0hnNCcCUl0JeU
         EWVrOKcK2rriaC96LWf/A2wh2/FvcFYly+OA+M8uKFojhAhzE0LLUUs7UEgJG4AkXgQq
         gZNhgCsiNo50avqIp9YQY2JbF/yiXguhQh4MAxCNqagwNDk/AhPyUBp7pOiGgXWBfvop
         zLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQNL5W1Yr7+pDOwXP1N7vvfC7JpA+h4P84f8zkd2hq08Zo2azV7SjPYz1MI+fvilkSybU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFhvOoh4e9alMeVK3JvSa+DHVg0NLj/yG+H1Feq9v2Gch25il
	J8cxyGN2Rz+LaeiyGI7+3+x/LIC9afuPFHaXVwP2azzuV3gr8WHvQAINjZcD0BF1repKIOOj6Cv
	R6oh0JifuEzxG1ShJ/Zp/qdDaBKhPZoHJ
X-Gm-Gg: ASbGnctZmV/Ai0maWvp5OUMrDBB07JOV79cLu9zUTI5iaSKwa30BK0ND5h25rv1TEKw
	sJYnBKLLuRwNLoB7IlTgqcdG8f2KkWMvKH+nCZrTaWWHpMfMomWxmlTPz27qG0b2Nrjg/2ctxki
	vlxe1wcGxf+FfXfCT4E9Vs2w1SNo6+ilw7RhOKV1CEgOh4i6ClE7E/iz0R
X-Google-Smtp-Source: AGHT+IFAJWvcxbFLt/xZXI3P7pD0wM7cowHQl7xalAX6MTf+emIjB0eRgTSBcZ4q/Cv4rc897NcvgEXwSvjbmQtX1ZE=
X-Received: by 2002:a05:6122:1692:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-529254d5675mr17540303e0c.9.1745430045251; Wed, 23 Apr 2025
 10:40:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:40:44 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:40:44 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <2a25ca04-c824-4bec-a5e7-95ec32556cf9@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-5-d1e2be4b2078@gmail.com> <2a25ca04-c824-4bec-a5e7-95ec32556cf9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 10:40:44 -0700
X-Gm-Features: ATxdqUFPZqBtXnd_-Um56MMsYrXkDRUYzvmqtJzCNaoc35KsdYU9Hw6TJv4jsYY
Message-ID: <CAOLa=ZThKEHa-=Eb+Hef8Q2uoWs1xOZBuHL-KUt0Z5K-uLuJsw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] meson: add support for 'hdr-check'
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000d3faa70633759958"

--000000000000d3faa70633759958
Content-Type: text/plain; charset="UTF-8"

phillip.wood123@gmail.com writes:

> Hi Karthik
>
> On 23/04/2025 09:15, Karthik Nayak wrote:
>> The Makefile supports a target called 'hdr-check', which checks if
>> individual header files can be independently compiled. Let's port this
>> functionality to Meson, our new build system too. The implementation
>> resembles that of the Makefile and provides the same check.
>>
>> Since meson builds are out-of-tree, header dependencies are not
>> automatically met. So unlike the Makefile version, we also need to add
>> the required dependencies.
>>
>> Also add the 'xdiff/' dir to the list of 'third_party_sources' as those
>> headers must be skipped from the checks too. This also skips the folder
>> from the 'coccinelle' checks, this is okay, since this code is an
>> external dependency.
>
> The xdiff code is in a kind of limbo as the upstream project is dead and
> so people who want a standalone copy take the code from our repository.
> The Makefile does run coccinelle on it but not hdr-check as that fails.
> Looking at the filenames in contrib/coccinelle they are almost all quite
> git specific so it probably makes sense to skip the xdiff files.
>

That was my conclusion indeed. I thought of also removing it from the
Makefile, but I think that it would be better done outside of this
series.

> Best Wishes
>
> Phillip
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   meson.build | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 4618804c7a..22fc65ec80 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -645,6 +645,7 @@ third_party_excludes = [
>>     ':!sha1dc',
>>     ':!t/unit-tests/clar',
>>     ':!t/t[0-9][0-9][0-9][0-9]*',
>> +  ':!xdiff',
>>   ]
>>
>>   headers_to_check = []
>> @@ -1994,6 +1995,68 @@ endif
>>
>>   subdir('contrib')
>>
>> +exclude_from_check_headers = [
>> +  'compat/',
>> +  'unicode-width.h',
>> +]
>> +
>> +if sha1_backend != 'openssl'
>> +  exclude_from_check_headers += 'sha1/openssl.h'
>> +endif
>> +if sha256_backend != 'openssl'
>> +  exclude_from_check_headers += 'sha256/openssl.h'
>> +endif
>> +if sha256_backend != 'nettle'
>> +  exclude_from_check_headers += 'sha256/nettle.h'
>> +endif
>> +if sha256_backend != 'gcrypt'
>> +  exclude_from_check_headers += 'sha256/gcrypt.h'
>> +endif
>> +
>> +if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>> +  hco_targets = []
>> +  foreach h : headers_to_check
>> +    skip_header = false
>> +    foreach exclude : exclude_from_check_headers
>> +      if h.startswith(exclude)
>> +        skip_header = true
>> +        break
>> +      endif
>> +    endforeach
>> +
>> +    if skip_header
>> +      continue
>> +    endif
>> +
>> +    hcc = custom_target(
>> +      input: h,
>> +      output: h.underscorify() + 'cc',
>> +      command: [
>> +        shell,
>> +        '-c',
>> +        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo \'#include "' + h + '"\' >> @OUTPUT@'
>> +      ]
>> +    )
>> +
>> +    hco = custom_target(
>> +      input: hcc,
>> +      output: fs.replace_suffix(h.underscorify(), '.hco'),
>> +      command: [
>> +        compiler.cmd_array(),
>> +        libgit_c_args,
>> +        '-I', meson.project_source_root(),
>> +        '-I', meson.project_source_root() / 't/unit-tests',
>> +        '-o', '/dev/null',
>> +        '-c', '-xc',
>> +        '@INPUT@'
>> +      ]
>> +    )
>> +    hco_targets += hco
>> +  endforeach
>> +
>> +  alias_target('hdr-check', hco_targets)
>> +endif
>> +
>>   foreach key, value : {
>>     'DIFF': diff.full_path(),
>>     'GIT_SOURCE_DIR': meson.project_source_root(),
>>

--000000000000d3faa70633759958
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2bcdd0e1e8f43909_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSkpoc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUNlQy85YVEveTZmbzg3OS83Vy9Jcm1DQm5IVm51MwpZMUxjQXJLaytD
K09rOVVhV3I5K3Bma2h2VHBGR09hMGxtM25ibVBVWEtHQU13YVk1TzN6Zjd1RHZvelJ0V2l5ClJ6
bGpaeEh0WXZ3WitER1FQbDdrQVFBNWZGUXUyU2pNdjhCQTJyUDRYSXY2RFVSQllsejdHMEJTL3E5
eDFwcUEKQ1VuUGJEUUd0WHFRZ1U2Y3lYQ2MvTnRCbUJqbjJZRytxcmJWckk1b3FJMVBwcjIyVGla
UStiRzZNS3JnQ2pFWgpNai9lTzFiSHhQK2p2K3I2b3IzcjIySk1XQStpdW5RMXRzTU1EdWVlYzZR
TWVMKzdQaUhTKzQwZm5uZ09ieUZRCk1XZVc0bUJZRDdqMTN6UzZPcW9BMDRkRVQ3ZUNjMWhXNGhu
bU53eGMzY2lYalJQRDczeTRnTWNEcWprNmZGMDIKV3Q1Wkd2Yk56cTVYNWpBSHcvTUcrV1krdjJS
KytRcmFHSm9oNTBpcnBZVUZDZldMM1pkcVpvUzBzM3BQSytjLwplRDN2VWtjYjREd0w1a0ZwK3Zm
eTNBeFhXT0hrWjUwdVlZWElWdE1LdnRMTWxSRDlhNUZUNVpoa0xvNm5tNGNCCmNydkgyUTlmVi9K
TzBPRWtmRk4yQ1NpSmlPdzN0Z2lDV2tDdW9uYz0KPVdzTXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d3faa70633759958--
