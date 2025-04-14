Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF228E5F1
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638576; cv=none; b=kjmw1dg6BZN91ry6miFN6PowCHDm8lwLFeBSA2VCqtsWMANIADbyh3FRXwdsIftjPtLvUsL3DrWF1KEN6nKuCafn9LPSmoSDZuj2cHIx4zq+/8RByOMdtqM9tk5pRv8T2DPwnEMmYnsZS6v+YOi2EGdhnaJX5mQdNikXy1JXP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638576; c=relaxed/simple;
	bh=hQIeKqD3npX38/MEJxqsv9SCBZmvy25yxOG0HDWY8gs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmZRcYnpB4UMnQsCjbiYdETQGMlqAw21om0Vm59b5UC3HBOsiXWggHN9KOVvTedpkIKzLiX1Ufsql5baWE/qAooZlIqu16CrCi9tG/ImrjXWer+E/gyaysLNxmAFc3WwGxJd+kdLGc4HGrBD8YOQlPVo0Mm0UJ1amoIuPfb/25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMHf9tGV; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMHf9tGV"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523de5611a3so1705336e0c.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744638573; x=1745243373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+1Dey+VH7kZsn4t1tBI3tAO3yvGCCzexdenXnZ9CkY=;
        b=mMHf9tGVxFjwfWBGwXjDIf0FDthwGIE+YvFuM+zYG0M/irIDEEdsg4o48Z8XnG/e+d
         1EZB/1HWgT96xpHNFjw2X+szJRtG0oS0yWYVZF/d+9X9QoMOdK9zmR/Au1QgYW1wj2QZ
         6ki70gMCZQaK6QiPlVLWCfKUjphs+iaYTUnbHv+aNGpYP1HAeibI8JJ4Oy0SnZujeg6S
         PGprGCgon3vkO9D/LbMtNT6GOxD8OVd+ekharF3JAwis4GA+bCRMP6KmErKUD1Q3ohcJ
         BcZ7LLhKX3mF24APPoq4/9eSTwqAAIK4tyGa3aAMkhV0Ct5BfZeA4ASr/rfamxysd++E
         T8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638573; x=1745243373;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+1Dey+VH7kZsn4t1tBI3tAO3yvGCCzexdenXnZ9CkY=;
        b=YD3cLX7yWZHJ4eQhTJpLjTfobE2guCkzl8aez0QXbRRfADOctYpUDF7zT4PiiP5yhS
         qEJ27+YMZ3dTLAjzvYk/q1VTE5VQCh9FfopNm0yJW143EoZ0x2WD8GxxMRPvEXe+Zabw
         g4yw4N0ghGEaR8PYZPGPWlkfzisOQVmclaPfU2F+AmjsI22tM+iPIGg5JRW/fkRn4B19
         oQRvqs4S6JH4lsDEsKx2sXlrtGI57J1qjtUvqVkWk/BGqcTW2q1F3lyjRC6WpcruHPEy
         JYOVbApaSl/t2VBNUrx1z9owtoTNxQxnDCuPk7OcVghHZhXo6oZM8rzmBL0BXROR/fXQ
         Whvw==
X-Forwarded-Encrypted: i=1; AJvYcCWBSv9Ery5qrhU1r3xB+YX2+I/D0ibtNnN1qWk9BcUMMMsl1P3SkgS5NVTCF8G4fE/HlIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOQ9q9YAqmJxWvo5PPGNEXiDKqkucSN/ryqttVdcRZPHXTkBy
	Xh0KOzLH9y7FHfuKyu10NZllYd2NpPbZtCIB5Gsuhdq3DI1bkfvrCCLLzEa3xJXNW9jBSYiWbKr
	jJ2QY0OVbmR50mtmQAj27YJj0HA0=
X-Gm-Gg: ASbGncuszszsFz+zHPsXAzwZoOp1/JW3mpMJ6OL9L50tCMPbiLFMTS6FFrndrQFDeQn
	Lz77OTixIrn5DQmdKFAmizzZpMQqSGEnQ152CO37GmJtgJtjh7/mZCMwGBFoUSLg9AfHpXBJSIW
	miYUrYVGh/Sm5jzFvbdv6O2k/oNJmkDzmA2pBCfCWIZPFEkFNZJ4yQB18=
