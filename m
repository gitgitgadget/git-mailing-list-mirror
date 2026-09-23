Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536157983E
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194488; cv=none; b=LAW6QBScl0N52txIUkwAfg0qnIv+CSwyse00jv0/ivKX+xQ/4N9zOVKyjR77nUm3HzUu241kAp+ThP+nHvrdJAh8nG+JrsbwHiJtEM91MIb4j45/QASa0+UEf6uXy3RQOhUEA5kc5Ig4U2464BOfVGI/phO44o11Jct7tMjT1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194488; c=relaxed/simple;
	bh=i6TPFc6pWjLG2LGL6l2d0ppVZH2dD4DPCQZ5nR7tTio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/B6n0Ba+NJnC1DlNR9FSoQvhfqcoKys2XASj71N97NGv7WduEkQWhhBli2Y7vGIKkZRT5utvoWIaPjWSwvD42LMDq/O4l7vWtAHXDhHMPD44d8wJmDnbWNon0XR28R0VdcdTTJ1PZ1hAU3oKjplr38hhiGPce4xNhu2DxvZTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SZ9oxxqC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lCNbw55f; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SZ9oxxqC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lCNbw55f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 68457EC0213;
	Wed, 23 Sep 2026 16:14:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 16:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790194476; x=1790280876; bh=BRQps6QJo0
	Abc5fQvII5cuZUUF+xAwZx5QyusVfP5ME=; b=SZ9oxxqCRhFtdBhTAI5PXejLJD
	/04dkb+M+gHDIvzCUYCttXEV59GeQA885fOYv6SLal1GkfIzECh711sHuDQJfxOJ
	y+s9VH/k28h8bM3sg9+B9saHw/eC4DjBYPMYiAIf3ATvdcTwsjl2jqaS6iadgguU
	pnA2vw6Ir5f22IukIK06XU56qGRwakGDzEi0hVt8du0mB0ATdXOrnUTsHKrowO1Q
	1PjduVmjO+CigQmEFFhptjd1YOrgd2lZ02Mh16Kbe/LkZkbH5Ipr9jUHphSpCB/F
	Yb3SoTy8T2s/+PgXD+0eT1VQK8FdEASrHTvn+pY0ivw+Xwi2lZUyrxY2iJvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790194476; x=1790280876; bh=BRQps6QJo0Abc5fQvII5cuZUUF+xAwZx5Qy
	usVfP5ME=; b=lCNbw55fttEhRq58l8+D6IFkHxQT9aWFL4ZXNYSvfxAFiqhdfC8
	O5TTmw4Iq6LJCoBZy+Qg78rJLrnALpXfJ7zCMvLbIsu18nQXCXkZq+iQQEaik5Uq
	EUXBUE5x3osbr18SMBdNdCj3/ySN4x5sTquD3c6+5t4yZ4y4JC6896lPkgyIdShJ
	odeiVr+7T6rlaoqHZghA2L0lKezmtBQT7uL+HdcU6pVj+516ZDxTrGRAJM69M+99
	udKfuIArwgtwWDsN1ss1LidxI6yWQcw3jalVkjDQRNJiHV4n3/mdCtPl6tdel/kO
	U+L4CbkfDDVPEKRpZJnj+QcG6/fGBydv3Kw==
X-ME-Sender: <xms:LDO0agphK3udze6hrNDzg7EZEtEvIqdOSm-GIN0Gy4EE_a0Oj7lRcw>
    <xme:LDO0ao5RrYpIs4kPgDUvZsce4iQl3pIxBirYXKZ27ug3O1I9vyo0sSA_PJlytnFf7
    xJ21TcR2_r-GXKWZRtJC3TnwWHolEDeUpY1D7EKTdUnQ9-PoBUHbHE>
