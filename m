Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2E37F334
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920874; cv=none; b=fhai8Hf1G5AypkgfFTkgc1gKgpQpY89CMSZe+cm6wXU7Rr33wHcZiMtN3bdjXhgWLTAgekfkYh4Nl8ki8+7IKw2RDyk1ZAQDwps9bWquaBbtXs1Tj4a+mG1totIAqM0ZGudSexLg0UI/lcVYQkrCR1QWg9xfPZq2ztjGfTl3z/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920874; c=relaxed/simple;
	bh=lE5PcRZYp8KrIMuuvrvTHImWGtHFZ7CZIJf8rw5MG1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnuTsFUMcjAfqGMBh1vEc8rQ+qHld4RyJBV2R49A2QeZP58LSr0lmqOOR6Odp1knfL2YL78goDCj31qzHHAfF/7RIPni9wC2jbTF9cuMxrERMfQqfLM/C4+vildDKr0K8P87VyYzslaX7Shy96JFR+eMRRfcVQCRIUIHAKYZWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k+bVlnam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbKjTLR7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k+bVlnam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbKjTLR7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA14D7A005C;
	Fri, 24 Jul 2026 15:21:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 24 Jul 2026 15:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784920870; x=1785007270; bh=2vuj+876fY
	P/AyIYcYzoNgVszmyyrZ/Wbc6zxA+XHfQ=; b=k+bVlnampgqwNV2gMF6G+JehY5
	fmUr5R2Xwxp8ETjt7REMMPEq88tOfEFDJR2rmHXBVcXIqlHh6ZUmiYMdTEwpFX2o
	WSD6pOrGjTZsCSK/K90sErLsezE7a7mc5VMJ/NV5LjbiXIcLFrHUoQYbIwn7LmVe
	IIG9NcBlIdqvGcikcYYcJl0pIXHWbXGvYA7TKnYV7FTAE1W+jdqxThGi/pX4iZtB
	2R/0Xn0arINVLovP0hgldNAbW53sVhOdQsSpg3dzBprgbK50PITZjOIr8os1YEY5
	+8oriEn80ekndXdodFpcIGk2FhWxEsPHzWRgam1ETMgLClrsbFDNjuoRwZbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784920870; x=1785007270; bh=2vuj+876fYP/AyIYcYzoNgVszmyyrZ/Wbc6
	zxA+XHfQ=; b=TbKjTLR70qDgTDjEPPvTIlGoLmDq8ZBxG10W/OX5kY6cyhj5gVr
	FWiOZTKP9iP8eUr/qULGpQ90jg0otJgl24qK2J8FjjFnFHDVL9fySmwNqvivGJW6
	tnwGQrqJyn8a1sjCIrWKBeau/DbK94biuGOck6QCgzjVY2IMJQo7/L5ie+Of+DsO
	iiyKzOp8OkUYUqjuSPVG6IGiTD6VwYsEvVL8MSlS9BV2CPFNjfWcOx6y3Oyx+Djb
	dBDi4xhNVMI4AKFChVLjrGWg1xUmGiLKEKc+LGTfRRvF/DAx41TUCXdTa0+G4wx+
	aWlbCEBSOIpSR30vZQ0+HuGZScarZf2RgSA==
X-ME-Sender: <xms:JrtjajHaBteM506QALTvTsYeoodF8Si1tl9pg4nzq7HM2Hl_fDclhQ>
    <xme:JrtjanPTS3TyqyO3DVdz8K3-Iw9qMRjfJFRMx07jBbGwx9up8DSwoM7XUm6-3wtLI
    E9zvtHemUaf9Y3bWNYXRxoYumgKOh0WnDb8mW8oELcbyA7Jcg>
