Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E414D711
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472744; cv=none; b=iqbxQqlNMxgEFNbcMwTMbL0sxGxFY0PHer0JoK34wrlZRSpJYUFe9ObDst9yW6bl0pHFDmn5keSM7r0XDLfwZvXRTpNkLk+s2uiuwlbvBJZh6eTysH+A4xHf3WkxC2FIgYeIX1RyCGlpQpR51+/+T7lt0P+BVsuK3jjT2XUOcho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472744; c=relaxed/simple;
	bh=fiSdT9yTOpyojxBIbghdXf/IBYetnmqKc4M0PAXf5vs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiFgjRfOBLSvjRuAk/VOJVAL2zCFTDjbzvw5OZKwpEW8zXQPxDOKr0UJGjKvpub+Dh8rRkvmjCejRCqzN6L2J4arM3blAopyyFs6n/pJTAPv7U9Yz12WNes5DMOSv1tDqSnJSBxh1SbLof8LRPIWEL6/R+N6MFKZoCaAos/XMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnsNzdtr; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnsNzdtr"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25dfb580d1fso2137341fac.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720472742; x=1721077542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXv3w6n7ME6xIVHZGSVBoGPejxrHk86+nNOkRlC5hVA=;
        b=BnsNzdtr9Zyi+pFaJN4bQXTD+fQEj0qVcS1Iiic9D65cWg5OsSb/iHORF/nU3S6KcY
         Iy+F3Z5tm5RFA3F9xNU0riexk2voMEQZcdaHXhwt//+m4rYlTTMjVDFJkk9zYY40Nto4
         CoAjozxMrdCqh0g8MDCzLp0bsOPMnGo3FvCKFyFw0r8z15ufRNtWMjtNP7Ey79BqeECa
         epYiGQXAFQV7KHMPueeVPtSVFoHrhqf7lMqUL44hXdvF4P5mvJFqkYmDjKfvtPxFsHUH
         LdsmTvulBN6nDle36AIoPr1z8LJjlqpTREAc/hrpXdIc4Gc7rg/v2BHarooVb/AJDkGr
         fsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472742; x=1721077542;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXv3w6n7ME6xIVHZGSVBoGPejxrHk86+nNOkRlC5hVA=;
        b=ovptX26eDGMly8p4YPjD/GEmMbigR1sbSDmrdWUFTu7JAJmrryKjkqV7DV9eOvPySm
         wfxXgGeTdsifWaoev4vUvtUEA0y40apvopKAOLnVuXJb4qaGRadN56jTCUQHKVok79x9
         P5GBTR7eV4rlMRqkFS88EM347dyOcX1Bg0E9GaQ6NQZ6SitgsI/Y/+mhhE4/51UIiWJD
         ZdLd0wykOlQv6MEoZsuQiGartm+/O7Es4GUyiW+7ahXq06LUWvzXFsA158n0+tx5AA2h
         B6tqCDctJbbL3xjm58uuKcZfHWhznm64TqJNdQ0m1x02ktJHeTyKf5J2xz2tYyNebVgG
         /H+A==
X-Gm-Message-State: AOJu0YzWJNABKibJWXFtLBIGoyFzoAuahP4ZwfIuVOkmxd7pNgs+Ssur
	vPzp62il9ZOtZXEtAaNfJPhl9lJuHXVY0vbpZ9f5cFQzI89HcvyL8gpxkefOfVg+otX24eTHYpp
	YXmXa2+Eiodfkdr3EIn1D4LysrT0em1bV
X-Google-Smtp-Source: AGHT+IFvD7Pnn2FjQtiuzcPqROsws54GlLbraB31PnCG2gpkIrIqQ63vhZh7YW48M7Zk7cMpad2DtHX/QPSyUKaIHco=
X-Received: by 2002:a05:6870:459a:b0:25d:f8ac:187a with SMTP id
 586e51a60fabf-25eaec60046mr339581fac.49.1720472742087; Mon, 08 Jul 2024
 14:05:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 14:05:40 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqr0c3hkjs.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com> <xmqqr0c3hkjs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 14:05:40 -0700
Message-ID: <CAOLa=ZTH8Zh-H7R+1=f3zvnBKFzs8Wtzh+Xxy7+aBvD4Yjg59A@mail.gmail.com>
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000a3656c061cc2c635"

