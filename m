Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3699286D73
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250377; cv=none; b=Gw/612A46Tg+/0/ynFtWR/JUEHOAQ5/GHrTBLuv6yZ7Qw5oi3JkMtzo3CBL0NUHaCvYtZa2INtdsR8tEloxsYoZjKPIpYB7cEIWxH4XEZN/emzz5yw+XIwmNbq2NWg/lfCG+hwNxFUGVemBb1iBatZSew1eztOEX+hSJrnZxufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250377; c=relaxed/simple;
	bh=qOzRuJwsgvhycuAUP7t8lj0y/XZpNXBCKx9/8GJKA+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IalYvnzigB/Br5yTCtyNqmastpPIis6HA+KY6a9uEHqH/j8zauE5NIMNpoxMbfowycKjyXORfRxtLftzrA0VXoqBNS3fpUOWJ10d3Diejwk6peVrNgMWA9dZ6hCXtEAtdNtw21mGUfbSxrI1QTBb5YgGTtnaiOHCbU3gQm4RE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VF3DtWnP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2Hw3Cibg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VF3DtWnP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Hw3Cibg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76B9C14000F7;
	Wed, 11 Mar 2026 13:32:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 13:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773250374; x=1773336774; bh=Ic/WiYbri4
	pu6HFHEbblfGPQPAWu7S1c26ufIs9gP2s=; b=VF3DtWnP75owzo3Nm0fAdJQTq7
	Ff4jzZMTcvcc8jCDGPRZFazlKXA5ta68xQIvaQzRDdGxUSsdR/6rj5vnFabHRJrZ
	YYQWPWF5Hu8jvAcuOtwp9G5obSO7PRgWS4ycLM9HuuEpLxiV4y/66OB3o71H6qSo
	o6sxr3gkSdjf5CU9tbZ+mhbxraZsBqfKy1vNocMPyy7XKsbyF/hFsI532oxBuCl9
	Apksaatgi4q991WJBJhuh3YHwK0bpklnQg1H4C4MvaiARicQI3uPSm22iHY0ozbB
	D4ycatr9/8WRU50YR5MsCXfdHMw9vcoywN5qxbZ/LlyMd75RUMbgN/zHDLyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773250374; x=1773336774; bh=Ic/WiYbri4pu6HFHEbblfGPQPAWu7S1c26u
	fIs9gP2s=; b=2Hw3Cibgf7v5jxPQTU21OFbyYYgkeYOx6h54RLL1H631ZsXAvFo
	JxlcQkBeXmj/pQ3hwwjfK16D/7hhRUAXlWgy823cY4t0VNeeJOQVAtiiAOjEtaVm
	nvY2xBceSVRdxfr9JIGZOF1bAeTuGpaWzg4PJnz5K3Pb2GUwp3ijbMUXwvPn3+21
	6qdqoQA1eluGUU4LCF9+bcw0Qf6Z2HJ35tD+VyNtMnQzwfVGRdrOqXk1qWkb5J+c
	lytol3PGFHsKPlkXxVIHmdYCYU1O7Q5sABS3XO9imxORhxAnFKjrfJ32hXINXLO0
	MKDfROmgQcDuEB9FNDQzyhPrHiNIAu4gUcA==
X-ME-Sender: <xms:RqexaWgZ5XQoWU6rEtPVUtRRf2U5xYgAZiS6dOwlnraiuSv22IqtAw>
    <xme:RqexaYhr4Lsbz9QmOmghf-AY6_YA2-IpyJZhRbEgeQ1gDt7g-QYnqlZsk1vjKd8gn
    lS5IonqVGzH-XHQ6VkUiS1m1P-exqmaJGvsUN4a2O7RnPoA8MLdbw>
X-ME-Received: <xmr:RqexaeK1n-UzClof8uY5zWBvjaJo1VZ75e0urQZ27StISwmWvXJu4dqbe1ow2xdOaOIsD0oyWLcVuXZWPsQ1zlKkNTMv_dK7_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesug
    hunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:RqexafHWve7c3KpOupx-b0Et0YPvXsgLzM-4dFCoe-4ILzNTCX_TrA>
    <xmx:RqexaaRSVrDCzSqN3bo5W5AhZq5Lv05y0ROF7ZtEl6q8xGGav_PLaA>
    <xmx:RqexaTfJoQGJqwnM2vb71OF66ogfDw34cTHjugiFxYhh2OZu3fylaw>
    <xmx:RqexaRpxIYawqdtuxyUpartNf5iKyRiFD8a8XzzPU5lbIUE-owQ2jQ>
    <xmx:RqexaaXNTtSc2Bmour8N5wTCr-RnoR4ziZ-mVSFEV-eHWlZE85_4Ig1s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 13:32:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] editorconfig: fix style not applying to subdirs anymore
In-Reply-To: <1eb3b78c-5833-4fa9-83f6-237d4a3e78d3@gmail.com> (Phillip Wood's
	message of "Wed, 11 Mar 2026 14:16:53 +0000")
References: <20260311-b4-pks-editorconfig-fix-subdirs-v1-1-4938193ccd31@pks.im>
	<1eb3b78c-5833-4fa9-83f6-237d4a3e78d3@gmail.com>
Date: Wed, 11 Mar 2026 10:32:52 -0700
Message-ID: <xmqq1phqqnjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 11/03/2026 07:09, Patrick Steinhardt wrote:
>...
>>    If the glob contains a path separator (a / not inside square
>>    brackets), then the glob is relative to the directory level of the
>>    particular .editorconfig file itself. Otherwise the pattern may also
>>    match at any level below the .editorconfig level.
>> 
>> What's interesting is that the _whole_ expression is considered to be
>> the glob.
>
> Ouch, I'd missed that, thanks for fixing it
> ...
>>    [{{,**/}*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,{,**/}Makefile,templates/hooks/*.sample}]
>>    indent_style = tab
>>    tab_width = 8
>> 
>> This starts to become somewhat hard to read, so the duplication feels
>> like the better tradeoff.
>
> Agreed

Thanks, both.
