Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AB4949FA
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142604; cv=none; b=RctmJMCILHsTwEH8oB20Sh0Q6Fq0OcVwnsArmlka6ocEAkN9IEWtnAbqMem8+e/5630CuaXtA1LlNQIVNsZDtiuqsGi9mfhvJfBqQgzEN91vBtghZ4eaQZ8P/YxTZOAVaBGZ+2edh1C1FdxH0ChvSRcRCYRMH10rVhnTLETDAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142604; c=relaxed/simple;
	bh=F1RZg1IqxELfJJ7UL3gOZXnfJwigkw97NayqsmvfIGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BjuBnilIQuFD5Rj6jc/Q+UHBFJpIgeymuACKtQ+K+YuIyuhK5M3R2XdpKw1DJkGLqqEoldHEcqQKeLvrSn0HP3SNL685UBJgQF6MuKiihDHMHHsMVowqpe66IB1EciqZcL98Ki9lNix9CdH2pH/JbwW0d4wH2Mqqb+CKZ/Nu1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v/LNUnHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h03j6al8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v/LNUnHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h03j6al8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FB57140007D;
	Fri, 11 Sep 2026 12:03:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 12:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789142602; x=1789229002; bh=t2pTeY5Fmy
	TOEky1l6wXt6XmQdMiMvF71SfU48RTA7U=; b=v/LNUnHIy5foKgXsGTvqX5yjNm
	3nV72S05S4yQ5RiScEkNSnJqr8tnpMIIOs3sPN2ZWAQEN6Fmv0iK+VhYEKxod9xp
	e/Sz+QdioE9HMFkHMQgC/Ga4XjN13Qo+43q9KozUWOvZ3eC3NGWoIntTFA6EdfM1
	AGt1lQupunQi2lMVdaWbBJaDw2jNkVvwIILlLfMFlnnNLbdMwAYnJRoPtfj/B7p9
	sQMd+WlgG4bu7XmHqh7WO/rNohG9dFGZSw7YDyrZzDVnqsw6X6HklDzivi9HDn80
	qxBbeEQ7jWYVE8vDl5noiVA6X6aLjua/K+gaDbAVEfZZRf4S3ZwikdOnuEhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789142602; x=1789229002; bh=t2pTeY5FmyTOEky1l6wXt6XmQdMiMvF71Sf
	U48RTA7U=; b=h03j6al8VYQZVG8UuHtTaK4TpiOzbjMqdr3aNHU4VeOohl+X0AU
	l7Rf3Frj5FLId9G7NXC68mqzsoH34vVNvrJrDU55lLr0INJjNBU+EzLIkEL4AtN4
	HCMLEvQDjgJBAMrbuU/Z0b2k/xOOEouPGSNBnrpYrReX6e596r+pbIsMZdUx5jhZ
	xD8i84bECykjeZaTc/qZpgrO5q24y0b50O94HMWnXCOUOaUWgU0C80/Vp/hk6Dw1
	BhhmULfKRV8gvWH5NEb1bM3SbHL2GeIezH1L2qx9Cj/4NXgeFPZWYC8mKletkoWR
	N53BH3hf1cMWfZ5xkQphhnQXABWgnrbTGiw==
X-ME-Sender: <xms:Siakam3XAsVly4CvRRoPGvohCRe0hs-tQ0DXnjjYK8wsbjmCaCFyUQ>
    <xme:SiakarqH8cCuJeTCyEMem82oeCVUlTx5EJ33n_LImcE5FQ8S7LRxa9tR4PodTm8fV
    HpDDb-F_aCihxvPn-sDS4NKdYw7q_5gIgV1ZhWR31GA0OGDA6kS6K8>