--000000000000a3656c061cc2c635
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
[snip]
>> diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
>> new file mode 100755
>> index 0000000000..9d4c4089c1
>> --- /dev/null
>> +++ b/ci/run-style-check.sh
>> @@ -0,0 +1,8 @@
>> +#!/usr/bin/env sh
>
> Under ci/ hierarchy we are very inconsistent.  Most use the bog
> standard "#!/bin/sh" (which is my preference by the way), but
> see what we have here right now:
>
>         $ git grep -e '^#![a-z/]*/bin/[a-z]*sh' -e '^#![a-z/]*bin/env ' ci |
>           sort -t: -k2
>         ci/check-directional-formatting.bash:#!/bin/bash
>         ci/install-dependencies.sh:#!/bin/sh
>         ci/make-test-artifacts.sh:#!/bin/sh
>         ci/mount-fileshare.sh:#!/bin/sh
>         ci/print-test-failures.sh:#!/bin/sh
>         ci/run-build-and-minimal-fuzzers.sh:#!/bin/sh
>         ci/run-build-and-tests.sh:#!/bin/sh
>         ci/run-docker-build.sh:#!/bin/sh
>         ci/run-docker.sh:#!/bin/sh
>         ci/run-static-analysis.sh:#!/bin/sh
>         ci/run-test-slice.sh:#!/bin/sh
>         ci/util/extract-trash-dirs.sh:#!/bin/sh
>         ci/check-whitespace.sh:#!/usr/bin/env bash
>         ci/test-documentation.sh:#!/usr/bin/env bash
>
> Unless you have a strong reason to suspect that in your CI
> environment /bin/sh is an unusuably broken shell, please do not
> spread the inconsistencies.
>
> I think the consensus from the last discussion we had was to allow
> scripts that rely on bash-isms to say "#!/usr/bin/env bash" because
> we know /bin/sh can legitimately be not bash and we assume bash may
> not be installed as /bin/bash.  As all of them would run in the CI
> environment that we have some control over what required packages
> are installed at what path, it is OK to assume that "bash" would be
> found on the $PATH by using /usr/bin/env (but it does assume
> everybody installs "env" there, not /bin/env or /usr/local/bin/env,
> with a bit of chicken-and-egg issue).
>

I must admit, I didn't put any thought into this while writing. The
usage of '/usr/bin/env' is mostly muscle memory and since I didn't need
any bash-isms, I defaulted to /bin/sh.

I'll change it, thanks!

>> +#
>> +# Perform style check
>> +#
>> +
>> +baseCommit=$1
>> +
>> +git clang-format --style file --diff --extensions c,h "$baseCommit"
>
> OK, "git clang-format" compares the working tree with the named
> commit, so if we have the tip of the topic branch proposed to be
> merged checked out and compare it with the base commit of the topic,
> that would give us exactly what we want.  Nice.
>
> Thanks.

--000000000000a3656c061cc2c635
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48d61394177d25b5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTVZLSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekxrQy85bml0MzVQUUFkVk00V1Z3RHpTTENQUVFseQpKS1ZhUWs5b09q
dDg3bVhPenBRQkRxSFB6WFJNODMxeWlUR2J3elQ0c011a2NLZFZEVlJ2anNhWXl2Z3hJb09YCjYz
eTN3TU56R21VMjBKakVuQkJoSEgvdHo2SkExd3pBWkZUQXBmZGxSc2pTUnA3RzRiZWw0QUVyaXM5
OVNIT1kKUmdvMjhocmVBSGduVjJsTWU5a090akxSQ0dyN0RiYU9HRThsbnhyckgraGhSRkVibThL
VUF4cHNFK3IvRnJqcgpOYzlvOHA0MHhwNHFyN3U0R0hEblE4UnFmSEZpeU1hNG1GcDFsQlIxemNE
MDB1dE1EeURsSkdDa3VqRllGc2pBCm9BZ09yRm5KeUFUUHdSSjNpUmpyODlML21PWnkzT3R2dTFo
MHZGWTh5M3F3UjEwM2NCeUZxY3RaUVN6dUdWeGQKSGNuKzMweWNDQjA2ektuRW01VkN4OUZPTCtU
WURPT3ZtZytXeEs1TWlHSGUzK3RlSytDTGhuRG5wKzViUDhyawp1bUNESjlFVzlZT3NtajFydjd6
bHJaMFp6YnJJZDdzcEZpWkRReTRXc3k1MWtsOW1Cc1laWnRtWW9IdVFwRS9hCkxFOWY5Tk1NbkRE
UmZjdjFtOUp0eVJ5LzUzUWpySXZUOWxNK0xQdz0KPXFZdmgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a3656c061cc2c635--
