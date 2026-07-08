Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21843CEB9B
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542729; cv=none; b=H3Ff5O0VTN1jCuani5bz20fEVBB3B2VazP5hFRa6tRfhxxn5uhihBle285+UrQnGeqRDySA9Z2zJVqEO40KJb7bFDDw8xIHuk8pgU6RKiBLT1V1DfGgq3uJoRje8z95sdtgyTSMNDFa5nL0LPOXnp2syVNIJbvIQTqfEhU97DMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542729; c=relaxed/simple;
	bh=eeZbOwQNCCpJJQRr940U6x+8SKUt9TpMtWlMXbayVG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f4V+Yrln89FcKF4Z1pV7noS9CcCcGYVqAXGqg7rarSdpngW38lUX95Rj4kZoVxybAnSypfomqXMVJhO8/JPkMsYo2nSof6hhc6L9Uly5VMGEGqTkeFXngpWpWYtsZfH9SvU5fUMJ8BQlm0zvU8xYTL+ow6wO4nxRNtGUw2d+bwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q8t1h7O2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fsT1s8i5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q8t1h7O2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fsT1s8i5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75C3C7A00A2;
	Wed,  8 Jul 2026 16:32:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 16:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783542723; x=1783629123; bh=FOnrIhf9z4
	rKSqkLHp5MdIDpCYuKMIZjLKoLllJIt3I=; b=Q8t1h7O29cH2dIXWX2IA4Eafhr
	2YI12BPH2tDgXzkQDx5d0zyg2e80al8BqGVbKccgm4cTdAJy2zreXHbyJ0zwjjYc
	EZCh2FkxGJV7jyAR5NFiXYej6P3Iw/RFacfSbb9Wf1k4V3Q5EjuxKovI/g/k7Qx9
	AtwbSMUXl/RJmMGqyx9tC0mO42dEiGL+MzTymJzmL+tFp7ak+rHPZbCid1MPrPsV
	WxAGbLxCYRxP5Jb1risrtQmTvvNcF8JHRj6su6wR3zvt+GuEzc2wFl7O/DBAGF7A
	Jx/ctVlStf8jJYFUPhESTMfbBYqqdHcyHSq5HRM10tOT0Sh171iOKfBT/n7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783542723; x=1783629123; bh=FOnrIhf9z4rKSqkLHp5MdIDpCYuKMIZjLKo
	LllJIt3I=; b=fsT1s8i51IK3GFt5XjSiR4uCuJKLx/pZoqBCnKX82jfb/M8tmEQ
	x8Ai1q+lsgVuDMu23GEvz1umAJCs+8pqxx7pHcH4IsGjfJ0q2rzSUgjCBE4ATPa8
	xwAfQqiF5+wuVczILAzIGPEKJs9QSRVvagQ8oRzNNpCybF5IyZQtzFspPq3DcZGC
	Lh1a/zPOrDC5wWt1b2NfzaMok0Tb2tyewqc3+99Pg5ZEtz4UPWwgrILtl3oljp4h
	ByAHWe3fA+uw7U2zzgSJPaAQZdTvhJwFc3TD9reokO9IdKQixnjNwRTiRhuWBzRT
	VUwEfyXPFTMp/SmJU9sRUKgNoEzXho2gtbw==
X-ME-Sender: <xms:w7NOarTGXq_3ZkMJn6Hy7k7ZjjGyOSHT36cAc0Gls0dMPOaU9khTtw>
    <xme:w7NOajwT_3pENLNnIp9GdkTEPdLoZqwHBiZnfN1g2RdthxswT2tk1DpGVTQl1NVGo
    N5Ot34CBzFNvvSv0B7tcIJIn06dIbmKTqGnIsr0-oOfhzIBizEa>
X-ME-Received: <xmr:w7NOal0mHbtSozUO6jkZOOdQLHKBJSAcJKoSBiSPnEzp3E1eb5LzHnpJcxKrSvK_j5_BpYoYOILdnoZVZPGtLhsPI-JyVS4_3NOfpLs>
X-ME-Proxy-Cause: dmFkZTEfhBmoVuGWpSuVPuqlOx6b/OxGch3E49GVRIn1ythinQazWc6YepparjJSjmKfWC
    scGNLQLnsE/jzqs5hjN8CwyyRHcnm8Dwc93MOobYRoWrhR3KCuA5oUh1w2eaJZOQuoH0gO
    ka2/SSX7glQ6gJEW0fiNzjdSXmzKQA9KmI//8/7FLtznzkxS+9t4Et2ubkXtxBO21xtMNW
    vakJVwS7nT9zHaY+0fhiKcZpHND0TlnM0bT6yX64FsgL5tetRYowfd72/uzuIZ297Q+pZx
    zNRxiqS6wO+SajjWZVfP80SwsHeQZKeRRqF6Magk7xO8r61UGvPMfI/WlkKvbMh0M+tBXx
    GqG+sYmNmu7bzU9mHsJvXKFR76lZRbFLDCXGNMfayWZAHbpJAzJ8vLGUOLaTi+keRz32Fx
    1s2Nvo3aLLNsUioIbP7G/KgHLbQJoayiKo5Sy25eZaHDi397cmIVAdpEl+/tXFoFyBPrxG
    sJi4TYr0pFsLfu6HNNFRdQPB46AxuYt9nAijQGa736dfd6zReOjxZOjQf1U5IzodWE+v2f
    xC5xOHh+fHfp9R+fawJjNvF4Lq02N00z1CftSHa7vR0STTwjxj55M7faGI5UZjQFCa/Sdq
    bUt2SlTHF1Ak/l6mwOsvlEI8kA0Bcrd+K4HiG9Y5iZ90ZGLfkp9IkG2nKZJg
X-ME-Proxy: <xmx:w7NOap7xvLirpRX_S4dv1ChBzk3m671DSExslNROzrOpmtTTwD-4vQ>
    <xmx:w7NOagUKcNiFDO3Y5XJkPBJ1Jl5-SYsA2uGbkWHhpi0sGHrVtKNNDg>
    <xmx:w7NOagAQ57HX6_yueuIKhBncD-h3tXiSaY8xGnwiuY2zuxcwWX6zZQ>
    <xmx:w7NOan7jrJ-w3VoYLlK9P6fGSdCKgTxxzxsAaqRCO7VZPGIbeND0rQ>
    <xmx:w7NOagU_rUWYc3u2Z_EIzKnnrrQhCJz8S5K501JC4yzWEJmP79FqT096>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 16:32:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] parseopt: exit 0 on help
In-Reply-To: <20260708035930.GB41684@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jul 2026 23:59:30 -0400")
References: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<20260708001557.3581080-1-sandals@crustytoothpaste.net>
	<20260708035930.GB41684@coredump.intra.peff.net>
Date: Wed, 08 Jul 2026 13:32:00 -0700
Message-ID: <xmqqzf01rznj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jul 08, 2026 at 12:15:53AM +0000, brian m. carlson wrote:
>
>> Changes since v2:
>> 
>> * Fix inverted condition in t1517.
>> * Stop checking for old versions of SVN Perl libraries since they are
>>   so old nobody is using them.
>> * Adjust the various cases where we choose between the error and
>>   non-error help output.
>
> Thanks, I have no complaints on this version.
>
> In the earlier thread I sketched out a hypothetical caller that might be
> affected by the change, but beyond raw speculation, I don't think we
> have any way of knowing how common such a thing is. So I'm inclined to
> proceed and see if anybody screams during this development cycle.

;-)  100% agreed on the issue of possible regressions.
