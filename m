Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671419D890
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656812; cv=none; b=eZi+iR7+ngvQ0WyZ8uQAUvgeQ3LuilN2L6KCVqpp/t5m/ApbFcTnJxnuQk9CF1T19icmWa94YpPZDPC9gTGvluR6JOoHowlvdd/bMIdFyulTssiPHEfEt4RccXcpUESPHTeGYn1/EXOEmiPxWBKrRIVRIin2CiXIVkt9okgIlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656812; c=relaxed/simple;
	bh=HkbAI1rApjWmdVF+4f1cYUFn1t1FNmhr2GYTQGFKXRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9QxNmvcJI/Oz9gEZzctM2X+Tyo4bzoJCqswXNIIqeVJuPVZxjFywewwrbU1agwuj7sf7/ILbp8/lNgfNVmPZ2Bb+QzYI5+quI9yKfyuPHm9TgbsCl6ItPqLK+1h48JGuTs7+XybK7cROf4gRgl+rDc0t16Blr2lvTwiHfGXfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9831 invoked by uid 109); 6 Jun 2024 06:53:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 06:53:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5916 invoked by uid 111); 6 Jun 2024 06:53:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 02:53:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 02:53:28 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] ci: fix check for Ubuntu 20.04
Message-ID: <20240606065328.GB646308@coredump.intra.peff.net>
References: <cover.1717655210.git.ps@pks.im>
 <f91004a4382c95b1b87bf3d1aafc018af2b7b92e.1717655210.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f91004a4382c95b1b87bf3d1aafc018af2b7b92e.1717655210.git.ps@pks.im>

On Thu, Jun 06, 2024 at 08:30:25AM +0200, Patrick Steinhardt wrote:

> In 5ca0c455f1 (ci: fix Python dependency on Ubuntu 24.04, 2024-05-06),
> we made the use of Python 2 conditional on whether or not the CI job
> runs Ubuntu 20.04. There was a brown-paper-bag-style bug though, where
> the condition forgot to invoke the `test` builtin. The result of it is
> that the check always fails, and thus all of our jobs run with Python 3
> by accident.
> 
> Fix this.

Yikes. This looks obviously correct. Though I guess nobody noticed or
cared that we were not using python 2? It sounds like it is a
nice-to-have to get more coverage, but the platform in question is happy
to use python 3).

-Peff
