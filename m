Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68546BF
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023349; cv=none; b=g7TPP2VJ1dhmtuXg1Q0XThJTyriLavC5oRbn62DvKcvaM/jDJ5DxX56KE2By6qYSjoUvv/YGj4KZNiCXbprFKp5EgkNOlxcC30sDqJajcr2Dg3re3Gnk8ahPM7Eoje4iFfhqb1Ifxu4WJwqHETMggmDnF7/9Lw75TPUG4xafDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023349; c=relaxed/simple;
	bh=i9xhwsEYZ7Hj34qKNtn596v8AFApqpma4E2TE9fbygc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GrCBYiAG9qGHggN2gaFHmc70zd+Rr/VQ5bCAjWnj18z7fR6YLc2YW6YYy2rzQ+j1kTEzEfL21n4z8HvWvKStDSHhzhGhOjrVOHgDFfmCPU6f+Xykzc+LTTsKXMkfFBZi+ezfYSAtw4sm7IjPMZg+RQglCiHBVO9Hl9tk27u5i14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAI73o1r; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAI73o1r"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f025bc147so2228703e87.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023346; x=1722628146; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amlbVLdrOg0c06xZOuweahl0TknhXF47nsf23rTfE+U=;
        b=YAI73o1rCFSrwJS7dDS/HNvYdgkEXZMAJh+u+3INmRNqy9ekpgzRN4qJfKyMZ1rWG6
         Z3BA8sXPEr1LxQoaRPEf7yUQRFRNxlYMxN/Y6qrDvtngL/NAQOzxf0ypGuDmXfukGC9m
         axahyTT+buBDEAI13Ir7ItauR+0T8zmDx5fNQxTb+lDf5Wf6LAO+j50VCMXHhh8Rvh1s
         fULJM+IqfJ295RzZN7QYHwwX052aa2YQrgbEersCrNq2pfeV4K3vqS2TmR9Lh3uXiMVz
         HFGWWbXzcvRBTBdPu5jU2mRcmdo2LA1/XBhZclu1egJ7/skHc78RI0wAuGzJWEyWJ8F+
         gKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023346; x=1722628146;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amlbVLdrOg0c06xZOuweahl0TknhXF47nsf23rTfE+U=;
        b=fpogLFgSueC97d0uzL8/bX5qxP6JQst5bqjebMExKfLRVJX3GtEqhl4b9J+XBy38+9
         nw68L4s6nLX1EI88G0KrMaKhnyE9pm9xQbnC2LTpNWPY0XUGiZ+Bq6jYcmAxlzLUbZHk
         bEbbMvLOAl6qfURdKRjsOJPHmE83ZXHB2r4b2UvwG53YJoo4ncEL72WOdBDR1dv8feNC
         P1PIo8QoV1rURjQmSb+RJ5G1lJyOSLAAS5nun3R00LGTyEUBfdgTL1dH+tXaxeQSmSqB
         4dpb6MVy7wKzVkmPisG85P3RoQHoNOoD8ypgAkDn2Z3egT0pqvjezD8gxKTPmkDvWt92
         jxSw==
X-Gm-Message-State: AOJu0YwuCmz0FVcmtpCdIffSM2TDi3w01EyIWitZfylsTtPFyc/THBER
	rMj6n7DbOczwiVN31xk2+Vy7ZI0ZFKIygOLc61OV4YstcrrL6jXw+z969i+bCSI/Eu9W2qjq14k
	YuYOLlr23NpS+xBkEGjQrjJEJtcId3DbG2Fs=
X-Google-Smtp-Source: AGHT+IGjs6pBNpU6uLmTqbZjoRir42avuWERW/GgznITvjMDDBu9YWOAlRuXtmVXUOWdVzaY0/1EaQ/vD/O+JWxaQQY=
X-Received: by 2002:a19:f614:0:b0:52e:be49:9d32 with SMTP id
 2adb3069b0e04-5309b2c30c0mr473673e87.47.1722023345976; Fri, 26 Jul 2024
 12:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
