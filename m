Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951232D949C
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719256; cv=none; b=Ta+O/U9xj4QJf5khAul3k4ISWOd7TfzJO5/9JF4amF/aSC3IsVpxyYJjxNsGpsH6fs42qjagPlDw/hpV/znlzEuASFPvm/Qj4t3GCQuorydR1zK2PRDXCTq4LUZ+GywXI2Ixf/ehMyQlLx30DLJxxYbCQvSy6ElTnPG+33jDbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719256; c=relaxed/simple;
	bh=BOhFuoVF+zx9clqX5zGxc9dE2seCGvK+I3OuypTEtJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idyXRcnpwcOtggfle5mUVZObwxdrYZoMABVFKbGCf0LM/9gvzrchcmbhMydNS5f/h49DK2yYUAzqm5aURa1on7edS5Zb6ZRxbJ+rW7oU+WKqyKALqBxmR0fRTbpqQb/hM9bkW+BGwwAkyQvd4llM595B+paPMasdinB2cJTMtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jK1veJcf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bR8Nad7a; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jK1veJcf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bR8Nad7a"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 997591D000BD;
	Sun,  2 Aug 2026 21:07:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 02 Aug 2026 21:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785719253; x=1785805653; bh=CXrK9x2zie
	oKRpaWTcKBd22rt2nq+/J+z5uazCaQ1l8=; b=jK1veJcfz3BiHr5Z0pba8Bprg0
	+F7ertZ/5mTSjPN6c44Zisf/8mTwQGACWFNLv548VIEq59ASc7AUtNPe6c9AslTK
	7BCqqwJlJRtSLxuH1WEqeYCTp7GsO+X0CGI0nXjFJZ8RQqVjD7fkxqTegMeQXDG2
	M9UMFksAFj+KLQXukxSInhqudBa+Wa6RILj2eInr7mDXSeColoo2HQFmJK8LCUSW
	N7bhXmRIkTxPFbBUPiD0sZ4PM+JzUjTJHwlLxAGS7dtkj22K7NPI5yq3c2F9mjcy
	sdR42JTsJ+lwXeI9azRoWRl0gW6iibTKg/MCo1ET0iF92sBmXpQ0rvD4IVfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785719253; x=1785805653; bh=CXrK9x2zieoKRpaWTcKBd22rt2nq+/J+z5u
	azCaQ1l8=; b=bR8Nad7apRpWQSe1TgE4WgmGEp2O7u46aC+mFAXQWvwIPOQoM4k
	XVFDzFZ4cXYDAEbUe2NVzyVAzKL3FsYV8q7kvRDt3a9QrKkzf9IfceTR182kt4z8
	2HZcj8YgrmPiiiIy2qOthtpz9Af4CJ+hYYWd1juCyQwJ8/9S779V4Sn6gjijF0q0
	rLYIMXn5FE4Yh1pUv30d/uESgML4i+GIrKti0wj4ICm2xQhAYVwT89Wqw3WzOxDY
	C63d2gEB4Ro6h77OsB5v0dwySeI0QJKROjG9SA8o8CppjgobrR9zmROQwtOVHc7i
	R9zgEipBiJUt25KduhiophvxNFKGrt5UIeQ==
X-ME-Sender: <xms:1elvaqMdPabCdTEWu2kPe6EDzkbfXtqWK0cvwIX3rd_C97e0CfbtQg>
    <xme:1elvarMUuFvXnDL9XaMJObY85T8mVZfX_SIvQuF0x7GHJenMD6kBB7-rQvEy9a9vo
    VGKi6dhEd5fl9pHtmPEEYcvbfKmX1q1GtsnzdTc8NhLwwM0V2T50g>
X-ME-Received: <xmr:1elvajh-QaqylilH3WJygoUoZpjC_6Wb3ZrUvIj0SaTnKvCY9GnuMshCZ9tzNuygLncRkuwBfcBIwJ4wKlqa7PvGd3cYvQM4zA>
X-ME-Proxy-Cause: dmFkZTF7scmNxWA+SjVYrAOuaXSvl2K/Rx0Ml6x2g3bWdnYwt8KMacrr/O9Wd/FFAWNvUr
    jPadGR0xYZWJE/PP05a1fyC5by5cGgYKM4oHK8aRBY6XcFiQfHE758Q/oG0OOe9zBf+fUl
    VHArZESP4OX9pgjJ+9Gx4vEw43LIF4LQ93b9jZx02HK772appAzlPTCffLn0amOoy8TEzf
    G8sL2dj6fdreCxH9kJpUYSGmDiqNUjziKzET/mQG209gaP5M8V3UAS18E5eE870abXfl2M
    qYH47012sOWO60dPU8UjYyatq4VEaeFpRCiGmDosgdRxsb6GfBk6MN+H80AK0PI0FfA+NI
    x5OvIp5NVZZXljuP0wHi4xUWrTja33EjEk1dhwMdCzuCSkv0s9s3mpjNkJ+2sb4of9UOmp
    LUBbRFbG79SkL0pmHbt6LpoGj9Q6AxNlqRyLM3KGAPyDgv0+trJjDcfTl4+OigAW+pZdKw
    xVzSlynZczgAwCVT4Kgt/SF8cprJAmMCh4Ph9C0niy73RL5by7BR1iVu7k7ka1FcnHuRJy
    vhCW2OrFnyeUWcV/paUcfa1z4hJlYn1BNGV51XY5BrvT/R3ClxxnibJ8q5Laq8EWZlDbHb
    Wa38MWc/PKDnfZU/+shms4V+94f33G/l01+yE+RJOjvmCGE5364juDZ6ONjg
X-ME-Proxy: <xmx:1elvagt8mM90b8aNGhw8aoDF2qYalywT4A1yJ2-hV37NYEnJDB__Rg>
    <xmx:1elvahSHN48ZKY8jQl2c3n1hjEvWqCX3s5VvgP4zocbMxov40QzT5g>
    <xmx:1elvak3bvQ7M6h7BVx_xfnTRX7ffDMCmPrTx6u36Q4uSw-yglg3Uog>
    <xmx:1elvamvpsz6oBvuew9cPqnj7BEsf2bmHFPJPSWxlb5sbUmkp2IH1SA>
    <xmx:1elvatDRQWvB8hf06TlGek10O_s8EIOw8yrPKgFrTPQejwOpK0tAcNmT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 21:07:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Britton Leo Kerin
 <britton.kerin@gmail.com>,  Elijah Newren <newren@gmail.com>,
  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] completion: complete tracked paths for 'git diff'
In-Reply-To: <xmqqcxw010me.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	02 Aug 2026 17:58:01 -0700")
References: <xmqqcxw010me.fsf@gitster.g>
Date: Sun, 02 Aug 2026 18:07:31 -0700
Message-ID: <xmqq8q6o106k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> When completing arguments for 'git diff', _git_diff() delegates to
> __git_complete_revlist_file(), which only completes revision
> references.  This is good [*], as mixing both revs and paths in a
> single list to have the user pick is simply too confusing.
>
> If no reference matches, or if '--' is given, however, _git_diff()
> leaves COMPREPLY empty. Bash then falls back to default filename
> completion in $PWD. This fails when 'git -C <path>' is used because
> $PWD is not the target repository.
>
> Update _git_diff() to use __git_complete_index_file() when '--' is
> present, or when revision reference completion yields no matching
> candidates, so that tracked paths are offered as candidates.

This changes behavior even in the case where '-C <there>' is not
used.  The new behavior omits untracked paths from suggestions,
which is clearly better behavior.

I'll add the above paragraph to the proposed log message when I
queue this on 'seen'.
