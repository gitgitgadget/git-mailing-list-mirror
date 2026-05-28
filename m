Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00EF345CAF
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000624; cv=none; b=g121nunJ/sd5LLWJ32x+UW0WK0U+RCuESt/Ut3DRYFfz0+9rb3wqyCB8H2dOe+C/d1P1CgonCTdKm4MwNIaAYFfHDtwxtn4V65eq/6qAsjPsYQcOb8TyqHaiFG5AZ/IP2y/bdoJOxoM1XLS8a575hX8YMKijIinTlHRGcAXjWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000624; c=relaxed/simple;
	bh=LVo5MEOzsIvPurm7gw1jMak8nn+hSurCbgTLH6GFMew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkqTZYVygLGz29Cg+wKfSk/SPVC3Zp8oRHGuPMomSZwkGE6gIxOnndntHmyicK6LvWCDEd7YdkQbKyGOejWAFpTspQWCS2+eS7MmoeYRNSDCeX1YgfCI3tmV+xeIHw0MVGJx2Eyi/rDVdEKEubquz1PPSrEC71AzV5fHUy15q0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WdsAP0k0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qt+WxTIi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WdsAP0k0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qt+WxTIi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 21370EC0081;
	Thu, 28 May 2026 16:37:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 28 May 2026 16:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780000622;
	 x=1780087022; bh=LVo5MEOzsIvPurm7gw1jMak8nn+hSurCbgTLH6GFMew=; b=
	WdsAP0k02k8THQnVET2ZjXg0d8tfwNGBeQ/Bup2Zon8cpfpZPXstkZO+SFsyc/x5
	xEG7IBrT9FxEKEba/26RvwRlMRNzbIRj+lG7q4ncrj9XUe9Ei0+AD1Zj3TS8Dfdh
	RFQG5e33t8bX1nZ2vVnsfw+lU8eazeXwJT5Wb5+THW4IXcppTz92q1KLZi7UZlM9
	iRmpmGBzN2Rl2tSzgFRTyvOCSozlusrLmktBifn2tSHPiGT5fPXm7Lzkturylm9v
	FJx7oLYUcvcMpBopEXclaHo0qyQmA2kMWNKGvwGfFPeQ5wroMsdrwODTmfF6KrLX
	ue8tbKzr4p4BAPVzcJxa9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780000622; x=
	1780087022; bh=LVo5MEOzsIvPurm7gw1jMak8nn+hSurCbgTLH6GFMew=; b=q
	t+WxTIi7v0hkQcRkQ3ObStGgrrX4cabwlV5GsMtm3sO/uJnd/ESubeYJ9drHKML1
	yT9IN7dStnE124frT55H+E5hhOUZTWjjtSJgbKBh+zahW/qPCfSXVpZDMXDvRnpl
	WF1W738TK+ayZbqAf1T1xHzOOST8992NtD+1kgKFpqs6jRNbOPVa8gnEb6Cyzd8W
	3DrW/HErhdDTnXue5lsucOMYvWLCzUBEvMYOsA2kcEM/l08/tP7ygr049cqwZD9N
	M9NAnEMtWquycn8NQRT1gxZ2WETw13CW7hYl+BzA4U9kJBvVN4lWpbqDDHEzul+L
	1WaXn3SLlE9g9QgvtBS0g==
X-ME-Sender: <xms:bacYaimyGB5kAv39iatd8RJMqkjzrjCkM9IAl0jec60YHGeP2sFY9g>
    <xme:bacYag1yjy8qprSXmm2rOnrs0VIOWY71CtXlV-r4l3kSScu3sXjZUcrpI2R9b6FFo
    kK1FcXSYBWHjrOtzTqJfdDYJ5Hdxkg56iVl02CgLQUj-GU3gtxG>