In-Reply-To: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
From: Tim Abdiukov <tabdiukov@gmail.com>
Date: Sat, 27 Jul 2024 05:48:55 +1000
Message-ID: <CAD+08a-+uME7SgmpV_NJ5qmmtxpGeKPYV4wig5w4=gX+GMB7nA@mail.gmail.com>
Subject: Re: Bug with bash and OpenSSL usage on Windows
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

user@(computer) MINGW64 ~
$ echo "I can start OpenSSL with no problem"
I can start OpenSSL with no problem

user@(computer) MINGW64 ~
$ openssl
help:

Standard commands
asn1parse         ca                ciphers           cmp
cms               crl               crl2pkcs7         dgst
dhparam           dsa               dsaparam          ec
ecparam           enc               engine            errstr
fipsinstall       gendsa            genpkey           genrsa
help              info              kdf               list
mac               nseq              ocsp              passwd
pkcs12            pkcs7             pkcs8             pkey
pkeyparam         pkeyutl           prime             rand
rehash            req               rsa               rsautl
s_client          s_server          s_time            sess_id
smime             speed             spkac             srp
storeutl          ts                verify            version
x509

Message Digest commands (see the `dgst' command for more details)
blake2b512        blake2s256        md4               md5
mdc2              rmd160            sha1              sha224
sha256            sha3-224          sha3-256          sha3-384
sha3-512          sha384            sha512            sha512-224
sha512-256        shake128          shake256          sm3

Cipher commands (see the `enc' command for more details)
aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb
aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb
aria-128-cfb1     aria-128-cfb8     aria-128-ctr      aria-128-ecb
aria-128-ofb      aria-192-cbc      aria-192-cfb      aria-192-cfb1
aria-192-cfb8     aria-192-ctr      aria-192-ecb      aria-192-ofb
aria-256-cbc      aria-256-cfb      aria-256-cfb1     aria-256-cfb8
aria-256-ctr      aria-256-ecb      aria-256-ofb      base64
bf                bf-cbc            bf-cfb            bf-ecb
bf-ofb            camellia-128-cbc  camellia-128-ecb  camellia-192-cbc
camellia-192-ecb  camellia-256-cbc  camellia-256-ecb  cast
cast-cbc          cast5-cbc         cast5-cfb         cast5-ecb
cast5-ofb         des               des-cbc           des-cfb
des-ecb           des-ede           des-ede-cbc       des-ede-cfb
des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb
des-ede3-ofb      des-ofb           des3              desx
idea              idea-cbc          idea-cfb          idea-ecb
idea-ofb          rc2               rc2-40-cbc        rc2-64-cbc
rc2-cbc           rc2-cfb           rc2-ecb           rc2-ofb
rc4               rc4-40            rc5               rc5-cbc
rc5-cfb           rc5-ecb           rc5-ofb           seed
seed-cbc          seed-cfb          seed-ecb          seed-ofb
sm4-cbc           sm4-cfb           sm4-ctr           sm4-ecb
sm4-ofb           zlib


user@(computer) MINGW64 ~
$ echo "However, if I run it, it just hangs"
However, if I run it, it just hangs

user@(computer) MINGW64 ~
$ openssl genrsa -aes256 -out out

On Sat, 27 Jul 2024 at 05:40, Tim Abdiukov <tabdiukov@gmail.com> wrote:
>
>   What did you do before the bug happened? (Steps to reproduce your issue)
> Tried to generate a self-signed certificate using git bash.
>
> Using git bash, I ran
> ```
> openssl genrsa -aes256 (private key location) 4096
> ```
> however, openssl just hung (on Windows). Cmd can execute this command,
> but bash cannot.
>
> What did you expect to happen? (Expected behavior)
>
> openssl to generate messages about key generation to stdout
>
> What happened instead? (Actual behavior)
>
> openssl just hung
>
> What's different between what you expected and what actually happened?
>
> openssl just hung, rendering it unusable within bash Windows
>
> Anything else you want to add:
>
> This is an issue specifically with Windows x64.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.45.2.windows.1
> cpu: x86_64
> built from commit: 91d03cb2e4fbf6ad961ace739b8a646868cb154d
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19044
> compiler info: gnuc: 14.1
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
