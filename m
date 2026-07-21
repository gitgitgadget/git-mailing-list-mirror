Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136B46E012
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662501; cv=none; b=MUaH/13rgcSWH8bqgcD9tWulnBn2bxLJVO3qQplMTyom0nsb+ZBr4g7saMyDfqp//UZeJVWoRyuj1E/NnX3RHB1g56QmA8t2rWtuMIWvtVy2tQ3jZViJOja/xPT4S8A2mOn1q4Ge79OC/VSdSIIOI2SCH2APGlCu4IR/8AGhkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662501; c=relaxed/simple;
	bh=r4W9/6IIl/SX9mT1JFuvd2tS8LOsXqVL5uMKD+wl2Ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hpPB5yhvHO8tutrM4z/8wQVEIEVK6eCOqj5wy5wADyo5BJhvhGjtIo8zqjchKAgNPqJuqJ1uSK178Nehc2hjQ3AKgwLhzFflEF3jfpje9dn+YmcVPKrt5KFYJnMGHXO+77NVa7djkvtcia+5MQSvFBG4UDf/mmdYqaw4e54GyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWcBGp3W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JH4iWoxU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWcBGp3W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JH4iWoxU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DF5A1D000A6;
	Tue, 21 Jul 2026 15:34:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 21 Jul 2026 15:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784662499; x=1784748899; bh=8IFViAphzL
	1qkCHdSNtBhOqTGA5VMEmvu5s2PuiB9NY=; b=cWcBGp3WMC1nxhTI4tQIkmVGdH
	E7RKxEH46cJMDWk/VFpuVMI5r2vupiCwiv/7jWE8RAHIBj7GquZU+N28Z9DTkjso
	PimpedE2OF27M4GQLGCvPZi8Vvww/dgHtkHyqGpur2bG3grLOlWOsBkUZLz7B2Ry
	sIQMCVCGPc106LqrIyBG0nqgu9PqwNwL46bWr0eVQn/98MA5ZyK1oVVS/X1ZtUDd
	Ye1UYUK3xWtQKKo54zU1/D0PDFZgg/FWHgeKVYzNM2z/3Abg6LOAXf3Ii7DmryEV
	XydHnKOhIKk76YbN+xxirQaV4GbAn/jkW0IW4S3+vCroSt1BN5psmAYOdzjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784662499; x=1784748899; bh=8IFViAphzL1qkCHdSNtBhOqTGA5VMEmvu5s
	2PuiB9NY=; b=JH4iWoxUKP19QjIf1wYqEYU9gsJ1pxwcb/dppWGqxcCye4xz5Qi
	8ezkBDS3DKCQsmQIrOoEPIbfABFWDkZwOxjLv2R215Flh4Tdc00L4hvLklpzTtel
	ve6k06I3AiiZ//PL1RNOyUEXvux7EvGUC2F8iDKGNZ7xhw0j1+fl0slVdNRdp83q
	OLrWSX0wqJi3BcKpteL/FL+IxF/KYRHGVDuWUABqW5cG++88nJIwYTBD729pyjhv
	cLliJ5IJn5HbWQlJyILl93RpZgm/bEXJ4ux+UQfmPQGq1V+o72afJmUG1V5sESVi
	Xm8sbsRWphSOMNLtgDhNnpLy6tfZfUyU43g==
X-ME-Sender: <xms:48lfasETlEM8MscLsQTNrAcMVuPPOWzV2W9Fo4coWlnZhiYSu-eEQQ>
    <xme:48lfakbKIPK7Y8E_1IkZvadIvd1mKdWyElfNZVNwn0r4qgr_n9nhGCNs76ibKHYU-
    6TnRBNdaJC24h8lEzxvFQwf0MJZSKpkkPyY8-HNotrQfEYoRaZI6g>
