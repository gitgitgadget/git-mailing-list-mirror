Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A781156F39
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084164; cv=none; b=W7Mb6qpE/ir1xSh+y5RExAT7Ncxkbx0ZOPw5ZLtRtLKDUbvkMY6BhiBDe9kALYBx3K1XrGOrlOxpWcptAPsOAKbBH4aL6XO4aFWHRw0I3f9VdPSxFHWafccNd0U88CJPHmCBa0CQED2i6tY2pMaY7TM5u5efPq4SVDrW08O5OuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084164; c=relaxed/simple;
	bh=rZmgqUc+q36iZH1S6q/C4zCrB3GMBZKRbf+GMkOFSTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo8iZoUzCz6qPmNyA4F4DCv7IOkmUu0SN+4ocKBD0PmkFF86jB2sDD+TiR17NbNvoRAKFrMNrxb0OIKBphmBIj7GFLAOUAf9c1nkDgy9cDlIVR2kQJFkaAwA9v/zIoLi0wqhKnvYZcGl4BmCXpKean2CwXzmPllSWjUR1khVb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ezY3ax+k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ezY3ax+k"
Received: (qmail 13886 invoked by uid 109); 20 Nov 2024 06:29:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rZmgqUc+q36iZH1S6q/C4zCrB3GMBZKRbf+GMkOFSTw=; b=ezY3ax+k6dp+11DHuoX1W7eg38Fkc48wU1u57f6N2s1UnDM2rTu82HR3f/tssEWkcSioWxuJF1xFpEnmOpLTobsHXQdqq+b/iunQjcPuw+v3wdh2+hegDVULPx/+zyXzxa4prF/mrWB6t5VUu1CROIUWBWq9zwFo99UFrjEu4VOiIYNs6oSGg6JrtBHgIE+xChqlOGek3BkcvWCPG6Fk/q0hY47+aH5cHgyGNJNT8FSs1AspENws70q95PZWPZbW6878YQ6a5k5+GAvrG1sfVPkqub7ciySoqrB3/afAPQ3X/IiSljovs0hNbjzteDhtdFCoSXXxS5ejfOOKwPP3Zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Nov 2024 06:29:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9276 invoked by uid 111); 20 Nov 2024 06:29:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Nov 2024 01:29:24 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Nov 2024 01:29:19 -0500
From: Jeff King <peff@peff.net>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] index-pack: teach --promisor to forbid pack name
Message-ID: <20241120062919.GA4564@coredump.intra.peff.net>
References: <20241116032352.GA1782794@coredump.intra.peff.net>
 <20241119201016.22713-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119201016.22713-1-jonathantanmy@google.com>

On Tue, Nov 19, 2024 at 12:10:15PM -0800, Jonathan Tan wrote:

> Thanks, Peff, for the catch. Here's an updated patch, with an updated
> commit message.

This looks good to me, thanks.

> Range-diff against v1:
> [...]
>     @@ Commit message
>          test here any more.)
>      
>          [1] https://lore.kernel.org/git/20241114005652.GC1140565@coredump.intra.peff.net/
>     +    [2] https://lore.kernel.org/git/20241119185345.GB15723@coredump.intra.peff.net/
>      
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          ---
>          This is on jt/repack-local-promisor.
>      
>     -    Looking into it further, I think that we also need to require no
>     -    packfile name to be given (so that we are writing the file to the
>     -    repository). Therefore, I've added that requirement both in the code and
>     -    in the documentation.
>     -
>     -    I've tried to summarize our conversation in the commit message - if you
>     -    notice anything missing or incorrect, feel free to let me know.
>     +    Thanks, Peff, for the catch. Here's an updated patch, with an updated
>     +    commit message.

Heh, I guess you stick your notes directly into the commit message. ;) I
do that sometimes, too. A long time ago I had a patch that would let you
write "---" in the commit message editor and then auto-convert that into
actual notes. Probably not that big a deal, though.

-Peff
