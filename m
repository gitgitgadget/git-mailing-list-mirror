Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094091FF7D8
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485594; cv=none; b=VuBqqIPabsuER+sT1qnXE5y7KvyLltxrpcapfxtz6k5nFZOim6VZdQcij8wEV23wK9ZyOZEmvgJibzyl/qC7bY/02MfBX9I9rQqH5QnLePbXAXjoU718Or0qfYGAXAPLtrc/Hf17rY4dz4Zc0X3Hw0a9zbE4MnytRR32NuFjlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485594; c=relaxed/simple;
	bh=8CZ5udlnu49ix6aM08ybcRo5oooPaQt/3QWkWFJyg/A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ixYROMx6H8etGcn5rJXMRzgUhOrUz6HXREQrgZqOC+UQxd2mxkrtdvaF1bBCh7U2EHqF7S2ypTurbcdDMqnwdAwQhrjsoMD46HkF9AoqBJ8vh/nu2OXuhh4HyqcQGvUHsykdmGWvB9sNXbGQ7wy3/rmh8KrpbFYEhkBi5fsA1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkXNTvJV; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkXNTvJV"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85bc5d0509bso419624241.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733485592; x=1734090392; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAv9yZyBl22Wu6mSD8Ir/FpaoRQW6xO1j/5w9Amnjk4=;
        b=WkXNTvJV786IHE9q6sqK0Ymlk1sQePfW7s/vgXI1Td8vKyB/KKY/UipqhEe1vcP2JV
         9Fu/QyrrwVVxyHXrVeFtX177AtJ7oO/KrRpay3PsZRz6je8dmo+1/dMLL91neWVUVEKx
         qYdXksGRWi7DRK0rMnnbvbbKDBjDnJF0yuYOhwiEJqjtvf9TD+qgR7+E/wxqGguSgAxR
         1PWRWlBeLl45nM1iEDaFRQ0PC91w2lykEo6DbLM/0U0MmlHQCtYi3RUdaeHg4IY7hghV
         Lqo8Hrn6aE3yrXLEjQj4ahpLEQD5s4HS5vSo5Pwn9SgWCJp0N63bcXa7CEDkxp6G6FuU
         7BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733485592; x=1734090392;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAv9yZyBl22Wu6mSD8Ir/FpaoRQW6xO1j/5w9Amnjk4=;
        b=ngWi5SX8gx3GmmLejzm626adJYG1NwknYhPpP03LdQV77PgJrLIQptW4YNFozybVB3
         O382Owsw3nay5bhk64aPERQ8kRfOglcp9NeNUINHfo1tFFU1mV1h6bsiAKnaNLdsc4j7
         WXOuSWpMA9D+pWoUEeu6EWla8iywdKQbINrY2ORS56tfqMTdASCgqKrkfUW1UC1mFJGz
         DAPyLvKLBKlwzapJjfxRuRFDUdFQCYz63beUcPO08f5hNnLLAT+Tr/RUd3moNbgKuu96
         aFROtg3quH20qyoAhjNkw0nOpsPH8ptoKhmEZL+S0b2Hv45SIWMeRHTzqM2UQ2a1q+R0
         LXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMYPa6BrApQwDfXAfqOmoMGh39SQpyETC5kVo+YiPCRg6qpvz72HYqpgMUQ/kTXviRqvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJVt+fFbfXfRwPC6eaalt/vr5+X9PzhN6WFV7q0YtIConwgyc
	s8mKUkmq4WjhJQKOAdFasDDMoHok9Ma3RgDTnecxc8F2Iron8Xs5GmhY+vF9RqAudW6jYDH6x4H
	lqi4oMYSrhirOjop+7Db6i9hloVdTzuOG
X-Gm-Gg: ASbGncvzbq3NP4VYLVgDp6hcD6DNbtZ3UklxSdprD1NPf47WJ5bigtNJfyqO1oo/rYf
	rkzMCg8iTA3UsefFa7z/WN7TwjwRXPQ==
