Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48430FF31
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123336; cv=none; b=QzplPS5sXVwWJHY93NmWPKPPDWBUV4EkwUFOQDCyw8dcx8lNG37uxUHikCAOJQX1qOe2N+dHP5AQMmfslLGMbawwcl7t2DgqU1k0Tm1rlVZ+JglSV8ESjWcaRG/JWgTnCbEPnYmRbDc9B4N3sY2EhkI4BlX7QbcTrP/VrZZLi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123336; c=relaxed/simple;
	bh=zR5MrK8r97wH8EdwJUyBNf2IPcGlPrcV7ZQkYX5C3Dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KRuoK3DJ8kEgu3eP0ziOCL+mq2rWafZB0sS5JpFEFQPZTiCGPNXjDeVF/RKb7+Q3YmkpxjVYmJN6E5QwAFRgAK3mHx6obTRJ4OJ233ysnjsV0F1+TChHSXeNWiMg4jhEBGmFIeELsI+Y24OonpBkNziTJ7UXll6uyEwNPhHZ9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QgDjX9mL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knx8Kf6l; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QgDjX9mL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knx8Kf6l"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BAAAEC01A7;
	Sun, 30 Aug 2026 16:55:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 30 Aug 2026 16:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788123334; x=1788209734; bh=zR5MrK8r97
	wH8EdwJUyBNf2IPcGlPrcV7ZQkYX5C3Dk=; b=QgDjX9mLqcBspihW4gW96feeKS
	O7RZvM8qAonIDjuhK6QP0j1RMWImLZRJiFbU5e9qrQzrplnu/8M67126tQwSkVdz
	HHy6h7J/g04VXQB0wN1MjDr7Xfxx1CRydH7UkTDb7cE0Z2BLkHrHqjXSOrhI133R
	3R4BDAzsUafx75mTRhPqYuJkPykXBVXsEX2tBEVX1Qk87xWEY7nJLic0SWY/ZATo
	SQns88I+feg+WvPX61UNHx2T7qHGVbgCrE9F6iy3VtTjIEd7bMIFcEg6RDAEQIKu
	riRkiqwkVjlzoypwvaFTczS01mt8kPTOuK50Cd+OHB08Dri29klt148sePbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788123334; x=1788209734; bh=zR5MrK8r97wH8EdwJUyBNf2IPcGlPrcV7ZQ
	kYX5C3Dk=; b=knx8Kf6lRW0wvcNui1lNDxJfmMw4CmarXerSAfnnradp6UcOCfQ
	7V8wtxJOqqVxQvjJhhhUxFP5KFxofTJ7fvKSriYIiG0ghDrFqpL2i3n0+Z/wRoBF
	6sxJreXsM6J8M0FHSD940at5Dggt1fDSXkCt93cAnVZzF2/hhS0Q1g6cPwDy/P+/
	a5Q7u/RIzup5vvkArA6aoBAHiKmBki8t9yIn38HnyEi2JiEWgC4ThJPlkGLV3FLd
	ALNh2aokIfFrW8CUa/dTheCosXmNXm/88Fr1CjX5dN0ZQS144daL6PsbZt1h3dI8
	PQ9xdVOPuEyY4Wg6z3wUGh3HTvK7jvmHgrw==
X-ME-Sender: <xms:xpiUap0k3wrfbYBGiDIcBME5haqUSpt4RVyjaQ7o09CUNWh07mrzgQ>
    <xme:xpiUanicdbRRBj666k4uv_bqV055DN55NxmzWzNO18pCOfxcsJHRBcgoOiQZRO9nT
    uA-l8jHsJoy0-yjGqT_6DwHdkOP4VZkwJ4eIBN7xo_lXqswowqaSXA>
X-ME-Received: <xmr:xpiUanR3xQO5P78lvqLYku8SBHC2TsgF1f2ZvUk8fwgQ6FvinMj-lRHTHU61G77RDtsKSsGl9DuHAhQy8DktSZvbX025g5fNvw>
X-ME-Proxy-Cause: dmFkZTFWh4lA6xlU3XtGveLQOh+EzTbCQc5x44y2lTRznvHnJy9d3yPMCdOTeABSInvr4y
    4nbvdhvUJXvRdgbunv+g1hVHrKvu59xFnysgf5UCaYsOTnp1J7teDWNM/itYc4Mi6ER8x1
    EaFuHg+v0YqPGwW1X6RyFWmMcJmnv3+v4MV8SHjGeBjw4KUhe25RPuJOXMwLjbfG5g8H7P
    4zClWrPv5AXJJmt020yRqZ3PxQ7scjko1zFyiP7skRCamm5Mb9ENlwcz71tuSR5KZD3269
    LD4qGektT3plf7JoFVoJRqV9KpOPQkvTTkTv5alW+DAiZTcTN+DCLZTTcL3IVE311gmGQs
    xVmUBnig8ZVp3kjt/MKAkh+zSiqF1w2Buz7BqAUsziSxxNT3n1aEUYRDg3y5GkS8LXfmhZ
    MaUXf1PVuCIIKqpqLiZUk0+EiUoen9BMqU/4wEnRqyXYyulSgb0W0fmYAomdfDcPrGT/Jw
    qq6qSW8BrIuSle4PIQReGPovKHq1G2RgtEuKni6ZG314rVGPL8VDKkgaivMUrBv+C0j3Yf
    r8mE4dfSOGcw28Ix3lvlak5AVS+AoQrJqB7IBFmxxCQZBVtVg6vWOjMhHis358T3UNfKrR
    TzMSttH+U44jPLh7LwnugLOIXd+p93uxSLdqPOcLTiZH3Hvz/ryWKYdlIxYg
X-ME-Proxy: <xmx:xpiUagiYIKQpgio8NSpKV-JzQJT16bL-NhKsuFSSOmruuFkr4hfRXw>
    <xmx:xpiUav5mOaz6GF5VgX659EU2TXEdKuhgfBz8lyUCozjp1Xayd9Io5Q>
    <xmx:xpiUalCPsifPu-PqoIxo1HQYxQE0oetryNuZAn4DGra1pkd-Q4abfg>
    <xmx:xpiUaubuWz_frk2xsuGZ_CA080_be_okSL-TXsmmae0fjPS39wBIOg>
    <xmx:xpiUasSPnbxYNqjw_qpdgeQcc2ySxcF36hffYRbrQydGBaB7X_pnuK5l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:55:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] die_for_incompatible_opts(): unbounded number of
 options
In-Reply-To: <20260829111549.GB40814@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 29 Aug 2026 07:15:49 -0400")
References: <20260826233152.1703497-1-gitster@pobox.com>
	<xmqqbjana2wv.fsf@gitster.g>
	<20260829111549.GB40814@coredump.intra.peff.net>
Date: Sun, 30 Aug 2026 13:55:32 -0700
Message-ID: <xmqqfqzv1g6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Aug 27, 2026 at 10:28:32AM -0700, Junio C Hamano wrote:
>
>> +void die_for_incompatible_opts(bool opt1, const char *opt1_name, ...)
>
> I'm mildly negative on this, just because there's no compiler support
> for making sure there is an EOF somewhere. Keeping patch 1 and using
> LAST_ARG_MUST_BE_NULL would be preferable, IMHO.

Let's discard this topic for now.

I do not like the second iteration very much, and I do not like the
1/2 preliminary step of the first iteration even less so.

Thanks.
