Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F68499F17
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062986; cv=none; b=EjRdTVI2DpmS2qXRU65F7ptnzzWyOSGdxCs9WsUHNHzsgioiskxP4SILK5ti56BP9nUImMzowvYt6hJbjh03lFRTavduuI0cvVmKpFWnlJZz0XWYejSGCaPwSHuYDiLgaZZm2viD1Y6XgEh3fFX92cZYLPss77I4SkfuOlsAmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062986; c=relaxed/simple;
	bh=mnGojnksPayLHP9V2z3/JaRhVo7/j6qg5Zrt1gE+haM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u3bbO6N5WuPIa4YmM2FU65iYs+g6x4gXgK8SQkmAU6zh7Ow5tFVEryp5ehJsic4dyhA2pqM9mMqAfjugalp9jliunAN7rN0hVTCi0Y12rgHM8p6ZEK530FwjClOUOMJ2mo4650BZlBKmoFt6VO4u0xSXKh51iVKQfU8ssjWbAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pG4k0mHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ku6zvZXd; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pG4k0mHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ku6zvZXd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA1CA14000E3;
	Thu, 10 Sep 2026 13:56:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 13:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789062984; x=1789149384; bh=mnGojnksPa
	yLHP9V2z3/JaRhVo7/j6qg5Zrt1gE+haM=; b=pG4k0mHalngwy2GHSFTuvAUGZy
	WQyWxovhQyM/D/rj21wtZxEAWOsNyLTjLHh0Yp7mEZNM5xILyRWOFPuZvXca/FHs
	PaEIO/pUCneIrj3yTCPt737NqDfz++pyrW+2dGEXO2qjYQTvBv0MtGSUy643NncR
	VNguCfaAP5LgXLCK7B6ER7W5YQrV7Z1HV2AtrHdymj8n7nYd0yQ/1eNbXZGFirRP
	R7RslPD/sc0WjpT/SHTvJJkQidtIbwi/j9xfxY0fYq57HHC6/w5ccY3MyesJguK4
	ijBqWD8Nk4q3r5NKizldEDRnXIpcb7eSCmILVUjDAxr+rlZD3tdeTPpG4Ddg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789062984; x=1789149384; bh=mnGojnksPayLHP9V2z3/JaRhVo7/j6qg5Zr
	t1gE+haM=; b=ku6zvZXdvLf10jFbkD+B9pLciB9QHd0/KSpC2nkAAlb3Au83mkM
	eAlMN+JbONBNJe+b7GIufwuDyEO7mjU/xRP4eTbe6JqzCz8rfTXlixx9UHtDAWOu
	86GWTSj3samsyo0Zru0UHpop9ejoob1XpmYFUhVFlLS/G57tx3e4FjQX4MLolCpA
	9L7zWvdDeU2mB+ezd24oCvoDXsuKuakPhBCpeezcEO+S4jFhE90LWWvjw2PDgIt/
	QJlZ5Sc0kwOZNj6SAnUCZFuJjThudW0sPoeyBhhMKJGdDcmoDYx4wnkOitd5nEJ8
	vNsyVJw1WqdSX3mgjOyxYrGaJGqakVedzdg==
X-ME-Sender: <xms:SO-iavYrk1jahTgbtNoJgtUD0fcjUUb0ErjYyR2dc8jLk89DIEWdbw>
    <xme:SO-ialZ8Hy4da9QLP6Tx216QKlWiG5haqPSV5W67_hYqOHrMnhB-IsrDPEvm9K3Dh
    wqMzaoKmWwCX96Ul4YvrR6qf0RBhnSn2q_f8G5rncrjs5KwFLczzQ>
X-ME-Received: <xmr:SO-iam9CT45XUM8baoI0uvwKaPfnwjqm2b645SsaxaSYwVR1lj4gryovkn5copMm9oV-zO6oDLNaTs8MR9ix1MwFgIWp4oaCOBuv>
X-ME-Proxy-Cause: dmFkZTFHMI7CppB3qrvWN6acIrnl8APm4g43DEbnv2k0Jl4VACAYvtHc7GpDYURZ7vUJCQ
    Fhw8C7xh+tjM0F9kqbXZqWgm+1wUW+G3x6fSyUUEra1aOPXsxrTD2dSSBhvP2sQsv5ADBt
    qARydslPBpVoT5Z6aQ/LjeDcuBIZBgyiOJbhhwCat/ucDqPbvwyTepd0zqvWBR7Rx73SDI
    RiDDp2E/FMyFZqt1DwEQJX8w0n9/ojpZiddhNsDXGKBptF0Q7ZZwyizI3cjDvxYuU9gbj6
    utP89sbdXMAjWRgDigV8fAODQMGWHimUehs1yWpXhwHqlOu4IgaWunSsE6wSub2OAnZaoM
    AJSzjtrB2b6Y3R8C+fjePf1OzgbB0ET6qo2JDYV/gin7lay098Vzljv71PSPWM/aKTFMAL
    kRqxBmx8ej01Vkoc0bTfR3RyMvwMuYhP99EdqTmOtLtIo09tWJXw5Dh8Sa6lLU3hSMF9G8
    z6GzdT62kdHixB+ZdV0LIW9WhjVg60re5Js6mNiqn95IG7ZVtclq5YnI4nRn2ROkpk6Giw
    1H0AgMkVJoIgbQHJVmjNZ+hACTMgBKJfqHL5SqC1/CMxgfyoZsdy1ca90o5AGL41F8N4IG
    dkMBDIqf1c1b5Cdzql4WEDfZMZVe8Zx6ucQ/14OZ6h3qvJ24shnoDq/+TcSA
X-ME-Proxy: <xmx:SO-iakgR4ybWf2_2omjd92gVeft1JIJpTpxlktPN6YwojKU-9jd84A>
    <xmx:SO-iamdB1puxY-W1mZ1dk5PIQrHcmizbTl_LwPRTWsKfVeqcgdcI8A>
    <xmx:SO-iarqwhsS0v_K-1Rg_myK_73YfAZDP_Xn5UNz1alpNpwfwkyUKhw>
    <xmx:SO-iarBug29eOFTMsKQTnTsVX4b53ABwhjlPscs1h4DxljyhtvkF7A>
    <xmx:SO-iamtK9NhQN2P_RcQJPbtPR0ZVycaVhoDPqQcEdNjmbmAnvt-N2WV0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 13:56:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll via B4 Relay"
 <devnull+markchucarroll.fastmail.com@kernel.org>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH v2 1/3] Update t4001 to use modern syntax.
In-Reply-To: <20260910-modernize-t4001-v2-1-ac53e9f5d717@fastmail.com> (Mark
	C. Chu-Carroll via's message of "Thu, 10 Sep 2026 13:07:33 -0400")
References: <20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com>
	<20260910-modernize-t4001-v2-1-ac53e9f5d717@fastmail.com>
Date: Thu, 10 Sep 2026 10:56:22 -0700
Message-ID: <xmqqv78ddm7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll via B4 Relay"
<devnull+markchucarroll.fastmail.com@kernel.org> writes:

> Subject: [PATCH v2 1/3] Update t4001 to use modern syntax.

Documentation/SubmittingPatches::[[summary-section]]

Also "git log --oneline --no-merges -60 origin -- t/" may give us
some hint.

> From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
>

Documentation/SubmittingPatches::[[describe-changes]]

> ---

Documentation/SubmittingPatches::[[sign-off]]