X-Google-Smtp-Source: AGHT+IFmsI0jT1Tm9uxsFQ3iuQ+222DYkovBSackK/ij51wCuQ4owr3Hkqr/eP5LneYOIoFgJTK2Npwiks090WOoBWg=
X-Received: by 2002:a05:6122:2a4c:b0:520:5f0a:b5a5 with SMTP id
 71dfb90a1353d-527c358835amr7868086e0c.6.1744638572843; Mon, 14 Apr 2025
 06:49:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 08:49:31 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 08:49:31 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <dc0d6acb-bcf1-4a7e-bfc8-7c2e7793c72b@gmail.com>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com> <dc0d6acb-bcf1-4a7e-bfc8-7c2e7793c72b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 08:49:31 -0500
X-Gm-Features: ATxdqUFfuB9FeIhZO1waEVg_SX485lb_6E6X7WiLujzM1RSBTDlo4J5iDdkAVOc
Message-ID: <CAOLa=ZQO-7CmeKh13+vxgYnv1dpKvLQnVPf6R3dkujLf+HoMEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] meson: add support for 'hdr-check'
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: jltobler@gmail.com, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000657a930632bd52e4"

--000000000000657a930632bd52e4
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 10/04/2025 12:30, Karthik Nayak wrote:
>> The Makefile supports a target called 'hdr-check', which checks if
>> individual header files can be independently compiled. Let's port this
>> functionality to meson, our new build system too. The implementation
>> resembles that of the Makefile and provides the same check.
>
> Thanks for adding this, I've left a few comments below
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 107 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 790d178007..6fce1aa618 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -655,6 +655,12 @@ if git.found()
>>     endforeach
>>   endif
>>
>> +headers_generated = [
>
> To me "generated_headers" would be a more natural name and would match
> the style of "coccinelle_headers" from patch 1 as well as the equivalent
> in the Makefile.
>

Yeah, makes sense, I will swap out the name.

>> +  'command-list.h',
>> +  'config-list.h',
>> +  'hook-list.h'
>> +]
>> +
>>   if not get_option('breaking_changes')
>>     builtin_sources += 'builtin/pack-redundant.c'
>>   endif
>> @@ -1995,6 +2001,107 @@ endif
>>
>>   subdir('contrib')
>>
>> +headers_check_exclude = headers_generated
>> +headers_check_exclude += [
>> +  'compat/apple-common-crypto.h',
>> +  'compat/bswap.h',
>> +  'compat/compiler.h',
>> +  'compat/disk.h',
>> +  'compat/fsmonitor/fsm-darwin-gcc.h',
>> +  'compat/fsmonitor/fsm-health.h',
>> +  'compat/fsmonitor/fsm-listen.h',
>> +  'compat/mingw.h',
>> +  'compat/msvc.h',
>> +  'compat/nedmalloc/malloc.c.h',
>> +  'compat/nedmalloc/nedmalloc.h',
>> +  'compat/nonblock.h',
>> +  'compat/obstack.h',
>> +  'compat/poll/poll.h',
>> +  'compat/precompose_utf8.h',
>> +  'compat/regex/regex.h',
>> +  'compat/regex/regex_internal.h',
>> +  'compat/sha1-chunked.h',
>> +  'compat/terminal.h',
>> +  'compat/vcbuild/include/sys/param.h',
>> +  'compat/vcbuild/include/sys/time.h',
>> +  'compat/vcbuild/include/sys/utime.h',
>> +  'compat/vcbuild/include/unistd.h',
>> +  'compat/vcbuild/include/utime.h',
>> +  'compat/win32.h',
>> +  'compat/win32/alloca.h',
>> +  'compat/win32/dirent.h',
>> +  'compat/win32/lazyload.h',
>> +  'compat/win32/path-utils.h',
>> +  'compat/win32/pthread.h',
>> +  'compat/win32/syslog.h',
>> +  'compat/zlib-compat.h',
>> +  't/unit-tests/clar/clar.h',
>> +  't/unit-tests/clar/clar/fixtures.h',
>> +  't/unit-tests/clar/clar/fs.h',
>> +  't/unit-tests/clar/clar/print.h',
>> +  't/unit-tests/clar/clar/sandbox.h',
>> +  't/unit-tests/clar/clar/summary.h',
>> +  't/unit-tests/clar/test/clar_test.h',
>> +  'unicode-width.h',
>> +  'xdiff/xdiff.h',
>> +  'xdiff/xdiffi.h',
>> +  'xdiff/xemit.h',
>> +  'xdiff/xinclude.h',
>> +  'xdiff/xmacros.h',
>> +  'xdiff/xprepare.h',
>> +  'xdiff/xtypes.h',
>> +  'xdiff/xutils.h',
>> +]
>
> Having to manually maintain this list is a bit of a shame as every time
> a new file is added to compat we need to add it to meson.build twice.
> The Makefile avoids this by filtering the list of headers used when
> building git based on their path - can we do the same here?
>

