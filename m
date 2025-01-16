Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9711CD1F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990729; cv=none; b=XdInQkwMDYDK0L5BMb7axqpFiWr8DMKwGY26/5NZ46SYQnPipvBkFvQBqOii8TwpWKCKGm6HO/ETywbsHL4oCQ+UvkaLj9+TWYdQdzk/x1cPYjrY0vhyn86Oj7BqrhQAFX/62Gx1ATZpXooIdqhYqBGbxfuoADef8OQN+iR0mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990729; c=relaxed/simple;
	bh=rAPS3FnrEeSOUfrTJK9MqZQHz+nwctVFGD6bS6HmDik=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G9eNFuzwJefrM0jtB3WK/DaiGx4sjiwI6+/UrLQNlXlcqbnZEGIq3Nfm9Ot3EeZRpQVE3jaGNs10xxlk9r0yNSP/RgF6ZdfQHHzrIYVPqes3xFR5AlN+1cioIJhjvjVZPaYl6AmfHkDzHa0r9whtet8JZsvNf5lFz9eoGBDdXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=28WN6FY0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4rhPMMI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="28WN6FY0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4rhPMMI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F249C1140168;
	Wed, 15 Jan 2025 20:25:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jan 2025 20:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1736990725; x=1737077125; bh=wvEAVbfXluU4pvnrmOtJZ
	90kkCMwQxi/a+xhfwimGkU=; b=28WN6FY0l6gX3Nqhftd2V4Hx7s+BBSK2QI5UE
	nZ4XSL3IaVh1Esky/HmmcblBdeZPpohe9LG17CWlVyvscuxubj+fpn6T5Kq2MLml
	5vj+Tr+Z8V2NvMjlsRrAsnVbucPoXtnEzPm22qz0P3m4ceQoZQweAFOJaySIgR8q
	uY75s0LeXB1sw+rLZfpBTGoN18nwpS0HFdU9N9Zs/I39cec5qM2dvS/KbDNYqR02
	hUMvL2Kl6Op72dK1yMHS0GaINzorYTuIJ/itb/kMG5jkGmog66wXKXQBHqOZdV0v
	0bQVe04RmMiovMCB7p3M9QriBnDvYOtK9b2Z0fzfUsc4vUnKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736990725; x=1737077125; bh=wvEAVbfXluU4pvnrmOtJZ90kkCMwQxi/a+x
	hfwimGkU=; b=g4rhPMMIAEqeVBfPQExqwn0i4XAmiGgdppjsPci2bwBjbuD+O4t
	ZzyMi7uSEbUCFkAKcAWzr00jfD9vfjWiPd7ZtJu3gScjbYBoKx4cf8dmObeyon1p
	qqgkiWe10IpHUeJ1DO3fGE2e/UHJsdI3Dyyy+HalJ8wWh/ubmr47s4Of34ZETNqY
	AeaqVmOXLWZ7F6FXf+AvMh5Uq9Q5NSnM86PSxx1Rzeb4OumwrpxtqyyY9sAn/EMn
	IYa47uxVNdICH3GP0fkPgY7mn81amD+7Fw6Q30CEpE7V6Q1hUwcUDH+oCZPZmrsG
	bY79H/Z8mFg+vla0NjOhPs83GvftNEldmOw==
X-ME-Sender: <xms:BWCIZ7l4FR0JXk-JPUbJPpKrDCgFAJGZxgdfC0pwvKUfaDrmfFOo9A>
    <xme:BWCIZ-24HK1PGHRv1OB8fiEYKjOAQMdG8msehE0eRQEGMV0nLrYGzHxy-oEwj41Ou
    aj2-Mx2plWF3eUkzg>
