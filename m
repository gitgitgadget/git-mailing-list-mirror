Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995569D2B
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817452; cv=none; b=qGC30P0vI6/Hz2Wg4OhGu/OELi18NUoF7R6XS3oqDU3RvKGlhzlqxLhqRe2RW55BWT7Bbb7DvNr5+S9sZJHwv33oHPv08Iute0inG376GvK40e6J7C9LjPihKCH4TqDk593pHNaNqJErIpSeTQ8Nt1qqB/IrZXLQl5V+QL7y07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817452; c=relaxed/simple;
	bh=I48aN0KVmQexCJxrdSg/ZSLmGhzcKpEFPENKHoMT2Tc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nqdtUeFpwpkfse31cguFVOxmO4UI2V3QnyytUi0ztOVrDCSxHd4qpZ3ChFu1gPsgvmFQvj4QI1FzM03kv9Zv7B10MNS5vYDBGb7ioiWsr/m5iJ4c57t2GiIWKoKn2Cvhao0Ku/5IM+SRQOXBhHAgjKTMaXnQlHdW3NuVG51GfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20532 invoked by uid 109); 28 Aug 2024 03:57:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 03:57:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23037 invoked by uid 111); 28 Aug 2024 03:57:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Aug 2024 23:57:27 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Aug 2024 23:57:22 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/6] unused parameters: the final countdown
Message-ID: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

After many long sets of patches fixing and annotating existing cases,
this is the culminating series that actually turns on -Wunused-parameter
in our DEVELOPER=1 builds.

When applied on 'master', everything should compile cleanly with the new
warning. There are some new cases introduced in 'next', but I'll send
separate patches to go on those individual topics.

The first two patches fix new spots that cropped up since the last round
of fixes. Patches 3-5 address compat/ code. And then the interesting one
is patch 6.

  [1/6]: gc: mark unused config parameter in virtual functions
  [2/6]: t-reftable-readwrite: mark unused parameter in callback function
  [3/6]: compat: disable -Wunused-parameter in 3rd-party code
  [4/6]: compat: disable -Wunused-parameter in win32/headless.c
  [5/6]: compat: mark unused parameters in win32/mingw functions
  [6/6]: config.mak.dev: enable -Wunused-parameter by default

 builtin/gc.c                        | 16 ++++++++--------
 compat/mingw.c                      | 15 ++++++++-------
 compat/mingw.h                      | 18 +++++++++---------
 compat/nedmalloc/nedmalloc.c        |  2 ++
 compat/regex/regcomp.c              |  2 ++
 compat/stub/procinfo.c              |  2 +-
 compat/win32/headless.c             |  2 ++
 compat/win32/pthread.c              |  2 +-
 compat/win32/pthread.h              |  4 ++--
 compat/win32/syslog.c               |  2 +-
 compat/win32mmap.c                  |  2 +-
 compat/winansi.c                    |  2 +-
 config.mak.dev                      |  1 -
 t/unit-tests/t-reftable-readwrite.c |  2 +-
 14 files changed, 39 insertions(+), 33 deletions(-)

-Peff
