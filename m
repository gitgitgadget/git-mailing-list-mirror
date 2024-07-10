Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DF193450
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620747; cv=none; b=XJ4S3S9AGcbiFluVMM9LZMpJHLQdR4ofB1gOsk8+uyFyNh/niOYB2UOtD8wXKbB5AfZo9Q7neGgOj2IymQUFbv1TmvPcEbMBeashSbZOndbh/TVMNYTSE4vA+JjooCCvATsAiUgNrNPF6h3MswSSlCBWzJp18g2iCxikDsKYSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620747; c=relaxed/simple;
	bh=1sCiVDqSgOXb+eyuBi5VjwIVHSR3n923mtLQiUNMq0E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Muaqo3hix9h8NGZbEN9/KkLzYiRI23XsX4rwK5BThH4Qc2hFerTxp7/Jmp95yUaZLr1ffeo+m8ZCrZ02c3OWaVlOcRTgG0FU/iWJwHXBaYxH+9s8mG6EuEZFGmPZlIg5ETGkmmpj6wTjQYzEMh8NKUozySiVfjBn0e19ZFynUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyYmh44W; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyYmh44W"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260209df55dso498340fac.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720620743; x=1721225543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ0WvObysavrCvyumgfC5aeDe+jFoQ+H3YtiVJbi/38=;
        b=KyYmh44W+3ufYAmKclVW3Rg+jQDQ/NdycWSoza8HqcIvrcv/iNCoLVAT8NbG3/6m/c
         sMBhdMmFIymtGC2zreN/M2HaoUUhcE6YHZRJrfVZy/0HP9w3LiV4zBm4EYre5CXHKaTt
         +QRL7kS/5unn6uNnzc9VGpUQk+0bvAN2p0y9XMHcpJSUKtlBxtJHjbFx3jVqYC3wcoQA
         ZXo5KFxy6RiWKNdPD1c4I0vAzBX03V6jCti2trbh6ljx1zU2szCzUIpRS5CeGg5icc+V
         usFP2Su0UTQkMXI/XkAS6bgSLahx6lX0a2HgCoq7SSnd9kmmX4M49br02X74+U+kgNel
         kGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720620743; x=1721225543;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ0WvObysavrCvyumgfC5aeDe+jFoQ+H3YtiVJbi/38=;
        b=hmUajgC4aozVKqzof6RpdTob9ghOJRIudyNGtfTvuu4BA4Qsy+4LARoGfDnPBhoVM1
         dt2U3O/dAEVI25BLjS2OMxjawbPPYD7Uhl49XiCHDOd0fzmMXPF8PSOH5oL/pon3Aezx
         TM/FwHW72I8xjL1bwT9D/Srb7RDLLNqYDQAqoKFJ22MypyC7kx6lRyjLVpDAhRlwMLCO
         zeb2q0EYvjkq2ClN5tNDDf1Op28H42Z4BIVTPxxpZydCC9Vd81lHGrglEyjWqye72wy/
         KfOpnAG3Udd5zYUUqzHp7RZQVwu4yMf0+IN5X27nEMrnhbYbZ4LB0/18XMkWYCLye0M/
         QqzA==
X-Gm-Message-State: AOJu0Yzw6Nd5lHQvkdw3dM09ZifYjsZ20O4fHyq4cGEgExEs0ZQh4Ftn
	9DXThxpM1UiAzkN3rAv9p4ll8Z+2kkGSBCIY9GvKlRFYLfZ36UDtbAO9b4yYNUYJfK1n43HxNaB
	MhRCkzEfpdbbX9EAC24Ji84HK4ZE=
X-Google-Smtp-Source: AGHT+IElWT3PtpHxm3YzjWgUFE+XeUwT96fIAZpUFevcXKyIOQk74EoWSD8m5YmKGc04n+XwFo+nbC++BIbLtORIqyI=
X-Received: by 2002:a05:6870:b69e:b0:220:873d:dbcc with SMTP id
 586e51a60fabf-25eaec8a67amr5133342fac.49.1720620743119; Wed, 10 Jul 2024
 07:12:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 07:12:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <tl66b35ytbri4dep3cnppdexebblep6avyuhj4moc4mnsolnp2@xpqqwyl4oo2y>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-9-karthik.188@gmail.com> <tl66b35ytbri4dep3cnppdexebblep6avyuhj4moc4mnsolnp2@xpqqwyl4oo2y>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 07:12:22 -0700
