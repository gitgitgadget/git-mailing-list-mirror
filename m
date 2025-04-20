Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638111BF37
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146666; cv=none; b=Chsgoec6X4MBIEQDZJHMDRnSChOyTXiXTwCs03vMkTJewpiFgA+hYaFUFSxDpEkUuGwia7uGuJZvVgWNWT5HChvqN/u9a1fdTS75brn+iGFHwj9S2BUq8dVzD7ErRNgSTgelleFTiw8al/9ZO+pW6vf4ggLMEIBRgWwsV4UPcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146666; c=relaxed/simple;
	bh=Nyo8Tv933Ug7AwOsxGotAeRb16Vb1BvRxG8NcEDgnLc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJC0pXKnrO8Ku4VeVZdGbhTk6w6qABnsWp7E9ekvrZwFzzdFh4qn/L6BYjnMDkQEXcd1LkS33DSq9i4sTPCiZCMiK0iJFJwYqH1YavnlGwq67dvUryDWIFdgyKSU7ohHwUOrAVnuWI18QWhzTduKWit5rShuZVW/FTh8+Wkm2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBkqQv0U; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBkqQv0U"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-873a2ba6f7cso1039098241.3
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745146664; x=1745751464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTbWGj7pl+IwGZNXk09qfptOhxRTsiUjLD61yLQAKb0=;
        b=iBkqQv0U8GMhElzVMiIwjoKascVHs5FDy2bOZczwd98VBsJiYQMPOYKuFNdDxfWScy
         SLXzWWIc2H9LgoSufyeYJvxWp60Th8QXIFaTOdIJ3dWLRT6nB+bWTQs++bKEu26meqxi
         4m8Qtebrcpc5hnwyWSpRstmUE1NgOFfAp+lHcoLKn7ISnpmVmWds6XnyBNWCBBVEjaxW
         lVza7UYZFQa909PUTfgMGDBV3u3Hybua2MxfYFEogSQ+gKNWgkJ64xuXkhIcg5iY7Ozl
         MBEu+/l1EC7BS+ABaQ9NMHpWMxeaG2nDZHH8fsinNHe10hqY5b7cyK2YBUIsEMrf+1Xr
         CT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146664; x=1745751464;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTbWGj7pl+IwGZNXk09qfptOhxRTsiUjLD61yLQAKb0=;
        b=lc1JNng+d86J2JKDLlXfajnIuZbMtSDuZpiUGojfysXJh0ZAhUSJ04K4p0BG6VbAKO
         u7njFg3PvS1kSbGUBcH6iUGRHEXVBfGxIS7+8YF9frtaxXgvyWv3CTj+PQxRLF4VTFFO
         Ya8KGtlGlwfmj9aDB8n2X6yaIndOz7Gwiwj9yIrK2OdICKAZf7lVKj8jo1b6d0c2GEVL
         UmPo8EIYsJNAvpUQDmCA4ziI6HMCWP8PyoxeiYjGF714+sysZzypRfjzZnyD7iiLh5Eu
         maUE8jPnohsrFlXYqnHUhIcWBfOJfST9RK86V4KNyBZqzG2Hb3rR/s9n4D4J7UBiWLph
         umyw==
X-Forwarded-Encrypted: i=1; AJvYcCVWq7aRcZ6Cl7LgzhSYk93dyJGz5gR/OuYfnisICb38piuYjbwzdBiMtS5FbK0XBeAD+s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZhdgP8WvQhxUaERQSUauE1fxILL3FJoLo9z/U2b6V2rN2i3+
	JSblgQPMWu0He3+IPkWUjCqIawRwl40VoKCce6i73EcXw4x4nfpx6/xrRafzu7poYVQgYpDoAKB
	HEzOoI/uB/K8DP4JdzM3Z1zAYaQI=
X-Gm-Gg: ASbGncvY5DLqPMXEv5o60TYgOcu0dJYZEA8+mj2S57skQxLBZnpINyDi/OZtNkC56lG
	mf3o8wo2hJGJMvN/IY2jZYtDyi1aj8++IOvmIDgXbZ8f2Te+lhfyX2H0/SzqpyCL4tbxJ1QyEUP
	f3IgCuT5oiMdvajDg2qndusWTFPtdALRXBviw08nL7ea8xBqP/iyNr49j0
