Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2677267738
	for <git@vger.kernel.org>; Thu,  1 May 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140405; cv=none; b=S5xZw3jOMY2W83y7aPUo0EZofWiwhGUCt+RIZhaT0NM2tLxeq8PB6AEvzSzxZFVaJz1PWGAQchIqJfcYoBwHpTWBR93vxNW3L/MMk0R+/bLtNnALeTOFQg98mrxSjPlXMYzXPTQQUOmw0CYup+Ze9iot+kAM/F4gUwpRnIgDPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140405; c=relaxed/simple;
	bh=VAAQtpbhG9JnYzjikIScenLmunuM1MPxBeLF52c9Isc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyL57a7gLPDP+SYGc/I6rBPy8BQrYJyhkkr7l71+/ykxNobrfq2u732e/TbY+AcS4gLGxS/MAGbWlu5b6cB4jLsUgsTxam2DchrjphQazG1/eLJaVgFiUgUychrMknmuxwCvv5B9glC5bG0564P9RE1r2MzngxPNKFigs3OM/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RsUB4oh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1y61Pey; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RsUB4oh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1y61Pey"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B9FFF1380E87;
	Thu,  1 May 2025 19:00:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 01 May 2025 19:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746140400; x=
	1746226800; bh=wzMjr+xiIbO40K1ClorsaZeyJw5SQBMEoUxx/oYAqWc=; b=R
	sUB4oh6TJK4/iZ2htOrKOL19WUJSNo3d1SCn8WedB6zlgN6kM0HfXztOObf0s9gU
	2iZEirQL8hReWoG/Cvdpe0lRlCG42ZBdj55Z8eSStsl/gOjR9FzQDN/zXgEqejHG
	mMczfSMG9tP7t0RONUQNfoS/wDSmTMXklISFsfpHm2cNKNK4QpipF2V9B9RdiuN4
	euFRBTKLfEiLM16or3yKxoDoocTJAgYZ4/oMZBpdlbCG3kyiLtBWnfcMBScKU3Tv
	VCndknbecEwEc0r/WXf0WkFa6m+001yKioftLFo7FUFjL122zS+5puPohnYTYORj
	MFXwfyBgB7Zo+Tj1WXz4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746140400; x=1746226800; bh=wzMjr+xiIbO40K1ClorsaZeyJw5S
	QBMEoUxx/oYAqWc=; b=W1y61PeyhCr7I1x6NyFpFxl0uJQdiuExqCa3IG2XJmVG
	Pbv409pA39OEZ6XfBfBY1kzNDhyMK5Fo8//gHgFu0uapkxzBm0BSDhVtEcDDqR8e
	uE5WoCWRsJ4YQA5YUFv2ihpZB5tD4D+JCbIion8g/x5JFcvGTqbGhf0S000I1hSE
	UtreKHKhf4ucbuC1kR2yLowpsIaGFRQv9BU8AdafNRdtsGb1wnWPk9Y7gSJI3x3V
	cyGSIDlXjbj8SYDxKkqbR0r3xnVFUSSb+cNM9zXcMgfOb2Mm5H0ekcfY35NHq1Wz
	oqFpHu62TmljrMXLXIlAL+Bg3YcplubgV0Q5xA+HDQ==
X-ME-Sender: <xms:8PwTaMLIeAsxQEm7Yh5-NnAmYrHQgpUID4PRzCVdy8FGDPxLxwvtkQ>
    <xme:8PwTaMLimf1CegEYNzAO3BVNjdy0TD1AyVhlGBSoDlA7xALqWedFT6Ekl0Pgn0ISD
    MJ9HJVL3xoIKrwQXg>
X-ME-Received: <xmr:8PwTaMsweHplHFJ002rZY2f7SHPwy4OlQfrwDiIkDfzmLfzQazHkzkAQwHkdZUfsiyPO0Q7KK9HujPwmxJCDc_PwHC3mLc2Zl1ir>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8PwTaJaUCmuuTN30efIGW0Q-eMC4YD82FTONUIaDFubB-Evmkneoag>
    <xmx:8PwTaDbMi185K9xAcuUCUptBBMb-zJ775YpImfNdSkCRl-qkMqgyFg>
    <xmx:8PwTaFATrd5KONpFRxsZ7hh7RqdeRiUmOD_YTr39aEa6qCHni4Fg4Q>
    <xmx:8PwTaJaqaO_2yA-CDUg63WOivOQvkslvel1ROkevurDBJ9AP79QQCA>
    <xmx:8PwTaAJsG7Pmv1Lkp-DVWT10sTdPrmY-O46IEW96rfWRdd1cFDAo0yqH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 19:00:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/2] Nominating "whatchanged" for removal
Date: Thu,  1 May 2025 15:59:56 -0700
Message-ID: <20250501225958.2947677-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501213452.370729-1-gitster@pobox.com>
References: <20250501213452.370729-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This does not go far enough to touch the "Git 3.0 removal" list in
Documentation/BreakingChanges.adoc, but is a preparatory step
necessary if we ever wanted to do so in the future.

The first step is to split out the long "we marked this for removal.
tell us at git@vger.kernel.org if you still use it, and in the
meantime we refuse to proceed without --i-still-use-this" message
out of "git pack-redundant" implementation and makes it reusable.

The second step is to use that helper to mark "git whatchanged" for
removal.

Relative to the previous iteration, the only change is necessary
adjustment of tests that use "git whatchanged".  The ones that
validate the output of "whatchanged" are updated to pass the
necessary "--i-still-use-this", and the ones that runs "whatchanged"
while testing other commands are rewritten to use "log --raw".

