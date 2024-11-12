Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0719E992
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406838; cv=none; b=mGzCwKQB4ze6la6j9kfGniJKLxXwHfw+s6lpUswcXZiSCc6oQgegUnVQTGl/VVNtFlqoD1YqP2xXFuiJ4pl4IRYGnYsyrUehi1KsyFTzbF2oRYqmlHS34/jY7niYGT/IhAhpSqnDUcnRAzCEXw7s2u4jsZ6h2mL299qTHw3qV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406838; c=relaxed/simple;
	bh=UlM1dGCSsOAD+OBQ541pTnkx/ox+G6N8zb4umCSIemA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZeLRwWdR3wuv/PnVfJOXN2frOANUp+rGM4oHcZJADb68DhCl2npj7AcojefAcw6aRDKuqSpRSjne66ZnZVZCmJrAfDNO8Mylx2JwAOyNlApW0S3uu0ppWbjVEyL18k2O1PWRMjMGExOkvyGK2AcipPEA2lk4HWMF5IARW1AXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MhF6aJ5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EvEYSgBO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MhF6aJ5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EvEYSgBO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1259C1380707;
	Tue, 12 Nov 2024 05:20:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 12 Nov 2024 05:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731406835;
	 x=1731493235; bh=Nc7sowS6AfVseu1fq8vpODwUY/gFLOvfdZ99EEw+NzI=; b=
	MhF6aJ5knekMlCy7eccxPAh3z/pqNU8CrviEkyjIta6pT1/QRfrOrJhqpAgq/SSX
	9ZNMhkwbOBy2bp55dXhWuX+aNQkYEzceqXtk7hAGE3U/zDzSojcQIhnxzKHz198/
	IbpKsbMLMUv6E81H4LQXXVcwGFVufBZ8k0aVahwI3HKLBNNq+m2PyILDoTU3fUKD
	AwVrZW+npVZ/WjSGJ7dLJ0vz+t5gWZTSPO5odbp6xwUmIUlp+eXsvrnIljYJA/Tz
	ude/45jRfXEjH7lOw0V+PBWdowqgZZd97CW8WZosYpd66QKlkOFCQIprPLEDDQDM
	Q1c/+Js3nxBJM/HCYiBPDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731406835; x=
	1731493235; bh=Nc7sowS6AfVseu1fq8vpODwUY/gFLOvfdZ99EEw+NzI=; b=E
	vEYSgBOTMWA4hSGWUjEG/uACnEGLezmLSqbcqpm1XpeHnF/FDPZ4t5LnW1zRj73E
	KPiggjjtGXh4cehuQPlUAMZSD+r/NizoHtD3pq5rEdC8LR6L7+Ac6VeFJFNum0jq
	J/FL9z76lmQSwCjZU6tIeNh7I/gUcL/UlAV/iPngA+R0u0tW83uJcHOwAZCCi+BN
	aeIkC8MdD9go7J6rDldk/FqdCBOZQPR9k7JSGW4jRG3/G0+/Lqz2D6WKoOYMIsK4
	BEGLWGfgtxYtcH2s8AaEkRfCkwMmLXDQaHYNxSc1gMXUSwLczLPaUsg1bBjyFsRB
	v8g3qgz2+bueVUjY2uoPw==
X-ME-Sender: <xms:8iszZ8xFI4l8dWbAIMAvY12AnVyrxyQQNA8ln03SQrjPHfxVVp2k4I0>
    <xme:8iszZwQcwJySptP3KnNi24Hc4_W2A2Hoq-YmUt0y-o69TJVgLaYChmj0y_2gOPBvy
    Oyb2P_wG5Hub6rb1Q>
X-ME-Received: <xmr:8iszZ-XdB5oHC4fnjyD512QAw-6g9h4m5LmswTksR4aAw3NkH2Di1l9JPh6Co3F2JTY9cszxMIScfmeCN61fWEF_WbAQcJeYhJq4Y_Dcvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeetgfeuve
    eujedvueejgeetleekvddvffehtdefvdegvdfgveelgeffjeffueekffenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:8iszZ6iktBCwNOR6vtAFwZPmXUKxn43Z9XCr6AFJWHoJer-BeiIPZw>
    <xmx:8iszZ-DP_B8wnkXtPn8J7E3L0dr22nNV4lrZsIxrGohqZUo7KGDfOA>
    <xmx:8iszZ7JeziRAxYQYb8ddmw12r4kuq5CkwUXUQ3z0rFSMJJJF1IUEjA>
    <xmx:8iszZ1DPpy_cA5FRgrID4HvRNPa7FdJElrXYy3BdhSm6YX_kRF86zg>
    <xmx:8yszZ151s7ZgTBwsgHpQTFZwWREuRq1DEtsFdnflGPtUhKubjcTuOV4Q>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:20:33 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v2 0/3] sequencer: comment out properly in todo list
Date: Tue, 12 Nov 2024 11:20:10 +0100
Message-ID: <cover.1731406513.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Fix three places where the comment char/string is hardcoded (#) in the
todo list.

This series does not depend on any other topics.
Topic `jc/strbuf-commented-something` was mentioned on the v1
discussion.  But it was kicked out of `seen` last week.  Also it doesn’t
compile when merged into `v2.47.0` or later:

```
strbuf.c: In function ‘strbuf_add_comment_lines’:
strbuf.c:384:24: error: ‘comment_line_str’ undeclared (first use in this function)
  384 |         add_lines(out, comment_line_str, buf, size, 1);
      |                        ^~~~~~~~~~~~~~~~
strbuf.c:384:24: note: each undeclared identifier is reported only once for each function it appears in
make: *** [Makefile:2795: strbuf.o] Error 1
```

§ Changes in v2

The first version just had patch 1 but this one fixes two other places.
The two other places where unearthered during the v1 discussion.

Rebased on `master` (b31fb630c0 (Merge https://github.com/j6t/git-gui,
2024-11-11)).

§ CI

Some failures that didn’t look relevant.

• linux-leaks
  • t0301-credential-cache
  • t9211-scalar-clone
• linux-reftable-leaks
  • ditto above

§ CC

• Stolee for the first patch
• Reviewers on the previous round

Kristoffer Haugsbakk (3):
  sequencer: comment checked-out branch properly
  sequencer: comment `--reference` subject line properly
  sequencer: comment commit messages properly

 sequencer.c                     | 26 ++++++++++++++++----------
 t/t3400-rebase.sh               | 16 ++++++++++++++++
 t/t3437-rebase-fixup-options.sh | 15 +++++++++++++++
 t/t3501-revert-cherry-pick.sh   | 12 ++++++++++++
 4 files changed, 59 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  5267b9a9c8c ! 1:  fc3b4438845 sequencer: comment checked-out branch properly
    @@ Commit message
     
         `git rebase --update-ref` does not insert commands for dependent/sub-
         branches which are checked out.[1]  Instead it leaves a comment about
    -    that fact.  The comment char is hard-coded (#).  In turn the comment
    +    that fact.  The comment char is hardcoded (#).  In turn the comment
         line gets interpreted as an invalid command when `core.commentChar`
         is in use.
     
    @@ Commit message
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • Message: “hardcoded” (more common according to `git grep`)
    +
      ## sequencer.c ##
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
      		/* If the branch is checked out, then leave a comment instead. */
-:  ----------- > 2:  710c5b1a3f6 sequencer: comment `--reference` subject line properly
-:  ----------- > 3:  86b4b485e0b sequencer: comment commit messages properly

base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
-- 
2.47.0

