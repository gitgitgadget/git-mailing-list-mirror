Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7155C1D5
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170961; cv=none; b=YxDeyrVGU3yJa16y5/B22dTcLVfDNI+wUC0S2iuxlpR89eupYOjrqTs78A+mS61lkIIgZ6uQbMQ3d0iBM/IzkiLWqsYDAcAWzi+wcNggYPQ3OrIPaVN5zMXR/mAWzCDee9o9p3yfkD/xJ0Q4w9vIyFgbBdpkU82slHKQNm7I7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170961; c=relaxed/simple;
	bh=w+V8+hEYiFaRULs9TmLwxuuC1LtjTa/gJZdoIU3kQlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qBzPiguS4m1XzI/bisPZ38e91w5Zp5wzpsGjj6h+/aWbGCXe8x1m4zRNDT5KddvhUXQOaEU4oJ3Tnt8zWLD2lP7qO2tR4s0t+HgRHYpYMwknDxr7G2VTuffJXbRPc3UzgauHG01Z3M9qCLiKmrcXl3gYeqmfEwgMUT7qmJzcCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p5xtO9HG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCE92ZXj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p5xtO9HG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCE92ZXj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD8A11400102
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 13:15:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 13:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792170958; x=1792257358; bh=s1i19XFfco
	hGxzxxF3HMJnII6YNL1I2TVGpNFfmxhCI=; b=p5xtO9HGvx3+1xo2L0y50Z4jTc
	cbF5FrNFWJJqpojklRV3S5IQAmqW/FhbQHljbTRX75usBz/WDXaBXbrg6WSCx4hz
	B6Gpm4dbd9GfUkLckACz80Hb/TivLvQhvN8J1gm0XN/23aPD37ySKkjS8g6d9v1m
	LnHcE1xzilSBlCzP9lI7jZ+Q/4Ek4b1vYmipqCuDtPOtpmLCHanaPnGWYue0Qgcp
	eE763qQKLJHTu0ewYNZwwSE3cH4bTXaVsjo2rek7nCgkryMB6xhjB8vph8ax4gLe
	T2gkWayRfWUnja00F0gS461W/fHKtyxCcUNF7ek2D6N25DqCP++B4uKdwlzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792170958; x=1792257358; bh=s1i19XFfcohGxzxxF3HMJnII6YNL1I2TVGp
	NFfmxhCI=; b=DCE92ZXjgnr4jVbUWPpZVWJSqZ78v5oqQ0bU+olbHFuEa/emt1U
	6ueN0vwV2uHjBAYb6mJpnW2t7ldwPjAzsS7pTIuJF5l/bNpdJT5UEs3YSVc85Al6
	Iki3mo4MCpBd2tNPi1kMPDLJM8N1k22rhsIOwF0+QxRVawVkIvSpQ4GJ/exJiqZJ
	dHzdF2QVCI224LIoZbcYHI7H091oTGVIplSW0DzfOFTnu85CKAicVAP+OH0L1m/G
	thktEz+kjUP9rXSp4I9N2oPWE3TxBsXcJR78MzbwV/iaM2+EjbLsYuGx0LrfuGIT
	52C7u0WbbBfGDemQkHlI7C04FK/0/+nS5cQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792170958; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gIbraYfXcVOVEvWD0uNsbBzf6FRZh/Q3JqLN4DjOObdu0j2
	e4JXRTFr71zdPRM8HstJAa5dOSrrB0sQFXBPGjfKZKq0xd00cjpxLy5429RYzHzh
	5a3iVQMe8zDMo9nsDJ8W/FqybLicc0hViJWGt+LeCC4QJqMKQ4p5fO37DVbj2+/f
	p77ncz6HXP+TyQDb5Qcu6qciyyLgrAJAGSHj3/NRmZ0kxEKgm0je7bDjJwoGMqre
	g1pNLBgH64hOa7/YNNlcjJlYc8j/yHYKiQITjZRXITjvkIIbW5gPj2Wv737ncBj8
	k+10DGGl1fucrTFLVEBQyqDnQzguDdlwmoJLO/A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lJY56R4ReYD+c1Zx1uY3B+m/WIN3dUBTsMlUUbkqYNE=:w+V8+hEYiFaRULs9TmLwxuuC1LtjTa/gJZdoIU3kQlE=;
X-ME-Sender: <xms:zlvSaorI8etM_SXHW85BHZf78alGdpLcQh3hdOLbaB0_qnPlG6J1nA>
    <xme:zlvSalofhZ7oh6_Ewc6lJ9zOoCbcw6ieUI7letQdRMvy4RPnGyBCwZfDuKNk4WnF8
    1-BPP0h1d293R6qV3Hwv8NAMxwEA8GT6mQCPfPsaVANGCRhP9sKRy0>
