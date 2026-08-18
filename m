Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A345199C
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076338; cv=none; b=exFVF/6JzfcW2dOd/8IQHN0Q+XgUFSVmNb4hr6vAKQxURwX/p8G7b7S28JL0qy4W3+39vavOvmLSksnEI2b4YoCfthcfhp8+wGw0rj3+p6w3LWpQV9ikMgDYlkrUqvbXBo4aMbABhHizdxt2DU56yMqBOrdrDNTceTpSsxcwjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076338; c=relaxed/simple;
	bh=IVZb/5NZjWlJSEIULqcHPz9IkzZ2PPESkW620ixPE/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugc1u4shCLkbGDxOXxiNNFMjnwBN3fk96qcH5gGgnm1dTVB6LGwVuPJjBnf76tQcZzL0B+qon1LnTEg7e8x5MjhP+N3GmyIpAiOlQfbt6s3hN0z0u5gjIPY9+IGj0h8ksWi3X35G/4rubyoRKPs99fdL4mD8jCWmlpe6y0eWcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BYPziohJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZ3SwS5Y; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BYPziohJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZ3SwS5Y"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76164140011B;
	Tue, 18 Aug 2026 14:05:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 18 Aug 2026 14:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787076335; x=1787162735; bh=A15xnvde73
	eODHJWaIg0A91+0whHmx+HcSiaXoVIidM=; b=BYPziohJfhH79rnNZbJC5RZZNf
	P9ofL+P6qmk9tLprYXjvMLsqJ3+kGltO2YnbrqWvH0zr4T8IIZbQn6Nz3EvZEwOK
	gn0vSP00RsVzn57qo+Mm0VH+/NcEoJsadbiBIhLMOu03PmmSurAs2KJ6L3G6hVsX
	YGPF295bCniMDzTl43hllSFldUQ4zaqACUcXchKt2z0HHWC+SuZusrgwj55B14mt
	LkpElG0VJOUPpIlM17pjHcf0bsFINUArGt/vkmlgKBlDZpbKs3j/xBRmcS3YvZE7
	Uqm24kCP8unDI6qnuPDbfswMILDJXpgFLMpaeg7WRt04wg0/DctXTcjZhC4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787076335; x=1787162735; bh=A15xnvde73eODHJWaIg0A91+0whHmx+HcSi
	aXoVIidM=; b=hZ3SwS5YWtCak4PZ9v9T3/ei4e5Dyfu7cK8SrgpeWlopYbsr7Vg
	AgJxPSH5NbHd4KXewIepGXv4bRR08q4VXSi35HFEc8zoYopo6VDkRek7AoMXK03k
	7DQ2RoZLOIlVbvDwjJ7hYB+IVmkP77xOZ/ASFUaRGdnscxJP5Wj9V3Sb+P4PlEqo
	Ub8V5qoqvx4sPudu5EEXost4z1CmTA0Vjyl9fHg7Nj5kpbKesavCUVbMZ3UcajP9
	DD+FBXeuf0kOGyjxjDodqa5HJ8dRgWR4uc2+oxbpjxIj1G4GnV6saHKS+YpeC60y
	zCk1i1BplnwIBX3tAcSsFrgbv+pZIrrv8Cg==
X-ME-Sender: <xms:756EalpnYiGSu_aThvN_Mw-iIFJ5xmK_U1iadEKWbAdHfTtMn2nTyA>
    <xme:756EavHUiqTuSVw8cAdaJKN7GNj6c2emmEBnp47gp6Bit9upGnkXeyzTCnyw8vxYv
    AYrNTN4W70k5PACH73AuLOxerF6P1v0kCTYOsHBeerRmUQzRZN9CQ>
