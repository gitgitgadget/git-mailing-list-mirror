Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DDC1FA851
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108412; cv=none; b=ex/42f4bFNHaMHaP6vdwsf4K2WfrIAC7pWgWvh2e9WOTs+5gmw9FPTmx9AdaXEMjUhmUTJBSgBC5mgluzl1Kt4BTHqgLNhKDeR/gjz4ecQ2QhCB9RtRDMloRuq4BhRocgdOXB7YY6Mz2XUWjOMQ65cT2pXip9imd0CV6un1mYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108412; c=relaxed/simple;
	bh=Ds5V8HVxsd5I8YV61o3uTtmDQxrP7/AY5yxIe/wQ2TU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFgk6W6Vehg0BlaaTK0nLSEtkpqwheL3vEXl4NfclAkvLmN/TcnAVDM2Ay3nuZ0Z2M0eu0FMuLhxq/iCg97dVZ3xz18p8+HQSS6K5AYvWGHV0JQBfoQDJiq9Q4oQ5H++XghGrtE404gMDEV7ddKWW8qao29Hg6aIOV0gACpTG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4gm+uRJ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4gm+uRJ"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85b9f2de38eso401568241.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737108409; x=1737713209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRNPn8OsjGGVV5rjaetOLJzezbDdSryGUuy/AslkLAs=;
        b=O4gm+uRJkwJjieaRjA09RBKQNqGRU+qw9v2nlP+eASQ88uH3t7+jjDyLECkoKESFdu
         7i40tUUfbD0DoQ/SXonU2e0Zou4Osh/pXZgQzWEpcZ1at/wXOEXNHFvKd8C6U1ufFuQG
         8iuMMB8pJE7nFnA6yLS4F+bHL2GyRNzZzRS8Hx/lF/QlvgYxbbi0Byuth0nkxvkgMlEF
         mEOtPriLsUzzqP9yWxKouM90g98h7MWYGKRvd0T4pBKNbloVA8l20CedSfFNbwFjzm3e
         +18xhRd82UnGLPxGaOuGjgC3EG1nxt8yistvbOZ5fDzME+x/oDNxbC8TjTEzsixq/9ez
         jeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737108409; x=1737713209;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRNPn8OsjGGVV5rjaetOLJzezbDdSryGUuy/AslkLAs=;
        b=PhhNC3rI//yJkiWjzpCOO2cpxO+Zy8sQdEs1pT1WBpsqgYXt8m+DQmxWz3Fzq76H2G
         Ng1mGiXtGd699RkoUPFy2+3vFGGD2xa+IGyBkbCCXnbWHiuNPYQ/UslPiQ3yrs9wxnue
         sJyGJJ87hVtS4Jfibse8PiQA/UcwmLVGXPoRU2DM6DwoEjaBhvpzcovBpomR9r6c5KLZ
         46zZhayFdet4+fExvKazA8b52ivYdoSpdmav0UGFPFIR3cOMD/4QxVI5NEbfEe8IFZ50
         /lP8KOKeLrubFBqDIMdAo8JYXUtJ4HhXk6z8drprE1Jiyv1nEpngvSWWIrxk+Iwj9VJF
         S+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsAk9sPfRMzM9GsDNEzWH5A89MQcSZdtv9fcMvbVwFpoha/bJgaZOZVd0OyTfKyofrPdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkPi5fVHg4VJBfKurFaGVPMjl1d+IdSAKg/lz4Y89BuaG0y6g
	6lDbDCtxGLjXYfvnqmRjcdwGep+v96ZfVABOeKXcS0OvLvpXcrq1deLe1kpwT+MIW6rqu6elgcL
	62RaiAKgJWfrEeEUY/MyCUrxotTA=
X-Gm-Gg: ASbGncus77M/YE3F6Sz3SL/jtQNDMdYYBXvR6AWSB1NV5co/Y0R21566Yq1ELeKacBE
	FpShVF5UlbPcJmbxqbNAyxL02gYt8VUrKjVOYkpI=
