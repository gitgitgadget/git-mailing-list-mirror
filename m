Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319E6ADD
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850024; cv=none; b=elNZ4CbX6vOn57D2NMpZ6EPt1NMajh7PN2XQxYcrYQoPk05/VhHASVZSWYZvf+nqdvZXm78mCAW5hRltIBYti86uUwEslgKBuByBMvu3VNrTFmDKX2ASP7uaFMZjYXlc8aS6SkVVZ2mDs/P/KoWFDLqTP2e8IR0COqvN4ed2wAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850024; c=relaxed/simple;
	bh=+jYg4u8MibH/3TYSj/YJFXQjvTdcOGvax2yCz7SN1TU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcd+HB6eEuJ7VLOaK0tdiRVI8z+Ya5QhnkOPCHUm32hRHV73CU4u1f4rnXOsy5QDNCaioq9IwSiK3BhmQZbFsvl+hCQ/JLB80srVPU8YB20P7Y9/LAgqUKAFN9G3DihjPcpHPGej5oicF4FPj0QGJasfxf7qS8XLOzrzfxkJ7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU7mrsuk; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU7mrsuk"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52413efd0d3so1320677e0c.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748850022; x=1749454822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5msL2S6p7cTlP8HjuUj1vu4Yr8KLMryn4g8bLk2fMk=;
        b=RU7mrsukylZtt1oIu5z6mhj4313paLmOrxtRAS2rGjtWals9oftyTlZLnNu7LYPL7g
         G3CqTgPyUKCaFNBnhhlssXvwMdONTW++qfqttzfrcM8BRUPwYnDw4rg5wK5XQzQbYQNF
         MeeL1+JNd1E2TGDR7mtiYJYLO90Hxo9kbTY2i1hhgKg/CLz1NawXcAKszuHEojlhAzg6
         859v2f6ROffS9U+v/G4rdUqJVWDsXK2Lv2Q71z3p9WqNJHWtNwwOjOp+vAiWVpGaf+oG
         vKOLFrDGndd2c7/+rfOwox4u/3DFlmwCY6U7zcNFVtQJiuihLeHCh2mpqTNsTHHWdt70
         YA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748850022; x=1749454822;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5msL2S6p7cTlP8HjuUj1vu4Yr8KLMryn4g8bLk2fMk=;
        b=dn/cei5ejC9sK2/PSn2TUgWkmxQxYY+kk0J40aIAASH0mCyqX06fhUA4ioJdXe9A1z
         4PA+NUAgvU9+08s/gHhTaSCNjCX7MGojim6hfFViCWjTnn6MLNySMV5XDPVctcAvI1uD
         RMf8pO1u6TbpHTGFTDC6CAfFingpx/nQhQ/G6EwENfhaFmJA03rtbeu8T3t5NF+JDnoe
         ilkypAt4UUUhiWW00+ddzH3hDUfU7ywe7849PePY9a0uXhMFcfUy4LIHsaYKNsuIgwLK
         mkJObNWRJCLdZLFc/NK1Blh7gcwrg/pAiCHWCDWxT51l4cMLYTHgH4712BSznHsNSN4R
         ZfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMd5B1sYFIAP1mT9U4KPJMkkf6K1B9GRnXTLfAadLcUPbhiTehBl/i7ZVgl/XeLCIJHr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCxjnX5doHOfKsMG5ur7sW35l9lilej2iRvqXxaYfM9XYfZic
	MKJqyrYR8gnejBOVARu3m86aLCAqVBP3sdHLmvi5tiKtehbXxCEuVhOm1sMeE0V/evVQ4830ZSr
	rIrN/tNW4Cnlba+32SL+VorTdlIVaMeew0C6o
X-Gm-Gg: ASbGnctCcSQ3kTTq73cOopvIaGnFzyYEQAXiFsGs37uq5IBuT0GXHQanRLrzDrzNg7+
	OziYwKkx2tXO+OJSNDsx8j7rH1y+md4afo/zuAossfgZi4D4LTee1Hf14+1obdpx3HOLV+4vRmJ
	GNXgYcija6UH3Rwa8lPWTsB8EjzOPndEqX9maetp4BNM8jrkGP9uNr6uWfHFBlvZXBRQ0=
X-Google-Smtp-Source: AGHT+IFSnVQZD3XrX9H7UxIXrKcxPl3vpx4oZg5PSLnRnAr6bgc2fLHFHKPV9my/sXZZrTGO6XOfHMnTvosqyo/G+AQ=
X-Received: by 2002:a05:6122:3bc1:b0:520:6773:e5ea with SMTP id
 71dfb90a1353d-53084c639abmr7961800e0c.7.1748850021651; Mon, 02 Jun 2025
 00:40:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 00:40:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 00:40:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im> <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Jun 2025 00:40:20 -0700
X-Gm-Features: AX0GCFsCQAT6ALMrL_qZO1Ap7PRp2O8bPoRkwV7oL8hqUQtdoC890c-hFTze90c
Message-ID: <CAOLa=ZRTPfov728fae4v28-JdXmVqKRX4cC9v9NytTboo8Ax6g@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] meson: parse TAP output generated by our tests
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="0000000000004e72f2063691e070"

--0000000000004e72f2063691e070
Content-Type: text/plain; charset="UTF-8"

Hello

