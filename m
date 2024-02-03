Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDA5D726
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706960381; cv=none; b=nplvKyc0hrXgGqLvTo1B9+VqHz6W4O3u/2VAxlTST1+Qdkv2kQk/Nv6EjjVScbAkHF60TLPxWCFeT5fkN4LfON4mmkMbM2ZbjzGbre77hwpAAZPHdXpTHuDOFr7npmYDNouB5pCHKPI8rJc06EMfBG9VeKVsEYQM7xgjQU/TUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706960381; c=relaxed/simple;
	bh=98jTjzv7Brvz6RyXer+SUDpU1t5SdD3yhhSmIyyjRSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts+Q1NUw2BsXBfvH4G4URGAM6CQ0LudsE3Y5DjWEvfTBpYe6EX06bDhT8zBnoACSdTHNJBbVieCJ9DIBdJnrXa2HgX/J1MahhiZpbBr0bWciD4z7zp/RewLzL0uglgdCgFNgr/o6uBRD8N1Zj3BCWoCv016c2n2luIaQS1GA2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaVEYQop; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaVEYQop"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e800461baso25563595e9.3
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 03:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706960377; x=1707565177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq0gOlbooxp07qM5WiaSONTKJeLkdtx1ai900Qv+Xz4=;
        b=IaVEYQop7WQzHtrZjmCh7z0mqdaEpHbHMigJyYzmbB4Sk3mJIBKDv4EbaSxeDXwNrp
         BDGtNBuqCkO+eSmqYKlgx81oLkUWfdB809tSNfjY7NEmN+V8fQEUsAWryKhXn7fOKRcP
         oJwkdQ6myFRh5tWb0m9HdW8O9260uJDZUL6kAcAdG0YyS4yYgtyA5wJVWrXjrINUwq6C
         78H0v6NaIgy3VwHPAYgoQ8iCY/9AczBuf5/eMEpT1g1A2BVJoY9L+nMbrEP8NUdatNiD
         MgC7T0dhW1g5mZ4GHc5PSAK9IE80KND5Lc0aMexenHv6t8QiwmmlsAVhBgN1jRDVuPF5
         f+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706960377; x=1707565177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qq0gOlbooxp07qM5WiaSONTKJeLkdtx1ai900Qv+Xz4=;
        b=WG0pjncnM6m170mnhnD1iFnAj08Ywk8oh3fRE8ruBOSwksyxROK8xyj4uF1BuxP3LH
         mZQ1EsdcbSXzJSexGKd72GVZIU8sAjk0jlW10xvleyF03OGXfy1WUfED5rOyuINVU2oC
         /2e02PlE2VKPgzY8KD/xfYvG/LVhFmODWp3j27HbQiIictWVgN9w0oxSCftsm2bg6B8h
         vqJxGDdx1hNXh61lPkXDNDR4RKSbwFBH9pjoSkieAhYQYMuY04D7P7F8BuD/yEj9lsYX
         oTjsqIgiZVqCpQg9zeHOVfhfEJCIpce1mWnYUF/xyqs+dyIWKq3ZsDYVo3k9UonGtuUE
         TbIw==
X-Gm-Message-State: AOJu0YzaOjS/mo+AXpm6CR2qafNUtAh68VvazHl08onMsRmVLDlR49Ed
	tQF7F61Hgks/HEOCoGZDa+GhaCLa/P0uYAPv7dy/+Sd5e2HpF3SJeua1ocKTQDTp8lnBPJ6E04h
	L4xvmK7GIzxPsERpmtnHzpbsdhFaRyVBqVyoAAcNa
