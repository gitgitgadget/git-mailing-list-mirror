Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566C2820AB
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639399; cv=none; b=DXw5PoLKMPvSIGLQlz/34Cm3G5caM+6D6vj8dZuBzDvT9jAYBCTgTJS9of0Dzo9AqBAE5pYDG27MpYb8JVT/btlGChoN7e8DpCIGvdHk7uL66r5slAYPp7+1eS+Z0jeVBbwe3c1ZzSLqqTEI1zMrQLYyUrHIalpo6m6dtliYu9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639399; c=relaxed/simple;
	bh=B8XYHvpnGn4+LNRtQJHdQ677XTDyWmU2XSsP2y39BR4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEn59btQ24pVssaY3mUmLAOg0KZ68sAe8unB5j6wupU74Wlm9RpvkUMAvM+9mSQI6LTpGbkil8rbWHq/xeM9UXRqEUvvSi8ut5uSdWnWKk8CBtCenjQugnX1gUQzRYryGmVFvdnKbjQljD9YIV9miixtTDgNzDuuPFnc8reKU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdVhh7dV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdVhh7dV"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c560c55bc1so444777685a.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744639396; x=1745244196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8uiSxcCWg0EWh7FVjVSyAHxUxuDirJtVIU+X3pvV2c=;
        b=gdVhh7dV73A/MzXKAJx6M5i4/ejq+XQm2YpfekWNkxrVgUM3A8L4wR3AVQvR740hKg
         fkdC3xm6Fc874uky81pcPU/xMknOgmeMl29+JmARaqtrV69ybyNFmZ3+UwXzvTzy464A
         8J5BJMy9qYr9/YV2GG26r5POELcFXNZh73nRTaHRBjMvCdE+mSjjJNDsR9rLQHbxPdtV
         G+K6YhdR+S3dEslWO1qwcjRs8+ODBNYqgW2C3AIjyDmTLZfEtEmhfBVnOOE2zZTO81eb
         9mzCMe4A01gMKh9AzuzzFOdgzALM5TBQquYPaO/QSgFrenk63CHDUPgjocrH+oXve+KO
         AD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639396; x=1745244196;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8uiSxcCWg0EWh7FVjVSyAHxUxuDirJtVIU+X3pvV2c=;
        b=afCxF4Nc6BaNDUEJN6oUM5A9g5yJRV8fm8Vb4lesPik4LCLGPBUYxGeRHJcjYSD+Gm
         sZVhjiT52WYJQSw1jIfTtDvKEYgy74VIDNxxV53b0f2fk+mmZ0z6me437VZxZ8DS1NMN
         NhtOlQOzoU6XXOKcv9D8VjUGUsB5MAY15H7DDtEqCW805r7ab9HCcfFBdQ2Mc/p+3GQZ
         TG0krRwKGlh680OaHqzI78cipIE9ELeUFcD+TjeSZVE9PVf/qt5IsXnp7XylWo5+YIY8
         DlxUrtBba4LJgQlx7bWqDW4d2UK3taFLqVSUDWFXjN396wgtHGH5/H4d+4OUU1lWl2a4
         ohxQ==
X-Gm-Message-State: AOJu0YzGYALIDJ1WrWgj3XqWmw6QxP3EXZWCYy9dPlVoZ1pvxu0NEU3t
	jDbCmt3wWyTILbGsSbmU+IpWZxOIBwzHDST+8rSpYelJvMGEWIz0n1K7AMboDZkxt0dYFIn66pK
	jhRa6aproRwa+0qFjrgH0Lcd9Utw=
X-Gm-Gg: ASbGncucB5qzeDmZvw5AHOLgqdh1eUgH5vEw6gfVBPKbkqo1YcPvW6d9iKJKNscMojg
	bym/inRbxKPBXFjD1MZbWzdcGTFjFrDlsmskuTKLlvVhSzfFZNv00Obmena/8XtRI9Kkv6nvPHO
	uAxPUmsTHRrBuc494TWYy/9cLvXQvA4cyCZ6a2Tf++eQf5N2HNc8Ov+Fk=
X-Google-Smtp-Source: AGHT+IH87Qqwa4Ohzpe1rTHD0b68pu3DYhTiUhoDJ+EPDiYEkXiEeiNr9QSZnkuRViH6EhyOe40C3VEYKB4Bh+HKpPw=
X-Received: by 2002:a05:620a:d95:b0:7c7:bb7d:f67e with SMTP id
 af79cd13be357-7c7bb7df6aemr866868285a.47.1744639396119; Mon, 14 Apr 2025
 07:03:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 07:03:15 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 07:03:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z_jpvghOGHvw2Y4x@pks.im>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com> <Z_jpvghOGHvw2Y4x@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 07:03:15 -0700
