Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71F234994
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011937; cv=none; b=Y4dzGifDDpxAUI5hxuE0pf8FSNxdYPAQrc1Z1Z5SsscnK9VkfCtnmx1TDX0+BapukQeeMacne7kurQD2qxxDjnno6b3gFSprGMVW/RKI3XBA8oYalIOd+u/V59crrC+Wlt8/E/fyR7Xqr8UPj9Zkzx5AKJ/412NMVIQQVzbCnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011937; c=relaxed/simple;
	bh=+JIAMjvf0vvG7M83dHWn4jOuGyApKTHG4zWYNH2K5FY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tv6MnbjyRWTC1x8jObOPT4RpJij8uN5mb+inV4qF+ikLnvP/y3YcL+JwU+Gz92d+VvQIsjmv69zEeW/o23ApREDRxf3AUCvjkbcb7hPntCSziYB6YKQWeKHQD7bQjEi/20rtSUTMkySoAzifqilC3HR/y/mN6oKy/XyMysf6bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3IILrx+; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3IILrx+"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87ec9a4c86cso513160241.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751011934; x=1751616734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWkAvy012Na1/4V46/gjJd7RgCblyIFcEreeDLypmb4=;
        b=g3IILrx+38ER/fQ8xnN2ukwpF0WEbykQEAjHDU9YY6gdEmEamP26qgum3vDYjPNINR
         jZ+wLZfDWRqGzBY1pQrhZXQ6QKnsVNcQk8zBEmrzFh/zm6LXKW2Hi4gFz4jJr3C2LQqN
         jXafN2WBskbe2bAfmMm9G25dOJfYFjot0yKLANWInEoSOFXPHZRqPJrU5FC8qHgrVGA8
         D582X8/Q4Mr/I/nc6DaLGprl7UQ4j2EguFDQJClHKZIqS5L6DsdsFMGZYCTI8k+hlAa+
         lFJ3LbA/AgtOWpsB50C4smgFH6f0ZRjQ/ROH/BXxor7ns2OXbljpeOlMstvClJsu5xci
         liTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751011934; x=1751616734;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWkAvy012Na1/4V46/gjJd7RgCblyIFcEreeDLypmb4=;
        b=KmYeFHK/bqTegXCLF/bVdFHoJUXDtWDO6HWwUqYMAWZ1iMUxsmp46EyKtRlmzP7TfX
         zGTyLRK/myImurL1TvXgH278QtX/ZFV2+c3D33Vt9NELFp3KSYGt9DvP9BxihdTT6iGt
         ZX54YQj/YR6S9jcfTzeJ8rdfAM2SRCAKCA6cBuKAeO7+dpcSAsdX/AbRnCfu84oHPp+N
         +KI8cuH4HYMRNE6i32VQPe1RgD2eiNW7hA46Wadx3tfaOlsSvjxA3kUltSuT2B08eGJx
         xUKnjyZpqVVZW5NjdeCMNIPJtJS+/bFfyjuWSyLSlme00RVDg/Fy4bCPCtqz9XYzOxF0
         Regw==
X-Gm-Message-State: AOJu0YxuMhDC0p/WKNLpA9PKtTxm3U7QjIJxFjGKFs3bXrWUsUJPTPcZ
	4yOKT49X0AmkqCZRiMEEeGrqtSHHxKJg6rpIxz9LwiGHAolE9Fp/mu+FDpuHTbymAuofB2R1r3W
	N/k6JvxULtUrFprMCOkXcqwP81BPBo1U=
X-Gm-Gg: ASbGncvYisfGfPybyVDFqUDMatcqMmDACl70c00Kou8A1mXUmNNnUS2lc2W5j/kGEfe
	qATtzEclzeIJPYCu7CuiOgLW41n9qKzh0jhTdWvexxzRqvvRpxhBnPeYZMLjuJ+zxjmFfTmpd1j
	DZo2xzFslIF/FKIa8T4BQLnzmzh+UmxrvoSnynAPxj/khQ
