Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAD3CCA19
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937980; cv=none; b=qlT06tZyrMuV1chqdCRj/OIEjg28XdByj+X37zyW4QHUc261X0dn/BcyVho6UXa+jpebMqexhlq+GSyJ1aFyV+wx+4NcComL1XTz7nN4rXbRtKXECXPiNM/GeA9oczf6eMBD+ed8xM5giXxco2j0XUy5IFCVZryK3kvYrZZZycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937980; c=relaxed/simple;
	bh=DoQFYlQgKYHvs4HdiR99g25WquMHeYaQ6+kiG99Pbx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vANaaKHIJmtuKXCVbXuqvojBhy3M28zm5ZcK11RCUtfR8lDX3i9emhy9quPc79THoodTxKOg0v0TTOrBKc/OasMFhkM40/fBEsgH7xPnsBkZqWjYv/8jugwj+lLf+GCWgyQArWFU6lbiHW3nIL+PiNRzP1nctYvzcIRcgrq5+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E8CvugrE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SI9GOrCB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E8CvugrE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SI9GOrCB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8547C14000FF;
	Mon,  8 Jun 2026 12:59:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 12:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780937978; x=1781024378; bh=DoQFYlQgKY
	Hvs4HdiR99g25WquMHeYaQ6+kiG99Pbx4=; b=E8CvugrEq7eOqKoZzIkm1RtrbK
	lfIxyubfMQlV/y3b4v0cm/Qvv0h+sx8xKjTEaAy4YXkJTdDYmtAlAuL+/JH7cRsX
	xePMS2zSoIEpzsOWfxh6P2lcKlurtkrFfO8AUrJrzRz46j1knIt5hpwfEl9klYj/
	ieAw49+Wp/IDQeN71Upooz/zlVkaknRvECprrhiQnrFtBPnlpFPkpenlXs5qgLt+
	bYfdW2qz/gr5S6yQxsi7LKJi+qXbtIhhN7jxBtv0Cy5rhIzjzdG9CAhOfcb3UBo7
	eJSBFxbbnTLirSfdCe+8oSPF5MZIu+lKLsPVcv8Jz2BVKe3ci6ryMrYa0jkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780937978; x=1781024378; bh=DoQFYlQgKYHvs4HdiR99g25WquMHeYaQ6+k
	iG99Pbx4=; b=SI9GOrCBJ//y64pADZ9r2vbEQOxzDhf38z7bFbh9Inoo5Q3bHbs
	Hyz6mEpIrmfSHZHDKuywjOz5MFscIbOX4/6gcfhjFbtELcFZIC7K5ZJLk/xulDVh
	lRx4yf45xrxpTsrYUq6iKyQWDD0MCilqeTePZ+6lM+hnnm8OJ0N8XRmd4iwmL2GV
	wthddA+efpyv9M4fVErWeefhV5wr+I+36JmdPr3nOR6nqEwPbELwouZ1G9NXVB4Z
	sF0mqNKA+NnwkqvJxxiiSS4pQBwI6OURLfUSaU0x2GhfWcpWiyjzrbWHuGg0aEnE
	m+KwQeJE4lT7SmWP7AEc6ukX+/e2BLYTkmA==
X-ME-Sender: <xms:-vQmasv2657IIOfYuDW0vyXP1twue1GzeQaq67IE2gGHhLXZII-yGg>
    <xme:-vQmag5uKOnz_Muvm9EIb8_Di70jt5xhrRoqi1ehzZUtVQuN6G4k3HqZikiqPKgnA
    9nXn9lXFumTVY95mjDP608SSZG26XFP6Wu5NFRQ8QlqWVQ5ZAVwTQ>
X-ME-Received: <xmr:-vQmalJ4fWZmFTTTOuva5SbTzEZH4n64hB8EKWDg0YE6B5yblQ_QZH5UXs33TgUG-To-5hayFvr89f-7SdK_W-CuA91TowDjhSGQ>
X-ME-Proxy-Cause: dmFkZTG1tYeBvRq4DHsCqir+xJE8wE2KZ2EClMchBklfO3RfaNqSe/KhW6bzjmG8lIhhuv
    z+tT+lUxFo122cLgpSdppjzyYzNDkalnSIEfTLTp5tABKjLT8rhMCKtFekoEzqCrLvlAJC
    gc06Z7D+6PWD2rGm+J/ZD/B+LvSD+Me/UUH+UnyMCSvN8OHRnFXUivNzpZJcOG4D35L8yB
    wkgfUgmKLj3HPKpvEjNR3j+Z9RHemRvH3/Gz1UELAKHdRglCU49rScdg3z2C/Iw9vB6vje
    07iE9P085ia3KxjSSKOrUhCZzBuyBdY+2svjqCrXhYhrwYQK4mZFnnLg/Ti1zo4IL/NsF/
    9hxLxkyBsP27wmiYSO54tw9EQsNTnkn1Drm3JwyKHcu1OYHxIpwkiuQ4GEAN6maUSJH90E
    PuIpz+4ltCSjviWYVYKrI/MuH28aJT74VAlMAXSnxBjgqzod7KohoB27hD7SGbWQgoWI8m
    SFluqepeK+E4P+ZFt5wE0f57PwHeGrtekGV8w5mtMde60zYC1MWZJKwNsJPlUwkHCwZYlQ
    722uf2s6q9bFYiAesPnmIkNE2+GRgEe4ossHNXlO3pmY4PmyoTa37ncjt4UESLwBC/C8FE
    8QtQvc2YnkYKtzxTZM+EVifBS0kPmo+A4uinIeWM4bFNI1o4qDF2Nbzj3PJw
X-ME-Proxy: <xmx:-vQmao5q6E1TTGQ8zfnspSel6ytpL7MAAtQAFPeCAB_OtNvZWBdhZQ>
    <xmx:-vQmagxu-sRUfeOGTSrfFTT-zp68VQRMKJwBC3kUozBgKKgmWmuywg>
    <xmx:-vQmakYkIcN3pQehL7mIXHF1ovcaz8i28EJ3HbmtWxUR92e0OmI09Q>
    <xmx:-vQmaqRfDm6WR3T0IUx1zbHgMhO4hLxKEaVEYBvhBOFvVlx8MuhmKg>
    <xmx:-vQmajAuVV8PIls6ETcR0Xi4eD_ZjbY7eLTL4aqcwIw1Ai3KvGGl6TAS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 12:59:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] worktree: record creation time and free-form note
In-Reply-To: <CAPGaHktHLPUeSuhETwyBo+jE2fMu40jHW284PN+2oY1YJ2j0Yw@mail.gmail.com>
	(Norbert Kiesel's message of "Wed, 3 Jun 2026 15:51:23 -0700")
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
	<xmqq1peots9i.fsf@gitster.g>
	<CAPGaHksjsSefYmGPBxKLw8DDADR5AwTiHTbHq0UyBBtg3CKq9Q@mail.gmail.com>
	<CAPGaHktHLPUeSuhETwyBo+jE2fMu40jHW284PN+2oY1YJ2j0Yw@mail.gmail.com>
Date: Mon, 08 Jun 2026 09:59:36 -0700
Message-ID: <xmqqjys9vuh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kiesel, Norbert" <norbert.kiesel@creditkarma.com> writes:

> I looked at the usage of `.git/description` and I could not find any
> usage.

GitWeb shows it.
