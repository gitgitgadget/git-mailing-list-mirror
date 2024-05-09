Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E416F850
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271789; cv=none; b=P+AFhpkOyCY1vKgR48lYe+S0w5pZVVRjNLOwwECHwNyBy17dFLF4MArMTC5lUh8S6ll8GdVcBOVUY+JxqRuJcs4sVhIEK057ydOxaqVy2OptkWq9yMVpAWHTHDOiSUNah+FkCqmC+CX20CRAO0vTBdtjAAvM98LtsumeCBbbLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271789; c=relaxed/simple;
	bh=9NtSK9pibcDBRGwigEziR4xgtNiUrFJ74nilcSz0yw4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIKWsf7XukXJQFICRk9FaoMcIC0rujFrrlp9sX9/nu+G0i6Rb2tT5Gis6a0zdC/34i/V6u4XimV5iNoQNkT2KOIAbvBvTTsndJXfyuMLD3t3dWRhcbbpZVXpRaRqfPnW8vzHFfs2lB0qY8xjA6gHyLsM3gsH7XdQ3jGDo1mvFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6912 invoked by uid 109); 9 May 2024 16:23:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:23:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31117 invoked by uid 111); 9 May 2024 16:23:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:23:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:23:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/3] ci: drop mention of BREW_INSTALL_PACKAGES variable
Message-ID: <20240509162305.GA1708042@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509162219.GA1707955@coredump.intra.peff.net>

The last user of this variable went away in 4a6e4b9602 (CI: remove
Travis CI support, 2021-11-23), so it's doing nothing except making it
more confusing to find out which packages _are_ installed.

Signed-off-by: Jeff King <peff@peff.net>
---
 ci/install-dependencies.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index c196e56762..2e7688ae8b 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -69,8 +69,6 @@ macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	test -z "$BREW_INSTALL_PACKAGES" ||
-	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 
 	mkdir -p "$CUSTOM_PATH"
-- 
2.45.0.414.g4009e73179