X-ME-Received: <xmr:LDO0ancpPQGGY6PkfOL8X4rQPkjPyjyDh2zppK0y6IXfuBuqI4107nAYMoUYBgVd7Kxd6Q7q0NXqZMr86pBlSqeOfUom-hTlvkGY>
X-ME-Proxy-Cause: dmFkZTEgO11BSfazY7ePuDHsVDDxHNULGWZTU0AGsZitNLRNSJahyd5mA6LYszp0zmh0bh
    VOYHOF2ax5MtwrpZNV/f1Thy0KcopAvzumSXccuNJxfd2iB9ywstficbiVQixs881HOwP8
    Tdmwp37Irv/CVoK74YYiEodlTYtv1WTMDqi1jPt3IBFLMxG3vKnRVeT4hcK0xkzcm1tfKJ
    HA+KKU4pQZ/i086543GWF7+3QXwSVUrIj9vnF6E6NMjZEJ+2MrHv/h5UNNhXN8G+xRdl6/
    68/Vty5YgHes/k0Hqlo1j42+hvZhxEPM60OwqB/OD9RKmAW2U6e/Vcs8Nldt96qN0H+VHU
    yQBr0d0705DnQ3hQjvoXxYUmE79edudOh5Honn4m4Byhhr4jFq3oKTTyiVTzv8n7p0dGqC
    7PrFdRkPi5YSYQDz2sXoDyszqrP5fXPpywclQPIbkokVEODanC5qf7Not4FTLOyukouTnO
    diP4lC5Jdvfvz7jyXy6c/vJs1oT3igSOpHhEclIpjsvgQTL9TiZK39nH0L+wWbyqzATF5M
    yaaCRHqHmGHh1QLixAkHW3/3ChbvDbQOMGC9dnKHUbioKY1LUNJG6l8bjdSB55PLGJZtFM
    jGlHv4SSLqhqmYQ4xqDoQE/06UxpJlMsqBRKALFezYJD5+1GtAa8A9VROmBw
X-ME-Proxy: <xmx:LDO0at7_rnTmTYz7cCo_rpDLVACVbX86kVjtftoDcanSl-gEy_AjVQ>
    <xmx:LDO0aus5wZQhJVRwmIiyF8RCDqIqW_yszN4gq-CNExctA0LtpKK25A>
    <xmx:LDO0atgqQHEREL4640bteeAqpnNFkZ2s3QGz0w4wo_6FONhQySlOGg>
    <xmx:LDO0apqpyiFDuenu8QO4ds0l7Xb2OJnfmMVXV6keGNB5Cnhf9fdZ5Q>
    <xmx:LDO0ak9uGf7tPe2ITmg9Gf-eUNI1DGGOCZLoeuB9ePjcLj11raqdNC_e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 16:14:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  <peff@peff.net>,  <newren@gmail.com>,  "Derrick
 Stolee" <stolee@gmail.com>
Subject: Re: [PATCH 1/6] strbuf: add header for 'safe' API
In-Reply-To: <DLMXXKPGU78J.2PBDFYJTPFTA4@fastmail.com> (Mark C. Chu-Carroll's
	message of "Wed, 23 Sep 2026 15:25:23 -0400")
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
	<b1779709120adc9c1df40c7210481d6bed9791c5.1789736540.git.gitgitgadget@gmail.com>
	<DLMXXKPGU78J.2PBDFYJTPFTA4@fastmail.com>
Date: Wed, 23 Sep 2026 13:14:34 -0700
Message-ID: <xmqqzex7913p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> General comment: I really like the idea of this. While I haven't
> encountered this specific issue with git, I've dealt with similar issues
> in other systems, and even if the cascading error case is rare, it's
> incredibly frustrating to deal with the loss of error details because
> they used unsafe operations to generate their messages!

If I understand correctly what this topic aims at, you'll see the
"loss of error details" either way.  Either we ran out of memory
inside strbuf call and die, or we fail to allocate memory to format
the details and end up not showing it.

> On Fri Sep 18, 2026 at 9:02 AM EDT, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> In particular, we cannot include 'banned-die.h' in 'strbuf.c'.
>
> I think we prefer to avoid "we" in these comments; and 

The third word of your comment should not be "we" but "I", if that
"we" intends to include me and others who wrote many commit log
messages ;-)
