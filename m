Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39147278170
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382740; cv=none; b=nQvKB13SdsfHqcTo17SOGNITlM7M7VZno9nSmpDouGylqZ9u/330qZriV/1eUDyy4gFbiWz4BaMSXpOq4KAYEKNOBebOhwji9BWGLsOIrQqe2nJ69NNaOFMFUIbY68z1DXoum0/mVhRN8wgIPCNS1jg32rXypSoLqKMTt/ieve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382740; c=relaxed/simple;
	bh=bXFkftFSmNyKRQ9DY5RjBIM/cT/Tam9fUJ6vG0MdU5A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqBOu0s/RnLs8Pf7UmXzkLsQOaWojQov/k0qq+pTBjX+j0rJD+wqkAAG/5RvGB0Vvbf3jKPYWYNI1iL9jIvFma+8qHw4YNyHF29UppVe2XIwrE55BqQfF3tWxUABTdx4q9zWIWMh+01BpudIkUidKTBagOpgnBJgZVIIVPVQElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnhwEE7E; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnhwEE7E"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d41cd4114aso1002461685a.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382738; x=1751987538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tefGmf+KIn+Zd507nyQH80efOVU4cuJB7zayt7I1wPA=;
        b=WnhwEE7E66kXXRls18syjtzCdVT0k7W1OU1GcZo55Oz9fbWZjpz08tEjt4MLroFM/M
         Fh+6xJoWkfKzPKzBfByLVx7nEXe1vTv8AuAZ6xjqoG7dYLmgWOdQ8KaRWF56uQgqGJ6w
         H9uBLRtcCTz2Ezbi//0zizulJgDwqLFTJEqxeU9PdJY3AFQ5jiYZ1ajEBIYBSdarQBwc
         FVKmtGhSVG4Z413c5Z5xVv5gdHCfR6+nlz8K6JITij/OLGDP6erDi2NYGK/PwltfyAxw
         Nx/+Fj883A0PwNvtcx4DUeD2c5r0Wokl+H3q0NAGHM3ckRFz+UdwQHQsRHXSYTR7zxzK
         tdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382738; x=1751987538;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tefGmf+KIn+Zd507nyQH80efOVU4cuJB7zayt7I1wPA=;
        b=QU2T8eiSeTLs1l2Yh0H2LKH3vwZSzWabHKHUzQBfeI6zSgHvPWaxkVImjArDDskZmw
         H+JQxDMugf5JQmYRvGM35GbGZuylkABZAQWcdSvBULxH6We/YX3gNMZo/b5hc9grIt8T
         Oa+dR0N3WnST3ukICfkI5izwfoL0UmujBFeN4zQS9eT1G3OhkUSVFyDvOAoE3RxZhE7q
         JbEth7kmXxB4YSVh9bwSYXPu7P1ZWJnrSxdqdbyxPziQg9/hmrUxFZSnSTlhxxbsfBPr
         VOffduqOhHXGUUjRmWfHfH9ha2L7poStRZB/dUWkf8zNGp5opTwzY7D6t7oMu7ouFS77
         TGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1qTpBhgk8HS6K3X6AwyAKOsa6rBmljMdllaCcuFiFJHp2bm6NsuHww1fLXdGad4Wn844=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLuoB3qu8s7pwOIX/gfkrG7YAK5ZY2DIqTQy/6XQNUxuP2apZ
	H58BS1Cf96r3lXgDsPA5eclraIod9Ju/TgcoQk+C1XOpKiqN2CBo0bX9GeANYgn2n3dS1B1KEnX
	nd4KGytnVrc3jdWNS4KuCpyOrMiUcOMg=
X-Gm-Gg: ASbGncuwzxI2JFw3MOsdzXlHxEryheLQcbSf3H07WM4pwaiTkHaZHnnKvVIqKxzg6Uq
	nL5ZxqzbCZdnedt57m8y//onDU22p6onWTLxMBtboyuWJanQT6ktUo2HdXb5X+ZBnQTthDa43ig
	W8GLZoBuBYDod3XnY+rigiWoRrpobfl3P/7MiE32uc2hW3GWllLFmRMe3bKAKYT6f8N/jaIiajz
	Rxkyw==
