Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D422D4FF
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075810; cv=none; b=Z5qCinGuNxtEHbIT5gJW3ETbQFwMjm+l/7h7l4QGeRckzX74FTsikucQCV66silSQQ8vR4L5RMkBLz6XL5YSb/ONPJmVQeb2u/iyM/c2edxRzfm22wh3hihTl79REcKzZOqVZrGdp2kmxkUpJ86jb7N2UJw8DToHwpfKMOvRuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075810; c=relaxed/simple;
	bh=fx01IMA0uLO7qYn03VyOcgfpkspFJy4zSy+yX8z6kQE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ha2OopwxVUWHUUXnF+dyUnIlonsqzyzt3C/SCwngKCEcjIrGvSVeftNY5xJMuRuyLGbPQytmULjBHGvj1wHu0JJe1ljxxBqCtPkf/MqlLmYba3BAOkK60Hs/Tb9mu1OXR+Lz7mXupg9SskDZp7PRy/glfgtrgU9rn5fU8xFXsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MdBnlKgW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MdBnlKgW"
Received: (qmail 3435 invoked by uid 109); 12 May 2025 18:50:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=fx01IMA0uLO7qYn03VyOcgfpkspFJy4zSy+yX8z6kQE=; b=MdBnlKgWtJGaiyO422YapX7/Cp8CVCXXiwpBgb5xGl9A/DU0kGs1U2wVbv1Ntsj5ExkT15CeLHFKWPzhflXwAebKXyTs1harRe4f82vXD0r7YuPOVRlATWwfiX/9zmzHn4tSffsNQ02AN9IHejDhpth6DPP8oCrWd/L//oo8vc+DMLSPCqq+RviKaUdfBtyj8rzdJpxBLt+7/Q6jvUhgdcetDH1B3Y07u3T5NrF4JajDMHiN04oI95knrLuHOhf6Hq067f74OUdAuHyEZcTTO65uk197N1GN28bOLawjlcejyKy0Bi6WEgP0fqsUtjlCUC8y0dtFP0XsPzGcPRKW/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 18:50:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10340 invoked by uid 111); 12 May 2025 18:50:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 14:50:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 14:50:06 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/3] minor oidmap cleanups
Message-ID: <20250512185006.GA1275914@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Just cleaning out old topics from my tree, and I found this one.

  [1/3]: oidmap: rename oidmap_free() to oidmap_clear()
  [2/3]: oidmap: add size function
  [3/3]: raw_object_store: drop extra pointer to replace_map

 builtin/rev-list.c      | 2 +-
 commit-graph.c          | 2 +-
 list-objects-filter.c   | 2 +-
 object-store.c          | 3 +--
 object-store.h          | 3 ++-
 oidmap.c                | 2 +-
 oidmap.h                | 9 +++++++--
 replace-object.c        | 8 +++-----
 replace-object.h        | 2 +-
 sequencer.c             | 4 ++--
 t/unit-tests/u-oidmap.c | 2 +-
 11 files changed, 21 insertions(+), 18 deletions(-)

-Peff
