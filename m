Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF850B406
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026201; cv=none; b=RDBxOUyo08EL9T0qmkHhiQnxuSFXpSiQvsjtg93NbXi0+7/Zi+pPjdRKFXvf6OC/1oeSMvfzV/Edc5mxBtzssJRZS3QpFDYxd6rnrk6P54+HF9w7StBkcUdUqPZivioxXerTQbjMR4AEQjIYmjuc5Omvv9KsMPHn1Rr662ubS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026201; c=relaxed/simple;
	bh=kKdXsxyQ4fIuzlq/gKhrTI4yLOtVOApDJtaKJN0B9vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JeL9g7A0Aikf3WFL/Z4u161a6QInKaVJXTDXrzrCPs1QU93TFkcwgZ43at9cdQF5FckE13VyUIoZzF4LNGJW1v7N09Yx3uw1wX4epwPtuDuXpSghM42ZAJbsWQS+TbEkm/2CFDSWYrmHda+S5WBkvrVlZH2X4Qo9w8NUus1dEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qSd83kc2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cYQtDpW1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qSd83kc2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cYQtDpW1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EDEE1EC0279;
	Mon, 21 Sep 2026 17:29:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 17:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790026198; x=1790112598; bh=89DKI9wscP
	4sqkKyfYcsVu8vWnXpFuLmFwYce7tgoL4=; b=qSd83kc2YxdaXGADh8bGAoeDYs
	Z2kofIrEgvD6fujqW+jM2mZVl7l3yTYFoIByv6pGQ3Vk1ZtG6hjfSGMx3nwOPkUE
	v2y6kbgEWzRCVhFzq+NzlyyXte7eN4lQyOQQcglyHwM7p3vf3l39cpUoiygHl0IM
	mWfPsjNDg7BwsNNwYUXi9g3Jfocf0JK6bbZ1EKh2miD1H73E+i0UdYiVV+rh+gmx
	o7nm4CfAIxojdrKY9cmTA4u6hHh2e0mvuEUxn0V+VshDChsDqIMWmFjKxUW+ebJC
	ocU4Bred51M4aJjbSVdACHTvPKqZ0yQ0Y4g0hlgWbwwBsm3nIllfJUNCHAwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790026198; x=1790112598; bh=89DKI9wscP4sqkKyfYcsVu8vWnXpFuLmFwY
	ce7tgoL4=; b=cYQtDpW10e2QT/98phtpVjrGi2Ol/eB0szg7kBQ/QItM/gd1wn9
	UTphjuoA7Qk3yiMzVePsP8C9KaImqgxnn7mn4hr/sOMNzrHv0qAWWeIJbmdofq7d
	E72WCpSZ3nqVBmYNq6fNk47hurOHwiEhYhMJ8iNTve/Py/lb6k43lKJksMGHymUm
	3P6EPQl9hPfu3QMwv7+EOClVFjeh1zujWLwXKgQ+OC0sOq2GAHMLxHZVn0qru/as
	LLQodJx8tBYNBoMoxJpTtzoEAI1SY2uKFxhchYigAqd+U4UlWPJuraOV+qESgd1C
	W2netKc82/KhbnIxUkuATV4ZmGY2k5hiv7Q==
X-ME-Sender: <xms:1qGxak1D0vkixfWqNXkrwzyQn3IkgutLACdT7oMAaC9j8T4XmdZkjQ>
    <xme:1qGxaiwXaw-IL4juqDdENrezCwOmnEKjg7FLo7Tfjroe114TNvrL0socYXRzlac7j
    4Mvzq19i_lyWA-Ev5JEFskpB9FjNTquvanEay_Azgxf7hqaWZ0GNg>
X-ME-Received: <xmr:1qGxamvAvZTQacIBaNVvzz8w6IYC7ESR54-M74D-2vXcL6CZV1tGwDta4e5NpBMe_qf0BD6l7tvLiLwdcGQbBwOgqUy-BKS0x4ZM>
X-ME-Proxy-Cause: dmFkZTFg4xYDoLEozldaj2cKGKw9Rtm/XAncSeJRH+sN3c+uH60gkaO3TBZmGMEFLadQum
    dWkS8GT/h+S3YmVPcWR2OpOcg97FpFM9VAcyqg/gIMXzVf4RUmP1mO+3QzWRoaA6RgkSpG
    4Si0DAJnKcXg1REEh9OnXuxyL+C+MIILtWu3ws9gQK+GRteYtjK0hxzdsIjgrzu6V9RNob
    si9iAkC/aHFhhupqq3vWbp4GcVcnnO3U3yGM9KvMyxcKeRYyC+yZ7YGAsfIzkiZY+1nFCA
    D0LMXxQFSH39Of7k/OIhKlfSN68vc4wVnyTAjyaOWkVKM7z4u5oCzuOBbzgCbXxn3tm0ZY
    Ruc8qEX4RkuaolUlmx5TvuS6J1ZK/rmWH1eH++VaS7b81quXnwsFbbrs2zVRl4kIQp7i87
    Pykinw4VtMw5EFuFd5UeSSZohviIsphwJhF7a3O0LIM5B9SYO8jskT/VvXoR6w0zR14/Gg
    yekjQrLv/9xD+6GyMaNV0jKNxeKN2DNSsdOfEECjW/3FposM/YeCwElGNNSWnxrM2aVw6i
    GT2kht+v7JIv++qnxlV9WWXTPBGXZgcd3j8TdObke7OP+2kaWLZdXNBoCsZc+elfsM44J+
    CeKhZZ2Ny2Zn+0apCvkmjbivdcriEzvUWDo9x+An+jUfvXusf/hv593y5CTw
X-ME-Proxy: <xmx:1qGxakx_PODOGr-VpKDpgmjWLM-2uvETdL20ROwYDTkSVSvYJbHiiA>
    <xmx:1qGxapBKpnw9dRodR4MqohMWj9qgcsBffb5xYK7SGW_5VlYhEYAI5A>
    <xmx:1qGxaic-u6VXsEqo1pKjFXYCKtce98FmlYJjzbd-7s5P9JUbIw3ZYw>
    <xmx:1qGxajn3jPan1pgwnaCFbXNLk1k6oYq_8nAVnzph5tKaxZPrhzf6NQ>
    <xmx:1qGxavl0_b3aminKuxxCt9otRMlhWeSUFLKG_vnVRCh8UegqkGFrpIhz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 17:29:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 4/6] strbuf-safe: add sstrbuf_grow()
In-Reply-To: <ebd91b95209d778727dca1bfcce17dcb76b3151f.1789736540.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Fri, 18 Sep 2026
	13:02:18 +0000")
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
	<ebd91b95209d778727dca1bfcce17dcb76b3151f.1789736540.git.gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 14:29:57 -0700
Message-ID: <xmqqv77yl2cq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +int srealloc(void **ptr, size_t size)
>  {
>  	if (!size) {
> +		free(*ptr);
> +		if ((*ptr = malloc(1)))
> +			return 0;
> +		return -1;
>  	}
>  
> +	if (safe_memory_limit_check(size, 0))
> +		return -1;
> +	if ((*ptr = realloc(*ptr, size)))
> +		return 0;
> +
> +	return -1;
> +}

This overrites *ptr with whatever realloc() returns, and then checks
if we had an error, thereby losing whatever pointer *ptr originally
had.  When realloc() does fail, we have already clobbered *ptr, and
very likely have robbed our caller the pointer it had to the region
of memory.  Aren't we leaking that piece of memory as the result?
