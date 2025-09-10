Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDB2F747B
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537372; cv=none; b=uygTkTwXP3Bn5W7V+xnQ8stZIADIQYJnUeeQWHvjeigkjz/KJQWe15OxxuV2QvfTQ3JrIrq39yZ8qZqajgiyy+ehTc5Urtjk9D3OSQHQ14GH/n2oiryQA491ZPOlGxoE04BsanmfZWjei6Dx9dLedZ1rq3cJcwOpPX/kAH+QCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537372; c=relaxed/simple;
	bh=c+s4Rk5L6eBToeW2Yt4noFrs/jYIjoE0+E4i8g1wL0s=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=qYXAFutJXAAlCvCaHFlbEczk1QVQSZj5hI3STQmKl0Llw9ndYuLz9A9H2yyfgOpWr6tLE64jF5t6ASaMVd7HKpMOfguuv8VuWahDS4fPkvmxuxJgLZiKKIrrI2iB8lqUpAR5XooCcg8IIXcyqmuZPkMpOV7sHTZR3U3mPkwof60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devjj.com; spf=pass smtp.mailfrom=devjj.com; dkim=pass (2048-bit key) header.d=devjj.com header.i=@devjj.com header.b=WI0cWKJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFYz4D2V; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devjj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devjj.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devjj.com header.i=@devjj.com header.b="WI0cWKJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFYz4D2V"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A9D25EC030C
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 16:49:29 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-07.internal (MEProxy); Wed, 10 Sep 2025 16:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devjj.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1757537369; x=1757623769; bh=c+s4Rk5L6e
	BToeW2Yt4noFrs/jYIjoE0+E4i8g1wL0s=; b=WI0cWKJkBOyDZ+GVe1Hl+4/bD6
	Z2cHBDC+vBeTSVLLPkt9O/xoI7oPZC72mODEtAFauLxirFc4k3LL6LoSUwH8UwmI
	5xwNonVofcCbeRdPQ/yxy9MlSP2dGxh47KYSApJNseA2K7PzUyk3x4n4W69aTJ+0
	1bIti+Y0LXwRbGLcmUTTl93Kjwg31XtxzQJSO1gR6EkV5vw8VkZ1jH+S0g+Z2uu6
	fCtEaWq3UchtIGP9gJQF+uNizQN3jPwm7vhHhHVWIe0UoV65G1lAIJA1uDVF9KF9
	jIqc7HIxD9YUYuLbK8Mhfp+Xs9hgYqW9krRQ10Y+y0Gd7WRJVU4AyaJJo+kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757537369; x=1757623769; bh=c+s4Rk5L6eBToeW2Yt4noFrs/jYIjoE0+E4
	i8g1wL0s=; b=eFYz4D2VnYhaRp62TJezxRXEhJDTPjYeTOFm1rwBO9M+Ig3SgXt
	rGTXWIySx/wM8SSMVeeNaXw4URHTeTL9d/x9rShXxRl+joBjPXUqQMeOTXlZzebE
	VwIfkNuUdzWbsdCyFxzrgLRMnb6WT0BWoBz66+eSIpbcYrNUSGgELRcZUvykncPp
	u2YPRAXFtDoORWpVgVezVU9oDqjCN/uHOAHmxNoz2iBIGE8CJ+T4zaotxjeOuk8Z
	4TK2KZe/XH9mOPCUG+zbbHHSvD3quMzf3lKU0CO01vGjWHh7VTXu90LTmcpKUuJT
	iRP3SjvP/Jfi9Fi+o7qb/SmBnvcWvMNvUSw==
X-ME-Sender: <xms:WeTBaFDKOiqL7uMpoA6SY8N_LhEHcVaOeV3RiUH-iDqYLDIzPcaRLw>
    <xme:WeTBaDgggvanjEzFLlN-0oeMfLM52MHJ8pbuupwK3ih-d3HqhNXk-zuqWVmnH9Rv5
    rUFYkNtdtaakVvTvHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkufgtgfesthejredtredttd
    enucfhrhhomhepfdflohhsvgculfgrrhgrmhhilhhlohdfuceojhhoshgvphhhseguvghv
    jhhjrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefgkeeuvdduuedtleeiudfhuefhud
    ejgfejheeitdffkeetgeektdeiffevhfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehjohhsvghphhesuggvvhhjjhdrtghomhdpnhgspghrtg
    hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WeTBaD4V5gaBHF-N5yp_oKZf7iaIS3PLRWNN3T_bUtgI_kt5Wvyhfg>
    <xmx:WeTBaNK0WaG-5WySTNvXTMrSS6ZJLtu-GYsd6Ukow5MK8ChHAK1hnA>
    <xmx:WeTBaFeW6drva_VILnV-fqZItJgHq_xY-vVZUHaI9dlkTA1-XRRZ-g>
    <xmx:WeTBaIc2uitk9K4XRI_km-HWP7e0SVJxM0c0R5Wu_ug-UBAZwV0nDQ>
    <xmx:WeTBaDAwos5wevp8BTNVuQQ70aY3PmDvdkonfdz7_lIjQTazHHilyuov>
Feedback-ID: i22a946f8:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 079491EA0068; Wed, 10 Sep 2025 16:49:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Sep 2025 13:49:07 -0700
From: "Jose Jaramillo" <joseph@devjj.com>
To: git@vger.kernel.org
Message-Id: <2d12d261-ae8d-4cff-8c46-b81172fe6c77@app.fastmail.com>
Subject: git whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I still use this! ~J
