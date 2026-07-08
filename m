Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704EA4963AA
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522176; cv=none; b=JZbttzR/cpJKcWvRSL0A2AhRGyilCwhnf3w9NUeXRyro632nIQYZC1WyPFX2znHpmj8FkrrP17OwFYp0106K7vGPkwMlAaYKMyb33Zd5NgTQszJ9qvGgjQSRmAEQfapQzuh845WrzlpsUcvgT9Bs/r8cxo1JLWJq5Xhh/ep8M10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522176; c=relaxed/simple;
	bh=F9ZSb/kCIcv02c/wXUgUFhPj1L3zeHuDUz0v1kO5SY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQncdUeOaiRlC0KOW2Q5cgTBhDivhm1G7Yoa4ZuTdSGhQGHKgkuEB5pAXXqzTDKSHxV9dH9DSoRvRwJpdWUxXztDl60FsMawbygDoYwowf+SgQzqmUPQyR3P1xANHZM2C6g17j9qXwKiCwcPJJEwo7sd+uNdUmn9vkrf5LL8iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jtKILD/D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJwdLqHm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jtKILD/D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJwdLqHm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A342EC0196;
	Wed,  8 Jul 2026 10:49:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jul 2026 10:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783522164; x=1783608564; bh=13NpYOkfPc
	5SCuvvOTl/vP46eO+Mv1WmaPpUMzw/Z9k=; b=jtKILD/DT7WIuDKTIXQuEb2Yfx
	6JZ2W5a4SeBsMLOOcrQTEpWLRVtinM+l1mGsGJA0/Vtw40zPQurHewk9DSOdwHQ6
	6LMAIl3CsNMZfOP6W1QL0v989YeVYG9lg8PK+DNfP80WFUMro4D93F/1lsbsp/du
	/aLf3lFz9bsKo2iTKtFxFBSSiSmkc2e/JxTL59mRt0VHl9aCNbfJ5bx1KjUSJmTz
	zTCgJhoPKqSHr159fv4ZXH8gqTg5BqRrSqQbBpMdoqf3lEKhPswsmlvSi6PH5CFd
	RK6qLx9xRbExwQmTItHMjdpMJavUzOBkvDF6AcPDlAxJ/Qk8Vox72lY8B3+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783522164; x=1783608564; bh=13NpYOkfPc5SCuvvOTl/vP46eO+Mv1WmaPp
	UMzw/Z9k=; b=oJwdLqHmpk/FxgAmf4CJKZg5xZU7RP4jy23awSjEFUKMWQ7a1Kc
	ZYf2m5QHJE+zd+41IIKlhRkV1tyE/b9l9quGXudFbwc4m+DuZd2zurkPaCNRjE+t
	Hp8hubyiQUHIuNMGcjF5XoDR3LQJJvC/F9QQPN+pKpqJh5FNK2cP1fhMlOE0Ww5u
	N9ulPXA3hbObwXwfYNgexiyjIWXdE43IQU7K8DP99y6tGnWXE/bu6qhfwoVhfPYZ
	t+YZ3JQYS8ciqepXvBdCN3bNQl184ukkOMVTLHc3dVz9Q0tvEbJKctuX6X0q+jHC
	7DLJKjGN9kzWRc3XctAYR8Yupk6yAL9sCMA==
X-ME-Sender: <xms:dGNOaiuQl2mq471HK52eW0TLb85_xNjiiQ9PK3Mu6xj66IzqfoCqLg>
    <xme:dGNOauXq3203WTRnTorxAq9VIREINot0u1crUbHVxKxglBv5x_aFtdJuA4hAL2RzS
    qqYbbmFMi0VFij599JzjNurJyZbN-C27pxkvjhghpiOehOzjDKlGA>
