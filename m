Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC625229C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631440; cv=none; b=BGKRgJg5LTYSpLFSCRO4CBQ2rxjMHuOnJO8Nr33wNU7pbkEGuJWh4HA10Wbv9UnJ79xy+jgC5pHG12W1apjNZi06H8jlIbkGEDGoxQEpRv5SkrW8ywNhFwVg0B0BF6mVxDpl4LXLdbwQIGLsxFkFHQCrLtQuYHPU8fM7n/ENFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631440; c=relaxed/simple;
	bh=R1pc6N79K9A8wAGbvQNErcAjEDct2+U94KwrgaxVaM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Twk8dZMUGhib6aF3/wQM7v0Y04UXdeiDHkaQ2Rg6CF8Bi479fFOFQRMUmeqQLjWsz7D9LRxdjFsI4h+U7igRs9aPfOUd+WtULjdLNvgBii7+LRvLBK4kH1yQE0BYALszbsyHm5Cd5Wb3BCTAxyrP6EhiBMuTZBDb1mXEuCUxWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FJW49blF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FJW49blF"
Received: (qmail 31183 invoked by uid 109); 19 Aug 2025 19:23:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=R1pc6N79K9A8wAGbvQNErcAjEDct2+U94KwrgaxVaM0=; b=FJW49blF79EDDnSCdr/zAxXQyW+lHyFrPu3YUDrVJlFVtlABUpwUOUiDBD9ziwXroLa9nBrNCWOHqZnH6Z+j6NHuHSO7zVQ2KAw68t2VDY0hkIuIDVfDox7lDsqALJ1WkZFAfPI3lCzh6XWDzs14eTfrHuyye7c2UaUWaWNUX0rOYDrAXUqW6ZfrPNb/0Vn4s3tAJx4jILNxHZeW6nO1GpRNMpdGCRUxYSNo6sp1yCqMsTIZGlofgVw7kM+Dc655DrtG05WWbaa2qd45cbFee3ceQMrPuX9Zdmy31GhrWL/x5Ik6VHgpIrCMlg72yWd1rG79Z2tCUwnbvKNOnJruSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 19:23:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46382 invoked by uid 111); 19 Aug 2025 19:23:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 15:23:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 15:23:56 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] dangling symrefs and fetchRemoteHEAD=create
Message-ID: <20250819192356.GA1059166@coredump.intra.peff.net>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192004.GA1058857@coredump.intra.peff.net>

On Tue, Aug 19, 2025 at 03:20:04PM -0400, Jeff King wrote:

> A fix is in the final patch, along with a detailed explanation. The
> earlier patches are just cleanup of the related test script before we
> add our new test there.
> 
>   [1/4]: t5510: make confusing config cleanup more explicit
>   [2/4]: t5510: stop changing top-level working directory
>   [3/4]: t5510: prefer "git -C" to subshell for followRemoteHEAD tests
>   [4/4]: refs: do not clobber dangling symrefs

Oh, one thing I forgot to mention: this must be applied on top of
ps/reflog-migrate-fixes. Specifically the changes to check_old_oid() in
046c67325c (refs: stop unsetting REF_HAVE_OLD for log-only updates,
2025-08-06). Otherwise this logic kicks in for split-HEAD updates, which
makes no sense (if we are creating "refs/heads/foo" and HEAD happens to
point to that branch, we split off a reflog update of HEAD, but we
should not enforce any old-oid rules since we are not writing HEAD at
all).

-Peff
