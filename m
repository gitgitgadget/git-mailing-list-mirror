Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84D37701A
	for <git@vger.kernel.org>; Tue, 19 May 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218384; cv=none; b=uhUjjR1op0lsgJX+FbR5u+OPwSiWv06VeIVCBTjYTbq4xlxW7sxDEFRJSl3EZjW7jbDPJOeu4qjvwd/InRllHMDQe0ghxUhpfU5mlOzchbjvEQ5s7rToV/5vhU9/xn6t+rYkCKg0EUtVmBhM4gedqUtWhRaogHM+/NT08DfdboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218384; c=relaxed/simple;
	bh=5aO+VJC6QALmc4x/47ZgIdjfG5F30dX/v4Ew3TCdWjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWY2bjY17Opy8tn2dhSgmc/L49/DsU5ZImIzLzkYEiKn+nWw110NbE+XGgo90hxXvFtYM2AVS+bPmnLKM7+LJigPhqv0SHsT1XWZwBU6Ftf9dLJz1FwYM0KJ8LApVsr75WLCARRmoxu0qsKdjvepzGWTxVEO2Mcre3NHgNTSv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=avk5hFal; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="avk5hFal"
Received: (qmail 23218 invoked by uid 106); 19 May 2026 19:19:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5aO+VJC6QALmc4x/47ZgIdjfG5F30dX/v4Ew3TCdWjM=; b=avk5hFaluXAWupUrJPwgzIjJcQ3X77sK7v+gGnNuIZVU4rDm7B7/53CfSHd1cBO5cWyUH3d5SxFSf1jGiNI7GVu+n8QKe6BEIhVx1bwoi02j73G/vk1kSuy2IQK8PBh41NGPqsvhMz44W6G2BPTkZ3IRLdHGBBTA2JbaHcL7HL1jd+QfyHO7/g8mbCsGwlBLLrDcCtUyI/r/Py5Sib7r5ddt4Od8laV6SynTFF7x3jF3rChB5nB2rXCBNNq5dFYGb2ffFHoMeRT09nqNZ+Ee4f3KT+l+KFnvMCyZlzYPC9xCp6zZ4yVGwRwTMvg1pzIAq7K9E8AIs8b5h9oZ+DD+Qg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 19:19:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 55140 invoked by uid 111); 19 May 2026 19:19:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 May 2026 15:19:43 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 May 2026 15:19:41 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #04)
Message-ID: <20260519191941.GB2269222@coredump.intra.peff.net>
References: <xmqqv7clbizy.fsf@gitster.g>
 <agyPJa3E2lPI9K/G@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agyPJa3E2lPI9K/G@nand.local>

On Tue, May 19, 2026 at 12:26:13PM -0400, Taylor Blau wrote:

> > * tb/incremental-midx-part-3.3 (2026-04-29) 16 commits
> [...]
> Apologies, I didn't realize you were waiting on these until seeing this
> WC report. I sent an extremely tiny reroll
> 
>     https://lore.kernel.org/git/cover.1779206239.git.me@ttaylorr.com/
> 
> that addresses the two outstanding comments you linked. They are very
> minor changes, and queueing either version of the series would be
> equally fine IMHO.

I peeked at the v4 range diff, and it looks good to me.

-Peff
