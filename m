Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD952E11C7
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783804712; cv=none; b=SkOCSfdB6K641Hopj5Fsr7IKj39gFPtZTR7NR6Wp+MD58mvcrnAanaJ9igYxZaon5la0Z6XnyphX4iuMsih4Woh/QbpFypD9p5pJe7NKlIs1mmz06v8t50wpjGpg9BzUYqa4vAPEFeqM46Ws/9hh3BdIWkLUJB8AqLRRlxsAN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783804712; c=relaxed/simple;
	bh=GGIbDFdx4VH/sKQJdnZJWp/hw6Gi9yL5i+A1BIR+C/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3reAvF8AZJS0XTYJaK3Y3quf7yoQ+Cv8qwGph6MTf/B3QecNjmHSDFiLaVAwdQzaPOUubdv0k70ir4wMuqtcKCyb+QLqNWxG8gcLdIFCWIoB911I5MmGDapBdj1gfEzkGgD5vMbdosMpM2W1D19bK0CBsKAJvei2XZi/dlt04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FkAOibEQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzOd3nUR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FkAOibEQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzOd3nUR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C7B4140009B;
	Sat, 11 Jul 2026 17:18:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 11 Jul 2026 17:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783804710; x=1783891110; bh=GGIbDFdx4V
	H/sKQJdnZJWp/hw6Gi9yL5i+A1BIR+C/w=; b=FkAOibEQXFO0MVQkxrLRgR7iCw
	2ky16Ycy7j8gdSgM2Rs6Yc55F5PzkuMkppmAm29kEyLacA9lnH+/YRti9rDB9ZZ1
	keJm9MsJRA3DSr0rSXX56LD2FQQ2nmBxWvMcdfQXN+/BV8bkbbXnAcYqM9nZ/5wG
	NlyfYj8YKgsMN7IcfizenRHk3QGKHrUKMODMh1C9K8m3fyKXWk/IGbBi48gWticn
	yNiXzXXTOnDbiz3QNpSrtuA8skGScaIiFcpnWfL3jAj377ovQx5ZAJqIbfVcZQpO
	iaKngnzWWyFpaDfljTJFUeaDVYAHauIAmATxHPbcyU+iFeqm2oVIZjRh89Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783804710; x=1783891110; bh=GGIbDFdx4VH/sKQJdnZJWp/hw6Gi9yL5i+A
	1BIR+C/w=; b=GzOd3nUR/Z5TZX4XI6j8rDBzbsMi9EUfHNSDbMQYNbqfKjHwb5g
	+VbkwslaJZzn/fatVkxpaU0GjpsVCO9Uu0tvJPIZV1j4JEuhJMRc5WAA+sBv//7u
	NB4/1DmN5c94VFhfcnfBFDuoLWMDbsIS75S/RqVg3mcoQeEWax7e7NiBSU9BTrMs
	sDuMOMn2Nv4x88G6Ce6w2ed52IXf3chMYsscGGSmteXg9IasZPkborSae2xVxR+h
	ufot+zZ6jN9GpDPfjrHNpWftDt50CLXAMie7QZeiziR2qPNxUsHawveCyEtMOpgr
	Ndiznvgztg3fKwt/whwkPUTxY6p316fH6Lg==
X-ME-Sender: <xms:JrNSag6oxjvinMkJ7m0zuw_At2sxkMl1lvy8oQ33t9wmf5umpt9wuQ>
    <xme:JrNSallj6_aIonEjKMup_mBRRMsQOxdfXQbz6glUrocibOPa1mSdFk5Af0-t0p_qW
    iTVPS9oXdG6RQRL4ezbj6_7sxlKCGQV-1qr5ABLPp0FPpSKjGPfpA>