X-Google-Smtp-Source: AGHT+IHCB9/u50BxXSHlLMSdGnhYVGooqJNFLXxKcUmVXwXuSFq+jzMqPBpYiHtQ5kkKVJllAk6xDaPAfvDmYQiSR+8=
X-Received: by 2002:a5d:51c2:0:b0:33b:21f9:cd9a with SMTP id
 n2-20020a5d51c2000000b0033b21f9cd9amr3206486wrv.19.1706960376694; Sat, 03 Feb
 2024 03:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202203935.1240458-1-gitster@pobox.com> <20240202203935.1240458-2-gitster@pobox.com>
 <CADCFv=5=uwp_NVpndTYFiRRK4hEwmMdA2At80cXuS91V5mKN2A@mail.gmail.com>
In-Reply-To: <CADCFv=5=uwp_NVpndTYFiRRK4hEwmMdA2At80cXuS91V5mKN2A@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIERvbcOtbmd1ZXogQ2VsYWRh?= <dominguez.celada@gmail.com>
Date: Sat, 3 Feb 2024 12:39:00 +0100
Message-ID: <CADCFv=4Gjh5B6RFF3P--FO9T7R+uGg2dyN8hT4VR0yJtJt-UsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] GitHub Actions: update to checkout@v4
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am adding non-html e-mail reply to keep track in git@vger.kernel.org:

The switch to checkout@v4 for GitHub Actions looks good to me. I
wonder if we should be updating other actions to v4 so they start
using Node 20:

In coverity.yml
(https://github.com/git/git/blob/8838dd21e8a4ec1324377ffcfa90413844ca3674/.=
github/workflows/coverity.yml#L101C15-L101C39)

actions/cache/restore@v3 -> v4 (reference:
https://github.com/actions/cache/releases/tag/v4.0.0)
actions/cache/save@v3 -> v4 (reference:
https://github.com/actions/cache/releases/tag/v4.0.0)

In main.yml

actions/upload-artifact@v3 -> v4 (reference:
https://github.com/actions/upload-artifact/commit/aa5cae10db2b39d79f5244f6b=
c5084278993a3ae#diff-1243c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8c=
ed9a36e6b6R33)
actions/download-artifact@v3 -> v4 (reference:
https://github.com/actions/download-artifact/commit/88dadfbcfcdd10293192ac8=
ee1e3ffe61f7055ee#diff-1243c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c=
8ced9a36e6b6R28)


On Sat, 3 Feb 2024 at 12:31, =C3=93scar Dom=C3=ADnguez Celada
<dominguez.celada@gmail.com> wrote:
>
> The switch to checkout@v4 for GitHub Actions looks good to me. I wonder i=
f we should be updating other actions to v4 so they start using Node 20:
>
> In coverity.yml
>
> actions/cache/restore@v3 -> v4 (reference: https://github.com/actions/cac=
he/releases/tag/v4.0.0)
> actions/cache/save@v3 -> v4 (reference: https://github.com/actions/cache/=
releases/tag/v4.0.0)
>
> In main.yml
>
> actions/upload-artifact@v3 -> v4 (reference: https://github.com/actions/u=
pload-artifact/commit/aa5cae10db2b39d79f5244f6bc5084278993a3ae#diff-1243c54=
24efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8ced9a36e6b6R33)
> actions/download-artifact@v3 -> v4 (reference: https://github.com/actions=
/download-artifact/commit/88dadfbcfcdd10293192ac8ee1e3ffe61f7055ee#diff-124=
3c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8ced9a36e6b6R28)
>
>
> On Fri, 2 Feb 2024 at 21:39, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> We seem to be getting "Node.js 16 actions are deprecated." warnings
>> for jobs that use checkout@v3.  Except for the i686 containers job
>> that is kept at checkout@v1 [*], update to checkout@v4, which is
>> said to use Node.js 20.
>>
>> [*] 6cf4d908 (ci(main): upgrade actions/checkout to v3, 2022-12-05)
>>     refers to https://github.com/actions/runner/issues/2115 and
>>     explains why container jobs are kept at checkout@v1.  We may
>>     want to check the current status of the issue and move it to the
>>     same version as other jobs, but that is outside the scope of
>>     this step.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  .github/workflows/check-whitespace.yml |  2 +-
>>  .github/workflows/coverity.yml         |  2 +-
>>  .github/workflows/main.yml             | 18 +++++++++---------
>>  3 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/=
check-whitespace.yml
>> index a58e2dc8ad..a241a63428 100644
>> --- a/.github/workflows/check-whitespace.yml
>> +++ b/.github/workflows/check-whitespace.yml
>> @@ -19,7 +19,7 @@ jobs:
>>    check-whitespace:
>>      runs-on: ubuntu-latest
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>        with:
>>          fetch-depth: 0
>>
>> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity=
.yml
>> index e5532d381b..a81a7566d1 100644
>> --- a/.github/workflows/coverity.yml
>> +++ b/.github/workflows/coverity.yml
>> @@ -38,7 +38,7 @@ jobs:
>>        COVERITY_LANGUAGE: cxx
>>        COVERITY_PLATFORM: overridden-below
>>      steps:
>> -      - uses: actions/checkout@v3
>> +      - uses: actions/checkout@v4
>>        - name: install minimal Git for Windows SDK
>>          if: contains(matrix.os, 'windows')
>>          uses: git-for-windows/setup-git-for-windows-sdk@v1
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index 4d97da57ec..90973f9693 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -112,7 +112,7 @@ jobs:
>>        group: windows-build-${{ github.ref }}
>>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =
=3D=3D 'yes' }}
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
>>      - name: build
>>        shell: bash
>> @@ -173,10 +173,10 @@ jobs:
>>        group: vs-build-${{ github.ref }}
>>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =
=3D=3D 'yes' }}
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
>>      - name: initialize vcpkg
>> -      uses: actions/checkout@v3
>> +      uses: actions/checkout@v4
>>        with:
>>          repository: 'microsoft/vcpkg'
>>          path: 'compat/vcbuild/vcpkg'
>> @@ -297,7 +297,7 @@ jobs:
>>        runs_on_pool: ${{matrix.vector.pool}}
>>      runs-on: ${{matrix.vector.pool}}
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>      - run: ci/install-dependencies.sh
>>      - run: ci/run-build-and-tests.sh
>>      - name: print test failures
>> @@ -317,7 +317,7 @@ jobs:
>>        CC: clang
>>      runs-on: ubuntu-latest
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>      - run: ci/install-dependencies.sh
>>      - run: ci/run-build-and-minimal-fuzzers.sh
>>    dockerized:
>> @@ -342,7 +342,7 @@ jobs:
>>      runs-on: ubuntu-latest
>>      container: ${{matrix.vector.image}}
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>        if: matrix.vector.jobname !=3D 'linux32'
>>      - uses: actions/checkout@v1
>>        if: matrix.vector.jobname =3D=3D 'linux32'
>> @@ -373,7 +373,7 @@ jobs:
>>        group: static-analysis-${{ github.ref }}
>>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =
=3D=3D 'yes' }}
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>      - run: ci/install-dependencies.sh
>>      - run: ci/run-static-analysis.sh
>>      - run: ci/check-directional-formatting.bash
>> @@ -396,7 +396,7 @@ jobs:
>>          artifact: sparse-20.04
>>      - name: Install the current `sparse` package
>>        run: sudo dpkg -i sparse-20.04/sparse_*.deb
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>      - name: Install other dependencies
>>        run: ci/install-dependencies.sh
>>      - run: make sparse
>> @@ -411,6 +411,6 @@ jobs:
>>        jobname: Documentation
>>      runs-on: ubuntu-latest
>>      steps:
>> -    - uses: actions/checkout@v3
>> +    - uses: actions/checkout@v4
>>      - run: ci/install-dependencies.sh
>>      - run: ci/test-documentation.sh
>> --
>> 2.43.0-522-g2a540e432f
>>
>
>
> --
> =C3=93scar Dom=C3=ADnguez Celada



--=20
=C3=93scar Dom=C3=ADnguez Celada
