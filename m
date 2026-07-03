Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAF3A1B5
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047262; cv=none; b=lgZtBj453Ch8paVMJr1LTZszrn3LVVNx2hMUAv42pbIEJWlCUHUJbkS13QCSeSG/B2QIdZ72HMAkb5cMhodqSLRIfqeze2nfpoNUE+HpKccIqn6CZTRrrqhoDXhlvY05YOkH68dLj6BiAYiD2nlpjbLf0q7jcA0Vdu6Eovw2wVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047262; c=relaxed/simple;
	bh=7RLAR89Xrs1sBDpt+JKH29d29PvvN7HcZo2kVo7Eh+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bai8yF4dRGqUVfcrfV5+XqzGOlHjD034aTOG+8H1oXUjxD5i3NaVVjTMlbM4m6m/YgC4jW7eBGLqsMgvalLFgAVo4DEsc+kmz1jMB8ApWyVWmXR7Ai63FGcqnrPWT7WCEgpFw5fP5qencVnzWOJQN0a1/rd2qAM1TvSDB86fl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rgMXW4R9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWaU6pxE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgMXW4R9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWaU6pxE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D099B14000B5;
	Thu,  2 Jul 2026 22:54:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 22:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783047259; x=1783133659; bh=7RLAR89Xrs
	1sBDpt+JKH29d29PvvN7HcZo2kVo7Eh+M=; b=rgMXW4R9uwDN9V086CUTNRqZW1
	sBYVQqJYzI56QRlwdnLLue3S9l+snLgTwRDziuTVjxzm2nvypVX1ATiTYbpJlgnY
	qQvEDSu/NvbZDUcfHQchMlbjQuSVCzYBTXWPC2jX+ZDZ43cLVhEa5hCmep+/OCg0
	moKGvqV9r9+vNM2aBeQqdvuGYB6YYJsbF3O1JG/0YRgXRhiZe1mhEfDLXFJD/jcO
	p4rbIfkO1pZj7AQqPkqrJ5NLsPJ1mB+yL4JnWh93//0+oAg3tDU2lZdycLw7DoHk
	ROWSj3Zmd73s9UCr1LabGQX8K+P9LlrC36/GxlgZ2uysvvTIIPN5biuiG/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783047259; x=1783133659; bh=7RLAR89Xrs1sBDpt+JKH29d29PvvN7HcZo2
	kVo7Eh+M=; b=VWaU6pxErfaY4vDQh6xK5TsgqajczM1zzk/pd3GL1Z9mIuWVvkb
	BEPm5J8ya0vqst9ipZYRjUlHwQdH7ilBXYSnIxEI5LZxI8cR9K6hmbd1FnPU8N82
	5wzOwBLAv3H7129KSEcMvB4iIuqCkZ28kOYz5m88UdzFQ2iaxj3o7Y0oagM0s3+o
	kTkSGJDnH/z1dPIL12lMT0NDCFN8feblSok4W85M17+1TMaCxS8HvTahe//SdNvR
	EDs7J2XDvqk22OcixNEsNviU7SsEjWVMt9vpQH3nwLM5CPvNgZim66jVUC5nynEi
	5sbmzCIayHmgEmcfp8SyxdZnf1H/+2W8BKA==
X-ME-Sender: <xms:WyRHak1mxx_dDz2MsfFVS8MoG1sr_gC2xQURNfurZjFj35pru7Zrig>
    <xme:WyRHamF9-iUyJcxD1hN8iX4yBBSaUU8sbkB0MGzuZnEhiqapFJBLhArQTZ-AtibBo
    pB12STo0C2gTnR3K0txibQwrhejTmbCsGGnCKkQCy0LOxgpIWuCE4Q>
X-ME-Received: <xmr:WyRHah6Wolnt0eZrcDHwvc-WCbGbYJytbfgiDOUXzKW5d5PCmdRpkWar6AEsGGI3HsXm0WTWsXt-HaaX-Dpchy2gfwirZbuLl3ev4z0>
X-ME-Proxy-Cause: dmFkZTGdsJbAvcQFv5PofzGlm8d81wljoUL8kmw6rzn48YayZomdK8y+4kXpMh+pXuMDc7
    it9+sfYbKSubGolu3hNxIhDspd9zu2XsvCRQ+6Dz1AOzMAhD0fLcrOY9IgNLc9BlrJ1RVS
    ihdNLRIlIqbJikW8FwmhQdn8wH0GeSM4ZVJN8urz3mxYb6HZFgCbQb1cA0CfPpPx4FDjPD
    tJDZAfj4oZh+/3x8Lmvgg/CKgBLJ0qAsEEXpc1tFv9QQoOAM95JAIe8ZT/3y3qfr0IreFY
    Zs8yylA+iykAQZ5OyTPrfv5WJGtfe4hqSuQR3Gmq5cGoAW93K6jMEiC/mLwtGDWDhO39eN
    O8YoJC7Pc3sXT8f1Hu3VKPUWs1SKltUhAbs3EOHGr+KIz4W0Lw1gRWCTIwqd8TrJWCM+Kq
    nK2dQv0Vin32nECVwIjKNMNcGqwe5q/OgjqokzRyodKgMhoLBG7q6NRWQallXNFfvjH//G
    wyySiqjayEs9BJy1LMDJNx0nYz8LUBxejBHebkZ+W7OazzSuGv0c/Api7NLur5MFEGCega
    LdLbV6275KHKydA0+9zV2qQxl8t4HZVzSHoUp7pQg4FatFQG1Sdv7X2UADbd0xIfTpyqdM
    3+3MZPeagGUkNDRSWL5Y44xDsZKAjMpYUCfpEr0gS1yf0ZPq6CTtIM8DgnCg
X-ME-Proxy: <xmx:WyRHasvs4H2imKpaXXo7XfMIpgAW288e1tMyGufCtuKnl3lN8NUlug>
    <xmx:WyRHai5q6K9oVL68ZI1lgEa2Y2RbD5mDTVtWDlMUuJED2xPV4Ew-Hg>
    <xmx:WyRHanXXWMob4xtyMHSDXQmdqLJEl91eyh3R7dqOqa148U5EC5_YJg>
    <xmx:WyRHak_uLZcn7JJZuUfEs6OGHwKJK7SRskuOd5eVNz3rw68xBEAo6A>
    <xmx:WyRHaqN9VrSWE5zOwNHXO9NHwOL_55dQgiKsIDDieRVlb3GYbpo843Tw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 22:54:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v5 00/10] commit-reach: terminate merge-base walk when
 one side is exhausted
In-Reply-To: <CAL71e4PgcZDK-gJziJa_yjEqX9TE+PFMwZn0xbjAUzuUDDDBYA@mail.gmail.com>
	(Kristofer Karlsson's message of "Wed, 1 Jul 2026 23:15:27 +0200")
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<xmqqpl16mq3v.fsf@gitster.g>
	<CAL71e4PgcZDK-gJziJa_yjEqX9TE+PFMwZn0xbjAUzuUDDDBYA@mail.gmail.com>
Date: Thu, 02 Jul 2026 19:54:18 -0700
Message-ID: <xmqq4iiglr51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> In the meantime, there are still some aspects of this v5 that would
> benefit from some discussion and feedback -- specifically the new
> test diagnostic helper (patch 2) and the commit-date ordering
> fallback removal (patch 10). Both are new in this version and could
> be seen as optional.

Sure, review comment on this iterations are welcome, of course, but
I'll punt on integrating it in 'seen'.

Thanks.