X-ME-Received: <xmr:zlvSaiNDu3mOv8x2QJZeIhlY1NfRZ77p9by-n4GDJIvHfJjKQIv227HzlHhDvZXqT9WuruIJdB2EIAnN7q0pxT7O7G8fE5Cm_c17>
X-ME-Proxy-Cause: dmFkZTGSUf6sV7Re2KbxJBu5bNrfoeD69zr75FcWvjCVp+qK5yqc4ARuDbTsL33OWP52Xf
    uODQyZS3dp3LARUikpY2DQE4zaM8V7YOPfnEVkdoUUwbMtN6dk46l7HYkdc/5Sp0MQAB++
    JucDhxZIdC+kXfMePLSydNkl4AzqPimUGVa+QMGx5+zquDwlufUDWajIDBW5LLa6LL72D8
    1twEBfKUaaRwM5Aacar5soauv4Bk43DS5x9TKx63vGKnUjz+qxD33jXZ6KtPFTXnhKfdZm
    a2bhRy8nEiVNsVcuX6IThCNETFBr6acN9ExF8p7x3ts38v4OHNNGqiy+mdAz+AMrwvbJh0
    g8qlxkplU6nAqAaKz3g9voqiXx4FKO9226LEc/SedSg3SeQcobTCpP31OR9xzhfIwUEWTY
    1f3RDPhgExVHksEANS1rTq7zfCWcxxtwWnhGME1Xe+mc35yoN1hmNB4MyeAzhe3QBjxLjN
    YNbHnjQ8QuneVxSF6w1U7OWlyKagcJ3BWgGwLGJ7U9QwtCC+zlU3RohZKmdHc+Qa6Bldxd
    ww7htO40JCRKEnUawZI2RRIxxEKYhxJ4fKv51uHU+DtevQEoKOah+r78awNrDpYGKNDttJ
    7VnPKqIOWRuKI25bsi5t3HTt7Uaic9ey2qVVEjiyH6DAHEbnS0fj7w/tAQKA
X-ME-Proxy: <xmx:zlvSauwVcSqMsChfE5N6tCIgxB8Ugc05MNp4L90qouHaIYz7rzncXA>
    <xmx:zlvSajuTqTZyAIZgpxKwEKXdkNIXMfGtzzQF-t4HzUm4_UElKxdqlw>
    <xmx:zlvSav7_dNM9qhm1xDKU_SwfjvAU4wUDusjCGY2yPMS9PHmeYu7AJQ>
    <xmx:zlvSaqRG4vBOjbnao96Uz5N4l0caN3nIfxe3mpgj05NQMNS4HGl4lw>
    <xmx:zlvSahuT4XanOYXzVfW030hZYklENA7cOFdlWmV0-oTaYOu7uKSyh3XR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 13:15:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] gitlab-ci: fix "check" jobs with large merge requests
In-Reply-To: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
	(Patrick Steinhardt's message of "Fri, 16 Oct 2026 16:48:20 +0200")
References: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
Date: Fri, 16 Oct 2026 10:15:57 -0700
Message-ID: <xmqqtsmlftwy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "check-whitespace" and "check-style" jobs verify that the changes
> proposed by a merge request don't introduce whitespace errors or style
> violations. To do so, both of them compare against the base commit of
> the merge request.
>
> But both GitHub and GitLab use shallow clones to set up the repository
> in CI jobs by default. So if the base commit to compare against is
> beyond the shallow boundary then these checks will fail. To avoid that
> error we thus configure GitHub CI to disable shallow clones via
> `fetch-depth: 0`. But we don't do the equivalent for GitLab, so we see
> such errors whenever we have a merge request with more than 50 commits,
> which is the configured shallowness for gitlab-org/git.
>
> Fix these issues by setting GIT_DEPTH to 0 for both jobs so that we
> always fetch the full history.

Hmph, that is annoying.  In theory, you only need to fetch from the
base that the patch series is designed to apply, but I guess that is
not a choice offered.

How much help are we really getting from these two jobs, by the way?
If we disabled them, would we suddenly start seeing uncontrollable
amount of crap patches full of whitespace breakages and style
violations?

Will queue, thanks.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> one more day, one more CI annoyance. The "check-whitespace" job is
> somewhat broken for us in case we have MRs that have more than 50
> commits. And while that's not something that happens for patch series
> that we send upstream, it does happen for some of our internal
> development branches.
>
> See [1] for a pipeline run with these changes.
>
> Thanks!
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/703
> ---
>  .gitlab-ci.yml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3f24835500..62737279d2 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -256,6 +256,8 @@ check-whitespace:
>    image: ubuntu:latest
>    stage: analyze
>    needs: [ ]
> +  variables:
> +    GIT_DEPTH: 0
>    before_script:
>      - ./ci/install-dependencies.sh
>    # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
> @@ -276,6 +278,7 @@ check-style:
>    variables:
>      CC: clang
>      jobname: ClangFormat
> +    GIT_DEPTH: 0
>    before_script:
>      - ./ci/install-dependencies.sh
>    # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
>
> ---
> base-commit: f57c9a73884400380bddd172acc88b569834f909
> change-id: 20261016-pks-ci-optional-whitespace-job-ff1effc3fec7
