Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC848986C
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185820; cv=none; b=u4ri+07FLnfh89KgJ+Igl9V6FRgT0birEomv6YPNtoC1TFGT78nYWJhy+ipxYsOlqlkcOnZVb+cHgeG0wBpccPLtf+dtZn1DdoGBCg+/8N0DSKwgDyI+JB3Bd3tGdnOBAN93pkFk0LTNgXWAlXgnmzYGNcx3G7ljh4IY9F/2P34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185820; c=relaxed/simple;
	bh=nd3X1R5slNIjBeGCatlznwIAJT1ml2FCoWUI6PAJSW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RC8ZeFs4ZtQnLyfQzE+kLmuyHJT37zYO6X4bm+vJJdBI5DsqGQ0mqHOo1eJ9ivj3dybR/0o1/Uc2NgWmlFnLd1vMVZ9aN3YDlmaPUCOs+uzmJagU8olbkkRgkcJ1T0f602W+YeqhGNMx6u/BhFMoLPRknVMzS3ClypVgAnOGTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ESC9KIRp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXIXKowD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ESC9KIRp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXIXKowD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E4E5E1D000B8;
	Mon, 31 Aug 2026 10:16:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 10:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788185816; x=1788272216; bh=IMMVqEeBT/
	uU8pl//ZEno6uXUUo7BqQGp2Oh2hazuVE=; b=ESC9KIRprYX5vfI1RZbfnUcoAk
	1YjbEqcOXX51VN3vsY0PBVU+OsXqxN2aAt7SthsK2SwTkfBPl9iXMRKXN+FzknL0
	pYXdj2NHMAMvarAVXksXR/aKWd6JfBrqSoqRTWqyZ9JomDTm7hZxOeN2eIU42uZT
	p66WQYvDDzsyS4/VTXNL+hzbWpMJ5AfO3b2duBnOhUBCNkc392jKQIpnoiz3kFUK
	au46LRWWhW4hD496tFq+W0juJ5nJ2ZiQOQMDHtxBlA21bWP1ugzEHbaSJMl01YEW
	c+/Sr1dQlJxmD+EXRQq5zeDnSk8N2nIEiQwGhLyoCREoke930LBgt7XNU8Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788185816; x=1788272216; bh=IMMVqEeBT/uU8pl//ZEno6uXUUo7BqQGp2O
	h2hazuVE=; b=PXIXKowDjU5PZD0SUe25jxd1PooSavBQ/09//XzwzBSzkq4NGA+
	NZ8nhm63CnX9JHK7W+jC5zvysQchqhr+v+XMDbPLlSO+jggSjVQCAe4oFMF3pWAs
	ATLhj0x4gH5dwfIFTRYazjw51HQxh5QowllIlwXk68OELowMtW7ot1KLRS4JpFcq
	9jc3Nexi81EeNo0JYs5a8B28WEo8OYbHQ3ZcilR2hqxQ2orHRO7Rdu4NhQ57B9vH
	9blIJuG9vfvICpCo4JOzuWXUZ4yf89YClupcFxUIZuP96ADRkl0F4rKEicM1rXV6
	kkLEwAD5GelkQ5xUXkwJ6SKIF0sIHjJGD/A==
X-ME-Sender: <xms:2IyVagl4wRw7B0Vvnx1kY4GHWjU80WNzPns4HFjSIvTEoQEVmTXq2w>
    <xme:2IyVajhz9X2nyjEdcW12-Nd6bAYjAXJy8A2qRYatIqDyDE-kV3_5DMaVnXnC0nNLr
    8yAswGLVePIOddd5yfJjXn7pONxS3YL4U-3eI4bkzsRzgArvdx-ipY>