The ideology in Meson is to list all files explicitly [1] and that was
what I wanted to follow. That said I understand the reasoning, and will
implement a glob match in the next version

>> +if sha1_backend != 'openssl'
>> +  headers_check_exclude += 'sha1/openssl.h'
>> +endif
>> +if sha256_backend != 'openssl'
>> +  headers_check_exclude += 'sha256/openssl.h'
>> +endif
>> +if sha256_backend != 'nettle'
>> +  headers_check_exclude += 'sha256/nettle.h'
>> +endif
>> +if sha256_backend != 'gcrpyt'
>> +  headers_check_exclude += 'sha256/gcrypt.h'
>> +endif
>> +
>> +if headers.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>> +  hco_targets = []
>> +  foreach h : headers
>> +    if headers_check_exclude.contains(h)
>> +      continue
>> +    endif
>> +
>> +    hcc = custom_target(
>> +      input: h,
>> +      output: h.underscorify() + 'cc',
>> +      command: [
>> +        shell,
>> +        '-c',
>> +        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo -n \'#include "' + h + '"\' >> @OUTPUT@'
>
> This line is rather long. Also do we really need "echo -n" here, the
> Makefile does not use it.
>

We can remove it, I was a bit stuck here, because of how meson converts
back-slash in 'command' [2], I eventually got this working version. But
the 'echo -n' can be changed to 'echo'.

Regarding the long line, now sure if there is a better way!

>> +      ]
>> +    )
>> +
>> +    hco = custom_target(
>> +      input: hcc,
>> +      output: h.underscorify().replace('.h', '.hco'),
>> +      command: [
>> +        compiler.cmd_array(),
>> +        libgit_c_args,
>> +        '-I', meson.project_source_root(),
>> +        '-I', meson.project_source_root() / 't/unit-tests',
>
> Do you know why we don't need to add these include paths for the
> equivalent rule in the Makefile?
>

Because the Makefile builds in-tree, so the dependencies are met. Since
meson builds are out of tree, we need to explicitly add missing
dependencies. I'll add this in the commit message.

> Thanks
>
> Phillip
>

Thanks for the review!

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

[1]: https://mesonbuild.com/FAQ.html#why-cant-i-specify-target-files-with-a-wildcard
[2]: https://github.com/mesonbuild/meson/issues/1564

--000000000000657a930632bd52e4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 97020bf5f1b6e6e6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mOUVta1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN282Qy80d1lhZEtpQnI4amNxUVRpQ0xHM0FMbyt6awpqWE5XZFM1Y0h1
SDlSOGQ5am5jV21EY3Fmd0JVTU1iZjI1VWhTa21reEd4VEthMEZuY3BPbTREMjNaTXpZQm1sCjNV
Z0JlM1VJQ3BUUjR1dXBKRzFXYk56RmJBbFlTalM4R2Y1OEl4V1k5MXB4Q1o5bTJWajNudXVucGxG
R3F2b2YKb2lBUU5IOVF3Tm1aQmJVbDZ0WFdQT1p0RytGSTI1dXI0MUd0cWVqakJqbG1MRnowWTcv
RFQyY2JBbVl6VFJaRgpBZDA4dE15MStuMlhWdHQ2ZURxWmlqQ0RPVjVuTnphVnd5YlI2Si95MUtN
bE1FUUlIMC92YWM0NlNGRk10Q1NRCmU0WjE3d1ZrbVdUVXJFVXJqVzg1dWVNTkh2ajNFaC9QSlNE
YW5TeDc1N3NVMXVpaVMxVkhJajhocEcvYWNnSGwKWTgxendDdzB2WXVya2d4OFUyMmdDb3NMc3ha
YVpueSs1OHR3cWVnTHBnNk4vNnB6elJpMloySU50Tm5QTU1YQQo5UE1URktVOTVHeUNwOSs4S3lr
UkNvRHI2bjJ3SG82QUdTNW4vaFMxRmY5U1lvZnpjYnE4a0dSWUNJWk5IRUwxCm52RzYrUzlxZVFH
VHVacUxDS3RoNFVWRWxKM1lId0MrSWhmb0swVT0KPWRLZlMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000657a930632bd52e4--
