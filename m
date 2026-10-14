Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E33AF676
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969429; cv=none; b=dUl5+783BKY5uSXpTl/CinjDxFpPF34f9fjztBhLDLnv0vARj5tbxbmUr5vD/ecfakMfPVdAGEWpYI3ZHwNPBDHkGzPj/5JiyAJvcDFVFsSpGLME82syXmEVOfeDyOA6EneH5m1cIwEErESFlkObRL2vlMj/sA711y4BLi0yhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969429; c=relaxed/simple;
	bh=NMGuO62kNq9eydYK3FJBqijn5rvPFiusLN92q7w3qI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmQgMMr8QbuJ4e9xkaV4p42lrR4shwSk9j+Q8nGdmRdm+6mQBpy8yKNBa4wTHzVY8GecoRIeXgEZmnCUM5vYLOC9bs+pOB91aI/mHFz15eHtPZvPzGVnYFGIQNn4OaYtQaogHtBfWzECZCme+Hc5Yopb29a2EIMbyVdTww62M7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Cpbl/6Qr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Cpbl/6Qr"
Received: (qmail 68886 invoked by uid 106); 14 Oct 2026 09:17:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NMGuO62kNq9eydYK3FJBqijn5rvPFiusLN92q7w3qI0=; b=Cpbl/6QrC+Nc+oyYOkkV06A+rg5P8Z7TRJ5zwb5JVwP914Lxe3RYxV4gSOxJk788cxLiP1qrDMokjkOoamdgxz7JRQcA30OZdllUfr60109A3xp5K+PhLznmNb/5UmlCEYbbxoJ47QYpsR8p5FihCCXyJYMomkroWi2vyfg9e1o1BmsBJ9K6h/Ve1kCLtyVob+GGkjod10H+xRLliv+K+SVSiGl5euT+19JvAvpuslSc8qN3XII4zPJT6/w+JeFsEkjiOQ5LYXvQol9h+DyJ9a67+dTg+CL4I0sR86rXHr8Goawc5acNuMd6t3cD7b+OprIBJv9AILqIibbrAikxlw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:17:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35658 invoked by uid 111); 14 Oct 2026 09:17:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:17:11 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:17:05 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 4/8] ci: switch away from unsupported i386/ubuntu image
Message-ID: <20261014091705.GC1341124@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-4-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-pks-ci-housekeeping-v3-4-04c24e1f480d@pks.im>

On Wed, Oct 14, 2026 at 10:30:30AM +0200, Patrick Steinhardt wrote:

> The linux32 job is used to exercise Git on a 32 bit platform. That job
> uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
> nowadays. Furthermore, Ubuntu 20.04 is the last release that has support
> for 32 bit, so we cannot upgrade the image to a later version, either.
> 
> Switch the job over to use i386/debian instead. Note that starting with
> Debian 13, support for i386 has been reduced [1]. But Debian still
> releases 32 bit Docker images for the latest release nowadays, so we
> will have coverage until at least 2030.

Makes sense. I did notice this hunk, though:

> @@ -48,10 +48,6 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>  		SVN='libsvn-perl subversion'
>  		LANGUAGES='language-pack-is'
>  		;;
> -	i386/ubuntu-*)
> -		SVN=
> -		LANGUAGES='language-pack-is'
> -		;;

I think we have some tests which use is_IS as an exotic locale, which I
assume is why we add this dependency. Do we need to do something similar
for Debian so we don't skip those gettext tests on the 32-bit job, or
does it just work on Debian?

-Peff
