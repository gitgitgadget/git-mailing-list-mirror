Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342A405F7
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510308; cv=none; b=kYz+gNVSh2wS+/8hXRSORY+VVEgfIZW2ZtzU2n//7ZibZ2e4OWwvaCzibEaJ31K9YFYnZ8RKPVdMrta+ZVOKJWFJDPeCeE5xciI0V30Ai/1i2lW8gToElT+zkDSDsNMXv2QlhiFvudzJA6tIcGvEuAsxNd17WbMuLStdHsK4b+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510308; c=relaxed/simple;
	bh=zWgLEMD/Sx4SNxY4UQL2/U0CWXD7wXiC1hu8lgOMXwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bd8Gm5MRCKUUtXZf+r44D51ASSZAeR3NIeRJ7a1h2qV/3Rp1D2Uwk7VPY9587wWWy0tEJ50r1jyIAsvrOAwwghFNv8O8Gb7AqX6lGzilC9axMH9tNcoDaxb3CUr/tllVfRxr9m6z8V3SmP4q8dFMusKG1itMxWF6HQy/OxPeAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V6X6Bouj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfnoDDyT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V6X6Bouj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfnoDDyT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E837D7A0137;
	Fri, 26 Jun 2026 17:45:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 26 Jun 2026 17:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782510305;
	 x=1782596705; bh=S41gFudXXz/kNmwWJvDAYwPSR/tWKaf+jB05sjfUYkg=; b=
	V6X6BoujYKs2vPflTdfJOj+kiHuQnnix57nqsvNwRhEaWFEhzQOS0GFoDK+/cOoa
	kGi3i0sygMac0nxEUUZH1dk0jH3o3Akp1A0uPH129kCzdOh/HwEagRFA8bIi5jwH
	fBjO9vPcw/O5LdgRkPEBlUEt6JVh9FYBZzr8IHiP2FtGcm4CQ6oplJAYKSmHmMlm
	TRKGzzccXaok1xNjScPDo8wY0oVepS9tnnOXrWeHy/lU1sPpfk1t8rH7cmVrvPAt
	AMQHpyqYYGYEpvNaGd7n+6JoWq7dZ0Dpq5EAQc2qkmiGvQmPbpqPPtplgGNZftDW
	r2Jp2v2L1ynvR70CVXYNTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782510305; x=
	1782596705; bh=S41gFudXXz/kNmwWJvDAYwPSR/tWKaf+jB05sjfUYkg=; b=P
	fnoDDyTGGArkpWV/qsNfdpSjT5EXg+CRdvgyCPyUZPT2Nz1bY2Ak/wZrY1H1wGdU
	+16RIyx4P1vRaKQs4wydeptAEFi4/FfAe25x+rQkrkdMzRfDguHIFrFQwIgpsLn4
	skLxWRaLB3QwsA187e53HArF0BFqOE0fpKaAJH40JR1D1NCgdCNFaj4xlFhKtnVx
	GBJxJ1a1dd3q4dLf45ZStVeTmGYkncQdt/DrsC9qYDubAPoiQAdCceFCc4cQNVCp
	khTww5pU1G18YPgxlSopT1WSggnuq318PDWTNks26Gg7RBUZCuhAOUa7uWPScRh8
	l/hNPHcl+8VglcK8dLDtQ==
X-ME-Sender: <xms:4fI-ak_6S2hH4EvgxmJD0s7vLUKTS-5z8-2NcSDno4pZ56p5t-v2pw>
    <xme:4fI-aryIeXxtNq1A8D_aD2WFOiGmT4qqQeCc7HL9UVplky73q6pI_1yG6VI8REr2d
    seEFmYqgXSTcWHnFulHCjHh8f7zz-akRMI7KLsFHr0MGzu6pNfDIA>
