Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877532186
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593037; cv=none; b=XRrFIt+zxm50iDdS0GhG83Ul72oj8WmID63qemI4KWQrWFPglKlc4yryi0OSE7ceBMnfyYzMszvaf0m0Jc/SP0H24AvRdjI8MRTpk5JtQdiAm6Yk0kSRnc93qea4V3sEzRKZ638UmT/ldyiLke92O+rSh/x4tH982bidtfH9KG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593037; c=relaxed/simple;
	bh=y5DDNEL2WembmFEWmGnp5TNGAc2RUzdONmJEMwuIadU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlPO795HWrcet3IAG9xCo0yLzTsJUlo7/M/RgU4Z2F27aktOEVq22CHMVEwE4DdH6/E2/LIij0U7ig/EyA8rctgrktyjmI0nvwh7rTO5yi+Q6I8iLXPsbTI/lg5MeaaAF98puPy1liANQcmNPyTAwxuq6OFMkTJFc/0u8KiEpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8618 invoked by uid 109); 30 Jan 2024 05:37:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:37:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29079 invoked by uid 111); 30 Jan 2024 05:37:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:37:16 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:37:14 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: [PATCH v2 0/3] some unit-test Makefile polishing
Message-ID: <20240130053714.GA165967@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129031540.GA2433764@coredump.intra.peff.net>

On Sun, Jan 28, 2024 at 10:15:40PM -0500, Jeff King wrote:

> The patches fixes two small hiccups I found with the unit-tests. Neither
> is a show-stopper, but mostly just small quality-of-life fixes.

And here's another iteration based on the feedback from v1. It uses the
mkdir_p template mentioned by Gábor, fixes the $(X) issue mentioned by
Patrick, and adds a new patch to handle the directory in "make clean".

No range diff, as range-diff refuses to admit that the patches are
related (presumably because even though the changes are small, the
original patches were also tiny).

  [1/3]: Makefile: use mkdir_p_parent_template for UNIT_TEST_BIN
  [2/3]: Makefile: remove UNIT_TEST_BIN directory with "make clean"
  [3/3]: t/Makefile: get UNIT_TESTS list from C sources

 Makefile   | 10 ++++------
 t/Makefile |  5 ++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

-Peff