X-Google-Smtp-Source: AGHT+IFKFjahqTchCdban4lKmcOHHdLL07W/mcawD+BpyXciSJHy+rghhqyCA5diQN1Ww0OjILLp23tY76MaxgxGDmY=
X-Received: by 2002:a05:6102:b05:b0:4af:c31d:b4e9 with SMTP id
 ada2fe7eead31-4afcaa3cf78mr3173340137.13.1733485591881; Fri, 06 Dec 2024
 03:46:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Dec 2024 06:46:30 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241206-pks-ci-section-fixes-v1-4-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im> <20241206-pks-ci-section-fixes-v1-4-7ab1b69e3648@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Dec 2024 06:46:30 -0500
Message-ID: <CAOLa=ZTdpmfKfuLj9PcXuO6_EqqR-2V4y8s2mpR3iXAS0sT32A@mail.gmail.com>
Subject: Re: [PATCH 4/4] ci/lib: fix "CI setup" sections with GitLab CI
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ed9701062898906d"

--000000000000ed9701062898906d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Whenever we source "ci/lib.sh" we wrap the directives in a separate
> group so that they can easily be collapsed in the web UI. And as we
> source the script multiple times during a single CI run we thus end up
> with the same section name reused multiple times, as well.
>
> This is broken on GitLab CI though, where reusing the same group name is
> not supported. The consequence is that only the last of these sections
> can be collapsed.
>
> Fix this issue by including the name of the sourcing script in the
> group's name.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index ba8f4da39caf29db5edaffde160bc81a7c58c329..2cdc99e7fd05650ef80715b621b42d15d6b13a12 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -55,7 +55,7 @@ group () {
>  	return $res
>  }
>
> -begin_group "CI setup"
> +begin_group "CI setup via $(basename $0)"
>
>  # Set 'exit on error' for all CI scripts to let the caller know that
>  # something went wrong.
> @@ -393,5 +393,5 @@ esac
>
>  MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
>
> -end_group "CI setup"
> +end_group "CI setup via $(basename $0)"
>  set -x

Nice. Before, only the last instance of "CI setup" would be collapsible.
Now that should be fixed.

Here are the links for without and with this series.

Without: https://gitlab.com/gitlab-org/git/-/jobs/8565481567#L20
With: https://gitlab.com/gitlab-org/git/-/jobs/8567031049

--000000000000ed9701062898906d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a4a81a18ce04a208_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUzVCVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2JCQy85blUyNG4zNTM5ZTdRS1hWSGZpMDFRdFZYOAphaUdRc0dtSi9M
R0xRNitvRlo2Q1RHV04rQi9pMG5MN0hVcmlMczZSRGNoY3NRRmVZeUhUYk93TWZoczJOWmg2CjlJ
bzJyemFuaU1uSzIwT1UrdXc5WDd1Sm5lL3RyZzRJaCtCOGZaZnhXb3RlZ1BWNy9KUjdUaXlxOHJN
LzdCTTMKNWN6L3c0OWNDYXRFRUhJck5mNFhPU0pONmpSTFBBTkJVOTA2cVpuamYwcVFLcWFwS0Jy
MGZCZytiaUdhL2h0ZgpKdFRCdVZLQ3FoeHduUG9xOURLVmkxdHJWbjVKU3NkTm9oNFZ5eWphVmJK
OTZDQzhsV3NXYUZ4RC9BanZINS9NCit0ZStpWHlJM1JpL2hYOW95VFNvTkFCOEVoWHBVeElzN0NS
YU0rWlpJWUorWVhmSm1HZ2d2RVJlOEREeXZwczgKK1BRR29FMVNoT0VYRWNyRWR1bEg0TVBPKzZ2
eklmcVlWaC9kdXVhOWU0YXVMQ3Vka2NENmxoZnkxUzB6RnA3cwoyV0N3Y2gwUHdiaTRVTUdRbmtM
bzd0bXlDUlVRaElaMVlDeEE3V0lwakZ6MmdPYy92bzFGNjRCUU5KeDl5WFFBCi9lMkQ2RDNiRUdT
VFE2R2hvbGlCV1lhOVgvZkJ1YnJ1T1Z0eHZKMD0KPVg2eW0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ed9701062898906d--
