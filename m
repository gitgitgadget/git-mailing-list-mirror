Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B940DB4A
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100182; cv=none; b=uWWExhdl67Z68rAT/Mzfvj7GwdKGtCaeBJLkUp9YvNQIlWi8hOiA1h/mIVQH0yOyxWd1YQcvGmclcscleuxkIk5yUZJF3f3CQOs0vPPTa9YlQukdWb5f741/7Tb3xf0rhz069TdvsjF3AzpIOtEGYQIUQJru2F1f8jdq5N9tDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100182; c=relaxed/simple;
	bh=Pr8LzS3q5LHLj/W8yQcwHbSc9y5IP8+GfpHJCwSJDJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0/h66MQhQfDkZgf/Sg9H223+Pyph5uIrkkr90xyzTY8Dee7t+PUApc2NjdDzOiXFIRmdP5zc2jwLz/FvhVOLHeyt1U+4GICYT8fawwLhR8ifb5wmngwMK7UWr4lSezkihMFiW38IB3PTUcxsfT6Avolu6MWwZ21DrD8nJwSZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b/nfY2Gd; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b/nfY2Gd"
Received: (qmail 30748 invoked by uid 106); 22 Sep 2026 18:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Pr8LzS3q5LHLj/W8yQcwHbSc9y5IP8+GfpHJCwSJDJQ=; b=b/nfY2Gdg/5yKIQ4qBKWqKZCj7MtsSdZciFxyLuqiOyVMp3gxFyhzVLt4w8kseQDs7fnDg30nyHf5gDrOwvhmGOLeatomnSITIAbHf5/uItwuGogyyMcMdbWOQaLKiqJawR93Ft55T9z1wwrNjs30rXXQj/6ZUcwJmTOUrtXpm91lcVraJ1BnEKgVgwl+7qtvP6N1obmYUmvGvl8Nksvdgirqnli3vGN8uiZvtB6gH+5yuvd3IWlaBWd09N5jKoC7y8CJ3/jVIs+gDuc9IOwm4uupaUfwIlPYKKw4P8bB5qIY5kWqh4yrmEaVtVRZPfRqcXsKBPutzuRz8FXJJZJlg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Sep 2026 18:02:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 170473 invoked by uid 111); 22 Sep 2026 18:02:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Sep 2026 14:02:52 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Sep 2026 14:02:51 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, r.norouzi@proton.me,
	git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] reflog: fix default expiry periods
Message-ID: <20260922180251.GA18803@coredump.intra.peff.net>
References: <GZicFFe4cqB928v52ERTcEFaAFtAwL0rp8VaCKSMyYzJ48XbQ9XoduiDtsou0Qp4N2CGmCS49uRbxi9dUWwlFzgzlt0PkGzR7IkqysP9tVQ=@proton.me>
 <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
 <xmqq5wzxfb79.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5wzxfb79.fsf@gitster.g>

On Tue, Sep 22, 2026 at 10:27:38AM -0700, Junio C Hamano wrote:

> Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:
> 
> > The default expiry periods for reflog entries are reversed in
> > REFLOG_EXPIRE_OPTIONS_INIT(). This causes reachable entries to
> > expire after 30 days instead of the documented 90 days.
> >
> > Restore the intended 90-day expiry for reachable entries and
> > 30-day expiry for unreachable entries.
> >
> > Add a regression test for a reachable reflog entry that is
> > 60 days old.
> 
> Does this breakage date back to the beginning of the reflog expire
> feature, or was it working perfectly fine but was broken sometime
> ago?  Do we know where the breakge happened, and why?  Those are a
> lot more relevant things to describe in the first paragraph.  Once
> the problem is described clearly enough in a simple case like this,
> the solution to the problem is so obvious that latter two paragraphs
> do not need to be said.

I had the same question. They were flipped by 8565827570
(builtin/reflog: stop storing default reflog expiry dates globally,
2025-04-08). That definitely should go in the commit message.

-Peff
