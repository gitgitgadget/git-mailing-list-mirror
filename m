Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FEA646
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879585; cv=none; b=OiFRsmPk/lndbkRqr7/IjctWEVlipG+nvSkKt/Te/QjalQl0Km9V+YfsGA1yUCKQGG648etHdmQ5qHSFAet6DBf6AC2MeNHS6jOmZo4F6hdnkaELdHI431k0Z6Xn4Hb3+5dMeTmUYeSfs4fK6yLlER6ZeF7q9dtISQ6nxDVruEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879585; c=relaxed/simple;
	bh=U5Fc8KrtEwd2vUd9+BfmaDGd6fTcA/RKXBaom80H/zk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8AkWbLpg99onQxVCPbLSI1pPExyrLMOshaXHoXfU8G5ixVLCxKCicRUfxWdn7zz3T8ZPPFBVGRlGCWBFF70m6GkDG0T1/PbjsMg1F9i7Sic1Tw6BsSFG05BeIGewP7vi4jqTDyZJDChfcJzlAOYw6zvCGYCliMg3rjgsW9st7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23543 invoked by uid 109); 17 Aug 2024 07:26:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:26:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27547 invoked by uid 111); 17 Aug 2024 07:26:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:26:25 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:26:21 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/5] dropping some more unused parameters
Message-ID: <20240817072621.GA1535666@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

These are from my pile of -Wunused-parameter fixes. The common theme
here is that we're actually changing the code rather than just marking
parameters with UNUSED. All of them just remove the parameters with the
exception of patch 2, where we can actually make use of it (but even
that one is not an observable bugfix because all callers were just
passing in the_repository anyway).

  [1/5]: refs: drop some unused parameters from create_symref_lock()
  [2/5]: pack-bitmap: load writer config from repository parameter
  [3/5]: pack-bitmap: drop unused parameters from select_pseudo_merges()
  [4/5]: ref-filter: drop unused parameters from email_atom_option_parser()
  [5/5]: diff-lib: drop unused index argument from get_stat_data()

 diff-lib.c           | 9 +++------
 pack-bitmap-write.c  | 4 ++--
 pseudo-merge.c       | 8 ++++----
 pseudo-merge.h       | 6 +++---
 ref-filter.c         | 5 ++---
 refs/files-backend.c | 8 +++-----
 6 files changed, 17 insertions(+), 23 deletions(-)

-Peff
