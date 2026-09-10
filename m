Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B602242D67
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014841; cv=none; b=bYDQtdjStG5nDZ5Jrn06ujhuGcGAHhqkXC+OW4PncC8xLbRW+H7wV/At7yjqy3MycT+SmKlPE2ZLI4ScP8zXaH6Cdb6Du+rtUyE2nTwjfQR6/Bc0bys3ytNyPIZ4j1NZDQk4uRssKLf1D+r+4RBMKw6AvwTm6UGNOYz019wfQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014841; c=relaxed/simple;
	bh=Kj0GmmOLEPum/DzKpbfLAow1D6Hoyhtmi3QV4dxtaEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWxTG2VJR+/KthoF3ns5sRUTe6caeA71BocUBMoyRMKEV73GmgF8GVPwxx4QmkxBVHOpD6sYinccFrcYrBFnDxf7OHPG/VaS7VsOIUVDaRzPHLLH8FTC391Wm9gOu5rbddRRJJ99RCMjRrEsMOLCKWorHV8uPaYvH2nfI8ZTvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GHHcPcGx; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GHHcPcGx"
Received: (qmail 30021 invoked by uid 106); 10 Sep 2026 04:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Kj0GmmOLEPum/DzKpbfLAow1D6Hoyhtmi3QV4dxtaEE=; b=GHHcPcGx8XF6g2JS2SdZk3bZKa2CxzwiZeuRUDcBXyMnUdHg4DezqIh8gsAQPsHiVhQcWZ5gK08dU2JSTL/aZiRqgef7Nahj31zxgFlw8kArAXHOiS4fXS64GAuu0sEwPiXmGY8mgELDa5KO2wzQpsuD4TloJaN9qEpSbQtY8dV2LD3ScH6WhdsssxNsarOGd3DDOFvPqByED3TCDvUUVhvfQfSA8fZHUIsG0JhDFjyQip6TB7XvFWXcnQoldpdPAeXF1OpEISpAA/WIbyaEC9MRIPFVw8WRex+VFv187AV2FP5sF17jGCrx3iCKNIb6JucITHqdi0V4c6Roc2aqIQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 04:33:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 151019 invoked by uid 111); 10 Sep 2026 04:33:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 00:33:57 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 00:33:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, ben.knoble@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
Message-ID: <20260910043356.GB241223@coredump.intra.peff.net>
References: <xmqqik4fyaav.fsf@gitster.g>
 <20260908213840.37833-1-ub4nal@mail.ru>
 <xmqqik4fwoz5.fsf@gitster.g>
 <20260909155440.GA94069@coredump.intra.peff.net>
 <xmqqv78eqmw8.fsf@gitster.g>
 <20260909195132.GA182066@coredump.intra.peff.net>
 <xmqq8q594tvs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8q594tvs.fsf@gitster.g>

On Wed, Sep 09, 2026 at 09:23:19PM -0700, Junio C Hamano wrote:

> Surely, and I think we are pretty much on the same page.  Such a
> mechanical rewrite is not too bad.  Here is what I came up with:
> 
>     $ edit tools/coccinelle/advice.cocci
>     $ make coccicheck
>     $ git add -N tools/coccinelle/advice.cocci
>     $ git apply .build/tools/coccinelle/ALL.cocci.patch
>     $ git add -p
> 
>     Some of the hunks I simply accepted with (y), but most of them
>     needed (e)dit to make them presentable; otherwise we ended up
>     with too many overly long lines.
> 
> 
>  tools/coccinelle/advice.cocci |  7 +++++++
>  advice.c                      | 13 ++++---------
>  branch.c                      |  6 +++---
>  builtin/am.c                  |  4 ++--
>  builtin/checkout.c            |  4 ++--
>  builtin/submodule--helper.c   |  4 ++--
>  sequencer.c                   |  9 ++++-----
>  7 files changed, 24 insertions(+), 23 deletions(-)

This misses a few that have more complex conditionals like:

diff --git a/commit.c b/commit.c
index ad26f0b40a..5eedad6a2c 100644
--- a/commit.c
+++ b/commit.c
@@ -290,9 +290,9 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
-	if (!no_graft_file_deprecated_advice &&
-	    advice_enabled(ADVICE_GRAFT_FILE_DEPRECATED))
-		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
+	if (!no_graft_file_deprecated_advice)
+		advise_if_enabled(ADVICE_GRAFT_FILE_DEPRECATED,
+			_("Support for <GIT_DIR>/info/grafts is deprecated\n"
 			 "and will be removed in a future Git version.\n"
 			 "\n"
 			 "Please use \"git replace --convert-graft-file\"\n"

But I think the bigger question remains: if we did this, would people
find the extra lines giving the turn-off instructions ugly/overwhelming?
I'm not sure.

-Peff
