Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B534D3B9
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574853; cv=none; b=bQRxAI2hCXPo6mrfQw0DeoHn2Yik0PEiMn8iVZVGkWXKrIyqrEK9EyGccQUswjUPfzSTINlTYLQUK3bGS17huEQLmL971BUERZRvGxeCffRla/426I1wCKZZhTwLs4Y2+8Phd7iwMXJZNdjkO194U4dNCampwa23+UJFK8PUPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574853; c=relaxed/simple;
	bh=08knu9cwuNSDy9wzpxWFu8z3RJR/6I6YQesEzve5EZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ViAd+r+kAcnez0acG3alX57mLJgYaMlwsPFCIjEwlPuNPRLoXUmzwfVBvIG3ghfpAI4hrA1ksdyoeKevDu3G2FsXCqxDJs3rvx6KyZ/SXVzBOyiPvkT7vp+fYS5KXDLQQbJe4muusM7c8L1+FJ+p+NutwFqbTL+qeUo8bAOS2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wwMSUdcR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obMrEmI9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wwMSUdcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obMrEmI9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FCD7EC04E0;
	Wed, 16 Sep 2026 12:07:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 16 Sep 2026 12:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789574849; x=1789661249; bh=BB8HG2tTWj
	eAN7LW3wvfj6RS/2jJO/vRnbzP+WDW2rA=; b=wwMSUdcR2R6kwffwBBD+NRl58m
	OJtwMGPeKs8JATBMqRoNdCbSDkaSnp0acnd7Mbrr9c+fclQfX+4OMd0ZWkby0np4
	ddbpKWdulGh2o+hLebmaeIg9ElucTh4KnN3kZLnnsIl7ujFlVNc3WN+W/zOSzgi7
	HDzFgabpaKKNSR5ALsdwk5+Bi/ntcQBBtamD8Gyn3yWkO6jnVRXNEsmlXTjREKYx
	CPsAnqIUGzO75xR8ieTln4Teu7C2CGQKfgQZSRlu+cHxH9xfDkbe4K5/KBc0tpZx
	fZQA8SCi3jgCiZGm6T6FRVlXc/xK3yhan47357KBZ5LdIFVapaP9+NkD09tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789574849; x=1789661249; bh=BB8HG2tTWjeAN7LW3wvfj6RS/2jJO/vRnbz
	P+WDW2rA=; b=obMrEmI9uEdjVO+maxaVHt8GTo30FqNxCGmMy5kUBX+Xk5cLPYm
	DIDe+09yBx+mWnMWtRgLcEJS5/TAMD68QsDNhtYrhOyr5PpR3doRPmse/Ycp7NZi
	aW7uyTwqCqlIGsxqM1vx90fABLE/TZiMC3SPb4YVM1VWYYLo0hid+ivRFju8Za5t
	kL/bb+2AKnVKM6BIFHs6aaVYVwu82QpQwNyEdqYPzSYV3XiDsLsD8bCc3Ghqf7V1
	+5Z+bMvCED/CGfzjqo7EunVqg3fltXdSiDYcOgr2u34LPHPqRNIC193KDKVPmsiJ
	3rzwvmi3Gj5Be01IbNMcfI70eFyKWXlVf+Q==
X-ME-Sender: <xms:wb6qak_US14y4vKxoT7HDX0r3L6DxIgGxk9yvyJC6gPUzg9btLWLUw>
    <xme:wb6qajsgC-WQbA6DkNRjtHMal5IEkNs9oaZdLqyspBcq0U_EKJLfbCJC88aLSHtL4
    UFSLWabQHjDgGYz_ClN5ECpRvOK9SVNiwI3zumS0jTp6Y9qZ1tc_g>
X-ME-Received: <xmr:wb6qavDI_9Ki_TSfhZ7zVy_0I5K9q0hBIWzXtVmDxJQnZ_-qGXejEbItY0G0-YgjeSOKr9mleXm-3lxxAcIEcLHi6UXl6N8tvYrD>
X-ME-Proxy-Cause: dmFkZTGPZrnJfMNtlF4XEoo1R1fmMjm51mubMPaKCXO3lCtZgQo0R45h/RgFuvIM8j1Scs
    A/fglx1I5/Kr+zhj8DFKW8IFloa89CARmi/ytV1/6Q/j81apD2VjoTEPfirlRQgkMLByrS
    cgzYeVYnuADXHt7LwDzRx4dYyCHx6wKp3xSzInV8hC6Ja+UBI+1TR74pJf2njAlq3vf7ec
    0Q/D5OFLdopBJs6NRBLQBNcuLM6J1wfHR1OTV+0COAMCBYOcdYfF7fAOuCO3dkxljqQD2p
    Pr0mDFlsyu/u77Cl20kxBlumNIRvwnrjXw6YuxLfywUK6XmCkAEZ6TNc0FmHdrZmPjT4l4
    tVC/so1GTobA9XTfEe8OkIQG28/VTkypglZr5crW+X5mwLLiw89hVwgMO8wScB32TBLkMd
    h9khHNlPwkp91fwFZLPCiz+r8Ci/T/qyTgKcfNPIiANkj2T7AO15HTk8le+mbpxHQ/m+8f
    8rxj7zjVbUrG5mb82/Xz3pwfFexJvITSdvdkkML9QTMrtLQ+LF53RLoQYyW7miw/m1KHSo
    QpKF67iUv3A4VlqyhXPmblkAmlCJWVVM/vMVdwqD6h+PpwQr+Q8gLmxm/XbPPhxTsCljHe
    8IA2ERBd9AwfmDEws3l4Xg8vAi8CN3doMrkVh1tZO889FOu86KUx14iVAL8A
X-ME-Proxy: <xmx:wb6qajU80Ntrp1umOTahAjtSj1XjyWtKW-_uwjpW_vajyudz6F-veg>
    <xmx:wb6qalB23tFHSQbGbUNJSVcbFiPjllMAsEYX_14P8SjxmUPWexxEnw>
    <xmx:wb6qau-NWvqrILotTOrHLy1xusqGtJtD2ssCqzbL9AX-OEjgQpIElQ>
    <xmx:wb6qakE8UpYeNhKEe27UkggOUHdMyk_YuXfE9rIo-6ZLOqGvD0ORwA>
    <xmx:wb6qanBnj1n1qs0z2ZqaXxK356Zv7vocMIvvdqPEcQjoTauiMdai5xo8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 12:07:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org,  newren@gmail.com
Subject: Re: [PATCH v4 0/2] dir: fix pathspec prefixes with exclusions
In-Reply-To: <7CB757FB-1F2D-4EE6-8C31-8C2CD6D42397@ytausch.de> (Yannik
	Tausch's message of "Mon, 14 Sep 2026 09:24:45 +0200")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
	<xmqqecfbk2eb.fsf@gitster.g>
	<81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
	<886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
	<7CB757FB-1F2D-4EE6-8C31-8C2CD6D42397@ytausch.de>
Date: Wed, 16 Sep 2026 09:07:27 -0700
Message-ID: <xmqq5x05xjr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yannik Tausch <dev@ytausch.de> writes:

> Pathspec prefix optimization must account for exclude items separately.
> The prefix is derived from non-exclude items, so applying it while
> matching an exclude item can compare the wrong portions of the paths.
> Conversely, an exclude item at the start of the pathspec currently
> prevents finding a common prefix among the remaining items.
> ...
> Yannik Tausch (2):
>   dir: do not apply prefix to negative pathspecs
>   dir: preserve pathspec prefix optimization with leading excludes

Thnaks.  This round looks ready for 'next'.


