Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE2140E34
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382494; cv=none; b=I74s/qnsbhtTcO/in/TnXEnIFLKjZ70eYz+1CZdGXvAFYqxqPzWaEzzpvWuqRM/eM6mqlIO3+N1tB2kgHN2Dvl7T6uX8gxuiozcc3SKb9Usb/fFI1DSgCYqZ8SJeFPAoHFLF5b0J4cI+50+ZR9pfQgJx77N8Uv1pw29bvJhsqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382494; c=relaxed/simple;
	bh=LhlWVgwgAaq6YEdHaG2Ws/ejkzHz7aUtsh54nWwyfTU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Flk1OUu4H7024pCH49jCrGwYgqM0cT9c64yh9MUm78lUinqd5kybPayodDzloKgiIG1GMdo3jbrMKW57iUiX/uEjNL34e/EzpN1GzdRsfzz49wd/Ey/rg9DiRSwIoX/SXS5WmknkobZnB0YS0ye2aYW8UE9wfqZ/iScnI6KXbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV1kc6oF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV1kc6oF"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d2107eb668so952385885a.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382492; x=1751987292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnhzjRzsZZMZMiFGIgYbXhbyBCO26N8QSiXGjyo9syY=;
        b=mV1kc6oFIC8ILZbai9IxP9O7NHpuVg3Oq3YyErtwJDtONjP8fiw/CkSqNh8ay4RwgV
         2s5YcrEMuCGi2KF6OZ7HT+JzbfrtJIVORvc7Y8KIxOunbemPhf8xkimZsqXiCG97a59/
         UV5JZXs2/HCNO+4CUX/3qfXzDTqcICJM7ekWD2QyeGpaj3WytmAnW4TX+xMDpBcoHNob
         0t6P1PrYmqp9yFhUDCsDZKGjDyp9PDLx1BfkR6SFqkoAR3vWLT4PZgxv00wTyse/6XF7
         0K5pHUZ3A+rNxfFtehb4xHw1tgLN1M8HC0N8JaflDqQjZKN1NycB4hpriviCYBFLI5uK
         Fn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382492; x=1751987292;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnhzjRzsZZMZMiFGIgYbXhbyBCO26N8QSiXGjyo9syY=;
        b=ajHtgx6p8ieIF2P9VtC3Nms16Zuf91oPUiWv4l5tsZfGN9o9/Oi/DDVVqaxWFNhbtd
         0PcLrSBMWq9fKDH+w1R/yvTFLpfYH76rWEBXmyLolLaYTo7zh89jPEm1DnRhBR2PsdEr
         IviCrr0jHEKYIdTGaupFbrfB684zzBTywLQJYANa+GuziUeCMhWe6mLqsrebHOjqzoeT
         fPO26yI9I+yUlCWpnUqd4DW4Lz807N4olpMmYBviMtyPP9PN2TZN1+Y0FFigYnf71iOW
         Be3MEXCdq/mVMuhgL12rZ+sl4+48pwJQBIh801HfimqHW6ni5WWw7BWSv7jiY0lmqYGv
         Hp3g==
X-Gm-Message-State: AOJu0YyHNmVU6zDedGjARs7ufHitCMUf7p07kMB8l8XSAt0mi8jfhFPk
	3M2r/Un+mCFIi6ShnVnOzkXSnjEfHLMMfy+Qk5BrJZ3MIL4eFBi9aweLTmA3Vc4m8agiPw1JECg
	riUTjVqWGfjTRn2o9PO8dgfd0vqqPOmg=
X-Gm-Gg: ASbGncvHYW92XCxL8YT4NeDykd2oZ/dcQjWayGXPZW67163rwE1zKKhnDfzC10/F+DR
	rvm+BDgKcOnEQbWSBKGq52uI+mBoAsxhWIFhE70ilLrVnFl6BTNhmOriEqf7wKEJGf6rn+QjVTO
	ApDwwX7vS7TBjIfIxCgu88PWjQf987agWUcLltb9a4DcFrPBO/s+76Y30e+HAvKkANETYDvZWcf
	mhMJw==