X-ME-Received: <xmr:bacYalpLcfgJ1UBxxRvKuvePPCeK1eEEWemlKjRfFpa6GaY6a5JXqGOzHjKzfbQz_yz5EiSZlmJwCUslD4mxO1PSHYul7nlL4r3I>
X-ME-Proxy-Cause: dmFkZTECVzQmmezIJiFfAp/YsdcoYGdpdIDVWGo57IuOeiSBmuA7OjXLrX1umrS3kuMy58
    qadNJbB6TaP0iLGHzVlwa/Q7RkyJYwLFrwuNfKm01qqvgoaqIUNkmAyXexqQJNg78mvV5t
    jnIJ5rQ9qeXiXZcepdCX1TRxOpyCxfBrVZr1YGMF8BqAOYjwHPrVd1i7y/3PfmKbDanmZL
    CUg8sVk6Ehv6ag3v6gyk7ePKfuplfswXUC3AkC0JK/7dwhR1ZzCNhEDJ5w2jHpZdszpgr/
    Hrvpz4BE4V2wnt3KwRbWDLsb2LcxVeuOwHrggnYKTDJDZDu/TkseUwsizp7mgh2V8FJSXo
    M8O/lf91RUvAFPkSMB0SHFN1t8zryPPRiL4pr9GmVQPpxjgkUHUjzjcNGJOYg59TlN5MXk
    As4TDMYyIF+xWNYwdJ65uHXrfVYoDvmx4D03h+FPZUE4bKA7TkVm2k7i3uWoAoPCqioY0R
    +g5LG7rlEauElG+zRoltpA4zZWup3zGQwO1dvKxIObV96pFti321PGWFMPOI7k1V4wcAQJ
    teUunAoG6ZK6qKqyoscElpkboHNqZDhdixEB33j1NWNf/XGcN6Y81BZ1k6riDL/efFxy0d
    u9eEsiP6D4qAODCJYvAoJyLkNFBO/9BNQzrwEiGAS0S9W7hM7hcB8yEPMgPA
X-ME-Proxy: <xmx:bacYalf_B-49un9M1ah50Va7yl16ldX5TovYXluYM5lV_HDZHRaBew>
    <xmx:bqcYasoXRQxTo4G8LIAn2Dwwp8VxcygXsYxOeGcWf5Dp5j0Dw-vqBw>
    <xmx:bqcYauHqmLViVd6Uq4GTBFhy731ewv9Bdn5QGBWNSh0cptJ11syOYQ>
    <xmx:bqcYaks7eeINH3-oOH1_z2jCAd38rN37wmcvAhOEKwNXAMn9xC-7PA>
    <xmx:bqcYahJmyPkyvy_irmqOQZbk1CZlSw9E6odL6ZUHpLJ9S_TGMFV2Mp5t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 16:37:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Andrew Kreimer" <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typos via codespell
In-Reply-To: <a48b62b8-2fc3-43be-a5e3-22189efef0ef@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 28 May 2026 19:53:08 +0200")
References: <20260506101631.18127-1-algonell@gmail.com>
	<b8d57be0-b03c-461c-94e4-02340b5af77b@app.fastmail.com>
	<a48b62b8-2fc3-43be-a5e3-22189efef0ef@app.fastmail.com>
Date: Fri, 29 May 2026 05:37:00 +0900
Message-ID: <xmqq1pevjmoj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sun, May 10, 2026, at 00:14, Kristoffer Haugsbakk wrote:
>> On Wed, May 6, 2026, at 12:15, Andrew Kreimer wrote:
>>> There are some typos in the documentation, comments, etc.
>>> Fix them via codespell.
>>>
>>> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
>>> ---
>>>[snip]
>
> I went through the typos in my previous message and with the exception
> of `po/` they all look good. They are all either documentation typos
> or typos in code comments. And they are all legitimate, in other words
> not false positives.
>
> With Junio’s email in mind, I think a second version which just drops
> the `po/` and git-gui typo fixes would be good. Since they are different
> projects.

Thanks!.
