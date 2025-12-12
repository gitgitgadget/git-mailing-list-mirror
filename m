Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CCF1DE4CE
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506031; cv=none; b=hxwZBTGk60pLLVbjTVEqABZgRheicWBB9W9UQvry/z+PqDJz5damGYd0Vgz7pIoQHge7j3Bj4Ftv42uWFl3ggGx8gMkFpeUtXFGf2LJU82q7Y4iV8va2uD+UKh/8czaKJse+QlMSl/5e/XPUaJ5TBhw6mOhXa9Nav+Z5StuTds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506031; c=relaxed/simple;
	bh=2ndv+OMt6Ys5amhD7HWdH8UxpRJeqADBiQzy9Ogzrzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfbVPBSFYe+/Rdp2on0kTIr3XRu4++GSYPmySSJflItjtkQx08a3rB7WF/41MCdiCnO0aMid73oGX8KRuJS2MahovGsQ4n32ANPLQ6pZHac+nc4fa0Ip/ABVlCYnPorlnyN58SFq2DpGMCoja/GZTuE5JtN85RWerRJNLX6KmyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KZwS5OnD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aM44O4T9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZwS5OnD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aM44O4T9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAED914000D1;
	Thu, 11 Dec 2025 21:20:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 11 Dec 2025 21:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765506027;
	 x=1765592427; bh=gcj4kgZMeF8W6or8FVC/3YlDjkCFnE7kA6ph01QAXLs=; b=
	KZwS5OnDkuVaDSDoGvKgQ+JJ10GwnjsUMvA5pSBHyv/gUR2VwYTQjzFUQTnLnRJ7
	QhzZMyW7rScrG7nWzMTINTp0sdzNXcxqwDKYqENPxLj1dBO4To3YbPUtzplujA5v
	0bOXObkVeVY1cOXzpxIIMX02lUv+FT4mjuc+ZAIMxIlsyTymdZvKdgPyzhcDzUoa
	RcGWL8d+hG7h8/sC/HWM570DDaJVDdPpTQodqOBWkiIbyMyQjshH+5e5t0sXmJ1q
	lOd0uEQVY4uV30x2T7hgEC3x6ZFttCbn1SGVA6rLkAtLGYB4gNoL0tsm4XS0QSZl
	+H8h1W6x83qEnebTo9+n8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765506027; x=
	1765592427; bh=gcj4kgZMeF8W6or8FVC/3YlDjkCFnE7kA6ph01QAXLs=; b=a
	M44O4T9geAI9+ENb7KVJ1pJwCjyJfusuPnK6gl4qxc6LJ03NC6IPGGRInjIYqfDL
	ksYZVqi5LsV5cTbTw7QVwpQh6enYHv+Kam4iUfR3Fnzl5MH2G7XiJMLw19J6MaS8
	lxqhzd/S/c56MUpUyo3sYGs/3pLYxwm5adO6tAx5DEnllvI4Ztgf9mR4TwboCZ1A
	ZKDid4bWmE1TmB0iIEK4AC3LRTBbopRKtX/urxk8RLQHmN6TPbfc9RrV8dCD6wBQ
	4TnjM9H4AHuAffVJ0gi/2c8q3Dxs/kqqcwmNm7/rQwsH7mJ8yxBQv6VPktanvTt7
	JPCt+FumpwVODjv/hRgdw==
X-ME-Sender: <xms:63s7aWpyRYhqyMDiiKiwmni3Wp7l9XGDNr6rMNeHaxSbdDRVMhFR7Q>
    <xme:63s7abjZQevM_qzf7w_bfWIz21Wo-DY-2KJ_BB6_XOON817rFullF-jSKXNcpL2GQ
    jFSLZ6cjqlaK9TIz1BEpyxRS_4NTCdcfMZgvsuW5RvpWSTVf7LGkQ>
X-ME-Received: <xmr:63s7aTiWVz3M1n7IANkmMH9Pny5cnfx6RJCPC_nPoo7d_AlIXMlgk-Avve_F6LSByjkHW1G5qHWn1RA-iJKzCuZp9bbsdd80oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:63s7aRhwgmD6A7yRMDZOXnYX__tZGCwfkZkoI4GHuV6id9VnD67i5w>
    <xmx:63s7aTIHdaOjPwQn8fCxXbGVhZXACDA3ED-DyEjAv6yB2WZ136foMA>
    <xmx:63s7aQFWX7-JEJORPaC0g9cmVCDDh2nH9IIZGQKnh2ZZTbzDF2sKWg>
    <xmx:63s7aXTMAaB6heFSCn6N91oaOnpOYXvr-T7vkMlguBxDiW8soDaG5w>
    <xmx:63s7aZgT6mG68hnTsh4Xx5i38BzFymSbPK5QhF0SqIwpmphLC8pzGxPW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 21:20:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Koji
 Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
In-Reply-To: <vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 11 Dec
 2025 03:17:03
	-0800")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
	<qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
	<1b3509d7-e421-4136-a62c-de86213d65b2@web.de>
	<xmqq7buthgq4.fsf@gitster.g>
	<vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
Date: Fri, 12 Dec 2025 11:20:25 +0900
Message-ID: <xmqq7buse906.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

>> I am looking at relevant parts of Makefile
>> 
>> # Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
>> # installed in /sw, but don't want GIT to link against any libraries
>> # installed there.  If defined you may specify your own (or Fink's)
>> # include directories and library directories by defining CFLAGS
>> # and LDFLAGS appropriately.
>> #
>> # Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
>> # have DarwinPorts installed in /opt/local, but don't want GIT to
>> # link against any libraries installed there.  If defined you may
>> # specify your own (or DarwinPort's) include directories and
>> # library directories by defining CFLAGS and LDFLAGS appropriately.
>> 
>> and notice that /opt/local/ is mentioned for DarwinPorts.  The patch
>> that started this thread talks about defaulting ICONVDIR to that of
>> Homebrew if available, but the new code checks /opt/homebrew and
>> then /usr/local/ (and let it override it).  Should the log message
>> be talking about DarwinPorts as well?
>> 
>>     As a workaround, set the default libiconv location to
>>     /opt/homebrew when the user has one from Homebrew, or
>>     to /opt/local when the user has one from MacPorts.
>> 
>> or something along the line?
>
> Since the original patch was only meant to help with Homebrew it
> might not be worth mentioning the OTHER package managers IMHO.

Meaing that the original patch should have included only
/opt/homebrew and we should drop the part about /opt/local?

Or do you mean Homebrew may use /opt/local instead of /opt/homebrew
and both parts of the original patch are needed to give coverage to
different Homebrew installations?

If the latter, perhaps we can say something in the proposed commit
log message to explain having both /opt/{homebrew,local}/ is
necessary (and why)?

>> By the way, for macOS newbies (like me), I wonder if a patch like
>> the attached may help?
>
> Did I read that correctly and you had found yourself forced into
> running macOS at least somewhere?

No, but I do look at CI output that includes macOS jobs every day.