X-ME-Received: <xmr:Siakaii7XRkqFo-avEKJazg-xkJf6qbGTOzY_3TcR5YhR0v8_wuWHB3UDVHzgBZOOO7lLhPerSCPKkn6vHSTlLsM49Lq2pSAOFbF>
X-ME-Proxy-Cause: dmFkZTGvVI7rfXuIQaVOyZDoDdEH8g5P+YNA6XuV40QW+Cam913iP1BWVKNjh3p7tYUXS/
    zXal38VxxYUW3l3Shv33LFUjG3TZoE/3UBmzqYEXYLRU4Gcd8gqO1tpUFVCo1FeI1RlnKj
    gA13L/0WofoEd1/X+QT+3clwV49WwVE5WDtuqJTOfKKTDPZRb/kgKBXX9pdiohuXdKiQSH
    ZzUudbKCfogfQ9HmkeeHNlRdy9rcCZ2dupep75i33AgTRXnvB9HoPRHXNWHsGD22+k5gL9
    L80Yl47274JHYBXTsUCnfFYayCa+peXTyL6rcEvgz4PM9i8eXRyaiM4aFCFcTuDg+mgWh7
    zdBOkQxuyPGBUMAXT6KYzUYpiVNLu0KB79Poes7s0BG377aE8GC00w1VQ2v1M9XB/x0vQx
    9+dTh9m4mMypQApkCXFd/QW3K6CQ4H0lfwLUnRMaAyVpT1MMHn7o8LDdhHTCmvkw8MCu4J
    Zwne79IBIqbp4p8Wwe6PF6sD0bayOZT4sHC/jClim62Gtd+ONm+HrS6m6k5xr7AABIO+9z
    eUFWJqSb4rtIf+ZxZtZYxztkRqorrVtUbArUFEcGw6Z3fO1C+Hk4uIaAWCvhQuXC99Rdmb
    DxuU0x1nuGSrTUsekzaY2QNVLwGWi3xRM2hsgiL1RAzxz6q9tUXw/LP2qcyg
X-ME-Proxy: <xmx:Siakan9Ve0mVO4nc8hb5Jnsq1W2wvSyAiS9SzqfEM0j7aiR-pJKNXQ>
    <xmx:SiakauWw54zWELVujfj3yuG9PqbMBNDjTWJ7DJTifbgtZ094KTwB9Q>
    <xmx:SiakarDFUeLSMa-HF4U7ln36YIZQwjNtlGjE2jHN-sGU-1qQPb4Ymw>
    <xmx:SiakajFItHtWWKxwUpfYa9Ue_fJrufvQ14JPKiFCqX74_jqaFqdN-Q>
    <xmx:Siakavt8pZpK4EVnjiGZ1VV0CmoNrixL32hRE74WILYY9VbiNBAIXMkE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 12:03:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tyler Cipriani <tyler@tylercipriani.com>,  git@vger.kernel.org,
  Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,  Stefan Haller
 <lists@haller-berlin.de>,  "D . Ben Knoble" <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] push: fix --force-if-includes detached HEAD advice
In-Reply-To: <aqOl0SnPHa5iM_tz@pks.im> (Patrick Steinhardt's message of "Fri,
	11 Sep 2026 08:55:13 +0200")
References: <20260904210122.431757-1-tyler@tylercipriani.com>
	<20260910230506.1631656-1-tyler@tylercipriani.com>
	<20260910230506.1631656-3-tyler@tylercipriani.com>
	<aqOl0SnPHa5iM_tz@pks.im>
Date: Fri, 11 Sep 2026 09:03:20 -0700
Message-ID: <xmqqcxujdbcn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 10, 2026 at 05:05:06PM -0600, Tyler Cipriani wrote:
>> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
>> index 257db58918..a0eff8bbd6 100644
>> --- a/Documentation/config/advice.adoc
>> +++ b/Documentation/config/advice.adoc
>> @@ -90,6 +90,10 @@ all advice messages.
>>  		Shown when linkgit:git-push[1] rejects a forced update of
>>  		a branch when its remote-tracking ref has updates that we
>>  		do not have locally.
>> +	pushRefUnverifiable::
>> +		Shown when linkgit:git-push[1] rejects a forced update of
>> +		a branch when we are unable to verify the remote-tracking
>> +		ref is available locally.
>
> We don't really care about the ref being available, but rather about it
> being integrated, right? So maybe s/available/integrated/.

Ah, I missed that one.  "available locally" is not of interest.  We
cannot tell if we integrated it is what matters.

Thanks.