X-ME-Received: <xmr:4fI-agPedNl5yFac0ysh9yhlJvSgkLH7gqI9QvDBESppdkoGVUjFReyr5BrTwOTOhc4RE3PHRAHFI-hefQoAzTzVYCruLcPTaS50pwI>
X-ME-Proxy-Cause: dmFkZTF4DIcBuIqFZ5gZdeEgHEdM0sBuX+T0Rq5nzjN8MZqkcJx6YlTknggeFn2L78UWMW
    1v3OcLXJoY4qD775if9hH+mS9yWu2amsf/KrvLZdMiCrFXlTVyM1oIeh/6uTvHsYK4clDP
    mo+D1ox+aPRvRbMOkvyTj+f0e5GRcJk3g4guI9aO5l3eG3e4oF7c4U/96KVPF5dQc3Enjz
    PP54j0U3K0150hwehFUKWu04t6NtyxQ/rAdJiEf4LUK9o+ER2VSyWuAg6koOoZzhcAJh+o
    pTz+gaBYAUDOHxSPUz88LJBeDnlrBdB7BtYV9z0yOIsGAX6O5KaD8edrbCBfZ74nrGIqnF
    bMqwDakY28cGra6/2Hyevpierzg0XtzOzCk7/6fYknY0A05Psk3w+wQ97Tww+6XRlVLBNA
    89zGz2IaAT6NxrLFJE5g9NuE0fpIrEpWN3PEaK/3P79PKdUIYWbVhaVmj5O3gXSQ919JDQ
    YNnqnuJIvFfngB8iAx2+WF563a/QXE+VdBvObm8xMPx7vS/9Xk8LXqcNNy775iKpeZFFv1
    3E1MbHQ0imN/Yby/AsEraGb7v7xmu2/pTFXaJufySiyBYZWtnaXMn9zrz2+CgfMNBRZs1I
    CzovB9JpkOh3DEZX2gWxIpnCNHkn1Q58hCDgsYZScOQklh4Lg9SM5N5PU7FA
X-ME-Proxy: <xmx:4fI-ag9X5k9smNKZM_cbT7q8Lyg_CpGm9dJ3Vsz2iLiL9S7f4q8yVQ>
    <xmx:4fI-at4ZXWM1da0FkE8inXpvWh1LZ3mht11nqYVCNGT-vIAhDDQ33g>
    <xmx:4fI-am51QTGLGXaEjOJ5Y88fBesgMlfli98JMgw2Ak5FhfO_zdq2cg>
    <xmx:4fI-amoki_BnUBY-JgXMfn1omiyxWZAebxsap9mjogiEqLLdeVTWBw>
    <xmx:4fI-arrnAmsdjzGX1nU4oFORe3DYsRHnfiIQj167OzjL2028KTtCN6U6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 17:45:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,
  cirnovskyv@gmail.com,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v2 1/2] dir: encapsulate excludes_file lazy-load
In-Reply-To: <aj7rtj9NsejqN357@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Fri,
	26 Jun 2026 23:14:30 +0200")
References: <20260626075037.532164-1-cat@malon.dev>
	<20260626075037.532164-2-cat@malon.dev> <aj7rtj9NsejqN357@szeder.dev>
Date: Fri, 26 Jun 2026 14:45:02 -0700
Message-ID: <xmqqldc1563l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Jun 26, 2026 at 03:50:36PM +0800, Tian Yuchen wrote:
>> diff --git a/environment.c b/environment.c
>> index ba2c60103f..8efcaeafa6 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -134,6 +134,13 @@ int is_bare_repository(void)
>>  	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>>  }
>>  
>> +const char *repo_excludes_file(struct repository *repo)
>> +{
>> +	if (!excludes_file)
>> +		excludes_file = xdg_config_home("ignore");
>> +	return excludes_file;
>> +}
>
> This function has a 'repo' parameter, which is not used in the
> function at all.  This causes build failure when trying to build this
> commit using DEVELOPER=1:
>
>   environment.c: In function ‘repo_excludes_file’:
>   environment.c:137:51: error: unused parameter ‘repo’ [-Werror=unused-parameter]
>     137 | const char *repo_excludes_file(struct repository *repo)
>         |                                ~~~~~~~~~~~~~~~~~~~^~~~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2922: environment.o] Error 1
>
> Please make sure that all commits can be built with 'make
> DEVELOPER=1'.

Good point.  In this case, we can start with UNUSED in step 1/2 and
then drop the UNUSED in the second step.  I wonder how harder to read
it would become if these two patches are squashed together...

Thanks.
