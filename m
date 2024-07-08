Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E0376F5
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473419; cv=none; b=agf0dFLsLpYH8IlVtAB+3CK6YMDCz7FGqnRLGMsn9QEj+3NvtycvSMW5HSgXflUTyRkzcBHWUF6PGQRp9W4F1j7sznEKDZMvXHDgGXMLnBX5Cr778JFjCu+ioqmKrtaWGKYYNNr7+vHARRS2HpqewGwPnp5XhGtWlkXWSoI/wFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473419; c=relaxed/simple;
	bh=Gvtc/vQzP5GOPzNLbxc53ddOokg4UDCUdRSzZHfjP7Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMgJ5ZaNDE20A6wlvRwpKR9olAmnb9/t/fTyIz+AWXZsz9vToKPPWm8ig4D0a0KYFyO72RBnDN6d4efVHsEQrXxIumn4nSOBzX9UaBM9CdrMCZ8UW9ILTEO6RaJRFshX3+Pvlz61UF1RMXHFLi+HUUWbrLTMahiKxJ9C6kRqRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9ykzD+1; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9ykzD+1"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24c9f6338a4so2785197fac.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720473417; x=1721078217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K2v6JpeTmyz2gSZzKCFzuZH3sZfQ1Res8Sy3C2UqB7o=;
        b=Q9ykzD+18xaOd9snq6LKwT0AIpFLDBq2YpxtEWy93dJDANxKRTawbXLF4Y9rN+lsdm
         pCp+6xZn67DNrO/qkBn1LAi+OmLDu6hmmKjCaR2U+llZs5DO6Lp/1K19vRYr8aJ/jnIi
         OLZXNX928xexIYnuorocroDczGE0iQK8LaGUojBe0Tl0YdfFYtgKdsQn955Nl3MTSeGj
         YCvdvTGMVZzHgFcjC5PaH8C4lZG1bTJktDkKHg5H+p5zFekXPYizfgkIkUPWTN9J8X5c
         C35sffv6Y9PD3EUoVIasfEmeinmBdN/TH+nxLVosTMz1ZPRe18YJzpnxJCbd8Rm4bVvX
         dT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473417; x=1721078217;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2v6JpeTmyz2gSZzKCFzuZH3sZfQ1Res8Sy3C2UqB7o=;
        b=rENZmosgTsVvLiGRJSNXBuJ21loNtpeZYxuAzKUKLR1MFABDHDntUh+Jcc201bwpz6
         hjcV0P1EkdR+ElwvsO5ZDrnhUBqpihAeVqv8OplbHqWAMj3bvSySIueuN3cKJrmObhsb
         FRKH521HmWM+tolTeBmELa3tL/ljqIuvq3Rt4BU9MykcV9R4RwvF4jS4MsDO6pSlzsyC
         J0AX4PEYZlXYmsqls+SPOkC0TgERjuHAMQlkD2Mr8KVCBuc+MrytZzZOLIsxl6mMPfTD
         LNYKcVe/LO0tF2+eL8YJMJuDA9In8knEJx4RWY8ozYyfvHt/hesUCzIZ01/+8S7SMXWc
         mErA==
X-Gm-Message-State: AOJu0YwW/O1LMeAYaEdTnR7UF+evTVnNxbZixCOS4wjLj+ru/hSDM1gF
	H2AmFJHpWVXOY/pE/rfftdsmPpDA1tZ2PLcjS/ZYvgu+DCR8zYF21h9XHMib2zJ3/srar7X10wR
	UjG78rYw1kOhe6DQhEvxZN/01bIw=
X-Google-Smtp-Source: AGHT+IEW8pbCUgyZ8QTwXHugOvuPYeTOkNS75r0Y7+hH0Ne8ma0Wxvr9vY+DFenBsvyFBlKOb3tv9zxk1zCD50UKb2Q=
X-Received: by 2002:a05:6870:a10c:b0:25e:e09:786d with SMTP id
 586e51a60fabf-25eaec3f6c7mr468909fac.53.1720473417478; Mon, 08 Jul 2024
 14:16:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 14:16:56 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7wc2ucdbirqgtrxgij3i4eqwfib334kdogbfxtiyifje6clsat@3p3xnqkoj3ic>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com> <7wc2ucdbirqgtrxgij3i4eqwfib334kdogbfxtiyifje6clsat@3p3xnqkoj3ic>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 14:16:56 -0700
