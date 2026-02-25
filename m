Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7F2BE644
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044667; cv=none; b=QtCQQp3qCNSatsAVEWRlN1qaXeeJRG996d5r/pxe2/a9b4jhXtpEiZBnsSiKniD9VEF+ad9Kef2JRXpstcdhc7kV1YE/kBtknD/jqCbfo/V0ss6nzCjMw2CbY6FsKau2JmXJGd6uPaEGtqDP7JPhPBv8kJ8wgH0eKEGZ+qwpxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044667; c=relaxed/simple;
	bh=F7SSNCD0ecLeaV79SruVv1tfSk4F13YkOyFC+T0uRPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/u6Whh7WPLTL3kFF80po01kGlj0N4aeS8Av45mtsKELs1fm4+Q8NESgk/SZXn07Y/xaLgmHW86UkSD/Da/5Xk+tziJNu2YoGnTjdiQgYt8grGx9+VStrbO3dqQrqFMCESOMCgSqCsalqJ7O+aiADHBU3ikMcumu02MFjgzv2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zk5+A7Af; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=woB/Ng69; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zk5+A7Af";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="woB/Ng69"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3D2B1400233;
	Wed, 25 Feb 2026 13:37:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Feb 2026 13:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772044664; x=1772131064; bh=l8DKVkZHAu
	wEdNToFh9g6aYUTBRyyE+L13uaJLiEjbY=; b=Zk5+A7AfiWkacMrv/MoTOyNtA4
	UtyyKinaCoBNIPJWYQgF3C8PKCb6+5LYdYFfZrQNtI44LYLkIdIFsCHa1XnvP5YD
	b9Ddv8TIBOMj+nFbYGVD0oGk0nLy1LYGhwtNvUP1JkxINxBczzVRb5pyqPvZZEk1
	4/2z1BtPU5b9aqyHO1XcWoQzc59Wymexw8DqGRDPcNGIIXf8tvC8DW0rHHpBL7DI
	wR1z8VT+TCMw/7DUncAenURsf5B6EDp3dBgfzXI+7vCp1q9XXChx8VKYW72dowkH
	4CaH5r2/lfIERDbyaKELFea/mUYY//ZcijI5LE1MldHQYZzNqKGSqjT1QsIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772044664; x=1772131064; bh=l8DKVkZHAuwEdNToFh9g6aYUTBRyyE+L13u
	aJLiEjbY=; b=woB/Ng690EgVEf+k4vL6Xfy50CygNCa9Sv9TucosIIXUtMtwYVv
	8bLadw/zpSGnbSUPd3F227cS7jDTxnQXPC4JPRsNLhlnj2TiIrWFgql84oLJLzCl
	NZgZyf+UmLb0LijAVKXu4OuxLXLGBEXhs2XKan1OxGSCkUscHwc2dc0kMv/KPw5J
	SAb6JT1fbbKMQX4sWPoQkCGcjme5LouV4X3zilYQs2sGODjPdnBADmBtpPtLNpvz
	qok6sUo4UGUD6GnMdFaB7u9bJ+xzz0xS0RiFTZaAxcs54BR2Xx4A7f3Hf8CCl9PG
	mt1jKO/IsBMVnohHIqDw1Q7owP7o9o/LtwA==
X-ME-Sender: <xms:eEGfaXt2WYPT3r5LaN4RAkbjf1L9nsEAYOPyNnvNYgGftu7tDfj61w>
    <xme:eEGfafe0HJTY8lWUQuCyCwl6GfWWUo8F9L8FPklo3UN8Ebu7p8WO4DSPTL2t3mMl4
    WFfKHGwJWWZCsjpCEZLKvNVSoQEngHqOnYN0yHdq0ryHhwQ>
X-ME-Received: <xmr:eEGfafwEbU7QVdDroBpQuqdD3bUbCJudf9664XnIlHo2VklBNpyb0n6bxNnkDvzjSPCEmIsTKAH6GpYdrTmlpCUrtu7uu1FvEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdejieeihfegjeduhfeviedtffdvffdvgfdvffeufeelhfeijeffjedtgefg
    udfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpiihohhhordgtohhmpdgtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdr
    rhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:eEGfaVGVVVB7DY3XeuULuY6EBDbcw_tyoJSIa5Q9PdiawbfeC5Fmxw>
    <xmx:eEGfaTyPhKq64vkob2NMBu0CihblnteXB2xYX2OSSs03gCWabHdaag>
    <xmx:eEGfaWsyBxW1crutNXJwSx4jNSuDTEvinaMWyfqZ5inmvJizHh__lg>
    <xmx:eEGfaQ2t6zdS_a8_JEKFXDliBqzj_GtyK7xnvJkA1e8UdsSi7dTvww>
    <xmx:eEGfaR975klR3vpQbOSEmT9ec033N31X1HvQKbIUIM5WyaAdD9_uu8yn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 13:37:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
In-Reply-To: <87ikbpwr13.fsf@collabora.com> (Adrian Ratiu's message of "Sun,
	22 Feb 2026 02:39:04 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-1-adrian.ratiu@collabora.com>
	<aZjuTSopOMvwR4hQ@fruit.crustytoothpaste.net>
	<87o6liw4s1.fsf@collabora.com> <87ikbpwr13.fsf@collabora.com>
Date: Wed, 25 Feb 2026 10:37:42 -0800
Message-ID: <xmqqzf4wacuh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Sat, 21 Feb 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>> On Fri, 20 Feb 2026, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>>> On 2026-02-18 at 22:23:44, Adrian Ratiu wrote:
>>>> Hello everyone,
>>>> 
>>>> v2 addresses all feedback received in v1.
>>>
>>> I ask because situations where the hook output is not handled gracefully
>>> and hooks fight over output or where the existence of TTY on a file
>>> descriptor is not preserved will result in bug reports and broken tests
>>> for tools that use Git, which I think we'd all like to avoid.
>>
>> Hi Brian,
>>
>> Yes, this is all done already. Phillip Wood actually brought this TTY
>> issue up in his review of the v1 parallel hooks series (many thanks). :) 
>> ...
>>
> Hi again Brian,
>
> v2 of the parallel series is out if you want to review it:
>
> https://lore.kernel.org/git/20260222002904.1879356-1-adrian.ratiu@collabora.com/T/#u
>
> P.S. I think your spam filter is blocking all my e-mails? I get this
> reply from you:
>
>  sandals@crustytoothpaste.net, ERROR CODE :554 - 5.7.1
>  <sender4-op-o12.zoho.com[136.143.188.12]>: Client host rejected:
>  CONN:SPAM
>
>    Original-Recipient: rfc822; sandals@crustytoothpaste.net
>    Final-Recipient: rfc822; sandals@crustytoothpaste.net
>    Status: 554
>    Action: failed
>    Last-Attempt-Date: 22 Feb 2026 00:30:10 GMT
>    Diagnostic-Code: 5.7.1 <sender4-op-o12.zoho.com[136.143.188.12]>: Client host rejected: CONN:SPAM
>    Remote-MTA: dns; complex.crustytoothpaste.net

So, shall we make this "hooks specified by config" advance, while
expecting the parallelized execution to further evolve as a follow
up series that will still be out of 'next' for now?

Thanks.

