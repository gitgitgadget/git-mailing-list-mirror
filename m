Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409421128F
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314777; cv=none; b=hcgyeuuLI2ry16b0F1JYWe+G3cUhJIdCBtrggJBBm4W07y0QDtLG8HjtSLpL/7JTxvL0F1DvX0NNM9neUULiyJySr0Yc/qa+dsci7iJSgXS9Qew7q1GMa3BgLMu5Mt+Y/ZznyiQbcZcqCFj78wZLtVqhfq0QSkgMllJed7+m2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314777; c=relaxed/simple;
	bh=a1YL7KR50qbJPglmUrb91WWiwgY1BkWUHS9jz84J8Xc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFpNsD96fIBj3xpmWzLgMmS6m7lXoF5YB2Wrp5uBJPF0HhDzvVqwRHGOt6PldrLeemrf54rVQCC4LvwlUk/RaWIFBu8OZYx8/ljfwi4lNi9dCmFlZjIAfxZx9NUBaJ9O/5l6bILPR2O43FSBa3DcBt3iyN09ffmjmoHrFvcFI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Body/F; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Body/F"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8670fd79990so2304850241.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742314773; x=1742919573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNFECFyakBF3t+6bphp7324j4i2sDWX7RtHvPIp0fkY=;
        b=A/Body/FJfRn01m/faaknddCdpDPQJcGYhd6TJuW3qoqw3AduuBKlhpXcEQyhGjSHW
         fKf/mrarZaMWEhYvONFZawhIdBOtnS9aEr5rbGyy524UezLunpJZ8TbZqP/vsZ1YeF6c
         8sGPMqzzvcFsaBCkjNc9p/+EFdEmkbev/MW+Uag1d/TGIV+JtoSw5kt3CI0FhkQ8LSEh
         cL4J3Y/uGK+l3FASO31lCk1+GUSFXK2SXUFv6sPx36tVqvzraLQZmwJS6MyCsKkqtmPA
         5CUy2V7nANJmr2yFFRQ9MwyvLPcwVJdp5A9hdPXm3SUqb5JaQ3/zfZBMm2xtTg1FWvkx
         p1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314773; x=1742919573;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNFECFyakBF3t+6bphp7324j4i2sDWX7RtHvPIp0fkY=;
        b=OQzmZV6/jy20APpH9KXOvRohar9jigeZLYNNc6xDd6yT6AtTJZi7nDE1uO/Frn9Iwe
         Mm6SlnUGuuPT+3vqWm7wsbLA/4pz5hzxRb6NyBo4me3/b3RNBmwXBLE+LBQVCfLycsnX
         jtRicVeRl1jMGG1nlrm9gsSxDcimZ+xh2WMefNPB6K22PBCjxhX/SEFYiNW71YWNcnaf
         8bsu2jtIvHsVyGXmP4p5GXIwDGKruk4hK3UsHEjPmyDds84U5X0j2iqqA2LzND0tMRX7
         WkYi2FWieEhZ2xHXHlHKSJQht5FytRtkKBhCpqM3ArLz5LIkXB4FsC+EDF0ycLtJs1W4
         MSAg==
X-Forwarded-Encrypted: i=1; AJvYcCUkQPThpHi5DfiL+rPUQXDLAwLemc9rXdMzQ/mYkBNVJaNOBgIF49YN9aSvqxu+EwGLvxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXN9mwNEr0UxPkXxlESCRfbzVy5ZszV2GASmfRGjU8ydi5T3j
	chOAegGp4L9HyUnpI/OOCJqd8+I1TeUfQKIFyQEiyoBDRrPVmKzBlPuLnEKN6+34Ny7Qee4e48r
	8hfKMb6i2IAhLF0JPeI6YWjburclYoRp7
X-Gm-Gg: ASbGncval2+ay/s4SExUeho22xJwRhONMX7GXNYzpJ3EqR0ILbNU0ygZGAQylzwJVNP
	AiPAxD6RfM4C0xlBDKm4xH3CW6ABWTXK/UdVX4L0L29urnuydym3BbaODlkSyg4w5cacJR5rfNK
	9O0E7T4zwFwKrfD5mTmY8vLUwImRTinAFTiOO02w==
X-Google-Smtp-Source: AGHT+IFmUkho/Q5+RRxJp77wAgAll7ZHv9oMUOI+oGx4x2UOOm54ndixO44gHfmnR9K4WLLyoOn7h8Y+TNvlswdynvI=
X-Received: by 2002:a05:6102:1797:b0:4c4:e018:326f with SMTP id
 ada2fe7eead31-4c4e0183678mr1647672137.10.1742314772576; Tue, 18 Mar 2025
 09:19:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 16:19:31 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqmsdi49h8.fsf_-_@gitster.g>
References: <xmqqv7sbfra0.fsf@gitster.g> <20250314184130.GA578421@coredump.intra.peff.net>
 <xmqqy0x7cg9h.fsf@gitster.g> <xmqqmsdi49h8.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Mar 2025 16:19:31 +0000
X-Gm-Features: AQ5f1JpAzHGmRS-LNgzCUWC-W2AmVvtyg--B7dUFHq6b8bivHu7Vg5oM2C3XseE
Message-ID: <CAOLa=ZRODjYfDXQ8m+hDosV7RBGDWeehzSvsR-+-HCmbS+tAcQ@mail.gmail.com>
Subject: Re: [PATCH] install meson for Documentation job
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="0000000000001b5c430630a0458d"