Message-ID: <CAOLa=ZTuBziBPY1B0P3gTWMhqThuyFsFW1aWtwUconYN4gH+aA@mail.gmail.com>
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000e51a47061cc2ee52"

--000000000000e51a47061cc2ee52
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 24/07/08 11:23AM, Karthik Nayak wrote:
>> We don't run style checks on our CI, even though we have a
>> '.clang-format' setup in the repository. Let's add one, the job will
>> validate only against the new commits added and will only run on merge
>> requests. Since we're introducing it for the first time, let's allow
>> this job to fail, so we can validate if this is useful and eventually
>> enforce it.
>
> [snip]
>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 37b991e080..65fd261e5e 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -123,6 +123,18 @@ check-whitespace:
>>    rules:
>>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>>
>> +check-style:
>> +  image: ubuntu:latest
>> +  allow_failure: true
>> +  variables:
>> +    CC: clang
>> +  before_script:
>> +    - ./ci/install-dependencies.sh
>> +  script:
>> +    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
>
> One downside to using $CI_MERGE_REQUEST_DIFF_BASE_SHA is that for GitLab
> merge pipeines, commits from the merge that are not part of the MR
> changes are also included. This could lead to somewhat confusing
> failures.
>

I'm not sure I follow.

> Example failure occuring on this patch series:
> https://gitlab.com/gitlab-org/git/-/jobs/7284442220
>

If you notice this job, it points to the commit: 1c6551488, and the
parent commit of that commit is: 614dff2011.

The parent commit [1] is a test commit I added to check the failures. So
isn't this working as expected?

> It might be best to use $CI_MERGE_REQUEST_TARGET_BRANCH_SHA instead.
>

I actually started with $CI_MERGE_REQUEST_TARGET_BRANCH_SHA, it didn't
work, because the value was undefined.

See: https://gitlab.com/gitlab-org/git/-/jobs/7283724903

This is why I also decided to fix and change the whitespace check.

>> +  rules:
>> +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>> +

[1]: https://gitlab.com/gitlab-org/git/-/commit/614dff20119aa325661424a9fcef552e242a95d9

--000000000000e51a47061cc2ee52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: de579ca8a0bc2c63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTVYwY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0VTQy80N0ZLcm9HYjJ3bTFsQmpXNVVjU2pxOFovRwpGd0NaREJGWUdY
UW05VFlIc3RvMnJKUlNtMXNPbmlPUTl2ZXlEbCt2c0FWU0k5ZGxYMEhDL3cxc0tCR25SVm5wCkhy
aHQ0a1N3QnNtd2hGd3YxVldKNHVrY1FRTE9CRjA0UVpYcldtQTZYYkVDQjZGbUZKcUd4cUoxb2pr
WXk0R28KSFIxWVkvcENSTkQ2b1c0MEdHOFN0eG9oWVp2M2lkOW1rN3o3OXBFb3I0NUcwbDc4cnds
bzh0U0laUXBNSU10TApYbHk2d1NFMDdEL3MvOFhoY1lkbytjbk1MVm9JWmp3VHhSMWViMmVPZjM4
RkZCTWNEZ0drRkc2U2dLVDZqTWxXClRYaGZTTmZ3cEVMR0l3Q09MMGRrTnVpS0FkZ09YYXlJbVNv
WklFRjVETE91bVg3ZEcrczlWSzBndHFrUGZjQTgKb0tBZlpZM3hTc0M3SkVEUUVQZVNNanczVjN3
Y1BsU2hOVWx5N21YMXROREp4Ykc5R2plelE0dzB3c2FNMzl6SAp0c29VY3czWUhRVlI5WjcxN3gz
eGgzSEJMTXEzVXA1czlDWlNSWFhjM3JQRTRVdlNJalgweXJtdVlKYjZWNktvClpvNWt0NzhhaE9M
QUF0MXZGZDZ4dTcyMTUrMENmWHdHWGJ1TnUyUT0KPUwyT0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e51a47061cc2ee52--
