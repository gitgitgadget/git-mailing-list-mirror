Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2012C530
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618719; cv=none; b=WVMqv2XjeBfNE+Fb3hqK+g8iXhKkc1obvMXHI1aHImZfhgMcZQCucuTVYMeGW4aRHJVHwNUKAFCgAsz5F6w8ATfOvrsxG4pvxvOACJb6nY3DuKJ3nbkOoaioCoJX7M7GNOUlCTK5rphSaTcBC5PNTT5dReD9b1QPGk56lCjn8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618719; c=relaxed/simple;
	bh=oFf5xuZP+UzY1mxPZTVk0ft617QOD2SRVXuizwV0bT0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z62WoSCUWy2gHAkD6AvKVO2b0kde6Zoqk3Gs/hRSLAvXzTRiUhenQjjkAheDV16EGf0xNn5uqaQopqGztuhujiHKK3mbSl3rM7tMmaW0WYAAef7AVs4/ZH5SI9IxyIvRoF2+2o4HaiJwc5zDDyJjI1aMSX4R8nwP36eCO8hwh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5gjDcSN; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5gjDcSN"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25e0663de76so3045116fac.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720618717; x=1721223517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=asR8NSBhHDssxaCX1KC2sjGGwhpqN1D2Km5fs9vGsfQ=;
        b=D5gjDcSNSoXx6iXOe2kDOEmwzsHz55mhJifCZMdmZqopwHf4AueM3OFJJeQPKZIQHl
         Dm8EJxNOhX+QrXjXmkNcB596VwJbYRyR/VV51emAx8BkwXdU+bcrl3jxcSZ4qF54q/8g
         EjzH+wywXR7BrXzoZ8NrSGJYZNaOM+bUccdYrpRSiyZSJQ7JiC3sSQHZFvgAyFHvMgSk
         /osKbwARdqqk4CyJCSBNeIL5PZQ5yueTTYoqvNJ7Wt+1zuCQ3LRCkYNJoWT3qTMZk/Gj
         O37zTcmle+E3WLAO/IhW5AZ2l+gcIKkHUyfcsAEFugZYAdA/6ZFWgvgNoPN575JPjIVh
         OCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618717; x=1721223517;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asR8NSBhHDssxaCX1KC2sjGGwhpqN1D2Km5fs9vGsfQ=;
        b=Bt8vqEeQWPPzqO/CIkPOop5k9mCGvNCqZV2jxyCDJDulw37NbBRBqGvYZjJ7ybnVrk
         dFKqqfCxv6FwcndmpRt7vKwuZHsoZNK4UPWyijh1xDYD995E4zx2ahSUXYxjKJ3kTRvv
         dfh07AT+bsPlVQoBekQ4QlUbCHdBmeUs6F7RDSbtIe28M+Ua9j7zvD6hxRW0FzOwyUmH
         CefHwkULkB7cigpo95XCWEEcKJmu1FaTmWGA8GOgFnKCqPlpEfaDGhoH2bMdqRe5WUG+
         bQ2kriogWBOAcPdut/7FDeH6nytS/CSWOmfuS3+dkJhE2PtewkLyHHKmHqUCviltN9hK
         n8hg==
X-Gm-Message-State: AOJu0YykgXhJ0w9zwqeFt4f4gDzGD7q+g+dx0ORGgmaaZopqklBfckTQ
	5e/WAQEBP2Aq2KpIbVpxfeshn20SFHXOYJXkIJHl0h+31gLfLi2j6faR6KMwO9zyiJ5d0N/OSBP
	IvdsuLQ0BJ6sYimy/G52Fzed2ELfz/4wA
X-Google-Smtp-Source: AGHT+IEoQW2hAls+qbv23QrDAj9bsSUiwsv87Rfu2+6MAm20ZnOixH83qXCMlB/ORues95kMf3gRsVnSLcBmAp/lFsg=
X-Received: by 2002:a05:6870:a10c:b0:25e:11f4:f691 with SMTP id
 586e51a60fabf-25eaebdb73amr4768176fac.47.1720618716722; Wed, 10 Jul 2024
 06:38:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 06:38:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <q4mixa3suepyjrp5lkd3wio2pcsdbjch757n2p55fzxpk3sc4u@lysauvdyiq4c>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com> <7wc2ucdbirqgtrxgij3i4eqwfib334kdogbfxtiyifje6clsat@3p3xnqkoj3ic>
 <CAOLa=ZTuBziBPY1B0P3gTWMhqThuyFsFW1aWtwUconYN4gH+aA@mail.gmail.com>
 <lu7o24bwwh5ntarnpfjkmceuvzxs6rdykcrojonqkhfcvq7vka@7h3rev4n7wxr>
 <CAOLa=ZQiHcCU9G6BFO98Y1VAPYgTDdJzbWC5bnMQwx9jsTJ0tg@mail.gmail.com> <q4mixa3suepyjrp5lkd3wio2pcsdbjch757n2p55fzxpk3sc4u@lysauvdyiq4c>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 06:38:36 -0700