X-ME-Received: <xmr:756Eavk4F0uqM8ci8TeteJ6fau1bcvAIDvtpsCZjMol-dyikwO-23y2FLxsmaEtwcmjcRGspKbOXGf4vmrY1Ljl82ZtzB4Wkkw>
X-ME-Proxy-Cause: dmFkZTFo7XU9xlYDKaYcc5CqN7ZnJZR6kQ/LIaVmCXWnVAZ59AJN4N2JhOJNnmNue5c3lG
    im9rRWQuontUryxaeDbGO6StRIYxY7Xoi0lJjtN/fGa1YCCpHLZrZBmWCCcQz+8ORvii4Y
    AFFadDWUErSM7WH79PrW+N+NFWsVFH2M3DS3RiwTb+5y7uQjR1MJYK5eT0r0Hr6frHH9N6
    CRCp2V//gDghUSeRxKU3l//hyHBnFIPTdtQIZtXKgLR5oDAZyyxmKvj0BvnWuBy7SYGH1Z
    QQ4Xqb/nCoYHssXgM+ZGheGB39bTRFqo83t4AN0NZgoc5cUu7gl7s/GMFSrcNlcffoLOQD
    91dp9Ki00bcQCQGH+Wgcsk2+3Qa4oZcebPENYF8O4DVxhWmguW9mhFgHU0ObAFk4t8Lwi8
    e9XwVzTMXTUzWkzs55uo2RIRrN+Bo+IkHxzFkczjkJoLfzCU9XFaMXUi7zdvhuAwfeK4CS
    Ay1HnSk4oboqeaNpqM0jcLPcsvGGwp6ZxsRtOvl1WiXHGMkl7BVjh8G9vUPaCX668kBfCo
    MHL+02KlLesSp7mgEx2HJOjaAvUnjGZzOjKv8ZNrlCTDlBBIt+x9CnIXfL7bmWxT7E5SR8
    MiVUOUOZP1SE7m6G6ArSD3ixxi3YTrRGqo6UuNzdoVveZouE8MxRqfATxSsA
X-ME-Proxy: <xmx:756Eaql7aTLxTb53kiqFU9Hglt6M8Np001PK23RaWCW3wyqtFms52A>
    <xmx:756Eaov4MDQ-pMcuIm5ES_ROhiB1KObNsFd7OhC796jQJrKApqp6DQ>
    <xmx:756Ealk23OxRSnVfJ_9t0X11drSgCtupKRnGyIw9lueGm9-lSjMijg>
    <xmx:756EarsjdmhmJqVYQ4D2Le-XO_GGwGI3yZLSwER1bG7RcscE73TSog>
    <xmx:756EanOP8LNSg4nQcM1fmUvt0g7cw1TqzzEHqvzzxOWlXBJFoS3gQ_Mv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 14:05:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] odb/source-inmemory: signal missing objects via
 positive return
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-2-ec234567510f@pks.im>
	(Patrick Steinhardt's message of "Tue, 18 Aug 2026 16:19:29 +0200")
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
	<20260818-pks-odb-generic-corrupt-objects-v1-2-ec234567510f@pks.im>
Date: Tue, 18 Aug 2026 11:05:33 -0700
Message-ID: <xmqqcxvfz4lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The in-memory source returns a negative value from its
> `read_object_info()` callback when the object in question does not
> exist. Adapt the callback to return a positive value for missing objects
> according to the new calling convention.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-inmemory.c         | 2 +-
>  t/unit-tests/u-odb-inmemory.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index 3e71611b8e..57183daf4d 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -66,7 +66,7 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
>  
>  	object = find_cached_object(inmemory, oid);
>  	if (!object)
> -		return -1;
> +		return 1;

Let's not define "any positive value means this single thing: it
does not exist" and then return a mysterious and unspecified hard
coded constant like this.  Instead perhaps something along this
line?

    enum odb_roi_status {
	ODB_ROI_SUCCESS = 0,
	ODB_ROI_MISSING = 1,
	ODB_ROI_IO_ERROR = -1,
	...
    };

As I already said, I personally prefer to define MISSING also as
a negative value.
