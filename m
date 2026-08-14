Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5F476CFE
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718651; cv=none; b=PYXpknmAkWgJMVbGA9aIZqFEYMdOL4F8NM6eRJ0z/C+OSkLfP5y98RtwHXJ9uHUtpsvL+SkxaJrbRUIMkmYmJ/s3donnH9hyrcPmSmk6aB84h6MuRo/Ob8nQnz8b4iM3gZMe9AyrWV8q37gxNp2Ro4G9FLo3lxg7Qv2Vr9+d62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718651; c=relaxed/simple;
	bh=an/7saw6J8wa9Uwmrve2yjuIjCJj5jeDToM8U3jEwCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=puiG6Sz1iBeO/t7ZNoL/REL+lRYkCKZ8nTiLn6iY/1GaBQpdzH4PVC3jmUz4vgRi3ri+LY32pxb6bhCWZ3Sbc2FtrsHxpF+ML60jnXokbKBQ8AJk2B0sXliMUWF6dAKmHdbgO+uXYXn6mzeq1cD5k/F5bMe0DdgrZirkbqXT8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xsf4GyNk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgTJ6zOw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xsf4GyNk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgTJ6zOw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64FA414000BB;
	Fri, 14 Aug 2026 10:44:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 10:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786718649; x=1786805049; bh=9LLrWTlFt2
	ImjvEpsbhT1rIf9h/21Fgqf5y46eNrfaw=; b=xsf4GyNkZFEk6T2Nd8yXvIk3Y2
	+tqAoMnpHdyWyXkmRhSkSX8OzS13JzUmMmEFGFCJcVlcP59PazMJTFVrZeIKQkFr
	G5YCUTTiWg0SBXKPZIZ3+FOpSofnR3c8Qdr7cihK6Ohqk7LRgudhlSNgdt6V34ir
	RvQzgq3295jmfPZm/QjmJPbDmML4SJFwyFik/LPykdxuWxm1jKKNNYkw4Af3Cswn
	scydBr3gch/YoMux8aeMYqkcyBHHK5HWz8Rh/ONb0QKn41TRFWvMEL595V1l2It1
	fDLeEjnmrqlZ1FU69Cd9m8eIUdKW45qTF1+T1vYSeKzvxL4HlyNSkTzoVuxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786718649; x=1786805049; bh=9LLrWTlFt2ImjvEpsbhT1rIf9h/21Fgqf5y
	46eNrfaw=; b=VgTJ6zOw+HNS151Y4Rp/a5PdH/iQ5nbYltXvlQFPu5xJpIr5zuH
	KuqNQaJcAeA6A6zaaL23eNHg6BRHJHx6VgJAcVeV+eGzb8Qs7QBsUQd2oS42sADg
	p1FqO+gVB/m5VB+eumoq2XQY8zGNksB41Xeqw3OaB2GL4DjkQxEdaELF9NFOTRcW
	wGn5ldDkjWddgc0LLIZkBjHMuMYSENBkV0aMSjq5lskf25rAeOESc5obqnw0XkZ4
	B8b5VHphI4nHBSI017i9sFPIAZKi7attAz5DOXyPuj1l4NlWMS9b2vVZqduVgSLy
	6VQVD7/j1nI/jmMITnp83JdMzFLJrCx6a6w==
X-ME-Sender: <xms:uSl_aog6Mq54yu0NbmsaXRKhccgbqTXftbXhSJwEBtMnp4UJO5-H4A>
    <xme:uSl_aocTK-NDfEyEnltYPEQwJp4VvdWbqunInCFHRhFrUiwdhv25iMsqrlfjTKcM_
    zEhXlifyR2AK4rEMD6sZDPw9bo05wOxvqoQSvlHMHY9GJrD2Xx6Zr0>
