Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E524F19D082
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604597; cv=none; b=g3ez+gq0ZJ4lk+77tzC1Tt8VJ4bRPylW76UYyk0Us4uqvxcSTUYyESIFlku+ol52tSMj6yAsMo3X2WxJnF0ObYITOE6WgC0RIX07sbOAe58ZfXxGFNZlxMLbVRZtKmIMs3XbknSDwB0k+CknwEk+IQUVo7R7aYH5q1NvuxZ+CoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604597; c=relaxed/simple;
	bh=Y/4ctRgD4hyBm3n1hokRiweYHFaLRIdPIJpi0+uRAGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwKXZLTi98FaBqUIwhIC4r2WuZ6sdEv4KC9qMA8d+yELdq69NBJItnCjMunSToRnlZxtrSdrnvCyKy85EbqonwgTvDJHPrb4pS22HB0A2/M0K/uJ7mMeYGwJGaW/SSLlEqK0G/3/PypgEEcNTMYBTKB/zAkbReEwNDA8AKI8IDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gzAFw8Un; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gzAFw8Un"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604593;
	bh=Y/4ctRgD4hyBm3n1hokRiweYHFaLRIdPIJpi0+uRAGw=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=gzAFw8Un4Twl1BV4qzOZHw+ozCC/hXA+pq7X93fEnMf9KUjQEoyhIJhv5ARtZJ1mz
	 QGqpmtZ/+bEMiYQh2xv6qU+1AeM5u52B6Yb5CaK1noesCuhLJkgF8Sss/9XKcbT/SE
	 Nj0Qq8yVjDDGRUqkI4ovizkIEJGnaq/aoHP4puQ/W5U9sBlcgcUbntXDMNOXzcGUnR
	 B13AorV3IqGkpvAMEgj39uB9qScH24FOuIno0GTJJG9kCD5q1s7aMhN3bN76orTAtX
	 Rafn84s6BA6wF3I8mLc6gZjkGChkY/Yat1o2nKnp2YixmQ8Bvus7FOta8KgLjHhO3a
	 Zw2NyHdIseqJv6uwvgNe623r01NrWqxiYQI6iZddbrCmoQv+MK06vJ8fwGUWaqHxcJ
	 KtXvh/5FbpIIW0Q+pJRk6Zr9QJnT94ux94ayXnt0H+5haan3OZOKfHQq4AVbHbstjc
	 U+hsGiG/FYnd7HE7h2xdekO0JDGUe9JVbpAm2jVksB4aGkEcCkv
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E176C2008B;
	Thu, 10 Oct 2024 23:56:33 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 00/13] Update versions of libcurl and Perl
Date: Thu, 10 Oct 2024 23:56:08 +0000
Message-ID: <20241010235621.738239-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a long time, we ended up with protracted discussions on the mailing
list about what versions of software we should support.  Oftentimes, we
broke long-obsolete operating system versions by using something shipped
slightly more recently.

Fortunately, we now have a platform support policy to guide us in our
approach to dependencies, so we can make updates without worrying about
breaking systems that have not received security support in several
years.

This series updates our requirements for libcurl to 7.61.0 (the version
in RHEL 8) and for Perl to 5.26.0 (the version in 15.6).  I considered
the mainstream LTS versions of RHEL, Debian, Ubuntu, and SLES, but
omitted consideration of paid support extended LTS, since we cannot
expect Git developers to have to pay a large corporation lots of money
just to test functionality.  This is in conformance with our policy,
which states that versions must be "in line with the version used by
other long-term-support distributions", which does not include extended
LTS distributions.

The libcurl dependency changes come in incremental patches so that if we
have people on unsupported systems, they can simply revert the patches
that they'd like to omit.  It also makes the changes easier to review
than one giant commit.

The Perl changes are a huge upgrade.  5.8.1, our former supported
version, was from 2003.  5.26 has substantially improved Unicode support
(including Unicode strings), s///r (to allow returning a modified value
instead of modifying it in place), postderef syntax (which also provides
better interpolation for complex expressions), and subroutine signatures
(although these are experimental until 5.36).  These allow us much more
readable, modern Perl.

The final commit introduces a small but useful change that we can now
take advantage of with our newly updated Perl dependency as an example
of why this is a generally beneficial change.  It can be omitted without
problem if it is judged to be too noisy.

brian m. carlson (13):
  git-curl-compat: remove check for curl 7.21.5
  git-curl-compat: remove check for curl 7.25.0
  git-curl-compat: remove check for curl 7.34.0
  git-curl-compat: remove check for curl 7.39.0
  git-curl-compat: remove check for curl 7.43.0
  git-curl-compat: remove check for curl 7.44.0
  git-curl-compat: remove check for curl 7.52.0
  git-curl-compat: remove check for curl 7.53.0
  git-curl-compat: remove check for curl 7.56.0
  INSTALL: document requirement for libcurl 7.61.0
  Require Perl 5.26.0
  INSTALL: require Perl 5.26.0
  gitweb: make use of s///r

 INSTALL                                 | 13 +---
 contrib/diff-highlight/DiffHighlight.pm |  2 +-
 contrib/mw-to-git/Git/Mediawiki.pm      |  2 +-
 git-archimport.perl                     |  2 +-
 git-curl-compat.h                       | 98 -------------------------
 git-cvsexportcommit.perl                |  2 +-
 git-cvsimport.perl                      |  2 +-
 git-cvsserver.perl                      |  2 +-
 git-send-email.perl                     |  2 +-
 git-svn.perl                            |  2 +-
 gitweb/gitweb.perl                      |  6 +-
 http.c                                  | 58 ---------------
 imap-send.c                             |  4 -
 perl/Git.pm                             |  2 +-
 perl/Git/I18N.pm                        |  2 +-
 perl/Git/LoadCPAN.pm                    |  2 +-
 perl/Git/Packet.pm                      |  2 +-
 t/t0202/test.pl                         |  2 +-
 t/t5562/invoke-with-content-length.pl   |  2 +-
 t/t9700/test.pl                         |  2 +-
 t/test-terminal.perl                    |  2 +-
 21 files changed, 23 insertions(+), 188 deletions(-)

