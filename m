Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958041862
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063359; cv=none; b=GhKgXjtmZ48EkcLRRHc3U806pU6Nh+K5bbcJArsM00JVGJxuXDzHSxZnnf6VQ3/6f2baDfhBYdBmKW7kmv9yQsTIV5mbHRyNixMd3FRX7fxy65mBn7t0O9ZUQzFqp34qe9DjjA0N5T88Uftgv8h3PzXRcsHEss1GXa3pB01uDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063359; c=relaxed/simple;
	bh=Z8j6flvjH/XS6we1cmzJp7dUF4GE4wLR0K8keGfV7mU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBBaVO3VjUSZXGkV/HwJofSTnDPdnZVIyqHmdll+1+V5q4D4zWAFN6sSUv+yYgr0zDW/q0BP5RBIftZxVQWKkkQhiSASo9u7Zkj+kfuu7v33lLZfsBeXJmpsujGsPOxea6ffxewWYj1wB3wdz+9PpK0RPKZi/o8I/4bQIfrPGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YKh2uZHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SGfUrMgV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YKh2uZHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SGfUrMgV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1DFC114015B;
	Thu, 16 Jan 2025 16:35:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 16:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737063355; x=
	1737149755; bh=2UY6fkj5sWRf1U6OFh6L9m9at6J7h55shzTui9/qq7g=; b=Y
	Kh2uZHH3MQH9KvBNPrAneTEuBfNhPeLsoHpKmiV3lndHiGbGCJAUe3cjr+WQ+EHZ
	z+GLR75FFnqW/BLbVUUI+eMq7TElR7yb98Q+T2n/Mdsd9MTF6cVlgjV5bCjTMBDz
	QTY7KlNgeDrfp0OHcJm9XvXdKxLoT0PNnd8rSLr4txB9eH96nvAPAbScRoKjNVap
	plQwNEFQ0tTzRVbt1xgRvXThZUaal+aAXmqLLXf0AqAImtsuw5uZsxMhYuKFAWWn
	T3lWTq8W6yEEhVg6RNqLLi+qIbmy7JEHWl0LacWRR31FlrgJhYr06vBGJGzqZ2H2
	Un+WltPmow0U5v29M4tmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737063355; x=1737149755; bh=2UY6fkj5sWRf1U6OFh6L9m9at6J7
	h55shzTui9/qq7g=; b=SGfUrMgVUcyJbH0qQr78W7cS4xOC67xY8wRFS0Q3YTKt
	hZfmz+v0StrXhsvuh3tug90sq8ElATpGDxPlq3fl1y49yGzSQ8XRqapvSK5WX9Wc
	ayaoVPj5D9jJtvyENRpiXu4VztLj1+JDVgXEjYBqfjWzmOMXaTHoJEOyFvWEtHiQ
	OLCAemGc2gffn6JNprepWOh9sY4jTLLSMJUnxucLw/EYxBNvwivIWHRwahYkLCde
	FzgbVDAUB6RCUIcH8FYuWmYOrd5KcCqTImSKWtYxmhtK/obxQD4OkUwZWvelnVGv
	n8ln0NCRIgo7WTsGUk0Ja/GZLJVCQQhEmeaJQONfYg==
X-ME-Sender: <xms:u3uJZ9r0y_uA2QdpfBjDdhMPuV8xdw0x2sLwX-96m5XAfwL-PS0-8g>
    <xme:u3uJZ_o4wYD3PGCTK0uMAMVFDrk3AtAu_d3QjgGvAf_z2gyT4Q52L6iP3XZ_7KeDw
    cHB5NyJpMT2WzEm_w>
X-ME-Received: <xmr:u3uJZ6M2TrVoiqwOTUl62GEB1jhjf1uSzlKBNw98tZZ86iu8-IDojFUfx5Cs-a2Ev61VE2S9DmfElj5Qz7pJEXv25-awU0BfdpRK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefue
    evveeltdetfeegveetiefhhefhtdduhfettdetfefgffduffelgffggeehgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:u3uJZ44hi3S5Lzt4dZyxmiiOXBqKv71cPJnLTFrks_cS6oK5Ci0Yvw>
    <xmx:u3uJZ86hju5mB9GLwssliWYnrvRCnyA2jkF3qkdxzoGQTsZbUK9iTg>
    <xmx:u3uJZwiV6AaEHQArnQB8UZKkjgS9r_h7J8Aac7T-54YJxpoux7AuFw>
    <xmx:u3uJZ-416qxF-sGQKYx2HqBGQTKdD2hWVMC3UcLHoeRPpfd-JoF-pw>
    <xmx:u3uJZ8HacmgolctDJNlcSKlvuxeZlRaGgXRC8cn23l6oJO-A7yEQFkGZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 16:35:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 0/6] Send help text from "git cmd -h" to stdout
Date: Thu, 16 Jan 2025 13:35:47 -0800
Message-ID: <20250116213553.2563751-1-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-210-gaa1682cadd
In-Reply-To: <20250116012524.1557441-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
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

There is a related "what status should these command exit with?"
question, and an argument can be made to switch them to exit with 0,
instead of historical 129, but it is left outside of the series for
now.


Changes since v3:

 - The helper functions for usage_with_options() and usage() are
   renamed to show_usage_with_options_if_asked() and
   show_usage_if_asked(), respectively.

 - The call to usage() in builtin/fetch-pack.c turns out to be the
   same class as builtin/var.c that simply treats "-h" as an
   unrecognised command line option.  The fix was rewritten to
   follow the pattern taken to fix "git var -h" and moved to the
   "oddball" step.

 - The patches are reordered; the first three patches prepare the
   new helper functions and ways to test their effect, and the
   remaining patches convert the commands to use the new helper
   functions.

[Reference]

https://lore.kernel.org/git/04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de/


Jeff King (1):
  t0012: optionally check that "-h" output goes to stdout

Junio C Hamano (5):
  parse-options: add show_usage_with_options_if_asked()
  usage: add show_usage_if_asked()
  builtins: send usage_with_options() help text to standard output
  oddballs: send usage() help text to standard output
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
 builtin/fetch-pack.c        |  2 ++
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
 41 files changed, 122 insertions(+), 64 deletions(-)

-- 
2.48.1-191-gafe818080f