X-Google-Smtp-Source: AGHT+IG/3ofW3J7vONYuRPO7JHXgxUf+OBBdo6JfXNrRLg1wahcSQo48/A/zPqKfR9i1vL+tp5BZ4N4vMB1q3XPdnYE=
X-Received: by 2002:a05:6122:6581:b0:517:4fb0:749c with SMTP id
 71dfb90a1353d-51d592ba751mr1221740e0c.3.1737108409297; Fri, 17 Jan 2025
 02:06:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jan 2025 10:06:48 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im> <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 10:06:48 +0000
X-Gm-Features: AbW1kvZOPdXGfwLq0C38pCwr5VHNUhlAPqM_9L4hwdPajFFZqypbDmwjRimCABw
Message-ID: <CAOLa=ZSfhDHd65D3d6pxbG0HqMPobfdj8fRhLogANyJ_karz0w@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] compat/zlib: allow use of zlib-ng as backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000ac4b9a062be41182"

--000000000000ac4b9a062be41182
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

>  9:  45fde7a7dd !  9:  6fefd3ab44 ci: switch linux-musl to use Meson
>     @@ Commit message
>          is the `GIT_TEST_UTF8_LOCALE` variable used in tests. Wire up a build
>          option for it, which we set via a new "MESONFLAGS" environment variable.
>
>     +    Note that we also drop the CC variable, which is set to "gcc". We
>     +    already default to GCC when CC is unset in "ci/lib.sh", so this is not
>     +    needed.
>     +
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>       ## .github/workflows/main.yml ##
>     @@ ci/lib.sh: linux32)
>
>       ## ci/run-build-and-tests.sh ##
>      @@ ci/run-build-and-tests.sh: case "$jobname" in
>     - 	group "Configure" meson setup build . \
>     + 		--fatal-meson-warnings \
>       		--warnlevel 2 --werror \
>       		--wrap-mode nofallback \
>      -		-Dfuzzers=true
>

why remove the group here? The rest of the range-diff looks good.

> 10:  0aa66bf9c1 = 10:  15acea92a2 ci: make "linux-musl" job use zlib-ng
>
> ---
> base-commit: cbdbb490357c16eaaa6528c1d550c513a632d196
> change-id: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32

--000000000000ac4b9a062be41182
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 961678083891fd98_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lS0s3WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTVVQy93T0hRMGhPQUw5K3VZNlFBQWhaajNoNW5MTQprTkg5UWY2ZzJZ
OWJ1a1hNbFN4UE1HMGNKYUcxQ1J2Yk5kSVFFdXloaUtrdlM3aEhjaEExZ0xEQVVjZ1p4bjk1CmEy
eVNsSEVZMzBtZlBXOWt2ZlYrQnpvSXBoMVphdWozcXpHMktrVDllNnAvVHczdUFkMHRHMnRxbGlr
Y3NWcmoKUVp5bXo3NTNHSWFMVkh1Z05mWmkxWXFId2tsVnFLcFVwclROY0Jqa1RqQXlpcTB3ZVha
RzlLVGVBT292NzRWNQpuMEJ4em5nMTh0UUlzVmFBOHp1ZHptS3p3RGg0YTNMbzJVZTdSUTJzc2w5
eWpTY2pvSHljM2pmQjFuNkVqN21ECnY0cTZQVkwvTDM2bmljWDBYdGFBbmRlRldBSHd4SjJBQWRW
bmxhclhPSmszdmxyVDdZM3JueFRpVUx0UjJGd3kKRWJtMzdVMjVjakJ6QmVJaW1KVng3bGVGclRN
UXdiWXJTWjFwWTJxMm9NVWgrL3BaNTVmeG5nV3dHRVlsYis0cApWKzRCZFFUcXlKbmU3d1BjMVcy
ZmpjTVVjS1I0S2hmdzQwV0dWa2FrdmNRQVdJUkNJQTNFdjRDL3BaQ2g2UURECkFWM0c4dFI5SmJG
OW1aVjBMdHp0QVg1OVRDUjhDSENJOEVjbWlZST0KPU1yZXEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ac4b9a062be41182--
