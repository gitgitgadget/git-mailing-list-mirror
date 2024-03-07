Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795D82C9C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801259; cv=none; b=eGGXPqQkVxgsn6m7jjPaaTSFF2MPKjlvAR5jcDG/x0xN2nKZbeFEx4yYsmUu0Yg9PooG3YJ300rBDqCWxIRH3HHXXTi4i30c5yipaJ3PUuFlgsA1H4zC0v+uyjlPjyaCJxlgFNytOCtSgXro1TF1fOxWGhI8CooNOatF/oIrPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801259; c=relaxed/simple;
	bh=kUhQshflR3mwysSgGVZR5FOwsW1MRBBXrTEI31Z4hko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+vmgR/dPPHA5dEyR/dYkIQlswycriLWE/LaIpMW5oOHUAEU5xNb3jjCeWos5v3uB923KUykUXzHO5ryr3R9uc21ubc3NQGy5+Ag/xKMmCknyP72M+NXl2sdwLpXNpHei4G+3FBDiE3wLAnfFxU3hJ/yhoOMIgrD7JbIvlJnBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6670 invoked by uid 109); 7 Mar 2024 08:47:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 08:47:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12315 invoked by uid 111); 7 Mar 2024 08:47:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 03:47:40 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 03:47:35 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [RFC/PATCH 0/2] some transport-helper "option object-format"
 confusion
Message-ID: <20240307084735.GA2072130@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I happened to be looking at the output of t5801 for an unrelated
problem, and I noticed our git-remote-testgit spewing a bunch of shell
errors. It turns out that its expectations do not quite match what the
transport-helper code produces.

This series brings the test and documentation in line with how the
transport-helper code behaves. But I'm not sure if we should be going
the other way (see the comments on patch 2 especially), and bringing the
transport-helper code in line with the others. Hence the RFC.

  [1/2]: t5801: fix object-format handling in git-remote-testgit
  [2/2]: doc/gitremote-helpers: match object-format option docs to code

 Documentation/gitremote-helpers.txt | 7 ++-----
 t/t5801/git-remote-testgit          | 6 ++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-Peff