X-ME-Received: <xmr:BWCIZxoDPHvhC0K2gT5wz8qJ-hFW9OXgxjRVP5m66YPcOD3DBWW0qBiEa9WlE9ez9BmeH4fEfmmeT5M9j2ajDgBTMqyYub9pnO2d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepledugfefvd
    ejtdehtddujeekjedvieevgfehteeugfdthfdvleegtefhudegjeeknecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BWCIZzkaMhASrm4uilESS5PNe1OjmgDqIHcSvSjyjYoRD_amDDN13w>
    <xmx:BWCIZ50ktL8Fthrmoc9FeJKY-v7mq2_TVcjHf2i44Oj0Ig-pnJHD0Q>
    <xmx:BWCIZytBO-CbsE4N8QKf9AfbGmht2sermciA-amXkxP_ZwsgCr0nRQ>
    <xmx:BWCIZ9XyCIahfyn_wvqO7SG7uzOPf8XlpGzr7KEGZzEAH1y1SQzcvg>
    <xmx:BWCIZ3BIciP4AVdj0n6DiW4_IVrAsN_XEYfpLCGS3JBJJo1__xWhlQ8c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:25:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 0/6] Send help text from "git cmd -h" to stdout
Date: Wed, 15 Jan 2025 17:25:17 -0800
Message-ID: <20250116012524.1557441-1-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-191-gafe818080f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jonas Konrad noticed[*] that "git branch -h" started showing the help
text to the standard error stream.  It turns out that we are fairly
inconsistent in our implementation of "git cmd -h".  The users of
parse-options API will get "If -h is the only option on the command
line, give the help text to the standard output" for free, but some
commands manually check for the condition and then call the
usage_with_options() function, which gives the identical help text
to the standard error stream.  And "git branch -h" Jonas noticed was
one of them.

Older commands written before parse-options API became dominant show
the help text by calling the usage() function, which is meant to be
used when they fail to parse their command line arguments, which has
the same problem.  An explicit request for help text "git cmd -h"
should be fulfilled by showing the help on the standard output.

This series teachs "git $cmd -h" to send its help text to the
standard output stream consistently for built-in commands.


[Reference]

https://lore.kernel.org/git/04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de/

Jeff King (1):
  t0012: optionally check that "-h" output goes to stdout

Junio C Hamano (5):
  parse-options: add show_usage_help_and_exit_if_asked()
  builtins: send usage_with_options() help text to standard output
  usage: add show_usage_and_exit_if_asked()
  builtin: send usage() help text to standard output
  builtin: send usage() help text to standard output

 builtin/am.c                |  3 +--
 builtin/branch.c            |  4 ++--
 builtin/check-ref-format.c  |  4 ++--
 builtin/checkout--worker.c  |  6 +++---
 builtin/checkout-index.c    |  6 +++---
 builtin/commit-tree.c       |  4 ++--
 builtin/commit.c            |  8 ++++----
 builtin/credential.c        |  3 ++-
 builtin/diff-files.c        |  3 +--
 builtin/diff-index.c        |  3 +--
 builtin/diff-tree.c         |  3 +--
 builtin/fast-import.c       |  3 +--
 builtin/fetch-pack.c        |  3 +++
 builtin/fsmonitor--daemon.c |  4 ++--
 builtin/gc.c                |  4 ++--
 builtin/get-tar-commit-id.c |  4 +++-
 builtin/index-pack.c        |  3 +--
 builtin/ls-files.c          |  4 ++--
 builtin/mailsplit.c         |  4 ++--
 builtin/merge-index.c       |  7 ++++++-
 builtin/merge-ours.c        |  3 +--
 builtin/merge-recursive.c   |  6 ++++++
 builtin/merge.c             |  4 ++--
 builtin/pack-redundant.c    |  3 +--
 builtin/rebase.c            |  6 +++---
 builtin/remote-ext.c        |  2 ++
 builtin/remote-fd.c         |  1 +
 builtin/rev-list.c          |  3 +--
 builtin/rev-parse.c         |  2 ++
 builtin/unpack-file.c       |  8 ++++++--
 builtin/unpack-objects.c    |  2 ++
 builtin/update-index.c      |  4 ++--
 builtin/upload-archive.c    |  6 +++---
 builtin/var.c               |  1 +
 git-compat-util.h           |  2 ++
 parse-options.c             | 10 ++++++++++
 parse-options.h             |  4 ++++
 t/helper/test-simple-ipc.c  |  4 ++--
 t/t0012-help.sh             |  3 ++-
 t/t7600-merge.sh            |  2 +-
 usage.c                     | 28 +++++++++++++++++++++++++---
 41 files changed, 123 insertions(+), 64 deletions(-)

-- 
2.48.1-191-gafe818080f

