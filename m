Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C02206B5
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975026; cv=none; b=iMIYdXuyQ8t9phqMgga7su+XTHRN0o9d3pHYs0ql4w5byumq1BqrPUFEjOZbJYaVKCyCepHPG6v7l6J9QrDPaPbbMZu8Lpvjav7eHdoLoHJAwh1x8TBe2czM3Y0C3CvNTLTQoUqSLUnkyinh0NMPMxCYszgWoRTKjT2Y/1GsqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975026; c=relaxed/simple;
	bh=luqjZL1ojV958a1c1TcCxYE4ptf7KHRDWVlKZIKfSs0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=XUiHt5RpLWhfni37sVs3FsLUdflC94T/D8Y533CgYRzWyse0qxMbYcy1BbjKZoX5v++CrxiO+6ETHEADNgiiv8HEnVN09NYFKumP+6IqAcb436CPlQewOGMkRTbMcfOzra8Z6kvtS1UqCR3DeCs0gnsUbB6tmn03n8DqHVneZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il0W+8Kk; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il0W+8Kk"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so3565407241.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751975023; x=1752579823; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+cHlpbrImFA7XzleqtgPh4In61CM9Ihuv8Ash0chO8=;
        b=il0W+8Kkyt+sFFSS8j7bY1yY/mFDYbKZtkUMyvLnEbfjadHQlnrGD8pUtv2wYj9jYc
         daq4bEUdGdnZQ0TaRZ5Q2Vf6czp+25CN0PbHp8rIQyo5JVW62DF4ZTn0DEsUQ46D0HA3
         Hid2PUSKd0glo/XSDOWvEEAfKHFNQCtRjkzs1H6iNkWpDgPhF/ZD9tW3DGzXn3FFXjjM
         4DMtkHwzk0JOqczuVjPwqY/MBNwTeSShQWEiJbhd9AAPrO1WDpI1P3QRtWg5LmhvFx9s
         Y1LkCKnRuVyHRpG5OFbI3MHMe8q8nhLaLrPQfmQ9/i0Nw4a04umGnB9/IEMFIinEIPEd
         npRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751975023; x=1752579823;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+cHlpbrImFA7XzleqtgPh4In61CM9Ihuv8Ash0chO8=;
        b=vl5r8SWrS8UUWvzFCF++lpXlyfMinRPM1n0wewYpMu+jo+3QHnn9BbP4I8TLahsia8
         0ZAH5WuGX8lN6LUNYklmA8yRNRZFVqWAn/DEVGhM6XNONeKg/LikmES5GerEJPXgznv7
         8T70UQ9/vPlnMAj/eVV8jxDcJL+Lz8n28BSqJVHJw2CYQv/A62YLyxwT/wiU4f4L+O6R
         ARrVkQIIn/Elt1/7AOY0rYRGZ70PsAT4jlW++ZATngwgZobrK8uq0t3RHoQhoT00El2D
         K0SA3rMmCooU6f2X98J9F0raXle6GlLbwcAFYJLap02+3nzYshW131n03Q/Jqish6rkC
         Y6hA==
X-Forwarded-Encrypted: i=1; AJvYcCUNC5As1CgSEyYRFNCSyVouX+CVeHtvOnzo9Brxfu9NvE0BiuALIAM+nSwBnOdSJjin7tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZyxdXxJXJu8UT3w7B129XMwXq+33Nk34affW1Nafxos2JoFP
	CUonGvzO4oOsrUPk+diyfpzBTjiA9mP4RJgmgrVGfWlk4BE4RSeYxknO7zR7KDucS+8KiHsF5oV
	7xryNAh/Ja2tPdKWVg/GrISB3y42jYJQ=
X-Gm-Gg: ASbGncvk4tr9DL62R0fIR+SGQHh+nnMQ6MN/NahbD8Vp1VCLnT6QbzQ5YO5UEtiCBDi
	2Xy4ftac9RsyZTyXRhCqwjpW+vJfxLO6QNBfjcxnypD+oVMNE0CaWpRWUu9HEQ9ztpW58tyWeum
	qtWNYb8DRdS9AoxDX+jHGe7uhf1hEnr7cGFPB8lV2ptToDmoz8KC7s5nSqwCxCcV4dDVEjXc/Qg
	PJQbg==
X-Google-Smtp-Source: AGHT+IEMMzOooMv11TvcDdSimuNYwl6gVjohFVfDbiyvnnPNRQO9HhHb+AkTJvV1qiwivMHTav0OddGS5icY8k7BnUo=
X-Received: by 2002:a05:6102:6cf:b0:4e9:d847:edab with SMTP id
 ada2fe7eead31-4f34064ab2dmr1725745137.14.1751975023223; Tue, 08 Jul 2025
 04:43:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 04:43:42 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250708-b4-pks-pack-refs-document-files-heuristic-v1-1-e28d65a94573@pks.im>
