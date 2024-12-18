Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF21A2544
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523715; cv=none; b=WlwSauYUze0ZaL4OWzEo63YO7Dl7pCX1TwYY1BojfS3Exb8451d4GgP0aaJ1kQLDJKRLij6iNY9t/qnscDj3VidAC42swkoMevPdexae9BKRU2bAB4VIK1E3OnsRS/+R9AyWekVgkfqII4PaFV+Z3w71S+mO1ZrR9kdNeIxBkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523715; c=relaxed/simple;
	bh=TZTYggABNzlcxI6/nk0TgP37ITf0QFrBnKf1865zPAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfNyaHpLw0Bdvs/VFTsb0ZdRzfjEmNLhOzIMFUDq5hoAthELuPrp9AuHmD2QqIfGAcATi1lMWFS4+Hu/HCxTsgXLH+bg0F/K/LRF2B11WCmmMZWRcpaXsBYa/0nVsBqAytutdoLsekq/WvispDnwzm7rxbu1QGNwQ/nM9nZ/PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fq9ACMLU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fq9ACMLU"
Received: (qmail 6445 invoked by uid 109); 18 Dec 2024 12:08:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=TZTYggABNzlcxI6/nk0TgP37ITf0QFrBnKf1865zPAg=; b=fq9ACMLU320BjWmfR0VnScO8/jTS15tJzbuoO/nt7KHdRv2wUaT1UtJAkTBlf7cPEGMHzjW/PsxcV+yXIn5b2wcuO8x5iSUa5MNljXmM084zkeWUhfwXGnyjvMUHo5D9tAiJN4g4ST6a5BU2aUZXPPAgZdIlBCDDjKabZcS9Dimx+J+YF6Vy3Bd5P+FYiXpU51c0dQZdlsJiS+atJu+Wic7hVZbupeY6TpEaUicSAbtD8aA/l1qKXrHajkbtlALh13l/6DepUbuQaWX6ZwgUzCjdU0E/MzL/92rRYL9+XO2xvD1k22aX4pMiCFjiWbPtWxy62FL2tUdP3356eOQJLw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Dec 2024 12:08:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24932 invoked by uid 111); 18 Dec 2024 12:08:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2024 07:08:32 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Dec 2024 07:08:31 -0500
From: Jeff King <peff@peff.net>
To: Aleksander =?utf-8?Q?Korzy=C5=84ski?= <ak@akorzy.net>
Cc: git@vger.kernel.org
Subject: Re: [Bug] --simplify-by-decoration prints undecorated commit
Message-ID: <20241218120831.GA695807@coredump.intra.peff.net>
References: <CAEtHj8AXKrQfyAW9FSv6yC-8GF1AkPixMFjSye+B51pJ4fOtWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEtHj8AXKrQfyAW9FSv6yC-8GF1AkPixMFjSye+B51pJ4fOtWA@mail.gmail.com>

On Mon, Dec 16, 2024 at 04:09:07PM +0100, Aleksander Korzyński wrote:

> # Now, let's try --simplify-by-decoration on another commit
> $ git log -1 --simplify-by-decoration --oneline 1e3ef455cc
> 025a87d9db Merge branch 'master' into master
> # The above output seems incorrect, because the commit isn't decorated

Yes, but it's a merge commit. From "git help log":

  Note that extra commits can be shown to give a meaningful history.

Try:

  git log --simplify-by-decoration --oneline --graph 1e3ef455cc

and you'll see that there are commits along both parent branches, and
thus we show the merge.

There are some other options listed after that for changing which
commits are shown ("The following options affect the way the
simplification is performed"). But I don't think there is one that will
show only the decorated commits (however, I could be wrong; I've only
ever used these options to show _more_ commits, not fewer).

-Peff
