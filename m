Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A57FBF0
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751772316; cv=none; b=Q6OdqUFmm+hWVeCiJVO6GXslftR8egtjyI5fE+ncOH9Hij/id7mN5kXLXkUOiJfi0L1oICp3wusy1dOjF/DnqH4Zru7bA0i4S8r8nag3pvIXPzZWl4WwDQF1XmbIGl4/BW5WWCjoqJ9TzJ1/HspN9QYRA2lV/4Gys7DD9cwLjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751772316; c=relaxed/simple;
	bh=Eh9sMmPAk1UwiHuhKzFb+tmaUxNbLX/IksEJMcBLq/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMgnlNtaiPae4Mf/nCcAD79rkYNluwPKw6Yr/KB7WlGtgBq1pPnwuLq3xWxt0EyZ00XM8WGPMS/7LXOA8Xv6X2S4+1Tz81d6697dinqbsJ1temgZ+bXvJM1dPBokA4Yzu2PV+6YGWo+TmpDHLSpk/XSGiqbGMR5T+8KIwVZgIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PCvRf3K7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PCvRf3K7"
Received: (qmail 26464 invoked by uid 109); 6 Jul 2025 03:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Eh9sMmPAk1UwiHuhKzFb+tmaUxNbLX/IksEJMcBLq/I=; b=PCvRf3K7EMhVeU+ZuTFdTzMWtBWuBhYg33Grtpsq0XCZn6Y64U9/5PHw7eqA5V7y22dCCq1ZB18efJGiHT/CydERhfLhdu+7iLdN4NwCPWglE61OQon/pMf/oWjL21uc2QMhhqTTZU0zxr2/pKBDKqr6aZe8qb4AsX6sHJj+PuE8doGqTLrRYMsivRJRg+LAAXCCwxACBkCvbzOPihImLE4WQymSppSKPTHeCsvfBDXoV64WTv1D5ClVQj9yeMDmxF9C/rwySwvyAzVfrxe2O8Ef9D/4S977NBs7YlbWkw+03NXUq6loRweKCIBykUkt3hGHsf3ulXJ0aRK4UEMk0g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 06 Jul 2025 03:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11461 invoked by uid 111); 6 Jul 2025 03:25:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jul 2025 23:25:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Jul 2025 23:25:12 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?Sm9zw6k=?= Miguel Armijo Fidalgo <jm.armijo.f@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: "git stash create" ignores "message" argument
Message-ID: <20250706032512.GB3041790@coredump.intra.peff.net>
References: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>

On Sun, Jul 06, 2025 at 11:28:46AM +1000, José Miguel Armijo Fidalgo wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
>     $ git stash create "example message"
>     1e9b483d1f9477de5c99a708f4aa512ba
>     $ git stash store 1e9b483d1f9477de5c99a708f4aa512ba
>     $ git stash list
> 
> What did you expect to happen? (Expected behavior)
>      stash@{0}: example message
> 
> What happened instead? (Actual behavior)
>      stash@{0}: Created via "git stash store".

Hmm. Is it "stash create" that is the problem, or "stash store"?

If I do this:

  git init
  echo foo >file
  git add file
  git commit -m foo

  echo bar >file
  commit=$(git stash create "example message")

and then look at the resulting commit:

  git cat-file commit $commit

then it has the expected commit message "On main: example message".

But when we "git stash store" it, the matching reflog message is the
generic "created via git stash store" one. And that reflog message is
what is shown by "stash list" (because it is essentially just a reflog
walk of the stash ref).

So (just guessing) the intended usage is probably:

  commit=$(git stash create "$msg")
  git stash store -m "$msg" $commit

Which is a bit awkward, but then the point of these sub-commands is for
scripted use (I did not even know we had them until seeing this thread).

So perhaps we'd want one or both of:

  1. A documentation fix to make it clear that if you want to behave the
     same as "stash push" you should feed the message to both "create"
     and "store".

  2. Possibly "stash store" could pull the default message from the
     commit, rather than using the generic one.

-Peff
