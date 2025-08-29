Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BC20B22
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501240; cv=none; b=rwZEgZDY9HrtwiW91z8LxeyfgdIXXeRgV2Yjmuv8c+ilMHNWd8slqa+lZk6buchhCDMJ/8IALxKwutfuDHGhAMgWrFCmpYha+xf1IpvazQAjPPFnwJlv8ouD3LUDDay4Jh/xW06Pc3U6jijimQToqO0hqJhQcFlmZNhnyXM3gVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501240; c=relaxed/simple;
	bh=tex0l9kyMH5qPOj5mDnFymvyxGKqhEZDj75KMfgk0BE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hY1HlxPNiud4pNt8Kd79s1HXM67UH7sifVQVjQFZ4ZPWZxmuCgZH3e4bAUCkU3WnZdVTufK6TvSPeShbpra25A0MjwgYJ1xk6zfuhk2VSvbsZo699ZgFiMKVT8rHCk5txzCM8lTbNjrJZI9VhBynq9C5K9SvJF/2Tuf5RoPgfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QMEug1GA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aksfiDij; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QMEug1GA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aksfiDij"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E41B1D00100;
	Fri, 29 Aug 2025 17:00:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 29 Aug 2025 17:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756501237;
	 x=1756587637; bh=7hUh4qJQnuEV1nwQ0AsZ4KgasXR+u2FRKq4Fmxm6u/E=; b=
	QMEug1GAYiqLzHZn1IcNAQN0x0qUiesyt/NC2WF/bRIF/tEJR2TLUVKfz6m6IqVF
	GZOBi9zesi/QPsbaPh+qsyBGGZBQh+aPCl6mWWG3Ygm9X1KA2Zev8O2moosIs7wQ
	mmqUVBAQTf+wSC0X1vt2UjVI3esmEcmIaFZtzJtxeD7YtqoqFS/UF8F7q68nvBiH
	eFg1qZidtdW2aXdnZ7r0s2akuMyBbYmEujedPNf9PSTkeC/jA2xf6BbITce6qFOV
	YhpTKbM1WoucsCziYygzGMkWc3P7CiAE/omrI75hKf4l/feLcG+VF+a1Qwu8vc5H
	6HwF0sLMvyCk/PTYzB3XIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756501237; x=
	1756587637; bh=7hUh4qJQnuEV1nwQ0AsZ4KgasXR+u2FRKq4Fmxm6u/E=; b=a
	ksfiDijSm6hD5Mnp3hVnm42AUPc1HqQPG3RnX2h9I9UWERHLt2IXoM6keXtxwPyv
	8XyRj+B+8GLGkBFN6o+eOdZahPgYN8Do5at30YV8IRNblji4mfAFIG5Q7onaqo6S
	Y1CtRsiE+K/mv6rvicvNCiyGD4Tg1siT/TtilAptHlVrfOEtUAJKdnMw3ZmupPqB
	UZifUcGDaecynqle8M2udpUGMdPjYbq8IXIesbZF2KzKHOV8wpkitO5dZ+qWczQM
	AZxWze8+Jfu6Uy2rRaEU513JE3tOrfzRzFS0F5hszWItUTRLLFC8nZ8E94rQU/Ph
	ROAMyVElNLGxRSH2JbuuQ==
X-ME-Sender: <xms:9BSyaPGLsR55ICQWDxoNE15cM8Vq1RrZevfLlM9MFnc7gE0S7fnP3w>
    <xme:9BSyaH2ukTjZzKmxScaj-34o1vavSc1qTzPqGlwF0YlM8e_fmjOhINtyYh9DEvRyp
    KpAqn9FzWKTI7xq8Q>
X-ME-Received: <xmr:9BSyaHnDqL-i7G8j_OlBLl0QuNsy0OQbX_3pnzCNA0CYx3Roi1OiPNFKWQjUj-uYB4mwOOWZn-xA5FQabSLEyXXPTEywfLlR-b81tNI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhulhhirg
    esjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9BSyaH-tG5GPwvBZI89sAjlPa_VEreiDGU-o0lwe2C54p2f7vdx5tQ>
    <xmx:9RSyaMpSub0wIQNG7qgZSMDB1Wz-VRJaydAhDsdCg9YQc-uPy7-Oig>
    <xmx:9RSyaAkEuxwSHCldFr6C-WfmY68HWkIalV8DmTcR-FE_ZpOmWT7Dtg>
    <xmx:9RSyaDgP_r7y3YURKJCmASzif14BwnGrQbd0osVP5Kw2rFNwSTlroQ>
    <xmx:9RSyaLUj29sKePWc5f0sjgtfPRpsfo44YzjKRSxXr1x5pfIL0q3lMXzw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 17:00:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
In-Reply-To: <CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 28 Aug 2025 10:00:22 -0400")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
	<CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com>
Date: Fri, 29 Aug 2025 14:00:35 -0700
Message-ID: <xmqqiki5n8r0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> +1. **Switch branches**, with `git checkout <branch>`
>> +2. **Restore a different version of a file**, for example with `git
>> +   checkout <commit> <filename>` or `git checkout <filename>`
>> +
>> +See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
>> +Here's a description of all of the modes:
>
> This looks good—I initially scratched my head thinking there were 3
> modes, but unifying "update files to match index" and "update files to
> match specified tree" is easier to digest in this presentation.

Yup.  And on the other side, unifying "prepare to extend the history
of a branch" and "prepare to create a new history starting at a
commit" (aka detached HEAD) into one is equally good.

But I am wondering what is the most common perception of the second
mode.  I've always thought that the action was to "grab things out
of the index or out of a tree-ish and overwrite the working tree
files", and it takes me an extra effort to read, think, understand
and finally realize that "update working tree files to match either
the index or a tree-ish" is equivalent to it.

Anyway, thanks for a review.
