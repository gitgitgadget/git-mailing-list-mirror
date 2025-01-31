Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D496199223
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738367367; cv=none; b=eePOALLwDUkFjLJQ1g0WSMM/HdIX71IRTJI1yq/XrmbZWudlSwZsZe+ugH4c4vWwKOOJpQi0+KW8HWWrSCMas9XBXGPmiv09nhtH2kzdghJ2NnzZ2mRdqLR0+WJLWCT6pVokgU9bJAIuL5//ramA8xnBo60r+ltZVr/5WHPlgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738367367; c=relaxed/simple;
	bh=ab3VZc0FKuzsHHXQJ2PO47sp+6863+j2rbn8MOXqt4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xim2UoSnDtHHRH1JIsW8xDxPgsf9ANsTjbPcj0GgPxthgPtRD3gJClKVsrl+l6YI7yAy0XX1NBzCDQgcCvv34vmgZUhyRN5PUeVSUP/XA6gGfx1YIl/sttg/SmCL1cxXsaKuvg0QAigfavGBbYp9Zf8VR1VIU4rhD4DMWmdO+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tl38z+Hb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nDquQKS/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tl38z+Hb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nDquQKS/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7304E1140105;
	Fri, 31 Jan 2025 18:49:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 31 Jan 2025 18:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738367364; x=1738453764; bh=/2yVwYUkcx
	P/HxQTg902waYx2ru/L5QGMkPygYvSWeo=; b=Tl38z+HbAt5HBKi5wCHfJBSGoy
	ou3lgqO9b63h2YQHzD8iJEHggXd8tXDz6fBQrQxCColYSDV8P1YpNowpFL+7YBt9
	4Sw20+uhj01D94vWFu/MhyCeoSkyHE1ajI1F0W/PwuuspnXP8CFVs8Juwr/kvlKB
	5g0YbTkV0dCWUkYEtiLFiQMrspOg190j/2jkS7q/h+iZ3+hvcAu3/zOgxcp0SWwT
	krUxJIqgXlE8nNzAQiJaB96d0StK9G+LoEIW1S86DdNlujWnFw2cQ9oTlqECI+9F
	eMq+Tuqfxf/mbmMCfQZ6RKjjuKR/+5TMePZ6BaLqUQWa9O5c+M9h1ReSxBrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738367364; x=1738453764; bh=/2yVwYUkcxP/HxQTg902waYx2ru/L5QGMkP
	ygYvSWeo=; b=nDquQKS/E3HDYXH2QyE7lP0RKc12StwRtVdXr+gZRfKClLu3D9y
	tLraS85Efil250IAG2eL68ceWiqf7iJxE08q/7h4liZst1LMpYJzZ2zx2Phgtzx+
	prg6lBt0Ixu4CsD5zT1780breE+n9CphANWt6rR5m47Xur5oLp8Cg9vR9yDE+fk1
	gGOZCvTGz1+hG1RHNN5ArUV1qSpqf9VyhsIEoaPhrP8NXwT3tNcpSKVuabd9BWZM
	snzPPYiwGp6ocejkQzyUEV4ieV1Z3OOkaAr2vrLDUxFwFJQxQrnUF1BmzVOWLi6R
	lil/YbvDYuN+LumjY8OPTxLmm2oGNLJWdxg==
X-ME-Sender: <xms:hGGdZ4Ts_qJ-WwyJxABeLE76fRLDtlunCVyw3dBy-v-kPUWElrZbJQ>
    <xme:hGGdZ1xorzgbV8awthW08eXoJYblgk7aM10BzXovuXLV0vYBb1Bb2XKVIy79zEJSq
    uzktp_nSkEEnyEWuQ>
X-ME-Received: <xmr:hGGdZ11voq5lRAJJR-J86U1MxGRZKIhPtsnkmlsKLwKl-ADD7A3W0QhVcXaKZuxa79_IR_vNVj1RhPlXxsGQV-r0q6nfgxnPh_iD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hGGdZ8Bk1t9vZc7k3R_ZLrTusZztP00rcgmGLiuPRXVV_gsdLVMU0g>
    <xmx:hGGdZxgqEYo-TmVt71SWurZwnbgLe7vcN7vf1_1Rz7LsQwrMkWzFVA>
    <xmx:hGGdZ4oYJ1S-zyrK2__ddc2E3JZdjYVH0Y0o1NheT0W8f2GeBBL0kQ>
    <xmx:hGGdZ0gAh7Iis1s5S4coGXTnBrl_9wpSyNzVbHiaMhV_ldHDY5nKFg>
    <xmx:hGGdZxdQ7fMbdPmUGZU_3QAgPlJ3yNveLETEFAQHvmnyQRmqgsLTdUde>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 18:49:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <20250131233452.GB3544301@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 Jan 2025 18:34:52 -0500")
References: <xmqqbjvyv510.fsf@gitster.g>
	<20250123003613.GA3900660@coredump.intra.peff.net>
	<xmqq5xm6uwip.fsf@gitster.g>
	<20250131233452.GB3544301@coredump.intra.peff.net>
Date: Fri, 31 Jan 2025 15:49:22 -0800
Message-ID: <xmqq1pwi5yt9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Thanks.  A greedy me wonders if things like this can be caught by
>> them a bit earlier before they hit 'next', though ;-)
>
> I've always been a little afraid to touch 'seen' since it does not
> necessarily even pass tests, and I don't want to waste too much time
> hunting problems in other people's topics. ;)

I do not generally recommend using the tip of the 'seen' branch to
those who want automated testing, as it more often than not contains
topics that are known-broken (which I do on purpose, so that I can
point at GitHub CI failure to authors), but it the automated testing
includes automatically bisecting once 'seen' is found broken, that
would work fine and it would be extra useful. The next greater step
would be to feed the bisection result to Copilot or whatever
programming peer of your choice, and see if it can fix the breakage.

To help the idea of catching before things hit next, it probably
would make the most sense to test the tip of the 'jch' branch, which
is somewhere between the 'master' and the 'seen' branches and
contains a bit more topics than the 'next' branch does. The branch
is usually what I use for my work every day, so even though it may
have acquired new leaks and UBs that would not cause troubles in
practice, it should functionally be a lot more stable and usable
than the tip of 'seen'.

Thanks.