References: <20250708-b4-pks-pack-refs-document-files-heuristic-v1-1-e28d65a94573@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Jul 2025 04:43:42 -0700
X-Gm-Features: Ac12FXxPfmHrYz7JasgInJywSIeNQLNy6pq5pw4XpiR-RuK3Iy-rKvUGhT930UQ
Message-ID: <CAOLa=ZSmY8ooXL1c-jE7tqjfMuz2o+wkWaV6W3_XXQFncv0JrA@mail.gmail.com>
Subject: Re: [PATCH] docs/git-pack-refs: document heuristic used for packing
 loose refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ea4a3806396978eb"

--000000000000ea4a3806396978eb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `git pack-refs --auto` flag asks the ref backend to decide for
> itself whether or not references need to be repacked. This is done to
> ensure that we don't repack in cases where the backend is already in a
> good-enough state, which is typically the case for the "reftable"
> backend that performs auto-compaction on writes.
>
> As such, we initially only had heuristics in place for the "reftable"
> backend. The "files" backend didn't have any heuristics, so we'd repack
> loose references every time `git pack-refs --auto` was executed. This
> caused excessive repacking with that backend though, which is why we
> eventually implemented a heuristic via c3459ae9ef2 (refs/files: use
> heuristic to decide whether to repack with `--auto`, 2024-09-04).
>
> The documentation for the `--auto` flag hasn't been updated accordingly
> and still claims that we don't have any metrics for the "files" backend.
> Update it to reflect the new reality.
>
> Reported-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> a small fix for our out-of-date documentation, as discovered by Karthik.
>
> Thanks!
>
> Patrick
> ---
>  Documentation/git-pack-refs.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
> index 652c5497715..42b90051e69 100644
> --- a/Documentation/git-pack-refs.adoc
> +++ b/Documentation/git-pack-refs.adoc
> @@ -66,7 +66,10 @@ Pack refs as needed depending on the current state of the ref database. The
>  behavior depends on the ref format used by the repository and may change in the
>  future.
>  +
> -	- "files": No special handling for `--auto` has been implemented.
> +	- "files": Loose references are packed into the `packed-refs` file
> +	  based on the ratio of loose references to the size of the
> +	  `packed-refs` file. The bigger the `packed-refs` file, the more loose
> +	  references need to exist before we repack.
>  +

Nice. The explanation has sufficient information without going too much
into detail. Perhaps a small nit would be s/ratio/logarithmic ratio/,
but I'm happy with this as is.

Thanks

>  	- "reftable": Tables are compacted such that they form a geometric
>  	  sequence. For two tables N and N+1, where N+1 is newer, this
>
> ---
> base-commit: 41905d60226a0346b22f0d0d99428c746a5a3b14
> change-id: 20250708-b4-pks-pack-refs-document-files-heuristic-58a9df3df946

--000000000000ea4a3806396978eb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aae8693fe700941f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odEJHd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGxMQy80bjBHNHFuSWdGOGRhdkwzZVl5bE10K0JSVwp6TE9MOTY3VHN6
VGJrNGEvK2dia0VjcFR1SnJSRnBiWDNDQ1JDRm96bGdzbldHSE80M0hNdHpFZkZTWDMzOS9sClhp
YTV4SEJqRE9Zd2ZpTUJJOEZnNkNpR3JydHFCa25OS0R4ZktQUEU2a0lzSDVIamswQkpUZjFCYzAv
MHVzMGgKL0hCTVg3QWFYNCsrT3IybjN6Z1c1WkVEdUJKQm80a1QxaTVhVTlvWFMzZEl1MHlldS9k
RTdiWjY0dGtMSWZZLworYm13YVNqaktKZDh1a2hKdVhLVE5mdjdFeGR4SGJuU1FQOS94Ri9hUGdl
S3lWc0k5S2wzNENrdzBmd29QZlk3CnZteFpJeGdqQXFYNTRkd1hkOW5rRlF6S3RMc0ZzOVVYMVB4
bGxBMmgvTms5N2M1dHFGWml6MVNDVEc3Mit3SzcKS1JrbHlQVklxT1djbUIweHFDVTFFdXdHSzAy
Q2VPVzlRSFAvd3ZQODVCT1NpYVhHMWkycUNmdFlBKy9Hd3IrVgo0VHZ3MngwTjdlNUNybytPU0VP
elVMV0Q5MGtDa1RpNHdhaUt3Q2JWUlZ4eWlUcFp5RjhHd0ZZMzREMUZlZFVaCmF6b2lYQ1NueWZp
dTBGTDJ3dlBNWWZDUmRaL1dkTzl3WlJ5ejBGVT0KPXVJNkgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ea4a3806396978eb--
