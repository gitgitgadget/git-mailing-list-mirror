Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BD47884D
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969767; cv=none; b=aWblZ/A80n5+VHdcmtTauYOfv/6aQ63fZhjmYeHnJoz9wtD8GdIwEWeZrALNgdw/vdro6ZTcmVdcQ30IibZWijrhXqo3Kcz7CVM7Red0neTaZLU9uPMuEZxH72EMFlcNkaLtkWUBv1wEEfmUVdWUW/izf+kweOjh4531O2WMVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969767; c=relaxed/simple;
	bh=Iy3CUlWI/UOL3k2Hz66DwSdji/MoCzoCg48Vs1Qcskg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/pOki+T9sWki93RPauOvpU7Uy+i+HZheyCt8Eb1j5e7EjkF6oKu4AVP35ykWqe8R0D2trJTex2U8k47nQGRlg46aSUdfeHg9sF8+34RJGtG+P0r/xIxOFAIh+lOgJltnVmcaIkhKGTzoSEJflaL+3uix1e4VMYB8xP/l8NCfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RJH9hEoM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RJH9hEoM"
Received: (qmail 68955 invoked by uid 106); 14 Oct 2026 09:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Iy3CUlWI/UOL3k2Hz66DwSdji/MoCzoCg48Vs1Qcskg=; b=RJH9hEoMQbvLvmOx6z6AIe2FdCjEgey2L2Gjx3EGp/7W+X6A77CBGNrJtSPS185pCOEfOGSFiNHyVMWXPpbEa+sA3l7HJdaVds9vl/IDhDzbwZGMcDn5HNUv0UlbKW0+y0bBzXt38ckWYUHotjCTPhaiDM0o44MqsiN4Hys6zqNa1TkM4Q5zKXvc9TScjBlzrZ35BhJMl0JEt5o261ZVqvneYoeKsGPJmwzsMq3W77NCwoOjJS6ga9ahjgbq2PCJT9icQ+WDIvFu+K+W2IcwfgGnGiBPQqsbtpkI5JQjvs/aPM5NL3v9jzTyKdOErL+Wn56iONrcnndSSFHi8G+O2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:22:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35726 invoked by uid 111); 14 Oct 2026 09:22:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:22:49 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:22:44 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/8] ci: some housekeeping and modernizations
Message-ID: <20261014092244.GG1341124@coredump.intra.peff.net>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
 <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>

On Wed, Oct 14, 2026 at 10:30:26AM +0200, Patrick Steinhardt wrote:

> this patch series is a result from the discussions in [1]. It fixes a
> couple of smaller issues in our CI and bumps jobs that use EOL Docker
> images to instead use supported ones.
> 
> Passing test runs can be found at [2] and [3] for GitLab and GitHub,
> respectively.

Sorry I missed the earlier rounds. The overall direction looks good to
me, and thanks for working on this. I did raise a few small issues that
might be worth addressing.

-Peff