X-Google-Smtp-Source: AGHT+IGjmlDL8EZ75LSnQ9cpoU6oH7mztmt80BW22L0FUr1oaREULbWoTcD0h4MJF4VLoAyn87lyKozIBn6Qlsmqx+0=
X-Received: by 2002:a05:6102:2b8b:b0:4df:8259:eab with SMTP id
 ada2fe7eead31-4ee4f873f4cmr2013295137.19.1751011934427; Fri, 27 Jun 2025
 01:12:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Jun 2025 01:12:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <iutm4xxkhchcpfygtqo2s4nit42sclzen63465ljtovzgdsebr@okpj5jtw62r6>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-4-67a49ecc2fd5@gmail.com> <iutm4xxkhchcpfygtqo2s4nit42sclzen63465ljtovzgdsebr@okpj5jtw62r6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Jun 2025 01:12:11 -0700
X-Gm-Features: Ac12FXxvpG55Dwg65zXJNyFmBtFrs-4hL4uRM-c0Rd72O6MBIbogD3iaS0QPkB8
Message-ID: <CAOLa=ZSJH-Wji+-oU+ku5aojYzEuC96tUu+24UTuTxCxt9LYNQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] meson: add rule to run 'git clang-format'
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000597bd10638893c70"

--000000000000597bd10638893c70
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/06/25 06:43PM, Karthik Nayak wrote:
>> The Makefile has a 'style' rule to run 'git clang-format'. While Meson
>> intrinsically supports a 'clang-format' target, which can be run when
>> using the ninja backend by running 'ninja clang-format', this runs the
>> formatting on all existing files.
>>
>> Our Meson build doesn't yet support a way to run 'git clang-format',
>> which runs the formatter between the working directory and commit
>> provided. Add a new 'style' target to Meson to mimic the target in the
>> Makefile.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  meson.build | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 7fea4a34d6..578db26df2 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>>    alias_target('check-headers', hdr_check)
>>  endif
>>
>> +clang_format = find_program('clang-format', required: false)
>
> Should we be checking for `git-clang-format` instead?
>

Yeah. While `git-clang-format` is packaged with `clang-format`, it does
make more sense to check for the former.

Thanks

--000000000000597bd10638893c70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 54208f385ece11d0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oZVVsb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0lCQy80L3ZIZnZKTE1zMTRyZ1AxZ0FCK2xrL2JCYgpuL3NLZXNpZC9N
RGMxYyszdkhSeVVlVGwvUXRDdnpkUDJCWlhQaHdQMFN2VGZMNGhoc0pSR0Ira0RMUmphVWlCCjlF
eko0SldlRjNHNTY0MHRSc3RSWkk0Q2FtV214YmY0L1I4VnYwTTJ1a2xETjRMdVAvRSs5MnFwNnVy
RzlZSCsKVFE1OGlvVUVERkhkT3JQdFUvUVZremJIUGk4UGpMQm50eEZnZUJBb2ZucjRhRlZvWEg2
Mk5yN3M1bk43dGpTaQpBOWVoM3B1bmtFanpCekhreWFtU3p2elNWczJRZ1REeE01eGlxZEFKV1pp
OTNCeEpQL1NZYVV3dGk3cjJ1NWNOCnBLd1luMGxRQVlIUXFWS1BrVTRTNHZqR2x1bjFFdGlvN2hu
dWNqQjY1alV4aVRIbytWWCtBSHFrN0huam4rL1UKaVNucUFtMHNSREh4WHRMamNTU2p0MHorTFJt
L2lzS0sycndYWEcxNGVVMEdpa3dXdGZOeDA1WmtDOXpqSmlybgpzS1RSVFVhWDY3VUZIUWlqTWgy
V0MzRVloZHlSc3gvNUIrMEFIRWtZWXRKNWRuQk0xV1BwUk0wV240NzVBYjdyCnpjS24yTTRES2hB
NEJKQ2RhTHJCdmZtRVFJT0FHV3NTREpUaGxqST0KPUJhY04KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000597bd10638893c70--
