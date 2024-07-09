Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DE149E13
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514665; cv=none; b=sGHXiEWw+XRHHxu0lx5U2BxZFlI5AKwR3kQvx6F0esvmq6w1+Uh60xUWCpnDauSaQ1K91wnMMdvTVGC0pCIsuxx7rc3qiH5tdnLYZnRLbwiOHEJQACLE2c2VQkGy4ISZNZEU8d2Jo/SIZsc+CE8+GkK2yeBbE9Xi3yBcKtWqc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514665; c=relaxed/simple;
	bh=KGAbQpBYa4Ibhft7ryNPoJnwl95GZXDFqwt2l83yBVk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJ2nzPKZnOKGvAxaEnE9TUjcj59q3H4ktFpOqLdYD+j5Ys7x/KnWXapsLMj+RRzEQszHlLJBWgjyzoY1PTMnaDoOoGIp1UZEzYl1r8j0op2/Y+X6CwDcYo1FqxUhdIiypIFXwo0gzD1bWImKB40r1WOrjvd22Oe/O8rSld+ROyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtKnu2qS; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtKnu2qS"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso2290701eaf.0
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720514663; x=1721119463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm7fyGjKT+HfUVKB9QK8Ct66SmsCgLH5UUxalFTHj8k=;
        b=mtKnu2qSFMqBYFc7yPrvivaikvtj1d91UB1gRWIYN9I0sdeVZKkXtpuKi38dxRJpNz
         0nF0ycjlpBtN5ALlBiKeWkDKZs8B+pTL+zgGC7YQKeUh7cMHjVsA2QuP5wv+myVdLUxb
         hbT+FQHHLx+S4IVBTD3T6E88PeO4mjbX1c3OTE7hvHHUiPYIoomK7GxKQ1lp78dKLDY/
         ZIkj/fVbd7m+EwNp4+yEuBTIL8P9r5qAK1dALWAtVGhKyDaZH2qNcwK6iTu00R7dWC0q
         Fha1pr/rmQ1N7PmJeHdoXN6dc72lLj9tMgbcC2DiZ32G+B86SnZUfPE0Hziq+bXTppUO
         iyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720514663; x=1721119463;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm7fyGjKT+HfUVKB9QK8Ct66SmsCgLH5UUxalFTHj8k=;
        b=OqBx/rIP1NofhinlubFbM4I9YzFrSn1pWZND/potLpxJ/10O58LcFrHPIeCVNxjL9J
         6uvqN7swI5pHLojKWn9vuLfiJGKoc99rq2U7MWozKY17P1uEfuBNt0Qs3XuRXqNAVJOB
         VYFT1A5AxGtrKahOKFhMkoId+4n2EEP0ha72N6+oN29jPA7y5syHF7BhEypgTAiSDFUP
         YLh5wU1AvAIMqcbI2OZw+guhCnhJBkvsKxC4/eTJ7W4YO2vFEzsg53A0woKgF/0FEHe3
         j2YCrIf4YbnNRi3AFxOOUEcDKYLXKXbYv2GG4x86Ex/l6m0T4bzbNCps7sZtIThPsw3W
         00Kw==
X-Gm-Message-State: AOJu0YyMudC7ujxrAhHtUoWXtN4YE0Aq3JcRdxJ7LFSx+qb9AMSv/utT
	cR1FiYIhxtmy9LMgzIrh/58LRNcB0xX53zr85evg5W1RUF7QM+V4aOs4UDeiP+q9r8iohKMtTWA
	skk5hSpi0TcuxAPtCrkBub+sw3qicYBo8
X-Google-Smtp-Source: AGHT+IFzx076cjAw4++iUx85D8s2ea7xbP5jNoFdP74a32f5q06WV7NyWPliRwMVSETONB1OmPQgea/7AUXDamOaThc=
X-Received: by 2002:a05:6870:658d:b0:258:456f:2fa5 with SMTP id
 586e51a60fabf-25eae75e6fcmr1517574fac.7.1720514662675; Tue, 09 Jul 2024
 01:44:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jul 2024 01:44:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <lu7o24bwwh5ntarnpfjkmceuvzxs6rdykcrojonqkhfcvq7vka@7h3rev4n7wxr>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com> <7wc2ucdbirqgtrxgij3i4eqwfib334kdogbfxtiyifje6clsat@3p3xnqkoj3ic>
 <CAOLa=ZTuBziBPY1B0P3gTWMhqThuyFsFW1aWtwUconYN4gH+aA@mail.gmail.com> <lu7o24bwwh5ntarnpfjkmceuvzxs6rdykcrojonqkhfcvq7vka@7h3rev4n7wxr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Jul 2024 01:44:20 -0700
Message-ID: <CAOLa=ZQiHcCU9G6BFO98Y1VAPYgTDdJzbWC5bnMQwx9jsTJ0tg@mail.gmail.com>
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000004ccf23061ccc892a"

