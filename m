Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EEE37C0F7
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924903; cv=none; b=C6s/8W2UFvn8ZT2C4txiBqYhXTjKC/7FmccMpCVydVmUp3LOLcmfEeMmimQHvYj0IiFPeO4iM+5NwdCXKszvxXbWvxhCSub6ULG/juqNmUSpjAlCZmmXBOtA/yW1uv0zv16UgR23QmedSdSZsa4hMGYRH7iivPQfUeb0DMd3KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924903; c=relaxed/simple;
	bh=XyBplyVYIigj+SnYeKCeNE3lvP7FdAO3ax/nmWa725I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KkdSUEjUBy+vb1T5GUtfRCWYGKubad80r0gC6GF2Qu6S9eUbL7mgLLGKiMaOJ7IYriXUAoUjiEwl/cG0vmUp54nhZU/oMnihnNoU67w6ykxLLKHQrm+7Vq/GC8Jq0UxcWLLV3K6vNxY+WtQcrJqlUXh8cEOzjcs+pSbijS+a8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WGCPLipK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZmbhKWM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WGCPLipK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZmbhKWM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C8CE14000DD;
	Wed,  1 Jul 2026 12:55:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 12:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782924901; x=1783011301; bh=WMrrhhVqRq
	dqtPJzzONE0ccaPHtV82gNjelzgOIkSRE=; b=WGCPLipKI6xlzyKJR9ml4PEOve
	v6PWhoFRQ5kOkMAK8ROLXkGPMgtH1eQsnx1qUeyimf54kfLlcy0DTSajaQFFq+2a
	rnvp923ULTQPr4Mnecg9umfHzyh0cwdI3oI2+woZK21Z61/zMSpFKKLBIgTe8DPH
	uf4De9HJ9ZjipH10g0MgjdKd177fQX7f9fGBrZFQnuIbDYjWY1O7yzaQ/bqDWLT7
	nK69glyzEe9w1MXXDqZ4YzWfnbgQJxK/JapBhjrPZdwsb0qt9EpjTAo/SghW0SkT
	u5mNMYUdf2cwAZLY59STtfwIC2OFGGSu0LxY6twdkEQQP8ToB/JwaQTVHZ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782924901; x=1783011301; bh=WMrrhhVqRqdqtPJzzONE0ccaPHtV82gNjel
	zgOIkSRE=; b=VZmbhKWMuG9Kc4hs5in7vO3lhgZCeM0tOYXGM9hMecmQ2xscewN
	4sGUq+/KA9OCq6+OPczMnid5IoPq0035Ysuqz3LGXcXwyMY60SNKn44yiu2YpTkR
	wIAfwbzGZoD149aP9ZpRQWWRQcH8jiaWVNllT9QSba1yqBUrFxY1wo9K+Eg3MoJx
	AyzwJpL71REq2eBnjNcAcwoimwGtbRQZKwdxxIWlf6WWKKo+i9mNdsPi8b55b8sP
	Z/Pg5FLPjaKZ6mNe36wB1DDpjCqd6SgzhLBXfm3OX75/wCR8zmKPt9UeR/FILHqS
	C82kYEklR94VYIWaGXmI9ONxHEXSTNDI4ww==
X-ME-Sender: <xms:ZEZFapjUOlozCs5i07A78SzP2BjZGWZN1M-rvwivHl2FuBXwVy7sUQ>
    <xme:ZEZFalDVW3XQ7l_lHHIgLJAh1FIwEmCqmL5KZUEvqcQtvusAVFl79bVAzEYIQywpd
    MqszL63B_5j8xsii74P6pvsvO0RqBcX0nwe9D7AJnFOYEuc2yD7CQ>