X-ME-Received: <xmr:uSl_atei1LNOdIsrPCs-bWtXd86j7dXCX6s3HBVzP_Ex6AIctV19AGEuvV6OrV0Nukl3i3oX1xrScfeaUjd0U3xNurFMp-bx2Q>
X-ME-Proxy-Cause: dmFkZTEOB0g/byaW9w1h0UlNNVdq2sXud0i32tn87VBEvUBBOHXO5bPi7BTZHird55/xbv
    N9eMjm5GGo1e0d2gnAozHJlZymGWNHgaoMnr/CfnxdveNAbh79YuxSZBPIh1pD0eEAd6VS
    ZEslFqHAKDHx0e3K8dAEylMupbqFe4YSdm3Zs1v3Sa0Svo81EE8+MQcNcWh89mIP0wYyYp
    LxOJEJcELS8RgqDs96eyfzjqgSkC69InpE+SDBpXH2qsIYafTV2onGEmLMMs+vaHWf2v6I
    4QCGYwCZF5kotXjyzL5b4Iv3lRq+r2vA5MxUrNKIu78G0ZGNL+++z6XWAcq6NE4w6QztpS
    jItbuqigpJ9KANl6ajjpzNuRl0oJILZvwBJgM9+DVZpHdHgjg+8H7ec92NE8Oj38wb+LEG
    RD/MySlgMBUZ8paJ6PNMUAUXAeMTLf1xH0Fjikzdp/NXvNO3Nkv9RqgKHqJzjR5dhMhc/+
    NH1KiOMe4gszdxcfE+8SwRf/JyfyUcKt4W37t60qw3EuoNLlmyG1xQm2/72PG0VSWUQbt1
    X063HY2nDCNQKph+JZKFmltM4wxnAtjtxK0D810Xpg/NDWodfC2Wi9bgxuW4sWc4CTSvKf
    7JFAxSfBEYr2m8ZHdfkDUrVLGkPwSKcTlh05T8UTXcR/MfjHiI+fQC9YdpJw
X-ME-Proxy: <xmx:uSl_ai8D1RRqTN1xKnN4pyGTfiE-1S3kG2lI5YhE0OKQrX6aw1ZDkg>
    <xmx:uSl_apkQRFv2yJv1doXgD3hz8gWEYV3-_tcrTh2jp6KwVzVvFAjIlw>
    <xmx:uSl_ak8IggiIV-CS7hbK8h1SMHb1ubQJzYd1r6XqW3sl4-0MJoQTqg>
    <xmx:uSl_anmNewvwb9l57eoJqEEheaueEFXqLyqVVKlGNll6Vrd5fOaUuA>
    <xmx:uSl_aooyM930pxLZE7pDr7D6LcIGJzt06FAHX8iowt6kmszdLd4sFhnm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 10:44:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 0/2] repository: move fetch_if_missing into struct
 repository
In-Reply-To: <20260814072419.1666358-1-cat@malon.dev> (Tian Yuchen's message
	of "Fri, 14 Aug 2026 15:24:17 +0800")
References: <20260813061125.1089553-1-cat@malon.dev>
	<20260814072419.1666358-1-cat@malon.dev>
Date: Fri, 14 Aug 2026 07:44:07 -0700
Message-ID: <xmqq33wgrcco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>  Documentation/technical/partial-clone.adoc |  2 +-
>  builtin/fetch-pack.c                       |  6 +++---
>  builtin/fsck.c                             |  6 +++---
>  builtin/index-pack.c                       |  8 +++----
>  builtin/pack-objects.c                     | 25 ++++++++++++----------
>  builtin/prune.c                            |  2 +-
>  builtin/rev-list.c                         | 17 ++++++++-------
>  common-init.c                              |  2 +-
>  git.c                                      |  2 +-
>  midx-write.c                               |  2 +-
>  odb.c                                      |  4 +---
>  odb.h                                      |  8 -------
>  repository.c                               |  1 +
>  repository.h                               |  6 ++++++
>  revision.c                                 |  2 +-
>  15 files changed, 47 insertions(+), 46 deletions(-)

$ git grep -e 'the_repository->fetch_if_missing' \
    builtin/{fetch-pack,fsck,index-pack,pack-objects,prune,rev-list}.c \
    common-init.c midx-write.c odb.c repository.c revision.c
common-init.c:          the_repository->fetch_if_missing = 0;

Compared to the previous round, there is no remaining reference to
the_repository's '.fetch_if_missing' member.  There is a reference
in common-init.c:setup_environment() that reacts to the
GIT_NO_LAZY_FETCH environment variable, but that does not count.

Much better.

Thanks.