Message-ID: <CAOLa=ZRHq4WarzBiNu9gxWxT=Fe8D0TZ00pLngXuqFUZf1j==w@mail.gmail.com>
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000002fef4a061ce53cb9"

--0000000000002fef4a061ce53cb9
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 24/07/08 11:23AM, Karthik Nayak wrote:
>> The 'check-whitespace' CI script exists gracefully if no base commit is
>> provided or if an invalid revision is provided. This is not good because
>> if a particular CI provides an incorrect base_commit, it would fail
>> successfully.
>
> s/exists/exits
>
> If no base commit is provided, we already fail. Here is an example
> GitLab CI job demonstrating this:
> https://gitlab.com/gitlab-org/git/-/jobs/7289543498#L2370
>
> If the base commit does not exist though, it currently prints that error occured
> but still exits with 0. Makes sense to update and fail the job accordingly.
>

This example is running on the 'edb990d9', whose parent's '8d9bcf0a'
parent '57fdb00c' contains my changes, specifically the `|| test -z "$1"`
section. You can check this on master locally though.

    $ ./ci/check-whitespace.sh ""
    fatal: ..: '..' is outside repository at '/home/karthik/git'

    $ echo $?
    0

or for invalid value:

    $ ./ci/check-whitespace.sh "random"
    fatal: ambiguous argument 'random..': unknown revision or path not
in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

    $ echo $status
    0

[snip]

>
> I might be misunderstanding, but this additional check seems redundant to me.
>

It is required, as commented above

>>  then
>>  	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
>>  	exit 1
>>  fi
>>
>> +gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)
>> +if test $? -ne 0
>> +then
>> +	echo -n $gitLogOutput
>> +	exit 1
>> +fi
>> +
>>  problems=()
>>  commit=
>>  commitText=
>> @@ -58,7 +65,7 @@ do
>>  		echo "${dash} ${sha} ${etc}"
>>  		;;
>>  	esac
>> -done <<< "$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)"
>> +done <<< "$gitLogOutput"
>>
>>  if test ${#problems[*]} -gt 0
>>  then
>> @@ -67,7 +74,7 @@ then
>>  		goodParent=${baseCommit: 0:7}
>>  	fi
>>
>> -	echo "A whitespace issue was found in onen of more of the commits."
>> +	echo "A whitespace issue was found in one of more of the commits."
> There is another preexisting typo:
>
> s/one of/one or/
>

Thanks. will add

--0000000000002fef4a061ce53cb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 36d6371df7ab5a56_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT2xzUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGZaQy85cG80YUlkc0d0eTZ0cmc0czlBVVpHcG5YYwpJUDRuMUV1cTUy
cTFCSGZPMDZmNVhPUUlQUUJETE01ZC9pT0NUejhoWTk5WG1ZK2pENGFHRjdiTThSN2JyTnJQClRI
Nk9iRlhmMFlvMzRuM0JIV253VlRXaEw5NEpnOUtHNThCM1BQaVc1OWh1eEI0S1JlS0VLYjEzelVo
TUNqOG4KYzcxZW10L1dzSW5sd2lTMmJ6dkVRRVNHSnRWengrOUVFdzVYSTlmaGxUSEdoRHVkVk5K
dUlvaFpHWTdoUXp6UQpvOFg0cUtPTVNWOVRaTnk2ZDBDNWs0a1c3bGYyOVlwWk9wZ3N6M3RyYlVi
SUpiS0dMRTQ5K2tOUUFXcFljSXZPCkVNVk9VVmk5c2w3ZU12cXJCcGNRQzdveXltWEhjSTlYa1FW
NTZUQVJMdEF0TEJxK1p1Rm5pS29wWmFwRkJ2eHUKNnI2c3BRZHdZb1RpOFRHRG8yMHloZjh0R09P
SUlGM21qVXg2YXgybm1BOG44bXdta04zb1lVZUc5TVpYWDNSbQp1VEkyK3BoOERUUjQvZUxHZVRD
NEN0dFY5dUxiWlVmenRJcVpvd1dxUFkvM2JIVlFoNitNTHNlelMwMXZqYVVvCkgzRTRySk5lRGU5
dWNSUUp4OFBEMmFZMFhHaWVRMUVOVEY2ZXVDND0KPUZwZDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002fef4a061ce53cb9--