X-ME-Received: <xmr:JrNSapSdSqrDQqR39Be29UznmG8W1IrTkbNv85DDMamB4etA1gDXQsJWbGRJksrUEeppq2Uqbdj9DumlhVN4A70zIqVQor1fzVhI9qI>
X-ME-Proxy-Cause: dmFkZTFCQZqZ4EJfaBoCL3Jfb4dwLD2ynd3K/dZjd0tj/gMFS6uOG+Juj8+b0irZnElUlo
    +ZO69nkMji5HhhT8trZBOc/YvsMWWhYA56984BXaQNAeyFhXOTmElmUTccl9Lq52xKbCfj
    bSQIHQTxrQ6G0ZzlUZWUQT7hr0Y+bkGEZD4ILAUe2AbjglA0tzAmNyYANQ69YCFzuH+Hu5
    SfJnadimDbk7IBSq+hGbWjcPF1QMBlOpzQGIMOP53zG2fujdgS2gtGYEUSdyychr7ImUQz
    YhCLc5vv6AKWPsyM10rWkScvxHGbjpB6LR09cZuED/W5zgUJuxfGGvV1z3KRwn0hTS7KAz
    /RTRIeq3rzqQYv0jFcNX38qd02gnG+Czm+eH+acYgo9OEi5nHgOGzZL1CCFL0RU8vd3lGR
    WU2H6l435PAQsNs4s5GCqycPhuRy+0jMRJMFDR5zdCgDn+rUx3NXxWTsTY6SpMyS9sY/x0
    kfv3/vpg6QTt79Xk+gBSr9MBIPYdXMik4fFi/V7z8Lj7at4txdhd2wuKULql3zFG+HRhbF
    pgCvEq2nEQW/MdDa5gv+UDZUVUiFPxrUjnZ3MQ/XYk3aEA29tusOiiHCROUFnOBH8yjMI/
    oLNvWjwr18rinTTIp12od6GT+wwbz4rlU3+KbfenN1EksahaLxXyvUZq910g
X-ME-Proxy: <xmx:JrNSasF_tQtP_N4xUJNYNo3nCnO-mFN9By6yM7hzEyNKzcdNa9pRdQ>
    <xmx:JrNSamGacJeVXMqxS5TxJvBdqsQdyEuSl5gUd1z22UCoHib6dY3L1Q>
    <xmx:JrNSaiQAQaSJW2zJTFX8wfyWMlfmp1GmSPe96sVJqo-hDZ-dMorNHw>
    <xmx:JrNSavLdBb32mftVX7FPDIMLCt9PiqeCZEh1KSSmyM6Ey_fTeS1-Vw>
    <xmx:JrNSasPgtB_pTZYT49aadBNNcdcOIoRoyjL0wSTfMBBq4nYopnVC_oQz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 17:18:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Kristofer Karlsson <krka@spotify.com>,  Taylor Blau <me@ttaylorr.com>,
  Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
In-Reply-To: <alF4rYSTxpQUC38K@com-79390> (Taylor Blau's message of "Fri, 10
	Jul 2026 15:56:45 -0700")
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
	<ak0DUx5Y/5y1OINz@nand.local>
	<CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
	<alFthqGQjsowvpEz@com-79390> <xmqqik6mbhtw.fsf@gitster.g>
	<alF4rYSTxpQUC38K@com-79390>
Date: Sat, 11 Jul 2026 14:18:28 -0700
Message-ID: <xmqqech99qe3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

>> If the test involved is longer than 3 lines, I would recommend
>> against it, as "git show" of such a patch will show the full code
>> change to implement a different behaviour plus "_failure" changing
>> to "_success" in the test, with the body of the test hidden outside
>> the context, which makes it hard to guess what the behaviour change
>> is really about.
>
> Hmm, I am not sure that I agree. Or, at the very least, that is now how
> I have written series in the past where I want to demonstrate and then
> subsequently fix an existing bug.

After applying and in viewing "git log -W -p", there is no such
difficulty like the one I described in the message you are
responding to, but it makes it harder on reviewers on the mailing
list, to make a quick pre-review based only on the material that
they can see in the e-mail.

It may be easier to write the commits, but given that we seem to
have more patches sent to the list than reviewers can review, it may
not be a good trade-off.