X-ME-Received: <xmr:ZEZFauHAae1CECQzYLXliLXObiWErY642y1D-vwS7KjlklBB90b0jO31i_mq_956yk_KYR7d85-ER4XF-rQxaVZMdAy29W80RWS7PVk>
X-ME-Proxy-Cause: dmFkZTGP+jWF/KjD31PI3X18Gqb9LNgrV+bCDE9mvMTYUg2bt68qNwk20HXUJejtXBbeBT
    8jNK4lQk83DGXEh+ctIFtC/k1swBVoTq8CjqtcO2op+bksApSh8FD3IlbfjG/VjZA5laQY
    Yh6KCF30hr6UOgww72vHzSaP9KE2xfiEYwixyfX1e4OhuowGDfg4LcslB8X3zcH6VjUlOA
    BXBOveIiglKeXQx2/ozENSdlU/aSSTrtZw3yc3DT564UklITUBFGZ5LewguIK96+73wmkQ
    M2PjHg3aWb26EmszIPKu43WSJ2nVXIyqo7O5ZIglxrOdAjiwICNS4gDOAEL7Z7GuK7tlLA
    GBJ5AWlMynDBr8hr/uxxa89rOiFOlA+BfbSjtTsR3r9O/ZUMchZOJKtJkwhGn4Pcvx18Jj
    hiUndJkSIq3OFkMFGrKf5fgxXBCtZGIe8OoUpO0voex+TDYgHvxAdNqftjouebHn9zoEVt
    jF5vyEFaBvAj39KWl9gryOUSHUb3i1CtRRxxaO08vJHqhTjZc6AFJZR3tfzuKfATz+nttQ
    sNgeAN00ZyAaPQZrR+7g0sEdofcC6jlNJOT0GWq162+44WHpd90Ye2hl31GV6Jccn/xudt
    6lIcmJzckFLi0B+RtRsIb21wMfyu+9d+lef2rlw2x8/BZ6Tm6jCFIniwAMwA
X-ME-Proxy: <xmx:ZEZFatJT3d9yUUy2FCZb4l9D9lr3rd60Iss8u3I3n0ITz5tOhwmAaw>
    <xmx:ZEZFaimSZDl6cWLvL16x8MOImgfOD4e037YJdyy2OIQ2DHdyRuS_xw>
    <xmx:ZEZFalRfhWXofkqP9hfJXHwA1M4RQiHDpry9KI7qcp_e_mfnE85m8A>
    <xmx:ZEZFakIiyk65UR0iWAIooqnMfoLrWkiglFucd736iCY_l-7VEYPY_A>
    <xmx:ZUZFajdNPRFpnwgBBWbar7tTufCmuw8wknmnDz283YDSGPr8-OYOTyXi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 12:55:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(dockerized): reduce the PID limit for private
 repositories
In-Reply-To: <pull.2164.git.1782889484346.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 01 Jul 2026 07:04:43
	+0000")
References: <pull.2164.git.1782889484346.gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 09:54:59 -0700
Message-ID: <xmqq5x2yps4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The underlying reason seems to be a substantial difference in the hosted
> runners that execute these Dockerized jobs: forcing the PID limit of the
> container to a high number lets the jobs pass, even when running the
> complete matrix of all 13 Dockerized jobs concurrently.

Is the "reduce" in the title accurate?  The above description tells
me that what you did was to "raise" the PID limit (i.e., forcing the
PID limit to a high number), presumably because the default PID
limit is way too low for the tests to pass?

And that fix turns constant failures into success (albeit the tests
run very slowly, which is a separate topic that you discuss next).

> But that's not
> the only difference: The jobs seem to take a lot longer in these
> containers than, say, in the containers made available to
> https://github.com/git/git.
>
> When forcing a PID limit of 64k in that private repository, the jobs
> completed successfully, but they also took a lot longer, between 2x to
> 2.5x longer, i.e. painfully much longer. Reducing the PID limit to 16k,
> the CI jobs still passed, but took an equally long amount of time.
> Reducing the PID limit to 8k caused the errors to reappear.
> ...
> It does not look as if the PID limit is the reason for the longer
> runtime, seeing as the 64k vs 16k timings deviate no more than as is
> usual with GitHub workflows. So let's go for 16k.

So 8k is too low to make them pass, just like the default setting
(whatever it is), but 16k is sufficient, so this patch settles at
that number, which makes sense.

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index cf341d74db..85cfedf5b0 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -420,7 +420,9 @@ jobs:
>        CI_JOB_IMAGE: ${{matrix.vector.image}}
>        CUSTOM_PATH: /custom
>      runs-on: ubuntu-latest
> -    container: ${{matrix.vector.image}}
> +    container:
> +      image: ${{ matrix.vector.image }}
> +      options: ${{ github.repository_visibility == 'private' && '--pids-limit 16384 --ulimit nproc=16384:16384 --ulimit nofile=32768:32768' || '' }}
>      steps:
>      - name: prepare libc6 for actions
>        if: matrix.vector.jobname == 'linux32'
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