X-ME-Received: <xmr:dGNOamFUj7mzbPI8Fv7BnVo8ffZzrW8GgrEAZVK8VHcm7P0_simzqbrILXXsJZMdAk6rfCI2dQTP17EMEEdfvQ78Q6c6ETGrwyeDINk>
X-ME-Proxy-Cause: dmFkZTE1nyYx2tHURtz/jZsCjyP8GeiiyR2mixxfSoDOE89wMJkoxKMOpkV7xW2y0FCtNe
    EyneY0pHVb9oatSE53QXyO6jL08wYeZMYnH8WbAcsRgV0XvU3lr/4RiqoXJyQzwGYvVmfZ
    rDL7eiUqQE7cSNm951+TnMlMAaQP823I/cFHSvHhaWPXCqJDCM04D8ZwTEcmnPrUEOwpsb
    cESjWC8PywrICzM88zGsQsEOPbiXBE+odYhQPYZTDNodoa/E+QzocVBbZcZ6qF3UP+LRtl
    PtmgKT2aw1Q8ZJ4Y78Imyc4/dPof6gRmAaF8TBCwlFuIPGq68v1ybl8mo5EUN3mrbgaai0
    szjGK0jQmJ0lL/VyFOaAcSHLn7IeyIgaEB5IOS9EPXcZic/ucQ/Ii2nD9RKFXANmGyU3Lp
    xyTitLnRKuovYpePAlH4IUPyDxVHNcEu1hlYSpXatqD90Dn+himxVDEBLoRQfxkbopGo+O
    lr3KO47dDgXGJifJxa1yAuKK3oMvIYW1JSPWJ7gdQOQoKCRfZNXT7NS/g1BZWKsjXLixkB
    69pQTzfgHZG21fZ87MAjoPc5jl5eIhNtOWywOHrNzXAoI+ouUpq5vAx6MPtlATRlRZenl1
    c26fRg1PQu4zYQCNa2wTkn3A0vKZI48X21AujvNdXfFj+e5epCjSOHgoX+yw
X-ME-Proxy: <xmx:dGNOao094zQhZovfD0ylllpil758WZKgYCCLaJdNhgCut52hDGWF5A>
    <xmx:dGNOagOgH-e5mn_7DpNPHkSmQaVqX-D8DN7K3b1qiFJo7TXJS1PHhA>
    <xmx:dGNOav4s-vJxWDX_U2M6LTSamF2k2pMDtOyI0-qaeZXtcQzEED3x0A>
    <xmx:dGNOai2kUk0JCMY8r4MHbVTLY9eHQuwadXXhg4yEHrt27ROZkjakVw>
    <xmx:dGNOag49RJBJC3NeY4mJjmJX_owBhO8_oUmOJeeIKLDLaHS_ucgHKIJZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 10:49:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Joerg Thalheim <joerg@thalheim.io>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
In-Reply-To: <b5c80d76-5ef4-cf1f-f4e1-78e63cfea81b@gmx.de> (Johannes
	Schindelin's message of "Wed, 8 Jul 2026 09:32:41 +0200 (CEST)")
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
	<20260517132111.1014901-1-joerg@thalheim.io>
	<xmqqzf1xbl4i.fsf@gitster.g> <agrIrGwSMFlKTx9x@pks.im>
	<b5c80d76-5ef4-cf1f-f4e1-78e63cfea81b@gmx.de>
Date: Wed, 08 Jul 2026 07:49:21 -0700
Message-ID: <xmqqa4s1wn7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... doubt whether the cost of that cache was worth blocking this patch for
> over a month. Lacking such a cozy setting and at this time also lacking
> the leisure to enjoy said beverages, I'd rather go forward with the
> proposed version and move on to more exciting things.
>
> In other words: I consider this patch fine as-is, and in the event that I
> would consider highly unlikely where the cache _really_ bothers anyone, it
> will be an easy patch to remove it.

And until now, we had over a month to see such an add-on patch, or
hear argument like the above that such a patch is not needed.  That
is what I find disturbing the most here.