X-ME-Received: <xmr:48lfasXBxU0besj4YAJvxrHMBm_w37ErNERFSH1p1hEb3HGVSGJvcoDFduVI_0lbsacHBAQSp4a9DzdJdStqitR0Iwun8MvCtA>
X-ME-Proxy-Cause: dmFkZTE118U+LFxPFSZSINDRlvXYwfuNCyR4cVu1jtir1UK+gCCBiyWgzYtfFb7RIHQpOx
    2AAQEAfRNnsq1osoK6IRy3w+hJCxOv0b8FQKbdqD+1eGfhMSLG47QjB3MH0L/8lQpuoKa/
    4y+YQdkORQMzxs/4ai4l71S7NhOzDSuuRdTA4VMbilHRh/ByzX4198zAzWcdo5vY99SamT
    XHMaOLU9O47La3A0u0kirBjUIYVd5oULMKQ9W+DvUHnZr4CUnAMzaThRv3yQS882B7Igxt
    2PquUxMgftMJPhUekmSYPx8OJqph/nblyrLBfvOPAUjLdGIPKrJZ5wiViMophroVzQcSCy
    L3vkdfOzHoDCRPqw61R4N76vUYYVxWtBlkR8OrmXBQFfw5sEcqERhjXfb0LdDsn0rOzvbu
    oRch9iIS6IfMfiMXsaR+R7VFjAgO9HvDoVo+twH36zGyLD9iMb7m+jb3CaSVd1PzpMkgXq
    kv9088WZH51+iNyA5IDFep1poCMz94/a+l8WAT9or+E1Pyxb03abondu2lHAXT0MvdOWIA
    fVPzc0OVf9ehxv+v5l/cOIbsKp6y5M7BS1RfQ2ewyG+ZF5FhD64FOpEobPWI6yCQ4/k7xo
    Ad/OoqXWEBuCSaua5pyUIoglMnxqYxuM84f04QomLXfZMzZSiXY7r+r2qC2g
X-ME-Proxy: <xmx:48lfaqmcz7UZtDfntNaz34Nsfuz9Za1-cZGYzAWYvKru_WDB3dRn1g>
    <xmx:48lfanAYMBIFPlqFSHSyZQbuDbJ4BuV5PqYd27BLkZYcpjPxQdbfcg>
    <xmx:48lfapgFZ3yqSNTf5MbE8IuIpCWvm6XIV5toFQ_thGWZvf0GQEpjRw>
    <xmx:48lfakxCxwFO9qeRxRd5SsBfE8lR32d_8qpSmzFEeQov2eeE0dOybQ>
    <xmx:48lfaqbZH3C4UVc3jscYEbCyFGCQ9b56k5XN3ZpxljFnpTXLgs9OjT-K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 15:34:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: tnyman@openai.com,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] stash: avoid sparse-index expansion for in-cone paths
In-Reply-To: <al61UTM0aK9j9eiP@com-79390> (Taylor Blau's message of "Mon, 20
	Jul 2026 18:54:57 -0500")
References: <20260720223118.62821-4-tnyman@openai.com>
	<20260720223118.62821-6-tnyman@openai.com>
	<al61UTM0aK9j9eiP@com-79390>
Date: Tue, 21 Jul 2026 12:34:57 -0700
Message-ID: <xmqqik68w2zi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> On Mon, Jul 20, 2026 at 03:31:21PM -0700, tnyman@openai.com wrote:
>> Signed-off-by: Ted Nyman <tnyman@openai.com>
>> ---
>>  builtin/stash.c                          |  4 +-
>>  t/perf/p2000-sparse-operations.sh        |  1 +
>>  t/t1092-sparse-checkout-compatibility.sh | 55 ++++++++++++++++++++++++
>>  3 files changed, 58 insertions(+), 2 deletions(-)
>
> All looks reasonable, and it's very nice indeed to see another one of
> these /* TODO */ comments go away ;-).
>
> Very pleasant read, this series is
>
>     Reviewed-by: Taylor Blau <ttaylorr@openai.com>
>
> , and looks good to me.
>
> Thanks,
> Taylor

Thanks, both of you.  Let me mark the topic for 'next'.