X-Google-Smtp-Source: AGHT+IEirFRTybOI87teTM9lOJi5qbVn9JqTJAiERwN26X5dwEpJvUbehUEaxDk1OM/IA/ZagKZB4liE0g3dbFTj6a8=
X-Received: by 2002:a05:6102:27ca:b0:4c5:5aba:94bb with SMTP id
 ada2fe7eead31-4cb800d79ffmr5007259137.3.1745146664270; Sun, 20 Apr 2025
 03:57:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Apr 2025 06:57:43 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Apr 2025 06:57:43 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <958aee61-23eb-4562-af9d-48108e6fe581@gmail.com>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
 <20250414-505-wire-up-sparse-via-meson-v3-3-edc6e7f26745@gmail.com> <958aee61-23eb-4562-af9d-48108e6fe581@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Apr 2025 06:57:43 -0400
X-Gm-Features: ATxdqUGxWTGeazeSADb8R9-KYias1q8Xj_DHoQBKHemo0hrEp1M7m3YBPlzh-mI
Message-ID: <CAOLa=ZSYgdY0YnP1Uw83N7oT9R+AUt034ecgPt0ak+RCD3f_6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] meson: add support for 'hdr-check'
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000015a720633339fb9"

--000000000000015a720633339fb9
Content-Type: text/plain; charset="UTF-8"

phillip.wood123@gmail.com writes:

> Hi Karthik
>
> On 14/04/2025 22:16, Karthik Nayak wrote:
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
>> headers must be skipped from the checks too!
>
> Doesn't this mean we'll skip all the xdiff files when running coccinelle
> as well? If so the commit message should point that out and explain why
> that is an improvement.
>

Yes, let me add it to the commit message.

>> +exclude_from_check_headers = generated_headers
>
> I'm not sure this is necessary. The list of headers that we filter is
> generated with "git ls-files" and so wont contain generated headers in
> the first place.
>

Good point, since generated headers are part of the '.gitignore', we can
skip the 'generated_headers' variable entirely.

>> +exclude_from_check_headers += [
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
>> +if sha256_backend != 'gcrpyt'
>> +  exclude_from_check_headers += 'sha256/gcrypt.h'
>> +endif
>> +
>> +if git.found() and compiler.get_argument_syntax() == 'gcc'
>> +  hco_targets = []
>> +  foreach h : headers
>> +    skip_header = false
>> +    foreach exclude : exclude_from_check_headers
>> +      if h.startswith(exclude)
>> +        skip_header = true
>> +        break
>> +      endif
>> +    endforeach
>
> This part looks much more maintainable than than the previous version
>

Indeed. Thanks!

>
> Thanks
>
> Phillip
>
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

--000000000000015a720633339fb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ed73e03ef59856d5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nRTB5VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTBnQy85WElGRE1XWXBZOUFnR3VKUEVqQWtzWnY5MQpXRVFud203Tmxt
NTl5TFJ0QlVYaWRyOTB5YWpVc3ZadktyTXQ4RUxPOTByY0FjQ0M4SHVzQlhrc2xTZVNsRDZSClVr
Sk91a1BBa29ZZ3U3ZTVGckJ4dDJ4bTkwcEU3RVVVbG9oOXhDZnBaKzFUb1Z5RDlObURKWVV2dUxx
b1U2VDIKWTdaUXcrYnRuN00rTy9iaDZWRHFqZE5DekFhQXRDSHpLdTR1ZmZwN1JzcVBLMVVEWktM
bG9uRWRkblp0L0kzMwpiWUluaklCOXM2dHZlYnFEdFk1TkxTM3dTV2FsQUk4TGlhcHA5N0dzRFpB
bHBRRzZqZzRCTUxnUHNUYVIwY0FQCmlSdVRsVmJRd3JNZHA4V1haRE1nZ282QzBqTm1XRzJGY0NV
NTlIdFdQbTllc1lFWjEzYW9SdkpCSnZ3LzVzZnIKUWlaUkRVRUtzcjNQd0QzdmsyNzlGbzFrcnE3
UHpJQmZ3YkNLcWxMb2NHdElCU3dIQXZNRVBYdnlOUFJHU2FRaApGKzNJNFNzUGlKbnB3aHZsR2th
OUhnb0V5cURxMXVyL0hSVVF4VjkzdDh1L2I5RUJ6RW1uR3VYNDBHUlo5dUhlCmRkY2U0KzA4YURV
ZVFsR2ZjZFF4cWQrdnA1QUY0c1ZjZEhERnovST0KPXNPR2QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000015a720633339fb9--