X-ME-Received: <xmr:2IyVaoe5aTduHBgfjgFcvunoa17BdTDcF2y5FFu1E6grzHbK165flLhVWKl7PKL-BvO3iMOnzeITSIezzBaQIuxav-jfNlK_3w>
X-ME-Proxy-Cause: dmFkZTEgqv1SB5BPcquukVFdg8U8GcEbueu8fqmJRxvf4GmSA/iGPB+9p/WASEKKFFJwAu
    jsWHcvvLeTwNYNURXXOi7DZll8DhXEh11+fvTknDNWHZsNMw7e9F6Yf0nEYuEOrSCaYD3U
    z+8+4e2oS4prEVW9JlQGaRpOotvWuXPXJC40QQAJz5Y65j5WOF6AJkzSFPhMRU6Ew74clF
    VF4x/OzCAgYvpVhqLKAsOkwZsP/BLKY06R0qCGS01ZaqTEWE+7dfA5hq4ByLE6S/yaTw85
    X/rFM3XESziaGolOSmkl5FJKX6iFgkXAKeCy+q/2Nna3eLShHBtr4XSi2L0Plt6uzm/jIk
    ULVwmsQ6QrOFm2NW7qtuBkZDJnCfEJrrjz/M34xl0blFZ0ipGwtG/smIXCmCE8GjXB0PAU
    Oq/wVaWvHGZz0FgUUDOfxCM8VD0SKZ9QxlaRDAMA9vsJCywqcqXeYvXhZerfvDwZ6ZTyrQ
    5rtOEcHOZjHH762jQityZ/CLsi50UW+ncBgU1t2i3AABxS71CSIyJILfwPETmiQdSNgf6Q
    DUXIXjAnNgp5amoCxKjjRIoxAFGZ7Q5WLtijs/W98xZP/fm/2BlOk5BylJVVOVKfkkqfEU
    DEJMdsC3x8PEaNNvslRvdvq1ICxH/Ro8+vjHvTyCFEYsmj8LV9GWEy1oUpEw
X-ME-Proxy: <xmx:2IyVaji4FJP0wKdieLQFKl1VN8BNvSVKfBVBG751RQnZxjdeGtKCsA>
    <xmx:2IyVagyPageA4rjPv8eMkzPYA0dw_-olioANl8sc7dDDXSSLULf5BQ>
    <xmx:2IyVavPOI7uvP-5nwdmyAswAke5fkUNQ_t8OxmTjfP524OYCuSIl3g>
    <xmx:2IyVahXmOWo_Uy4PB1sleqlNk9zcwNeuzFx9qQWKi-JTJ5XELFOgKw>
    <xmx:2IyVavWfArj_geOJMYArFre3DXqhyMlSnO2M8ISHPAYHTgyYyqgw4sDS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 10:16:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Grayson Gordon <graysongordon1@gmail.com>,  git@vger.kernel.org,
  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <apUlqvXgChMeCUkp@pks.im> (Patrick Steinhardt's message of "Mon,
	31 Aug 2026 08:56:42 +0200")
References: <xmqqmruqt36l.fsf@gitster.g>
	<20260818214858.65122-1-ggordon@gitlab.com>
	<xmqqpkz4czhu.fsf@gitster.g>
	<CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
	<xmqqld9q40ww.fsf@gitster.g> <apUlqvXgChMeCUkp@pks.im>
Date: Mon, 31 Aug 2026 07:16:54 -0700
Message-ID: <xmqqik4qz86h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> They do look involved but seem to cover the situations we do care
>> about, except we seem not to test when the server does not explicitly
>> say "this is still good", or am I not reading the tests correctly?
>
> Isn't the following test covering that scenario? Or am I misreading?
>
>     test_expect_success SSL_VERIFYSTATUS 'fetch succeeds with stapled "good" OCSP response'
>            with_ssl_verification git -c http.sslVerifyStatus=true \
>                    ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
>            test_line_count -gt 0 actual
>     '

Probably I misstated.  What I meant was a reaction to "fail close"
floated earlier.  A server does not explicitly give stapled good,
and the client says "this is not known-good" and not talking to it.
I.e. 'fetch fails without stapled "good"'
