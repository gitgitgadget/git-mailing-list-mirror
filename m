Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981D28B7D6
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735636; cv=none; b=rPUJkvu9WwU3zp3h5wAF3UmSuoQgwoM9othNRN/shHWolavw9oWhPd+LEv4NxM29KdG9kAcZR8Hyg0BVsAwkJ3nbpiCxbHDNem3hVWPqNfVVwpLxw3xbQfxqFE/6OkxixusozR/2eyFJLKzqetnyj9FZmmqrzb1wGunLYsb8qJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735636; c=relaxed/simple;
	bh=vGazjFmWNisVl+wCgFM8t2j/XTZ9m7kix6EMAiDHCDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6VUNVIRn7+lUT8xPh8AIKFVvRfzqMqt25jf2ifoZEijPjiGjnAPNOlY9qcODPXljcMIKleSQeXbRynm55kuQF6A/m/WC2MvtFg9tUqzZBZvSiZ2Q2Aow/ejwbb5bQISQNIFcn/plyVeX9nXF7+X6UK/f/a/rSovoteF96nENvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h9HEpkOJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h9HEpkOJ"
Received: (qmail 29296 invoked by uid 109); 8 May 2025 20:20:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vGazjFmWNisVl+wCgFM8t2j/XTZ9m7kix6EMAiDHCDY=; b=h9HEpkOJ92zGuBiVnmCOm9aBtcq6Ab1/SU6743rLwhLR1nHn9fnrCzojhOzR8rVfI+DM5B0OnD8DR7t5K5kc5IaMzAjfz2ZpLc9/vscOBgb2/dm/N3yTMzt+O1Rh2vsaAE8y09mmZ4i9pNwRztgdaLY2tQtrXDm9+TXWgk774iWEl7MsxYtpuQZy/T4KzLDzHq3ANZDGUvN+IZuCsSrEFNLoBMb4AO8lrMW5licRsKSipFp4Jut4W5F1F/LW/xzB/bdMCBRGuH5lqsDd9drMRd7IX/XpPBHk+Hk+NPJJCbJAtIZ1xaomNT3I+1B50nSN175gjHmYUxg+mTqajjkGUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 20:20:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20307 invoked by uid 111); 8 May 2025 20:20:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 16:20:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 16:20:33 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Michal =?utf-8?Q?Such=C3=A1nek'?= <msuchanek@suse.de>,
	'Akash S' <akashs@commvault.com>, git@vger.kernel.org,
	'Adithya Urugudige' <aurugudige@commvault.com>,
	'Abhishek Dalmia' <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <20250508202033.GE18229@coredump.intra.peff.net>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <aBz8U35YX7UH-PTW@kitsune.suse.cz>
 <20250508194731.GA13108@coredump.intra.peff.net>
 <029701dbc054$a6e9af00$f4bd0d00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <029701dbc054$a6e9af00$f4bd0d00$@nexbridge.com>

On Thu, May 08, 2025 at 04:06:08PM -0400, rsbecker@nexbridge.com wrote:

> As a possible alternative, would some kind of information presented via the proposed
> git blame-tree series (or call it git annotate-tree perhaps) be useful for this enhancement?
> I am not sure what the results will look like, but it might be useful and then cached by
> the backup strategy. I'm grasping at straws, though.

I don't think so. From an efficiency perspective, your best git-aware
backup really is going to be packfiles representing slices of history,
depending on each other. I.e., bundles or something approximating them.

-Peff