X-Google-Smtp-Source: AGHT+IG6tNGrfZSBuoGMV2/lS7aM5NpxifOkiuLOjd2vO+Pl86vcGJmVGE/d0Ln5jaF+JXO9YfurjiJfeCQSpi7Lneo=
X-Received: by 2002:a05:620a:4006:b0:7c5:5e05:df33 with SMTP id
 af79cd13be357-7d4439b8a60mr2555500585a.51.1751382737884; Tue, 01 Jul 2025
 08:12:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Jul 2025 11:12:16 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87bjq4qbxi.fsf@iotcl.com>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
 <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com> <87bjq4qbxi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Jul 2025 11:12:16 -0400
X-Gm-Features: Ac12FXw_boFVro9T0PLCUdvOoZSF34PMR-VBB-RE9JrwVso9Om-EN38kvFqZRqI
Message-ID: <CAOLa=ZT6-Ea9iaNgYymmT6s5mjWk4i4RxZjcr+7G6HUbg4GdHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] meson: add rule to run 'git clang-format'
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000f5b4140638df9106"

--000000000000f5b4140638df9106
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
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
>> index 7fea4a34d6..20ce0525a1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>>    alias_target('check-headers', hdr_check)
>>  endif
>>
>> +git_clang_format = find_program('git-clang-format', required: false)
>
> I think we should include `native: true` as well.
>

Does it really matter here? I must admit I don't understand the
repercussions here.

>> +if git_clang_format.found()
>> +  run_target('style',
>> +    command: [
>> +      'git', 'clang-format',
>
> We should be using the `git_clang_format` variable here to ensure we
> call the tool we've found.
>

Good point, let me add that.

>> +      '--style', 'file',
>> +      '--diff',
>> +      '--extensions', 'c,h'
>> +    ]
>> +  )
>> +endif
>> +
>>  foreach key, value : {
>>    'DIFF': diff.full_path(),
>>    'GIT_SOURCE_DIR': meson.project_source_root(),
>>
>> --
>> 2.49.0
>>
>>
>
> --
> Cheers,
> Toon

--000000000000f5b4140638df9106
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 986b88583c9f00de_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oaitzNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXBzQy85eHFneDFWRGdxNGg1RXJTcW8zbmJyRmEwTApvV0tRTEZmTFdo
NmJnanJ5RE50SjhFNTY5RmNQZ1pHY0NKTGt4Q3Flc1UwSVF3ekVrYTQweXBJZFNsenRxUWh2CmN5
a256OGxBYzhhbmJacjYvdFppWk1TMDJ5SllPcnMzT0g5a09jbk5EUWdBZitPMEpVVmQ5cDJ4TVZN
UTNCKy8KUjc5ZUkyOTNBN1BPcHdyZG5pOEZuRVZTL1RoRmR3Q2IxZW9Ndnh0cEJNdFd6Nnhabnpo
MVdJa0VyOG1JRE53bApkOXZlbHpXSkZZSVhNVHJnMmhBNHZGYVU2UnloWFFINjY2RmxVeTZYT3gr
bUZ3OHBJdkNsTmRQWUp5RG5ObDdlCnptTEtXeC95UjEyS1VoS0o4TTFoS29iekNqZVg3Z09BL2hs
dWE0U1FNbi9CVkpuQ2R6U2ZxN2EvY1dXOEhYRWoKUVhZd2FKbWlhM0lsL0pkZGZ1ZXEycUhqa2Nt
ZUV5ODc4YjVOWC8yL0ZnQlV4TGFrQTBaaE5wNEdBa1RhRnlNWgpLaW45R2JnVUFFOWtrSWdEUmJB
cU90dS9USU16Q1VRODIzSkY2THZRUXZBM2JDYVpwUzVGQmNEOG50blFMMUszCjBhbmNRR0hva2tW
QW9tazNYaGF1OGRsNnJzR0lvK2MrVGk3S2Z1UT0KPTRJcysKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f5b4140638df9106--