Junio C Hamano (2):
  you-still-use-that??: help deprecating commands for removal
  whatchanged: require --i-still-use-this

 Documentation/git-whatchanged.adoc | 10 ++++++++--
 builtin/log.c                      | 13 +++++++++++++
 builtin/pack-redundant.c           | 10 ++--------
 git-compat-util.h                  |  2 ++
 t/t4013-diff-various.sh            | 17 +++++++++++++++--
 t/t4202-log.sh                     | 14 +++++++++-----
 t/t5323-pack-redundant.sh          |  5 +++++
 t/t9300-fast-import.sh             | 12 ++++++------
 t/t9301-fast-import-notes.sh       |  2 +-
 usage.c                            | 12 ++++++++++++
 10 files changed, 73 insertions(+), 24 deletions(-)

Range-diff against v1:
1:  2e4e3906b1 = 1:  2e4e3906b1 you-still-use-that??: help deprecating commands for removal
2:  43eb8ec0a8 ! 2:  622456481b whatchanged: require --i-still-use-this
    @@ Commit message
         While at it, update the documentation page to use the new [synopsis]
         facility to mark-up the SYNOPSIS part.
     
    +    Two test scripts on fast-import run "git whatchanged" without even
    +    checking the output from it.  It might still help manual debugging
    +    so I've replaced these calls with "git log --raw", but we probably
    +    are better off removing such useless git operations that do not
    +    contribute to the tests.  Such a clean-up is left outside the scope
    +    of this patch.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/git-whatchanged.adoc ##
    @@ t/t4013-diff-various.sh: diff-tree --stat --compact-summary initial mode
      test_expect_success 'log -m matches pure log' '
      	git log master >result &&
      	process_diffs result >expected &&
    +
    + ## t/t4202-log.sh ##
    +@@ t/t4202-log.sh: for cmd in show whatchanged reflog format-patch
    + do
    + 	case "$cmd" in
    + 	format-patch) myarg="HEAD~.." ;;
    ++	whatchanged) myarg=--i-still-use-this ;;
    + 	*) myarg= ;;
    + 	esac
    + 
    +@@ t/t4202-log.sh: test_expect_success 'reflog is expected format' '
    + '
    + 
    + test_expect_success 'whatchanged is expected format' '
    ++	whatchanged="whatchanged --i-still-use-this" &&
    + 	git log --no-merges --raw >expect &&
    +-	git whatchanged >actual &&
    ++	git $whatchanged >actual &&
    + 	test_cmp expect actual
    + '
    + 
    + test_expect_success 'log.abbrevCommit configuration' '
    ++	whatchanged="whatchanged --i-still-use-this" &&
    ++
    + 	git log --abbrev-commit >expect.log.abbrev &&
    + 	git log --no-abbrev-commit >expect.log.full &&
    + 	git log --pretty=raw >expect.log.raw &&
    + 	git reflog --abbrev-commit >expect.reflog.abbrev &&
    + 	git reflog --no-abbrev-commit >expect.reflog.full &&
    +-	git whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
    +-	git whatchanged --no-abbrev-commit >expect.whatchanged.full &&
    ++	git $whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
    ++	git $whatchanged --no-abbrev-commit >expect.whatchanged.full &&
    + 
    + 	test_config log.abbrevCommit true &&
    + 
    +@@ t/t4202-log.sh: test_expect_success 'log.abbrevCommit configuration' '
    + 	git reflog --no-abbrev-commit >actual &&
    + 	test_cmp expect.reflog.full actual &&
    + 
    +-	git whatchanged >actual &&
    ++	git $whatchanged >actual &&
    + 	test_cmp expect.whatchanged.abbrev actual &&
    +-	git whatchanged --no-abbrev-commit >actual &&
    ++	git $whatchanged --no-abbrev-commit >actual &&
    + 	test_cmp expect.whatchanged.full actual
    + '
    + 
    +
    + ## t/t9300-fast-import.sh ##
    +@@ t/t9300-fast-import.sh: test_expect_success 'A: create pack from stdin' '
    + 
    + 	INPUT_END
    + 	git fast-import --export-marks=marks.out <input &&
    +-	git whatchanged main
    ++	git log --raw main
    + '
    + 
    + test_expect_success 'A: verify pack' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'A: verify marks import does not crash' '
    + 	INPUT_END
    + 
    + 	git fast-import --import-marks=marks.out <input &&
    +-	git whatchanged verify--import-marks
    ++	git log --raw verify--import-marks
    + '
    + 
    + test_expect_success 'A: verify pack' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'C: incremental import create pack from stdin' '
    + 	INPUT_END
    + 
    + 	git fast-import <input &&
    +-	git whatchanged branch
    ++	git log --raw branch
    + '
    + 
    + test_expect_success 'C: verify pack' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'D: inline data in commit' '
    + 	INPUT_END
    + 
    + 	git fast-import <input &&
    +-	git whatchanged branch
    ++	git log --raw branch
    + '
    + 
    + test_expect_success 'D: verify pack' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'H: deletall, add 1' '
    + 
    + 	INPUT_END
    + 	git fast-import <input &&
    +-	git whatchanged H
    ++	git log --raw H
    + '
    + 
    + test_expect_success 'H: verify pack' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'Q: commit notes' '
    + 	INPUT_END
    + 
    + 	git fast-import <input &&
    +-	git whatchanged notes-test
    ++	git log --raw notes-test
    + '
    + 
    + test_expect_success 'Q: verify pack' '
    +
    + ## t/t9301-fast-import-notes.sh ##
    +@@ t/t9301-fast-import-notes.sh: INPUT_END
    + test_expect_success 'set up main branch' '
    + 
    + 	git fast-import <input &&
    +-	git whatchanged main
    ++	git log --raw main
    + '
    + 
    + commit4=$(git rev-parse refs/heads/main)
-- 
2.49.0-599-gc9a5c860a0

