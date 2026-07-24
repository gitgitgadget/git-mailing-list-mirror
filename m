Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33D41A54B
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908352; cv=none; b=HJACw3nS3l7ZO63KIFP0Z4SnuIp/cnpW3qmdfDgHTwkZ57UPsxCU+AKO+eIzS7jLxJkzg1bplcIAn/tU5q3a9rZJs5qFrhnDDwhcZ7sTw5RK3p+kW2hOMTiwybJFNHCKz3ALur7UTEBKNFQbZr6i338Po4gEXku1KHoX2DjCvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908352; c=relaxed/simple;
	bh=80gFVR5UzHrEj9efAem3+ga1wEOHvuvSNTDcB8+d4+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PW7oQBCEnD4zCTv7VCPUJiiizSUTH9iosFmv4/PMb/wh/2GbsKR9+emVY9SH1C0ZYNGqJncqPMzTfPWXcZDI+aHIQDQYfnGu0RY+mFZJlw/uFsXr8BaGyMRYaGNooQwtUp9vPO6LolPcnpGeu17WT+ryLA0Q/VWUyYRIt2xJ5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XDMgcuG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gFKHFNHI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XDMgcuG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gFKHFNHI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 11D7D1D0043E;
	Fri, 24 Jul 2026 11:52:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 24 Jul 2026 11:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784908348; x=1784994748; bh=op+ByFRpMt
	jc1tZsaL5Lt7PHLWC0FldQU0KYH4uPQQI=; b=XDMgcuG18c2Mp0kiRB3V81u/KR
	+PtLkU5e8xH0KGb/ADkdsv2RWq3VRu2o7oM/PGHYSsFj3eh6w4p8FZQRyyc2jEaC
	Osn/AMRPY6jZVxz+CxU7Rh+CQKucFgOL6y0JKjgZx/RNnSQFFK+mhfZkQ07weeEY
	dTtl24N4QHiQk4fsdAGzsHfkPiYxcXGuPJQD9zunnqUvHmwWISbFA/qxOicmlNFy
	L+hlRRZpjuYIvD+2tUXfD0kuO1f/EdPGy1QIOoWu+EE7KrbUiAgiHVOk9+bbZBVa
	xavifwtAvWyF8F4vGXwEEg6PDvQiYv/7l7+iHdZt5eimVyn1sA1sqeTXkgLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784908348; x=1784994748; bh=op+ByFRpMtjc1tZsaL5Lt7PHLWC0FldQU0K
	YH4uPQQI=; b=gFKHFNHIlWd+6C3HhJWiDBFM/Q726nwsszq/RRBSb+uEi65udHX
	qIDwDLpmFoYA1aCsZ2Aclq23/jDvDyM5qJ2GtZJe46s1wcJR/zJRTF8BzqDFyYvV
	+4am/dLfBxRc9hldx6hNfVH0RCnm/QkC0hzm5sFxkH3xCQIf4jeGzoymEzYfhArF
	0TJFloGv4PIh5/zNq2R7Y3e2VK32Xgav4wvG19KYMl8FeRgW/dVFEAgvgG4V+tmO
	Tk0U5fo89KFVHiCG3e56ue5fx50lQUwuHJqnXiApRuOgCE8NIYQNXyb9f0a98eOR
	Mv9OjVUlcvdvj14yR6ZUEF5ayEYAMoXG3+g==
X-ME-Sender: <xms:PIpjaqMSVgSbp6KyLJ8Ak32F7WrBLnSCJ2s1__CFR312WOVcKJL7Cw>
    <xme:PIpjahJyGngou0cthZHnjqtEJceNIIMWCKjv8lvdGzopgqbtIOtSzQc7Jth-nTb-4
    3Nju6iyxIderVvRAezeBT0Srb3348uBkMyw-kEVxbzN8OILKd9qtQ>
X-ME-Received: <xmr:PIpjas1_0TNLWkkOg8HVRFA2uQzlEwD8G8Bw_R-WSDfuIlbaWZIgfcZTe0syNY-dnPcdMkIA6RcF5pjlht7NuvNLzcgkKZQzMg>
X-ME-Proxy-Cause: dmFkZTGfj4QEIUhnQUGq6YrOlKQZZwhsynM6WPmu9jdSRFYjHUVo8SHGZxaCRnkxsqC+n4
    TTpTUu+1H+ZrAMr1t2bWH3aCdmWuFdv0Sw2hXlAzdFdsa6mKIrb5JnzJpDcVMzm48aKL2y
    p3jFRgN/+4NdAOx8x8t9h2J1CBVOYIMbB63VHfBMsk9PaKcpsvwlPbFAIQdsUnoXvVAAft
    /2JOme4V0HzPMQjfBiORe9ZP1zF7hUv3Rg4u8nRvN0I9Lg9JrX+NSmuoLiQd8Pl0jshAxO
    7UsMAfrxrotYfTBKuGxDUXvE1UqB3ytZSQ2AshVTm2Knm62cDLl246KzAnklFS9LmPa+rl
    o7cEsdTgen4zo2SIGe9iSkYVFev53rfH3PY7oc7ailRBUWo89iwiWcZg/vQwufUYftFpQu
    dgEILstCiw80rteUbN/o+a6x1lfhUY+VXXklK9FjxqrdYsX5qYCr32dYRoMukp/f5mEmno
    gaPgJZ6wJU3GI5Xlq2tAEKpA3J3laRoGZ4+6jhuoiTZEkOHgqqkhWLQ1KlzHR0nLC+bjbL
    deYKpOMmb4rowbFKVtXKnrV/2OqPjyZNI0aoJYL2vVYmOe/2c9El/TYiA46caU/MciD0MY
    b8TuGAR15MVHhzgVWZFy3fxHQNrIJPU48bi4pxefAVR3KFw5Vz+1Ec29UUsw
X-ME-Proxy: <xmx:PIpjalUeekJRRvc4lzBmO-CWFX8msbwtsWhe7GrirMaGr6kYm1DNXg>
    <xmx:PIpjauOL6ajG7qZ8CwhJBT2uuHLipm6Ir8ykEjqQr0UxZGFNXt3Ksw>
    <xmx:PIpjao1UR4V1x6I2u2xsPj9sRhgv9BCH0sZkhPlIaQnEavwaQiwLEw>
    <xmx:PIpjaiTJHN2pRXlRNi0PeJaVO3_x96druhfLXqEy_SQQLAgv0syA1Q>
    <xmx:PIpjarOGJYlccranvpD9Il8HjdqrESBOfA-iGhGKlLs-8lblP0OaEd0S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 11:52:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  szeder.dev@gmail.com,
  toon@iotcl.com
Subject: Re: [PATCH GSoC v21 00/13] cat-file: add remote-object-info to
 batch-command
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
	(Pablo Sabater's message of "Fri, 24 Jul 2026 12:54:11 +0200")
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
	<20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Date: Fri, 24 Jul 2026 08:52:26 -0700
Message-ID: <xmqqtspo8jwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Changes in v21:
> - Dropped unnecessary change in git-cat-file.adoc
> - Fixed EXPAND_DATA_INIT macro formating
> - typo and blank line before WARNING:
> ...
> Range-diff versus v20:

All looks good.  Let's mark it for 'next' now.
