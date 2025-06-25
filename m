Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B12676DF
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867635; cv=none; b=ayrivJROU4aHTRBR9QPDo4at9T3fmmQEaPteF7I5PRFpVTjXlv9puZDT7Fx1ilGfUrttSf5AtFpc5fTGLDmjO3aIibeyTarswvS0O+RIySQM4ctZFlKkfJnBlPLpbmSaCA4s2NDtAmqmLBmaaCQzwt/lscIZJP3DJORcvNFez/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867635; c=relaxed/simple;
	bh=nQPasC5WtVLaKKzaO4fllm/xo/xm10lQwt64uYEuj90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jumKirBN7EBO6Np7/6uGC+6qKqKNmoOne+fWUjs6LpN8966msPyztk9HQ56gJFqVjo6XBxiCpnuWZ8miebOcHvpR82yLahm7qU+Q50xDCvucwIh9NX5KyeBX12hkM6QAKddnIJMpOTKCrEYdBK2MUim7/KtLc5Vab/EFedm/8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aIvG7pcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFu+KSv0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aIvG7pcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFu+KSv0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9248FEC00CF;
	Wed, 25 Jun 2025 12:07:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 12:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750867632;
	 x=1750954032; bh=S6KkrEvfxAH9hKBnllPUkagjpbZwukF8tJbjZ7nJqbo=; b=
	aIvG7pcK+vzHftJTMxDa1v4yQKXfk+3+YZSEfGQyYW605WsZeW0/+rJ4onuip2Kj
	JlV7tyIK63ttH1Ygcj2/Ek3JKenbKpwV9ck6CVYfu7VX2cG6ydzojy3jS2Ji6V/m
	sLK9PtvHlpLxaw9tWPZwbU4eIxaWKUMfRQX+ViQThwz10LoMmwqH8hQZ4ZjMLhsk
	7P/VpeerU4RnwDx4ksV9xwfCsOim8r+o8XNdZ0FFUcSOP/JqCcjwA+SA9EwMHzX/
	6hbdNlMfrNjXEx6X61rO7HDwQkJolBDMsUd4chDfceO6fntNgtmapY/KH5M+qsQW
	wSti36aFv3RolYRVpfofmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750867632; x=
	1750954032; bh=S6KkrEvfxAH9hKBnllPUkagjpbZwukF8tJbjZ7nJqbo=; b=D
	Fu+KSv0/SVdZ2B+78lNRU3CZRVkEulu37jJuf6aKPjW0o/u0BXDqB3xvOEtZ8Ynr
	vjvBIoQMLV8GzvI7978ROjddf56COX7msLcHSef7ecHKmTYQSX0pAoIESe0v1a4t
	IItO7Rd7XLX4crzQX3INvHbkWxm1cZIahnbC7/ktVcfTvr0Dt1JlFfNvbT9KFvLT
	nswAIwB0GpcGOC048yy1UXYG4oRNOqLWEf1cosImhXQW4zg8KLdE5cbAZ6GvHu5S
	kY0RqNgs22574qrwEr+0RNtdjV/JrHERXliitdH4lLzMTX6YL0yrIAvPoMSrooJv
	m2F7lzaS/2J7/D36+Tkcg==
X-ME-Sender: <xms:sB5caHEfhJ8Fl1qjrKS63AdC_A1Ytz31KCGYBg0E6fs0EabrKIltdQ>
    <xme:sB5caEUFo-EFQT8NUw4AOHnYtDzwL8Hjy2m7l-mkiiu-FCPyTVUif_JwM8UTgSJSO
    29fibACMUo8qJTPVw>
X-ME-Received: <xmr:sB5caJKUITIoOvGKwk5e-m4cxRMxzBuB7zKCeKf1A0k7LZONW78IWxjZE0cv-fwYE9lsxoujYDYmUGT-dHVXBqWAVKzKH-Au4yuzyls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:sB5caFHaQluVuy4ztk8qUtHZWOX54r6S8dyETcywOEBLGygAgbT9BQ>
    <xmx:sB5caNV-i6i8XhBMNNSWWDC0d4a1AfY6ScKk3ETd3cArZprg8qmd0A>
    <xmx:sB5caAP7mjozXfaqhzPbPCf5kPrGy-f7Yuhxwbe6uUm3-xg5PS2MAw>
    <xmx:sB5caM0j46QiOjXdOTrcv-NgBbElyCull1KEpooSN83JyYYCYXj1gA>
    <xmx:sB5caFn2oVzEr621-ueMCIDxpzeTz73CjvI-i7R7tPUCmnPhNTzBVoks>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:07:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/3] daemon: explicitly allow EINTR during poll()
In-Reply-To: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 ("Carlo
	Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message of "Wed,
 25 Jun 2025
	07:35:25 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 09:07:11 -0700
Message-ID: <xmqqa55vyfdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

>      +@@ Makefile: include shared.mak
>      + # when attempting to read from an fopen'ed directory (or even to fopen
>      + # it at all).
>      + #
>      ++# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
>      ++# prefer to use ANSI C signal() over POSIX sigaction()
>      ++#
> ...
>      ++ifdef USE_NON_POSIX_SIGNAL
>      ++	COMPAT_CFLAGS += -DUSE_NON_POSIX_SIGNAL
>      ++endif

The new symbol sounds like "POSIX does not have signal(2) but on
this platform we have a usable signal(2), so we use it here", but I
do not think that it is what we want to say (as POSIX inherits this
from ANSI C anyway).  More importantly, this "USE_X" sounds as if we
allow builders to set it and magically we stop using sigaction(2),
which is not what is going on.  We have tons of calls to both
signal(2) and sigaction(2), and we turn calls to signal(2) we have
in daemon.c to sigaction(2) but on some platforms their sigaction(2)
cannot do what we ask it to do, so we are stuck with signal(2) on
these platforms only for these calls in daemon.c.  It may be obvious
to those who develop and review this series, but not for anybody else.

Isn't the situation more like:

    We use sigaction(2) everywhere and have been happy with it in
    our code, but this topic discovered that on some platforms,
    their sigaction(2) does not do XYZ that everybody else's
    sigaction(2) does, so on them we need to fall back on the plain
    old signal(2) on selected code paths that we need XYZ out of the
    signal handling interface.

What is this XYZ that describes the characteristics of
signal/sigaction implementation on these platforms?  A name
constructed more like SIGACTION_LACKS_XYZ (hence we have to resort
to signal), possibly with a more appropriate verb than "lack", would
be less confusing.

I think the topic is moving in the right direction with cleaner code
than the previous round.  Thanks for investing time in it.
