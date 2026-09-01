Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35547279C
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252461; cv=none; b=F7Ha5z3y9Dz5eb/iwH6oO1KM7tCRVeFCj6JMo96rwVSZ3YVbAHQeaEKLDmOtr51WuHbfk5HgRisrZkjHkQNW2iDy+Cveyd7suEZsGGbSgKlIl1a2pahBatlRK1ydeErEfWsbuyZ2O3lS568LtozCSvZYE8dDE62mt4vPwz5J/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252461; c=relaxed/simple;
	bh=fe+dZYI4fml2s4QziMgk5yxOf+fPYVyKiTMC13TVruQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx83YZAWZjU5bmwGMAUMPB8XpcHpxQFapNAn3mSWGYYhocV8IPJlGdNNJfQA+TZGGsL/tj6MgXDmPW3zIR1T/RF7jtDVSAbqG58w3bC0PCtN3D7QjUDlHh02qRCvEKAPYz/s1DPiOba0cUx0P+KsquBK/+HtbQFYe8xEG7VXAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BJsAPupG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BJsAPupG"
Received: (qmail 7438 invoked by uid 106); 1 Sep 2026 08:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fe+dZYI4fml2s4QziMgk5yxOf+fPYVyKiTMC13TVruQ=; b=BJsAPupGUhs69ZGAWq41Mn+P5VtkGCgw+I8N4TW9pbuQOSniYjppmsuzY5N6rTuMIE6yc3+/fRAeLKE8y7yiM2507fWoRydwWdU+FL3+CqvqSDLO2BlQeCeL8yEzjjgWm9Ghwya9/61S/15HxXfTH4NzW/Hj6ruXw47VnGojAJQgUosgg7HkJ0hWLv+VPsyno6iyAN9JbUf1kYmCjpPt1UidL7m+PmkbKd1h0/pGGJrqPnPpN9G0VPWuejpMYHkQD4tGBoHrIvKh6FqBJcnBwIMLYWeV+DkF0GmC+iZWwgEV1D/C335lJgcwybTXGMnEmVTwHJRuoWEDrliapGlWjw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 08:47:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34996 invoked by uid 111); 1 Sep 2026 08:47:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 04:47:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 04:47:37 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: fix missing Ruby dependency in "documentation" job
Message-ID: <20260901084737.GA2973751@coredump.intra.peff.net>
References: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>

On Tue, Sep 01, 2026 at 10:16:11AM +0200, Patrick Steinhardt wrote:

> Our "documentation" job has recently stopped working with the following
> error:
> 
>   + sudo gem install --version 1.5.8 asciidoctor
>   + gem install --version 1.5.8 asciidoctor
>   ./ci/install-dependencies.sh: 23: gem: not found

Not directly related to your patch but... asciidoctor 1.5.8, really?
That version is 8 years old. Looks like we set that version in
615a6c37e1 (ci: stick with Asciidoctor v1.5.8 for now, 2019-03-29)
due to some issues with the then-new-ish v2.0.0.

But these days I'd guess everybody is using v2.0.x (which seems to work
fine) for local builds. We probably ought to do the same in CI. If we
have to catch issues in one, I'd rather it be the one people are likely
to actually use.

It's possible that we could benefit from building with both in order to
support the older version. But given its age I doubt it's worth it. We
can still take bug fixes if somebody finds a problem, but we don't
necessarily need to spend cycles building every commit with 1.5.8.

-Peff
