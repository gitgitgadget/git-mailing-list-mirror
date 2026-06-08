Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC0376469
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921596; cv=none; b=uHU0zOrh6XULcsckzFO1J06UmrbtgOaNZLflCk/R0vbaD92YO6SMC0ZelXE3TSxx+t0oCAGPFwSYvc4Rm87r1NRAU/nW1ZtlqBX3jkeXDvbLkj/4p/l/5+7FIyB2ON0CDGaosipFaUVuiDPRYC/Zt/cxOCIWvu0BC5FloOJs5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921596; c=relaxed/simple;
	bh=yT4fetGuvNg2XNXP+he/4WkBudHfBd9O8LDNaM75nIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WdQrF4PY7sYyHMuAlNHFNOrIAT8660u00vkbmhNqEUQHi40n5J6tK208AN4l00JTo2TFrxE2n6bQFgtzqigVGCFo6ZF+ANg+Ml+o6eq1nAZZcrWOBfYn3mLi39vxM6GumnNwvaYtANlGpJuT1FLkHO3NOW25jUV+QUGg2UZFVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VKMvh5Yl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHHqo7L1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VKMvh5Yl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHHqo7L1"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E280A140016F;
	Mon,  8 Jun 2026 08:26:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 08 Jun 2026 08:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780921594;
	 x=1781007994; bh=jb7tzSM+BjJjpa5lxO8unNyITCOojWgwpV7yW7SyI2g=; b=
	VKMvh5Yl+4lu5pARvvGTs3pWGT2UTw/OfwzbXrUeOp7jqynxg2mmY4ium5GqJlMy
	3eSrXVOnEn72rnxgKkxNUBq+o/6LMN0RrxgLN3orzFIBYES9OY6kLVlVM1ZQ622o
	zPnqkVwKefhc5hdTiLuGOXga2NH45u4gKanodQQ4CNIWnz0sjAsOlRZ9A+PSHdNX
	cPD8ZSsIKfphuShvsMaLIlC3HgJ6rxz/MN3NpRawZ67Gw8NhA56GJ/Qy5j6TcpDc
	tPA8AyavqRD50mbjRUuS1U+0Imz6Gx5YF6d8kNaO+OIFj92qziQqs/zsaSmuO99M
	aD3GXX4XY50oiEXJc+Habg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780921594; x=
	1781007994; bh=jb7tzSM+BjJjpa5lxO8unNyITCOojWgwpV7yW7SyI2g=; b=S
	HHqo7L1moZCNBdyquBrJz+xMsfLEHOJZ8nNHoPa9kEOMOhB3e5NlVGBm/88/MBym
	M3w3m77LDt++Ncd5SU4X0xTF7Ve6KsEnLdqsPIH6K6l8KDTXnJYTbly3t9KtWP7M
	HNMNo3joUxbXzXCbblUBweWfZ035hC5TWOtsgK8gr8RrbSICU3beg8ANGf8HggKA
	U/Bb+ib2cbvXPb8Bgi1e3lrrdtnDY9mYRbxatvHhSbGgkLYkWz4iZVHIPF4KAJz8
	ruoDuOYIUKMfRGY7yozXWmjsIBpXhDZKEpYTcSmfAliqdJq0efC2/bItl9FzMUiN
	jTEdEIW3QTImaPUUxUGmw==
X-ME-Sender: <xms:-rQmapE-BMLhQZdlR7DQj6QZMpeOyI2rrW0MQcQsD2blX0x-zTkUag>
    <xme:-rQmalPQ3fIA4Fbs_zQj3Mf9gdlatV1oHxcC3XOij9o1hftCkRtvmE94XBgrWbfYB
    _TqLNlch1kI0NPAOwDFWdllUokYWR7X4g1DeODr_RMyM0VBoEuoWUI>