X-Google-Smtp-Source: AGHT+IHrT0UfCbcjyOzIcsCtSI8VZblUDQPrMJZ1/p8aUhnLGc7yS67OylZtCphFI3e8JpW2S5Q5o5+z25omRSLgt3A=
X-Received: by 2002:a05:620a:4486:b0:7d3:f68c:5778 with SMTP id
 af79cd13be357-7d4439b80a9mr3275429885a.54.1751382492203; Tue, 01 Jul 2025
 08:08:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Jul 2025 11:08:10 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aGO00T4c2Q-EYXZx@pks.im>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
 <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com> <aGO00T4c2Q-EYXZx@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Jul 2025 11:08:10 -0400
X-Gm-Features: Ac12FXy8V4mZLBZtYQZnmEa3ssptTweo2lq6n6bktAiz1oh-zBiNbAstJuA2iAc
Message-ID: <CAOLa=ZSaAVY2ChSWyU20fMniFHAz-aVtCDR_EizxJfErdy-u+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] meson: add rule to run 'git clang-format'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jltobler@gmail.com, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000005091b50638df8315"

--0000000000005091b50638df8315
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 30, 2025 at 10:38:22AM +0200, Karthik Nayak wrote:
>> The Makefile has a 'style' rule to run 'git clang-format'. While Meson
>> intrinsically supports a 'clang-format' target, which can be run when
>> using the ninja backend by running 'ninja clang-format', this runs the
>> formatting on all existing files.
>>
>> Our Meson build doesn't yet support a way to run 'git clang-format',
>> which runs the formatter between the working directory and commit
>> provided. Add a new 'style' target to Meson to mimic the target in the
>> Makefile.
>
> Hm. Meson already knows to wire up clang-format automaically if it's
> available. But it indeed doesn't know to only format files that have
> been changed, so I guess this style makes sense regardless of that.
>

Exactly!

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  meson.build | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 7fea4a34d6..20ce0525a1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>>    alias_target('check-headers', hdr_check)
>>  endif
>>
>> +git_clang_format = find_program('git-clang-format', required: false)
>> +if git_clang_format.found()
>> +  run_target('style',
>> +    command: [
>> +      'git', 'clang-format',
>> +      '--style', 'file',
>> +      '--diff',
>> +      '--extensions', 'c,h'
>> +    ]
>> +  )
>> +endif
>
> Do we want to call this target `clang-format-changed` though, so that it
> is consistent with the implicit `clang-format` target?
>

I was aiming for consistency with the Makefile, I don't think anyone
uses `meson compile clang-format` anyways. I do like the short form, but
open to adding an alias and setting `make style` for deprecation in the
following releases.

> Patrick

--0000000000005091b50638df8315
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9bf0c012fa331b56_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oaitka1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2daQy85bGRPenhnYVpxMG9ybEEzSGxTM250S1B1UgpLakZ0Y0IyMVVK
K1BWZEpiT2ZQWDhQNHhSVXhMd3BCdGRadThlTDhYSERudW5HajZ3QkI1QVVuNk9GM2kwS1pFClpw
WGp3TGo1UG5LVlZiTG9vbVZxU2YyaTQ2Z29JS1ozbHJManhmbWlpNmxobDFWQkN4b0FiUmk5TzlV
TmxxOWIKTW1XL015UXpNeXd0b3lVekdRek5DZW8yY2tEcWE1WW93Q29MdFRjMmtRVkRCdktyUVF5
aVpiVmYwaWNJMGcvSQpWSkhhTlpldnFoQnVJMlpsOGdkUUg2a2l1MjR5OEtYRk80bmF5UGFoaGQ0
VHl5cnlxcE82Y1JzWi9ndVN5Q2lOCmZhWks5TDhsU3VkK04raWg0QUFEclJPNnIrWTd5Y3BrVis0
UGFteG9DYUZQUFpZelJFOGFqNyt2aXVpWVZnUXIKejlGa21FeEpHTGZNaXk1QWt0QitPZTQ5K1BU
M1VYenUzVzdkeGI0eU5tSmNnVnNMc1dQNkJXUE94ME10Q21HcgphczNQbTFVcWx2NkdJNnl6MCtF
MVp2VzdmWmJhcGg0cjd0WGJJb2ZWZnF2SkhqLzZMb2JoTVB1WFJESVJudUZECkVPQkJLaWJPUW44
SDI5cjRxdnQzMWtUQmtSTER6bWhUSVBwQ0h4MD0KPVpTbWQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005091b50638df8315--