X-ME-Received: <xmr:JrtjatfsWO_h0ON6Ko7Jicg7dUsCmBkOp7m-g__k8vqp7tFOCAHeb2IGGrhJvF3_nrwhskKM-bX-Djk2QWEHub8b06zBZXa4KQ>
X-ME-Proxy-Cause: dmFkZTFdA8KvEJUlRT0VZKUO4rvj/ZmJH/ekv3iW4OJKkVOCg0aGlKC1FnEcalgRXgh5zB
    3scfEMYMxOFsd64kkDgvUsWBJVaqndOZvN+3/FmYKxPSNDTT7EXoUJ7te20n+5KGKbrskR
    TZhLXugEpMPv6xfG3/x7rg3ZZVqCplo3f6HZ6r+G/QhM0vtt7x803CzE3hc2hRpNi2rk0I
    IRMYTZ3yXAkEodqk/Y8ArP0UKXf2GJ9NyKL6W8E7GIaoLVv5xEa01EPdO33GTKhx7GsQ1T
    mLyzOPhDByDx6FVOVa7eBU0zvZomB9z3Wd2mkBH797psVmOHNe7I7qh8d7YObrh87bgUj3
    uwEUYVRkQIRYTGS3ujn5qXtqyIFvzG+unyMpKV9BTWFhMgeXheatu6MQWIRP2vl4iSC8s1
    hjHTJSflcJ3CpRtNi7hvq/oOSt6vLT7M2QuQnHgeqJjImc49jrOKCWeJ644oRB5R65CyAR
    DHwnrT4MTz1r12JTq+98jvWy7rZRLrg7EThkFtYteX8y7HL0krVt6BXMSBlzCvh02BXd4r
    ar+5jBilvy+5LxsE1JdViviYTsxsBSMWplEFH1PDg2yeYE4kq/IX42u3fIFiYPA01/0h52
    +KTab0moOu9+6XTae+cwbJcZUQxHIbPMeENWCnlJ0q726UuMxPhw1vOwvi1g
X-ME-Proxy: <xmx:JrtjassrexvCNuC6kIDLYTlRAIZQjLF2nHk54QPIJVguef4C4NY7zQ>
    <xmx:JrtjamnEA_tXWpduI4OmC99Xkl2MUM7oztgLSk4k8CqDXR5ysx7jOw>
    <xmx:JrtjamxQ2WWB0heXvpyYKVXhHirGsDYj-ka_qW3j4gY80VQaSyxDDQ>
    <xmx:JrtjagOOkb2prX22CcnfnCEsKBTppJPNTbvgD5IvEGZuCL07s6KIoQ>
    <xmx:Jrtjar8ZL4-bDmHdWA4xP8EQMI-ryOSXKmAxwjGisSQejHpFFxrQ22x4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 15:21:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com
Subject: Re: [GSoC Patch v2 5/7] repo: add path.index with absolute and
 relative suffix formatting
In-Reply-To: <CA+rGoLcgHYk1BgWyNmJT6SGmo6xb_Q4O=LT46FXaC=+tQ_U-qg@mail.gmail.com>
	(K. Jayatheerth's message of "Fri, 24 Jul 2026 23:19:16 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
	<20260717133015.32040-6-jayatheerthkulkarni2005@gmail.com>
	<845D6852-98F5-4168-82CD-90B3B476BCF5@gmail.com>
	<CA+rGoLcgHYk1BgWyNmJT6SGmo6xb_Q4O=LT46FXaC=+tQ_U-qg@mail.gmail.com>
Date: Fri, 24 Jul 2026 12:21:08 -0700
Message-ID: <xmqqv7a45h3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> While bare repos don't have a working tree (and therefore usually no index),
> scripts do sometimes set GIT_INDEX_FILE to build temporary indexes for
> tree manipulation.
>
> Should we strictly return an empty string for bare repos (similar to
> how we handle path.toplevel),
> or should we return the default <gitdir>/index path in case a script
> wants to know where it would be?

The path to the top level can be an empty string if you are already
at the top level, which is neither an error nor an unusual
condition.  I do not understand the contrast you are drawing here.

I expect "tell me where the index is" to return <gitdir>/index,
$GIT_INDEX_FILE, or whatever Git sets during setup.  In other words,
whatever repo's '.index_file' member holds when control reaches
repo_read_index().

If a script checks that location and finds no file, that is the
natural way to learn there is no index.
