Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354F5223
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740275714; cv=none; b=NAXQ+CGamApfZ/tpeU3fwb9/gorU/foxPiptyMZw4Sb5EhnddqSoGxaPcCGEr6aPNJVjxuRGGZB0b/SKGiWMNqiZ75D1g6VQyiEf62VN72SMYXsjRVUwigQMhrY/eAPKo5hBOk5clvI55EFSrjP/ysGbOaVU+st16WlLXspovXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740275714; c=relaxed/simple;
	bh=D+iTOhrIPCThdQdcSXXuIdZVGae8zvd0+UUQdJdDbkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD2pHp6loAEdgSrkLjdps94HcQr8l+niR6VCjeSEl7Rmz/gQOP6N3hMTM8+OG7PI6E4T786s4sxWQqZc9lIuKFWpARdHSsOwjXiL7NaZ+BoUE/J/veH+cceUITEFmi3vrNq8knDkzPUlWXUnHw3xIv5Bql/rAQ37bVV6y4ti13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wY8GeLlJ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wY8GeLlJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1740275704;
	bh=D+iTOhrIPCThdQdcSXXuIdZVGae8zvd0+UUQdJdDbkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=wY8GeLlJqh9qWlAbQNY7mRzaOlRFq1UkwJCcdzwcoukQlNLLfHLWbHJq7H3SQxZUU
	 a9q9caeP75rGxXIoFmh4L+1j5WZRIl19xNoXG53vySek/bVvlHVLoyzbmrMTJnVZN1
	 qRPixJW0EaSY4uIDgyylWlJPTo6uqmOr8XRJB1MX2dXQcht9jRdIbfSB4FWHYz+DRl
	 99YTGiGuMLEpGkdCwgrpsF/7SW55H9k7pY6wP+MJ5OuPEcFyloNDmYF3GQ+TdjnYiF
	 roawgo0jywzqN1QD3JR7yX2RpCt2uU3gs/HlkOf10LmSDGaOhdVXW/Dl3Mb6rTxUxL
	 r/LfIm++FxqbqRMYifqUjPHLM+SKXh85Cv6W6JVkPdUcS1u8XMBdQP5kBWPC63eer6
	 O0XWbJP5x6Txm0eaXrDXePn0AmfSwYr8yEm0tDoT+yGhBaXPfYd2qsbhwCPhMeTk7X
	 aTtxrhzcNQCrjm7Gegt+Zms6tJ+bN90SYpjecbwkhWynAMhJzcz
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9DE3E20005;
	Sun, 23 Feb 2025 01:55:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/1] Fix netrc usage with WebDAV-based HTTP protocol
Date: Sun, 23 Feb 2025 01:53:30 +0000
Message-ID: <20250223015331.588161-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.48.0.rc1.219.gb6b6757d772
In-Reply-To: <Z7UPYY24uk7lLzeP@tapette.crustytoothpaste.net>
References: <Z7UPYY24uk7lLzeP@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a long time, we've enabled the automatic usage of netrc if the user
doesn't provide any credentials.  Unfortunately, in 2.46, this broke for
the WebDAV-based HTTP protocol, which this series fixes.

In looking at this issue, I discovered that we have (before this series)
zero tests for the netrc functionality and zero documentation for it,
which obviously is suboptimal.  In this series, I am adding one test,
which is for this particular bug.

However, I think we need to either decide that we're going to support
this as a fully-fledged feature and add documentation and sufficient
tests, or remove it, since it's not reasonable to have undocumented,
untested features that people rely on.  Our HTTP code is quite subtle
and complex and we can't expect future developers not to break things in
this state[0].  I will note, as an argument in favour of removal, that
we have git-credential-netrc helper in contrib that users can enable if
they want to retain this functionality, and we could even ship it by
default without much difficulty.  For those reasons, I am not planning
to add more tests and documentation here, but of course I welcome
interested parties to do so.

[0] Personally, I had some vague knowledge this feature existed and I
feel like I'm reasonably familiar with the HTTP code, and I still
accidentally introduced a bug, so that doesn't bode well for
contributors who are less familiar with it.

brian m. carlson (1):
  http: allow using netrc for WebDAV-based HTTP protocol

 http.c                      |  3 +--
 t/t5540-http-push-webdav.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

