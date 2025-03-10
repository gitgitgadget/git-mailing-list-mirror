Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA01CDA0B
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648618; cv=none; b=eICAVB9soDybG/3P1WhzMtIOOA2abEf0ITurwj1NyUm4t0d4qlbeAq6ftzHS8jXeDPsnP3I881GfavQwIqqFOw+GL8hpSX98mnnsKCfA6SK2WUdBvIDi62QQT+gqBrRQ4RuzmOrNiOvTcXt79nZkBx24Ql7YKWL2xGLANWNEN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648618; c=relaxed/simple;
	bh=WbKcIQ+EmdtC4naV54w6CS+Vt4JQKixbvt7BaxMBStw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YUhMoMJHXrfJ6MccB2d0bqsQxGnPXLw7u22J2hedN94kEddDOVLJw6PDxp2hI/Css4+1sW4GpmoQSQCz/nPx+e/CgVlIWJ1xA/awdEZcdhMr6i5x1MLwzNYMdUFvdJG91a/LTMgOEsgWb24PSWmb/iwZHB/WZHTElKxb30JyRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VM5NMzt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qL8pQKvu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VM5NMzt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qL8pQKvu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47E07254025A;
	Mon, 10 Mar 2025 19:16:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 10 Mar 2025 19:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1741648614; x=1741735014; bh=1f6TQsXlyyxEhuxo0cQ+9
	L/272JOgSZ4T1zXq+6ylmo=; b=VM5NMzt7wr4cYIdh5YrtILhLJ1kUo4ZRuubbM
	usmJ7Kv0HuuPlOdhwITdGust3LLzavxQLVOYtTeKy1qA9Srxdmy40l84XZFo7JMa
	mtwnmsB44dn9rKlvPE5C90FYdLXlXh5bVN5a2QlL9zr0zpQ0vAEUYW/A/vEBJypM
	XBjAk0Ot5OQSozsaCqT/jsHnZEC/TyPm1xqBdOKZfQhJwC635Db4mrAF0u3Kdzip
	K8fuLnb5jO/cWlYjhgVwE2q98jEZcw2z51Rtliw8JA6WMGNciPaA6NHADbajCytg
	eEA/+P1jyXE1ih3XogIOKT06MlcuUZnDn2KkD9lJcvDYdYU9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741648614; x=1741735014; bh=1f6TQsXlyyxEhuxo0cQ+9L/272JOgSZ4T1z
	Xq+6ylmo=; b=qL8pQKvuvtKDaero1yxtN64s4rLGMLCix1kKSIeMjLGsTgyZIzV
	+27HeG1jK0kEDcbC6N6oBtrRhTqWLhdTFdTayq6UA7Kwl1oHt3sVvWHGyCHZQvIE
	MzRbiyvwdvYG9H/yQnaErDNdDVFQEVq9Swjew9EZxu1A4JsyMI8vFUN/jSkhZ62L
	/giy+IsgWCmQ/YAUdKv50EqK1bAx1GJsqAazNxWgwtc0Ae0fV9JofQIeyfp6Ut5f
	uld/OyGDukF4Pp+0cqgpQ4HfLfmRWzb+ccvhiwZdNJExKFwVwNJwYcqIM9HOjXXH
	h9RR6eKfLpz/P3LSEiW0oNhnRVWRA5LmK8A==
X-ME-Sender: <xms:5nLPZ45Pc6c7zrNAuCmjS_A7VbvLD5KW_KU4qc8Tj-eT5RWobSRZhg>
    <xme:5nLPZ56PcKjZa3qpWnapl2DpCP4iFPkqkxI6TRq0r0aK-d5xlI8lJ5aBXfSV5IkS6
    nI1B_LvlABlNHc4sw>
X-ME-Received: <xmr:5nLPZ3dy_TkC6s91jhTz2iEXkND4M1LeY_rJIpa47ts6nKhSRZN5-reFLHNlVZcif4B_ekv81b5cfMIDa7nfbY3uyK_jEaHt4q5K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeelve
    duffeltdejgfdvueevgefgveeludehtddujeetgeffieeljeeuieethffhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5nLPZ9ISWGKIIBG3hTKi1jS-NMrrxHDnhUJ3LaBiM7KsKKhFbNTMGQ>
    <xmx:5nLPZ8JzRLKt1lD6SHQWq-jZe1qSszHC9ZtZ0ccOrCxkPmTqJXJe0g>
    <xmx:5nLPZ-wx5NoBZwWqKP0XtwbBgd9kCOcBbad5nwpIBWwTO4kt2X3jQA>
    <xmx:5nLPZwLbMFjkh54YJ5XgM7o8rub1Th2v0cKUsMOogc3Io3CncKEjaA>
    <xmx:5nLPZzV3jXRtvg37Vz6hRf5nbZBs5kyL4SLY0gmscyPjja6vUHW0cn63>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:16:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 0/4] drop "name-rev --stdin" support
Date: Mon, 10 Mar 2025 16:16:48 -0700
Message-ID: <20250310231652.3742490-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-173-g4d16673c2b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Administrivia]
    Yes, yes, I know I shouldn't be playing with shiny new toys
    during the pre-release freeze time.  But just to show others who
    may still be doing so that the first patch in this series has
    already be written to avoid duplicated and conflicting work, I
    am sending them out.  I have no intention to push the topic
    further before the final.

During Git 2.40 timeframe, we deprecated "--stdin" option of the
"name-rev" command in preference to "--annotate-stdin", and removed
the mention of it from the documentation.

Let's prepare for Git 3.0 to stop supporting it.

The real motive of these patches is not really about that option but
make sure we have, with WITH_BREAKING_CHANGES compilation knob,
enough support to keep preparing these changes.  The first patch
renames the WITHOUT_BREAKING_CHANGES prerequisite that unfortunately
invites double negations easily and changes existing users of it,
then two patches to a test script minimally modernizes it.  The last
step introduces the real change, guarded by WITH_BREAKING_CHANGES
compilation knob.

Junio C Hamano (4):
  t: introduce WITH_BREAKING_CHANGES prerequisite
  t6120: avoid hiding "git" exit status
  t6120: further modernize
  name-rev: remove "--stdin" support

 Documentation/BreakingChanges.adoc |  6 ++++++
 builtin/name-rev.c                 |  2 ++
 t/t5323-pack-redundant.sh          |  2 +-
 t/t5505-remote.sh                  |  6 +++---
 t/t5515-fetch-merge-logic.sh       |  2 +-
 t/t5516-fetch-push.sh              |  8 ++++----
 t/t6120-describe.sh                | 18 +++++++++++++-----
 t/test-lib.sh                      |  5 +++++
 8 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.49.0-rc2-173-g4d16673c2b

