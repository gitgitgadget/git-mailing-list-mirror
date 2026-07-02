Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836593A6B9A
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024126; cv=none; b=BjbTlTKbAvDz8Zk/zrw+RmLvN+ONqaED1FVdpt4n/AGdS3P8FHluBDFcoK29Kp6optmdSpWMstTfzYbzpasQnSSzjtIYAOPS+KFhy2QaEcyhtTQbrfX6f1d5swp+VAoqsi1ai9YWHW84RPuTD95q44JT1n/XhJV6dQaArubhlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024126; c=relaxed/simple;
	bh=Y4n46gmh0J3869XdCKwc5wHNEENHd5OIlhw9czLtFIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oBDJZaCkFQwjJt9Em78Znjxm7qs5nmJK7p6ubYpKLzT+ndVDy2+585jx3X4UF7zmq/bltH4ug3iSU5ucKDif0YQXN1e92R8941DPaIpxjBqz8AtUzspt66pUwslnNMvZ44YdaMBTBa0BnyRypGcHpOKpx1Xw3czHno+sV0R3brM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y20KE4Tr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Swl6ibp4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y20KE4Tr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Swl6ibp4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 932067A010C;
	Thu,  2 Jul 2026 16:28:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 16:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783024123; x=1783110523; bh=Y4n46gmh0J
	3869XdCKwc5wHNEENHd5OIlhw9czLtFIk=; b=Y20KE4Tr1vhfuVHaxFN7XTukzh
	njnrS0JQbCTy9tZQOyZVVNhFp6Ll7Y9zxqZxTQmjq58zCs17pZoQPiRXb5f8FfP4
	q/J2XKe8PM3v0nt0wp56uVx/KFifbCgszj3CwX/aU2A2ErdeyVDNptOG62o3eTLM
	0AMkuhyeYU6hX+LhclOCQ3KVf6A64O1i+BNxoqUUCwKA2gV1799oMBbYpS09kfsy
	sFI3LE1QAQPlxEl7EB8he+gkmUZbWZ9fMLsxD0LTsvRpbAwc83xVovnWU/34Zbqt
	xpEvX4bxYAsM9KkquoH5VAjpz9CFMBHnH0q9FvL480QN+WJQn4KEoBY7iTZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783024123; x=1783110523; bh=Y4n46gmh0J3869XdCKwc5wHNEENHd5OIlhw
	9czLtFIk=; b=Swl6ibp4q1wD6fKPRJCuBd6rvBmjI3jShOM1MndjZO/FeI+omzE
	yztFGoDr1qXMjNX2/EFMJ9H7VA3q/XrxFP4I5jl2YFD2Bub5MYRgvbvb4c3d54Mp
	zKC3N9xHeZw51d7QMIosqkqp6NUlIGqWTQoJgGUHdw4bxjoBIS0aHVJrk+s3AptI
	iK9cOf2IZSl7MkAiXGysUIAeRYSeTWM1NoouGcx2Z9RzO4lI0ZVsfiHfGvFtDPXp
	kuAV6zbjVPznSB5xa+Oo2u0u7Tkzaigu8/B46KP3sNXBCu3yi4fNLXIAqPvPh7r5
	Q3/Sh6MGrPgkJqVYgJCy286eUCwtSkZBVXQ==
X-ME-Sender: <xms:-slGapG1ne-DcK8eOpCH-m3juqHFrqVSIUjvcVteVEGY1HkIA6Lqkw>
    <xme:-slGavAComUBLJOud47qMxQS6Q1yfdNWLtfV6PWnP6FGpfZkrk3WMkDiJcamHuvvl
    1Wc0545Yp6sNzBf0UVFqWk8cmOQZUelctQoHEHnr2foa6loQulAwg>
X-ME-Received: <xmr:-slGapW0k_GhNH9Ef6CCt0VB2c98D_x3ev6kSoQiTeYodymgfZUW4YvvxTl58yXqotzgj5DSr_SoakogvGFqvV7TEFnkmS1eH1cCDYw>
X-ME-Proxy-Cause: dmFkZTEGL5RIyOUZ33px9ExUuhGS+9FrSxypNArrBXVyzwYNe4SpD+4oSfOZcRkT+QMj49
    PK4C+8JtOK5+8rhOVPdXoPs96gg4fHjAPxnzmbt/wXepQk7AJP6kTmL4Gub3FohtYQWzMb
    J1BMOujAdI6VMkQeHzLXi7xeCBQNwiqi7B5MPG6fMPstHJtOaoiv0CHuphITQG97gPNiYz
    CYD8TzB2ne7c7cNUQVsPg8roOxnx/UE1rFDDMHFMhBCNFjAiw2LNd8iUh58znT9Y2M4Rhe
    ycjg20tEcphCvBHp1B65IaBBxpPhpxEmhrVbfOuIM95w+6xXzOMBX8jW4Gf4mERJKTSoK9
    QjKaj5N9NQop/VrpBiaFjS8jDYsPczoO2OVuvRhA0wFmPU64SKSFneHVEojg1KLvn5t/6N
    +5LZY2zAyfqFPPjjIZMfdaEdlUaIPacza0gJn8F/DISdfH7BfH9/GXY/9Dxh+hbHV7pymu
    K/6AXGe9IGcT/UTdKBlpbHbsSg1DSU73Se70zM44ju7FByn2cyKF8LbxOdc5UIZtsePtH+
    bHACwPI80XKEoL9JXhMI3Md8a6TAYWD2VJfS1FF+gta8+HTpY+0fVUHpLaXMmvGHUVLD4W
    QhGSNOnIemkPhcbZD9ZRnKbRfN8LTjYVCssvrdQb9mGX5+rNe5PNduxEMBmQ
X-ME-Proxy: <xmx:-slGajohy5Ft5IsQ5Hr1et1utVNHVz3uRaKY3MfIu2a_BPxuDHff9g>
    <xmx:-slGalSdqfRzVQ-koSPnqcWYTKrGeN80t617iDZylqoXbHtDFEVSAQ>
    <xmx:-slGat1vav9l8CwwnJugE8gxKpL16gzG9l0q7P-4XZpMBZFqk2JqLQ>
    <xmx:-slGahDtGrpODBcEn_la1_GYakWExZTXtS_T4qBHSunuk-LJq0YT8A>
    <xmx:-8lGajgy_PqfLqs3JLxWv_LkFod5u8bZA3U2ufYVYe5wNwxwDTy7XoXJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 16:28:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  Matt Hunter <m@lfurio.us>,  Harald Nordgren
 <haraldnordgren@gmail.com>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
In-Reply-To: <akZfm-igZKeHaDST@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Jul 2026 14:54:51 +0200")
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
	<akIQLM6xZTHBudWT@pks.im>
	<3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
	<CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
	<dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
	<DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
	<3c35bd17-e884-432d-a400-36a89964ed89@gmail.com>
	<akZfm-igZKeHaDST@pks.im>
Date: Thu, 02 Jul 2026 13:28:40 -0700
Message-ID: <xmqqcxx5kufb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, agreed. I think that the reflog is insufficient for a lot of Git's
> operations and that it is way too hard to reason about.

As the reflog has never been about undoing, this is understandable.

Things like @{-N} notation and "git push --force-if-includes" make
good use of the "what was this ref pointing at historically?"
information, so they give us a proof that it is possible to
programmatically go back and find the necessary state, though.
