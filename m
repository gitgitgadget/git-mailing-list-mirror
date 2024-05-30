Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC308210197
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051144; cv=none; b=HVHsYsA49jthUDbUtAy0SXSppidRL5KqqCcDQwnEbLUlYgZB+lUVLPpkmqFstWnZsj4TgAcw9Czm6ZWx96goOh9QAlSltQt1eEI0rVpQivS7WyKBu/vimWFq4cNItxeg7a8KEsevyRsmOMfkqxvM9IAaX0vfH123qsEudZ8LJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051144; c=relaxed/simple;
	bh=ogw8zwV79A7N0Xr2/MiZasrnu5RxXUdz9aVdx87TaW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPNzApvMTkzo766yMRlTL/pGaEUsfXTLU87ABJpXfAmUIjDnkwtzNAH034WZ8w1xEo6e0ci1AlrlkA3MajNBphOCi6/L2+xm8tJP+M+gZ1WILyl1vRMvCmC3vTHlKGGiYIDqsdMPh8Y7nFAGl2g30uzQmzPWXJHotDz2gUxpsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16735 invoked by uid 109); 30 May 2024 06:39:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 06:39:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27584 invoked by uid 111); 30 May 2024 06:38:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 02:38:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 02:38:57 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/5] add-ons for ps/leakfixes
Message-ID: <20240530063857.GA1942535@coredump.intra.peff.net>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>

Here are a few patches to go on top of ps/leakfixes. Patches 1 and 3 fix
functional problems noticed by Coverity, and then the others are just
cleanups I noticed while there.

  [1/5]: t-strvec: use va_end() to match va_start()
  [2/5]: t-strvec: mark variable-arg helper with LAST_ARG_MUST_BE_NULL
  [3/5]: mv: move src_dir cleanup to end of cmd_mv()
  [4/5]: mv: factor out empty src_dir removal
  [5/5]: mv: replace src_dir with a strvec

 builtin/mv.c            | 50 +++++++++++++++++++++--------------------
 t/unit-tests/t-strvec.c |  3 +++
 2 files changed, 29 insertions(+), 24 deletions(-)

-Peff
