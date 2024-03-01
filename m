Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707E8464
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276289; cv=none; b=QQoB4paCiz8fi05OOQ92acq59QuCGtgac4rGG+5HJBXp7Qr1Am7etPTs+5/TV93x4belV3JKON59jdaALYQePii9n2YGthiUSujLQikka/NeCzeeqNxIomaqZP20UzJkT1QdIqerv3tkO5IYW9gTzTd4cZF6Na7y/D2DkG+Q0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276289; c=relaxed/simple;
	bh=0IbJJIWAHQ7DSvjEoztA87vq5xYhWvFHNomFdrOUEjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp3w6XxcNl+g2S3eVTeKvf6bFycpkKB3kFU7cl+YVsnaHYIvaxJpKtx3PStWUTidd+KGcHl2HO34zDj1onEyVUW9U5l8cbVis5E0XVfVj80+KMgVBGMmlz+HYsYJGZTomNUGWu9wBBcAQjiJbIiFxZfFxv0J01UxcNIRS3nDabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2001 invoked by uid 109); 1 Mar 2024 06:58:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Mar 2024 06:58:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9736 invoked by uid 111); 1 Mar 2024 06:58:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Mar 2024 01:58:09 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 1 Mar 2024 01:58:05 -0500
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Dirk Gouders <dirk@gouders.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 03/11] commit-reach(repo_in_merge_bases_many): report
 missing commits
Message-ID: <20240301065805.GB2680308@coredump.intra.peff.net>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
 <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
 <1938b317a49f4d688bfefd7e5a74ad750a55a91a.1709113458.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1938b317a49f4d688bfefd7e5a74ad750a55a91a.1709113458.git.gitgitgadget@gmail.com>

On Wed, Feb 28, 2024 at 09:44:09AM +0000, Johannes Schindelin via GitGitGadget wrote:

> @@ -1402,6 +1436,8 @@ static int merge_mode_and_contents(struct merge_options *opt,
>  							&o->oid,
>  							&a->oid,
>  							&b->oid);
> +			if (result->clean < 0)
> +				return -1;

Sorry, I accidentally commented on v2 of your series a moment ago,
rather than the most recent version. But this hunk was untouched between
the two, so the comment still applies:

  https://lore.kernel.org/git/20240301065647.GA2680308@coredump.intra.peff.net/

-Peff