X-ME-Received: <xmr:-rQmajfYMlsrbbh0kiet48bz5rSZlw9O_7Dg1sZvAW381gpvG_Dgj_KBTxvu_ueyXcDxibDVeTAYZ4ZUGFlP5EX-qRNop2a5QZ9N>
X-ME-Proxy-Cause: dmFkZTGXoWbCHkc8yo0T9H8u04CLwJRFVlQ/UR9v7Vy5P8Q8poLgekCU/8daW2M0CQrk/b
    an9pYEFrXM29DD69E/ZDibh4TSffQXDlluQW8nVCStZjOG1gZlMjwMx1gKz3pHCyLeGHGB
    CcXsLxC/+Oym2y40CWGkxFUw6fed8U6UVcezorLJAENj7TicMfgk27UFlIO2yYh4FdXroj
    MNjDIo03iJ+B/ng3kQpqyL1ywL2Ptd4TQR7q4YpLIVE77F3OozHhIoC5b9D3hl2+MyM+y4
    8ObXGyB8Nmv1yyFBZI75chjXAxrc347l9SG7g3hwJS8KMRGdUTM4gdzlgPuaflLHNd4zV8
    ldOmNNuSZhQwa50v16zsATVNuvJzwUeLZA6/qVlbY2DtjRE9kQF7hipRh8dJYHjPAR1LLe
    fIrOAH2QNkCkuRWKDm/ewOq80ps/15HSMxSfmz7kjxxy5Hu/gkc/y6SH9awhAyAIm/TpNZ
    YtZREcql21jmG+Fqi/EBI7Ft5Vw8yFe2QKc9i+NXlLo9MCd6c4t86Ca40A1S6/Z91vzwBp
    7y4fKAltb7y2Nv8SJDj7EiJ+CKtXHebFkgFanyCTW3Oa9wc/VaGYAjXTo6qi8HXoA2HPAK
    78qN5YOo1UprK6O8XQGjlRTZEdBMT89UV2aaMMZL2F3PZbpoyF5e94qK2Yeg
X-ME-Proxy: <xmx:-rQmaqujPA1qgIs-JRmliDWIrJU0VqyPRV1a8Aah0F7pcwds3GhWrw>
    <xmx:-rQmaskOl342J9zFxn_lSCyhyDypeamZMXxq8r2p_fXP3-0-dPa-ug>
    <xmx:-rQmakw74pBd_O2a5J7XM3B7h7XBCmVddPGogOMGKWcYT9qwwgFlLg>
    <xmx:-rQmamPP4tlWHmOjnlTzAxTjxlvKcD2SfJ3Uz5porkE7uqzTPPiqFw>
    <xmx:-rQmapFiPxwaYFnozG3vFRp8XZKZ4C5elxAEMzH4K7lEipD1iPhheIgT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 08:26:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Michael Montalbo via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] diff: add long-running diff process via
 diff.<driver>.process
In-Reply-To: <CAC2QwmJwxpnrPNW6YLm2uXKaYjkUwjVsPN_U+c52m0rNe95_Nw@mail.gmail.com>
	(Michael Montalbo's message of "Sun, 7 Jun 2026 10:04:58 -0700")
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<d044fa0ee5c9cda7dfe4f663f34443103521ef43.1780087700.git.gitgitgadget@gmail.com>
	<c7987f11-9181-3975-552c-14e74abb2c97@gmx.de>
	<CAC2QwmJwxpnrPNW6YLm2uXKaYjkUwjVsPN_U+c52m0rNe95_Nw@mail.gmail.com>
Date: Mon, 08 Jun 2026 05:26:33 -0700
Message-ID: <xmqqik7tz092.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Sun, Jun 7, 2026 at 7:36 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Michael,
>>
>> I stumbled about this patch when it broke CI in Git for Windows, where we
>> do _not_ use `NO_PYTHON`, even though Python is unavailable in the
>> build/test CI jobs. The existing tests handle this situation gracefully,
>> this here patch does not:
>> ...
>> Given the complexity of what t4080 tries to test (error, abort, crash,
>> bad-sync, no-hunks, multiple files in one session, capability
>> negotiation), it would unfortunately be infeasible to use `test-tool
>> pkt-line` from a shell script implementing that `diff.*.process` protocol.
>>
>> So I've spiked a demo how the `test-tool diff-process-backend` could look
>> like (letting Opus do the menial typing, so that I can enjoy at least part
>> of a sunny Sunday outside), which also passes the CI build and test:
>> https://github.com/dscho/git/commit/b6e3c93381b00929476c3a00155f7cf7334a22e6
>>
>> That commit is of course not intended to be used as-is; Feel free to pick
>> code parts of it and integrate them into your topic branch. Or write your
>> own test-tool helper from scratch if that's more your jam.
>>
>
> Johannes, thank you for the great feedback. The historical context is
> really helpful and
> the concerns you raise make a lot of sense. I will take a look at your
> spike and also work
> on removing Python from the test.

Another request.

Please do not force readers to scroll through a ~800 line message
just to read only 5 lines of response from you.  Keep relevant parts
of the message you are responding to in your message to help readers
understand the context in which your response was made, but trim
everything else that is not relevant from your quote.

Thanks.
