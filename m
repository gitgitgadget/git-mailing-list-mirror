Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7B22A4D3
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728310; cv=none; b=g+5aSPvi+NlaaUxMgDc/VZNJl1LXsBjN9cNTJWUTJ3i/9+PJCMeZW/02NHlul800gKt9eUfQlfh9QlQ7v6pliq6PoYZndZptePQxsiTy5MRl2ctOnbfGsk5df2MbofAiLZtRDNU/SZI0hd0e+xIgA+VOl7YSfkdJs2tyfeZSH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728310; c=relaxed/simple;
	bh=Iblili9z3mxl1pWc2qkYcl0Da94nBJaIg+Z6q4nKrzs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQqBmw8CkSJ5+lPR9FteNWGH5preq/Odk5ayixNRPVE7mvRCE/uBJKjp53iBI1QAw0TjlNYLxTiLM1zJiO/aY9k7c13XTHUVcT1Q/ELjjqlZR20ZScxVLHzBvJ81o28aqlQ4+VTbX6Pn270/fRIB7JQIKvBJRpwFygVN1gQFNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cTNwcKTF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JaayzBQD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cTNwcKTF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JaayzBQD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3697E1382DCB;
	Tue, 11 Mar 2025 17:25:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 11 Mar 2025 17:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741728307; x=
	1741814707; bh=3/RR8AJxISJbEfWwBdZzorYzVpXwoI/rSk2bWpypvZU=; b=c
	TNwcKTFIM4fE7o51BjpPhiZ5RxFF9tSCSfLhgW4l8j03H/9yKaL9kCf9F5fNAclj
	MIWFHtZ+GWrwTwkqSsbNdaMRRbFOVYNubPN07RXlqo2EaF/erPbra1C6Blu955Vo
	1n5dmng3+8i3V1VkUMr9QFjc6tM+zxblF39p/hMSWregIJcb8pFQx+7hPV+7JnVa
	femkkNC8Bp8U5PwWzMxMVC56zhK66Zq0DGt1hwSQ5nQjosUkrRAkYu2aDhwAuzJw
	DZbFxlprEPJIU59wkUc2tPhTa/ch94o76awrO8ZuHKq0d+VKu8x3ZvR21Q4LVYFx
	hGdsQz8SMqT+EaDhwHsyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741728307; x=1741814707; bh=3/RR8AJxISJbEfWwBdZzorYzVpXw
	oI/rSk2bWpypvZU=; b=JaayzBQDpQy1PieqofKoTkhEdKHJ3OOz9NDhr4CQSiSr
	pEtmp25eBHuDfICt17l+FUbx5VMEhiSg+jQjr0+nr6oxt4p3tmAsL0pLDy3r2yPT
	LaDql7FwewrDSyH/pXDllEPjyFBgiV2IwyUt1yvG9phiiuHX6w8/Bld7p8Oo54Iv
	a2VD3jSjEnsCIdZyR7sQJfmsF4n3ooc7YfQAHsqP2FYbpYZGl5jsQgBua6VfdK81
	FH5ssbCFJ8DRPmbTcOixYfAz8kBOFM+MqjhLFu0x7rfopMImFbeiuKbOMJVU1WbP
	FcIlkoYWikYV2BitYKIbnLPShLZLN2XynqRNs256jQ==
X-ME-Sender: <xms:M6rQZ0zZwsFTVfCZC6MhLlWl04MT_-aTOt1rPPO_NfLEA-C9Zj1OHg>
    <xme:M6rQZ4TpNhGfPdOfvUm_6wxeODh_jK01WBv3hBR078hNFH7VTs0jBjfI5kKcZeVLQ
    8nndyoGUCaOItwyGQ>
X-ME-Received: <xmr:M6rQZ2VdPl89pHm4sOLzZbiXR30RnzQPh3ORPbz6F9MhwwrLp_w4EnUFOWYPA8sdaTBvMX1CamfT-87iovnMk33Ks2Zbz-QCdphg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M6rQZyjudYkK_G3a1o87jtIUOTAKGVHAOXO0xFuaHASwWSei4NS8bQ>
    <xmx:M6rQZ2AbUvS1RslwAiQBVBuEunZLeVLWi_9WeZa02jnvSwJ4XiLSuA>
    <xmx:M6rQZzKE9MjsXTfb2EITfZxNrMrd-LJybRKkNANL1V_hL1e_LGMfig>
    <xmx:M6rQZ9DGluvoavUCbS3oymbM0GPbI7Pok6D-zRfU01OfA7p3o9WF6A>
    <xmx:M6rQZ5M0Qc_US5r1iTEfwTZvtU29K0dPvYF1k9u3sF4zAwlyFtakunUw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:25:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/6] drop "name-rev --stdin" support
Date: Tue, 11 Mar 2025 14:24:59 -0700
Message-ID: <20250311212505.2920181-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-181-g28e223d67e
In-Reply-To: <20250310231652.3742490-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During Git 2.40 timeframe, we deprecated the "--stdin" option of the
"name-rev" command in preference to the "--annotate-stdin" option,
and removed the mention of the former from the documentation.

Let's prepare for Git 3.0 to stop supporting it.

The real motive of these patches is not really about that particular
option but make sure we have, with WITH_BREAKING_CHANGES compilation
knob, enough support to keep preparing for these changes.

The first two patches are preliminary clean-up and enhancement.
We lacked documentation on test_lazy_prereq and we did not have a
good way to signal a prerequisite that no longer should be used,
both of which are remedied.

The third patch renames the WITHOUT_BREAKING_CHANGES prerequisite
that unfortunately invites double negations easily and changes
existing users of it.

Then two patches to a test script minimally modernizes it.  

The last step introduces the real change, guarded by
WITH_BREAKING_CHANGES compilation knob.  The resulting code is more
littered with #if[n]def compared to the previous round but it should
be clear which section of the code should go away once we do Git
3.0, which is the whole point of the WITH_BREAKING_CHANGES exercise.

Junio C Hamano (6):
  t: document test_lazy_prereq
  t: extend test_lazy_prereq
  t: introduce WITH_BREAKING_CHANGES prerequisite
  t6120: avoid hiding "git" exit status
  t6120: further modernize
  name-rev: remove "--stdin" support

 Documentation/BreakingChanges.adoc |  6 ++++++
 builtin/name-rev.c                 | 10 +++++++++-
 t/README                           | 25 ++++++++++++++++++++++++-
 t/t5323-pack-redundant.sh          |  2 +-
 t/t5505-remote.sh                  |  6 +++---
 t/t5515-fetch-merge-logic.sh       |  2 +-
 t/t5516-fetch-push.sh              |  8 ++++----
 t/t6120-describe.sh                | 18 +++++++++++++-----
 t/test-lib-functions.sh            |  5 +++++
 t/test-lib.sh                      |  7 ++++++-
 10 files changed, 72 insertions(+), 17 deletions(-)

-- 
2.49.0-rc2-181-g28e223d67e