X-Gm-Features: ATxdqUF9bpnQ6Z9G-M07cnue3l7-wZPeK4tH0lTdzYqWbQhnyfj_Ug09mD3s4hc
Message-ID: <CAOLa=ZRy3eCd+jGjxVGgiYn2xAP0ugJEfzb0zcGt-Wkv4fNbgQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] meson: add support for 'hdr-check'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com
Content-Type: multipart/mixed; boundary="00000000000077e5ad0632bd83e4"

--00000000000077e5ad0632bd83e4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 10, 2025 at 01:30:33PM +0200, Karthik Nayak wrote:
>> The Makefile supports a target called 'hdr-check', which checks if
>> individual header files can be independently compiled. Let's port this
>> functionality to meson, our new build system too. The implementation
>
> Nit: Meson is typically spelt with an upper-case 'M'.
>

Will modify throughout the series, thanks!

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
>> +
>>  if not get_option('breaking_changes')
>>    builtin_sources += 'builtin/pack-redundant.c'
>>  endif
>> @@ -1995,6 +2001,107 @@ endif
>>
>>  subdir('contrib')
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
> Many of these feel as if they should've been part of
> `third_party_sources`.
>

The condensed list is now:

exclude_from_check_headers += [
  'compat/',
  't/unit-tests/clar/',
  'unicode-width.h',
  'xdiff/',
]

I think from this:
- compat/: This captures all compat headers, I'm not sure adding all of
  compat under 'third_party_sources' makes sense though.
- t/unit-tests/clar/: can be removed, since this is already captured in
  'third_party_sources'.
- unicode-width.h: isn't a fit for 'third_party_sources'.
- xdiff/: will move to 'third_party_sources'.


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
>> +      ]
>> +    )
>> +
>> +    hco = custom_target(
>> +      input: hcc,
>> +      output: h.underscorify().replace('.h', '.hco'),
>
> You can use `fs.replace_suffix()` instead of `.replace()`.
>

Nice, will do.

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
>>  foreach key, value : {
>>    'DIFF': diff.full_path(),
>>    'GIT_SOURCE_DIR': meson.project_source_root(),
>
> Patrick

--00000000000077e5ad0632bd83e4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 27afa0f8c660c7ae_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mOUZhRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUlSQy80dExNaXFWM1c4VzZSVlhHV1JpMVZGM0Y3agp1ODc5V0tINFVn
d2RFeDdTQVVrM1ZhdThRSDVYV0RRd1NUVGxDMjR1YS9BTDVVaTByWGN2Nko4UzZxVFZWSFlrCnFK
Q3U5azA4eFVNa3o5b3FoWURUUjhaWVJIb052OVkxUUFiOUx5aWZ5OGdKNzRsNXd5emYvVmJLTE9x
Tk1lcnAKSVV6RzRmbE5ZVE5xckltVjVvOEZKcXp1RHBZUm03dzJicUJFVlVOdW1qcHNNRkU5RXNP
emVicXErZFZYRnlIMApPcU82WEY4SU9iZG82VDdqVGJ1Ui9DWkNxbktGd3ZaQ0RHOXJJekhkNVoy
Rm0vK1VWczMrbWRKWDBCaU5LT3Z4CjQ4UG9ZNlpOb3BLdDdKUUJwdVdPS1VXU2luNVhCVVdoQitJ
QTNEeEtXN0xsbFljZTBzSW9rTXlDUjlSWUpmS1QKeWJBK1dIWjZnQ3R5aU1kV1R5Y1RsTWtJMG1o
Q3lEdmxyRE03eVdJNVZ1RWxnVkl2aFlaUHBZLzJ0UXJUQjhUNgpWS1NMOFJoazV0QmlNTWhHVFdE
V2ZIWlY1Wlo4QzhHMlFuLy9kbkordUJRVnNuOEVQayt5UEF1U0hla0x5dU52CmE2bW9hdTg5Z2lM
T0g2RFNXeFFtc2x5bHZMN1FNSlN3TlVJOFNoQT0KPVZPemYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000077e5ad0632bd83e4--