--0000000000004ccf23061ccc892a
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 24/07/08 02:16PM, Karthik Nayak wrote:
>> Justin Tobler <jltobler@gmail.com> writes:
>>
>> > On 24/07/08 11:23AM, Karthik Nayak wrote:
>> >> We don't run style checks on our CI, even though we have a
>> >> '.clang-format' setup in the repository. Let's add one, the job will
>> >> validate only against the new commits added and will only run on merge
>> >> requests. Since we're introducing it for the first time, let's allow
>> >> this job to fail, so we can validate if this is useful and eventually
>> >> enforce it.
>> >
>> > [snip]
>> >
>> >> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> >> index 37b991e080..65fd261e5e 100644
>> >> --- a/.gitlab-ci.yml
>> >> +++ b/.gitlab-ci.yml
>> >> @@ -123,6 +123,18 @@ check-whitespace:
>> >>    rules:
>> >>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>> >>
>> >> +check-style:
>> >> +  image: ubuntu:latest
>> >> +  allow_failure: true
>> >> +  variables:
>> >> +    CC: clang
>> >> +  before_script:
>> >> +    - ./ci/install-dependencies.sh
>> >> +  script:
>> >> +    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
>> >
>> > One downside to using $CI_MERGE_REQUEST_DIFF_BASE_SHA is that for GitLab
>> > merge pipeines, commits from the merge that are not part of the MR
>> > changes are also included. This could lead to somewhat confusing
>> > failures.
>> >
>>
>> I'm not sure I follow.
>>
>> > Example failure occuring on this patch series:
>> > https://gitlab.com/gitlab-org/git/-/jobs/7284442220
>> >
>>
>> If you notice this job, it points to the commit: 1c6551488, and the
>> parent commit of that commit is: 614dff2011.
>>
>> The parent commit [1] is a test commit I added to check the failures. So
>> isn't this working as expected?
>
> Ah ok, I misunderstood the setup of that CI job, but the problem is
> still present. Here is an example CI job I've run demonstrating it:
>
> CI - https://gitlab.com/gitlab-org/git/-/jobs/7291829941
> MR - https://gitlab.com/gitlab-org/git/-/merge_requests/174
>
> For the MR that spawned this CI job, This patch series is the source
> branch and the target branch is a version of master one commit ahead
> containing a clang format error. Because this is a merge pipeline, using
> $CI_MERGE_REQUEST_DIFF_BASE_SHA will include changes from either side of
> the base commit. This means it would be possible for the CI job to fail
> due to commits ahead in the target branch, but not in the source branch.
> For the check-whitespace CI job, I specifically chose
> $CI_MERGE_REQUEST_TARGET_BRANCH_SHA for this reason.j
>

You're right indeed. I did some more reading about this and I think the
solution lies somewhere in between..

>>
>> > It might be best to use $CI_MERGE_REQUEST_TARGET_BRANCH_SHA instead.
>> >
>>
>> I actually started with $CI_MERGE_REQUEST_TARGET_BRANCH_SHA, it didn't
>> work, because the value was undefined.
>>
>> See: https://gitlab.com/gitlab-org/git/-/jobs/7283724903
>>
>> This is why I also decided to fix and change the whitespace check.
>
> I'm not seeing $CI_MERGE_REQUEST_TARGET_BRANCH_SHA as undefined in the
> job. Here is a modified version on the check-style CI job printing the
> environment variables:
>

You can see the output

    $ ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    fatal: ambiguous argument '': unknown revision or path not in the
working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

This only happens if "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is empty.

> https://gitlab.com/gitlab-org/git/-/jobs/7291792329#L2470
>
> Do you have an example of the check-whitespace job failing in GitLab CI?
> Maybe I'm missing something, but I don't see a problem.
>
> -Justin

So I think I get the issue, GitLab has two kinds of pipelines it runs:
1. merge pipeline: Here the pipeline runs on the source branch (the
feature branch which has to be merged).
2. merged pipeline: Here the pipeline creates a merge commit using the
source and target branch and then runs the pipeline on the merged
commit.

And "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is only defined in the 'merged
pipeline'. If you see the pipelines for my branch on GitLab [1]. You'll
see only one of them is marked as 'merge results' and the others being
marked as 'merged results'. The former includes the job I mentioned
above, where "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is not defined.

I'm still not sure why it marked only one of the pipelines as such, but
this means there is chance that it could happen.

So I guess the best outcome is to use
"$CI_MERGE_REQUEST_TARGET_BRANCH_SHA", but fallback to
"$CI_MERGE_REQUEST_DIFF_BASE_SHA", if the former is not defined.

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/172/pipelines

--0000000000004ccf23061ccc892a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e559c8fbb53bc96a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTStHTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEhnREFDUEk1RS9ZVlo4VXlLT1Z6NStyRXpDdFpmOApvc2xoWGlqY3NJ
Wngyb2MrY3pTNC96U2hYSWVqUHBEcmlXUHJGelI4SWdoWTc4cHBVNUhuTVNZY1RtU2FDRFFmCkhV
L3dWTEhRbkw0M2NBcWdDRDlzN0srQ3BoaHIyeitQNmx0clpwOEp2QUg5ek8xWkF2TWFnSFkycGsr
ZmtVemIKUlZ2Y3Y1ZFVIWjJLdE1DUXFZVFFGL2FQdTF0OE5BMjJob0lJY2VjdVlmM2NubjVaOG95
Sy9ua0U4WjJQSUY5RQpXL2J2WW95VFVPVGN1QzRsOFFCRTRBS1c3c3MvVERjSDFSeUhEQjRWNmpq
bzVkRnhCSytPWE1tMU12L0I5RUcwCjF0eDRQeHZOVEtIU3NSNmFpTHBLQ2QyZ1p0dTFENTA3Y2lt
ZEdSblFOamRPaUYySzU4TzZySHNVVzRYaHJVdTAKMlp3T21xaUZGclNNS2RHTC9qcEE0dE9MOU5X
WCtiREJvS2JuK3B6YTVMR2J2OTJiS21XUnhGbmhhd3ErUEFSRAoyaFkvbzV2d0lyYm1IWFA2OXRH
bzZjRlNmeE12dWpaWUlub1h1RHhSOE8yclFOL0IyL3daUDU1QzNtSDFUcmRsCmtwVnVIZ053S2FB
bVJrTW1uU0hSMWt5M1VLcGhVYTRGeGVRb24zWT0KPTk2RVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004ccf23061ccc892a--
