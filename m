Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F070805
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745012137; cv=none; b=AETAWRagOMLwAiEzuTRoKn9YGZQd4Q6Tq+BQ+3gmbIvZ69Jch25qKk0NTBmehBvPyP9FRusP9Vsq6bOwJu5jKb94mfVeLzW1+9mbStvkb0cbpm2fvoQ+4OGF8mxCKuwHLoF/FjNnSkwj85lu7TeYl4DTKrk7+Ad5x0eHE4i7ROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745012137; c=relaxed/simple;
	bh=vYjAYobc10QRSn7p8GHW6IS4O0XdEWQhkDlrZN16YrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nikBPSGoUg+EF/R2+3HeI2ShseUpZsHyK3XYljVF7dDDX/wLgHLvs1bNk7xinQs/HUOW0epQggWw7zgfE/ZfiCFlEjXOZ7plaDd71J4rTRxdDtIOAOdL0S8KPL90En+EUCmW/sTta4vRLKPBrBtE1yWmpr81jIW5l5QdJ7K0dEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hgoRnIi6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hgoRnIi6"
Received: (qmail 20230 invoked by uid 109); 18 Apr 2025 21:35:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vYjAYobc10QRSn7p8GHW6IS4O0XdEWQhkDlrZN16YrY=; b=hgoRnIi6KNKl51d9mGXZQMF/1VIXudGErPYiTwcFjkcqmjPEVS3ELSG5ixJVK8E2HqXJQsd8WySynpY81A44nkIWbU8tdZKhTU6pTAFyRLgbVrK0ghWiRyfNelilNVL0ojR/J7d/VHiVFj0YO5BiUwY93ltO/yHFEJ4+lrkzIWho/BHj5bYMfp0rR2xQNPJ6Kj3Hv6i96ptLOgXbd6DZwZ3q+ugHbSoeVn8I2p0X1slwMSGOAHusDyluZJn+sw3CRMMtM17sxHC3BbnAJCcEeguqXMaSCjDl5445HIlA5+hH8Bapps+hguS+HBR/80Hq/jJFHxGaWuFNFkybmpticA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Apr 2025 21:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7796 invoked by uid 111); 18 Apr 2025 21:35:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Apr 2025 17:35:34 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Apr 2025 17:35:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Anthony Wang <anthonywang513@gmail.com>, git@vger.kernel.org
Subject: aw/t9811-modernize, was Re: What's cooking in git.git (Apr 2025,
 #04; Tue, 15)
Message-ID: <20250418213531.GA89733@coredump.intra.peff.net>
References: <xmqqbjsxkn6x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjsxkn6x.fsf@gitster.g>

On Tue, Apr 15, 2025 at 04:41:10PM -0700, Junio C Hamano wrote:

> * aw/t9811-modernize (2025-04-15) 1 commit
>  - t9811: be more precise to check importing of tags
> 
>  Test updates.
> 
>  Will merge to 'next'?
>  source: <20250412061957.81747-2-anthonywang03@icloud.com>

This commit seems to be the cause of consistent failures in t9811 in CI
for macos (and I was able to bisect locally on linux after installing
p4).

The problem is this bit from the commit message:

  Additionally, we add a negative test to verify that a possible
  uninteded tag does not show up in the imported repository.

This line from the test output shows that command failing:

  test_must_fail: command succeeded: git show-ref --verify refs/tags/TAG_F1_ONLY

And indeed, that tag is definitely there. The original test comment
says:

  # - a tag that is only on one file; this kind of tag
  #   cannot be imported (at least not easily).

So I don't know if git-p4 got smarter, or what. But we should probably
back out at least that part of the commit until we figure out what's
going on (where "we" is somebody who cares a lot more about p4 than I
do).

-Peff