--0000000000001b5c430630a0458d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> On Fri, Mar 14, 2025 at 10:36:39AM -0700, Junio C Hamano wrote:
>>>
>>>> * ps/ci-meson-check-build-docs (2025-03-12) 1 commit
>>>>  - ci: perform build and smoke tests for Meson docs
>>>>
>>>>  CI update.
>>>>
>>>>  Will merge to 'next'.
>>>>  source: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>
>>>
>>> I didn't dig into it, but I'd imagine this topic is the source of CI
>>> failures on the "documentation" job like this:
>>>
>>>   2025-03-14T17:50:13.8749066Z + meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
>>>   2025-03-14T17:50:13.8752287Z ci/test-documentation.sh: line 50: meson: command not found
>>>   2025-03-14T17:50:13.8769502Z ##[error]Process completed with exit code 127.
>>>
>>> that I'm seeing in jch (and looks like you have a similar one in the
>>> latest build of 'seen')
>>>
>>> -Peff
>>
>> Somebody more clueful than me about how the CI dependency set-up is
>> supposed to happen should rewrite the proposed log message
>> altogether.  The install-dependencies script pretends as if two
>> case..esac blocks are orthogonal (the former switches on $distro,
>> the latter that we see in the patch switches on $jobname), but I
>> somehow do not get the feeling that we can move Documentation job
>> from ubuntu-latest to alpine-latest for example.
>
> Ping?  Anybody wants to help explain how this part of CI works to
> the commit log message?
>

Weird. From the looks of
https://github.com/git/git/actions/runs/13867157977/job/38808418127, it
seems like the '$distro' variable in 'ci/install-dependencies.sh' is not
being correctly initialized. We can see this in the logs of the CI:

  CI setup via install-dependencies.sh
    + set -e
    + export TERM=dumb
    + export MAKEFLAGS=
    + test true = true
    + CI_TYPE=github-actions
    + CI_BRANCH=refs/heads/seen
    + CI_COMMIT=d5389e37e21d864f40f4167280db799ffe8983c2
    + echo Linux
    + tr A-Z a-z
    + CI_OS_NAME=linux
    + test macos != linux
    + CI_REPO_SLUG=git/git
    + CI_JOB_ID=13867157977
    + CC=gcc
    + DONT_SKIP_TAGS=t
    + cache_dir=/home/runner/none
    + GIT_TEST_OPTS=--github-workflow-markup
    + JOBS=10
    + echo
    + tr : -
    + distro=
    ...

So in 'ci/lib.sh' we set `distro=$(echo "$CI_JOB_IMAGE" | tr : -)`. So
this means the distro is based on '$CI_JOB_IMAGE' env variable.

From '.github/workflows/main.yml' we can see that this is not set for
the 'Documentation' job. I'm not sure why this the way it is though. I
didn't look into the history.

An untested fix, which should fix (is it a bug?) the root cause:

-- 8< --

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9959b61ece..2679a32508 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -473,6 +473,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent
== 'yes' }}
     env:
       jobname: Documentation
+      CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
     - uses: actions/checkout@v4


>> In any case, the change seems to "fix" the issue for me
>>
>> (bad)
>> https://github.com/git/git/actions/runs/13867157977/job/38808418127
>>
>> (good)
>> https://github.com/git/git/actions/runs/13867208725/job/38808554478
>>
>>
>> Thanks.
>>
>> --- >8 ---
>> Subject: [PATCH] install meson for Documentation job
>>
>> Why should we even do this?  Doesn't it run on ubuntu-latest which
>> has its own apt--get install for meson in the $distro specific
>> set-up before this part?
>>
>>
>> ---
>>  ci/install-dependencies.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
>> index 0df74610d0..fdeeaabaca 100755
>> --- a/ci/install-dependencies.sh
>> +++ b/ci/install-dependencies.sh
>> @@ -123,7 +123,7 @@ sparse)
>>  	;;
>>  Documentation)
>>  	sudo apt-get -q update
>> -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
>> +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make meson
>>
>>  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>>  	sudo gem install --version 1.5.8 asciidoctor

--0000000000001b5c430630a0458d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d86835f413846b13_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mWm5SSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1hpREFDQ2dCVlQyUFVhdFFIS2ltcnVsME0yMlRMcgpac2tIK0kwY0ZT
Z0Z4YWNBcG5jZkhiNmlaWE1uaGlsUGRhNWZRZzNQM1FkdXlwa0RmVG5Ib0N1MVREcXRheDZSCkVj
cXVtUmZPcDRkNzBNQWw4MVJtVWFTQU8zT3dXWG9kU3RhY2ZiZzBMVmVuaFJJaUt4V1g0OUpVOGFZ
eVlIdUYKVVJRRWs0WndpelBVSzBYeElDNzFUcW9sTnFzSDRRayt3YUtIWFNDWEtNM1ljNit5VDZD
eW85ZFFHT21ySTNiVQozT3NlSFR3RUIvV2RsMzlqUm5uR3l3THQwRjhxVFhRbmJDMk1TVWNVemsy
ckFVLzNXa0tLajBNOFo5ZW1JK2pEClg3TDlZb1NFYkdhMXMwaWQzaU1Fbm1YM0tlSUlrTy9IVmJu
Y0VibGtIcmZGYWQrd1pSTzBGVEc5UU5QQXI4RXQKbytoMm9RYUpZenRHSjNWLzlLdmZLU0tCa05B
UlZpeFpGT2dnWUVZKzRrNlZyK3NacjRGWWZLU2kyYnIzZUJrKwpEWE9OMjlKQUVRdEhlRzZEdkx1
N1lORzQ3OTNXZHhnbEdPYzBPdVNad2wzb2YybDF3eVg2cFV4ekhlVXVaYzhVCkhWV005ZUJva25r
ckN5VmtSTEljNmpNMi9BVjhmeTk5UWJSVUxlMD0KPWZFN0QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001b5c430630a0458d--