Message-ID: <CAOLa=ZQZchY=1crbF8xjZknJkJ1feeR80Swk0k7TR530Gw_6FA@mail.gmail.com>
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000006791cf061ce4c3d4"

--0000000000006791cf061ce4c3d4
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

>>
>> You can see the output
>>
>>     $ ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
>>     fatal: ambiguous argument '': unknown revision or path not in the
>> working tree.
>>     Use '--' to separate paths from revisions, like this:
>>     'git <command> [<revision>...] -- [<file>...]'
>>
>> This only happens if "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is empty.
>
> Ya I noticed this failure, but was wondering if it was maybe due to
> something else. I have been unable to reproduce it and in all the jobs I
> was running resulted in a merge pipeline with the variable defined. But
> maybe sometimes a regular pipeline gets run for some reason and
> consequently $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is not defined? Was the
> pipeline triggered directly from the source branch?
>

Just a regular push. Not sure at all why this happened. I was testing
different types of style issues on the CI and this happened once.

>>
>> > https://gitlab.com/gitlab-org/git/-/jobs/7291792329#L2470
>> >
>> > Do you have an example of the check-whitespace job failing in GitLab CI?
>> > Maybe I'm missing something, but I don't see a problem.
>> >
>> > -Justin
>>
>> So I think I get the issue, GitLab has two kinds of pipelines it runs:
>> 1. merge pipeline: Here the pipeline runs on the source branch (the
>> feature branch which has to be merged).
>> 2. merged pipeline: Here the pipeline creates a merge commit using the
>> source and target branch and then runs the pipeline on the merged
>> commit.
>>
>
> Correct, this is my understanding.
>
>> And "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is only defined in the 'merged
>> pipeline'. If you see the pipelines for my branch on GitLab [1]. You'll
>> see only one of them is marked as 'merge results' and the others being
>> marked as 'merged results'. The former includes the job I mentioned
>> above, where "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is not defined.
>>
>> I'm still not sure why it marked only one of the pipelines as such, but
>> this means there is chance that it could happen.
>
> Huh, I'm guessing the CI job must have been triggered from the source
> branch directly. Did you manually run the CI job? I wonder if that could
> have caused it.
>

Not that I remember.

>>
>> So I guess the best outcome is to use
>> "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA", but fallback to
>> "$CI_MERGE_REQUEST_DIFF_BASE_SHA", if the former is not defined.
>
> This is exactly what I think we should do too. For merge pipelines we
> will want to use $CI_MERGE_REQUEST_TARGET_BRANCH_SHA so that only the
> commits included in the MR are scanned in CI. If that variable is not
> defined, it makes sense to fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA.
> Since it's not a merge pipeline it will only scan commits included from
> the MR and therefore work as expected.
>
> This should handle both cases correctly. :)
>
> -Justin

Yeah seems like the best solution at this point, let me implement this.

--0000000000006791cf061ce4c3d4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bb72b466e873201a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT2p0b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3NIREFDZHZRMnREMkRpY2JPaG9mN0paV1R0YjZBZQplcmp4M3BSd1FS
ZnYvV0haUHBxaTMvblViNldHQWltcGZZMFBZU1hmemh2UnVqT0NWVkF3dmNidU91VGxoZGNoCmpz
UGpHWUV0dlZESy9KVmUzOXBKWUVqSlJTT3NoMEhybVZSY3JGUmxOWitSeXdFQTBOckhXQk1ReUgx
c1IwYkwKdXZ0UmV5UlB4NHhUb0d5Mmdqc0NHQ2VxblhCbGlraEgwZ29FRTRuS21IK1F3bEIwZFp0
K0NVYnptcUI2aTBvbQpOSE5JeGhqMk8wTVhSTytjcysvMnZ2WWl1Ym5nQlRZdUl5N2p6RzBNMDF5
WHJUTzdzQ1pHY0UrbGpjOWNDb0l1CmI1eUgzeVpBNGFNWjhpQ0NXZEozNU5BdVA3VXhQN2hrYVYx
VitZT2Z6dnZxNkVtbFNRQktXd0NmMEZYYVZOR1YKczQ3WXFjS3RTOG9ya01UWU0vdTdEQWxlODhp
aE9NeCtrdzBGVUpqOWJLZjgreEYzWWN2NVdBNnJUOWxQemVRbQpOYzNvTHdzZCtsSWFNSThUYnZK
aUNaQS81Zy9rOU5HaE05SjNjb0hNcW02MExlclpsNG0xNUpjdGJKM3ErK3paCm52QjFxcEE4NC9J
ZkI0N0FtdUQ1TnY0dFdTZzVZaG5UeDdOaEkvVT0KPWJFdmUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006791cf061ce4c3d4--