> Range-diff versus v3:
>
>  1:  0e9aac3c63f =  1:  05d16d9d7ac t: stop announcing prereqs
>  2:  2c3bd12eb5d !  2:  ed6a8b205f0 t: silence output from `test_create_repo()`
>     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(sub
>      -test_create_repo sm1 &&
>      -head6=$(add_file sm1 foo6 foo7)
>      -fullhead6=$(cd sm1; git rev-parse --verify HEAD)
>     -+test_expect_success 'setup submodule' '
>     ++test_expect_success 'setup submodule anew' '
>      +	rm -f sm1 &&
>      +	git init sm1 &&
>      +	head6=$(add_file sm1 foo6 foo7) &&
>  3:  c659a0ce551 =  3:  cf05118aeae t9822: use prereq to check for ISO-8859-1 support
>  4:  e7141b15b56 !  4:  4d41989afe6 t983*: use prereq to check for Python-specific git-b4(1) support
>     @@ Metadata
>      Author: Patrick Steinhardt <ps@pks.im>
>
>       ## Commit message ##
>     -    t983*: use prereq to check for Python-specific git-b4(1) support
>     +    t983*: use prereq to check for Python-specific git-p4(1) support
>
>     -    The tests in t9835 and t9836 verify that git-b4(1) works with both
>     +    The tests in t9835 and t9836 verify that git-p4(1) works with both
>          Python 2 and 3, respectively. To determine whether we have those Python
>          versions in the first place we create a wrapper script that directly
>     -    executes the git-b4(1) script with `python2` or `python3` binaries. We
>     +    executes the git-p4(1) script with `python2` or `python3` binaries. We
>          then condition the execution of tests on whether that wrapper script can
>          be executed successfully.
>
>  5:  71b76db40e4 =  5:  b3f5f4e0d4d t/test-lib: don't print shell traces to stdout
>  6:  b60daf5ac69 !  6:  78ab5b1d331 t/test-lib: fix TAP format for BASH_XTRACEFD warning
>     @@ Commit message
>          t/test-lib: fix TAP format for BASH_XTRACEFD warning
>
>          When the Bash version is too old to support BASH_XTRACEFD we print a
>     -    warning to stderr. This warning breaks the TAP format because it is not
>     -    prefixed with a "#". Fix this.
>     +    warning to stderr. This warning is not prefixed with "#", which causes
>     +    TAP parsers to (wrongly) interpret the warning as part of the protocol.
>     +
>     +    Fix this issue by prefixing the warning with a "#" so that it is treated
>     +    as comment.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>  7:  ce55bee9a12 !  7:  61b8b7640b7 t7815: fix unexpectedly passing test on macOS
>     @@ Commit message
>
>          The test passes if '.' matches a NUL byte, which we expect to only
>          happen on Cygwin. The upcoming changes to support parsing TAP output in
>     -    Meson surface that this test is also unexpectedly passing on macOS
>     -    though.
>     +    Meson surface that this test, surprisingly, passes on macOS as well.
>
>          It is unclear how long the test has been passing on macOS already.
>          064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
>     -    2025-04-17) mentions that the test started to pass for Cygwin once it
>     -    has imported a newer implementation of regcomp(3p) et all, which was
>     +    2025-04-17) mentions that the test started to pass for Cygwin. This was
>     +    attributed to a new implementation of regcomp(3p) and friends, which was
>          inherited from FreeBSD. Given the BSD lineage of macOS it is feasible
>          that it also inherited similar code eventually that made the test pass
>          now.
>     @@ Commit message
>          same in this edge case and mark the new behaviour as expected.
>
>          This change is outside of the scope of this patch series, which only
>     -    introduce support for TAP. So instead of fixing the bigger issue, ignore
>     -    the test on Darwin like we already do for Cygwin.
>     +    introduces support for TAP. So instead of fixing the bigger issue,
>     +    ignore the test on Darwin like we already do for Cygwin.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>  8:  80dcf1d5979 =  8:  02011b7017c test-lib: fail on unexpectedly passing tests
>  9:  dca5730ab18 =  9:  540741acc80 meson: introduce kwargs variable for tests
> 10:  60393aa4af9 = 10:  8417d0ed94c meson: parse TAP output generated by our tests
>
> ---
> base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
> change-id: 20250429-pks-meson-tap-1eed604a02a3

The range-diff looks great. Thanks!

--0000000000004e72f2063691e070
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 59d016420dd39b15_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nOVZXSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXlRQy8wYTZyQ2RvZ2tqZzN4VGFOUnJRSlBMRlVpQwo3akgySnp5R3Vt
MlhxajVVYkdwb0NmektiZldsTUw3Z3Evb3VSVHMySm9yeEcxSXhUT2hCYnN0QmNrbWVlWkVDCmZw
Z1hsd1liUU50ZGc5NndJdjY5ZDV0YnBxU1BhcHJZWE9XekROczNmekpFc0l5QTgvNld6T05zZUxK
U3cwVWUKMjRPUG9yZENtOWhyRW93VWRVZmZVRzA5cXNERkV1cE5oWVUxb1NsRXVwd0dRQkpRTk9q
UHA2KysybWNKNm9JcgoyRSt0cjRtNHpmcnRkMlh2NStrVTByUEFEclpCcXNQb1ZmZ1IwNkRBek9S
d1RSZ2IwaGR2ZHhtT3FHU3Y0WElmCmNybG9CVWZkamlWUlJ1NmtoR1VwWUpMV1htVU5Gb1FpQnFF
YnhrNUxkaDdjdlI3bnBYTm9GSjZtNDFoK09jUEUKQllyeit1ZDk4dE15ajdkMzQvY3NVaGdLMFpY
UFFEYW16NjdGRDVqV0hGbXpBSlRmVjRSY3RaWDdrQmxGTTlUUQovZXRyUWFoZjJyWHRmbkV3blFr
NWRSTW5yOVlDcHNpSlhJMFVRSG1uVmFoYU9wdS9yY3VwZDQrNnp4R0RzTEZoCjdBRmRQTjdTd3or
bWNsay9laU9OUjU1REVtTGxBM1JaSWxTS2xSRT0KPUROUzUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004e72f2063691e070--
