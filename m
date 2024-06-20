Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15B158DCE
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897125; cv=none; b=WNYynvzGCk3w4do3acqIPCzZ51B0WZ2UzHOMAStWQaAqWvxbR2u5m6HBG6E+z0cT5ooPEM4oi3Z/jeqm5aygfY9theYKum5iquvacZLektq2bUgYzta9kfLQ73wnsfrxWQnUG8ELdB2MhPnKx3nsfRtDwRhguyi0RjMbQhwSqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897125; c=relaxed/simple;
	bh=yndrg9heX44ZYWet3ZGSnz3hlehqIopyOcAl7bGmGQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEQwo8k1YQrt/bRlLxQ2Hv0/xKayO9/OWdxRthXVimnsxXSEysjs3BVxr7eY7LVx11xaL2WVS8zdQ9kfga+fuq5moiSrPcFQAsa2GQlvLx+I+mj2jD6ics3CnxBcjXa4Ptuk3xAr8GAp1comEPow89Vl5Ei7pi07r5eek4xLwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17694 invoked by uid 109); 20 Jun 2024 15:25:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Jun 2024 15:25:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31799 invoked by uid 111); 20 Jun 2024 15:25:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Jun 2024 11:25:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Jun 2024 11:25:21 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Christian Couder <christian.couder@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
Message-ID: <20240620152521.GB1555496@coredump.intra.peff.net>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
 <20240619134533.GA943023@coredump.intra.peff.net>
 <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
 <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
 <20240619145042.GA957055@coredump.intra.peff.net>
 <ZnNftSO13KlmFbQ3@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnNftSO13KlmFbQ3@tapette.crustytoothpaste.net>

On Wed, Jun 19, 2024 at 10:46:13PM +0000, brian m. carlson wrote:

> We'll want to honour people's decisions to remain a mystery or to work
> around broken server implementations, or just to make it harder to track
> or fingerprint them.

Yep, I agree with everything you said, especially this part.

> I also think the documentation should state that for the user-agent and
> os-version fields that they are merely informative, can be changed, and
> MUST NOT be used for access control.  That doesn't mean people will
> honour it, but it does mean that we can and should feel free to break
> implementations that don't comply.

I think Christian's proposed documentation did have something along
these lines.

I do kind of wonder if we even need a separate "os-version" field, and
if it couldn't simply be plugged into the user-agent string (making it
"git/1.2.3 Linux x86_64" or something). But maybe that introduces more
hassles with respect to configuring/overriding the two parts separately.

-Peff
