Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1676404BF4
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591803; cv=none; b=e8EdZxY0gTvWt1CxTtADM8wZhRTdht6DI54MJZJhKmlzgNuknCw72NcwO6vkmEGUOMOyTcmL8E4g73sZrSHVdrjvPyaEt+BDGVOKnljCqkIBrh8BMFff0uQOfzDW3u9wACotIXK9eyLuO1qKDITkknkmHcrfaoXmMbhWuyATk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591803; c=relaxed/simple;
	bh=RGPUBLwzHJTVWZiasJHNkJTp3ITXBz7Rfw9JxMuq9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJoHtCVgDsE5FhPLZdymzKF4jlPsE9C5RO+WLshLtIYB0r1GiLMN+gcbQF8s30cnKCjH8wEwcYrq2dkJdF/ZjZKw8kUHQpIiphKXwYgepO5B5a9yaMzfkyRaSjAfsgXMtNqNTc2u/3UnAvA58nLzxHkaAp4i7NF1qDOj8VL8HDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNIR88NU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpxzkymX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNIR88NU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpxzkymX"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D82F7A00BA;
	Thu,  9 Jul 2026 06:10:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jul 2026 06:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783591800; x=1783678200; bh=oFoVKhASaw
	6/vdfRm8SuTEVH39HnnAnaf9NYvcm+eKI=; b=bNIR88NU5yMu8kC6QdWYaLMLCU
	11M5eAlHct9Tq+hgPVRtdHQl+XjOaONKuvkCZPZAO5RQz71eHcfHD9C0ax+nFcNS
	b+xMxlMhKSvVnAQ9ZS4ZnLgSUavWTDhJ7JENdtwA2bqJ4fKeEsJpbHAU6bjRYFGD
	+0jLMIGNzuXjazIMNfkjUS6JMLCiFIbkBps6O/ckBtiSxgUDcjsQNJ1WRyoisoYg
	zS3/Jc5Hr2XKqLAab/YRXQPKWt6rStJ6PpLCSzVy19qX9Rzh7vwqL3bZOyPN+Jil
	BNXBSQpnsm71jQsBoa+eso0E0MUYc1tKmVo6d4kqhbtR10ao/6bxnlxowB0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783591800; x=1783678200; bh=oFoVKhASaw6/vdfRm8SuTEVH39HnnAnaf9N
	Yvcm+eKI=; b=LpxzkymXWdtmE7QxBT/3rXWcGhK+YCgVwhyremkX4eArMC/Kt7O
	FVS14kyKavNeTWoAc2aCYFlgx7xueSW136RwWkmxa3Eu8UdoZw+PxB43ShR0jsWM
	NabYcOMgivZz8cSS5cq1FRkS9eFNKWaEMsbmseWj6WkH+bdETRtRf4/KZ6h6NfYR
	Faz3ec0ad5t1Xm1wk+fUsmMq/YCYq25u9gIRH0qpRkkz04FcYWJCXthu/WGeBvVa
	TRe29bIV6bf9mAS3YPvqVIv9muQNrd79lmndr5vDHD9R56IUTB7lZvSLzHrXkkhl
	SKTGsc0VW3diDEvL8pMoADkYt1laLpkW4hA==
X-ME-Sender: <xms:eHNPat1KSffXqGBVAQNVjtKeMPEDVietaODFCXl-Eth6V-S-LO6vLg>
    <xme:eHNPalmY1FJWJOBt84_SbBu3YBxoWWZee2A9j8dfPlRSbLIXWKJosFa4pmsXA5RSm
    ZHJ2pIdywE1RnIIznyGmL_MMuxO5jxmLD8cYbM5xHnSu_5Gt8R7aw>
X-ME-Received: <xmr:eHNPat-QhhrWMkn0LOMhARRYNJczGURgQaTuvXNM_-aQt1EmDbMlNU-j4n2cRfs5YJ4z-daC0CmCPdTbolWJdGg0I8socjOhGJWXLLVsyg>
X-ME-Proxy-Cause: dmFkZTELEX6IxCgZX4YMXylckjWKUdKh0LWxNWMuA47Kj52XlzznQPA5q7l+t6pZz77sDR
    igyPRT34NfK7MPAke2KCEQTBPNuUE9NZEqEs2/xq56gjIAgcVS7Mwboj+nA1qsvqe36VlT
    tbRPYEaZxt1wADp4TM8JweROE75lvdrPqIhE3UzAb5ZpcrDRoM+U+/ke4oF8Fl/CUTOjGl
    y2HxKXqixa9FXeBd3r6YLLyCMD6bnKTBmGcLhVoT5V05J1uGc74quVzWyUCxeaeueE/r0e
    D7lGE+ZTpP5kjt32orc49IEGbDwbCS3FBRgDHeKchK2cF5NgAop+V7l0rv16td2RKxWItN
    8I73G3leOSRHb6Z/ypcD+rEuPkVXnHqN9g29Rf8GpyQf8UtDbvE5NbpuG5uEEd6ihtWDON
    9AMnd50msmN3RLMn6C0pBLsuswOzZSXuKVG3gCIUMia0DUPzL+Fl/s4rEaka53x7zIrHBA
    qYszkdHHYdpFM5nZlhYIJEnqnCCgk5j9819sB/ZNlN6ha03ZVyfFZ3Q/tFj8gcv+tTDBMl
    PL1x72IxHCl2CQonzYsaUf4aj9Q0E72gHKK7R3v6SfiYoDhBfRBcQAEs6scupZDzCnOQ1n
    s5wEakkwuZeF00ZZ1Nb840HQXQWivS+oF/MNxwKNunqfaykE0lqFb2972pvQ
X-ME-Proxy: <xmx:eHNPaqpiBCUUtqC3adadggMNeEj3CWnwUrPJoFMQZ0G7PaKnx8VOjA>
    <xmx:eHNPamkGdGqLW8ZrO7Ss05ikXlmcKla9xeRls4iEGShChy5AkBYM5Q>
    <xmx:eHNPahhSZn8C4kB33PNGWGBX1ZLNMdTL1o0sD7yPsXZEiVaTbY8X-A>
    <xmx:eHNPaufeNfP5mRIa3v0WsQZu3uOkXzrfP1EvVpUKoX3y1fNDPAABzw>
    <xmx:eHNPaqqqSw1Ff0EyjUlz1mWOHb_qmGBp9Teq-nDd-ndfqG9pdXj6EnCb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 06:09:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4abc1937 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 10:09:58 +0000 (UTC)
Date: Thu, 9 Jul 2026 12:09:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 0/3] includeIf: add "worktree" condition for matching
 working tree path
Message-ID: <ak9zcggAmy205Fz8@pks.im>
References: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>

On Thu, Jul 09, 2026 at 10:41:40AM +0800, Chen Linxuan via B4 Relay wrote:
> Changes in v7:
> - Preserve the symlinked spelling of the worktree path and match
>   includeIf "worktree:" against it, so the condition now matches both
>   the symlinked and the real path, consistent with "gitdir:"
>   (Patrick Steinhardt, v6 review).
> - Split the work into a preparatory commit that stores a non-realpath
>   worktree path and a follow-up that wires it into includeIf.
> - Extend symlink test coverage to subdirectories and linked worktrees.
> - Link to v6: https://lore.kernel.org/r/20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn

One note: it would be nice if you could send newer versions of your
patch series in reply to the old version. I see you're using the b4
relay, so this should be configurable via `b4.send-same-thread`.

Thanks!

Patrick
